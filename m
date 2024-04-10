Return-Path: <linux-kernel+bounces-138250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF689EEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D0E1C20D46
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B375B155723;
	Wed, 10 Apr 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="abHtNVPg"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271F1552EF;
	Wed, 10 Apr 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741295; cv=none; b=J6AFRe5/5TIkhfTY6f0U7HEKVg7xSSdPie9QWTxiEFqHytVAOjspR3ggryHcy6/pbfYQMzdZMpt0a1vpxbk8eKLt2YcNc2dNYfn6ESsBF8p8UXexi/MKHpbjUZnJew8Wi0/EsTFw98A0vmsHn83NrEtekA8mLyOn177LFs+XauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741295; c=relaxed/simple;
	bh=zsoYaP4ttIY6R/+fdqaCRZ/R7zwJWemSd7limzCI9I0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BJU0r0gdjtmTKIQftIFLY+MEmVuRqCXEU+b/RbyKFhMWO3+L4X81hyLASOjtW3O6hkrhAxB3xHRdrg1ldtGuwWL2zBXGYLYKViffylifKqdYzXjKtw5x9CHnK0g7AXNoKerPZ6EUgmRWB15h+nJPnAkTIJ112tpV6qC08R3LxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=abHtNVPg; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712741290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiYdWuU6TA/MRaisJkvN1oi05HBnSA4JJqXFKW8pk3w=;
	b=abHtNVPg9dPnB3ukM7+xz0G35WCgg6u8vPOyxisReIzDTWEfKOBvxo9dx+qa1/TAR+GQF3
	+Z3ZNNgMSDrnnUGkamYkqWlDfofS646hD7T77g/GzFAHBQGStPmMU9ldYydE85W7oA1Sc5
	MD7+cJt4LFCF5RLhEAt0MQ897p4uZJ/hgIBFvPuu7np1QFCMTCtQGo/zLuw9LuA1PHfxOP
	dSHLs9caK6SSVb2GOvnPyab2fPaVUcmIzuUEVei7ML4A9K66r4ZXLw/5Jpw/uQyNFIbsmN
	2PI/V1Q/GaRieWtjhBrHzYBqjhSRbHumZ2Qy5Tg8lvQYORUG4Dy8ZR64pLZJSw==
Date: Wed, 10 Apr 2024 11:28:09 +0200
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
In-Reply-To: <66689051.MzlzmSNrL9@bagend>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <66689051.MzlzmSNrL9@bagend>
Message-ID: <9f4c7615a6685ac42dccdbe35e57c357@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-04-10 11:19, Diederik de Haas wrote:
> On Thursday, 29 February 2024 20:26:31 CEST Alexey Charkov wrote:
>> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
>> active cooling on Radxa Rock 5B via the provided PWM fan.
>> 
>> Some RK3588 boards use separate regulators to supply CPUs and their
>> respective memory interfaces, so this is handled by coupling those
>> regulators in affected boards' device trees to ensure that their
>> voltage is adjusted in step.
>> 
>> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>> Alexey Charkov (5):
>>       arm64: dts: rockchip: enable built-in thermal monitoring on 
>> RK3588
>>       arm64: dts: rockchip: enable automatic active cooling on Rock 5B
>>       arm64: dts: rockchip: Add CPU/memory regulator coupling for 
>> RK3588
>>       arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
>>       arm64: dts: rockchip: Add further granularity in RK3588 CPU OPPs
>> 
>>  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  12 +
>>  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 +
>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  30 +-
>>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi          | 385
>> ++++++++++++++++++++- 4 files changed, 437 insertions(+), 2 
>> deletions(-)
>> ---
>> base-commit: cf1182944c7cc9f1c21a8a44e0d29abe12527412
>> change-id: 20240124-rk-dts-additions-a6d7b52787b9
> 
> Can you rebase this patch set on Heiko's for-next branch [1]?
> And then also fix the ordering of the nodes and the elements within
> those nodes so that they match the current conventions?

Ah, thanks, this is a good reminder about the proposal for the plan
for moving forward, which I promised to send a while ago. :)

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=for-next

