Return-Path: <linux-kernel+bounces-103815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC7B87C4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0CBB22213
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A450A7691D;
	Thu, 14 Mar 2024 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRAH9VAY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B576906;
	Thu, 14 Mar 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453190; cv=none; b=BQR1jGhF7wIXmAhYDGvQnWLDQx+9hxxzXxMXx8jz9lQlKtvR+4FsnTTzay5Y46PWFAaprzoh0D6985YK0GxCr35svkf9JraCbXfagPNtFLp0lAsOobBhNE9/iJbKnqBvho7lr0RoevFTdDydo/KzAlHaRwU8z80Nm+/g2qmIRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453190; c=relaxed/simple;
	bh=Otk8voavGxoJw3TmDDsRxQ/ZIr/+xlU5r8AFgMD3ua8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLzmH7UIteJ21pANl+xzP6BVQX7tlWwl5Nht854MNOCE0z9A+dzPccSmHotrKmmHQ5tKTEFSTdoa9FVKK5/YoeMDPN8Q0Zl2SzqTDNaIYxdtQOb/PiPEX8ewCBg5gGLWawkn33Qe2ymZlELB/shfk42HVPJe4LflDmcVNFo3dYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRAH9VAY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so1055568b3a.1;
        Thu, 14 Mar 2024 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710453188; x=1711057988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOlDjn199Ds2vIsEotg/NQOKdXgjZzdKLP6u3pbYxgg=;
        b=VRAH9VAYrD9MGX/oNIuWNVpy/Gz3oa5zA2VqUK3q4EpNKzuT+sABQHvsFnOe8h19e6
         yoWbdGK6faGpKWmmOg4sXCNP6m33uiZjZuAfyFdGCTpOaw+goPeqBxRJZ+YAXZIFumjE
         wPmLv43Ra+7xkWA4wOAHctmvhv0P2X7tJ7pa4mZ0EFDLRO3Qww9Kblw2Dru2VaA4RVDm
         lp39Vok7jReGJey5wYI/JyL0P2OaVLOKMe++/egKPz6sXmWZZ1oNLONivcusNPAaXa9G
         DPVGWDt66JrXjDX0Sos7mk3eqy+3oQTmV9VB7aD0sfpVW0XqUtp7wHVVZ4EX73Q77d5Y
         jz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710453188; x=1711057988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOlDjn199Ds2vIsEotg/NQOKdXgjZzdKLP6u3pbYxgg=;
        b=LO0oydVbevXjGBhvqydk6I9MdUVNcaWin1rJc0mzex1CGQl8XUjIMZsHf9yDnEqRWx
         itwiWuNYJP/em6rypRRmdwd228JYp8sBQrZf3iCh9g9WVcC6OL7jhgZNbbbIl0UW4yNv
         0N2K2i2d3E7Tcdk1FkVg64iV6YEAKd4rXu+PyOzi8Zsj8p/1CMA2KB6q/FEdWoDLWLL3
         rTbGmzTAHKAYojKj0uJdF87U8xZiWd59nmGkXL+zqMH6yOG6wz5avocaBz12xrfwFBRm
         My4MiEB0ubyrOHPRJcKbPCR2Qyl3H6tI4QKV4YXgKNYKwY7YrCfXdQDU839Z3AauUvj4
         xFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEvF21UzceLzrzKPVoUIm6hGW2hXKNHlPOUt/mB6/t4E26bsxR2dlO8uVGtFR+IQot8O63hD5HlICtMKfL8tywLHSjftyWDOMnwZ0eVh25/ykEe+4LhRTQ0EJPTuiFBqdE
X-Gm-Message-State: AOJu0YytRdMZ0UUNf+K0xhu6pn8A3B/0P/AZg8LK9LgSzhpyrDqOeyxd
	fCz1GEJGnWUXl7oFXgIy5ELMtdGoaPjZMJpJI1z5mvw2d0SQjtPx
X-Google-Smtp-Source: AGHT+IE5TQcA+GcLuweBygffsPI/rrCpSE9G6GJqEIZ3BUSyKlbU2gmp2kOo3d+LX9bIK5s3+BEPiA==
X-Received: by 2002:a05:6a20:8f12:b0:1a3:4748:f9 with SMTP id b18-20020a056a208f1200b001a3474800f9mr2617727pzk.8.1710453188555;
        Thu, 14 Mar 2024 14:53:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u18-20020a63f652000000b005d8be4c125csm1202682pgj.80.2024.03.14.14.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 14:53:07 -0700 (PDT)
Message-ID: <8f977bbb-d949-4e90-b3d2-b9815189b842@gmail.com>
Date: Thu, 14 Mar 2024 14:53:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Joel Fernandes <joel@joelfernandes.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, rcu@vger.kernel.org, neeraj.upadhyay@amd.com,
 urezki@gmail.com, qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
 chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org,
 Justin Chen <justin.chen@broadcom.com>
References: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com> <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87sf0sldbi.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 14:21, Thomas Gleixner wrote:
> On Thu, Mar 14 2024 at 21:45, Thomas Gleixner wrote:
>> On Thu, Mar 14 2024 at 12:09, Florian Fainelli wrote:
>>> https://gist.github.com/ffainelli/cb562c1a60ef8e0e69e7d42143c48e8f
>>>
>>> this one is does include the tmigr events. Thanks!
>>
>> You need 8ca1836769d758e4fbf5851bb81e181c52193f5d too.
> 
> So from the above trace it's clear where it goes south:
> 
> [  236.318158]   <idle>-0         3..s.. 2928466us : tmigr_handle_remote: group=aecb05cb lvl=0
> [  236.326526]   <idle>-0         3d.s.. 2928467us : tmigr_handle_remote_cpu: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> [  236.357809]   <idle>-0         3d.s.. 2928469us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
> 
> [  236.377222]   <idle>-0         0dn... 2928471us : tmigr_cpu_active: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> [  236.387765]   <idle>-0         0dn... 2928471us : tmigr_group_set_cpu_active: group=aecb05cb lvl=0 numa=0 active=9 migrator=8 parent=00000000 childmask=1
> 
> [  236.401526]   <idle>-0         0d.... 2928477us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
> [  236.420940]   <idle>-0         0d.... 2928478us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=8 migrator=8 parent=00000000 childmask=1
> [  236.434874]   <idle>-0         0d.... 2928478us : tmigr_cpu_idle: cpu=0 parent=aecb05cb nextevt=3103000000 wakeup=9223372036854775807
> 
> [  236.446896]   <idle>-0         3d.... 2929469us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=0 migrator=ff parent=00000000 childmask=8
> [  236.460916]   <idle>-0         3d.... 2929470us : tmigr_cpu_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> [  236.473721]   <idle>-0         3d.... 2934471us : tmigr_cpu_new_timer_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> 
> CPU3 is the last active CPU and goes idle. So it should take care of the
> pending events, but it does not.
> 
> This is the next trace entry where CPU0 magically comes back to life.
> 
> [  236.487393]   <idle>-0         0d.s.. 162001359us : timer_cancel: timer=8c725d84
> 
> 8ca1836769d758e4fbf5851bb81e181c52193f5d is related, but dos not fully
> explain the fail. I haven't yet spotted where this goes into lala land.

It was a lot harder to generate the same issue on cold boot against 
8ca1836769d758e4fbf5851bb81e181c52193f5d, however, just like against 
36e40df35d2c1891fe58241640c7c95de4aa739b, it would happen resuming from 
suspend to DRAM whereby the CPU core(s) lost their power and had to be 
re-initialized. Eventually I got a cold boot log:

https://gist.github.com/ffainelli/b5684585c78518a5492cbbf1c7dce16e

Does the consistent ~159s mean anything?
-- 
Florian


