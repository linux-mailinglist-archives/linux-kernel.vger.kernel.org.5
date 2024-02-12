Return-Path: <linux-kernel+bounces-61062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4455850CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7C283154
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65811FBF;
	Mon, 12 Feb 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1eo/7MU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF1538D;
	Mon, 12 Feb 2024 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707703464; cv=none; b=ALzB9lCRUs8pRNunbZ7jdVT6cgfaQyvrCXb/AiFds8aCVSvIQ/wRD60SueQuUeyf14LxT0CRxPOTRbdzQSexztq4aztkC/Hy6J8D4nlXPiBNnyuQ0D+DUbSxndQlYM/91Hv4MSKmWRoKgXWaY17UqCg5FKMRK5DB6bqLY0S1/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707703464; c=relaxed/simple;
	bh=r7CpmQPE0yFIMO8wUCYayc7SU5gVp4HIycN2Kkd09iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hki7UyFRVLX+2Qx/fSm290Ywqjl3F3pTyQS/JfeswiIDenz4SZyjw90gU4Cq5U+EB8Q/ALLNHEZ4M2gUucR8nb8uVxBQSHf3D70lHBrNBg3BmUTyz2z41RVDKr/uZrcQBV2BmDasK2bklyXbxLd/xvjCCXkz5ArMb412OM1v7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1eo/7MU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8aadc624dso19772975ad.0;
        Sun, 11 Feb 2024 18:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707703463; x=1708308263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TsrxGbd+ooYSWDZTCkHy7ejEqn2Gr/9LfDCkLbwwsGE=;
        b=Y1eo/7MUw1LARDx3MpRagBiR7N07uv3abqjqzhNu0u5XHV8/6y+ZjzLAInXAZBdXlR
         0nRJO9OkNb1w+yr8SgmR2qvZtu61Y27EbSmdoNomRUoNPr+QykBeRmx163uUXYCiPAG5
         +AO4Xmhqznf33Kbqane/es3TRZ/jEbtSsFGjEYF11RZXvays52dvXWP6hGMFjw8ZD/6b
         3u9+V9mFv6FgQ2FzJbaczlnnxf55+7Nxbg1AAwuAleZ6a1q4Y0xEgjbNpC+p8HvvVB0f
         EIKS2htDPQ5/M1ixtKYmkS+3pBxy2uzCiVAupTGLhnE5hR12TsrQgA6D17QhzSFByB6c
         SnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707703463; x=1708308263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsrxGbd+ooYSWDZTCkHy7ejEqn2Gr/9LfDCkLbwwsGE=;
        b=J0jxc+832w9sxAoQFosPf/RRivIPtHK3QQEt+nthRDrcu8dY5DPeGXA//ckCVUh0xJ
         cNay6bSHq5PeuXuiWGHHVneX2PZIxM+w/aYsuB5WQSCksP+OcAl1hAgvR2Y4jzwatwjz
         cFn288R0KbNW/B+osSTt0SrdyecDIjdeidqixVfSXuAk+5CTGpSVSJjUzfHAnTaXSYWJ
         fYOVqkXnutCXnH0t7lwpAa+7lHxlcqcd2hixdLuognFxQXliqCFEpnZxVKd3YXM7TYvW
         Yeyc3HvSDkRUcHi2CaqbyZa5unboQVoR0Qxyk3ka10l1cYvidaJCUJH8POfL2iPyFPsH
         J1Cw==
X-Gm-Message-State: AOJu0YzYA1yleyszXordTv4ekW8nMj/wGUrbUrCVvN4z+qDrwYzVQ6TB
	yiYmLghvX8xsDg3ugV60UAUrbK9MKBLb7xMxbe2Ty/OORBZU0YcS
X-Google-Smtp-Source: AGHT+IHfpAhqqSvwCArO+eSLiXKqftpXVya7qy4ArmDpb0OddSqzStbnsx0XYcV1AllL1RRt6nXXmQ==
X-Received: by 2002:a17:903:1104:b0:1d9:c367:2032 with SMTP id n4-20020a170903110400b001d9c3672032mr6149354plh.10.1707703462565;
        Sun, 11 Feb 2024 18:04:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWy1fDCXF/hq1vAxIEA9hjG7uksPhaCkv9MPZSMuZ97awi4I71xxZCl4pqzM64Wd/1ESbZJnxGNaPd08U2bewdPYnL+TP1CAUeHhjQCakujFF4IeLGqL0fVHrh5eexQLPWEJzlTzKBTqWG7uugeB/GlH/ZG+RVIW5xvDtCH2fXmJ2CY4scAVRS/TGWAQQgUblf7IROWLnNpsmeruP7ACUqfel9tlvlqNOU9FqzwoMgivkg1DX70kx98CLw4fAefDeH/VU1/TpqtLO5JwWbOuVBGJNZAZBJYiJwY67wZVU7O7DyMCf1E6gAhYwFBnrn+IKS7q8MtagBDTHfoyeyVx152alSjTAo9Lj7O6ZxFarsmfArh24oESnH5Kpje29cnKQgg6oqV+FGWIhsCExmEWtyHoqtzYmBTRF7OV5QH0gyRaZJHdo7KLLbYNELLenwoFU7trJwUBvyLwYj6q73DrINOc5UseadQqC3uQnPrP9BybDOBMeNl3SwcUxg=
Received: from ocxma-dut.. ([153.126.233.61])
        by smtp.gmail.com with ESMTPSA id kc8-20020a17090333c800b001d5b93560c3sm4913556plb.167.2024.02.11.18.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:04:22 -0800 (PST)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mailhol.vincent@wanadoo.fr,
	vladimir.oltean@nxp.com,
	laforge@gnumonks.org,
	Takeru Hayasaka <hayatake396@gmail.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net-next v8 1/2] ethtool: Add GTP RSS hash options to ethtool.h
Date: Mon, 12 Feb 2024 02:04:03 +0000
Message-Id: <20240212020403.1639030-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a patch that enables RSS functionality for GTP packets using ethtool.

A user can include TEID and make RSS work for GTP-U over IPv4 by doing the
following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`

In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
gtpu(4|6)u, and gtpu(4|6)d.

gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format does
not include a TEID.
gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format that
includes a TEID.
gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U extended
header includes Uplink, applicable to both IPv4 and IPv6.
gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downlink,
for both IPv4 and IPv6.

GTP generates a flow that includes an ID called TEID to identify the tunnel.
This tunnel is created for each UE (User Equipment).By performing RSS based on
this flow, it is possible to apply RSS for each communication unit from the UE.
Without this, RSS would only be effective within the range of IP addresses. For
instance, the PGW can only perform RSS within the IP range of the SGW.
Problematic from a load distribution perspective, especially if there's a bias
in the terminals connected to a particular base station.This case can be
solved by using this patch.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2->v3: Based on Harald-san's review, I added documentation and comments to
ethtool.h and ice.rst.
v3->v4: Based on Marcin-san's review, I added the missing code for GTPC and
GTPC_TEID, and revised the documentation and comments.
v4->v5: Based on Marcin-san's review, I fixed rename and wrong code regarding
GTPC
v5->v6: Based on Marcin-san's review, Undoing the addition of unnecessary
blank lines.Minor fixes.
v6->v7 Based on Jakub-san's review, Split the patch.
v7->v8: There are no code changes. I've resent the patch, including Marcin-san's
patch, because PatchWork did not interpret the patch correctly.Simon-san told
me. Thanks.
 include/uapi/linux/ethtool.h | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 06ef6b78b7de..11fc18988bc2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2023,6 +2023,53 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+
+/* Used for GTP-U IPv4 and IPv6.
+ * The format of GTP packets only includes
+ * elements such as TEID and GTP version.
+ * It is primarily intended for data communication of the UE.
+ */
+#define GTPU_V4_FLOW 0x13	/* hash only */
+#define GTPU_V6_FLOW 0x14	/* hash only */
+
+/* Use for GTP-C IPv4 and v6.
+ * The format of these GTP packets does not include TEID.
+ * Primarily expected to be used for communication
+ * to create sessions for UE data communication,
+ * commonly referred to as CSR (Create Session Request).
+ */
+#define GTPC_V4_FLOW 0x15	/* hash only */
+#define GTPC_V6_FLOW 0x16	/* hash only */
+
+/* Use for GTP-C IPv4 and v6.
+ * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+ * After session creation, it becomes this packet.
+ * This is mainly used for requests to realize UE handover.
+ */
+#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
+#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+
+/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
+ * The format of these GTP packets includes TEID and QFI.
+ * In 5G communication using UPF (User Plane Function),
+ * data communication with this extended header is performed.
+ */
+#define GTPU_EH_V4_FLOW 0x19	/* hash only */
+#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
+
+/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
+ * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
+ * UL/DL included in the PSC.
+ * There are differences in the data included based on Downlink/Uplink,
+ * and can be used to distinguish packets.
+ * The functions described so far are useful when you want to
+ * handle communication from the mobile network in UPF, PGW, etc.
+ */
+#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
+#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
+#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
+#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
+
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
@@ -2037,6 +2084,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
-- 
2.34.1


