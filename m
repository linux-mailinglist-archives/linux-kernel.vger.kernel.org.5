Return-Path: <linux-kernel+bounces-144093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5998F8A41B8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69040B20F26
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB625779;
	Sun, 14 Apr 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AXrl34k4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5C2C190;
	Sun, 14 Apr 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089270; cv=none; b=DRedod4N2zAsEB6/E0p3+fMkWR1PokB7MNbWySLIdVDbumku53LgpiXLQz/IdI5KLr7Kob4Sewn3+hu3uu+cT6LLRV+VmyqeOpo81Xo9qGQX5rguP6rUOiEMo6VlphbVtGcAoBJIg9reTHrnQ0rKL3QK0zZg7dKzbPHNleihVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089270; c=relaxed/simple;
	bh=PYNxOTBDPas3DhTn/LjQCOuHCajbvwfrlkj0oizsSsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZpnNq9rkZC/RBF2USipZ0DT/2HvSjjlwg7Mtr/V+2OnfzOr4xM7bbJTxsl22mhcvwz5Ml6N7JIU7tisXZFytiTjGDxqC3po41J5Qqem8bCERmI42BJD3OHI6T7FrSPUCIYPxmVi53cLLbcxkmpIt2Z+PMQ47lIvebspbiJA5CjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=AXrl34k4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1713089245; x=1713694045; i=wahrenst@gmx.net;
	bh=BcXnyFLSiecfEm9hOusCZzYCTA6xHvCbglcnW+Su5Vc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=AXrl34k4NiaR2xaCHzeaEXjYxpdn6m+RgoiOMGSVaIIq+ebfvFIGsR9fkBn9Vtrb
	 +gXCgsJ4X7Gy508BafjwLAEN60VUQ9cz4in8dYLRJmEmSNoaniKWwTPZKDkXjDgLc
	 j7Wn7lcB30e1n80Wn4O55TY/eoPXZvUhbaHGJJKFsEW0oJmHlEt8hYSmjer7TulEX
	 9zeG+Ir5+aYzW3JW7pW9p/OraVRmvi1b8jGbzh1Q9pxW4iprrhk2d8mQmq/3k3tdU
	 7HfLZIps80ScP4PruUT1xDug+E+WxeaO/DVHccwpL2OoqrLkHVgNQPxCAfpE7ByZN
	 zrq4lcDKgtckw/9eIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1sbI0L4Bq5-00kcXr; Sun, 14
 Apr 2024 12:07:25 +0200
Message-ID: <fd77cfa2-9bd8-4393-95bd-eced676bf6d2@gmx.net>
Date: Sun, 14 Apr 2024 12:07:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add support for BCM2712 SD card controller
To: Andrea della Porta <andrea.porta@suse.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <cover.1713036964.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:accCx00poYGsvNcwQW0/34oRbtZyJ0evPPlSzcwec8RRGSsPtyL
 H8/yzIccKZRoXazP5Vorco9XbWGpZRbWwNDZ/I8xg3F7us6hcBusj0i3Gu5f3xS83sgaujI
 Kwvn2AG/sgbeHzNZEwEXEbUHp+pKoxo/by/mYab/eGqg6UXM+A6WFfnnX9jVq9Rmgz6x/gi
 pNbnG+q7hTDHFLJLi+uwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jbo1m5rDERM=;opjDWYBWEtwH5Lex+q8wTD3WUsl
 qVKp2vcCJLptK1C8b1MDSIniJP9yVPydZ/XY6XCZyJoC2kTI7RrMG97ZBpgpo7AauVWkzOdQ8
 6u8j/QbbJD266Avl37xxYavcbszqnXRa5NjPzJtO3fmPaq6HS5qCuyyUQ/ZFUPkDK1jLBpg6w
 tJr+QJ/1wuaAfAxziJoHCyAMYGVSvd4+iwZrCp1+M21x+3G9ypX52kSWHLHGCmpKvUjKDlVYM
 UUUDEaqjw4t5t1A7TRJQu33otVggqtVjR740XPT9SzqrdePwqE7g91MXMiQ30VJAus3Q7Q5eM
 +scKWV3/tKLfLQmZUn5q4mcyNsrlArCKImQdG3z/r2DwXpDx2GGmG47LdNek8HL0auYLInfDd
 tiGBdXTLLNA282dbQvz+EtMG6dUP0wisxX2Soz+WK/BbuYiJxsXB/HgKzkTFEbObtRfT0nplx
 9sfP9ZVfHIJCH958kpy7yjuBbxtDKd9c3rHVXDQDE+wyzpP4xGdfAt1Jg0cZunPnHWQSThVQv
 k7flYjpdL9hFbiVav+0ldEjT5cJYWxU5aKMJk566fhcwUjs0gvkLszDnicLBKtGHz4pK0n/1m
 fLFI2YN6taln4gU24mX1nRRSGf/wiq+i219Re1eBBmtz4bbszjHKeRehARinA7MZTsc05cWYC
 B3kgaHHg9LCLKekT9PmarzNNZ/W0RpbmLMl59U8nviS03hPF9NoFIN50BjyOV6rbvuwVMJzhf
 MP0X+fYTmXR5R2GedhU5hqyJoBHWTEBMyXuxAP+XTJFaF4P0xh5dbfYxyDQSGCLnPpxAxLWG2
 CJR7fnkjB4Xg+sfcGA5IMJndBSbtEgLwrdsML7dNBZ7Z4=

Hi Andrea,

Am 14.04.24 um 00:14 schrieb Andrea della Porta:
> Hi,
>
> This patchset adds support for the SDHCI controller on Broadcom BCM2712
> SoC in order to make it possible to boot (particularly) Raspberry Pi 5
> from SD card. This work is heavily based on downstream contributions.
since your goal is minimal Raspberry Pi 5 support, i suggest to use this
as the subject for this patch.
> Patch #1 and 2: introduce the dt binding definitions for, respectively,
> the new pin cfg/mux controller and the SD host controller as a preparato=
ry
> step for the upcoming dts.
>
> Patch #3: add a somewhat reasonable (*almost* bare-minimum) dts to be us=
ed
> to boot Rpi5 boards. Since till now there was no support at all for any
> 2712 based chipset, both the SoC and board dts plus definitions for the
> new Pin and SD host controller have been added.
The patch still seems to contain a lot unnecessary stuff (Wifi, BT,
SPI), please try to remove as much as possible for the minimal support
(just boot via debug UART & SD card) in order to make review easier. Btw
this patch must be after pinctrl & SDHCI support.
> Patch #4: the driver supporting the pin controller. Based on [1] and
> successive fix commits.
>
> Patch #5: add SDHCI support. Based on [2] and the next 2 fix commits.
> Drop the SD Express implementation for now, that will be added by patch
> #6.
>
> Patch #6: this patch offers SD Express support and can be considered tot=
ally
> optional. The callback plumbing is slightly different w.r.t. the downstr=
eam
> approach (see [3]), as explained in the patch comment. Not sure what is =
the best,
> any comment is highly appreciated.
I don't think this should be necessary for minimal Raspberry Pi 5
support. Maybe this should be addressed later.

More important would be an additional patch which enables the necessary
drivers in arm64/defconfig.
>
> Tested succesfully on Raspberry Pi 5 using an SDxC card as the boot devi=
ce.
>
> Still untested:
> - SD Express due to the lack of an Express capable card.
>    Also, it will need PCIe support first.
> - card detection pin, since the sd was the booting and root fs device.
>
> Many thanks,
> Andrea
>
> Links:
> [1] - https://github.com/raspberrypi/linux/commit/d9b655314a826724538867=
bf9b6c229d04c25d84
> [2] - https://github.com/raspberrypi/linux/commit/e3aa070496e840e72a4dc3=
84718690ea4125fa6a
> [3] - https://github.com/raspberrypi/linux/commit/eb1df34db2a9a5b752eba4=
0ee298c4ae87e26e87
>
> Andrea della Porta (6):
>    dt-bindings: pinctrl: Add support for BCM2712 pin controller
>    dt-bindings: mmc: Add support for BCM2712 SD host controller
>    arm64: dts: broadcom: Add support for BCM2712
>    pinctrl: bcm: Add pinconf/pinmux controller driver for BCM2712
>    mmc: sdhci-brcmstb: Add BCM2712 support
>    mmc: sdhci-brcmstb: Add BCM2712 SD Express support
>
>   .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   51 +-
>   .../pinctrl/brcm,bcm2712-pinctrl.yaml         |   99 ++
>   arch/arm64/boot/dts/broadcom/Makefile         |    1 +
>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  313 +++++
>   arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |   81 ++
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  841 +++++++++++
>   drivers/mmc/host/Kconfig                      |    1 +
>   drivers/mmc/host/sdhci-brcmstb.c              |  275 ++++
>   drivers/pinctrl/bcm/Kconfig                   |    9 +
>   drivers/pinctrl/bcm/Makefile                  |    1 +
>   drivers/pinctrl/bcm/pinctrl-bcm2712.c         | 1247 +++++++++++++++++
>   11 files changed, 2918 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm2=
712-pinctrl.yaml
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
>   create mode 100644 drivers/pinctrl/bcm/pinctrl-bcm2712.c
>


