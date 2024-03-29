Return-Path: <linux-kernel+bounces-126225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11E789340A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BF61C231D5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8B157E88;
	Sun, 31 Mar 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MqWRDyHZ"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25C15572C;
	Sun, 31 Mar 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903217; cv=fail; b=clE/Ny8Jua4ytrf4og5iD39mFHYNGFXDmwblNbsT2BBUT7iu/oj8maR1dWsOcYiuicqWHed9UssiqVm5S3ACyW6dDy7ZLYXS4XBa4SlP8LsBb6myKNrJlq0L9+eBQ56WTjvb5yEMeH7Z24Iq1WJrktiI+UoJ9Sga8Nhj9EN+cFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903217; c=relaxed/simple;
	bh=vxGy5e1TMtYkEcEnoP0qaaRaR1FgjjbYf85/fCQEvwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d9KlValU4o+e1gGyevxAPcP1SVEyjWzBE6vzySxe/VsuiJP0gKo7Bx4BlMoy1HT+wL6iymlI4GC5S+ezJo/0ySvqlLkNxUxv+5zi1miY/o8MmrqDAgFJA95XLFb5Qjqza9nLsjo3Iuefa9ebis2SzkDXN93+FWJ+ovcIX910q38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=fail (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MqWRDyHZ reason="signature verification failed"; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 04B9420842;
	Sun, 31 Mar 2024 18:40:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 67pl0qAFy3Gb; Sun, 31 Mar 2024 18:40:03 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B79AA20897;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B79AA20897
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 993AF800051;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:00 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:15 +0000
X-sender: <netdev+bounces-83458-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBfAAAAy4oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 25441
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83458-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DD6C420892
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744055; cv=none; b=QElk8gh858jXIFAdKlEuEgd3eVX56pPJAdglEopJNNxzYbipooWiEv/PqjqSKNJX7szBg5463RkjYuMIFLmSN/Ou9uBmDynlcHfx5AEJlfKRK/mNw9W6L/c+/rBZAmUHwMVBUaIgX3bU2iUOnez4WR515OkHk62fiWwPWHXHpuE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744055; c=relaxed/simple;
	bh=StGoq54zznjDZKc/Pf7ZGEHHjSofq9BwKnoDbg71mHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eJtor+Q17vwPqmCIL02xw4u+Bi4wBHT87v9P/pqgBhmxl6pYTgQ81YAkfLIAUT8j48XiaB+ioD/9r1+RKDvViIi2473m2kagM47cxHL3dDLLi14FIMuwk/FIbu7QyxSo1o5JvCc2ZVe5smktXLdG7KyQLfqFSaQASJvJOlWUPIk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MqWRDyHZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
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
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:18 -0700
Subject: [PATCH 2/2] wifi: mac80211: Add missing return value documentation
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

kernel-doc is reporting some warnings, so fix them:

% scripts/kernel-doc -Wall -Werror -none include/net/mac80211.h
include/net/mac80211.h:2056: warning: No description found for return value=
 of 'wdev_to_ieee80211_vif'
include/net/mac80211.h:2066: warning: No description found for return value=
 of 'ieee80211_vif_to_wdev'
include/net/mac80211.h:5603: warning: No description found for return value=
 of 'ieee80211_beacon_cntdwn_is_complete'
include/net/mac80211.h:5968: warning: No description found for return value=
 of 'ieee80211_gtk_rekey_add'
include/net/mac80211.h:6350: warning: No description found for return value=
 of 'ieee80211_find_sta_by_link_addrs'
include/net/mac80211.h:6478: warning: No description found for return value=
 of 'ieee80211_txq_airtime_check'
include/net/mac80211.h:6981: warning: No description found for return value=
 of 'rate_control_set_rates'
include/net/mac80211.h:7142: warning: No description found for return value=
 of 'ieee80211_tx_prepare_skb'
include/net/mac80211.h:7156: warning: No description found for return value=
 of 'ieee80211_parse_tx_radiotap'
include/net/mac80211.h:7277: warning: No description found for return value=
 of 'ieee80211_tx_dequeue'
include/net/mac80211.h:7292: warning: No description found for return value=
 of 'ieee80211_tx_dequeue_ni'
include/net/mac80211.h:7324: warning: No description found for return value=
 of 'ieee80211_next_txq'
include/net/mac80211.h:7405: warning: No description found for return value=
 of 'ieee80211_txq_may_transmit'
include/net/mac80211.h:7466: warning: No description found for return value=
 of 'ieee80211_calc_rx_airtime'
include/net/mac80211.h:7480: warning: No description found for return value=
 of 'ieee80211_calc_tx_airtime'
include/net/mac80211.h:7528: warning: No description found for return value=
 of 'ieee80211_is_tx_data'
include/net/mac80211.h:7562: warning: No description found for return value=
 of 'ieee80211_set_active_links'
17 warnings as Errors

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e6a11a982ca8..8984ac4359b8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2049,7 +2049,7 @@ static inline bool ieee80211_vif_is_mesh(struct ieee8=
0211_vif *vif)
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that get a wdev.
  *
- * Note that this function may return %NULL if the given wdev isn't
+ * Return: pointer to the wdev, or %NULL if the given wdev isn't
  * associated with a vif that the driver knows about (e.g. monitor
  * or AP_VLAN interfaces.)
  */
@@ -2062,6 +2062,8 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wi=
reless_dev *wdev);
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that needs to get the wdev for a vif.
  * This can also be useful to get the netdev associated to a vif.
+ *
+ * Return: pointer to the wdev
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
=20
@@ -5597,7 +5599,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, =
unsigned int link_id);
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @link_id: valid link_id during MLO or 0 for non-MLO
  *
- * This function returns whether the countdown reached zero.
+ * Return: %true if the countdown reached 1, %false otherwise
  */
 bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
 					 unsigned int link_id);
@@ -5942,8 +5944,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *=
keyconf);
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
@@ -6342,6 +6344,8 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(st=
ruct ieee80211_hw *hw,
  *	may be %NULL if the link ID is not needed
  *
  * Obtain the STA by link address, must use RCU protection.
+ *
+ * Return: pointer to STA if found, otherwise %NULL.
  */
 struct ieee80211_sta *
 ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
@@ -6471,8 +6475,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_=
sta *pubsta, u8 tid,
  * @hw: pointer obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
  *
- * Return true if the AQL's airtime limit has not been reached and the txq=
 can
- * continue to send more packets to the device. Otherwise return false.
+ * Return: %true if the AQL's airtime limit has not been reached and the t=
xq can
+ * continue to send more packets to the device. Otherwise return %false.
  */
 bool
 ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq =
*txq);
@@ -6975,6 +6979,8 @@ bool rate_usable_index_exists(struct ieee80211_suppor=
ted_band *sband,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @pubsta: &struct ieee80211_sta pointer to the target destination.
  * @rates: new tx rate set to be used for this station.
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int rate_control_set_rates(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *pubsta,
@@ -7135,6 +7141,8 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_=
vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
@@ -7151,6 +7159,8 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw=
,
  *
  * @skb: packet injected by userspace
  * @dev: the &struct device of this 802.11 device
+ *
+ * Return: %true if the radiotap header was parsed, %false otherwise
  */
 bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				 struct net_device *dev);
@@ -7260,7 +7270,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *st=
a, u8 tid);
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
  *
- * Returns the skb if successful, %NULL if no frame was available.
+ * Return: the skb if successful, %NULL if no frame was available.
  *
  * Note that this must be called in an rcu_read_lock() critical section,
  * which can only be released after the SKB was handled. Some pointers in
@@ -7286,6 +7296,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
+ *
+ * Return: the skb if successful, %NULL if no frame was available.
  */
 static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw =
*hw,
 						      struct ieee80211_txq *txq)
@@ -7317,7 +7329,7 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_=
hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @ac: AC number to return packets from.
  *
- * Returns the next txq if successful, %NULL if no queue is eligible. If a=
 txq
+ * Return: the next txq if successful, %NULL if no queue is eligible. If a=
 txq
  * is returned, it should be returned with ieee80211_return_txq() after th=
e
  * driver has finished scheduling it.
  */
@@ -7400,6 +7412,8 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct =
ieee80211_txq *txq,
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
+ *
+ * Return: %true if transmission is allowed, %false otherwise
  */
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq);
@@ -7460,6 +7474,8 @@ void ieee80211_nan_func_match(struct ieee80211_vif *v=
if,
  * @status: &struct ieee80211_rx_status containing the transmission rate
  *          information.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_rx_status *status,
@@ -7474,6 +7490,8 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw=
,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @info: &struct ieee80211_tx_info of the frame.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
@@ -7523,6 +7541,8 @@ ieee80211_obss_color_collision_notify(struct ieee8021=
1_vif *vif,
  * hardware encapsulation enabled are data frames.
  *
  * @skb: the frame to be transmitted.
+ *
+ * Return: %true if @skb is a data frame, %false otherwise
  */
 static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
 {
@@ -7558,6 +7578,8 @@ static inline bool ieee80211_is_tx_data(struct sk_buf=
f *skb)
  *  - change_sta_links(0x10) for each affected STA (the AP)
  *  - assign_vif_chanctx(link_id=3D4)
  *  - change_vif_links(0x10)
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links=
);
=20

--=20
2.42.0


X-sender: <netdev+bounces-83458-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGMAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 25688
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:28:04 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:28:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id CDCB620270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:28:04 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZbXcWlxNb6O for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:27:59 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83458-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 1F40A2032C
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"MqWRDyHZ"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 1F40A2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3662B22492
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676613CAA1;
	Fri, 29 Mar 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"MqWRDyHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4613B58D;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744055; cv=3Dnone; b=3DQElk8gh858jXIFAdKlEuEgd3eVX56pPJAdglEopJNNx=
zYbipooWiEv/PqjqSKNJX7szBg5463RkjYuMIFLmSN/Ou9uBmDynlcHfx5AEJlfKRK/mNw9W6L/=
c+/rBZAmUHwMVBUaIgX3bU2iUOnez4WR515OkHk62fiWwPWHXHpuE=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744055; c=3Drelaxed/simple;
	bh=3DStGoq54zznjDZKc/Pf7ZGEHHjSofq9BwKnoDbg71mHw=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3DeJtor+Q17vwPqmCIL02xw4u+Bi4wBHT87v9P/pqgBhmxl6pYTg=
Q81YAkfLIAUT8j48XiaB+ioD/9r1+RKDvViIi2473m2kagM47cxHL3dDLLi14FIMuwk/FIbu7Qy=
xSo1o5JvCc2ZVe5smktXLdG7KyQLfqFSaQASJvJOlWUPIk=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DMqWRDyHZ; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TIpHY4=
010213;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3DsXcof/W6pLniDYlgtOd09vD4vb8NPmLp0ZyN24gIjo8
	=3D; b=3DMqWRDyHZwMIJZ0kLPPl52i6v0DHRqnHncfSw5/W4sxK6MlH+8QtxFXROHG0
	mr0V2eCmeiT6mM10v+MmDedAffgLKny5H30YaaqejZl7RBcqZfM6RVjtJQtNY+Mw
	Aseq2Nt3TMm3dKjSVPSGEt1K487uZxLoQROvJt3DDkJ64y7TDmxgb8Nx8cEk0QjP
	ml11lNWxp029LFKIq4C8LlU6Svxt9upq/TO2LEfuq9Vtw2s3XfEN4ERjSywlqRBq
	zH8bW3tomi/NX1Am8UzpSxezqR6s3ssW49WqbVKbJJbT22ki72BCzOBUOYfOTvBC
	WO4X+kQOP4FuUmJpLgG6AJ+PEsQ=3D=3D
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g11ah-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJm502=
0691
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 13:27:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:18 -0700
Subject: [PATCH 2/2] wifi: mac80211: Add missing return value documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
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
X-Proofpoint-Virus-Version: vendor=3Dnai engine=3D6200 definitions=3D5800 s=
ignatures=3D585085
X-Proofpoint-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-ORIG-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 clxscore=3D1015 suspectscore=3D0
 malwarescore=3D0 adultscore=3D0 spamscore=3D0 lowpriorityscore=3D0 mlxlogs=
core=3D999
 impostorscore=3D0 priorityscore=3D1501 bulkscore=3D0 mlxscore=3D0 phishsco=
re=3D0
 classifier=3Dspam adjust=3D0 reason=3Dmlx scancount=3D1 engine=3D8.19.0-24=
03210001
 definitions=3Dmain-2403290183
Return-Path: netdev+bounces-83458-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:28:04.8740
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 1e76f7d6-02e1-4b74-8e48-08dc=
502ebcf6
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.215|SMR=3D0.138(SMRDE=3D0.005|SMRC=3D0.132(=
SMRCL=3D0.103|X-SMRCR=3D0.131))|CAT=3D0.074(CATOS=3D0.001
 |CATRESL=3D0.026(CATRESLP2R=3D0.018)|CATORES=3D0.042(CATRS=3D0.041(CATRS-T=
ransport
 Rule Agent=3D0.002 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.038))|CATORT=3D0.003(CATRT=3D0.003(CATRT-Journal Agent=3D0.002
 )));2024-03-29T20:28:05.118Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 18165
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.029|SMR=3D0.024(SMRPI=3D0.022(SMRPI-FrontendProxyAgent=3D0.022))=
|SMS=3D0.004
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAacPAAAPAAADH4sIAAAAAAAEAL1Z6XPb=
xhUHxUukRPlM0m
 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
 65EQEtKk8EaPcZ6mMgLeSK1CqUKUlnMjOmEbVKEoQTLSsuUOUVtHiK
 63HYwTjMjijuReMKm6xBxH13RcbtkJH3Eh3p/TgvCJBrMeywYUHf0g
 0LPou7kSTOoxhU5uh+mdy9V0xHQpyeFAAVLgRbuXIGnMbmSvTw22l/
 VTOy6fZmuUnrR3GoJ0VKDAj5tFRfp+HihvLK2cRMFxIzS8EtVVz4k0
 squziGiDl1iE5VtUyV0jqL459xcU+3ByUyV5QI8BR7s9XlcrGvWA62
 2v31Xfw4zs1damvLtD7OysSoVUmzfnJ7nGcYYesVU70fwmCM5I+Uxa
 oobWEXLfxoBwE52kWmjiKQdHmQn5/O5mL+qzTl7Qy4volUVnQVFLY/
 IEaJalvbXHhFE9rglUaGZU/UXFBRFSc5UoHM0NTFAV8iq6qakqch9A
 sVCVF288BYpBIP8ZCc3RJTbQp88rnabUa/lduhuuW0+xTnVI4jVKTe
 mPNut4RmL0dTQ9ST8ziwk957P7vEp0bs+ZikUQsdAdP3A9aF5mhi9H
 /jeskG+TkAAAEOzwFSZXRyaWV2ZXJPcGVyYXRvciwxMCwyO1JldHJp
 ZXZlck9wZXJhdG9yLDExLDI7UG9zdERvY1BhcnNlck9wZXJhdG9yLD
 EwLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRC
 cmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEwLDY7UG9zdFdvcmRCcm
 Vha2VyRGlhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3Jp
 dGVyUHJvZHVjZXIsMjAsMTg=3D
X-MS-Exchange-Forest-IndexAgent: 1 4229
X-MS-Exchange-Forest-EmailMessageHash: 7858568C
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

kernel-doc is reporting some warnings, so fix them:

% scripts/kernel-doc -Wall -Werror -none include/net/mac80211.h
include/net/mac80211.h:2056: warning: No description found for return value=
 of 'wdev_to_ieee80211_vif'
include/net/mac80211.h:2066: warning: No description found for return value=
 of 'ieee80211_vif_to_wdev'
include/net/mac80211.h:5603: warning: No description found for return value=
 of 'ieee80211_beacon_cntdwn_is_complete'
include/net/mac80211.h:5968: warning: No description found for return value=
 of 'ieee80211_gtk_rekey_add'
include/net/mac80211.h:6350: warning: No description found for return value=
 of 'ieee80211_find_sta_by_link_addrs'
include/net/mac80211.h:6478: warning: No description found for return value=
 of 'ieee80211_txq_airtime_check'
include/net/mac80211.h:6981: warning: No description found for return value=
 of 'rate_control_set_rates'
include/net/mac80211.h:7142: warning: No description found for return value=
 of 'ieee80211_tx_prepare_skb'
include/net/mac80211.h:7156: warning: No description found for return value=
 of 'ieee80211_parse_tx_radiotap'
include/net/mac80211.h:7277: warning: No description found for return value=
 of 'ieee80211_tx_dequeue'
include/net/mac80211.h:7292: warning: No description found for return value=
 of 'ieee80211_tx_dequeue_ni'
include/net/mac80211.h:7324: warning: No description found for return value=
 of 'ieee80211_next_txq'
include/net/mac80211.h:7405: warning: No description found for return value=
 of 'ieee80211_txq_may_transmit'
include/net/mac80211.h:7466: warning: No description found for return value=
 of 'ieee80211_calc_rx_airtime'
include/net/mac80211.h:7480: warning: No description found for return value=
 of 'ieee80211_calc_tx_airtime'
include/net/mac80211.h:7528: warning: No description found for return value=
 of 'ieee80211_is_tx_data'
include/net/mac80211.h:7562: warning: No description found for return value=
 of 'ieee80211_set_active_links'
17 warnings as Errors

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e6a11a982ca8..8984ac4359b8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2049,7 +2049,7 @@ static inline bool ieee80211_vif_is_mesh(struct ieee8=
0211_vif *vif)
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that get a wdev.
  *
- * Note that this function may return %NULL if the given wdev isn't
+ * Return: pointer to the wdev, or %NULL if the given wdev isn't
  * associated with a vif that the driver knows about (e.g. monitor
  * or AP_VLAN interfaces.)
  */
@@ -2062,6 +2062,8 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wi=
reless_dev *wdev);
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that needs to get the wdev for a vif.
  * This can also be useful to get the netdev associated to a vif.
+ *
+ * Return: pointer to the wdev
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
=20
@@ -5597,7 +5599,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, =
unsigned int link_id);
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @link_id: valid link_id during MLO or 0 for non-MLO
  *
- * This function returns whether the countdown reached zero.
+ * Return: %true if the countdown reached 1, %false otherwise
  */
 bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
 					 unsigned int link_id);
@@ -5942,8 +5944,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *=
keyconf);
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
@@ -6342,6 +6344,8 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(st=
ruct ieee80211_hw *hw,
  *	may be %NULL if the link ID is not needed
  *
  * Obtain the STA by link address, must use RCU protection.
+ *
+ * Return: pointer to STA if found, otherwise %NULL.
  */
 struct ieee80211_sta *
 ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
@@ -6471,8 +6475,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_=
sta *pubsta, u8 tid,
  * @hw: pointer obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
  *
- * Return true if the AQL's airtime limit has not been reached and the txq=
 can
- * continue to send more packets to the device. Otherwise return false.
+ * Return: %true if the AQL's airtime limit has not been reached and the t=
xq can
+ * continue to send more packets to the device. Otherwise return %false.
  */
 bool
 ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq =
*txq);
@@ -6975,6 +6979,8 @@ bool rate_usable_index_exists(struct ieee80211_suppor=
ted_band *sband,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @pubsta: &struct ieee80211_sta pointer to the target destination.
  * @rates: new tx rate set to be used for this station.
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int rate_control_set_rates(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *pubsta,
@@ -7135,6 +7141,8 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_=
vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
@@ -7151,6 +7159,8 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw=
,
  *
  * @skb: packet injected by userspace
  * @dev: the &struct device of this 802.11 device
+ *
+ * Return: %true if the radiotap header was parsed, %false otherwise
  */
 bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				 struct net_device *dev);
@@ -7260,7 +7270,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *st=
a, u8 tid);
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
  *
- * Returns the skb if successful, %NULL if no frame was available.
+ * Return: the skb if successful, %NULL if no frame was available.
  *
  * Note that this must be called in an rcu_read_lock() critical section,
  * which can only be released after the SKB was handled. Some pointers in
@@ -7286,6 +7296,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
+ *
+ * Return: the skb if successful, %NULL if no frame was available.
  */
 static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw =
*hw,
 						      struct ieee80211_txq *txq)
@@ -7317,7 +7329,7 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_=
hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @ac: AC number to return packets from.
  *
- * Returns the next txq if successful, %NULL if no queue is eligible. If a=
 txq
+ * Return: the next txq if successful, %NULL if no queue is eligible. If a=
 txq
  * is returned, it should be returned with ieee80211_return_txq() after th=
e
  * driver has finished scheduling it.
  */
@@ -7400,6 +7412,8 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct =
ieee80211_txq *txq,
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
+ *
+ * Return: %true if transmission is allowed, %false otherwise
  */
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq);
@@ -7460,6 +7474,8 @@ void ieee80211_nan_func_match(struct ieee80211_vif *v=
if,
  * @status: &struct ieee80211_rx_status containing the transmission rate
  *          information.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_rx_status *status,
@@ -7474,6 +7490,8 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw=
,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @info: &struct ieee80211_tx_info of the frame.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
@@ -7523,6 +7541,8 @@ ieee80211_obss_color_collision_notify(struct ieee8021=
1_vif *vif,
  * hardware encapsulation enabled are data frames.
  *
  * @skb: the frame to be transmitted.
+ *
+ * Return: %true if @skb is a data frame, %false otherwise
  */
 static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
 {
@@ -7558,6 +7578,8 @@ static inline bool ieee80211_is_tx_data(struct sk_buf=
f *skb)
  *  - change_sta_links(0x10) for each affected STA (the AP)
  *  - assign_vif_chanctx(link_id=3D4)
  *  - change_vif_links(0x10)
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links=
);
=20

--=20
2.42.0


X-sender: <linux-kernel+bounces-125389-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGoAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 25632
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:28:35 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:28:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 927E32032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:28:35 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7IXDrBxfwfAa for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:28:34 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125389-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com B229B20270
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"MqWRDyHZ"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id B229B20270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B2C1F2355C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF9E13DDBF;
	Fri, 29 Mar 2024 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"MqWRDyHZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4613B58D;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744055; cv=3Dnone; b=3DQElk8gh858jXIFAdKlEuEgd3eVX56pPJAdglEopJNNx=
zYbipooWiEv/PqjqSKNJX7szBg5463RkjYuMIFLmSN/Ou9uBmDynlcHfx5AEJlfKRK/mNw9W6L/=
c+/rBZAmUHwMVBUaIgX3bU2iUOnez4WR515OkHk62fiWwPWHXHpuE=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744055; c=3Drelaxed/simple;
	bh=3DStGoq54zznjDZKc/Pf7ZGEHHjSofq9BwKnoDbg71mHw=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3DeJtor+Q17vwPqmCIL02xw4u+Bi4wBHT87v9P/pqgBhmxl6pYTg=
Q81YAkfLIAUT8j48XiaB+ioD/9r1+RKDvViIi2473m2kagM47cxHL3dDLLi14FIMuwk/FIbu7Qy=
xSo1o5JvCc2ZVe5smktXLdG7KyQLfqFSaQASJvJOlWUPIk=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DMqWRDyHZ; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TIpHY4=
010213;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3DsXcof/W6pLniDYlgtOd09vD4vb8NPmLp0ZyN24gIjo8
	=3D; b=3DMqWRDyHZwMIJZ0kLPPl52i6v0DHRqnHncfSw5/W4sxK6MlH+8QtxFXROHG0
	mr0V2eCmeiT6mM10v+MmDedAffgLKny5H30YaaqejZl7RBcqZfM6RVjtJQtNY+Mw
	Aseq2Nt3TMm3dKjSVPSGEt1K487uZxLoQROvJt3DDkJ64y7TDmxgb8Nx8cEk0QjP
	ml11lNWxp029LFKIq4C8LlU6Svxt9upq/TO2LEfuq9Vtw2s3XfEN4ERjSywlqRBq
	zH8bW3tomi/NX1Am8UzpSxezqR6s3ssW49WqbVKbJJbT22ki72BCzOBUOYfOTvBC
	WO4X+kQOP4FuUmJpLgG6AJ+PEsQ=3D=3D
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g11ah-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJm502=
0691
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
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
Content-Type: text/plain; charset=3D"utf-8"
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
X-Proofpoint-Virus-Version: vendor=3Dnai engine=3D6200 definitions=3D5800 s=
ignatures=3D585085
X-Proofpoint-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-ORIG-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 clxscore=3D1015 suspectscore=3D0
 malwarescore=3D0 adultscore=3D0 spamscore=3D0 lowpriorityscore=3D0 mlxlogs=
core=3D999
 impostorscore=3D0 priorityscore=3D1501 bulkscore=3D0 mlxscore=3D0 phishsco=
re=3D0
 classifier=3Dspam adjust=3D0 reason=3Dmlx scancount=3D1 engine=3D8.19.0-24=
03210001
 definitions=3Dmain-2403290183
Return-Path: linux-kernel+bounces-125389-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:28:35.6313
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 42894db1-a2ae-4db2-be40-08dc=
502ecf4b
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.386|SMR=3D0.326(SMRDE=3D0.005|SMRC=3D0.319(=
SMRCL=3D0.104|X-SMRCR=3D0.319))|CAT=3D0.058(CATOS=3D0.001
 |CATRESL=3D0.010(CATRESLP2R=3D0.002)|CATORES=3D0.045(CATRS=3D0.045(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.041)));2024-03-29T20:28:36.045Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 18167
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.028|SMR=3D0.023(SMRPI=3D0.021(SMRPI-FrontendProxyAgent=3D0.021))=
|SMS=3D0.004
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAacPAAAPAAADH4sIAAAAAAAEAL1Z6XPb=
xhUHxUukRPlM0m
 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
 65EQEtKk8EaPcZ6mMgLeSK1CqUKUlnMjOmEbVKEoQTLSsuUOUVtHiK
 63HYwTjMjijuReMKm6xBxH13RcbtkJH3Eh3p/TgvCJBrMeywYUHf0g
 0LPou7kSTOoxhU5uh+mdy9V0xHQpyeFAAVLgRbuXIGnMbmSvTw22l/
 VTOy6fZmuUnrR3GoJ0VKDAj5tFRfp+HihvLK2cRMFxIzS8EtVVz4k0
 squziGiDl1iE5VtUyV0jqL459xcU+3ByUyV5QI8BR7s9XlcrGvWA62
 2v31Xfw4zs1damvLtD7OysSoVUmzfnJ7nGcYYesVU70fwmCM5I+Uxa
 oobWEXLfxoBwE52kWmjiKQdHmQn5/O5mL+qzTl7Qy4volUVnQVFLY/
 IEaJalvbXHhFE9rglUaGZU/UXFBRFSc5UoHM0NTFAV8iq6qakqch9A
 sVCVF288BYpBIP8ZCc3RJTbQp88rnabUa/lduhuuW0+xTnVI4jVKTe
 mPNut4RmL0dTQ9ST8ziwk957P7vEp0bs+ZikUQsdAdP3A9aF5mhi9H
 /jeskG+TkAAAEOzwFSZXRyaWV2ZXJPcGVyYXRvciwxMCwxO1JldHJp
 ZXZlck9wZXJhdG9yLDExLDM7UG9zdERvY1BhcnNlck9wZXJhdG9yLD
 EwLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRC
 cmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEwLDg7UG9zdFdvcmRCcm
 Vha2VyRGlhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3Jp
 dGVyUHJvZHVjZXIsMjAsMjA=3D
X-MS-Exchange-Forest-IndexAgent: 1 4229
X-MS-Exchange-Forest-EmailMessageHash: 7858568C
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

kernel-doc is reporting some warnings, so fix them:

% scripts/kernel-doc -Wall -Werror -none include/net/mac80211.h
include/net/mac80211.h:2056: warning: No description found for return value=
 of 'wdev_to_ieee80211_vif'
include/net/mac80211.h:2066: warning: No description found for return value=
 of 'ieee80211_vif_to_wdev'
include/net/mac80211.h:5603: warning: No description found for return value=
 of 'ieee80211_beacon_cntdwn_is_complete'
include/net/mac80211.h:5968: warning: No description found for return value=
 of 'ieee80211_gtk_rekey_add'
include/net/mac80211.h:6350: warning: No description found for return value=
 of 'ieee80211_find_sta_by_link_addrs'
include/net/mac80211.h:6478: warning: No description found for return value=
 of 'ieee80211_txq_airtime_check'
include/net/mac80211.h:6981: warning: No description found for return value=
 of 'rate_control_set_rates'
include/net/mac80211.h:7142: warning: No description found for return value=
 of 'ieee80211_tx_prepare_skb'
include/net/mac80211.h:7156: warning: No description found for return value=
 of 'ieee80211_parse_tx_radiotap'
include/net/mac80211.h:7277: warning: No description found for return value=
 of 'ieee80211_tx_dequeue'
include/net/mac80211.h:7292: warning: No description found for return value=
 of 'ieee80211_tx_dequeue_ni'
include/net/mac80211.h:7324: warning: No description found for return value=
 of 'ieee80211_next_txq'
include/net/mac80211.h:7405: warning: No description found for return value=
 of 'ieee80211_txq_may_transmit'
include/net/mac80211.h:7466: warning: No description found for return value=
 of 'ieee80211_calc_rx_airtime'
include/net/mac80211.h:7480: warning: No description found for return value=
 of 'ieee80211_calc_tx_airtime'
include/net/mac80211.h:7528: warning: No description found for return value=
 of 'ieee80211_is_tx_data'
include/net/mac80211.h:7562: warning: No description found for return value=
 of 'ieee80211_set_active_links'
17 warnings as Errors

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e6a11a982ca8..8984ac4359b8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2049,7 +2049,7 @@ static inline bool ieee80211_vif_is_mesh(struct ieee8=
0211_vif *vif)
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that get a wdev.
  *
- * Note that this function may return %NULL if the given wdev isn't
+ * Return: pointer to the wdev, or %NULL if the given wdev isn't
  * associated with a vif that the driver knows about (e.g. monitor
  * or AP_VLAN interfaces.)
  */
@@ -2062,6 +2062,8 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wi=
reless_dev *wdev);
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that needs to get the wdev for a vif.
  * This can also be useful to get the netdev associated to a vif.
+ *
+ * Return: pointer to the wdev
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
=20
@@ -5597,7 +5599,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, =
unsigned int link_id);
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @link_id: valid link_id during MLO or 0 for non-MLO
  *
- * This function returns whether the countdown reached zero.
+ * Return: %true if the countdown reached 1, %false otherwise
  */
 bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
 					 unsigned int link_id);
@@ -5942,8 +5944,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *=
keyconf);
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
@@ -6342,6 +6344,8 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(st=
ruct ieee80211_hw *hw,
  *	may be %NULL if the link ID is not needed
  *
  * Obtain the STA by link address, must use RCU protection.
+ *
+ * Return: pointer to STA if found, otherwise %NULL.
  */
 struct ieee80211_sta *
 ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
@@ -6471,8 +6475,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_=
sta *pubsta, u8 tid,
  * @hw: pointer obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
  *
- * Return true if the AQL's airtime limit has not been reached and the txq=
 can
- * continue to send more packets to the device. Otherwise return false.
+ * Return: %true if the AQL's airtime limit has not been reached and the t=
xq can
+ * continue to send more packets to the device. Otherwise return %false.
  */
 bool
 ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq =
*txq);
@@ -6975,6 +6979,8 @@ bool rate_usable_index_exists(struct ieee80211_suppor=
ted_band *sband,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @pubsta: &struct ieee80211_sta pointer to the target destination.
  * @rates: new tx rate set to be used for this station.
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int rate_control_set_rates(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *pubsta,
@@ -7135,6 +7141,8 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_=
vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
@@ -7151,6 +7159,8 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw=
,
  *
  * @skb: packet injected by userspace
  * @dev: the &struct device of this 802.11 device
+ *
+ * Return: %true if the radiotap header was parsed, %false otherwise
  */
 bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				 struct net_device *dev);
@@ -7260,7 +7270,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *st=
a, u8 tid);
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
  *
- * Returns the skb if successful, %NULL if no frame was available.
+ * Return: the skb if successful, %NULL if no frame was available.
  *
  * Note that this must be called in an rcu_read_lock() critical section,
  * which can only be released after the SKB was handled. Some pointers in
@@ -7286,6 +7296,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
+ *
+ * Return: the skb if successful, %NULL if no frame was available.
  */
 static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw =
*hw,
 						      struct ieee80211_txq *txq)
@@ -7317,7 +7329,7 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_=
hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @ac: AC number to return packets from.
  *
- * Returns the next txq if successful, %NULL if no queue is eligible. If a=
 txq
+ * Return: the next txq if successful, %NULL if no queue is eligible. If a=
 txq
  * is returned, it should be returned with ieee80211_return_txq() after th=
e
  * driver has finished scheduling it.
  */
@@ -7400,6 +7412,8 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct =
ieee80211_txq *txq,
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
+ *
+ * Return: %true if transmission is allowed, %false otherwise
  */
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq);
@@ -7460,6 +7474,8 @@ void ieee80211_nan_func_match(struct ieee80211_vif *v=
if,
  * @status: &struct ieee80211_rx_status containing the transmission rate
  *          information.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_rx_status *status,
@@ -7474,6 +7490,8 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw=
,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @info: &struct ieee80211_tx_info of the frame.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
@@ -7523,6 +7541,8 @@ ieee80211_obss_color_collision_notify(struct ieee8021=
1_vif *vif,
  * hardware encapsulation enabled are data frames.
  *
  * @skb: the frame to be transmitted.
+ *
+ * Return: %true if @skb is a data frame, %false otherwise
  */
 static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
 {
@@ -7558,6 +7578,8 @@ static inline bool ieee80211_is_tx_data(struct sk_buf=
f *skb)
  *  - change_sta_links(0x10) for each affected STA (the AP)
  *  - assign_vif_chanctx(link_id=3D4)
  *  - change_vif_links(0x10)
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links=
);
=20

--=20
2.42.0


X-sender: <linux-wireless+bounces-5623-peter.schumann=3Dsecunet.com@vger.ke=
rnel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=3Drfc822;peter.schumann@secu=
net.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAvkWmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbm=
dlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAA=
AAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1h=
aWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 18744
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:28:03 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:28:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 7CC212036C
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:28:03 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 182wrE_8OFsK for <peter.schumann@secunet.com>;
	Fri, 29 Mar 2024 21:27:59 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dlinux-wirel=
ess+bounces-5623-peter.schumann=3Dsecunet.com@vger.kernel.org; receiver=3Dp=
eter.schumann@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 1BFFD20270
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"MqWRDyHZ"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 1BFFD20270
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6326B2336D
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD5C13C9D4;
	Fri, 29 Mar 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"MqWRDyHZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4613B58D;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744055; cv=3Dnone; b=3DQElk8gh858jXIFAdKlEuEgd3eVX56pPJAdglEopJNNx=
zYbipooWiEv/PqjqSKNJX7szBg5463RkjYuMIFLmSN/Ou9uBmDynlcHfx5AEJlfKRK/mNw9W6L/=
c+/rBZAmUHwMVBUaIgX3bU2iUOnez4WR515OkHk62fiWwPWHXHpuE=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744055; c=3Drelaxed/simple;
	bh=3DStGoq54zznjDZKc/Pf7ZGEHHjSofq9BwKnoDbg71mHw=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3DeJtor+Q17vwPqmCIL02xw4u+Bi4wBHT87v9P/pqgBhmxl6pYTg=
Q81YAkfLIAUT8j48XiaB+ioD/9r1+RKDvViIi2473m2kagM47cxHL3dDLLi14FIMuwk/FIbu7Qy=
xSo1o5JvCc2ZVe5smktXLdG7KyQLfqFSaQASJvJOlWUPIk=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DMqWRDyHZ; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TIpHY4=
010213;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3DsXcof/W6pLniDYlgtOd09vD4vb8NPmLp0ZyN24gIjo8
	=3D; b=3DMqWRDyHZwMIJZ0kLPPl52i6v0DHRqnHncfSw5/W4sxK6MlH+8QtxFXROHG0
	mr0V2eCmeiT6mM10v+MmDedAffgLKny5H30YaaqejZl7RBcqZfM6RVjtJQtNY+Mw
	Aseq2Nt3TMm3dKjSVPSGEt1K487uZxLoQROvJt3DDkJ64y7TDmxgb8Nx8cEk0QjP
	ml11lNWxp029LFKIq4C8LlU6Svxt9upq/TO2LEfuq9Vtw2s3XfEN4ERjSywlqRBq
	zH8bW3tomi/NX1Am8UzpSxezqR6s3ssW49WqbVKbJJbT22ki72BCzOBUOYfOTvBC
	WO4X+kQOP4FuUmJpLgG6AJ+PEsQ=3D=3D
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g11ah-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJm502=
0691
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 13:27:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:18 -0700
Subject: [PATCH 2/2] wifi: mac80211: Add missing return value documentation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
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
X-Proofpoint-Virus-Version: vendor=3Dnai engine=3D6200 definitions=3D5800 s=
ignatures=3D585085
X-Proofpoint-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-ORIG-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 clxscore=3D1015 suspectscore=3D0
 malwarescore=3D0 adultscore=3D0 spamscore=3D0 lowpriorityscore=3D0 mlxlogs=
core=3D999
 impostorscore=3D0 priorityscore=3D1501 bulkscore=3D0 mlxscore=3D0 phishsco=
re=3D0
 classifier=3Dspam adjust=3D0 reason=3Dmlx scancount=3D1 engine=3D8.19.0-24=
03210001
 definitions=3Dmain-2403290183
Return-Path: linux-wireless+bounces-5623-peter.schumann=3Dsecunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:28:03.5419
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 46949a95-01b1-4c69-2276-08dc=
502ebc2b
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dcas-es=
sen-01.secunet.de:TOTAL-FE=3D0.005|SMR=3D0.006(SMRPI=3D0.004(SMRPI-Frontend=
ProxyAgent=3D0.004));2024-03-29T20:28:03.547Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 18197
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

kernel-doc is reporting some warnings, so fix them:

% scripts/kernel-doc -Wall -Werror -none include/net/mac80211.h
include/net/mac80211.h:2056: warning: No description found for return value=
 of 'wdev_to_ieee80211_vif'
include/net/mac80211.h:2066: warning: No description found for return value=
 of 'ieee80211_vif_to_wdev'
include/net/mac80211.h:5603: warning: No description found for return value=
 of 'ieee80211_beacon_cntdwn_is_complete'
include/net/mac80211.h:5968: warning: No description found for return value=
 of 'ieee80211_gtk_rekey_add'
include/net/mac80211.h:6350: warning: No description found for return value=
 of 'ieee80211_find_sta_by_link_addrs'
include/net/mac80211.h:6478: warning: No description found for return value=
 of 'ieee80211_txq_airtime_check'
include/net/mac80211.h:6981: warning: No description found for return value=
 of 'rate_control_set_rates'
include/net/mac80211.h:7142: warning: No description found for return value=
 of 'ieee80211_tx_prepare_skb'
include/net/mac80211.h:7156: warning: No description found for return value=
 of 'ieee80211_parse_tx_radiotap'
include/net/mac80211.h:7277: warning: No description found for return value=
 of 'ieee80211_tx_dequeue'
include/net/mac80211.h:7292: warning: No description found for return value=
 of 'ieee80211_tx_dequeue_ni'
include/net/mac80211.h:7324: warning: No description found for return value=
 of 'ieee80211_next_txq'
include/net/mac80211.h:7405: warning: No description found for return value=
 of 'ieee80211_txq_may_transmit'
include/net/mac80211.h:7466: warning: No description found for return value=
 of 'ieee80211_calc_rx_airtime'
include/net/mac80211.h:7480: warning: No description found for return value=
 of 'ieee80211_calc_tx_airtime'
include/net/mac80211.h:7528: warning: No description found for return value=
 of 'ieee80211_is_tx_data'
include/net/mac80211.h:7562: warning: No description found for return value=
 of 'ieee80211_set_active_links'
17 warnings as Errors

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e6a11a982ca8..8984ac4359b8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2049,7 +2049,7 @@ static inline bool ieee80211_vif_is_mesh(struct ieee8=
0211_vif *vif)
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that get a wdev.
  *
- * Note that this function may return %NULL if the given wdev isn't
+ * Return: pointer to the wdev, or %NULL if the given wdev isn't
  * associated with a vif that the driver knows about (e.g. monitor
  * or AP_VLAN interfaces.)
  */
@@ -2062,6 +2062,8 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wi=
reless_dev *wdev);
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that needs to get the wdev for a vif.
  * This can also be useful to get the netdev associated to a vif.
+ *
+ * Return: pointer to the wdev
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
=20
@@ -5597,7 +5599,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, =
unsigned int link_id);
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @link_id: valid link_id during MLO or 0 for non-MLO
  *
- * This function returns whether the countdown reached zero.
+ * Return: %true if the countdown reached 1, %false otherwise
  */
 bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
 					 unsigned int link_id);
@@ -5942,8 +5944,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *=
keyconf);
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
@@ -6342,6 +6344,8 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(st=
ruct ieee80211_hw *hw,
  *	may be %NULL if the link ID is not needed
  *
  * Obtain the STA by link address, must use RCU protection.
+ *
+ * Return: pointer to STA if found, otherwise %NULL.
  */
 struct ieee80211_sta *
 ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
@@ -6471,8 +6475,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_=
sta *pubsta, u8 tid,
  * @hw: pointer obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
  *
- * Return true if the AQL's airtime limit has not been reached and the txq=
 can
- * continue to send more packets to the device. Otherwise return false.
+ * Return: %true if the AQL's airtime limit has not been reached and the t=
xq can
+ * continue to send more packets to the device. Otherwise return %false.
  */
 bool
 ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq =
*txq);
@@ -6975,6 +6979,8 @@ bool rate_usable_index_exists(struct ieee80211_suppor=
ted_band *sband,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @pubsta: &struct ieee80211_sta pointer to the target destination.
  * @rates: new tx rate set to be used for this station.
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int rate_control_set_rates(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *pubsta,
@@ -7135,6 +7141,8 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_=
vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
@@ -7151,6 +7159,8 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw=
,
  *
  * @skb: packet injected by userspace
  * @dev: the &struct device of this 802.11 device
+ *
+ * Return: %true if the radiotap header was parsed, %false otherwise
  */
 bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				 struct net_device *dev);
@@ -7260,7 +7270,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *st=
a, u8 tid);
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
  *
- * Returns the skb if successful, %NULL if no frame was available.
+ * Return: the skb if successful, %NULL if no frame was available.
  *
  * Note that this must be called in an rcu_read_lock() critical section,
  * which can only be released after the SKB was handled. Some pointers in
@@ -7286,6 +7296,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211=
_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
+ *
+ * Return: the skb if successful, %NULL if no frame was available.
  */
 static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw =
*hw,
 						      struct ieee80211_txq *txq)
@@ -7317,7 +7329,7 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_=
hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @ac: AC number to return packets from.
  *
- * Returns the next txq if successful, %NULL if no queue is eligible. If a=
 txq
+ * Return: the next txq if successful, %NULL if no queue is eligible. If a=
 txq
  * is returned, it should be returned with ieee80211_return_txq() after th=
e
  * driver has finished scheduling it.
  */
@@ -7400,6 +7412,8 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct =
ieee80211_txq *txq,
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
+ *
+ * Return: %true if transmission is allowed, %false otherwise
  */
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq);
@@ -7460,6 +7474,8 @@ void ieee80211_nan_func_match(struct ieee80211_vif *v=
if,
  * @status: &struct ieee80211_rx_status containing the transmission rate
  *          information.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_rx_status *status,
@@ -7474,6 +7490,8 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw=
,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @info: &struct ieee80211_tx_info of the frame.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
@@ -7523,6 +7541,8 @@ ieee80211_obss_color_collision_notify(struct ieee8021=
1_vif *vif,
  * hardware encapsulation enabled are data frames.
  *
  * @skb: the frame to be transmitted.
+ *
+ * Return: %true if @skb is a data frame, %false otherwise
  */
 static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
 {
@@ -7558,6 +7578,8 @@ static inline bool ieee80211_is_tx_data(struct sk_buf=
f *skb)
  *  - change_sta_links(0x10) for each affected STA (the AP)
  *  - assign_vif_chanctx(link_id=3D4)
  *  - change_vif_links(0x10)
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links=
);
=20

--=20
2.42.0



