Return-Path: <linux-kernel+bounces-108011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6A8804CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C92853DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1A39FFE;
	Tue, 19 Mar 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E5N7fbn1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423B364C4;
	Tue, 19 Mar 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872797; cv=none; b=GlDtyY3XiyzFa+hh6gUAItRask4KGr60oZx7CneBRv0Y6nr1EFyfTBJ+q8hz2qT6IvVLEo2L+M0plAFDd/ZEU0qReJUzy2d3GvhKqv+TpsM5aAjhvYfCZ7ejpnId055PD0vSw/svDnzpAezoTgyNhtulDDY9ZMCs7P+TjfEgHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872797; c=relaxed/simple;
	bh=k0q1YV2PRCKSfAM9C0GUA2z5VeAVR4kwrMRUc6V9q74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DUbqSX/DXP7LdEJCnqRm6/xwnwoZsy5o6Zc57z9o+QoDTHinu1MUIf36xNjP4YNzJkkgih4IzNPF0kbozm4sVngADY4/BcqJD3SAfxx/j0FD0ndiF9XMLD4a57XP4u4yRYWSZkG2uk+2sm/VlwemtC+i/+fgapPW1wtyJy93WJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E5N7fbn1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGhmp028101;
	Tue, 19 Mar 2024 18:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=pYgeos+Cw4BG6DT2A669kHE2mYt8f2k9WjjUw/5vYfU
	=; b=E5N7fbn1+mD2nKihNLzBp5RLssB6KALcgaoUk7mvSDiE80gSRiYgYUjH3PR
	9OiTon45tBqcXRFyBZOKn3hBFL8oxmR8Bh4AFUO79KAq3ufZMU0PUb6ILV2AsV9U
	INgkYf7smAOfFMtxbDAYiSa/NI6qejYlat41F/LFcgl6/Oes22N8fpx3RqnncOQ2
	Y1ZdD9ig1HcGxMc1rPp/MUlUsvtBgO0myvIzY9VrO5mO+yEZ5LpoM50BXSEk3nSN
	ePbE2SVeiJWsJ+oxcW1jrQn4b/RFOUSfqo+P0LOfMNJZxbBc6RHlvbeV+WQb5i3F
	HrRo/33ly550U9CgBD9pkWwhhyA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy5ppsrf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JIQTqO003409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 11:26:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 19 Mar 2024 11:26:24 -0700
Subject: [PATCH 2/3] wifi: nl80211: fix nl80211 uapi comment style issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240319-kdoc-nl80211-v1-2-549e09d52866@quicinc.com>
References: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
In-Reply-To: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eb0fiIvcetRheGVxxFNvhjPTA65x8rww
X-Proofpoint-ORIG-GUID: eb0fiIvcetRheGVxxFNvhjPTA65x8rww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190140

Currently kernel-doc raises "warning: bad line:" for several comments
that have invalid multi-line comment style; they are missing the
leading '*'. And checkpatch.pl raises "WARNING: please, no space
before tabs" for a large number of comments which have space then tab
after the leading '*'.

Fix those issues.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/uapi/linux/nl80211.h | 166 +++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9397c61a48dc..4de84fbfd4fa 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -442,11 +442,11 @@
  *	stations connected and using at least that link as one of its links.
  *
  * @NL80211_CMD_GET_MPATH: Get mesh path attributes for mesh path to
- * 	destination %NL80211_ATTR_MAC on the interface identified by
- * 	%NL80211_ATTR_IFINDEX.
+ *	destination %NL80211_ATTR_MAC on the interface identified by
+ *	%NL80211_ATTR_IFINDEX.
  * @NL80211_CMD_SET_MPATH:  Set mesh path attributes for mesh path to
- * 	destination %NL80211_ATTR_MAC on the interface identified by
- * 	%NL80211_ATTR_IFINDEX.
+ *	destination %NL80211_ATTR_MAC on the interface identified by
+ *	%NL80211_ATTR_IFINDEX.
  * @NL80211_CMD_NEW_MPATH: Create a new mesh path for the destination given by
  *	%NL80211_ATTR_MAC via %NL80211_ATTR_MPATH_NEXT_HOP.
  * @NL80211_CMD_DEL_MPATH: Delete a mesh path to the destination given by
@@ -476,15 +476,15 @@
  *	after being queried by the kernel. CRDA replies by sending a regulatory
  *	domain structure which consists of %NL80211_ATTR_REG_ALPHA set to our
  *	current alpha2 if it found a match. It also provides
- * 	NL80211_ATTR_REG_RULE_FLAGS, and a set of regulatory rules. Each
- * 	regulatory rule is a nested set of attributes  given by
- * 	%NL80211_ATTR_REG_RULE_FREQ_[START|END] and
- * 	%NL80211_ATTR_FREQ_RANGE_MAX_BW with an attached power rule given by
- * 	%NL80211_ATTR_REG_RULE_POWER_MAX_ANT_GAIN and
- * 	%NL80211_ATTR_REG_RULE_POWER_MAX_EIRP.
+ *	NL80211_ATTR_REG_RULE_FLAGS, and a set of regulatory rules. Each
+ *	regulatory rule is a nested set of attributes  given by
+ *	%NL80211_ATTR_REG_RULE_FREQ_[START|END] and
+ *	%NL80211_ATTR_FREQ_RANGE_MAX_BW with an attached power rule given by
+ *	%NL80211_ATTR_REG_RULE_POWER_MAX_ANT_GAIN and
+ *	%NL80211_ATTR_REG_RULE_POWER_MAX_EIRP.
  * @NL80211_CMD_REQ_SET_REG: ask the wireless core to set the regulatory domain
- * 	to the specified ISO/IEC 3166-1 alpha2 country code. The core will
- * 	store this as a valid request and then query userspace for it.
+ *	to the specified ISO/IEC 3166-1 alpha2 country code. The core will
+ *	store this as a valid request and then query userspace for it.
  *
  * @NL80211_CMD_GET_MESH_CONFIG: Get mesh networking properties for the
  *	interface identified by %NL80211_ATTR_IFINDEX
@@ -574,31 +574,31 @@
  * @NL80211_CMD_FLUSH_PMKSA: Flush all PMKSA cache entries.
  *
  * @NL80211_CMD_REG_CHANGE: indicates to userspace the regulatory domain
- * 	has been changed and provides details of the request information
- * 	that caused the change such as who initiated the regulatory request
- * 	(%NL80211_ATTR_REG_INITIATOR), the wiphy_idx
- * 	(%NL80211_ATTR_REG_ALPHA2) on which the request was made from if
- * 	the initiator was %NL80211_REGDOM_SET_BY_COUNTRY_IE or
- * 	%NL80211_REGDOM_SET_BY_DRIVER, the type of regulatory domain
- * 	set (%NL80211_ATTR_REG_TYPE), if the type of regulatory domain is
- * 	%NL80211_REG_TYPE_COUNTRY the alpha2 to which we have moved on
- * 	to (%NL80211_ATTR_REG_ALPHA2).
+ *	has been changed and provides details of the request information
+ *	that caused the change such as who initiated the regulatory request
+ *	(%NL80211_ATTR_REG_INITIATOR), the wiphy_idx
+ *	(%NL80211_ATTR_REG_ALPHA2) on which the request was made from if
+ *	the initiator was %NL80211_REGDOM_SET_BY_COUNTRY_IE or
+ *	%NL80211_REGDOM_SET_BY_DRIVER, the type of regulatory domain
+ *	set (%NL80211_ATTR_REG_TYPE), if the type of regulatory domain is
+ *	%NL80211_REG_TYPE_COUNTRY the alpha2 to which we have moved on
+ *	to (%NL80211_ATTR_REG_ALPHA2).
  * @NL80211_CMD_REG_BEACON_HINT: indicates to userspace that an AP beacon
- * 	has been found while world roaming thus enabling active scan or
- * 	any mode of operation that initiates TX (beacons) on a channel
- * 	where we would not have been able to do either before. As an example
- * 	if you are world roaming (regulatory domain set to world or if your
- * 	driver is using a custom world roaming regulatory domain) and while
- * 	doing a passive scan on the 5 GHz band you find an AP there (if not
- * 	on a DFS channel) you will now be able to actively scan for that AP
- * 	or use AP mode on your card on that same channel. Note that this will
- * 	never be used for channels 1-11 on the 2 GHz band as they are always
- * 	enabled world wide. This beacon hint is only sent if your device had
- * 	either disabled active scanning or beaconing on a channel. We send to
- * 	userspace the wiphy on which we removed a restriction from
- * 	(%NL80211_ATTR_WIPHY) and the channel on which this occurred
- * 	before (%NL80211_ATTR_FREQ_BEFORE) and after (%NL80211_ATTR_FREQ_AFTER)
- * 	the beacon hint was processed.
+ *	has been found while world roaming thus enabling active scan or
+ *	any mode of operation that initiates TX (beacons) on a channel
+ *	where we would not have been able to do either before. As an example
+ *	if you are world roaming (regulatory domain set to world or if your
+ *	driver is using a custom world roaming regulatory domain) and while
+ *	doing a passive scan on the 5 GHz band you find an AP there (if not
+ *	on a DFS channel) you will now be able to actively scan for that AP
+ *	or use AP mode on your card on that same channel. Note that this will
+ *	never be used for channels 1-11 on the 2 GHz band as they are always
+ *	enabled world wide. This beacon hint is only sent if your device had
+ *	either disabled active scanning or beaconing on a channel. We send to
+ *	userspace the wiphy on which we removed a restriction from
+ *	(%NL80211_ATTR_WIPHY) and the channel on which this occurred
+ *	before (%NL80211_ATTR_FREQ_BEFORE) and after (%NL80211_ATTR_FREQ_AFTER)
+ *	the beacon hint was processed.
  *
  * @NL80211_CMD_AUTHENTICATE: authentication request and notification.
  *	This command is used both as a command (request to authenticate) and
@@ -1715,21 +1715,21 @@ enum nl80211_commands {
  *	(see &enum nl80211_plink_action).
  * @NL80211_ATTR_MPATH_NEXT_HOP: MAC address of the next hop for a mesh path.
  * @NL80211_ATTR_MPATH_INFO: information about a mesh_path, part of mesh path
- * 	info given for %NL80211_CMD_GET_MPATH, nested attribute described at
+ *	info given for %NL80211_CMD_GET_MPATH, nested attribute described at
  *	&enum nl80211_mpath_info.
  *
  * @NL80211_ATTR_MNTR_FLAGS: flags, nested element with NLA_FLAG attributes of
  *      &enum nl80211_mntr_flags.
  *
  * @NL80211_ATTR_REG_ALPHA2: an ISO-3166-alpha2 country code for which the
- * 	current regulatory domain should be set to or is already set to.
- * 	For example, 'CR', for Costa Rica. This attribute is used by the kernel
- * 	to query the CRDA to retrieve one regulatory domain. This attribute can
- * 	also be used by userspace to query the kernel for the currently set
- * 	regulatory domain. We chose an alpha2 as that is also used by the
- * 	IEEE-802.11 country information element to identify a country.
- * 	Users can also simply ask the wireless core to set regulatory domain
- * 	to a specific alpha2.
+ *	current regulatory domain should be set to or is already set to.
+ *	For example, 'CR', for Costa Rica. This attribute is used by the kernel
+ *	to query the CRDA to retrieve one regulatory domain. This attribute can
+ *	also be used by userspace to query the kernel for the currently set
+ *	regulatory domain. We chose an alpha2 as that is also used by the
+ *	IEEE-802.11 country information element to identify a country.
+ *	Users can also simply ask the wireless core to set regulatory domain
+ *	to a specific alpha2.
  * @NL80211_ATTR_REG_RULES: a nested array of regulatory domain regulatory
  *	rules.
  *
@@ -1772,9 +1772,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_BSS: scan result BSS
  *
  * @NL80211_ATTR_REG_INITIATOR: indicates who requested the regulatory domain
- * 	currently in effect. This could be any of the %NL80211_REGDOM_SET_BY_*
+ *	currently in effect. This could be any of the %NL80211_REGDOM_SET_BY_*
  * @NL80211_ATTR_REG_TYPE: indicates the type of the regulatory domain currently
- * 	set. This can be one of the nl80211_reg_type (%NL80211_REGDOM_TYPE_*)
+ *	set. This can be one of the nl80211_reg_type (%NL80211_REGDOM_TYPE_*)
  *
  * @NL80211_ATTR_SUPPORTED_COMMANDS: wiphy attribute that specifies
  *	an array of command numbers (i.e. a mapping index to command number)
@@ -1793,15 +1793,15 @@ enum nl80211_commands {
  *	a u32
  *
  * @NL80211_ATTR_FREQ_BEFORE: A channel which has suffered a regulatory change
- * 	due to considerations from a beacon hint. This attribute reflects
- * 	the state of the channel _before_ the beacon hint processing. This
- * 	attributes consists of a nested attribute containing
- * 	NL80211_FREQUENCY_ATTR_*
+ *	due to considerations from a beacon hint. This attribute reflects
+ *	the state of the channel _before_ the beacon hint processing. This
+ *	attributes consists of a nested attribute containing
+ *	NL80211_FREQUENCY_ATTR_*
  * @NL80211_ATTR_FREQ_AFTER: A channel which has suffered a regulatory change
- * 	due to considerations from a beacon hint. This attribute reflects
- * 	the state of the channel _after_ the beacon hint processing. This
- * 	attributes consists of a nested attribute containing
- * 	NL80211_FREQUENCY_ATTR_*
+ *	due to considerations from a beacon hint. This attribute reflects
+ *	the state of the channel _after_ the beacon hint processing. This
+ *	attributes consists of a nested attribute containing
+ *	NL80211_FREQUENCY_ATTR_*
  *
  * @NL80211_ATTR_CIPHER_SUITES: a set of u32 values indicating the supported
  *	cipher suites
@@ -2416,7 +2416,7 @@ enum nl80211_commands {
  *	scheduled scan is started.  Or the delay before a WoWLAN
  *	net-detect scan is started, counting from the moment the
  *	system is suspended.  This value is a u32, in seconds.
-
+ *
  * @NL80211_ATTR_REG_INDOOR: flag attribute, if set indicates that the device
  *      is operating in an indoor environment.
  *
@@ -3823,7 +3823,7 @@ enum nl80211_sta_bss_param {
  *	(u64, to this station)
  * @NL80211_STA_INFO_SIGNAL: signal strength of last received PPDU (u8, dBm)
  * @NL80211_STA_INFO_TX_BITRATE: current unicast tx rate, nested attribute
- * 	containing info as possible, see &enum nl80211_rate_info
+ *	containing info as possible, see &enum nl80211_rate_info
  * @NL80211_STA_INFO_RX_PACKETS: total received packet (MSDUs and MMPDUs)
  *	(u32, from this station)
  * @NL80211_STA_INFO_TX_PACKETS: total transmitted packets (MSDUs and MMPDUs)
@@ -4039,7 +4039,7 @@ enum nl80211_mpath_flags {
  * @NL80211_MPATH_INFO_METRIC: metric (cost) of this mesh path
  * @NL80211_MPATH_INFO_EXPTIME: expiration time for the path, in msec from now
  * @NL80211_MPATH_INFO_FLAGS: mesh path flags, enumerated in
- * 	&enum nl80211_mpath_flags;
+ *	&enum nl80211_mpath_flags;
  * @NL80211_MPATH_INFO_DISCOVERY_TIMEOUT: total path discovery timeout, in msec
  * @NL80211_MPATH_INFO_DISCOVERY_RETRIES: mesh path discovery retries
  * @NL80211_MPATH_INFO_HOP_COUNT: hop count to destination
@@ -4201,8 +4201,8 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_DISABLED: Channel is disabled in current
  *	regulatory domain.
  * @NL80211_FREQUENCY_ATTR_NO_IR: no mechanisms that initiate radiation
- * 	are permitted on this channel, this includes sending probe
- * 	requests, or modes of operation that require beaconing.
+ *	are permitted on this channel, this includes sending probe
+ *	requests, or modes of operation that require beaconing.
  * @NL80211_FREQUENCY_ATTR_RADAR: Radar detection is mandatory
  *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX_TX_POWER: Maximum transmission power in mBm
@@ -4359,14 +4359,14 @@ enum nl80211_bitrate_attr {
 /**
  * enum nl80211_initiator - Indicates the initiator of a reg domain request
  * @NL80211_REGDOM_SET_BY_CORE: Core queried CRDA for a dynamic world
- * 	regulatory domain.
+ *	regulatory domain.
  * @NL80211_REGDOM_SET_BY_USER: User asked the wireless core to set the
- * 	regulatory domain.
+ *	regulatory domain.
  * @NL80211_REGDOM_SET_BY_DRIVER: a wireless drivers has hinted to the
- * 	wireless core it thinks its knows the regulatory domain we should be in.
+ *	wireless core it thinks its knows the regulatory domain we should be in.
  * @NL80211_REGDOM_SET_BY_COUNTRY_IE: the wireless core has received an
- * 	802.11 country information element with regulatory information it
- * 	thinks we should consider. cfg80211 only processes the country
+ *	802.11 country information element with regulatory information it
+ *	thinks we should consider. cfg80211 only processes the country
  *	code from the IE, and relies on the regulatory domain information
  *	structure passed by userspace (CRDA) from our wireless-regdb.
  *	If a channel is enabled but the country code indicates it should
@@ -4385,11 +4385,11 @@ enum nl80211_reg_initiator {
  *	to a specific country. When this is set you can count on the
  *	ISO / IEC 3166 alpha2 country code being valid.
  * @NL80211_REGDOM_TYPE_WORLD: the regulatory set domain is the world regulatory
- * 	domain.
+ *	domain.
  * @NL80211_REGDOM_TYPE_CUSTOM_WORLD: the regulatory domain set is a custom
- * 	driver specific world regulatory domain. These do not apply system-wide
- * 	and are only applicable to the individual devices which have requested
- * 	them to be applied.
+ *	driver specific world regulatory domain. These do not apply system-wide
+ *	and are only applicable to the individual devices which have requested
+ *	them to be applied.
  * @NL80211_REGDOM_TYPE_INTERSECTION: the regulatory domain set is the product
  *	of an intersection between two regulatory domains -- the previously
  *	set regulatory domain on the system and the last accepted regulatory
@@ -4406,21 +4406,21 @@ enum nl80211_reg_type {
  * enum nl80211_reg_rule_attr - regulatory rule attributes
  * @__NL80211_REG_RULE_ATTR_INVALID: attribute number 0 is reserved
  * @NL80211_ATTR_REG_RULE_FLAGS: a set of flags which specify additional
- * 	considerations for a given frequency range. These are the
- * 	&enum nl80211_reg_rule_flags.
+ *	considerations for a given frequency range. These are the
+ *	&enum nl80211_reg_rule_flags.
  * @NL80211_ATTR_FREQ_RANGE_START: starting frequencry for the regulatory
- * 	rule in KHz. This is not a center of frequency but an actual regulatory
- * 	band edge.
+ *	rule in KHz. This is not a center of frequency but an actual regulatory
+ *	band edge.
  * @NL80211_ATTR_FREQ_RANGE_END: ending frequency for the regulatory rule
- * 	in KHz. This is not a center a frequency but an actual regulatory
- * 	band edge.
+ *	in KHz. This is not a center a frequency but an actual regulatory
+ *	band edge.
  * @NL80211_ATTR_FREQ_RANGE_MAX_BW: maximum allowed bandwidth for this
  *	frequency range, in KHz.
  * @NL80211_ATTR_POWER_RULE_MAX_ANT_GAIN: the maximum allowed antenna gain
- * 	for a given frequency range. The value is in mBi (100 * dBi).
- * 	If you don't have one then don't send this.
+ *	for a given frequency range. The value is in mBi (100 * dBi).
+ *	If you don't have one then don't send this.
  * @NL80211_ATTR_POWER_RULE_MAX_EIRP: the maximum allowed EIRP for
- * 	a given frequency range. The value is in mBm (100 * dBm).
+ *	a given frequency range. The value is in mBm (100 * dBm).
  * @NL80211_ATTR_DFS_CAC_TIME: DFS CAC time in milliseconds.
  *	If not present or 0 default CAC time will be used.
  * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
@@ -4507,8 +4507,8 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_PTP_ONLY: this is only for Point To Point links
  * @NL80211_RRF_PTMP_ONLY: this is only for Point To Multi Point links
  * @NL80211_RRF_NO_IR: no mechanisms that initiate radiation are allowed,
- * 	this includes probe requests or modes of operation that require
- * 	beaconing.
+ *	this includes probe requests or modes of operation that require
+ *	beaconing.
  * @NL80211_RRF_AUTO_BW: maximum available bandwidth should be calculated
  *	base on contiguous rules and wider channels will be allowed to cross
  *	multiple contiguous/overlapping frequency ranges.
@@ -4522,9 +4522,9 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_EHT: EHT operation not allowed
  * @NL80211_RRF_PSD: Ruleset has power spectral density value
  * @NL80211_RRF_DFS_CONCURRENT: Operation on this channel is allowed for
-	peer-to-peer or adhoc communication under the control of a DFS master
-	which operates on the same channel (FCC-594280 D01 Section B.3).
-	Should be used together with %NL80211_RRF_DFS only.
+ *	peer-to-peer or adhoc communication under the control of a DFS master
+ *	which operates on the same channel (FCC-594280 D01 Section B.3).
+ *	Should be used together with %NL80211_RRF_DFS only.
  * @NL80211_RRF_NO_6GHZ_VLP_CLIENT: Client connection to VLP AP not allowed
  * @NL80211_RRF_NO_6GHZ_AFC_CLIENT: Client connection to AFC AP not allowed
  */

-- 
2.42.0


