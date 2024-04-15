Return-Path: <linux-kernel+bounces-144692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA38A4946
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F05281B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E728DDA;
	Mon, 15 Apr 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nvk/rXZK"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3320335;
	Mon, 15 Apr 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167080; cv=none; b=V9R1VGsZHl8ftE4ARna3yUR+vPqX+dPU5yJI3pgL4yj2+IDfQMYImwjKsGjC0gmZ5pCXEj2Zie8kUEp96gCYBLyAuvXHhA6JKIrav4vOaTAYfUtxhcYzvXv8HtNhBJg+MxIFSkk2xKAuWKIVYKlcd/6irvRrBbjOYLQz26Iedco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167080; c=relaxed/simple;
	bh=rd7uyf9US0bWcIRDFwfOfCTgUqPC8XCQTic44zRqyak=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hYvUq4krKWH2e8K8s0vTgbZBz/gN5f88cLe/6a1hz2DckvGtxK/cIcBbZ+7X+N0wzsckuR2bRyXI90+Lut3Hd8bG1WMkgrRWBLx+hg9pzGNsBFkP31N2nv9IK4FtIzhhR89ygkAJxrfrZgWev62iiiAlwAihqcnfHZO3CRIXkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nvk/rXZK; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EFB9C000A;
	Mon, 15 Apr 2024 07:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713167075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiMNpOSoKUjR1Wtr6GuPAYb1hdJwJ3VRxcscaIKAfYI=;
	b=Nvk/rXZKJbOHwRNhheJEh6OEqevzX5EWhGMEBpjQwRuAGofgY90i5t6ve7M8rCOgybM9AI
	LvhqNrQbmL32AwGzGiPjynna5C4jrUUslDb1QI2DPsTtgPNzmfXol/ytndeH8zSxhMKeG3
	tf027rlA9YlmDZWO0ORc/Y/ewPz3C5F0uMYGrMHAC6jG58tezdRBgGA8fVMRPQdZ9zkWGz
	WQFC3gdATNbxSJuFIRETajuWjeQq5Hj6JOEYzmvhhuxtPqRUIMUZx4LNENGZ0WIKiS0Cq1
	G2BCU+OjutjghLev5pLgozyyDu420qMyizc7fMUeom7UBnM1hvvqRpUwQUGqSw==
Message-ID: <16df0d66-991a-4d9c-9321-b139555a5e64@bootlin.com>
Date: Mon, 15 Apr 2024 09:44:32 +0200
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
 <a86c6e6d-812b-4777-981b-c747ca601372@bootlin.com>
 <IA1PR20MB495304E9A53F0893C821DD78BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <IA1PR20MB495304E9A53F0893C821DD78BB0A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi

On 4/14/24 at 11:41, Inochi Amaoto wrote:
>> Gotcha for the CONFIG_CLK_SOPHGO_CV1800 setting. However, I'm confused. Why
>> is this setting available in linux-next, but neither in
>> git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git ("master" and
>> "for-next") nor in github.com/sophgo/linux.git ("master" and "for-next") ?
> At now, we only maintain the dts related change, but not the driver
> code. The driver code is usually applied by the subsystem maintainer.
> This is why you only see the clk changes in the linux-next.
>
>> What's the tree used to push to linux-next?
>>
> As you see, the driver code applied to the clk/for-next. That is the
> tree used to push.

It makes perfect sense, thanks!

So, I tried to boot my Milk-V Duo S board with the latest linux-next 
kernel (with CONFIG_CLK_SOPHGO_CV1800=y). Here's what I'm getting:

[    1.933301] mmc0: SDHCI controller on 4310000.mmc [4310000.mmc] using ADMA 64-bit
[    1.947274] Legacy PMU implementation is available
[    1.954001] clk: Disabling unused clocks
[    1.959283] PM: genpd: Disabling unused power domains
[    1.964840] ALSA device list:
[    1.968165]   No soundcards found.
[    1.975652] dw-apb-uart 4140000.serial: forbid DMA for kernel console
[    2.133075] mmc0: Internal clock never stabilised.
[    2.138256] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    2.145082] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000000
[    2.151906] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[    2.158725] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[    2.165543] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000000
[    2.172362] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
[    2.179220] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000000
[    2.186056] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[    2.192878] mmc0: sdhci: Int enab:  0x00000000 | Sig enab: 0x00000000
[    2.199699] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[    2.206520] mmc0: sdhci: Caps:      0x00000000 | Caps_1:   0x00000000
[    2.213342] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
[    2.220162] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[    2.226983] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[    2.233798] mmc0: sdhci: Host ctl2: 0x00000000
[    2.238558] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000000000000
[    2.246189] mmc0: sdhci: ============================================
[    2.256290] /dev/root: Can't open blockdev
[    2.261025] VFS: Cannot open root device "/dev/mmcblk0p2" or unknown-block(0,0): error -6

Here's my device tree (compiled with the sophgo for-next) branch:

/dts-v1/;

#include "cv1812h.dtsi"

/ {
         model = "Milk-V Duo S";
         compatible = "milkv,duos", "sophgo,cv1812h";

         aliases {
                 serial0 = &uart0;
         };

         chosen {
                 stdout-path = "serial0:115200n8";
         };

         memory@80000000 {
                 device_type = "memory";
                 reg = <0x80000000 0x20000000>;
         };
};

&osc {
         clock-frequency = <25000000>;
};

&sdhci0 {
         status = "okay";
         bus-width = <4>;
         no-mmc;
         no-sdio;
         disable-wp;
};

&uart0 {
         status = "okay";
};


What's frustrating is that I got the mmc working a few days back :-)
Hoping this helps...
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


