Return-Path: <linux-kernel+bounces-47584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D54844FD0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C30E2843B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8323B18C;
	Thu,  1 Feb 2024 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpP4W14d"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABC3A8C3;
	Thu,  1 Feb 2024 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758417; cv=none; b=GaMKBnZEIhfh75F6vbGEdLxtNQqiu7wv7Zcwm6iwwUOYhcvZGVb/FvkncPtTGAS1rc+DrxgWIjyT0s7wL+3iTBJAYJ/F3GC5lXXkyAT8ojNkw0gZ/XMM42EKHX7OOPNLiXQsMgO45cNJFO15Sd/1Q1zAhVmsp0POaaetzOnNoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758417; c=relaxed/simple;
	bh=c98q0DBzTSNS7tEr3sDPGDVeuEmomoTmFD862t30ECY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KWZdPtEQ4iDVM+9kwCAzs3Ha03UbYEjwd8xRyfLitdULumrqOpGTiptG6TI6grRjSvALv7GwuqA46cOIJ4jrUpdh7wERJEXjGWIHjKCdZje5qn8YEM89qZDJ6lQM55DPbtriXjdSbLR3ozXTLn86fZznS5OqIdb9cs+fTjMpAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpP4W14d; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bb9b28acb4so327373b6e.2;
        Wed, 31 Jan 2024 19:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758415; x=1707363215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ho6tWOUJQG5jwgdiQ+YC/nc1aAPjOngvOC35lqmr7A=;
        b=KpP4W14dbfgRShfei2GhIxyBibF9W4EZhwSIoK0shcFqhU3CvJV9PwCz2XJbF9wUc6
         WbAflA4I8e9ivhbfOZbj2X2H/hzSYHFTtTzLajVL2WgBzq4IxWU1+l5bNVYjtj/ocsfn
         1p9Esw9PXVe+js1NanquLE1X9Q5XuZ1etuKNZ2Nr5nT1TgWlF+ndqYTCx+EgyfM+YrV3
         LdpxOP9P+GNSOxIikFwkNB+yBPiJKP60dcJVLyee76TMso0vxOmdnWqwOoxjyuND8rGK
         nwdsTmljWTJ08tn/dekjD56g7rLqM8zSUmSMqRwtoeFwR1xeDYWiPo6UGFg1crcnWhUS
         zRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758415; x=1707363215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ho6tWOUJQG5jwgdiQ+YC/nc1aAPjOngvOC35lqmr7A=;
        b=NQ99FYySCCNViFadfgxijnuSx+X/CL64JfjC0vk4pzM+jpJ7TYCsbiWAMWCHiVnOFZ
         TLgHAtntLYy9ip/jlu8hZpkkqMB0ybCcZlVMoV4Smok8BNqGyhTswsdP4s2XIJa7/6A0
         NAt9GJbAJYkC9e8CZ8tsx1thV4fVnvFWP2zwl/gFbPI+DHDH1s2Luld6iGpjYXzTDJnW
         bFqg/LXgN0J0CA2N8pYKOGKqhZHepeX6M1uyTDi1Q1RkjokZ804yXbn9KPWiFIsv5cA+
         Z2Z0pkMS5f83PRB9hWwzRyfWqL2s3rKXk4OOPz1WT/dLKaGlVamWPgVq0ywcz0ryRFHL
         zY3w==
X-Gm-Message-State: AOJu0Yy5Z1m8rfYyokVjK04g/5Q4Q2dJsk3ig+Me/8JmqT+G/F5tpwZ7
	LroJ7ahm863HdRQBl9CK4KzWKmO2vZ+8tPfue1nqn3q9lSmuTFjQ
X-Google-Smtp-Source: AGHT+IENjLvEpE9KD1z9Zpm/r2KpiGmQBztfkkKyMKEkrLlj9O/v/fl7kfS6TC+kgGwW+FX5ejt8SA==
X-Received: by 2002:a05:6808:170e:b0:3be:58:4a23 with SMTP id bc14-20020a056808170e00b003be00584a23mr3686028oib.54.1706758414953;
        Wed, 31 Jan 2024 19:33:34 -0800 (PST)
Received: from ocxma-dut.. ([153.126.233.62])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b006ddd2be2169sm10661625pfa.73.2024.01.31.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:33:34 -0800 (PST)
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
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH net-next v7 1/2] ethtool: Add GTP RSS hash options to ethtool.h
Date: Thu,  1 Feb 2024 03:33:09 +0000
Message-Id: <20240201033310.1028154-1-hayatake396@gmail.com>
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


