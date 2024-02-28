Return-Path: <linux-kernel+bounces-84836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447686AC48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AF71C2214F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF0B128389;
	Wed, 28 Feb 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WNggj9gg"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70A7E584;
	Wed, 28 Feb 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116953; cv=none; b=udUjIp+z8QUQygJ62Ft5CxXM7bYDiK1G7EG9/7TTQC7Hlf8oYfMGKJx/cRm6fLWNQughjTjYC0W8KYbdYA8prtt3GCp3gQLJEzpOx/EjYeL4a0MhWI0b63p1KUy6XORxzcNAjfX3YlrGIYFjmDLrl9skulca4fXzJEfsDXaSzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116953; c=relaxed/simple;
	bh=PbHolSpfIrxNIopauDWoGliXxY0r9I/R9inLIaJeAXk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KHreZcot0f6g24HHZ2Kj0ZhmwbczLlyFOULsr0LXPRDhdp6+U9xISzSsHPqW7G/yzbbgxsiGtsOFqPg8lfw3ziQ4ID4LrDGvvTEH9y4hp3TK/16T/ouIrZqVRFz0WGhG3kNhjwPDNPVi0wRp9X9tNEu7UGTfzeXsMrkPMGt4hD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WNggj9gg; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709116946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJcsp6UhNtSkpQqYGXeRXDOKtYxsPaRoMFG4CL1lZec=;
	b=WNggj9gg3Nxhhmd0F7ETUb0dhwUkP3bZXHMRov7lvQYH1/+3n1+mz0OGxw1pqr+ASmR3un
	ILzmd058Pjg3w5vRwU5+RKGHhwBKSOkX79WdccA2CV89OGwiPBQhQvPanzWXknQgg72mIG
	iuw56VdlfPxmGS2QVQsVLSqoPNpTnNZVk6nv1QvCBYHibyo/y4jadWj4rA4odIhmU949AL
	05yrUm+mlv6EYI5O4+bd6yEI8kjYJTQ1Rtq4ykU6sK34pZURNHbqviPl9juf8m0EHkhlsy
	fkbCCPJkQN4lZ2a0oNxhL/LMfrhjIj4BrQJf6hlW6irt6CPn5WtiabzrbqSg3w==
Date: Wed, 28 Feb 2024 11:42:25 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add cache information to the
 Rockchip RK3566 and RK3568 SoC
In-Reply-To: <4676da62ec0fc0fe89318baea0678e0c@manjaro.org>
References: <20240226182310.4032-1-linux.amoon@gmail.com>
 <8ceea100f2ef7cce296943ce1397161a@manjaro.org>
 <CANAwSgQnoBx+th6s254sML+Zw+RZQC6WU9TjfMoWgHxmCqbDcw@mail.gmail.com>
 <4676da62ec0fc0fe89318baea0678e0c@manjaro.org>
Message-ID: <8eb17d05ff857d154169e62b1f04413f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Anand,

On 2024-02-27 15:58, Dragan Simic wrote:
> On 2024-02-27 13:49, Anand Moon wrote:
>> On Tue, 27 Feb 2024 at 00:39, Dragan Simic <dsimic@manjaro.org> wrote:
>>> On 2024-02-26 19:23, Anand Moon wrote:
>>> > As per RK3568 Datasheet and TRM add missing cache information to
>>> > the Rockchip RK3566 and RK3568 SoC.
>>> >
>>> > - Each Cortex-A55 core has 32KB of L1 instruction cache available and
>>> >       32KB of L1 data cache available with ECC.
>>> > - Along with 512KB Unified L3 cache with ECC.
>>> >
>>> > With adding instruction cache and data cache and a write buffer to
>>> > reduce the effect of main memory bandwidth and latency on data
>>> > access performance.
>>> >
>>> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> 
>>> I was about to send my own patch that adds the same missing cache
>>> information, so please allow me to describe the proposed way to move
>>> forward.
>>> 
>>> The way I see it, your commit summary and description need a rather
>>> complete rewrite, to be more readable, more accurate, and to avoid
>>> including an irrelevant (and slightly misleading) description of the
>>> general role of caches.
>>> 
>>> Also, the changes to the dtsi file would benefit from small touch-ups
>>> here and there, for improved consistency, etc.
>>> 
>>> With all that in mind, I propose that you withdraw your patch and let
>>> me send my patch that will addresses all these issues, of course with
>>> a proper tag that lists you as a co-developer.  I think that would
>>> save us a fair amount of time going back and forth.
>>> 
>>> I hope you agree.
>> 
>> I have no issue with this,.If you have a better version plz share 
>> this.
> 
> Thank you, I'll send my patch within the next couple of days.

Here's a brief update...  Basically, not all of the cache-size values
found in your patch were correct, but I've got all of them calculated
again, double-checked, and cross-compared with the way values in my
earlier patch for the RK3399 SoC dtsi were calculated. [2]

It all checked out just fine.  It's all based on the RK3566 and RK3568
SoC datasheets and a couple of ARM specifications, which I'll describe
in detail in my patch description.  I'll send the patch after I test
it a bit, to make sure it all works as expected.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b72633ba5cfa932405832de25d0f0a11716903b4

