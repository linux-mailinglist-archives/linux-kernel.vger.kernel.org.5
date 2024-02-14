Return-Path: <linux-kernel+bounces-64874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178B2854425
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C586628917C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276C66FD5;
	Wed, 14 Feb 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nyvoMJfu"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF66FAD;
	Wed, 14 Feb 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900169; cv=none; b=UDFPAN20D+N4kis9HZYFTywFTd20maMVB8WqyQdQYyM07dwlbj4RhSCQcaZDP5BVSTSJ2ybDSN6C2BEX7OTXk+QSS6JViShi+KquaYuAsxLsFHbakvPhscZQ6dg4aW+zRxXLyTUVBMvBkyFQtQXGS+2rKS66CQJz3Hhkhp1Rd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900169; c=relaxed/simple;
	bh=cQ7ey7w8wt3lNYqkfFPRTDVyX+jY3R2zNfbWoLshh74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVE0hSXoepzbTRW4Iu8po1rEnomtwzSP7T0+lDq8QvWT+9mIJZjPpPgKvY2IkGomcA0y20CkVKc2rgrrMrQf1gx4hoaKa/+OTAvHJj5KS7yGRZgidKLXV+OWZiH4m04l6sHXG5NSWqqlQ054HhkBaq50u/js8RmJDhnTQ/Rqgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nyvoMJfu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D87D41BF20E;
	Wed, 14 Feb 2024 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707900164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv66vnT3uWpmwK5vL0oxQ5i9QWjHzZcZ6TRaxRZ78Z8=;
	b=nyvoMJfu+S5UHF57qKJYh+mmIYTAjy13qIWhIMbs7exxtbxZm7Yw0ZKy2gmJAJzcx4PXx7
	uM1HIT2ZE5EKdk3DrnFvDCkGPXg6/M4ZzKYlJEuYAuw+DtYiAXJ9/QqHPwzK7qg3Q3EI2m
	Ma0RhhkK/oN/AUAeX7EleuVVvapcB57bHUXXo+ou6CnL8lmpRlFvQfV+Z3mrKDkiepNRkO
	cuKPrniyxalFJo1zcRiwPZTJi/AIQi12Gf6pJEXs49OBVPiJNUgCQSVoOrpqap+0FyBk1m
	I0QqDRksI2XiYGYDPQNE2vt1Vqgl/YYys9A2FRZ/OGVpLPZY90BtJgz6UARVGw==
Message-ID: <09eeb7d4-c922-45ee-a1ac-59942153dbce@bootlin.com>
Date: Wed, 14 Feb 2024 09:42:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
To: Kalle Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>
References: <202308290615.lUTIgqUl-lkp@intel.com> <877cpev0pn.fsf@kernel.org>
 <87a5uatfl1.fsf@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <87a5uatfl1.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Ajay, Kalle,

On 8/29/23 10:31, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> kernel test robot <lkp@intel.com> writes:

[...]

>>> sparse warnings: (new ones prefixed by >>)
>>>>> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int key_mgmt_suite @@     got restricted __be32 [usertype] @@
>>>    drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     expected unsigned int key_mgmt_suite
>>>    drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse:     got restricted __be32 [usertype]
>>
>> Yeah, this is an old issue but we really should try to fix this,
>> especially so as I would like to make wireless code sparse warning free
>> in the near future. IIRC there were some problems with nl80211 interface
>> as well so this might not be simple fix still.
> 
> For reference here's the old discussion:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20220720160302.231516-1-ajay.kathat@microchip.com/
> 
> Any volunteers to help fix this? I would prefers fixes for issues like
> this compared to questionable random cleanups we always get.

I'm bumping this old thread because it looks like the sparse warning is still
present in WILC driver, and I would gladly help getting rid of it, but since
there's already been a fair amount of discussions around it, I am not sure what
is expected/what should be done. Here is my understanding so far:
- Ajay has proposed a patch ([1]) which indeed fixes the warning but involves
many casts
- Johannes and Jouni then gave details about the original issue leading to those
casts ([2]): wpa_supplicant somehow forces the AKM suites values to be be32 at
some point, while it should be treated in host endianness
- as pointed by Ajay, the corresponding fix has been made since then by Jouni in
wpa_supplicant ([3]). The fix make sure to handle key_mgmt_suite in host
endianness AND to keep compatibility with current drivers having the be32 fix. -
 - It could have allowed to simply get rid of the all casts on AKM suites in
wilc driver ([4]), but then new kernel/drivers would break with existing
userspace, so it is not an option

Now, I see multiple options to fix the sparse warning:
- apply the same fix as for wpa_supplicant ([3]) in wilc driver (so basically,
become compatible with both endianness)
- apply the same fix as for wpa_supplicant ([3]), not in wilc but in nl80211
(may need to update not only wilc but any driver having trailing be32 cast on
AKM suites)
- take the initial quick but not-so-nice double cast fix and call it a day

What's your opinion on this ?

[1]
https://lore.kernel.org/linux-wireless/20220720160302.231516-1-ajay.kathat@microchip.com/
[2]
https://lore.kernel.org/linux-wireless/e677e3cd1b5c34146017a65f28fabdb673a91d23.camel@sipsolutions.net/
[3] https://w1.fi/cgit/hostap/commit/?id=8392ea9e75eacf30cb09671e463d9a37c3eadd6a
[4]
https://lore.kernel.org/linux-wireless/20230830042300.87184-1-ajay.kathat@microchip.com/

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


