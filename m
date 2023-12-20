Return-Path: <linux-kernel+bounces-6219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611AC819610
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD66286AED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781C5245;
	Wed, 20 Dec 2023 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XZBNDm6N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B668BFB;
	Wed, 20 Dec 2023 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK0mkVv024938;
	Wed, 20 Dec 2023 01:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=95AyH6yKUSc2IRZWBWByifDc44CB6+hmYpeugyo+d5w=; b=XZ
	BNDm6NycnjyQXpolJkC0y5IH4xyoIJZqh0MMLzkY+foELStqnYLsvvZ9T7zOd8ax
	B2KuPyIUqCYCbAXiyC+hjwldCXbFgiaO+geZUlTZvmWH51PgMTOl9bnHSmfVz8In
	vbNXBRWA+2HRK1Ihin5kBNgZqYJygT3ioySP2iGkQ/ECZWDvAzfgGwMv3j+ZIdfB
	SHsoCkFyNPo/KvS6ckUJsAXLO3YRHIGoKDepQeQ9HxZzWK844A0YxFFUDoqqmQfG
	Of7ypq/WXtiJPdwfpNciiocEijrEqOSXvINA8iLbn3pk8+Kt1zorfHLPHYcmSQxH
	CVagtXW4RsJyao3qYieA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v38qssyy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 01:00:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK10RmY020923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 01:00:27 GMT
Received: from [10.110.4.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 17:00:27 -0800
Message-ID: <56d7f97e-bc8b-465f-9e59-80028ccec995@quicinc.com>
Date: Tue, 19 Dec 2023 17:00:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: address several kerneldoc warnings
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <87plz1g2sc.fsf@meer.lwn.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87plz1g2sc.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eZ-R2n_ohw8x7HfLjPf3l8-ObObKjJoe
X-Proofpoint-ORIG-GUID: eZ-R2n_ohw8x7HfLjPf3l8-ObObKjJoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200004

On 12/19/2023 4:01 PM, Jonathan Corbet wrote:
> include/net/cfg80211.h includes a number of kerneldoc entries for struct
> members that do not exist, leading to these warnings:
> 
>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'band_pref' description in 'cfg80211_bss_selection'
>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'adjust' description in 'cfg80211_bss_selection'
>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'bssid' description in 'wireless_dev'
>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'beacon_interval' description in 'wireless_dev'
>   ./include/net/cfg80211.h:7299: warning: Excess struct member 'bss' description in 'cfg80211_rx_assoc_resp_data'
> 
> Remove and/or repair each entry to address the warnings and ensure a proper
> docs build for the affected structures.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  include/net/cfg80211.h | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index b137a33a1b68..81c46c8e2a68 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -3180,8 +3180,8 @@ struct cfg80211_ibss_params {
>   *
>   * @behaviour: requested BSS selection behaviour.
>   * @param: parameters for requestion behaviour.
> - * @band_pref: preferred band for %NL80211_BSS_SELECT_ATTR_BAND_PREF.
> - * @adjust: parameters for %NL80211_BSS_SELECT_ATTR_RSSI_ADJUST.
> + * @param.band_pref: preferred band for %NL80211_BSS_SELECT_ATTR_BAND_PREF.
> + * @param.adjust: parameters for %NL80211_BSS_SELECT_ATTR_RSSI_ADJUST.
>   */
>  struct cfg80211_bss_selection {
>  	enum nl80211_bss_select_attr behaviour;
> @@ -6013,7 +6013,6 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
>   *	wireless device if it has no netdev
>   * @u: union containing data specific to @iftype
>   * @connected: indicates if connected or not (STA mode)
> - * @bssid: (private) Used by the internal configuration code
>   * @wext: (private) Used by the internal wireless extensions compat code
>   * @wext.ibss: (private) IBSS data part of wext handling
>   * @wext.connect: (private) connection handling data
> @@ -6033,8 +6032,6 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
>   * @mgmt_registrations: list of registrations for management frames
>   * @mgmt_registrations_need_update: mgmt registrations were updated,
>   *	need to propagate the update to the driver
> - * @beacon_interval: beacon interval used on this device for transmitting
> - *	beacons, 0 when not valid
>   * @address: The address for this device, valid only if @netdev is %NULL
>   * @is_running: true if this is a non-netdev device that has been started, e.g.
>   *	the P2P Device.
> @@ -7270,8 +7267,6 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
>  
>  /**
>   * struct cfg80211_rx_assoc_resp_data - association response data
> - * @bss: the BSS that association was requested with, ownership of the pointer
> - *	moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
>   * @buf: (Re)Association Response frame (header + body)
>   * @len: length of the frame data
>   * @uapsd_queues: bitmap of queues configured for uapsd. Same format
> @@ -7281,6 +7276,8 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
>   * @ap_mld_addr: AP MLD address (in case of MLO)
>   * @links: per-link information indexed by link ID, use links[0] for
>   *	non-MLO connections

also missing the following?
 * @links.addr: MLO per-link MAC address

> + * @links.bss: the BSS that association was requested with, ownership of the
> + *      pointer moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
>   * @links.status: Set this (along with a BSS pointer) for links that
>   *	were rejected by the AP.
>   */


