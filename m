Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810FA7BCCC2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjJHGgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:36:12 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E01D8;
        Sat,  7 Oct 2023 23:36:10 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59f6041395dso43622857b3.1;
        Sat, 07 Oct 2023 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696746969; x=1697351769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZcY7LYYHgfRnAS6/MqMsfJ+TF7feUNbMBV189+9vhw=;
        b=lQf8pOqqkS4ogvG3Gp+spCu/gpuKlECHRalNJsJZaAopomI9pCJjj7zOAXfibmsAcB
         k9C8xFsxaNG/rMKMjIoHkz2XnE9HZv7kJVm3Hhm2qUYcm1u/8zqlf9YpmfCPoB5cXbmU
         LJcRVn0J5ZCbQXnKlaR6Kkx2I9bugr8sjfCkv1XSawcNqC9u/1T5uVPgWE4BRbP3OpWZ
         WNpCz1cOmr8CHK/h/O/IixUWVohOYT76CG+z87CqQ+uZPhpeLEZ4zvgyMLVxiE2pvejf
         qxtpyTHoplHlXPmY1RZGGWu3YzFP0wPNalyw9BlSI7bsQvI3NLGeYEiX60FUX9Y9xamE
         hvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696746969; x=1697351769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZcY7LYYHgfRnAS6/MqMsfJ+TF7feUNbMBV189+9vhw=;
        b=Iezgk/GmJDawQSbsjvS2+U8ni1EjyI3L+MC7c6dczDGrCRwNwtTAHyRBqzAcWQ67fA
         rlKEuGuj9OUv21QD6JEv+WQhG8mvggR9Ft2jM4rxlzJRJwJFahbb0gFJRIRR5UjC15V6
         bwY8/ep9C6tbtEJob4gyHZUNylcoTuwnP3tskaiAY+FJVHN7bnG6yiKCwmO/jmic694m
         Ct1J44ZqQElhGTqqDAZ6R8DDFvB/X7Y3JSkySxdXOr8HcPpNZGU1VTNU3ZRuJmGYJsrA
         7ySOHOfGLYQa79Jj0f2yLiFTJeDs4NRYnm2emxQXrWtFODN59QTGWTvOtbEisfrPC33a
         oSFg==
X-Gm-Message-State: AOJu0YwidSgU/2nlSWCjngL0unpDaTtQQQ1UCjXTqd4u99/qvhP4pi0U
        Z/EGjrRZi7KmTs6OVA0O6ng=
X-Google-Smtp-Source: AGHT+IE+oXMPVuBZmST15ZL+Vl9YSp/yrk8QAaLaSC7UDJUPbeoCczAYRb5b2LLP6zEEAQ+7h2W7zw==
X-Received: by 2002:a81:7cd6:0:b0:59b:6c4:b822 with SMTP id x205-20020a817cd6000000b0059b06c4b822mr13517377ywc.36.1696746968956;
        Sat, 07 Oct 2023 23:36:08 -0700 (PDT)
Received: from ocxma-dut.. ([153.126.233.61])
        by smtp.gmail.com with ESMTPSA id y76-20020a0dd64f000000b0058c668e46cbsm2661460ywd.46.2023.10.07.23.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:36:08 -0700 (PDT)
From:   Takeru Hayasaka <hayatake396@gmail.com>
X-Google-Original-From: Takeru Hayasaka <t-hayasaka@bbsakura.net>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Takeru Hayasaka <hayatake396@gmail.com>,
        Takeru Hayasaka <t-hayasaka@bbsakura.net>
Subject: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP from ethtool
Date:   Sun,  8 Oct 2023 06:36:01 +0000
Message-Id: <20231008063601.61674-1-t-hayasaka@bbsakura.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeru Hayasaka <hayatake396@gmail.com>

This is a patch that enables RSS functionality for GTP packets using
ethtool.
A user can include her TEID and make RSS work for GTP-U over IPv4 by
doing the following:
`ethtool -N ens3 rx-flow-hash gtpu4 sd`
In addition to gtpu(4|6), we now support gtpc(4|6), gtpu(4|6)e,
gtpu(4|6)u, and gtpu(4|6)d.

Signed-off-by: Takeru Hayasaka <t-hayasaka@bbsakura.net>
---
Hi mentainers.

I wrote a patch to enable RSS for GTP-U/C (+Exthdr) using ethtool.
This is an advantage for users who use Linux on mobile networks.

Here is the ethtool patch
cf. https://lore.kernel.org/netdev/20231008063041.61709-1-t-hayasaka@bbsakura.net/T/#u

Thank you.

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 98 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_flow.h    | 15 +++
 drivers/net/ethernet/intel/ice/ice_lib.c     | 70 ++++++++++++++
 include/uapi/linux/ethtool.h                 | 10 ++
 4 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ad4d4702129f..a5ee6638bc60 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2404,6 +2404,21 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
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
@@ -2413,9 +2428,25 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
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
+
 	return hdrs;
 }
 
@@ -2431,6 +2462,12 @@ static u32 ice_parse_hdrs(struct ethtool_rxnfc *nfc)
 	BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_SRC_PORT)
 #define ICE_FLOW_HASH_FLD_SCTP_DST_PORT	\
 	BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_DST_PORT)
+#define ICE_FLOW_HASH_FLD_GTPC_TEID	BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_IP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_IP_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_EH_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_EH_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_EH_QFI BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_EH_QFI)
+#define ICE_FLOW_HASH_FLD_GTPU_UP_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID)
+#define ICE_FLOW_HASH_FLD_GTPU_DWN_TEID BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID)
 
 /**
  * ice_parse_hash_flds - parses hash fields from RSS hash input
@@ -2448,6 +2485,11 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc)
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
@@ -2456,6 +2498,11 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc)
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
@@ -2489,11 +2536,50 @@ static u64 ice_parse_hash_flds(struct ethtool_rxnfc *nfc)
 			if (nfc->data & RXH_L4_B_2_3)
 				hfld |= ICE_FLOW_HASH_FLD_SCTP_DST_PORT;
 			break;
+		case GTPU_V4_FLOW:
+		case GTPU_V6_FLOW:
+		case GTPU_EH_V4_FLOW:
+		case GTPU_EH_V6_FLOW:
+		case GTPU_UL_V4_FLOW:
+		case GTPU_UL_V6_FLOW:
+		case GTPU_DL_V4_FLOW:
+		case GTPU_DL_V6_FLOW:
+			if (nfc->data & RXH_L4_B_0_1)
+				hfld |= ICE_FLOW_HASH_FLD_TCP_SRC_PORT |
+						ICE_FLOW_HASH_FLD_UDP_SRC_PORT;
+			if (nfc->data & RXH_L4_B_2_3)
+				hfld |= ICE_FLOW_HASH_FLD_TCP_DST_PORT |
+						ICE_FLOW_HASH_FLD_UDP_DST_PORT;
+			break;
 		default:
 			break;
 		}
 	}
 
+	switch (nfc->flow_type) {
+	case GTPC_V4_FLOW:
+	case GTPC_V6_FLOW:
+		hfld |= ICE_FLOW_HASH_FLD_GTPC_TEID;
+		break;
+	case GTPU_V4_FLOW:
+	case GTPU_V6_FLOW:
+		hfld |= ICE_FLOW_HASH_FLD_GTPU_IP_TEID;
+		break;
+	case GTPU_EH_V4_FLOW:
+	case GTPU_EH_V6_FLOW:
+		hfld |= ICE_FLOW_HASH_FLD_GTPU_EH_TEID;
+		break;
+	case GTPU_UL_V4_FLOW:
+	case GTPU_UL_V6_FLOW:
+		hfld |= ICE_FLOW_HASH_FLD_GTPU_UP_TEID;
+		break;
+	case GTPU_DL_V4_FLOW:
+	case GTPU_DL_V6_FLOW:
+		hfld |= ICE_FLOW_HASH_FLD_GTPU_DWN_TEID;
+		break;
+	default:
+		break;
+	}
 	return hfld;
 }
 
@@ -2590,12 +2676,20 @@ ice_get_rss_hash_opt(struct ice_vsi *vsi, struct ethtool_rxnfc *nfc)
 
 	if (hash_flds & ICE_FLOW_HASH_FLD_TCP_SRC_PORT ||
 	    hash_flds & ICE_FLOW_HASH_FLD_UDP_SRC_PORT ||
-	    hash_flds & ICE_FLOW_HASH_FLD_SCTP_SRC_PORT)
+	    hash_flds & ICE_FLOW_HASH_FLD_SCTP_SRC_PORT ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_IP_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_EH_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
 		nfc->data |= (u64)RXH_L4_B_0_1;
 
 	if (hash_flds & ICE_FLOW_HASH_FLD_TCP_DST_PORT ||
 	    hash_flds & ICE_FLOW_HASH_FLD_UDP_DST_PORT ||
-	    hash_flds & ICE_FLOW_HASH_FLD_SCTP_DST_PORT)
+	    hash_flds & ICE_FLOW_HASH_FLD_SCTP_DST_PORT ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_IP_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_EH_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_UP_TEID ||
+		hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
 		nfc->data |= (u64)RXH_L4_B_2_3;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index b465d27d9b80..7ddf6ce994e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -64,6 +64,21 @@
 	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_EH_TEID | \
 	 ICE_FLOW_HASH_GTP_U_EH_QFI)
 
+#define ICE_FLOW_HASH_GTP_U_UP_TEID \
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_UP_TEID))
+#define ICE_FLOW_HASH_GTP_U_DWN_TEID \
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID))
+
+#define ICE_FLOW_HASH_GTP_U_IPV4_UP \
+	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_UP_TEID)
+#define ICE_FLOW_HASH_GTP_U_IPV6_UP \
+	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_UP_TEID)
+
+#define ICE_FLOW_HASH_GTP_U_IPV4_DWN \
+	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_U_DWN_TEID)
+#define ICE_FLOW_HASH_GTP_U_IPV6_DWN \
+	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_U_DWN_TEID)
+
 #define ICE_FLOW_HASH_PPPOE_SESS_ID \
 	(BIT_ULL(ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID))
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 201570cd2e0b..a9664b48eddb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1667,6 +1667,41 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 		dev_dbg(dev, "ice_add_rss_cfg failed for sctp4 flow, vsi = %d, error = %d\n",
 			vsi_num, status);
 
+	/* configure RSS for gtpc4 with input set IPv4 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_IPV4_TEID,
+				 ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV4);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc4 flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu4 with input set IPv4 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV4_TEID,
+				 ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV4);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu4 flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu4e with input set IPv4 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV4_EH,
+				 ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV4);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu4e flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu4u with input set IPv4 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV4_UP,
+				 ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV4);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu4u flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu4d with input set IPv4 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV4_DWN,
+				 ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV4);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu4d flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
 	/* configure RSS for tcp6 with input set IPv6 src/dst, TCP src/dst */
 	status = ice_add_rss_cfg(hw, vsi_handle, ICE_HASH_TCP_IPV6,
 				 ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV6);
@@ -1688,6 +1723,41 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 		dev_dbg(dev, "ice_add_rss_cfg failed for sctp6 flow, vsi = %d, error = %d\n",
 			vsi_num, status);
 
+	/* configure RSS for gtpc6 with input set IPv6 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_IPV6_TEID,
+				 ICE_FLOW_SEG_HDR_GTPC_TEID | ICE_FLOW_SEG_HDR_IPV6);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpc6 flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu6 with input set IPv6 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV6_TEID,
+				 ICE_FLOW_SEG_HDR_GTPU_IP | ICE_FLOW_SEG_HDR_IPV6);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu4 flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu6e with input set IPv6 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV6_EH,
+				 ICE_FLOW_SEG_HDR_GTPU_EH | ICE_FLOW_SEG_HDR_IPV6);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu6e flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu6u with input set IPv6 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV6_UP,
+				 ICE_FLOW_SEG_HDR_GTPU_UP | ICE_FLOW_SEG_HDR_IPV6);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu6u flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
+	/* configure RSS for gtpu6d with input set IPv6 src/dst */
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_GTP_U_IPV6_DWN,
+				 ICE_FLOW_SEG_HDR_GTPU_DWN | ICE_FLOW_SEG_HDR_IPV6);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for gtpu4d flow, vsi = %d, error = %d\n",
+			vsi_num, status);
+
 	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_ESP_SPI,
 				 ICE_FLOW_SEG_HDR_ESP);
 	if (status)
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..f3af2a78f7dd 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2011,6 +2011,16 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+#define GTPU_V4_FLOW 0x13	/* hash only */
+#define GTPU_V6_FLOW 0x14	/* hash only */
+#define GTPC_V4_FLOW 0x15	/* hash only */
+#define GTPC_V6_FLOW 0x16	/* hash only */
+#define GTPU_EH_V4_FLOW 0x17	/* hash only */
+#define GTPU_EH_V6_FLOW 0x18	/* hash only */
+#define GTPU_UL_V4_FLOW 0x19	/* hash only */
+#define GTPU_UL_V6_FLOW 0x20	/* hash only */
+#define GTPU_DL_V4_FLOW 0x21	/* hash only */
+#define GTPU_DL_V6_FLOW 0x22	/* hash only */
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
-- 
2.34.1

