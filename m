Return-Path: <linux-kernel+bounces-125389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F514892544
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDB4285D93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A313CC7A;
	Fri, 29 Mar 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MqWRDyHZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4613B58D;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744055; cv=none; b=QElk8gh858jXIFAdKlEuEgd3eVX56pPJAdglEopJNNxzYbipooWiEv/PqjqSKNJX7szBg5463RkjYuMIFLmSN/Ou9uBmDynlcHfx5AEJlfKRK/mNw9W6L/c+/rBZAmUHwMVBUaIgX3bU2iUOnez4WR515OkHk62fiWwPWHXHpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744055; c=relaxed/simple;
	bh=StGoq54zznjDZKc/Pf7ZGEHHjSofq9BwKnoDbg71mHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eJtor+Q17vwPqmCIL02xw4u+Bi4wBHT87v9P/pqgBhmxl6pYTgQ81YAkfLIAUT8j48XiaB+ioD/9r1+RKDvViIi2473m2kagM47cxHL3dDLLi14FIMuwk/FIbu7QyxSo1o5JvCc2ZVe5smktXLdG7KyQLfqFSaQASJvJOlWUPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MqWRDyHZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TIpHY4010213;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=sXcof/W6pLniDYlgtOd09vD4vb8NPmLp0ZyN24gIjo8
	=; b=MqWRDyHZwMIJZ0kLPPl52i6v0DHRqnHncfSw5/W4sxK6MlH+8QtxFXROHG0
	mr0V2eCmeiT6mM10v+MmDedAffgLKny5H30YaaqejZl7RBcqZfM6RVjtJQtNY+Mw
	Aseq2Nt3TMm3dKjSVPSGEt1K487uZxLoQROvJt3DDkJ64y7TDmxgb8Nx8cEk0QjP
	ml11lNWxp029LFKIq4C8LlU6Svxt9upq/TO2LEfuq9Vtw2s3XfEN4ERjSywlqRBq
	zH8bW3tomi/NX1Am8UzpSxezqR6s3ssW49WqbVKbJJbT22ki72BCzOBUOYfOTvBC
	WO4X+kQOP4FuUmJpLgG6AJ+PEsQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g11ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 20:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJm5020691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 13:27:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:18 -0700
Subject: [PATCH 2/2] wifi: mac80211: Add missing return value documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-mac80211-kdoc-retval-v1-2-5e4d1ad6c250@quicinc.com>
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-ORIG-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290183

kernel-doc is reporting some warnings, so fix them:

% scripts/kernel-doc -Wall -Werror -none include/net/mac80211.h
include/net/mac80211.h:2056: warning: No description found for return value of 'wdev_to_ieee80211_vif'
include/net/mac80211.h:2066: warning: No description found for return value of 'ieee80211_vif_to_wdev'
include/net/mac80211.h:5603: warning: No description found for return value of 'ieee80211_beacon_cntdwn_is_complete'
include/net/mac80211.h:5968: warning: No description found for return value of 'ieee80211_gtk_rekey_add'
include/net/mac80211.h:6350: warning: No description found for return value of 'ieee80211_find_sta_by_link_addrs'
include/net/mac80211.h:6478: warning: No description found for return value of 'ieee80211_txq_airtime_check'
include/net/mac80211.h:6981: warning: No description found for return value of 'rate_control_set_rates'
include/net/mac80211.h:7142: warning: No description found for return value of 'ieee80211_tx_prepare_skb'
include/net/mac80211.h:7156: warning: No description found for return value of 'ieee80211_parse_tx_radiotap'
include/net/mac80211.h:7277: warning: No description found for return value of 'ieee80211_tx_dequeue'
include/net/mac80211.h:7292: warning: No description found for return value of 'ieee80211_tx_dequeue_ni'
include/net/mac80211.h:7324: warning: No description found for return value of 'ieee80211_next_txq'
include/net/mac80211.h:7405: warning: No description found for return value of 'ieee80211_txq_may_transmit'
include/net/mac80211.h:7466: warning: No description found for return value of 'ieee80211_calc_rx_airtime'
include/net/mac80211.h:7480: warning: No description found for return value of 'ieee80211_calc_tx_airtime'
include/net/mac80211.h:7528: warning: No description found for return value of 'ieee80211_is_tx_data'
include/net/mac80211.h:7562: warning: No description found for return value of 'ieee80211_set_active_links'
17 warnings as Errors

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e6a11a982ca8..8984ac4359b8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2049,7 +2049,7 @@ static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that get a wdev.
  *
- * Note that this function may return %NULL if the given wdev isn't
+ * Return: pointer to the wdev, or %NULL if the given wdev isn't
  * associated with a vif that the driver knows about (e.g. monitor
  * or AP_VLAN interfaces.)
  */
@@ -2062,6 +2062,8 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that needs to get the wdev for a vif.
  * This can also be useful to get the netdev associated to a vif.
+ *
+ * Return: pointer to the wdev
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
 
@@ -5597,7 +5599,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id);
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @link_id: valid link_id during MLO or 0 for non-MLO
  *
- * This function returns whether the countdown reached zero.
+ * Return: %true if the countdown reached 1, %false otherwise
  */
 bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
 					 unsigned int link_id);
@@ -5942,8 +5944,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
  * key(s) will be available. These will be needed by mac80211 for proper
  * RX processing, so this function allows setting them.
  *
- * The function returns the newly allocated key structure, which will
- * have similar contents to the passed key configuration but point to
+ * Return: the newly allocated key structure, which will have
+ * similar contents to the passed key configuration but point to
  * mac80211-owned memory. In case of errors, the function returns an
  * ERR_PTR(), use IS_ERR() etc.
  *
@@ -6342,6 +6344,8 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(struct ieee80211_hw *hw,
  *	may be %NULL if the link ID is not needed
  *
  * Obtain the STA by link address, must use RCU protection.
+ *
+ * Return: pointer to STA if found, otherwise %NULL.
  */
 struct ieee80211_sta *
 ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
@@ -6471,8 +6475,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
  * @hw: pointer obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
  *
- * Return true if the AQL's airtime limit has not been reached and the txq can
- * continue to send more packets to the device. Otherwise return false.
+ * Return: %true if the AQL's airtime limit has not been reached and the txq can
+ * continue to send more packets to the device. Otherwise return %false.
  */
 bool
 ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
@@ -6975,6 +6979,8 @@ bool rate_usable_index_exists(struct ieee80211_supported_band *sband,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @pubsta: &struct ieee80211_sta pointer to the target destination.
  * @rates: new tx rate set to be used for this station.
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int rate_control_set_rates(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *pubsta,
@@ -7135,6 +7141,8 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
@@ -7151,6 +7159,8 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
  *
  * @skb: packet injected by userspace
  * @dev: the &struct device of this 802.11 device
+ *
+ * Return: %true if the radiotap header was parsed, %false otherwise
  */
 bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				 struct net_device *dev);
@@ -7260,7 +7270,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *sta, u8 tid);
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
  *
- * Returns the skb if successful, %NULL if no frame was available.
+ * Return: the skb if successful, %NULL if no frame was available.
  *
  * Note that this must be called in an rcu_read_lock() critical section,
  * which can only be released after the SKB was handled. Some pointers in
@@ -7286,6 +7296,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
+ *
+ * Return: the skb if successful, %NULL if no frame was available.
  */
 static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw *hw,
 						      struct ieee80211_txq *txq)
@@ -7317,7 +7329,7 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @ac: AC number to return packets from.
  *
- * Returns the next txq if successful, %NULL if no queue is eligible. If a txq
+ * Return: the next txq if successful, %NULL if no queue is eligible. If a txq
  * is returned, it should be returned with ieee80211_return_txq() after the
  * driver has finished scheduling it.
  */
@@ -7400,6 +7412,8 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
+ *
+ * Return: %true if transmission is allowed, %false otherwise
  */
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq);
@@ -7460,6 +7474,8 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
  * @status: &struct ieee80211_rx_status containing the transmission rate
  *          information.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_rx_status *status,
@@ -7474,6 +7490,8 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @info: &struct ieee80211_tx_info of the frame.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
@@ -7523,6 +7541,8 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
  * hardware encapsulation enabled are data frames.
  *
  * @skb: the frame to be transmitted.
+ *
+ * Return: %true if @skb is a data frame, %false otherwise
  */
 static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
 {
@@ -7558,6 +7578,8 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
  *  - change_sta_links(0x10) for each affected STA (the AP)
  *  - assign_vif_chanctx(link_id=4)
  *  - change_vif_links(0x10)
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
 

-- 
2.42.0


