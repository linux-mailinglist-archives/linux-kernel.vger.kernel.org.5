Return-Path: <linux-kernel+bounces-6290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178968196D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FED288A96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530C8C06;
	Wed, 20 Dec 2023 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kacXMSXl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859DFC07;
	Wed, 20 Dec 2023 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vI6BjtvZa1OtwQfscOfCYySPSF4W/z+9OUCWNtr2S0Q=; b=kacXMSXlVR7wQyIQbqm2dFOL2y
	75gcSjsTqGnIEzCDqmkcRrCl4P7oVgOF/TSgbLHJ1cu2wL2qo6F+g80/UW42QLcYUygeJvsTY14Jd
	S0MgiIheFV2Xn7RnUkxrVk1mwSDHkql9aZbxtDS6aOdcw10uCHvaBxLOxSDXcbY5ZNUZv8v9yHzol
	XFg45yBJZ2mgEzsldQC3sPM0meY9t1fEzsQzcKRaO5p/PS5buuDQiK83zPAi0GMDtQE+uj0mNIc+e
	FBnrSm5aOvPjF0FHmt3bia5VdPmL7wGUcAUWRZbvnDD3AXoVJlp69GYLkyeNkTcuqobsFDKrZ2iMn
	Nk4Mwiuw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFmL1-00FyTs-0t;
	Wed, 20 Dec 2023 02:29:35 +0000
Message-ID: <5e0e5d84-3891-47a1-bce1-beb26cd19b7b@infradead.org>
Date: Tue, 19 Dec 2023 18:29:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: address several kerneldoc warnings
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Jonathan Corbet
 <corbet@lwn.net>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <87plz1g2sc.fsf@meer.lwn.net>
 <56d7f97e-bc8b-465f-9e59-80028ccec995@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <56d7f97e-bc8b-465f-9e59-80028ccec995@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 17:00, Jeff Johnson wrote:
> On 12/19/2023 4:01 PM, Jonathan Corbet wrote:
>> include/net/cfg80211.h includes a number of kerneldoc entries for struct
>> members that do not exist, leading to these warnings:
>>
>>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'band_pref' description in 'cfg80211_bss_selection'
>>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'adjust' description in 'cfg80211_bss_selection'
>>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'bssid' description in 'wireless_dev'
>>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'beacon_interval' description in 'wireless_dev'
>>   ./include/net/cfg80211.h:7299: warning: Excess struct member 'bss' description in 'cfg80211_rx_assoc_resp_data'
>>
>> Remove and/or repair each entry to address the warnings and ensure a proper
>> docs build for the affected structures.
>>
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  include/net/cfg80211.h | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index b137a33a1b68..81c46c8e2a68 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -3180,8 +3180,8 @@ struct cfg80211_ibss_params {
>>   *
>>   * @behaviour: requested BSS selection behaviour.
>>   * @param: parameters for requestion behaviour.
>> - * @band_pref: preferred band for %NL80211_BSS_SELECT_ATTR_BAND_PREF.
>> - * @adjust: parameters for %NL80211_BSS_SELECT_ATTR_RSSI_ADJUST.
>> + * @param.band_pref: preferred band for %NL80211_BSS_SELECT_ATTR_BAND_PREF.
>> + * @param.adjust: parameters for %NL80211_BSS_SELECT_ATTR_RSSI_ADJUST.
>>   */
>>  struct cfg80211_bss_selection {
>>  	enum nl80211_bss_select_attr behaviour;
>> @@ -6013,7 +6013,6 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
>>   *	wireless device if it has no netdev
>>   * @u: union containing data specific to @iftype
>>   * @connected: indicates if connected or not (STA mode)
>> - * @bssid: (private) Used by the internal configuration code
>>   * @wext: (private) Used by the internal wireless extensions compat code
>>   * @wext.ibss: (private) IBSS data part of wext handling
>>   * @wext.connect: (private) connection handling data
>> @@ -6033,8 +6032,6 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
>>   * @mgmt_registrations: list of registrations for management frames
>>   * @mgmt_registrations_need_update: mgmt registrations were updated,
>>   *	need to propagate the update to the driver
>> - * @beacon_interval: beacon interval used on this device for transmitting
>> - *	beacons, 0 when not valid
>>   * @address: The address for this device, valid only if @netdev is %NULL
>>   * @is_running: true if this is a non-netdev device that has been started, e.g.
>>   *	the P2P Device.
>> @@ -7270,8 +7267,6 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
>>  
>>  /**
>>   * struct cfg80211_rx_assoc_resp_data - association response data
>> - * @bss: the BSS that association was requested with, ownership of the pointer
>> - *	moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
>>   * @buf: (Re)Association Response frame (header + body)
>>   * @len: length of the frame data
>>   * @uapsd_queues: bitmap of queues configured for uapsd. Same format
>> @@ -7281,6 +7276,8 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
>>   * @ap_mld_addr: AP MLD address (in case of MLO)
>>   * @links: per-link information indexed by link ID, use links[0] for
>>   *	non-MLO connections
> 
> also missing the following?
>  * @links.addr: MLO per-link MAC address

Yes, that should also be fixed at some point.

What Jon is trying to do here is address a boatload of new kernel-doc warnings of the
"Excess struct member" variety.

> 
>> + * @links.bss: the BSS that association was requested with, ownership of the
>> + *      pointer moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
>>   * @links.status: Set this (along with a BSS pointer) for links that
>>   *	were rejected by the AP.
>>   */
> 
> 

Thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

