Return-Path: <linux-kernel+bounces-144069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5D68A4179
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89B1C20933
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20522F11;
	Sun, 14 Apr 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GN1CMzsY"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203D24B28;
	Sun, 14 Apr 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085897; cv=none; b=Nbs5b2omu+0CRAmmROjAUIc8CSC9N9HXeSpZV3QLh2HdcA5TXdFcfWUCE0qGdHs/j7bh7v7cFzLJES1ics2/wviyXL3o1yEqurMTW3j2bNZd1kDRDSGhXduWzCW/xU+g9OmBHRFJC2B++nrE5+FTPgeytFVQKzxMLmOkUvIR33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085897; c=relaxed/simple;
	bh=i3mHY9s61s8hPoAu7VOWUAI7hIuoJftUIgMHk6z8Bp4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BYhHkkVc2ovIsvAtIUd3zG4fYHwE5kGO9YTsYNhj8JUOiD0gerFoArhJs034Be9KTZs3CxggWcnaqhoV9OxVx5ScvEfyAnSdTooks0TDWdVrnIkbfdUI1sIOyx1gGQvHT7reuo2SqMZ1X2SRmuKBenBF8sW0f9nVYcaBYSeQ//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GN1CMzsY; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F78D1C0002;
	Sun, 14 Apr 2024 09:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713085886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucqJYAIoktU0BaFjFoxsK2t1BH4GJs/UThpTq3LARR8=;
	b=GN1CMzsYW7HkiiQrLBRaZXY727moXji1hMlvFRdiPgg6fCYeRSQwCVWksVXkI2DwGQfONe
	pYxEbZJ+Ak50/dzaIBqrtOBv4063jSM8zfgb1T5qf4ky6s0CEtspCoLIda7Eq+D8x33SPc
	tC6O+ycHpdMeMmOYpLg2cDtTtFClbwxaOJL4uuUrG7ZFNLuRMoh9R4ObS6k4ktdO4lHPQA
	4k+Ns5LX0kNJ7zzef1LBltq7nYVIHe20P4NnnnjdbjiJyUSUwU+vV8ZDwd6PiFRUPx//rt
	hgNdqGfMhNqcHuvnLdTK/7THiJRlPkWvUjT6pRATdOOqAO8d6XrsDoZJUAWuDg==
Message-ID: <a86c6e6d-812b-4777-981b-c747ca601372@bootlin.com>
Date: Sun, 14 Apr 2024 11:11:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, Jisheng Zhang <jszhang@kernel.org>,
 Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
 dlan@gentoo.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v9 0/6] riscv: sophgo: add clock support for
 Sophgo CV1800/SG2000 SoCs
To: Inochi Amaoto <inochiama@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E5E78F930EE25A86EE1CBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
 <2696c0e0-0f15-44d1-ba40-dcab4be802d2@bootlin.com>
 <IA1PR20MB49536A93C7A684EAE844E316BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953A5ACD22C8CB791C76BABBB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <IA1PR20MB4953A5ACD22C8CB791C76BABBB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi

Thanks for your help!

On 4/14/24 at 08:43, Inochi Amaoto wrote:
>> Hi Michael,
>>
>> I think you boot with the `defconfig` config. This config does
>> not enable the CV1800 clk support. I think you may need to apply
>> [1], which enable the clk driver. Also if you want to test sdhci
>> with real clk, you can try [2]. I test them on the Milk-V Duo S.
>>
>> Regards,
>> Inochi
>>
>> [1] https://lore.kernel.org/all/IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com/
> I make a mistake when reordering the url.
> [1] should be https://lore.kernel.org/all/IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com/


Indeed, I was using the "defconfig" config. Too used to having 
everything working with this configuration on RISC-V :-/

Gotcha for the CONFIG_CLK_SOPHGO_CV1800 setting. However, I'm confused. 
Why is this setting available in linux-next, but neither in 
git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git ("master" and 
"for-next") nor in github.com/sophgo/linux.git ("master" and "for-next") ?

What's the tree used to push to linux-next?

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


