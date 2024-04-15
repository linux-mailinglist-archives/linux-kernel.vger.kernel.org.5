Return-Path: <linux-kernel+bounces-144752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE78A4A38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB611F26187
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC4374D3;
	Mon, 15 Apr 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="jmdSZtP2"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA1383AB;
	Mon, 15 Apr 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169273; cv=none; b=Oy9CVQK9qilsz0p8nLc2IeLSFN5wG0kEeGmPjP8aO/5K7ri+/6b2+ZfEkFqOWLyRaSqzwEQ+TqZrYsFz+M6Vvj0nIIbjqNq+o1BaaycRLlN0mumvfgwHchnPVsd1WU3t8xfQuEsXurIDxXKlptxtvVmM4mHXQRnhzImBv9qcRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169273; c=relaxed/simple;
	bh=oQunxvop27t5yJXcm19bCMeiPUoz/b2hHIJhuJg8Nc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=T/2ReRz6utLmomVEAZy0SrkS/2Qb47GgNeDzwllE6BNEZGNVEEJQBPqNFdfpFV5BOk1OS0j3NROFRIdjBhsQOHOO03ufNJ2sMrotl0JzAXe8aVpYCf1e96Y0qYStohduQxoZFYHDSN1mdo1t71bNScRIflgfNpUKAQNIS0HhQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=jmdSZtP2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1713169248; x=1713774048; i=wahrenst@gmx.net;
	bh=KmiBSlvBSznTGtJsTgqRLR9KNsooabNqyzKhFAipvvk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=jmdSZtP2VeLSIPWswAYmTgZ0w8bCZhdP0mVP9+EpcOe0ljAk27S+aDLyONz1GRHx
	 dEzmyQgYBiZYvnetlfTcde2H+m8Cv8sAxgWrXFU4hjFSII64JtuR75eW551Urp7VE
	 FReoS2CunvaDAg2XxGcJ5WDc64ab+NxQ8nMdIZ5hN6M2uGwFc6PFF5u2bg65533G5
	 z4DYbmqP301WeXjWRXXTfEJJiO4iErmCYu1xpVAoBonOFe4KFOXjg3k6X24zE93Fo
	 VSlcyo71LLIykN8PwzlnkP3MCqJrYsO8DupcYrBBd4os0Sg7jnpvvE/timb+3w1W3
	 +iXajfT+Dk3YEuX74g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1sWzF82qKc-00qPfS; Mon, 15
 Apr 2024 10:20:48 +0200
Message-ID: <d7b884dd-9b70-41c3-ac2a-66b54c26d08a@gmx.net>
Date: Mon, 15 Apr 2024 10:20:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: broadcom: Add support for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Bell <jonathan@raspberrypi.com>, Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
Content-Language: en-US
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
 Kamal Dasu <kamal.dasu@broadcom.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NmOzBldTMHifhoDliViPEkybyqb+Rsr5z1HmhLqafkA7C7So3J1
 hGr1+DRzYrwMFKJi+d2O8DcYxqms6cf9VFt9LmTHGgTsrD39IPvQ6nwRaEwAiXkfwWd5Sso
 amChi6M4iST2/ZynvY4vZZvejEWMQu+moYMW2rYIBYJ5nuH9nGSI2+JAayz/pst4DDFcv/r
 QHrX4yGftKFnqAl52Zvsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uVezZPm5UaE=;EUg7JKnJImPZDoSVFZs6vaXZOJG
 8oqRo121ptlrfYElOR/Iin6trMJgUR3pVSOxQ4WY0n/wBGQQbYySg3hS2qped5dAJ1q4tMnfn
 RbQN6RTAvYPQL3TXxDvagP6ajlz8sANpSHMUqlWragnr9/HD8T4iJ99nGl+6m9t3LoR21Qs5v
 B1XjbHWSPnG/wSV5njsU/KRVnzH6HshgEpL83IgQLPXIsyta9eYUBM3Bv3qNYlpoaSCwoHTXp
 Ob3+FMo46rLOxkMvMPrPecGKnWdmm/LTMA8NxdggSZaZh0iA0+3nWAKLVs2ThB5hG5QW6ui22
 N70waAGllSBOTWs3g9xuGVPUoTSppinDD4PCj0RtCD3VCZqr2E7DqASNHxu5AHCWASOr//EdR
 iSzVZkgqfDUqQJMZ00FjTRQ2kptFaBVRtbTtjU/EyZdGuF0+pt0Kn9yNKEnqIo8vcroR+WTmf
 WcLFGUhcctmH/Px8nnxmKGhxxl1FASjftQyBsTX/D022jd18xfbWT9Nm+7mTW50/x5xpyHNMX
 9lEw3U1MJykA5hNfjWQwFuulPiRkohwuPtUhqJe6umhPsa9dDen2QEJ/vFlVeR09StLMZqRzi
 O+8MTETgFGFxXW1mmtnwBiPF7ZzT5J9871+K0g7Iya1upTyjeNm4uipSvKYlxsQDk+fQjQW5S
 4d7r/92nS0Gq3RR2eX2mbALlcSAST0JiRMaVmxByGIsAsudF32J0WjvGXxRtXpBP+57EPwUGq
 krAArXwx/mOS6Pt9FfnQWR2aG9wofz73mB/VUxcSXcict8dRAWbUWuk0gA686DkNWbU0VXKzP
 HlU1yKy6XrvWXTGAoqbO+oToarBJILiZE289h3ocZaJl8=

Hi Phil,

Am 14.04.24 um 00:14 schrieb Andrea della Porta:
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     | 313 +++++++
>   arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |  81 ++
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 841 ++++++++++++++++++
>   4 files changed, 1236 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
>
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts=
/broadcom/Makefile
> index 8b4591ddd27c..92565e9781ad 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -6,6 +6,7 @@ DTC_FLAGS :=3D -@
>   dtb-$(CONFIG_ARCH_BCM2835) +=3D bcm2711-rpi-400.dtb \
>   			      bcm2711-rpi-4-b.dtb \
>   			      bcm2711-rpi-cm4-io.dtb \
> +			      bcm2712-rpi-5-b.dtb \
>   			      bcm2837-rpi-3-a-plus.dtb \
>   			      bcm2837-rpi-3-b.dtb \
>   			      bcm2837-rpi-3-b-plus.dtb \
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm=
64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> new file mode 100644
> index 000000000000..2ce180a54e5b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
> +
> +#define spi0 _spi0
> +#define uart0 _uart0
> +
> +#include "bcm2712.dtsi"
> +
> +#undef spi0
> +#undef uart0
> +
> +/ {
> +	compatible =3D "raspberrypi,5-model-b", "brcm,bcm2712";
> +	model =3D "Raspberry Pi 5";
> +
>
according to this downstream commit [1] it's just called "Raspberry Pi
5" without Model B, but the filename and the compatible says something
different. Is there still a chance to get this consistent or is it too
late because the firmware expect the compatible?

[1] -
https://github.com/raspberrypi/linux/commit/99e359d2f2da2c820fd2a30b1ad08b=
32c9549adb

