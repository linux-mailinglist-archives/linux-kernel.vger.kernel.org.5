Return-Path: <linux-kernel+bounces-47578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BE844FC0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A2E1C2544D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BA3C088;
	Thu,  1 Feb 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2qnltL+"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE93BB2A;
	Thu,  1 Feb 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758122; cv=none; b=ibdVYZqA6k0ihzU9cMSimpbsjddHlAlJKqdVZYj7XbVJ8EWXGuhNS+c7e09U0pIDk2R8M/4lnIdUKzfojmpaViw7QT/ajOjmTjqJHuXbNTJGXWebeLFWjooH9kfxRQzOOmViMz4KzoyxNycb2ce8CayOfDfU3njegW6fwEhAnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758122; c=relaxed/simple;
	bh=FcN9Oz8uRf7SVlupVgLPbuVjVr6ymhkfTfSTUN2UYTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awuxt9CeL0z4iKlaRwDqMvWxy/YpvL+UVsVfQYB/UDoy9wpXIxZItolGq0H7YaocLPHk5XtIRMgJhqpERFnEldDweywLECwrgwTgg9TQDKpAJOatspGM+5sQAbRbvMR04WrZ92QHHls/vptVxRhAOsz6Z1aU4TU4D2IPMS0Jitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2qnltL+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d74045c463so3844895ad.3;
        Wed, 31 Jan 2024 19:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758120; x=1707362920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUVdlwWAjj8cbBkvTW+76Z/trcG39A3eTZ0exUJTSf4=;
        b=f2qnltL+f5eBov1K46SLpTbtOisGUwqrPqBdlmkmAYhzKJzJjuUpS7vD8Y5pAxrXNr
         MndfGKuYXHjzrICxteByANcIPhfZCTuqANFfK8Mv/ld8IQkHav8N4q/nhZjpRMGJ1f07
         n23g+nia8bNce5yFBgCZwoWTT5BijKyUJF2uwK65LfSi1kqyBtlELDWGk1WD99vjo/HQ
         4GIKISJUe1ilaBYDs/mwyjKB/eyyPCOU7U2LSrG1tJ2fyqhFoqk9BX0VYUtAJr7S3NMB
         HQoxnYvTLY8WmgFTzPahZJ5bnfqHbQPeGIvfjiBOHNlTkBctqyM9GcKMKs3U+2VlCmw4
         mxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758120; x=1707362920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUVdlwWAjj8cbBkvTW+76Z/trcG39A3eTZ0exUJTSf4=;
        b=DoRmJ/lMMWYnFBuXlRfqM8TuGgTatlBp71adl6cfLHRTjhCqMrN3sz8s2xrsrcBJaM
         7I77FPyfMdbohRLKSaHhmtJU38DtIn1bY4YIgqKS2XfibRTrK6OHCX4tuNEJlVOAKDa+
         nZXDX4xYTJc9wm/9yVRFlHLmdprkRZ0fkT8iOqdxsv4B8/EvELxQfa9LJII5c6cytmbg
         RMSEhViiufKs3rX4g/PomIzsErxLgwsuHSIMICUJRpridqw6YQCvqYzHdP/pX6QIHyMb
         ev4fwY0fK5yGW7H5aB4bhWGYzWowrYaHWhDgfwSGg2PLjoOHuaunl+SztzJjpYMQMQAf
         phKA==
X-Gm-Message-State: AOJu0YwdtUfkzI9LZdCHilu6lcz4Y31PPvgZgdZ8QOg7dPRVPfLaVYiC
	EtKEZcZ3zyxJiZCqMyMChyMAhuAiBEoNGYHVJRz/RF9cJ7WZ0dly
X-Google-Smtp-Source: AGHT+IENeTPn4CY7P8Z4GNVey20rB374YNBqiOzPH1Wo7h6vbnTx2fK0vOIu6LtQ2lqlONZrwZk/tg==
X-Received: by 2002:a17:902:c60a:b0:1d9:464b:68a5 with SMTP id r10-20020a170902c60a00b001d9464b68a5mr1548349plr.56.1706758119982;
        Wed, 31 Jan 2024 19:28:39 -0800 (PST)
Received: from ocxma-dut.. ([153.126.233.62])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001d8c8c903c0sm347852plb.149.2024.01.31.19.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:28:39 -0800 (PST)
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
Subject: [PATCH net-next v6 2/2] ice: Implement RSS settings for GTP using ethtool
Date: Thu,  1 Feb 2024 03:27:50 +0000
Message-Id: <20240201032748.1027121-2-hayatake396@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201032748.1027121-1-hayatake396@gmail.com>
References: <20240201032748.1027121-1-hayatake396@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the addition of new GTP RSS hash options to ethtool.h, this patch
implements the corresponding RSS settings for GTP packets in the Intel ice
driver. It enables users to configure RSS for GTP-U and GTP-C traffic over IPv4
and IPv6, utilizing the newly defined hash options.

The implementation covers the handling of gtpu(4|6), gtpc(4|6), gtpc(4|6)t,
gtpu(4|6)e, gtpu(4|6)u, and gtpu(4|6)d traffic, providing enhanced load
distribution for GTP traffic across multiple processing units.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
 .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
 drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
 4 files changed, 162 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 5038e54586af..934752f675ba 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -368,15 +368,28 @@ more options for Receive Side Scaling (RSS) hash byte configuration.
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
   And <option> is one or more of:
     s     Hash on the IP source address of the Rx packet.
     d     Hash on the IP destination address of the Rx packet.
     f     Hash on bytes 0 and 1 of the Layer 4 header of the Rx packet.
     n     Hash on bytes 2 and 3 of the Layer 4 header of the Rx packet.
+    e     Hash on GTP Packet on TEID (4bytes) of the Rx packet.
 
 
 Accelerated Receive Flow Steering (aRFS)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a19b06f18e40..d0e05032f464 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2486,6 +2486,24 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 	case SCTP_V4_FLOW:
 		hdrs |= ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4;
 		break;
+	case GTPU_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_V4_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_TEID_V4_FLOW:
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
@@ -2495,6 +2513,24 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 	case SCTP_V6_FLOW:
 		hdrs |= ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV6;
 		break;
+	case GTPU_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_V6_FLOW:
+		hdrs |= ICE_FLOW_SEG_HDR_GTPC | ICE_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_TEID_V6_FLOW:
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
@@ -2518,6 +2554,12 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
 		case TCP_V4_FLOW:
 		case UDP_V4_FLOW:
 		case SCTP_V4_FLOW:
+		case GTPU_V4_FLOW:
+		case GTPC_V4_FLOW:
+		case GTPC_TEID_V4_FLOW:
+		case GTPU_EH_V4_FLOW:
+		case GTPU_UL_V4_FLOW:
+		case GTPU_DL_V4_FLOW:
 			if (nfc->data & RXH_IP_SRC)
 				hfld |= ICE_FLOW_HASH_FLD_IPV4_SA;
 			if (nfc->data & RXH_IP_DST)
@@ -2526,6 +2568,12 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
 		case TCP_V6_FLOW:
 		case UDP_V6_FLOW:
 		case SCTP_V6_FLOW:
+		case GTPU_V6_FLOW:
+		case GTPC_V6_FLOW:
+		case GTPC_TEID_V6_FLOW:
+		case GTPU_EH_V6_FLOW:
+		case GTPU_UL_V6_FLOW:
+		case GTPU_DL_V6_FLOW:
 			if (nfc->data & RXH_IP_SRC)
 				hfld |= ICE_FLOW_HASH_FLD_IPV6_SA;
 			if (nfc->data & RXH_IP_DST)
@@ -2564,6 +2612,33 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc, bool symm)
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
 
@@ -2676,6 +2751,13 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
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
index ff82915ab497..2fd2e0cb483d 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -37,13 +37,13 @@
 #define ICE_HASH_SCTP_IPV4	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_SCTP_PORT)
 #define ICE_HASH_SCTP_IPV6	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_SCTP_PORT)
 
-#define ICE_FLOW_HASH_GTP_TEID \
+#define ICE_FLOW_HASH_GTP_C_TEID \
 	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID))
 
-#define ICE_FLOW_HASH_GTP_IPV4_TEID \
-	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_TEID)
-#define ICE_FLOW_HASH_GTP_IPV6_TEID \
-	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_TEID)
+#define ICE_FLOW_HASH_GTP_C_IPV4_TEID \
+	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_C_TEID)
+#define ICE_FLOW_HASH_GTP_C_IPV6_TEID \
+	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_C_TEID)
 
 #define ICE_FLOW_HASH_GTP_U_TEID \
 	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_IP_TEID))
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
 
@@ -242,6 +256,13 @@ enum ice_flow_field {
 #define ICE_FLOW_HASH_FLD_SCTP_DST_PORT	\
 	BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_DST_PORT)
 
+#define ICE_FLOW_HASH_FLD_GTPC_TEID	BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_IP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_IP_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_EH_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_EH_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_UP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_DWN_TEID \
+	BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID)
+
 /* Flow headers and fields for AVF support */
 enum ice_flow_avf_hdr_field {
 	/* Values 0 - 28 are reserved for future use */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9be724291ef8..3c4282019570 100644
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
+		ICE_FLOW_HASH_GTP_C_IPV4_TEID, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu4 with input set IPv4 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4,
+		ICE_FLOW_HASH_GTP_U_IPV4_TEID, ICE_RSS_OUTER_HEADERS, false},
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
+		ICE_FLOW_HASH_GTP_C_IPV6_TEID, ICE_RSS_OUTER_HEADERS, false},
+	/* configure RSS for gtpu6 with input set IPv6 src/dst */
+	{ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6,
+		ICE_FLOW_HASH_GTP_U_IPV6_TEID, ICE_RSS_OUTER_HEADERS, false},
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
-- 
2.34.1


