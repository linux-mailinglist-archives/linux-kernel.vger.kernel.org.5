Return-Path: <linux-kernel+bounces-88063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53786DCEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1CC1C226EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317269D33;
	Fri,  1 Mar 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bC1hZFSR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F14C629;
	Fri,  1 Mar 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281269; cv=none; b=WyHT06tUOhEuja4sbP4M9JJspEddSAFKGNJGpE+HwPRj47pOF4wfFPvlIc8FSza7NhSl3fYOEtwXblDt0t8dU8ViIjmJBrAWHjjQ/dIEScD+qKPiMQG50Hy4bWpavk6szWYuyh4438lFLPfQHdcbZ6mFWfzgcRT9JFdecnGfVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281269; c=relaxed/simple;
	bh=sTDWu7ch8miz/GZAckiUfRCxVjKtxzaPPw16BArEcvk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KprHFexOsHKeqdEATi8OFdMa/aSnvEOZODOb6kjNE0i8vTvHs8lHBIGVlDzpXTovTgGIF4hflypNhR/Wdp2btUjbE/paBJ1lN3mE9gzz2oC1NT51yqcGZx2FbD6+qH0HS7BdRhxJj7/76/hfzb/BFmo7f060tRZBj7lr/RBzHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bC1hZFSR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709281264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+18udHpLdy95OkiC4n4xDRRezey7Z+tS7O6jkyULnM=;
	b=bC1hZFSR6GR/rYNrKd+NODHBKVtCHrUY0yriO6RgAHLtfMikoIxClwf576UijbczLn6MpV
	5j+NK4EscAmZGoL03JaUQVuYk5WzULPgSQBqwpoIHUfynLJWHr9b8pFUn2AUvZ9V2eZiut
	UMviP+9UbnIxlvkq8OHvFSlftQ3NvoHYr8P6VbQ8onhDdm78RyHa153pbpZ2XYE8ge5iKW
	mdE4sIT2TmOh2CY7kZ32GiVTB/R50vXIkt9Uosb+I4WBxZfPro7ApGAFzzANLC/VpX7MNY
	aZQlH4kaXNPukaVR54Mg6fYIzG/+D6PQIBfnKg3P4r9LWEQsBzG+MB9N4SGRdQ==
Date: Fri, 01 Mar 2024 09:21:04 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
In-Reply-To: <CABjd4YxhL7m-neLFCQG5Aja2=stFdou7ji8m==UGPSSH-CybVw@mail.gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <5eb9193a44fb9f9b1e976412874cecef@manjaro.org>
 <CABjd4YzFuhfS9RhJ6svb9ZD0NqMT5B6GmqigHFLr8YG6FR5k=w@mail.gmail.com>
 <90d0cfd9b7d018e7332213f624f0f658@manjaro.org>
 <CABjd4YxhL7m-neLFCQG5Aja2=stFdou7ji8m==UGPSSH-CybVw@mail.gmail.com>
Message-ID: <edb0ba399467359e16e50c89a1671b7f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 08:51, Alexey Charkov wrote:
> On Fri, Mar 1, 2024 at 10:14 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-03-01 06:20, Alexey Charkov wrote:
>> > On Fri, Mar 1, 2024 at 1:11 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> >> See, I'm not a native English speaker, but I've spent a lot of time
>> >> and effort improving my English skills.  Thus, perhaps these comments
>> >> may or may not seem like unnecessary nitpicking, depending on how much
>> >> someone pays attention to writing style in general, but I'll risk to
>> >> be annoying and state these comments anyway. :)
>> >>
>> >> The comment above could be written in a much more condensed form like
>> >> this, which would also be a bit more accurate:
>> >>
>> >>
>> >>                                 /* IPA threshold, when IPA governor is
>> >> used */
>> >>
>> >> IOW, we're writing all this for someone to read later, but we should
>> >> (and can) perfectly reasonably expect some already existing background
>> >> knowledge from the readers.  In other words, we should be as concise
>> >> as possible.
>> >
>> > In fact, the power allocation governor code itself doesn't call those
>> > trips threshold or target as your suggested wording would imply.
>> > Instead, it calls them "switch on temperature" and "maximum desired
>> > temperature" [1]. Maybe we can call them that in the comments (and
>> > also avoid calling the governor IPA, because upstream code only calls
>> > it a "power allocator").
>> 
>> Hmm, but "IPA" is still mentioned in exactly three places in the files
>> under drivers/thermal.  I think that warrants the use of "IPA", which
>> is also widely used pretty much everywhere.
>> 
>> Perhaps a win-win would be to have only the very first of the comments
>> like this, to introduce "IPA" as an acronym:
>> 
>>                                    /* Power allocator (IPA) thermal
>> governor       */
>>                                    /* switch-on point, when IPA 
>> governor
>> is used   */
> 
> Yes, good point, thanks!

I'm glad that you agree. :)

>> Next, "the target temperature" is mentioned more than a few times in
>> drivers/thermal/gov_power_allocator.c, which I believe makes the use
>> of "IPA target" perfectly valid.  Actually, let's use "IPA target
>> temperature", if you agree, to make it self descriptive.
> 
> Or perhaps simply "target temperature"? Stepwise governor will also
> use this trip as its target, so it's not IPA specific, unlike the
> switch-on point.

I also had similar thoughts about the shared nature.  I agree, just
"/* target temperature */" would be fine.

>> Finally, the threshold...  Based on
>> drivers/thermal/gov_power_allocator.c,
>> I think "IPA switch-on point" would be a good choice, which I already
>> used above in the proposed opening comment.
> 
> Agreed, that sounds good to me, will reflect in the next iteration.
> Thanks for bringing it up!

Great, thanks!

