Return-Path: <linux-kernel+bounces-149356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A68A9006
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C4B22200
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4398B4A3C;
	Thu, 18 Apr 2024 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BKWndvsF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073719A;
	Thu, 18 Apr 2024 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400085; cv=none; b=lnv2C3lFzyDG1FDXJe0tNm1OuwhFADn5znJvNkPKUOgqVFpyyu09iA1sm+EixJcs6UfVtF8oBJQ20KjPeB7xpjGjubNTg7pE1Hsod/JmOeJP+DyrXKgI1O4x5VpVhEooL4FdPnwQYFmSm5Y9BNK+a14VH5BJHqxMTaNpGaK2T94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400085; c=relaxed/simple;
	bh=Rxo0JAfc7fVrBR2gPos47ERcTv7o1ZyGpuemRx6R4NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lfA3mJAnIGH3UzNASiFDxtSogJK7FiexkJu5cJwDd9svU7nWg3kUTuzU0PvmEaqCy+xldbgwIxWqMGOQniV1NBoBRS4kCFZCP6vRYYLqilidUZvmnXNWXkRHKfOxqrt/dtaAoc9AV0QNYu8W2DlEH2hecMnJKxbO6+mlIbvSqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BKWndvsF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNOE8S030133;
	Thu, 18 Apr 2024 00:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=I2t
	HaPwatgooNFYC9SX+oURa4w19LfTCDXDqlfilksM=; b=BKWndvsFPJG0ggKMeaM
	6OR0G1U3II5ZqQVfbjc6fE0EXtvTVnbwRUGyUXi2yrUjeWduUU/TGtc8E4RO2GEe
	aOpWhvnTIhE8POhz4dm7rp0osk8Rw1awUYbVzUIOhowPptiXpgnNWzpverkge3PD
	LfaOSEDGvnxcqCEyPlhkhbugUne04ENSLFK7K9Ezz5iJbCUqad4UrAWSwbGKHk4F
	BfIjvGtIXSA/PP1Qdm+bozXYgm9qtxt5T+3naBpCaRj3lpScpjzQKnE8CSt/CktT
	wPjoPRKKV6aVC5fT8XRaId6CTDDVDoHu17aP7SIKbZq8V9NUxI5z6ea1LuuOWIWz
	1iQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjarpjcj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:27:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I0Ribq007992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:27:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 17:27:44 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 17 Apr 2024 17:27:42 -0700
Subject: [PATCH wireless-next] wifi: cfg80211: fix cfg80211 function
 kernel-doc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240417-cfg80211-kdoc-v1-1-d54cb7143417@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAP1oIGYC/x3MQQqDMBBA0avIrDuQCVHbXqW4iHGiQ0ssGVFBv
 LvB5Vv8f4ByFlZ4VwdkXkVlTgX0qCBMPo2MMhSDNdYZRy2GOD6NJcLvMAck07jQ13V0/gWl+We
 Ost+/D2yS+ceqmHhfoDvPC967uk5uAAAA
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HThOlePvPvGRIYzgBd5HrNvEXVFBNuHG
X-Proofpoint-ORIG-GUID: HThOlePvPvGRIYzgBd5HrNvEXVFBNuHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_19,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180001

Running "scripts/kernel-doc -Wall -Werror -none include/net/cfg80211.h"
produces many warnings of the form "warning: No description found for
return value of <function>", so make sure all of them have a Return:
clause. In some instances also add a Context: clause.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/cfg80211.h | 111 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1e09329acc42..0112d645a2b4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1149,6 +1149,8 @@ ieee80211_chandef_max_power(struct cfg80211_chan_def *chandef)
  * @band_mask: which bands to check on
  * @prohibited_flags: which channels to not consider usable,
  *	%IEEE80211_CHAN_DISABLED is always taken into account
+ *
+ * Return: %true if usable channels found, %false otherwise
  */
 bool cfg80211_any_usable_channels(struct wiphy *wiphy,
 				  unsigned long band_mask,
@@ -1833,9 +1835,11 @@ enum cfg80211_station_type {
  *
  * Utility function for the @change_station driver method. Call this function
  * with the appropriate station type looking up the station (and checking that
- * it exists). It will verify whether the station change is acceptable, and if
- * not will return an error code. Note that it may modify the parameters for
- * backward compatibility reasons, so don't use them before calling this.
+ * it exists). It will verify whether the station change is acceptable.
+ *
+ * Return: 0 if the change is acceptable, otherwise an error code. Note that
+ * it may modify the parameters for backward compatibility reasons, so don't
+ * use them before calling this.
  */
 int cfg80211_check_station_change(struct wiphy *wiphy,
 				  struct station_parameters *params,
@@ -2229,7 +2233,7 @@ struct cfg80211_sar_capa {
  * @mac_addr: the mac address of the station of interest
  * @sinfo: pointer to the structure to fill with the information
  *
- * Returns 0 on success and sinfo is filled with the available information
+ * Return: 0 on success and sinfo is filled with the available information
  * otherwise returns a negative error code and the content of sinfo has to be
  * considered undefined.
  */
@@ -5334,6 +5338,8 @@ struct wiphy_iftype_ext_capab {
  * cfg80211_get_iftype_ext_capa - lookup interface type extended capability
  * @wiphy: the wiphy to look up from
  * @type: the interface type to look up
+ *
+ * Return: The extended capability for the given interface @type, may be %NULL
  */
 const struct wiphy_iftype_ext_capab *
 cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
@@ -5904,6 +5910,10 @@ int wiphy_register(struct wiphy *wiphy);
 /**
  * get_wiphy_regdom - get custom regdomain for the given wiphy
  * @wiphy: the wiphy to get the regdomain from
+ *
+ * Context: Requires any of RTNL, wiphy mutex or RCU protection.
+ *
+ * Return: pointer to the regulatory domain associated with the wiphy
  */
 const struct ieee80211_regdomain *get_wiphy_regdom(struct wiphy *wiphy);
 
@@ -6421,6 +6431,8 @@ ieee80211_get_channel(struct wiphy *wiphy, int freq)
  *
  * The Preferred Scanning Channels (PSC) are defined in
  * Draft IEEE P802.11ax/D5.0, 26.17.2.3.3
+ *
+ * Return: %true if channel is a PSC, %false otherwise
  */
 static inline bool cfg80211_channel_is_psc(struct ieee80211_channel *chan)
 {
@@ -6450,8 +6462,8 @@ ieee80211_get_response_rate(struct ieee80211_supported_band *sband,
  * ieee80211_mandatory_rates - get mandatory rates for a given band
  * @sband: the band to look for rates in
  *
- * This function returns a bitmap of the mandatory rates for the given
- * band, bits are set according to the rate position in the bitrates array.
+ * Return: a bitmap of the mandatory rates for the given band, bits
+ * are set according to the rate position in the bitrates array.
  */
 u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband);
 
@@ -6665,6 +6677,8 @@ bool ieee80211_get_8023_tunnel_proto(const void *hdr, __be16 *proto);
  * header to the ethernet header (if present).
  *
  * @skb: The 802.3 frame with embedded mesh header
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 int ieee80211_strip_8023_mesh_hdr(struct sk_buff *skb);
 
@@ -7043,6 +7057,8 @@ const struct ieee80211_reg_rule *freq_reg_info(struct wiphy *wiphy,
  *
  * You can use this to map the regulatory request initiator enum to a
  * proper string representation.
+ *
+ * Return: pointer to string representation of the initiator
  */
 const char *reg_initiator_name(enum nl80211_reg_initiator initiator);
 
@@ -7051,6 +7067,8 @@ const char *reg_initiator_name(enum nl80211_reg_initiator initiator);
  * @wiphy: wiphy for which pre-CAC capability is checked.
  *
  * Pre-CAC is allowed only in some regdomains (notable ETSI).
+ *
+ * Return: %true if allowed, %false otherwise
  */
 bool regulatory_pre_cac_allowed(struct wiphy *wiphy);
 
@@ -7185,6 +7203,8 @@ static inline void cfg80211_gen_new_bssid(const u8 *bssid, u8 max_bssid,
  * cfg80211_is_element_inherited - returns if element ID should be inherited
  * @element: element to check
  * @non_inherit_element: non inheritance element
+ *
+ * Return: %true if should be inherited, %false otherwise
  */
 bool cfg80211_is_element_inherited(const struct element *element,
 				   const struct element *non_inherit_element);
@@ -7197,6 +7217,8 @@ bool cfg80211_is_element_inherited(const struct element *element,
  * @sub_elem: current MBSSID subelement (profile)
  * @merged_ie: location of the merged profile
  * @max_copy_len: max merged profile length
+ *
+ * Return: the number of bytes merged
  */
 size_t cfg80211_merge_profile(const u8 *ie, size_t ielen,
 			      const struct element *mbssid_elem,
@@ -7224,7 +7246,7 @@ enum cfg80211_bss_frame_type {
  * @ielen: length of IEs
  * @band: enum nl80211_band of the channel
  *
- * Returns the channel number, or -1 if none could be determined.
+ * Return: the channel number, or -1 if none could be determined.
  */
 int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 				    enum nl80211_band band);
@@ -7302,6 +7324,8 @@ cfg80211_inform_bss(struct wiphy *wiphy,
  * @bss_type: type of BSS, see &enum ieee80211_bss_type
  * @privacy: privacy filter, see &enum ieee80211_privacy
  * @use_for: indicates which use is intended
+ *
+ * Return: Reference-counted BSS on success. %NULL on error.
  */
 struct cfg80211_bss *__cfg80211_get_bss(struct wiphy *wiphy,
 					struct ieee80211_channel *channel,
@@ -7322,6 +7346,8 @@ struct cfg80211_bss *__cfg80211_get_bss(struct wiphy *wiphy,
  * @privacy: privacy filter, see &enum ieee80211_privacy
  *
  * This version implies regular usage, %NL80211_BSS_USE_FOR_NORMAL.
+ *
+ * Return: Reference-counted BSS on success. %NULL on error.
  */
 static inline struct cfg80211_bss *
 cfg80211_get_bss(struct wiphy *wiphy, struct ieee80211_channel *channel,
@@ -7706,8 +7732,9 @@ int cfg80211_vendor_cmd_reply(struct sk_buff *skb);
  * cfg80211_vendor_cmd_get_sender - get the current sender netlink ID
  * @wiphy: the wiphy
  *
- * Return the current netlink port ID in a vendor command handler.
- * Valid to call only there.
+ * Return: the current netlink port ID in a vendor command handler.
+ *
+ * Context: May only be called from a vendor command handler
  */
 unsigned int cfg80211_vendor_cmd_get_sender(struct wiphy *wiphy);
 
@@ -8260,6 +8287,8 @@ void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
  *
  * @sinfo: the station information
  * @gfp: allocation flags
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
 
@@ -8777,13 +8806,13 @@ bool cfg80211_reg_can_beacon(struct wiphy *wiphy,
  * also checks if IR-relaxation conditions apply, to allow beaconing under
  * more permissive conditions.
  *
- * Requires the wiphy mutex to be held.
+ * Context: Requires the wiphy mutex to be held.
  */
 bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
 				   struct cfg80211_chan_def *chandef,
 				   enum nl80211_iftype iftype);
 
-/*
+/**
  * cfg80211_ch_switch_notify - update wdev channel and notify userspace
  * @dev: the device which switched channels
  * @chandef: the new channel definition
@@ -8796,7 +8825,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 			       struct cfg80211_chan_def *chandef,
 			       unsigned int link_id);
 
-/*
+/**
  * cfg80211_ch_switch_started_notify - notify channel switch start
  * @dev: the device on which the channel switch started
  * @chandef: the future channel definition
@@ -8819,7 +8848,7 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
  * @operating_class: the operating class to convert
  * @band: band pointer to fill
  *
- * Returns %true if the conversion was successful, %false otherwise.
+ * Return: %true if the conversion was successful, %false otherwise.
  */
 bool ieee80211_operating_class_to_band(u8 operating_class,
 				       enum nl80211_band *band);
@@ -8831,7 +8860,7 @@ bool ieee80211_operating_class_to_band(u8 operating_class,
  * @chan: the ieee80211_channel to convert
  * @chandef: a pointer to the resulting chandef
  *
- * Returns %true if the conversion was successful, %false otherwise.
+ * Return: %true if the conversion was successful, %false otherwise.
  */
 bool ieee80211_operating_class_to_chandef(u8 operating_class,
 					  struct ieee80211_channel *chan,
@@ -8843,7 +8872,7 @@ bool ieee80211_operating_class_to_chandef(u8 operating_class,
  * @chandef: the chandef to convert
  * @op_class: a pointer to the resulting operating class
  *
- * Returns %true if the conversion was successful, %false otherwise.
+ * Return: %true if the conversion was successful, %false otherwise.
  */
 bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
 					  u8 *op_class);
@@ -8853,7 +8882,7 @@ bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
  *
  * @chandef: the chandef to convert
  *
- * Returns the center frequency of chandef (1st segment) in KHz.
+ * Return: the center frequency of chandef (1st segment) in KHz.
  */
 static inline u32
 ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef)
@@ -8861,7 +8890,7 @@ ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef)
 	return MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
 }
 
-/*
+/**
  * cfg80211_tdls_oper_request - request userspace to perform TDLS operation
  * @dev: the device on which the operation is requested
  * @peer: the MAC address of the peer device
@@ -8880,11 +8909,11 @@ void cfg80211_tdls_oper_request(struct net_device *dev, const u8 *peer,
 				enum nl80211_tdls_operation oper,
 				u16 reason_code, gfp_t gfp);
 
-/*
+/**
  * cfg80211_calculate_bitrate - calculate actual bitrate (in 100Kbps units)
  * @rate: given rate_info to calculate bitrate from
  *
- * return 0 if MCS index >= 32
+ * Return: calculated bitrate
  */
 u32 cfg80211_calculate_bitrate(struct rate_info *rate);
 
@@ -8898,7 +8927,7 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate);
  * when the driver wishes to unregister the wdev, e.g. when the hardware device
  * is unbound from the driver.
  *
- * Requires the RTNL and wiphy mutex to be held.
+ * Context: Requires the RTNL and wiphy mutex to be held.
  */
 void cfg80211_unregister_wdev(struct wireless_dev *wdev);
 
@@ -8911,7 +8940,9 @@ void cfg80211_unregister_wdev(struct wireless_dev *wdev);
  * held. Otherwise, both register_netdevice() and register_netdev() are usable
  * instead as well.
  *
- * Requires the RTNL and wiphy mutex to be held.
+ * Context: Requires the RTNL and wiphy mutex to be held.
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 int cfg80211_register_netdevice(struct net_device *dev);
 
@@ -8924,7 +8955,7 @@ int cfg80211_register_netdevice(struct net_device *dev);
  * is held. Otherwise, both unregister_netdevice() and unregister_netdev() are
  * usable instead as well.
  *
- * Requires the RTNL and wiphy mutex to be held.
+ * Context: Requires the RTNL and wiphy mutex to be held.
  */
 static inline void cfg80211_unregister_netdevice(struct net_device *dev)
 {
@@ -9000,9 +9031,9 @@ int cfg80211_get_p2p_attr(const u8 *ies, unsigned int len,
  * correctly, if not the result of using this function will not
  * be ordered correctly either, i.e. it does no reordering.
  *
- * The function returns the offset where the next part of the
- * buffer starts, which may be @ielen if the entire (remainder)
- * of the buffer should be used.
+ * Return: The offset where the next part of the buffer starts, which
+ * may be @ielen if the entire (remainder) of the buffer should be
+ * used.
  */
 size_t ieee80211_ie_split_ric(const u8 *ies, size_t ielen,
 			      const u8 *ids, int n_ids,
@@ -9030,9 +9061,9 @@ size_t ieee80211_ie_split_ric(const u8 *ies, size_t ielen,
  * correctly, if not the result of using this function will not
  * be ordered correctly either, i.e. it does no reordering.
  *
- * The function returns the offset where the next part of the
- * buffer starts, which may be @ielen if the entire (remainder)
- * of the buffer should be used.
+ * Return: The offset where the next part of the buffer starts, which
+ * may be @ielen if the entire (remainder) of the buffer should be
+ * used.
  */
 static inline size_t ieee80211_ie_split(const u8 *ies, size_t ielen,
 					const u8 *ids, int n_ids, size_t offset)
@@ -9096,6 +9127,8 @@ unsigned int ieee80211_get_num_supported_channels(struct wiphy *wiphy);
  * This function can be called by the driver to check whether a
  * combination of interfaces and their types are allowed according to
  * the interface combinations.
+ *
+ * Return: 0 if combinations are allowed. Non-zero on error.
  */
 int cfg80211_check_combinations(struct wiphy *wiphy,
 				struct iface_combination_params *params);
@@ -9111,6 +9144,8 @@ int cfg80211_check_combinations(struct wiphy *wiphy,
  * This function can be called by the driver to check what possible
  * combinations it fits in at a given moment, e.g. for channel switching
  * purposes.
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 int cfg80211_iter_combinations(struct wiphy *wiphy,
 			       struct iface_combination_params *params,
@@ -9118,7 +9153,7 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 					    void *data),
 			       void *data);
 
-/*
+/**
  * cfg80211_stop_iface - trigger interface disconnection
  *
  * @wiphy: the wiphy
@@ -9173,6 +9208,8 @@ static inline void wiphy_ext_feature_set(struct wiphy *wiphy,
  *
  * The extended features are flagged in multiple bytes (see
  * &struct wiphy.@ext_features)
+ *
+ * Return: %true if extended feature flag is set, %false otherwise
  */
 static inline bool
 wiphy_ext_feature_isset(struct wiphy *wiphy,
@@ -9294,6 +9331,8 @@ void cfg80211_pmsr_complete(struct wireless_dev *wdev,
  * Check whether the interface is allowed to operate; additionally, this API
  * can be used to check iftype against the software interfaces when
  * check_swif is '1'.
+ *
+ * Return: %true if allowed, %false otherwise
  */
 bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
 			     bool is_4addr, u8 check_swif);
@@ -9386,6 +9425,8 @@ void cfg80211_bss_flush(struct wiphy *wiphy);
  * @cmd: the actual event we want to notify
  * @count: the number of TBTTs until the color change happens
  * @color_bitmap: representations of the colors that the local BSS is aware of
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 int cfg80211_bss_color_notify(struct net_device *dev,
 			      enum nl80211_commands cmd, u8 count,
@@ -9395,6 +9436,8 @@ int cfg80211_bss_color_notify(struct net_device *dev,
  * cfg80211_obss_color_collision_notify - notify about bss color collision
  * @dev: network device
  * @color_bitmap: representations of the colors that the local BSS is aware of
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
 						       u64 color_bitmap)
@@ -9409,6 +9452,8 @@ static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
  * @count: the number of TBTTs until the color change happens
  *
  * Inform the userspace about the color change that has started.
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 static inline int cfg80211_color_change_started_notify(struct net_device *dev,
 						       u8 count)
@@ -9422,6 +9467,8 @@ static inline int cfg80211_color_change_started_notify(struct net_device *dev,
  * @dev: the device on which the color is switched
  *
  * Inform the userspace about the color change that has aborted.
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 static inline int cfg80211_color_change_aborted_notify(struct net_device *dev)
 {
@@ -9434,6 +9481,8 @@ static inline int cfg80211_color_change_aborted_notify(struct net_device *dev)
  * @dev: the device on which the color was switched
  *
  * Inform the userspace about the color change that has completed.
+ *
+ * Return: 0 on success. Non-zero on error.
  */
 static inline int cfg80211_color_change_notify(struct net_device *dev)
 {
@@ -9477,6 +9526,8 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
  * @ppos: read position
  * @handler: the read handler to call (under wiphy lock)
  * @data: additional data to pass to the read handler
+ *
+ * Return: the number of characters read, or a negative errno
  */
 ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
 				  char *buf, size_t bufsize,
@@ -9499,6 +9550,8 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
  * @count: read count
  * @handler: the write handler to call (under wiphy lock)
  * @data: additional data to pass to the write handler
+ *
+ * Return: the number of characters written, or a negative errno
  */
 ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
 				   char *buf, size_t bufsize,

---
base-commit: f236464f1db7bea80075e6e31ac70dc6eb80547f
change-id: 20240417-cfg80211-kdoc-1064cb55f4a9


