Return-Path: <linux-kernel+bounces-70813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A3859CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80895284119
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14220208D7;
	Mon, 19 Feb 2024 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBImsdTv"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE16208B9;
	Mon, 19 Feb 2024 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327134; cv=none; b=PnnWJnaLe79erTMzf0XAUU9hbCPCscmD6s/2bfzgD4IRmOOzW6wepSoF4NwjlL+j6U/xVWmQJhXrO4nI5HlXJSb1teJxqIrwi5hVGlzPO0tdS+b2ckw1vc85/tW/NFixt/tyckH5Rovv5TYtHoOUpiiStUX+qXOKLJGrcsYKTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327134; c=relaxed/simple;
	bh=lm1PlqVLoGDEZnLoK6vHhxGWJUzUGb8zGartg2K/7EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtHiYhYVbq25tjw1YBrsGU3o/0pOW775MDRZJIfpiUXAYacj2Bj8ZpxycikxGL6IYBXEfCNHApev1hlfoXL3gL0B6WFYtxotWqO8M2Yq0U41l2K7GyLsTtpy4kiZP9l69YgGOmgN74KvLADxPh2JS/AgWuGRKh8wORtq70i/omc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBImsdTv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512b69f6c22so289622e87.2;
        Sun, 18 Feb 2024 23:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708327131; x=1708931931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsY8L+6XXJAzku0PhMBAkzqv7lmk4rGmLx3vYseByc4=;
        b=JBImsdTvR3fmQ7PpzYSU84UEZX5V9nMWyjrMIAOsU6J3Drf5KF7u32Gi9ZdpdjITw2
         h/ELNZP8XJY4loyfSDVQjo+dZAcIzxzg6fc0nfL5vWwQ+KStTQ5jWM3EDgK/wWTb5eKm
         nR3NAJaUL0U2g7z5KvcUf0cpzi0aMOy+n+us9YT8A4Netu5TmziYGq/mcbohUna+D2oa
         ODuiJAnF7kORlSeYrRaSu9cTgit9DrQlbCwyMYdLZIb5qGMjz/1Y/TnHqGLEda7ze5rR
         xIdsA3yfACxgzzBclRcPopfvzvJHGdkhRghev4cJxZCGtgX08L9v8SU7nxKP4HJvRnIJ
         GeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708327131; x=1708931931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsY8L+6XXJAzku0PhMBAkzqv7lmk4rGmLx3vYseByc4=;
        b=anEQLjW/R/7bUIXAP4aGIvuz7V8QW5p82XmSUoVwlzbRo7dhy63J2/uoLzlROnqiWh
         PaxB/K84trdrYn83DrR/B9/gl4Fzvticu0cBlodvwgeJJWIf7zNdttO8GWaAlpXNlSfQ
         p6KpVjEQu/vkI8CdMj+z+7WYUrxKsskd2PvHGHFQaUhaVzO5nJYY3v7zmSYlOmjbPAn2
         J4a7lG0LnjVadWNl//S4zuVmc7TnvO7DmqGX6xoFFeZwZST0k+gt8CY/nElb1WwB0HGR
         AsCgZFozQwM5oDSRkLscCZyOgd3x1CeUDREi3N/jaYGjxIOP8u0o+9EbsFDpU2GCa635
         ZcZg==
X-Forwarded-Encrypted: i=1; AJvYcCUuAIg4VUOa5sKSnvZyWa8r7PbRq+S/PJXkoFmh7fdEOU8bJ1zJI89mgiK+frxifPCKBMl91nyAOOXiFRiY+OtVtaGnrKw1CFLyuwGBI8tBVCaOEzLx7PDhSzZKFu9S03v20YTx6Ziv
X-Gm-Message-State: AOJu0YydyAZVol9JKHZ6ptEe5CRLsObBIu0BVw47KDdytL4X98K3TjRr
	DrPeb7428u4Wdp+8J+mEXB2rkh04Uvzx5MXyJWHf63swRKi29pAu
X-Google-Smtp-Source: AGHT+IEAmelxRqp6BpVlGjCIPVhVmRUtPNtl1RSW6sSPuYsteML7fjSA3oU2JJWJhIC5dYnVeNpRLA==
X-Received: by 2002:ac2:4a78:0:b0:512:b386:e824 with SMTP id q24-20020ac24a78000000b00512b386e824mr1321354lfp.60.1708327130398;
        Sun, 18 Feb 2024 23:18:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id m23-20020a195217000000b005129f9b0e4bsm792228lfb.96.2024.02.18.23.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 23:18:49 -0800 (PST)
Message-ID: <06660242-ec6a-4bfe-adb0-da7f826c1634@gmail.com>
Date: Mon, 19 Feb 2024 09:18:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@aculab.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, linux-iio@vger.kernel.org
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <20240216135812.07c9b769@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240216135812.07c9b769@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 2/16/24 15:58, Jonathan Cameron wrote:
> On Mon, 12 Feb 2024 13:20:09 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The loop based 64bit division may run for a long time when dividend is a
>> lot bigger than the divider. Replace the division loop by the
>> div64_u64() which implementation may be significantly faster.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>
>> ---
>> This is a resend. Only change is the base which is now the v6.8-rc4 and
>> not the v6.8-rc1
> Given I'm not rushing this in, it is going via my togreg tree, so the
> rebase wasn't really helpful (thankfully didn't stop it applying).

Oh, I didn't think about it. Just thought I'll rebase to the most recent 
tag. I see the point now that you mentioned it, thanks.

> Would have been fine to send a ping response to the first posting of it.

Ok. Some maintainers like Mark prefer getting full resend instead of a 
ping because they don't keep the old messages/patches around. Reacting 
to ping would require them to go and fetch the patch from lore - while 
having full resend allows them to apply patch using their normal 
work-flow. Or, at least I think this is how Mark told me couple of years 
ago. I must admit that plenty of water has flown through the Oulu-river 
since that, so maybe this has changed also for them.

Anyways, good to know your preference, thanks!

> I was leaving some time for David or Subhajit to have time to take
> another look, but guess they are either happy with this or busy.

Ok. This is perfectly fine. I just thought that maybe the patch fell 
through the cracks and decided to re-send before I forget ... :)

> Applied to the togreg branch of iio.git and pushed out as testing for
> all the normal reasons.

Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


