Return-Path: <linux-kernel+bounces-144817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB758A4B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27117B244F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B873C46B;
	Mon, 15 Apr 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="J3fXMbIX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337013FB2F;
	Mon, 15 Apr 2024 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172018; cv=none; b=NakJJ4VpNrmi6QI8sYvRnT/aPsRWRVcA/1UQm94Q1RM4NkuwdVVLqRpv3L+lxjCgJ2ssaSmYvREclHEPZ89k4M3ngYGvDgnTTKNbRYhCCw5sX9KyGMrQBJ3bO70FlQcY2hZJSmUAwsBW/OiXglOAQ9PWlaZVD2pBeOeVPzuYPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172018; c=relaxed/simple;
	bh=Y5nbs45jMBNKDqjA80WR2kWn52G0oSM52UyubBPrLFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMGx8c5IpmFWaOQz+/I9mD5xmKL2BMgMo5jogZkoSgLCu8sI8qPq2kKW5JSl2BdYJRXWYIUN/TpwK7hn3zUmB3e90xOEf7l9OziT6q9DmH0WuMfzvShPLHq8MTf2v/Uku97tGeH0kRBugmVzH5vVTdNMsXixB64/rKCqvLCHrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=J3fXMbIX; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1713171993; x=1713776793; i=wahrenst@gmx.net;
	bh=iVvbXiK9+4jKmBby/qHuymH4wqCDuhTpZTWgpimbGeE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=J3fXMbIX9LLAGfD6kfwfvHdiXn8RckqgxmHO85GPsonO5ej/Z2fAbLl+z0xhAjjV
	 UpmO4PStxqhXUxk5VzRr3a7xN7U/l7y+PCOSlqmEHKCIbns7ISHnXM1FXDVxGDjb3
	 wmzbJqbasVshbXhwMXU+t12ffal2mhGSfJgjGxKygxy8zjDtjLY0au02CoWhNbaW5
	 p+z3HR+cDRIvjWjiSqQBbA0C1J8g9IJ1nykcg1DJwawHo1yssLSq0Errdpc1V5mMD
	 hep0waXtf8J+B1h0HBp7AZ4t8HmG196nlN/978NT82eeyfBIwgCEcEJegA2uGCc0M
	 mBiuNV44cekCurVd6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1sH6RJ39MK-00VzWL; Mon, 15
 Apr 2024 11:06:33 +0200
Message-ID: <48414875-187d-4afe-ae87-6431b845eaca@gmx.net>
Date: Mon, 15 Apr 2024 11:06:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: broadcom: Add support for BCM2712
To: Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Bell <jonathan@raspberrypi.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
 Kamal Dasu <kamal.dasu@broadcom.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1713036964.git.andrea.porta@suse.com>
 <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
 <d7b884dd-9b70-41c3-ac2a-66b54c26d08a@gmx.net>
 <CAMEGJJ2R-WEqs+LgqMwDQJ_QHF840RYAqVGkbWxBs70anv6M4w@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CAMEGJJ2R-WEqs+LgqMwDQJ_QHF840RYAqVGkbWxBs70anv6M4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wbkUfb+3POtV/dyswIWfamIRka73DquA3dHwWh7g3oVut6k3jDB
 xDufkZUndxr7JICIELbkyCObezpt8CpmOf2AGwgwAhyDBtKqRlF+Wdzz4daHswBE45CAott
 p1PFmv9Pp2EqbwzvrSp68LkvDMtAknucXe1Azi6NuKNkNC/JDWA9yZ+n2iHKeDvGdIYwejh
 XiHOh9KqW6pnd6NE+Jlbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7tHIbPC4OPE=;0o3Qmm8vlD26+gY5h7dXTZ9iQi1
 zj0OK3X3lReB4XHePGLPIK9wdIbP7X4j2VoFizl/ccS+yL4hb9oRt9smL5ZlUY+vqOdGmSP7j
 0sbG9K7r9KzSS5NCQ/SEWBQ+l1vqGudz9ZawGrmzICjlB4+JYpKM9w0CVcFt/Aah5zDLCEaH2
 HaxlTbcBcuWPRVGlnaYcpNnpp3drvpRQSLlTvqmKwuHt5YsTRHjC1Sen5e8L2QMYuh1R+MEKL
 sJGLlGYS/lsj9yVocB7RMdEPNIAF13HmGJ7E5dTGRrOTelYmJ21NCTcCfXa8Ak4Gaf0YAMXZ7
 VEVYSL3y5qEYVk4cqHEK+YxnX3cRZu6t9EpfYtAWw4S9YqbaXy+oK3PCOUkgaTjQuwtWlD+IY
 HlEohfSXso/PQnkVuRG4XtwTN9Hsch4sbHShTA0/F4MgvCPy9ixW2uw5CsI5Mu7J2X79jnH7M
 AhUOv7EObhjKKBPnpzAYpyKEg51ZLBAr1cNXtlRkfHnPGZQrPqT132BeJokMQF3lNtJvi6QAE
 pqtbzcRHtE3z+WD/r/roW1/wvtTfsOZIoGtK59qh7MQiWHkwQtRboe2YrYSzB+qUYPc/z6CuN
 oZkmKF1YJjajqlMAIE1VgXrhFGbli3mTSnvDZsWAVLs539XVaHIYHFzEkuSZcdhDMiWi0ByEV
 V6qGE+xXW+it6EgjNWQSlgxcGdToO5pNiRJakn+VXKX2CkYwOAtrBd9b9GsJqvJ+U9F0k7G5L
 doZ5ES2CVfyd1VFjJBDYw06ULf8H+D/JRg0yJrnjuXBC2h8EZ4Xfz+UEqOsAEuKBEQFxoqEmu
 u2+T1wt9huhjy3uB2dBeCErCyJnUiu2CJZ6L9GV/UI/4s=

Hi Phil,

Am 15.04.24 um 10:52 schrieb Phil Elwell:
> Stefan,
>
>
> On Mon, 15 Apr 2024 at 09:20, Stefan Wahren <wahrenst@gmx.net> wrote:
>> Hi Phil,
>>
>> Am 14.04.24 um 00:14 schrieb Andrea della Porta:
>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>> ---
>>>    arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>>>    .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     | 313 +++++++
>>>    arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |  81 ++
>>>    arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 841 +++++++++++++++=
+++
>>>    4 files changed, 1236 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>>>    create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
>>>    create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/d=
ts/broadcom/Makefile
>>> index 8b4591ddd27c..92565e9781ad 100644
>>> --- a/arch/arm64/boot/dts/broadcom/Makefile
>>> +++ b/arch/arm64/boot/dts/broadcom/Makefile
>>> @@ -6,6 +6,7 @@ DTC_FLAGS :=3D -@
>>>    dtb-$(CONFIG_ARCH_BCM2835) +=3D bcm2711-rpi-400.dtb \
>>>                              bcm2711-rpi-4-b.dtb \
>>>                              bcm2711-rpi-cm4-io.dtb \
>>> +                           bcm2712-rpi-5-b.dtb \
>>>                              bcm2837-rpi-3-a-plus.dtb \
>>>                              bcm2837-rpi-3-b.dtb \
>>>                              bcm2837-rpi-3-b-plus.dtb \
>>> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/a=
rm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>>> new file mode 100644
>>> index 000000000000..2ce180a54e5b
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>>> @@ -0,0 +1,313 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/pwm/pwm.h>
>>> +#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
>>> +
>>> +#define spi0 _spi0
>>> +#define uart0 _uart0
>>> +
>>> +#include "bcm2712.dtsi"
>>> +
>>> +#undef spi0
>>> +#undef uart0
>>> +
>>> +/ {
>>> +     compatible =3D "raspberrypi,5-model-b", "brcm,bcm2712";
>>> +     model =3D "Raspberry Pi 5";
>>> +
>>>
>> according to this downstream commit [1] it's just called "Raspberry Pi
>> 5" without Model B, but the filename and the compatible says something
>> different. Is there still a chance to get this consistent or is it too
>> late because the firmware expect the compatible?
>>
>> [1] -
>> https://github.com/raspberrypi/linux/commit/99e359d2f2da2c820fd2a30b1ad=
08b32c9549adb
> Nothing cares about the compatible string, but the product name was
> changed too late for the firmware, which expects the current DTB file
> name.
should i send a pull request to address the compatible? This would avoid
a little bit confusion in the upstreaming process, because
devicetree/bindings/arm/bcm/bcm2835.yaml needs to be updated as well.

Best regards
>   I'm happy with the naming as it stands, since we use Pi 4 to
> refer to all the BCM2711-based devices, and Pi 5 can include CM5.
>
> Phil


