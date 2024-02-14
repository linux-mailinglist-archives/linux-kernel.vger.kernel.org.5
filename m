Return-Path: <linux-kernel+bounces-65095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5058547B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79651F252DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36F18E2E;
	Wed, 14 Feb 2024 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K/XwVZ/f"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAC1643A;
	Wed, 14 Feb 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908601; cv=none; b=kbs/3jlbdOUCKbRu/EcdvOGC+ISm1hzv0AH8JtMSUa3j/YCxN0/Y2yPv36dca343fpwTfByy337L1DQbUG5T8G8xM+8HYAkLDHcNyu8hzJxrjAuIwVc8t7b5U2W6wnb2qsGu7hbbOXD+uBuB3Q97x7hvvuvwymIX6HXFpscELow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908601; c=relaxed/simple;
	bh=PtSNdfznwWbqhoQQFKH7/wNCSFcUYs/wTcLDeBDVllI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZMgZf/R9Ibw6o3JXeRcpMTHmlp/XadqIYYUrftaVHh3SS3n3KCo47lRcbxCboXQYwDud+fF9ONqWQfrU3TYIL4JZLai5rfRd5EylLxldda+bhFXT4jaGVucowQaKBNFiXF2/xhwVmX/GcmkkTOieYZSVpfyr/9tgFeIG10Zgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K/XwVZ/f; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B86DFF80B;
	Wed, 14 Feb 2024 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707908597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbA2a2kIur1xwjNXnDhSYrVB1/GrR0EMUnG/VimlxgE=;
	b=K/XwVZ/fB4w4yax/6+s7vgiB6S4qHn0RubxBy/oW9XrM2CGyyhllgvgGkRshU3bL+UjvrU
	Hd1BcPEOPEchireGDLgD7pCdrPN5VH8yopOav4qSn3pT00s+yIaoFkjJN+YZdSKcbJWayO
	Z/JyRVg8klPka2AIsb/mrit5xkBihPAT9tl3v7cq7Z0+UvtqVK8bwNWDSPu+nmnrbRyWLu
	2kxaSg1+aMIis6xWCNKufUi/C1T2IBMgsDFayKGwrxd2q69lwfJymy/+B/Wq0jDgfIOXnV
	H7K1C+GV2A7zExwsO+PhlYMSyBsHYAEwR7zcxA/SndS/4USUzzKC0y9x2LMqKQ==
Message-ID: <912f4e56-bd30-48c1-bf24-dd728188b1c5@bootlin.com>
Date: Wed, 14 Feb 2024 12:03:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
 kernel test robot <lkp@intel.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <202308290615.lUTIgqUl-lkp@intel.com> <877cpev0pn.fsf@kernel.org>
 <87a5uatfl1.fsf@kernel.org>
 <09eeb7d4-c922-45ee-a1ac-59942153dbce@bootlin.com>
 <e9501c13be127b8b9d0c769a27d8d38636875f0f.camel@sipsolutions.net>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <e9501c13be127b8b9d0c769a27d8d38636875f0f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/14/24 10:29, Johannes Berg wrote:
> Hi,
> 
>>> For reference here's the old discussion:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20220720160302.231516-1-ajay.kathat@microchip.com/
>>>
>>> Any volunteers to help fix this? I would prefers fixes for issues like
>>> this compared to questionable random cleanups we always get.
>>
>> I'm bumping this old thread because it looks like the sparse warning is still
>> present in WILC driver, and I would gladly help getting rid of it, but since
>> there's already been a fair amount of discussions around it, I am not sure what
>> is expected/what should be done. Here is my understanding so far:
>> - Ajay has proposed a patch ([1]) which indeed fixes the warning but involves
>> many casts
>> - Johannes and Jouni then gave details about the original issue leading to those
>> casts ([2]): wpa_supplicant somehow forces the AKM suites values to be be32 at
>> some point, while it should be treated in host endianness
>> - as pointed by Ajay, the corresponding fix has been made since then by Jouni in
>> wpa_supplicant ([3]). The fix make sure to handle key_mgmt_suite in host
>> endianness AND to keep compatibility with current drivers having the be32 fix. -
> 
> Am I confused, or is the change [3] in the other direction?
> 
> From what I see, the code there (now changed again, btw) is about
> reading the value *from the driver*.

Ah, you are right, so [3] is rather about supporting drivers sending values with
host endianness, while interface historically expects big endian :/
> 
> The driver change is about getting the value *from the supplicant*.
> 
> And the _outgoing_ code (sending it to the driver) from the supplicant
> has - as far as I can tell - been putting it into the attribute in host
> byte order forever? See commit cfaab58007b4 ("nl80211: Connect API
> support").
> 
> 
> Aha! So, I'm not _completely_ confused, 

So I am the one confused :) Thanks for the clarification. I did not dig enough,
and since the cast is done right at connect message reception, I assumed wrongly
that the issue was on the supplicant->driver path.

> however, the only use of this value in this driver is sending it back to the supplicant!> Which seems entirely wrong, since the supplicant assumes basically anything
will be
> handled?

Not sure to fully understand why its wrong (supplicant seems to expect AKM
suites to be provided) , but I may be lacking more general understanding about
the external auth process.
Or do you mean that AKM suites should be enforced to RSN_AUTH_KEY_MGMT_SAE only
in this driver->supplicant call (and so, not forward any possible value ?)

> (But - the firmware also has a parameter key_mgmt_suites [in struct
> wilc_external_auth_param] which is never even set in
> wilc_set_external_auth_param??)
> 
> 
> Also note that the supplicant will *only* read RSN_AUTH_KEY_MGMT_SAE in
> big endian, so you've already lost here pretty much?

So we have to keep some big endian conversion on the driver/nl80211 ->
supplicant path, IIUC


>>  - It could have allowed to simply get rid of the all casts on AKM suites in
>> wilc driver ([4]), but then new kernel/drivers would break with existing
>> userspace, so it is not an option
> 
> I am wondering if it works at all ...
> 
>> Now, I see multiple options to fix the sparse warning:
>> - apply the same fix as for wpa_supplicant ([3]) in wilc driver (so basically,
>> become compatible with both endianness)
> 
> But this cannot be done! On input to the driver, the value is in host
> byte order always. The question is on output - and there you cannot
> detect it.

Yeah, this suggestion is wrong because of the misunderstanding clarified above.

>> - apply the same fix as for wpa_supplicant ([3]), not in wilc but in nl80211
>> (may need to update not only wilc but any driver having trailing be32 cast on
>> AKM suites)

So to fix my initial suggestion, it is not "doing the same fix" but rather "move
the be conversion from the driver to nl80211 layer". Which matches in fact what
you are suggesting below.

> That might even work? Well, not the same fix, since again input vs.
> output, but something like this:
> 
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -20136,9 +20136,27 @@ int cfg80211_external_auth_request(struct net_device *dev,
>  	if (!hdr)
>  		goto nla_put_failure;
>  
> +	/*
> +	 * Some drivers and due to that userspace (wpa_supplicant) were
> +	 * in the past interpreting this value as a big-endian value,
> +	 * at a time where only WLAN_AKM_SUITE_SAE was used. This is now
> +	 * fixed, but for the benefit of older wpa_supplicant versions,
> +	 * send this particular value in big-endian. Note that newer
> +	 * wpa_supplicant will also detect this particular value in big
> +	 * endian still, so it all continues to work.
> +	 */
> +	if (params->key_mgmt_suite == WLAN_AKM_SUITE_SAE) {
> +		if (nla_put_be32(msg, NL80211_ATTR_AKM_SUITES,
> +				 cpu_to_be32(WLAN_AKM_SUITE_SAE))
> +			goto nla_put_failure;
> +	} else {
> +		if (nla_put_u32(msg, NL80211_ATTR_AKM_SUITES,
> +				params->key_mgmt_suite)))
> +			goto nla_put_failure;
> +	}
> +
>  	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
>  	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
> -	    nla_put_u32(msg, NL80211_ATTR_AKM_SUITES, params->key_mgmt_suite) ||
>  	    nla_put_u32(msg, NL80211_ATTR_EXTERNAL_AUTH_ACTION,
>  			params->action) ||
>  	    nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, params->bssid)
> ||

If this kind of fix is ok in nl80211, I can do some tests with it, see how it
would affect other drivers ( I think there's only Quantenna driver which would
be affected)

Thanks,

Alexis

>> - take the initial quick but not-so-nice double cast fix and call it a day
> 
> but that doesn't actually work for anything other than
> WLAN_AKM_SUITE_SAE...


> 
> johannes
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


