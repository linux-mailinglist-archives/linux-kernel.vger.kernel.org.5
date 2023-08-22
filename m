Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321578479B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbjHVQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjHVQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:30:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A057B137;
        Tue, 22 Aug 2023 09:30:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MEHlLv009054;
        Tue, 22 Aug 2023 16:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=5NbVFQoq5z6hfqu5DPiLi81vz+l/8/4qcBf+uDDEeic=;
 b=BdAhkL7Y1GbRVCc7X1sWGQgIxEF7U8AGhxCDGA1ZnoRjQi2SgHgDtvdBBqOzHwiNWQ7n
 Hnd6NGx8NPLPyCXREgGkCV1yFeis2qbMrCshseytQlRUUexJJE2zI00/vh8HIJvfW679
 Szbf7IrAtoUcPWDodwB1fyIt4Jsuanlrbo2++p+R284ZutYrnNqNTUV3GQY573o/ZGcc
 ZY+Q7ifatosjW55BOjzIQW3KV4uFbfafa1aBi4lCwuuTvAJvWrqV/M6UrWn1wfle4NhP
 5jyOg/lGtZMKhBODMkXNlTxiJhIISIP3v3MMJ0tn9y4l0lfPplTxrO/PkzEGQzeWaN5g MA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smreu19h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:30:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MGUKuU031793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:30:20 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 09:30:19 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Tue, 22 Aug 2023 09:30:17 -0700
Subject: [PATCH] wifi: Fix ieee80211.h kernel-doc issues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230822-kerneldoc-v1-1-0d42ce5029bf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJji5GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMj3ezUorzUnJT8ZF0jS4s0E2MTMwMLQyMloPqCotS0zAqwWdGxtbU
 AialF8VsAAAA=
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CEhUdMwiuCQThYarDK6Cu6CU2lS65GlK
X-Proofpoint-ORIG-GUID: CEhUdMwiuCQThYarDK6Cu6CU2lS65GlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc script identified multiple issues in ieee80211.h, so
fix them. In the process update some references to the latest
applicable specification.

include/linux/ieee80211.h:848: warning: Function parameter or member 'count' not described in 'ieee80211_quiet_ie'
include/linux/ieee80211.h:848: warning: Function parameter or member 'period' not described in 'ieee80211_quiet_ie'
include/linux/ieee80211.h:848: warning: Function parameter or member 'duration' not described in 'ieee80211_quiet_ie'
include/linux/ieee80211.h:848: warning: Function parameter or member 'offset' not described in 'ieee80211_quiet_ie'
include/linux/ieee80211.h:860: warning: Function parameter or member 'token' not described in 'ieee80211_msrment_ie'
include/linux/ieee80211.h:860: warning: Function parameter or member 'mode' not described in 'ieee80211_msrment_ie'
include/linux/ieee80211.h:860: warning: Function parameter or member 'type' not described in 'ieee80211_msrment_ie'
include/linux/ieee80211.h:860: warning: Function parameter or member 'request' not described in 'ieee80211_msrment_ie'
include/linux/ieee80211.h:871: warning: Function parameter or member 'mode' not described in 'ieee80211_channel_sw_ie'
include/linux/ieee80211.h:871: warning: Function parameter or member 'new_ch_num' not described in 'ieee80211_channel_sw_ie'
include/linux/ieee80211.h:871: warning: Function parameter or member 'count' not described in 'ieee80211_channel_sw_ie'
include/linux/ieee80211.h:883: warning: Function parameter or member 'mode' not described in 'ieee80211_ext_chansw_ie'
include/linux/ieee80211.h:883: warning: Function parameter or member 'new_operating_class' not described in 'ieee80211_ext_chansw_ie'
include/linux/ieee80211.h:883: warning: Function parameter or member 'new_ch_num' not described in 'ieee80211_ext_chansw_ie'
include/linux/ieee80211.h:883: warning: Function parameter or member 'count' not described in 'ieee80211_ext_chansw_ie'
include/linux/ieee80211.h:905: warning: Function parameter or member 'mesh_ttl' not described in 'ieee80211_mesh_chansw_params_ie'
include/linux/ieee80211.h:905: warning: Function parameter or member 'mesh_flags' not described in 'ieee80211_mesh_chansw_params_ie'
include/linux/ieee80211.h:905: warning: Function parameter or member 'mesh_reason' not described in 'ieee80211_mesh_chansw_params_ie'
include/linux/ieee80211.h:905: warning: Function parameter or member 'mesh_pre_value' not described in 'ieee80211_mesh_chansw_params_ie'
include/linux/ieee80211.h:913: warning: Function parameter or member 'new_channel_width' not described in 'ieee80211_wide_bw_chansw_ie'
include/linux/ieee80211.h:913: warning: Function parameter or member 'new_center_freq_seg0' not described in 'ieee80211_wide_bw_chansw_ie'
include/linux/ieee80211.h:913: warning: Function parameter or member 'new_center_freq_seg1' not described in 'ieee80211_wide_bw_chansw_ie'
include/linux/ieee80211.h:926: warning: expecting prototype for struct ieee80211_tim. Prototype was for struct ieee80211_tim_ie instead
include/linux/ieee80211.h:941: warning: Function parameter or member 'meshconf_psel' not described in 'ieee80211_meshconf_ie'
include/linux/ieee80211.h:941: warning: Function parameter or member 'meshconf_pmetric' not described in 'ieee80211_meshconf_ie'
include/linux/ieee80211.h:941: warning: Function parameter or member 'meshconf_congest' not described in 'ieee80211_meshconf_ie'
include/linux/ieee80211.h:941: warning: Function parameter or member 'meshconf_synch' not described in 'ieee80211_meshconf_ie'
include/linux/ieee80211.h:941: warning: Function parameter or member 'meshconf_auth' not described in 'ieee80211_meshconf_ie'
include/linux/ieee80211.h:941: warning: Function parameter or member 'meshconf_form' not described in 'ieee80211_meshconf_ie'
include/linux/ieee80211.h:941: warning: Function parameter or member 'meshconf_cap' not described in 'ieee80211_meshconf_ie'
include/linux/ieee80211.h:964: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * mesh channel switch parameters element's flag indicator
include/linux/ieee80211.h:984: warning: Function parameter or member 'rann_flags' not described in 'ieee80211_rann_ie'
include/linux/ieee80211.h:984: warning: Function parameter or member 'rann_hopcount' not described in 'ieee80211_rann_ie'
include/linux/ieee80211.h:984: warning: Function parameter or member 'rann_ttl' not described in 'ieee80211_rann_ie'
include/linux/ieee80211.h:984: warning: Function parameter or member 'rann_addr' not described in 'ieee80211_rann_ie'
include/linux/ieee80211.h:984: warning: Function parameter or member 'rann_seq' not described in 'ieee80211_rann_ie'
include/linux/ieee80211.h:984: warning: Function parameter or member 'rann_interval' not described in 'ieee80211_rann_ie'
include/linux/ieee80211.h:984: warning: Function parameter or member 'rann_metric' not described in 'ieee80211_rann_ie'
include/linux/ieee80211.h:1019: warning: expecting prototype for enum ieee80211_opmode_bits. Prototype was for enum ieee80211_vht_opmode_bits instead
include/linux/ieee80211.h:1052: warning: Function parameter or member 'tx_power' not described in 'ieee80211_tpc_report_ie'
include/linux/ieee80211.h:1052: warning: Function parameter or member 'link_margin' not described in 'ieee80211_tpc_report_ie'
include/linux/ieee80211.h:1073: warning: Function parameter or member 'compat_info' not described in 'ieee80211_s1g_bcn_compat_ie'
include/linux/ieee80211.h:1073: warning: Function parameter or member 'beacon_int' not described in 'ieee80211_s1g_bcn_compat_ie'
include/linux/ieee80211.h:1073: warning: Function parameter or member 'tsf_completion' not described in 'ieee80211_s1g_bcn_compat_ie'
include/linux/ieee80211.h:1086: warning: Function parameter or member 'ch_width' not described in 'ieee80211_s1g_oper_ie'
include/linux/ieee80211.h:1086: warning: Function parameter or member 'oper_class' not described in 'ieee80211_s1g_oper_ie'
include/linux/ieee80211.h:1086: warning: Function parameter or member 'primary_ch' not described in 'ieee80211_s1g_oper_ie'
include/linux/ieee80211.h:1086: warning: Function parameter or member 'oper_ch' not described in 'ieee80211_s1g_oper_ie'
include/linux/ieee80211.h:1086: warning: Function parameter or member 'basic_mcs_nss' not described in 'ieee80211_s1g_oper_ie'
include/linux/ieee80211.h:1097: warning: Function parameter or member 'aid' not described in 'ieee80211_aid_response_ie'
include/linux/ieee80211.h:1097: warning: Function parameter or member 'switch_count' not described in 'ieee80211_aid_response_ie'
include/linux/ieee80211.h:1097: warning: Function parameter or member 'response_int' not described in 'ieee80211_aid_response_ie'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_STATUS' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_MINOR_REASON' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_CAPABILITY' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_DEVICE_ID' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_GO_INTENT' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_GO_CONFIG_TIMEOUT' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_LISTEN_CHANNEL' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_GROUP_BSSID' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_EXT_LISTEN_TIMING' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_INTENDED_IFACE_ADDR' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_MANAGABILITY' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_CHANNEL_LIST' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_ABSENCE_NOTICE' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_DEVICE_INFO' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_GROUP_INFO' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_GROUP_ID' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_INTERFACE' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_OPER_CHANNEL' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_INVITE_FLAGS' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_VENDOR_SPECIFIC' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1519: warning: Enum value 'IEEE80211_P2P_ATTR_MAX' not described in enum 'ieee80211_p2p_attr_id'
include/linux/ieee80211.h:1554: warning: Function parameter or member 'frame_control' not described in 'ieee80211_bar'
include/linux/ieee80211.h:1554: warning: Function parameter or member 'duration' not described in 'ieee80211_bar'
include/linux/ieee80211.h:1554: warning: Function parameter or member 'ra' not described in 'ieee80211_bar'
include/linux/ieee80211.h:1554: warning: Function parameter or member 'ta' not described in 'ieee80211_bar'
include/linux/ieee80211.h:1554: warning: Function parameter or member 'control' not described in 'ieee80211_bar'
include/linux/ieee80211.h:1554: warning: Function parameter or member 'start_seq_num' not described in 'ieee80211_bar'
include/linux/ieee80211.h:1579: warning: Function parameter or member 'reserved' not described in 'ieee80211_mcs_info'
include/linux/ieee80211.h:1618: warning: Function parameter or member 'cap_info' not described in 'ieee80211_ht_cap'
include/linux/ieee80211.h:1618: warning: Function parameter or member 'ampdu_params_info' not described in 'ieee80211_ht_cap'
include/linux/ieee80211.h:1618: warning: Function parameter or member 'mcs' not described in 'ieee80211_ht_cap'
include/linux/ieee80211.h:1618: warning: Function parameter or member 'extended_ht_cap_info' not described in 'ieee80211_ht_cap'
include/linux/ieee80211.h:1618: warning: Function parameter or member 'tx_BF_cap_info' not described in 'ieee80211_ht_cap'
include/linux/ieee80211.h:1618: warning: Function parameter or member 'antenna_selection_info' not described in 'ieee80211_ht_cap'
include/linux/ieee80211.h:1704: warning: Function parameter or member 'primary_chan' not described in 'ieee80211_ht_operation'
include/linux/ieee80211.h:1704: warning: Function parameter or member 'ht_param' not described in 'ieee80211_ht_operation'
include/linux/ieee80211.h:1704: warning: Function parameter or member 'operation_mode' not described in 'ieee80211_ht_operation'
include/linux/ieee80211.h:1704: warning: Function parameter or member 'stbc_param' not described in 'ieee80211_ht_operation'
include/linux/ieee80211.h:1704: warning: Function parameter or member 'basic_set' not described in 'ieee80211_ht_operation'
include/linux/ieee80211.h:1872: warning: Function parameter or member 'mac_cap_info' not described in 'ieee80211_he_cap_elem'
include/linux/ieee80211.h:1872: warning: Function parameter or member 'phy_cap_info' not described in 'ieee80211_he_cap_elem'
include/linux/ieee80211.h:1936: warning: Function parameter or member 'he_oper_params' not described in 'ieee80211_he_operation'
include/linux/ieee80211.h:1936: warning: Function parameter or member 'he_mcs_nss_set' not described in 'ieee80211_he_operation'
include/linux/ieee80211.h:1936: warning: Function parameter or member 'optional' not described in 'ieee80211_he_operation'
include/linux/ieee80211.h:1948: warning: Function parameter or member 'he_sr_control' not described in 'ieee80211_he_spr'
include/linux/ieee80211.h:1948: warning: Function parameter or member 'optional' not described in 'ieee80211_he_spr'
include/linux/ieee80211.h:1960: warning: Function parameter or member 'aifsn' not described in 'ieee80211_he_mu_edca_param_ac_rec'
include/linux/ieee80211.h:1960: warning: Function parameter or member 'ecw_min_max' not described in 'ieee80211_he_mu_edca_param_ac_rec'
include/linux/ieee80211.h:1960: warning: Function parameter or member 'mu_edca_timer' not described in 'ieee80211_he_mu_edca_param_ac_rec'
include/linux/ieee80211.h:1974: warning: Function parameter or member 'mu_qos_info' not described in 'ieee80211_mu_edca_param_set'
include/linux/ieee80211.h:1974: warning: Function parameter or member 'ac_be' not described in 'ieee80211_mu_edca_param_set'
include/linux/ieee80211.h:1974: warning: Function parameter or member 'ac_bk' not described in 'ieee80211_mu_edca_param_set'
include/linux/ieee80211.h:1974: warning: Function parameter or member 'ac_vi' not described in 'ieee80211_mu_edca_param_set'
include/linux/ieee80211.h:1974: warning: Function parameter or member 'ac_vo' not described in 'ieee80211_mu_edca_param_set'
include/linux/ieee80211.h:2194: warning: Enum value 'IEEE80211_REG_LPI_AP' not described in enum 'ieee80211_ap_reg_power'
include/linux/ieee80211.h:2194: warning: Enum value 'IEEE80211_REG_SP_AP' not described in enum 'ieee80211_ap_reg_power'
include/linux/ieee80211.h:2194: warning: Enum value 'IEEE80211_REG_VLP_AP' not described in enum 'ieee80211_ap_reg_power'
include/linux/ieee80211.h:2194: warning: Excess enum value 'IEEE80211_REG_SP' description in 'ieee80211_ap_reg_power'
include/linux/ieee80211.h:2194: warning: Excess enum value 'IEEE80211_REG_VLP' description in 'ieee80211_ap_reg_power'
include/linux/ieee80211.h:2194: warning: Excess enum value 'IEEE80211_REG_LPI' description in 'ieee80211_ap_reg_power'
include/linux/ieee80211.h:2577: warning: cannot understand function prototype: 'struct ieee80211_he_6ghz_oper '
include/linux/ieee80211.h:2624: warning: Function parameter or member 'tx_power_info' not described in 'ieee80211_tx_pwr_env'
include/linux/ieee80211.h:2624: warning: Function parameter or member 'tx_power' not described in 'ieee80211_tx_pwr_env'
include/linux/ieee80211.h:4485: warning: expecting prototype for RSNX Capabilities(). Prototype was for WLAN_RSNX_CAPA_PROTECTED_TWT() instead
include/linux/ieee80211.h:4734: warning: expecting prototype for ieee80211_mle_get_eml_sync_delay(). Prototype was for ieee80211_mle_get_eml_med_sync_delay() instead
117 warnings as Errors

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/linux/ieee80211.h | 235 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 177 insertions(+), 58 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 4b998090898e..bd2f6e19c357 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -836,9 +836,14 @@ enum ieee80211_preq_target_flags {
 };
 
 /**
- * struct ieee80211_quiet_ie
+ * struct ieee80211_quiet_ie - Quiet element
+ * @count: Quiet Count
+ * @period: Quiet Period
+ * @duration: Quiet Duration
+ * @offset: Quiet Offset
  *
- * This structure refers to "Quiet information element"
+ * This structure represents the payload of the "Quiet element" as
+ * described in IEEE Std 802.11-2020 section 9.4.2.22.
  */
 struct ieee80211_quiet_ie {
 	u8 count;
@@ -848,9 +853,15 @@ struct ieee80211_quiet_ie {
 } __packed;
 
 /**
- * struct ieee80211_msrment_ie
+ * struct ieee80211_msrment_ie - Measurement element
+ * @token: Measurement Token
+ * @mode: Measurement Report Mode
+ * @type: Measurement Type
+ * @request: Measurement Request or Measurement Report
  *
- * This structure refers to "Measurement Request/Report information element"
+ * This structure represents the payload of both the "Measurement
+ * Request element" and the "Measurement Report element" as described
+ * in IEEE Std 802.11-2020 sections 9.4.2.20 and 9.4.2.21.
  */
 struct ieee80211_msrment_ie {
 	u8 token;
@@ -860,9 +871,14 @@ struct ieee80211_msrment_ie {
 } __packed;
 
 /**
- * struct ieee80211_channel_sw_ie
+ * struct ieee80211_channel_sw_ie - Channel Switch Announcement element
+ * @mode: Channel Switch Mode
+ * @new_ch_num: New Channel Number
+ * @count: Channel Switch Count
  *
- * This structure refers to "Channel Switch Announcement information element"
+ * This structure represents the payload of the "Channel Switch
+ * Announcement element" as described in IEEE Std 802.11-2020 section
+ * 9.4.2.18.
  */
 struct ieee80211_channel_sw_ie {
 	u8 mode;
@@ -871,9 +887,14 @@ struct ieee80211_channel_sw_ie {
 } __packed;
 
 /**
- * struct ieee80211_ext_chansw_ie
+ * struct ieee80211_ext_chansw_ie - Extended Channel Switch Announcement element
+ * @mode: Channel Switch Mode
+ * @new_operating_class: New Operating Class
+ * @new_ch_num: New Channel Number
+ * @count: Channel Switch Count
  *
- * This structure represents the "Extended Channel Switch Announcement element"
+ * This structure represents the "Extended Channel Switch Announcement
+ * element" as described in IEEE Std 802.11-2020 section 9.4.2.52.
  */
 struct ieee80211_ext_chansw_ie {
 	u8 mode;
@@ -894,8 +915,14 @@ struct ieee80211_sec_chan_offs_ie {
 
 /**
  * struct ieee80211_mesh_chansw_params_ie - mesh channel switch parameters IE
+ * @mesh_ttl: Time To Live
+ * @mesh_flags: Flags
+ * @mesh_reason: Reason Code
+ * @mesh_pre_value: Precedence Value
  *
- * This structure represents the "Mesh Channel Switch Paramters element"
+ * This structure represents the payload of the "Mesh Channel Switch
+ * Parameters element" as described in IEEE Std 802.11-2020 section
+ * 9.4.2.102.
  */
 struct ieee80211_mesh_chansw_params_ie {
 	u8 mesh_ttl;
@@ -906,6 +933,13 @@ struct ieee80211_mesh_chansw_params_ie {
 
 /**
  * struct ieee80211_wide_bw_chansw_ie - wide bandwidth channel switch IE
+ * @new_channel_width: New Channel Width
+ * @new_center_freq_seg0: New Channel Center Frequency Segment 0
+ * @new_center_freq_seg1: New Channel Center Frequency Segment 1
+ *
+ * This structure represents the payload of the "Wide Bandwidth
+ * Channel Switch element" as described in IEEE Std 802.11-2020
+ * section 9.4.2.160.
  */
 struct ieee80211_wide_bw_chansw_ie {
 	u8 new_channel_width;
@@ -913,9 +947,14 @@ struct ieee80211_wide_bw_chansw_ie {
 } __packed;
 
 /**
- * struct ieee80211_tim
+ * struct ieee80211_tim_ie - Traffic Indication Map information element
+ * @dtim_count: DTIM Count
+ * @dtim_period: DTIM Period
+ * @bitmap_ctrl: Bitmap Control
+ * @virtual_map: Partial Virtual Bitmap
  *
- * This structure refers to "Traffic Indication Map information element"
+ * This structure represents the payload of the "TIM element" as
+ * described in IEEE Std 802.11-2020 section 9.4.2.5.
  */
 struct ieee80211_tim_ie {
 	u8 dtim_count;
@@ -926,9 +965,17 @@ struct ieee80211_tim_ie {
 } __packed;
 
 /**
- * struct ieee80211_meshconf_ie
+ * struct ieee80211_meshconf_ie - Mesh Configuration element
+ * @meshconf_psel: Active Path Selection Protocol Identifier
+ * @meshconf_pmetric: Active Path Selection Metric Identifier
+ * @meshconf_congest: Congestion Control Mode Identifier
+ * @meshconf_synch: Synchronization Method Identifier
+ * @meshconf_auth: Authentication Protocol Identifier
+ * @meshconf_form: Mesh Formation Info
+ * @meshconf_cap: Mesh Capability (see &enum mesh_config_capab_flags)
  *
- * This structure refers to "Mesh Configuration information element"
+ * This structure represents the payload of the "Mesh Configuration
+ * element" as described in IEEE Std 802.11-2020 section 9.4.2.97.
  */
 struct ieee80211_meshconf_ie {
 	u8 meshconf_psel;
@@ -950,6 +997,9 @@ struct ieee80211_meshconf_ie {
  *	is ongoing
  * @IEEE80211_MESHCONF_CAPAB_POWER_SAVE_LEVEL: STA is in deep sleep mode or has
  *	neighbors in deep sleep mode
+ *
+ * Enumerates the "Mesh Capability" as described in IEEE Std
+ * 802.11-2020 section 9.4.2.97.7.
  */
 enum mesh_config_capab_flags {
 	IEEE80211_MESHCONF_CAPAB_ACCEPT_PLINKS		= 0x01,
@@ -960,7 +1010,7 @@ enum mesh_config_capab_flags {
 
 #define IEEE80211_MESHCONF_FORM_CONNECTED_TO_GATE 0x1
 
-/**
+/*
  * mesh channel switch parameters element's flag indicator
  *
  */
@@ -969,9 +1019,17 @@ enum mesh_config_capab_flags {
 #define WLAN_EID_CHAN_SWITCH_PARAM_REASON BIT(2)
 
 /**
- * struct ieee80211_rann_ie
+ * struct ieee80211_rann_ie - RANN (root announcement) element
+ * @rann_flags: Flags
+ * @rann_hopcount: Hop Count
+ * @rann_ttl: Element TTL
+ * @rann_addr: Root Mesh STA Address
+ * @rann_seq: HWMP Sequence Number
+ * @rann_interval: Interval
+ * @rann_metric: Metric
  *
- * This structure refers to "Root Announcement information element"
+ * This structure represents the payload of the "RANN element" as
+ * described in IEEE Std 802.11-2020 section 9.4.2.111.
  */
 struct ieee80211_rann_ie {
 	u8 rann_flags;
@@ -993,7 +1051,7 @@ enum ieee80211_ht_chanwidth_values {
 };
 
 /**
- * enum ieee80211_opmode_bits - VHT operating mode field bits
+ * enum ieee80211_vht_opmode_bits - VHT operating mode field bits
  * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK: channel width mask
  * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ: 20 MHz channel width
  * @IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ: 40 MHz channel width
@@ -1042,9 +1100,12 @@ enum ieee80211_s1g_chanwidth {
 #define WLAN_USER_POSITION_LEN 16
 
 /**
- * struct ieee80211_tpc_report_ie
+ * struct ieee80211_tpc_report_ie - TPC Report element
+ * @tx_power: Transmit Power
+ * @link_margin: Link Margin
  *
- * This structure refers to "TPC Report element"
+ * This structure represents the payload of the "TPC Report element" as
+ * described in IEEE Std 802.11-2020 section 9.4.2.16.
  */
 struct ieee80211_tpc_report_ie {
 	u8 tx_power;
@@ -1062,9 +1123,14 @@ struct ieee80211_addba_ext_ie {
 } __packed;
 
 /**
- * struct ieee80211_s1g_bcn_compat_ie
+ * struct ieee80211_s1g_bcn_compat_ie - S1G Beacon Compatibility element
+ * @compat_info: Compatibility Information
+ * @beacon_int: Beacon Interval
+ * @tsf_completion: TSF Completion
  *
- * S1G Beacon Compatibility element
+ * This structure represents the payload of the "S1G Beacon
+ * Compatibility element" as described in IEEE Std 802.11-2020 section
+ * 9.4.2.196.
  */
 struct ieee80211_s1g_bcn_compat_ie {
 	__le16 compat_info;
@@ -1073,9 +1139,15 @@ struct ieee80211_s1g_bcn_compat_ie {
 } __packed;
 
 /**
- * struct ieee80211_s1g_oper_ie
+ * struct ieee80211_s1g_oper_ie - S1G Operation element
+ * @ch_width: S1G Operation Information Channel Width
+ * @oper_class: S1G Operation Information Operating Class
+ * @primary_ch: S1G Operation Information Primary Channel Number
+ * @oper_ch: S1G Operation Information  Channel Center Frequency
+ * @basic_mcs_nss: Basic S1G-MCS and NSS Set
  *
- * S1G Operation element
+ * This structure represents the payload of the "S1G Operation
+ * element" as described in IEEE Std 802.11-2020 section 9.4.2.212.
  */
 struct ieee80211_s1g_oper_ie {
 	u8 ch_width;
@@ -1086,9 +1158,13 @@ struct ieee80211_s1g_oper_ie {
 } __packed;
 
 /**
- * struct ieee80211_aid_response_ie
+ * struct ieee80211_aid_response_ie - AID Response element
+ * @aid: AID/Group AID
+ * @switch_count: AID Switch Count
+ * @response_int: AID Response Interval
  *
- * AID Response element
+ * This structure represents the payload of the "AID Response element"
+ * as described in IEEE Std 802.11-2020 section 9.4.2.194.
  */
 struct ieee80211_aid_response_ie {
 	__le16 aid;
@@ -1489,7 +1565,7 @@ struct ieee80211_tdls_data {
 /*
  * Peer-to-Peer IE attribute related definitions.
  */
-/**
+/*
  * enum ieee80211_p2p_attr_id - identifies type of peer-to-peer attribute.
  */
 enum ieee80211_p2p_attr_id {
@@ -1539,11 +1615,17 @@ struct ieee80211_p2p_noa_attr {
 #define IEEE80211_P2P_OPPPS_CTWINDOW_MASK	0x7F
 
 /**
- * struct ieee80211_bar - HT Block Ack Request
+ * struct ieee80211_bar - Block Ack Request frame format
+ * @frame_control: Frame Control
+ * @duration: Duration
+ * @ra: RA
+ * @ta: TA
+ * @control: BAR Control
+ * @start_seq_num: Starting Sequence Number (see Figure 9-37)
  *
- * This structure refers to "HT BlockAckReq" as
- * described in 802.11n draft section 7.2.1.7.1
- */
+ * This structure represents the "BlockAckReq frame format"
+ * as described in IEEE Std 802.11-2020 section 9.3.1.7.
+*/
 struct ieee80211_bar {
 	__le16 frame_control;
 	__le16 duration;
@@ -1563,13 +1645,17 @@ struct ieee80211_bar {
 #define IEEE80211_HT_MCS_MASK_LEN		10
 
 /**
- * struct ieee80211_mcs_info - MCS information
+ * struct ieee80211_mcs_info - Supported MCS Set field
  * @rx_mask: RX mask
  * @rx_highest: highest supported RX rate. If set represents
  *	the highest supported RX data rate in units of 1 Mbps.
  *	If this field is 0 this value should not be used to
  *	consider the highest RX data rate supported.
  * @tx_params: TX parameters
+ * @reserved: Reserved bits
+ *
+ * This structure represents the "Supported MCS Set field" as
+ * described in IEEE Std 802.11-2020 section 9.4.2.55.4.
  */
 struct ieee80211_mcs_info {
 	u8 rx_mask[IEEE80211_HT_MCS_MASK_LEN];
@@ -1600,10 +1686,16 @@ struct ieee80211_mcs_info {
 	(IEEE80211_HT_MCS_UNEQUAL_MODULATION_START / 8)
 
 /**
- * struct ieee80211_ht_cap - HT capabilities
+ * struct ieee80211_ht_cap - HT capabilities element
+ * @cap_info: HT Capability Information
+ * @ampdu_params_info: A-MPDU Parameters
+ * @mcs: Supported MCS Set
+ * @extended_ht_cap_info: HT Extended Capabilities
+ * @tx_BF_cap_info: Transmit Beamforming Capabilities
+ * @antenna_selection_info: ASEL Capability
  *
- * This structure is the "HT capabilities element" as
- * described in 802.11n D5.0 7.3.2.57
+ * This structure represents the payload of the "HT Capabilities
+ * element" as described in IEEE Std 802.11-2020 section 9.4.2.55.
  */
 struct ieee80211_ht_cap {
 	__le16 cap_info;
@@ -1691,9 +1783,14 @@ enum ieee80211_min_mpdu_spacing {
 
 /**
  * struct ieee80211_ht_operation - HT operation IE
+ * @primary_chan: Primary Channel
+ * @ht_param: HT Operation Information parameters
+ * @operation_mode: HT Operation Information operation mode
+ * @stbc_param: HT Operation Information STBC params
+ * @basic_set: Basic HT-MCS Set
  *
- * This structure is the "HT operation element" as
- * described in 802.11n-2009 7.3.2.57
+ * This structure represents the payload of the "HT Operation
+ * element" as described in IEEE Std 802.11-2020 section 9.4.2.56.
  */
 struct ieee80211_ht_operation {
 	u8 primary_chan;
@@ -1862,9 +1959,12 @@ struct ieee80211_vht_operation {
 
 /**
  * struct ieee80211_he_cap_elem - HE capabilities element
+ * @mac_cap_info: HE MAC Capabilities Information
+ * @phy_cap_info: HE PHY Capabilities Information
  *
- * This structure is the "HE capabilities element" fixed fields as
- * described in P802.11ax_D4.0 section 9.4.2.242.2 and 9.4.2.242.3
+ * This structure represents the fixed fields of the payload of the
+ * "HE capabilities element" as described in IEEE Std 802.11ax-2021
+ * sections 9.4.2.248.2 and 9.4.2.248.3.
  */
 struct ieee80211_he_cap_elem {
 	u8 mac_cap_info[6];
@@ -1923,35 +2023,45 @@ struct ieee80211_he_mcs_nss_supp {
 } __packed;
 
 /**
- * struct ieee80211_he_operation - HE capabilities element
+ * struct ieee80211_he_operation - HE Operation element
+ * @he_oper_params: HE Operation Parameters + BSS Color Information
+ * @he_mcs_nss_set: Basic HE-MCS And NSS Set
+ * @optional: Optional fields VHT Operation Information, Max Co-Hosted
+ *            BSSID Indicator, and 6 GHz Operation Information
  *
- * This structure is the "HE operation element" fields as
- * described in P802.11ax_D4.0 section 9.4.2.243
+ * This structure represents the payload of the "HE Operation
+ * element" as described in IEEE Std 802.11ax-2021 section 9.4.2.249.
  */
 struct ieee80211_he_operation {
 	__le32 he_oper_params;
 	__le16 he_mcs_nss_set;
-	/* Optional 0,1,3,4,5,7 or 8 bytes: depends on @he_oper_params */
 	u8 optional[];
 } __packed;
 
 /**
- * struct ieee80211_he_spr - HE spatial reuse element
+ * struct ieee80211_he_spr - Spatial Reuse Parameter Set element
+ * @he_sr_control: SR Control
+ * @optional: Optional fields Non-SRG OBSS PD Max Offset, SRG OBSS PD
+ *            Min Offset, SRG OBSS PD Max Offset, SRG BSS Color
+ *            Bitmap, and SRG Partial BSSID Bitmap
  *
- * This structure is the "HE spatial reuse element" element as
- * described in P802.11ax_D4.0 section 9.4.2.241
+ * This structure represents the payload of the "Spatial Reuse
+ * Parameter Set element" as described in IEEE Std 802.11ax-2021
+ * section 9.4.2.252.
  */
 struct ieee80211_he_spr {
 	u8 he_sr_control;
-	/* Optional 0 to 19 bytes: depends on @he_sr_control */
 	u8 optional[];
 } __packed;
 
 /**
  * struct ieee80211_he_mu_edca_param_ac_rec - MU AC Parameter Record field
+ * @aifsn: ACI/AIFSN
+ * @ecw_min_max: ECWmin/ECWmax
+ * @mu_edca_timer: MU EDCA Timer
  *
- * This structure is the "MU AC Parameter Record" fields as
- * described in P802.11ax_D4.0 section 9.4.2.245
+ * This structure represents the "MU AC Parameter Record" as described
+ * in IEEE Std 802.11ax-2021 section 9.4.2.251, Figure 9-788p.
  */
 struct ieee80211_he_mu_edca_param_ac_rec {
 	u8 aifsn;
@@ -1961,9 +2071,14 @@ struct ieee80211_he_mu_edca_param_ac_rec {
 
 /**
  * struct ieee80211_mu_edca_param_set - MU EDCA Parameter Set element
+ * @mu_qos_info: QoS Info
+ * @ac_be: MU AC_BE Parameter Record
+ * @ac_bk: MU AC_BK Parameter Record
+ * @ac_vi: MU AC_VI Parameter Record
+ * @ac_vo: MU AC_VO Parameter Record
  *
- * This structure is the "MU EDCA Parameter Set element" fields as
- * described in P802.11ax_D4.0 section 9.4.2.245
+ * This structure represents the payload of the "MU EDCA Parameter Set
+ * element" as described in IEEE Std 802.11ax-2021 section 9.4.2.251.
  */
 struct ieee80211_mu_edca_param_set {
 	u8 mu_qos_info;
@@ -2177,9 +2292,9 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
  * enum ieee80211_ap_reg_power - regulatory power for a Access Point
  *
  * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
- * @IEEE80211_REG_LPI: Indoor Access Point
- * @IEEE80211_REG_SP: Standard power Access Point
- * @IEEE80211_REG_VLP: Very low power Access Point
+ * @IEEE80211_REG_LPI_AP: Indoor Access Point
+ * @IEEE80211_REG_SP_AP: Standard power Access Point
+ * @IEEE80211_REG_VLP_AP: Very low power Access Point
  * @IEEE80211_REG_AP_POWER_AFTER_LAST: internal
  * @IEEE80211_REG_AP_POWER_MAX: maximum value
  */
@@ -2567,7 +2682,7 @@ static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
 #define IEEE80211_6GHZ_CTRL_REG_SP_AP	1
 
 /**
- * ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
+ * struct ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
  * @primary: primary channel
  * @control: control flags
  * @ccfs0: channel center frequency segment 0
@@ -2614,9 +2729,13 @@ enum ieee80211_tx_power_intrpt_type {
 };
 
 /**
- * struct ieee80211_tx_pwr_env
+ * struct ieee80211_tx_pwr_env - Transmit Power Envelope
+ * @tx_power_info: Transmit Power Information field
+ * @tx_power: Maximum Transmit Power field
  *
- * This structure represents the "Transmit Power Envelope element"
+ * This structure represents the payload of the "Transmit Power
+ * Envelope element" as described in IEEE Std 802.11ax-2021 section
+ * 9.4.2.161
  */
 struct ieee80211_tx_pwr_env {
 	u8 tx_power_info;
@@ -4478,7 +4597,7 @@ static inline bool for_each_element_completed(const struct element *element,
 	return (const u8 *)element == (const u8 *)data + datalen;
 }
 
-/**
+/*
  * RSNX Capabilities:
  * bits 0-3: Field length (n-1)
  */
@@ -4721,7 +4840,7 @@ ieee80211_mle_get_bss_param_ch_cnt(const struct ieee80211_multi_link_elem *mle)
 }
 
 /**
- * ieee80211_mle_get_eml_sync_delay - returns the medium sync delay
+ * ieee80211_mle_get_eml_med_sync_delay - returns the medium sync delay
  * @data: pointer to the multi link EHT IE
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,

---
base-commit: 1ad27e0f35db54b6804b8b2dbbe7e35eb4bbe67f
change-id: 20230822-kerneldoc-298f43460812

