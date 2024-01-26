Return-Path: <linux-kernel+bounces-39530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C115383D263
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79567291230
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458B4567D;
	Fri, 26 Jan 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFcBfBg2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860704687;
	Fri, 26 Jan 2024 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235020; cv=none; b=oyZ/Ep1s5qcBWNXSGIrEF+B2jy0ukso+5MAExzXs0OhGQ+ALEIJ4kMiPTgJpCDHYfhKPKm6azWX2h7yQ3EJQ/1Z2Wg1vhhxIcM7iixzJYNe75I8KTo0aWXblJIkfS/KfYX0l6brLd8LvpFgj6pDPfpZ/8BTajNaAJ8omC+gBMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235020; c=relaxed/simple;
	bh=6v2FN2p81kidGMFBYwnq5KT+TLDFlAZQmj4CY+00aGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/NYumyNUI8cmt425lRYFIAAySCMbGNAqos2T7PDygFCOFIaxavrR0UMEgO8hZPsyPSnIRqKFg5YpfHhKkYD6erYO6UYFzl92KsBA9npxLUlwAlRd/zJStsgbn0cz4K52IdIcYAO/slPzAtaFYsYRCgHjoviyIdshGu/1RjGmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFcBfBg2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d731314e67so31104495ad.1;
        Thu, 25 Jan 2024 18:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706235018; x=1706839818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8B1O00SdeuKEg/sH/EZDUoyazytZxHGS8kZbS7zUUA=;
        b=CFcBfBg2RHXUQ24Ha+IBIj2b40/u4XexcChNshKdX1/CnPF0f/DbJoPtgcZjT6Kb3C
         oXTOBBjRc7XbbIJpI5xY8Uux6ZM9MGE6r2DzROEj6e8z6WTSYJ5hTmiQBIxQO3KjuQja
         PjLgiJGMVmLji4jqOZ2HUUTRRGGbJK6vtNZwOQgwpXgr+z5GkxZswF/P+1EEvFWKbGDd
         klSaISDzwWkiDuGBY7SpwDooQMXks0OOpLlzVAKZnbv/Q0U/iK+ROd/noCSXnWKIyxG+
         /rKNQ7LtQiEFM6UJHnxkAZuOueZ6S1Q05BW4jOIexCm4cIeOAMHsRx6U+r13XK6LFvET
         KMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706235018; x=1706839818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8B1O00SdeuKEg/sH/EZDUoyazytZxHGS8kZbS7zUUA=;
        b=qVyZqVXxqp0ug5nb02q3r+BmxywLB9bNKCuAIDTMH2VCzOEYsr9S+mtgfmvBdrrCmi
         Dz3vq6a1ULqInh0Ra3hyQnVj7S8npRKEa2ym+h0mjJJ2CSGLBUo6BvoYA6LJgfE6uZAG
         TG5zk6ekPI30Ytgp8ghGF3MXLsizkCoCyi6dYucPs1z8XqirkbaeznnwO9a/cQBO0SeS
         n5eXvjsos+AZG/77XzbTieErOy3fTniajiwwaGpBjij2NIRD4IhVsmD9u12LvP56XNqb
         uJp3t+nGaSVuAqOwHoeKeJuNhHCsYxGt0mQS9KEoQ4l25aNomg2Aam2BHZxEBiwyl1Ke
         7lzQ==
X-Gm-Message-State: AOJu0YzMUCC9SHABqHlqH+U4O0st8d+QvSUVZn1AfNSIvxfSu4yzdrYl
	f3kZX1IwiWUeGUY0z+v55zpKlY3QKHi721ibrSY3lndBu4dhkjpq
X-Google-Smtp-Source: AGHT+IEnfqve9u7cQMYFpRFk7ZdEbzNkrVyrNDi2hpBieIyDeV3JIlXOErueU5u3CfvIRuzgiFmCzA==
X-Received: by 2002:a17:903:191:b0:1d4:e084:571e with SMTP id z17-20020a170903019100b001d4e084571emr713097plg.129.1706235017658;
        Thu, 25 Jan 2024 18:10:17 -0800 (PST)
Received: from ocxma-dut.. ([153.126.233.62])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902f24300b001d6f584ee1esm157288plc.34.2024.01.25.18.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 18:10:17 -0800 (PST)
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
Subject: [PATCH net-next v3] ethtool: ice: Support for RSS settings to GTP from ethtool
Date: Fri, 26 Jan 2024 02:09:49 +0000
Message-Id: <20240126020949.758175-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a patch that enables RSS functionality for GTP packets using
ethtool.
A user can include her TEID and make RSS work for GTP-U over IPv4 by
doing the following:
`ethtool -N ens3 rx-flow-hash gtpu4 sde`
In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
gtpu(4|6)u, and gtpu(4|6)d.

gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format does not include a TEID (Tunnel Endpoint Identifier).
gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format that includes a TEID.
gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
gtpu(4|6)u: Used when the PSC (Packet Service Charge) in the GTP-U extended header includes Uplink, applicable to both IPv4 and IPv6.
gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downlink, for both IPv4 and IPv6.

GTP generates a flow that includes an ID called TEID to identify the
tunnel. This tunnel is created for each UE (User Equipment).
By performing RSS based on this flow, it is possible to apply RSS for
each communication unit from the UE.
Without this, RSS would only be effective within the range of IP
addresses.
For instance, the PGW can only perform RSS within the IP range of the
SGW.
problematic from a load distribution perspective, especially if there's
a bias in the terminals connected to a particular base station.
This case can be solved by using this patch

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
Sorry for the delay; I've been swamped with other work and fell behind. Since Harald has been supportive of the basic structure in the previous patch review, I've kept it largely unchanged but added some comments and documentation. I would appreciate it if you could review it again.

 .../device_drivers/ethernet/intel/ice.rst     | 23 +++++++---
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 42 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c      | 20 +++++++--
 include/uapi/linux/ethtool.h                  | 37 +++++++++++++---
 4 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index e4d065c55ea8..4b32e510ecdb 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -368,16 +368,29 @@ more options for Receive Side Scaling (RSS) hash byte configuration.
   # ethtool -N <ethX> rx-flow-hash <type> <option>
 
   Where <type> is:
-    tcp4  signifying TCP over IPv4
-    udp4  signifying UDP over IPv4
-    tcp6  signifying TCP over IPv6
-    udp6  signifying UDP over IPv6
+    tcp4    signifying TCP over IPv4
+    udp4    signifying UDP over IPv4
+    gtpc4   signifying GTP-C over IPv4
+    gtpc4t  signifying GTP-C (include TEID) over IPv4
+    gtpu4   signifying GTP-U over IPV4
+    gtpu4e  signifying GTP-U and Extension Header over IPV4
+    gtpu4u  signifying GTP-U PSC Uplink over IPV4
+    gtpu4d  signifying GTP-U PSC Downlink over IPV4
+    tcp6    signifying TCP over IPv6
+    udp6    signifying UDP over IPv6
+    gtpc6   signifying GTP-C over IPv6
+    gtpc6t  signifying GTP-C (include TEID) over IPv6
+    gtpu6   signifying GTP-U over IPV6
+    gtpu6e  signifying GTP-U and Extension Header over IPV6
+    gtpu6u  signifying GTP-U PSC Uplink over IPV6
+    gtpu6d  signifying GTP-U PSC Downlink over IPV6
+
   And <option> is one or more of:
     s     Hash on the IP source address of the Rx packet.
     d     Hash on the IP destination address of the Rx packet.
     f     Hash on bytes 0 and 1 of the Layer 4 header of the Rx packet.
     n     Hash on bytes 2 and 3 of the Layer 4 header of the Rx packet.
-
+    e     Hash on GTP Packet on TEID(4byte) of the Rx packet.
 
 Accelerated Receive Flow Steering (aRFS)
 ----------------------------------------
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index eaa2b993cb48..a9ba300570b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2494,6 +2494,9 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 		hdrs |= ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4;
 		break;
 	case GTPC_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_TEID_V4_FLOW:
 		hdrs |= ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4;
 		break;
 	case GTPU_EH_V4_FLOW:
@@ -2518,6 +2521,9 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 		hdrs |= ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6;
 		break;
 	case GTPC_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_TEID_V6_FLOW:
 		hdrs |= ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6;
 		break;
 	case GTPU_EH_V6_FLOW:
@@ -2573,6 +2579,7 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc)
 		case SCTP_V4_FLOW:
 		case GTPU_V4_FLOW:
 		case GTPC_V4_FLOW:
+		case GTPC_TEID_V4_FLOW:
 		case GTPU_EH_V4_FLOW:
 		case GTPU_UL_V4_FLOW:
 		case GTPU_DL_V4_FLOW:
@@ -2586,6 +2593,7 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc)
 		case SCTP_V6_FLOW:
 		case GTPU_V6_FLOW:
 		case GTPC_V6_FLOW:
+		case GTPC_TEID_V6_FLOW:
 		case GTPU_EH_V6_FLOW:
 		case GTPU_UL_V6_FLOW:
 		case GTPU_DL_V6_FLOW:
@@ -2642,6 +2650,33 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc)
 		}
 	}
 
+	if (nfc->data & RXH_GTP_TEID) {
+		switch (nfc->flow_type) {
+		case GTPC_TEID_V4_FLOW:
+		case GTPC_TEID_V6_FLOW:
+			hfld |= ICE_FLOW_HASH_FLD_GTPC_TEID;
+			break;
+		case GTPU_V4_FLOW:
+		case GTPU_V6_FLOW:
+			hfld |= ICE_FLOW_HASH_FLD_GTPU_IP_TEID;
+			break;
+		case GTPU_EH_V4_FLOW:
+		case GTPU_EH_V6_FLOW:
+			hfld |= ICE_FLOW_HASH_FLD_GTPU_EH_TEID;
+			break;
+		case GTPU_UL_V4_FLOW:
+		case GTPU_UL_V6_FLOW:
+			hfld |= ICE_FLOW_HASH_FLD_GTPU_UP_TEID;
+			break;
+		case GTPU_DL_V4_FLOW:
+		case GTPU_DL_V6_FLOW:
+			hfld |= ICE_FLOW_HASH_FLD_GTPU_DWN_TEID;
+			break;
+		default:
+			break;
+		}
+	}
+
 	switch (nfc->flow_type) {
 	case GTPC_V4_FLOW:
 	case GTPC_V6_FLOW:
@@ -2777,6 +2812,13 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
 		hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
 		hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
 		nfc->data |= (u64)RXH_L4_B_2_3;
+
+	if (hash_flds & ICE_FLOW_HASH_FLD_GTPC_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_IP_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_EH_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
+		nfc->data |= (u64)RXH_GTP_TEID;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 6253d8a3fea4..d9b111e09fc7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1667,10 +1667,17 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 			vsi_num, status);
 
 	/* configure RSS for gtpc4 with input set IPv4 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_IPV4,
+				 ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc4 flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpc4t with input set IPv4 src/dst */
 	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_IPV4_TEID,
 				 ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4);
 	if (status)
-		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc4 flow, vsi = %d, error = %d\n",
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc4t flow, vsi = %d, error = %d\n",
 			vsi_num, status);
 
 	/* configure RSS for gtpu4 with input set IPv4 src/dst */
@@ -1722,11 +1729,18 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 		dev_dbg(dev, "ice_add_rss_cfg failed for sctp6 flow, vsi = %d, error = %d\n",
 			vsi_num, status);
 
-	/* configure RSS for gtpc6 with input set IPv6 src/dst */
+	/* configure RSS for gtpc6 with input set IPv4 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_IPV6,
+				 ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc4 flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpc6t with input set IPv6 src/dst */
 	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_IPV6_TEID,
 				 ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6);
 	if (status)
-		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc6 flow, vsi = %d, error = %d\n",
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc6t flow, vsi = %d, error = %d\n",
 			vsi_num, status);
 
 	/* configure RSS for gtpu6 with input set IPv6 src/dst */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f3af2a78f7dd..e79ad8faada3 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2011,16 +2011,40 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+
+// Used for GTP-U IPv4 and IPv6.
+// The format of GTP packets only includes elements such as TEID and GTP version.
+// It is primarily intended for data communication of the User Equipment (UE).
 #define GTPU_V4_FLOW 0x13	/* hash only */
 #define GTPU_V6_FLOW 0x14	/* hash only */
+// Use for GTP-C IPv4 and v6.
+// The format of these GTP packets does not include TEID.
+// Primarily expected to be used for communication to create sessions for UE data communication,
+// commonly referred to as CSR (Create Session Request).
 #define GTPC_V4_FLOW 0x15	/* hash only */
 #define GTPC_V6_FLOW 0x16	/* hash only */
-#define GTPU_EH_V4_FLOW 0x17	/* hash only */
-#define GTPU_EH_V6_FLOW 0x18	/* hash only */
-#define GTPU_UL_V4_FLOW 0x19	/* hash only */
-#define GTPU_UL_V6_FLOW 0x20	/* hash only */
-#define GTPU_DL_V4_FLOW 0x21	/* hash only */
-#define GTPU_DL_V6_FLOW 0x22	/* hash only */
+// Use for GTP-C IPv4 and v6.
+// Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+// After session creation, it becomes this packet.
+// This is mainly used for requests to realize UE handover.
+#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
+#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+// Use for GTP-U and extended headers for the PDU session container.
+// The format of these GTP packets includes TEID and QFI.
+// In 5G communication using UPF (User Plane Function),
+// data communication with this extended header is performed.
+#define GTPU_EH_V4_FLOW 0x19	/* hash only */
+#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
+// Use for GTP-U IPv4 and v6 PDU session container extended headers.
+// The difference from before is distinguishing based on the PDU session container.
+// There are differences in the data included based on DL (Downlink)/UL (Uplink),
+// and can be used to distinguish packets.
+// The functions described so far are useful when you want to handle data communication
+// from the mobile network in UPF, PGW, etc.
+#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
+#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
+#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
+#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
@@ -2035,6 +2059,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
-- 
2.34.1


