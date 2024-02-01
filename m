Return-Path: <linux-kernel+bounces-47577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB5844FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B6528F43D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE613B78D;
	Thu,  1 Feb 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBELPiiX"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A63B786;
	Thu,  1 Feb 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758118; cv=none; b=kfK636/H5OfLyBA/VXVKYpQOHXGU/ibW6qmdxqyFInRnSWHUYSzCbaQsTcLeqXtPbTUkcvTl9OQv+3nItF06lINRIQaQ9Km4h9Gxsd6aaDa2UxN4Wj8Db6Au7dN2QEALBXbd0vX6nd93OWdyLHz0vIIB+auD/iI9KjdiUoEGWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758118; c=relaxed/simple;
	bh=emwqzbfyj2CjwDXfFxr2yguXLoC7xr2j8vCVmi+56Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S+EQAzKLm3NvcysdiisNkIE5pSXSh8hpUl/dJ4NcEQZu9nSRmQf1KrLZJpygTY1fJtHkW9SxOvt1pQRLYYwv0b8r4w80I/ROkfA1tVOBa+5BCn+v2oBY0o5rXHZO7V95yaruf78oNqv/M1YygTxTS2o4gRG0x6H65ThQY6yb0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBELPiiX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso367161a12.3;
        Wed, 31 Jan 2024 19:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758116; x=1707362916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ho6tWOUJQG5jwgdiQ+YC/nc1aAPjOngvOC35lqmr7A=;
        b=mBELPiiXKuLics7srQM2DZE4cUcti2pBcBrZ+AVMhMpaEnv8eB6VvqeyR/yarNDKaR
         oaQVDmobaB24PBRSKzIWokVYF5YpVCxe99ey/94qJ+N1KHCJGcz/mbgl3Q267Nj3g7H8
         ODTS2EqcqRLe0Lz/V59cXFHc3kDRXEKzX7ZS6CEDdKVBToqWVFHK0wv82+IZ4zmt4IJN
         g5ip44mZNYpmNMjpxeFI0iRxFrthIUL+sQxoS9vbeMtkLluahFKsxCZO9KkDOKpVb1e1
         VVfYAwS/pEJvNmOl9Bxp2EsUr+VX79PTHC5rw14dAP2pRSzLC+XTU0J0TePwdAsXOxTd
         eB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758116; x=1707362916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ho6tWOUJQG5jwgdiQ+YC/nc1aAPjOngvOC35lqmr7A=;
        b=MfAN+5jde1l/bDDF1C/0ebLqXHfhlUsIlsTVrzaCBkHiT7mRRnx122mWmledjBcqAk
         HTtQFHZwsQufiE46wIkevjXa00K8G93rLZReSmOTWWfLLmtxW2wAxybEKwbOTuVzR1yU
         5Q1nItGv/l7weNlkRmJXM87sNKbX5cvDKeWCFEuEpso4auC57Res2pMG/ONRPESaZapr
         58EyGzwoZYw/C3QVU0ulvWhjSV7Kky4ann1koR2U/4GhjJhonV/KdfvBoJRxTWEEBC8z
         FSJvNK96OFJHxPPGNP5lxp/2WG3IYk1NL5qI5ZJ3dz06zfrIDi652J76/7DkUqCR7f9y
         4vHQ==
X-Gm-Message-State: AOJu0YwMafAa9iB6L1zcA/py4nEsCf1Ooze/GFjLQluQw0ycUQV6S7ip
	ccq0vU1sTGf/UylH4gjJZzZO/icbsffu9pUbHgn82EVpvE+A8eRF
X-Google-Smtp-Source: AGHT+IEg4yxMdZKR72aUWYqIJObTXDnPnApeUkWrbWcBkPgWJ9jQiF6bv9EpHP9LqAQfMdqtWN+v9Q==
X-Received: by 2002:a05:6a20:d485:b0:19c:881d:78e6 with SMTP id im5-20020a056a20d48500b0019c881d78e6mr3543871pzb.42.1706758115776;
        Wed, 31 Jan 2024 19:28:35 -0800 (PST)
Received: from ocxma-dut.. ([153.126.233.62])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001d8c8c903c0sm347852plb.149.2024.01.31.19.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:28:35 -0800 (PST)
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
Subject: [PATCH net-next v6 1/2] ethtool: Add GTP RSS hash options to ethtool.h
Date: Thu,  1 Feb 2024 03:27:49 +0000
Message-Id: <20240201032748.1027121-1-hayatake396@gmail.com>
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


