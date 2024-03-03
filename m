Return-Path: <linux-kernel+bounces-89866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0B86F6B4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8481C2094A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982879B98;
	Sun,  3 Mar 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TOlJJ8VH"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB316CDC0;
	Sun,  3 Mar 2024 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493059; cv=none; b=m0uijOIiftTCC/LPgCZXjLWuqSFliwXGQanZU/XqNcxtBd1KYVlabib6lENeI+oC7LI51WWn8az7QqNw3QqR6D8xPHSupBIU29bYgL21YQmfHLCTSkoCEYibWhsvHwGSdps4HFtlKET4zUt084vlpl7SF/beTcm6+7Fk2uQMKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493059; c=relaxed/simple;
	bh=gGx3jX5ZlsiFiMZEU4HNH80BafPHn2SaRicDJFtox1E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=R64Oi34EIey0rbwQ/g0WmybG1JGfKWEfQwQhMJvaQqtOjw1JjDqkyijOwJLYpSzXS9CRCAeTyzURlgEN4hDNpldzSXMHWtoAECZDfwoZnCKQ5d4ZeHdHxjeuSC8g95ZKvFBb1qILy7t27pxpm67/niufS/G+Lw+x0bcZJDTrp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TOlJJ8VH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709493055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hNRWVJno8AKrSg17qcfRn/w8+KSTZ6aFzgs/r3ObuA=;
	b=TOlJJ8VHpsOa61znsLHbSBW0mYcpkpgfqCfGjFUJ3KWEo/4o5Ln7vKaN3z0AuQnJv4quUo
	bOPmsjwXXleK2DsJg4h6jTUye86v/KTo+sB9qG9sJ+x99SAWOjEJ7Fczklii2CKp2U/eeV
	roRVSuZ2T+refguesiecIN8IgdMKO8X1qRPv7DRVl5BlN9XStc0H7Cv4Cy0hB53kjAL66b
	JicZ37BduwHUNvLAHicib9fx7N+rlQf8wHumw4femJMovgCZgbG9I+cusHcb//hzTi4IkD
	nO+roPN3a9uIH48a8NkP49gmG2vwUpgESBwp73ozjlW1ixbCPnGI/CZoPqGCKw==
Date: Sun, 03 Mar 2024 20:10:55 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add cache information to the
 Rockchip RK3566 and RK3568 SoC
In-Reply-To: <31ad86c4e2e3f8f46016227b0d204c8b@manjaro.org>
References: <20240226182310.4032-1-linux.amoon@gmail.com>
 <8ceea100f2ef7cce296943ce1397161a@manjaro.org>
 <CANAwSgQnoBx+th6s254sML+Zw+RZQC6WU9TjfMoWgHxmCqbDcw@mail.gmail.com>
 <4676da62ec0fc0fe89318baea0678e0c@manjaro.org>
 <8eb17d05ff857d154169e62b1f04413f@manjaro.org>
 <31ad86c4e2e3f8f46016227b0d204c8b@manjaro.org>
Message-ID: <e6951decd632141ab7f08bda6f5569be@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Anand,

On 2024-02-28 18:50, Dragan Simic wrote:
> On 2024-02-28 11:42, Dragan Simic wrote:
>> On 2024-02-27 15:58, Dragan Simic wrote:
>>> On 2024-02-27 13:49, Anand Moon wrote:
>>>> On Tue, 27 Feb 2024 at 00:39, Dragan Simic <dsimic@manjaro.org> 
>>>> wrote:
>>>>> On 2024-02-26 19:23, Anand Moon wrote:
>>>>> > As per RK3568 Datasheet and TRM add missing cache information to
>>>>> > the Rockchip RK3566 and RK3568 SoC.
>>>>> >
>>>>> > - Each Cortex-A55 core has 32KB of L1 instruction cache available and
>>>>> >       32KB of L1 data cache available with ECC.
>>>>> > - Along with 512KB Unified L3 cache with ECC.
>>>>> >
>>>>> > With adding instruction cache and data cache and a write buffer to
>>>>> > reduce the effect of main memory bandwidth and latency on data
>>>>> > access performance.
>>>>> 
>>>>> I was about to send my own patch that adds the same missing cache
>>>>> information, so please allow me to describe the proposed way to 
>>>>> move
>>>>> forward.
>>>>> 
>>>>> The way I see it, your commit summary and description need a rather
>>>>> complete rewrite, to be more readable, more accurate, and to avoid
>>>>> including an irrelevant (and slightly misleading) description of 
>>>>> the
>>>>> general role of caches.
>>>>> 
>>>>> Also, the changes to the dtsi file would benefit from small 
>>>>> touch-ups
>>>>> here and there, for improved consistency, etc.
>>>>> 
>>>>> With all that in mind, I propose that you withdraw your patch and 
>>>>> let
>>>>> me send my patch that will addresses all these issues, of course 
>>>>> with
>>>>> a proper tag that lists you as a co-developer.  I think that would
>>>>> save us a fair amount of time going back and forth.
>>>>> 
>>>>> I hope you agree.
>>>> 
>>>> I have no issue with this,.If you have a better version plz share 
>>>> this.
>>> 
>>> Thank you, I'll send my patch within the next couple of days.
>> 
>> Here's a brief update...  Basically, not all of the cache-size values
>> found in your patch were correct, but I've got all of them calculated
>> again, double-checked, and cross-compared with the way values in my
>> earlier patch for the RK3399 SoC dtsi were calculated. [2]
>> 
>> It all checked out just fine.  It's all based on the RK3566 and RK3568
>> SoC datasheets and a couple of ARM specifications, which I'll describe
>> in detail in my patch description.  I'll send the patch after I test
>> it a bit, to make sure it all works as expected.
>> 
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b72633ba5cfa932405832de25d0f0a11716903b4
> 
> Pretty much the same patch for the RK3328 is also ready for testing.

Just sent the patches to the mailing list, please have a look. [2][3]

I've "downgraded" the previously proposed "Co-developed-by" tag in the
RK356x patch [3] to a "Helped-by" tag, just because the cache-size 
values
in your patch mostly weren't correct and, as a result, differed from the
cache-size values in my patch, making the "Co-developed-by" tag 
technically
not applicable.  For that tag to be applicable, the most important parts
of the patches need to be pretty much identical.

I hope you agree.

[2] 
https://lore.kernel.org/linux-rockchip/e61173d87f5f41af80e6f87f8820ce8d06f7c20c.1709491127.git.dsimic@manjaro.org/
[3] 
https://lore.kernel.org/linux-rockchip/2285ee41e165813011220f9469e28697923aa6e0.1709491108.git.dsimic@manjaro.org/

