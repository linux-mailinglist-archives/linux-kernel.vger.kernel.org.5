Return-Path: <linux-kernel+bounces-105542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8F87DFED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791F11F2152C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314271F94C;
	Sun, 17 Mar 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqSm2k4Z"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C61EF0D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710706059; cv=none; b=hfWHgbhE/k4Ck+h7AoJ34qNqFM9/lwRTiuaTnPNFR3ha27gNQxoKHPpO3e0IEEM5Wv47lz0MoZvB+HHzY/hyt2++AwwLXV7rIsE8lTyE6z91mQA3O6Ek2qBFg91FmdzTjaUJgyG+tM2g/kOLUfscsilQFYl6WjueyiJYhu7sCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710706059; c=relaxed/simple;
	bh=kdZ6u9Ut7hq0bFYMJMl7COnPyTq4zEv4NiIpOq2MWP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHY/P7Tt5iNpwAOUcpj/HDnRbi6X3bk/NGjBJZCmaOHwdQ1rGLkhI8+6v0ykhQbrV7fe5HAEXEsVeyF9/9/dBBcAk1Q8tMdM+eMEJXaScZzNN9EW3FMZTNIO7UzTy7Tf9xg8964vPcuVkVaDmpQp1Pe9wW37v6fU+EKcqLFLiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqSm2k4Z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4683f79d89so78810566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710706056; x=1711310856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4qvZkUQarrx0iYNI4lczPEauFHLXfI/CeYtxbbYnts=;
        b=kqSm2k4ZDShDqYdP9NmC5HevL2PncEf8tXnUeaiv4vn27N+cAfa8UXpvEgvWxw4f5z
         A2RXY9CKS0pZNESrxMuiGL/lcBNqjUeNF1DkjWUJRww3qO+Y0tbAQYnoL95G0umdg/Yk
         fUpKckrOL0gmrxew7HSkBvU1givkxiWYVlFsg9rvYb51weKy8S0vCYGTi3mfmTox6VUl
         NOtj6GHypvCFfudiA8qXVZzlJ2UKcQv20/3XvxfnCS9tQG5Mbwc57KJo0Mh7w1j+yhrS
         bWK2c/oSwOTgnD7H7oyqpIm8EjpKmpkXJEOxZl/b507NqjANcOd7hd/5DTY5Eq4Z8pQ4
         vPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710706056; x=1711310856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4qvZkUQarrx0iYNI4lczPEauFHLXfI/CeYtxbbYnts=;
        b=DLaJs0dvEEd1dub0w5Sjw2D2qdH9yMbmrssQtbC24P/hspeCZa0+A3H865XXDDMNzC
         jKjAfF88lUn+8lryJT3IC3f44cD5i2prp+CmuHXryvCUGMWCjDZtP0D88HKn2/y55sx4
         Xv5u6T0Z9vzIcDaGD2krTkvRz0j//6Xddd4IUKFyaThV1Axp6HFdLxQ1C2BKmfsKagok
         JAfrAmm/CTmntqzLDlxH3j9AXwJAfKaiHINiD3NKOPe6HaW3+tHV6bQfY16Jl7rMG0oP
         8To8By5uEmY/xsuHuQMguw0TgnPHrEq9zFrXWXGPLaL+Iv3NcU33GkuFewErQt1KMceQ
         eukA==
X-Forwarded-Encrypted: i=1; AJvYcCWoT5cr8uu2Wx5+xG0DTCv2BSzLfR5BO26oj0oRq/HoEvXTsPDlFPBYuh8m2d3+bywS5CLtrnLcHk07flfU0k+IHzCh8nBSFaEFwD3p
X-Gm-Message-State: AOJu0YzkKCVW92U/1nykb+B1aHezW661UWPuUdLTD4WI0gvYv+6a5HnJ
	wu/Rk521f7fqmcpzAqr7dm7xavRO3lJObEQGoKke/HUgy49F1Qf3
X-Google-Smtp-Source: AGHT+IGH8v2ezB+ucuzXtpOUhaAWijlhYPJr5qUhZXrNfUz4HvronYNFXKEvNtU/vbrW/qLfDalJGw==
X-Received: by 2002:a17:907:720b:b0:a46:aaaa:9424 with SMTP id dr11-20020a170907720b00b00a46aaaa9424mr2979935ejc.5.1710706055903;
        Sun, 17 Mar 2024 13:07:35 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id h21-20020a17090619d500b00a46447348e8sm4059941ejd.191.2024.03.17.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 13:07:35 -0700 (PDT)
Message-ID: <6c772d15-d249-4175-93f4-ca523006129b@gmail.com>
Date: Sun, 17 Mar 2024 21:07:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Lee Jones <lee@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Larry.Finger@lwfinger.net, johannes@sipsolutions.net, kvalo@kernel.org,
 arnd@arndb.de
References: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
 <fba3951f-00b7-41af-8ef4-1e7c86e0cb48@moroto.mountain>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <fba3951f-00b7-41af-8ef4-1e7c86e0cb48@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/24 08:04, Dan Carpenter wrote:
> On Sat, Mar 09, 2024 at 11:09:24PM +0100, Philipp Hortmann wrote:
>> Hi,
>>
>> I would remove the driver from the mainline kernel. What are your thoughts?
>>
>> I bought two WLAN devices (DUT: D-Link DWL-122 and T-Sinus 111 data) that
>> are supported by wlan-ng driver. Issue is that the driver is not working
>> anymore.
>>
>> The error picture is that the device does not receive any packets.
>> The dmesg says:
>> [  123.695917] prism2_usb 2-1.6:1.0 wlan0: Unknown mgmt request message
>> 0x0e4f9800
>> [  127.508211] prism2_usb 2-1.6:1.0 wlan0: Unknown mgmt request message
>> 0x04f0d000
>> ...
>>
>> A working commit 8fc4fb1728855a22f9149079ba51877f5ee61fc9 (HEAD) Date: Mon
>> Jul 5 11:16:28 2021 -0700
>> A failing commit  d980cc0620ae77ab2572235a1300bf22519f2e86 (HEAD) Date:  Fri
>> Jul 16 19:08:09 2021 -0700
> 
> Those dates are 11 days apart during the v5.14 merge window.  You're
> saying 5.15 is broken but the broken commit is in 5.14-rc2 so it really
> was broken earlier.
> 
> There were only 3 patches to wlan-ng between v5.13 and v5.14.
> 
> $ git log --oneline v5.13..v5.14 drivers/staging/wlan-ng/
> b1e9109aeff3 staging: wlan-ng: silence incorrect type in argument 1 (different address spaces)
> ad843f392035 staging: wlan-ng: remove redundant initialization of variable txresult
> ea82ff749587 staging: wlan-ng: cfg80211: Move large struct onto the heap
> 
> Obviously I'm going to suspect the largest patch.  Reviewing that patch
> now, I see we removed a memset() from the loop.  That seems like a bug.
> 
> -               memset(&msg2, 0, sizeof(msg2));
> -               msg2.msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
> -               msg2.bssindex.data = i;
> +               msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
> +               msg2->bssindex.data = i;
> 
> That's the only interesting change so I suspect it's the issue...
> Could you test this patch?  I feel like if you're the first person to
> complain since Aug 29 2021 then probably we should just remove the
> driver.  Greg is on vacation so lets hold off on removing it until he
> comes back.
> 
> regards,
> dan carpenter
> 
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 471bb310176f..0c270ed8ce67 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -347,6 +347,7 @@ static int prism2_scan(struct wiphy *wiphy,
>   	for (i = 0; i < numbss; i++) {
>   		int freq;
>   
> +		memset(msg2, 0, sizeof(*msg2));
>   		msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
>   		msg2->bssindex.data = i;
>   


Hi Dan,

sorry it is so crowded here.

You are right with the statement that it is this commit.
commit ea82ff749587807fa48e3277c977ff3cec266f25 (HEAD)
Author: Lee Jones <lee.jones@linaro.org>
Date:   Wed Apr 14 19:10:39 2021 +0100

     staging: wlan-ng: cfg80211: Move large struct onto the heap

     Fixes the following W=1 kernel build warning(s):

      drivers/staging/wlan-ng/cfg80211.c: In function ‘prism2_scan’:
      drivers/staging/wlan-ng/cfg80211.c:388:1: warning: the frame size 
of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]

But It is not depending on the line you pointed to.

I need another week to look into this.

Thanks for your support.

Bye Philipp


