Return-Path: <linux-kernel+bounces-152531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E2E8AC011
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA02D1C20A4E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AB1BF20;
	Sun, 21 Apr 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Bdvv0Jdp"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEC1BC4B;
	Sun, 21 Apr 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715660; cv=none; b=Hpdaf2kRNW/2KhEQPbJWcHKf98+llADePieeMB1kd0+9zlnfQirRf8YBNBJJfvLhJO/lykqCehmws+t5PRXylWbTZavJmQB8rsXtAikInGu6Lm285la+1prVcxlz/eZE4MPkFWLmX//jHGw6MGfhsaLj5qQJg/wfWIkroS2eDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715660; c=relaxed/simple;
	bh=Cyhx+MN4VujH/tdWm0dQNdZ3a1INmFQBlsbASGClCaY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oqw4WnTw7uhkTX7oakhMEKjKv1DalbCDfjPa37JbJmC5Ga31yr1rYBFE4xA5OfKeciLyT0fGiciRviwEV3U+/Z4oC9IYlH7uRmWFqCJLtocDYK7HDjOQEffw/D/AF5A3R8ZZTiGjjley5yHmih8pXEXVKB+uVgGsA40EfxELj2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Bdvv0Jdp; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713715655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsbWtpJGTpVE59gMLUthsI5owfAuS8vpivZIQQQ1eIA=;
	b=Bdvv0JdpiuYrX4w/mGLWCWpiWk0/76kKVfTbP11g+yKcyKSMt7DoVECfFRf//g1f8moZcs
	zoUj0XNxDvp4JjNqPwYHHPCMHtc1N+2wRJnV20rCigi2zj1UQu+Eo7Oft2hGEwr39zGhQq
	X6l4ak3NsRp9S2N1ZYxHk3BmSao95pAqBwIpiA9uom9q24Hwfazaejk8IRRUDy9T6NaXEB
	DxECT69Kpvyu8V5ICo/ChhcwEM4+kCKxnMUo3/Ybr8Jb/6tGWSLSppykuRAaNLlxI1DB4O
	VGgVrLNgUFF+4YXZg+Atf7LJqZPr9GBEdJvHqZHhnYtAeW2/7A9+qnAcOQ08UA==
Date: Sun, 21 Apr 2024 18:07:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
In-Reply-To: <3068718.7t0mGDVaCv@bagend>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <66689051.MzlzmSNrL9@bagend> <9f4c7615a6685ac42dccdbe35e57c357@manjaro.org>
 <3068718.7t0mGDVaCv@bagend>
Message-ID: <51b07f627c5e16461d9c38dc41c0b957@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-04-20 19:53, Diederik de Haas wrote:
> On Wednesday, 10 April 2024 11:28:09 CEST Dragan Simic wrote:
>> > Can you rebase this patch set on Heiko's for-next branch [1]?
>> > And then also fix the ordering of the nodes and the elements within
>> > those nodes so that they match the current conventions?
>> 
>> Ah, thanks, this is a good reminder about the proposal for the plan
>> for moving forward, which I promised to send a while ago. :)
>> 
>>> [1] 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=for-next
> 
> I build a (Debian) kernel based off 6.9-rc4 + a whole bunch of patches,
> including this patch series. I got someone on #debian-arm to try it out 
> on a
> Rock 5B and the dmesg output showed a number of items wrt thermal and 
> OPP.
> 
> Some items that I filtered out from that dmesg output:
> 
> [    3.211716] hwmon hwmon0: temp1_input not attached to any thermal 
> zone
> [    3.908339] panthor fb000000.gpu: EM: OPP:900000 is inefficient
> [   10.473061] cpu cpu0: EM: OPP:600000 is inefficient
> [   10.473233] energy_model: Accessing cpu4 policy failed
> [   10.585236] rockchip-thermal fec00000.tsadc: Missing rockchip,grf 
> property
> 
> Attached is the full list of items I collected from that dmesg output 
> which
> seem worth investigating.
> 
> Maybe useful to investigate when moving forward?

This is a nice report, thanks!

I'm not sure what's going on with the mmc2 issues.  Regarding the 
hym8563,
hwmon, energy_model and rockchip-spi issues, I'll have a look into them
and come back with an update.

Regarding the multiple "OPP:<frequency> is inefficient" warnings, it's
already on my TO-DO list to perform a detailed (and repeatable) testing.
My suspicion is that declaring the OPPs as inefficient actually isn't
warranted, but we'll see what will be the test results.

