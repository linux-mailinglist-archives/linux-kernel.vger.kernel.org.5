Return-Path: <linux-kernel+bounces-41214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9838B83ED80
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C681B21596
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91D288D7;
	Sat, 27 Jan 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQvYH4fF"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5028DA0;
	Sat, 27 Jan 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366063; cv=none; b=Nydk2BskrJW+NukTSZN07TTKRxmZE8mtcpfQsllXTF9xfKX+/+hkF7xaC+wpsex1j6UIXYRf2zhuADnKmzSS74O2Vtt53GBJFVSmS2HLys4un+fo9xKxxZiSK6FY36RTMIMVZAK1mJ/YKbq9QWxPBFCbrD6FTnRpG/GsrGCHBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366063; c=relaxed/simple;
	bh=SwgbL6R6rjtyODBrPAM5Rc0AGgL/I6UBGUJ2RqnTg48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wbst8kfWDKhFPPiJMpk+ViGE1BX2NXIlSeM+bEbaEgkYSNcwfhGO1+lOabIirWfCkWIxDiJgyqpyMJCan1Fovc1wrm1MOEuan4rXU3xG+SfAHJpjPxUwa5GEyeW4+vKz7pnHVNtwrYUHt+wfVa+PiUnsoBTm8qHCdLa+jhEMoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQvYH4fF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so710896b3a.3;
        Sat, 27 Jan 2024 06:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706366061; x=1706970861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DU2wtgM1sYNlNq0tFEhGIhqfxPmXsPzm3Qf0VdWlxiM=;
        b=YQvYH4fFUFBcbwa4Did97zyYjEvtbvlOS3Vigb8e4/ZEmxGfP7B4FuNwa/s/3t15iT
         LzPcC0dALn+NoMwVREOdOn0r6LBueQ2eDthgJUu6yMP7rzx3Iqis5mTTN9JpohZ7JPYK
         2ksxwKEfvy/XJDggrqAb91PZIRn3WURWK1yO7iFHvLlC4L9nmGWqbpCRFYrnnb/zYmkO
         tn/zJWmWLlsWPZ3WKkW884daEpnXCsBq4FGN4AeB6jDTz21Oh6E0b6+2K51lyQHTXR2G
         d7uw/yt/m09mRIMWWumNT4T7dJmijqXko87fwUKnExiOm5Cc1h87/YKtdKpYygh63dkO
         4d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706366061; x=1706970861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DU2wtgM1sYNlNq0tFEhGIhqfxPmXsPzm3Qf0VdWlxiM=;
        b=PM0AdlCXBj0mF/vntMgO5mrB6PoLCsETEbFTjJpnhA29z1jxi7fOHd4p+8BZ8R/Jt+
         TfMmtamSED0+iy9jmKNhwgCJEJeSKmnH4muWA9CKp3iemNCy077rVQtXHtYU2k38Kph8
         WrU3sW8fjwpR2bqusZ1Dg5wv3YaqgWepZhCFctNyWWkmjwNJOglspymSD2VclQExONhl
         w45J8lUqEq1TnU+dANTb2y8oHvlLD8KyRYDNMs5Ba3KRPf0Us8Jlku313lL7oVGfpXzP
         aQVzk1kPyG+n1wlv9/KZllBDxqgAESo9yOa3k0pNI6xJyd4wWTKaYCEiLJ5Y3HXsXm70
         ksoQ==
X-Gm-Message-State: AOJu0YyVZ/i3xZ12r+Sq2X9fgr+Sbti45yyifuwf1mp0v6v8DN2+dT6P
	L72CQ2usxz345wEFHWcn0ekVOuvN0pBE5IoGhsF78fV8UDfLbjma
X-Google-Smtp-Source: AGHT+IG79Zpy/H6uiiFkhouwH1vLAj1aKTq5+TRNZxxjlwoi3YI92aWeNRfzzNSVgiDi8iil7zeXCg==
X-Received: by 2002:a05:6a00:2fc3:b0:6d9:bb7c:a56d with SMTP id fn3-20020a056a002fc300b006d9bb7ca56dmr648845pfb.35.1706366061065;
        Sat, 27 Jan 2024 06:34:21 -0800 (PST)
Received: from ocxma-dut.. ([153.126.233.62])
        by smtp.gmail.com with ESMTPSA id gu7-20020a056a004e4700b006db105027basm2852463pfb.50.2024.01.27.06.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 06:34:20 -0800 (PST)
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
Subject: [PATCH net-next RESENT v3] ethtool: ice: Support for RSS settings to GTP from ethtool
Date: Sat, 27 Jan 2024 14:07:48 +0000
Message-Id: <20240127140747.905552-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a patch that enables RSS functionality for GTP packets using ethtool.

A user can include her TEID and make RSS work for GTP-U over IPv4 by doing the following:
`ethtool -N ens3 rx-flow-hash gtpu4 sde`

In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,gtpu(4|6)u, and gtpu(4|6)d.

gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format does not include a TEID.
gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format that includes a TEID.
gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U extended header includes Uplink, applicable to both IPv4 and IPv6.
gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downlink, for both IPv4 and IPv6.

GTP generates a flow that includes an ID called TEID to identify the tunnel. This tunnel is created for each UE (User Equipment).By performing RSS based on this flow, it is possible to apply RSS for each communication unit from the UE.Without this, RSS would only be effective within the range of IP addresses. 
For instance, the PGW can only perform RSS within the IP range of the SGW.Problematic from a load distribution perspective, especially if there's a bias in the terminals connected to a particular base station.This case can be solved by using this patch.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
(I have resent the submission after making revisions based on Paul's advice.)
Sorry for the delay.
I've been swamped with other work and fell behind. 
Since Harald has been supportive of the basic structure in the previous patch review, I've kept it largely unchanged but added some comments and documentation.
I would appreciate it if you could review it again.

 .../device_drivers/ethernet/intel/ice.rst     | 23 ++++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 74 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_flow.h     | 22 ++++++
 drivers/net/ethernet/intel/ice/ice_lib.c      | 37 ++++++++++
 include/uapi/linux/ethtool.h                  | 41 ++++++++++
 5 files changed, 192 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 5038e54586af..6bc1c6f10617 100644
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
index a19b06f18e40..eb5f490c6127 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2486,6 +2486,21 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 	case SCTP_V4_FLOW:
 		hdrs |= ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4;
 		break;
+	case GTPU_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_EH_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_UL_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_DL_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV4;
+		break;
 	case TCP_V6_FLOW:
 		hdrs |= ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6;
 		break;
@@ -2495,6 +2510,21 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 	case SCTP_V6_FLOW:
 		hdrs |= ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV6;
 		break;
+	case GTPU_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_EH_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_UL_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_DL_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV6;
+		break;
 	default:
 		break;
 	}
@@ -2518,6 +2548,11 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
 		case TCP_V4_FLOW:
 		case UDP_V4_FLOW:
 		case SCTP_V4_FLOW:
+		case GTPU_V4_FLOW:
+		case GTPC_V4_FLOW:
+		case GTPU_EH_V4_FLOW:
+		case GTPU_UL_V4_FLOW:
+		case GTPU_DL_V4_FLOW:
 			if (nfc->data & RXH_IP_SRC)
 				hfld |= ICE_FLOW_HASH_FLD_IPV4_SA;
 			if (nfc->data & RXH_IP_DST)
@@ -2526,6 +2561,11 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
 		case TCP_V6_FLOW:
 		case UDP_V6_FLOW:
 		case SCTP_V6_FLOW:
+		case GTPU_V6_FLOW:
+		case GTPC_V6_FLOW:
+		case GTPU_EH_V6_FLOW:
+		case GTPU_UL_V6_FLOW:
+		case GTPU_DL_V6_FLOW:
 			if (nfc->data & RXH_IP_SRC)
 				hfld |= ICE_FLOW_HASH_FLD_IPV6_SA;
 			if (nfc->data & RXH_IP_DST)
@@ -2564,6 +2604,33 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
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
 	return hfld;
 }
 
@@ -2676,6 +2743,13 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
 	    hash_flds & ICE_FLOW_HASH_FLD_UDP_DST_PORT ||
 	    hash_flds & ICE_FLOW_HASH_FLD_SCTP_DST_PORT)
 		nfc->data |= (u64)RXH_L4_B_2_3;
+
+	if (hash_flds & ICE_FLOW_HASH_FLD_GTPC_TEID ||
+	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_IP_TEID ||
+	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_EH_TEID ||
+	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
+	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
+		nfc->data |= (u64)RXH_GTP_TEID;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index ff82915ab497..9d6803d68a45 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -66,6 +66,20 @@
 	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_EH_TEID | \
 	 ICE_FLOW_HASH_GTP_U_EH_QFI)
 
+#define ICE_FLOW_HASH_GTP_U_UP \
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID))
+#define ICE_FLOW_HASH_GTP_U_DWN \
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID))
+
+#define ICE_FLOW_HASH_GTP_U_IPV4_UP \
+	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_UP)
+#define ICE_FLOW_HASH_GTP_U_IPV6_UP \
+	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_UP)
+#define ICE_FLOW_HASH_GTP_U_IPV4_DWN \
+	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_DWN)
+#define ICE_FLOW_HASH_GTP_U_IPV6_DWN \
+	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_DWN)
+
 #define ICE_FLOW_HASH_PPPOE_SESS_ID \
 	(BIT_ULL(ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID))
 
@@ -242,6 +256,14 @@ enum ice_flow_field {
 #define ICE_FLOW_HASH_FLD_SCTP_DST_PORT	\
 	BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_DST_PORT)
 
+#define ICE_FLOW_HASH_FLD_GTPC_TEID	BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_IP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_IP_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_EH_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_EH_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_EH_QFI BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_EH_QFI)
+#define ICE_FLOW_HASH_FLD_GTPU_UP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_DWN_TEID \
+	BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID)
+
 /* Flow headers and fields for AVF support */
 enum ice_flow_avf_hdr_field {
 	/* Values 0 - 28 are reserved for future use */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9be724291ef8..72f737c6c9ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1618,6 +1618,25 @@ static const struct ice_rss_hash_cfg default_rss_cfgs[] = {
 	 */
 	{ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4,
 		ICE_HASH_SCTP_IPV4, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpc4 with input set IPv4 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4,
+		ICE_FLOW_HASH_IPV4, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpc4t with input set IPv4 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4,
+		ICE_FLOW_HASH_GTP_U_IPV4_TEID, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu4 with input set IPv4 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4,
+		ICE_FLOW_HASH_GTP_IPV4_TEID, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu4e with input set IPv4 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV4,
+		ICE_FLOW_HASH_GTP_U_IPV4_EH, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu4u with input set IPv4 src/dst */
+	{ ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV4,
+		ICE_FLOW_HASH_GTP_U_IPV4_UP, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu4d with input set IPv4 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV4,
+		ICE_FLOW_HASH_GTP_U_IPV4_DWN, ICE_RSS_OUTER_HEADERS, false},
+
 	/* configure RSS for tcp6 with input set IPv6 src/dst, TCP src/dst */
 	{ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6,
 				ICE_HASH_TCP_IPV6,  ICE_RSS_ANY_HEADERS, false},
@@ -1632,6 +1651,24 @@ static const struct ice_rss_hash_cfg default_rss_cfgs[] = {
 	/* configure RSS for IPSEC ESP SPI with input set MAC_IPV4_SPI */
 	{ICE_FLOW_SEG_HDR_ESP,
 		ICE_FLOW_HASH_ESP_SPI, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpc6 with input set IPv6 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6,
+		ICE_FLOW_HASH_IPV6, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpc6t with input set IPv6 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6,
+		ICE_FLOW_HASH_GTP_U_IPV6_TEID, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu6 with input set IPv6 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6,
+		ICE_FLOW_HASH_GTP_IPV6_TEID, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu6e with input set IPv6 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV6,
+		ICE_FLOW_HASH_GTP_U_IPV6_EH, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu6u with input set IPv6 src/dst */
+	{ ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV6,
+		ICE_FLOW_HASH_GTP_U_IPV6_UP, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu6d with input set IPv6 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV6,
+		ICE_FLOW_HASH_GTP_U_IPV6_DWN, ICE_RSS_OUTER_HEADERS, false},
 };
 
 /**
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 06ef6b78b7de..b3d67f3aa948 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2023,6 +2023,46 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+/* Used for GTP-U IPv4 and IPv6.
+ * The format of GTP packets only includes
+ * elements such as TEID and GTP version.
+ * It is primarily intended for data communication of the UE.
+ */
+#define GTPU_V4_FLOW 0x13	/* hash only */
+#define GTPU_V6_FLOW 0x14	/* hash only */
+/* Use for GTP-C IPv4 and v6.
+ * The format of these GTP packets does not include TEID.
+ * Primarily expected to be used for communication
+ * to create sessions for UE data communication,
+ * commonly referred to as CSR (Create Session Request).
+ */
+#define GTPC_V4_FLOW 0x15	/* hash only */
+#define GTPC_V6_FLOW 0x16	/* hash only */
+/* Use for GTP-C IPv4 and v6.
+ * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+ * After session creation, it becomes this packet.
+ * This is mainly used for requests to realize UE handover.
+ */
+#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
+#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+/* Use for GTP-U and extended headers for the PDU session container(PSC).
+ * The format of these GTP packets includes TEID and QFI.
+ * In 5G communication using UPF (User Plane Function),
+ * data communication with this extended header is performed.
+ */
+#define GTPU_EH_V4_FLOW 0x19	/* hash only */
+#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
+/* Use for GTP-U IPv4 and v6 PDU session container(PSC) extended headers.
+ * The difference from before is distinguishing based on the PSC.
+ * There are differences in the data included based on Downlink/Uplink,
+ * and can be used to distinguish packets.
+ * The functions described so far are useful when you want to
+ * handle communication from the mobile network in UPF, PGW, etc.
+ */
+#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
+#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
+#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
+#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
@@ -2037,6 +2077,7 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
-- 
2.34.1


