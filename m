Return-Path: <linux-kernel+bounces-92546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB468721F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608211C21994
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A9E126F05;
	Tue,  5 Mar 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="k4QbrGxe"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF028595C;
	Tue,  5 Mar 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650218; cv=none; b=rbpqJi+e8BYP4wm7cp+ndUxQdtJz6ewDWEgzSanI+VnwBhKG22ibZgj5qb+9veaHxKvof/G5zoPLPgu1ISxDS/U1OWsriTw19I0sUJJJQyW9kuzLZs0EC++teCUyTl5LYAXZ7Le8PiRGkh0v3wggyqVg8jlDOOqpH2SKpAEJ0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650218; c=relaxed/simple;
	bh=qNvP0MHUDhq5uKeC1lWkHuAKP+QAc5+WTwtcRR/JpYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJgTKaAHZXpID/rQj8ECTfK5jrG7xFDlkR/bTF+/skqexIdgRLmf3yyBkroWdgomFaRrCuKdLc4f7Mi+JsCzlkjBgc+9mc+CXEPTv3555ead57mgZs1Ob5aBgZTdjB3ngdP534wniOUIcFpqLj5/JN9wFljjMjnlt+EzHS1QAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=k4QbrGxe; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=eHhl2jHhjVxxGJR4b9ILlAb7oyvlwVpJjsN5ZgneT1I=;
	t=1709650216; x=1710082216; b=k4QbrGxe9YUkQ61IFAr4rLn1eXPIuPtzoYWWr3/ehpdcRBK
	0/2pakh7LjB1WAR35C62c3ZsovuWR7LcgCAw4TYxH4LFf/U1GH5rQdWH/wdR9Ya69aqUsP4bBBYNn
	Hwfokd0yYRWqBsvmhlGVv77hs6zMbpAFLB44WWk5epRB+j23R6uOrfkxjvLu3XWorFqWYzwhAHmKW
	gOpz2sj2EgS0ZcFbxQ7tnqkjkKciSz2VeAXcxflol6zGKLg/3TJ0zbhvBXwZusS1Q1BPS3+ljxHPo
	1N1TM40QdA9HuljVWxa6HtVmAwWVm2O7LV+X+RmmGlm01lw1VZmLPcghSsfoG0Dw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rhW7R-0003md-KW; Tue, 05 Mar 2024 15:50:13 +0100
Message-ID: <1726bbb2-2cdc-4cad-b6b1-295f6338e771@leemhuis.info>
Date: Tue, 5 Mar 2024 15:50:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lenovo ThinkPad X13s regerssions (was Re: Linux regressions
 report for mainline [2024-02-25])
Content-Language: en-US, de-DE
To: Johan Hovold <johan@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vinod.koul@linaro.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
 <83c6019f-9c6f-4ad1-87d5-e4f1bdaca93c@leemhuis.info>
 <ZecjcApvdZSGRysT@hovoldconsulting.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZecjcApvdZSGRysT@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709650216;b8afcc65;
X-HE-SMSGID: 1rhW7R-0003md-KW

On 05.03.24 14:51, Johan Hovold wrote:
> [ +CC: Vinod, Bjorn, Abhinav ]
> 
> On Tue, Mar 05, 2024 at 10:33:39AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [dropping Linus from CC, we can add him back later when needed]
>>
>> On 27.02.24 11:20, Johan Hovold wrote:
>>> On Sun, Feb 25, 2024 at 01:21:46PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
>>>
>>>> Johan Hovold also deals with multiple issues affecting Lenovo ThinkPad
>>>> X13s, but he send out patch series to fix some or all of those[1], so
>>>> with a bit of luck those issues will soon be fixed as well.
>>>> https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/
>> As 6.8 final might be just five days away, could you please help me out
>> with a short status update wrt. unresolved regressions from your side if
>> you have a minute? It's easy to get lost in all those issues. :-/ :-D
> Heh. Indeed. It's been a rough cycle. :)

:D

>>>> [1]
>>>> https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/
>>>
>>> This series addresses a use-after-free in the PMIC glink driver caused
>>> by DRM bridge changes in rc1 and which can result in the internal
>>> display not showing up on boot.
>>> The DRM/SoC fixes here have now been merged to drm-misc for 6.8.
>> What about the others from that series? Can they wait till 6.9? Or are
>> they on track for 6.8?
> Vinod, the PHY maintainer, just told me he will try to get them into
> 6.8.

Ahh, good.

>>> But also with these fixes, there are still a couple of regressions
>>> related to the Qualcomm DRM runtime PM rework in 6.8-rc1. I'll send
>>> separate reports to track those.
>
>> Any decision yet if they are going to be reverted for now?
>>
>> Am I right assuming those would fix
>> https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
>> which did not get even a single reply?
> 
> That was the hope, but I've managed to trigger a reset on disconnect
> once also with the runtime PM series reverted.

Ohh. So did the PM series increase the chance of hitting this? Because
if not, then...

> One of the patches from that series has already been reverted (to fix
> the VT console hotplug regression) and there is some indication that
> that was sufficient to address the issue with hotplug not being detected
> in X/Wayland too. I'm waiting for confirmation from some users that have
> not been able to use their external displays at all since 6.8-rc1, but
> it does seem to fix the X/Wayland issues I could reproduce here.
> 
> But either way, the reset on disconnect is still there, and have since
> been reproduced by Bjorn also on another Qualcomm platform without a
> hypervisor so that we've now got a call stack. I've heard that Abhinav
> is looking into that, but I don't know if there's any chance to have a
> fix ready this week.

..this sounds (please correct me if I'm wrong) like on Sunday the
situation likely will be "the problem is basically in 6.7.y already, so
there is not much we can do for 6.8 and reverting or delaying the
release is unneeded" -- unless of course a fix comes in reach during
this week.

Ciao, Thorsten

