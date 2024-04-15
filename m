Return-Path: <linux-kernel+bounces-144930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208A8A4CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AD128403C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0F95D47B;
	Mon, 15 Apr 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="kwsPJ/Nz"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB385C8FC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177830; cv=none; b=iBukEmoNx/tQTA3CaMydD5jKcpzUIcGaF8yC4sPukxg6PhQ91NN6vu5BpyvmrHEflKXnjA86frv/bVkFGWFSjNom/Bwk1CmskyMVzo7YfJJlT1ensCefjltkqNaoBL0aWIKzpzp2DrLYVUtnabF7bsvQPItOBnCZHp+pLWd30jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177830; c=relaxed/simple;
	bh=GoyZ2K2uSZ2QiRtBlva3t0vKVlGk4PFbZEXKavMcgzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocmZn/n93XZiArnzYGDS7MQmtliU9RYpxFcqD7cOIL+bJSyCZ3og2M2OPdAo+qBCvhBMlFsiPdZCd4q+hBBpk1OvfCt1Bd161cqoaVJitF6g3IwiDEemuf68LAIiBlbCRDIah7gip8RGeIkoHLAcpQxzi1dr75cP7pEVpx8OKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=kwsPJ/Nz; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de0f9a501d6so2932716276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1713177827; x=1713782627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=27uQNyY7fO/Nb/RX2/X38PRpC7aDcHGBuUgugg3/cGA=;
        b=kwsPJ/NzN64f/2F4mnXYQKsbwrrnP76Ln7lVwzKvpSgpviLju6VFwR/9M1I3EIbQY7
         Y/7rTawW9x8MHBCiJ2yDvOvKOr1mPha0n0ojkRU2gK8XU6awYdAjM/5+xRhp0Ra8qwad
         xk5XraNFIEkfHQMTFdcuht6hQ7pAOTdQ7baiTr/lw1g84gBvXTd69KCIrrRkGZvAvRVY
         0XtuWooCRL8iHkyR3PbzhZME1xNnPfUOm/LI70zeohky9LCshTFxUQ0RL+vm6xwIW2m7
         RCnG1EQIbQgQ9Ftc/1ta7WquZPIqPPAgoO2RTrlAAnJ13v40TXi9UZAvpHBUAGbNfFZe
         xYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177827; x=1713782627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27uQNyY7fO/Nb/RX2/X38PRpC7aDcHGBuUgugg3/cGA=;
        b=b+qGw/fUGKgAmWNHNsn8VoAD6lbHHsYeq9zsCrR9No8VpDUE815lpn3cUGoGPT62Nd
         yPOJPr/oar5mFnkmJ0aM7Njq7PF7UhDN6pjtSbu0jloyCkoSO4Q4j7E5oK6Jq7S4FLX+
         K4sN8qc8PFLbll41b5Al7HbJJH8zsndD/PSezNRJ/+UTm51JRVyknwYbb6q2zHe8INbb
         JnGzon4bJYvEIMQ6DB1CbwqKojYgwLtSDyFNjbjKOiHgHBupGUfNlGnaFWTq3kQ5ttJ7
         GCb3N44S0vEd/1WLQRj9hH3rxxM/JlLSFWz5Ewa5u0tjPLh4nhqeOdnlFpxC+g/p2Qck
         ooEw==
X-Forwarded-Encrypted: i=1; AJvYcCW4KKEGRUQ+R/ZxOeemOtw6mm6TXKyY5878IgRiU9RU0FrvE90jLCS6QL/YEYQM3eDy8q7+o/CKO0aT9r7MScJ6oO/qQMTftVYJJOHk
X-Gm-Message-State: AOJu0YwLYYJ1lKtZFi1naImq+8HpTfPF75RvHI1wG1Awo166F88gwG4x
	Z5SazRByheMuEyPXPlGeN8EPV8w3OAxttbfUX10iclbFvE9a/5Qj7HOA426YJlH8kbiMgra3t64
	Ypm+uJAUdxUlCHfguZSGjwY5bSNshYmcXu+oZ9A==
X-Google-Smtp-Source: AGHT+IFrOOR02QEeiB0o7nLAcKpgP8IOe7tPByIwJHmAYVK7O1a2uf5Kx5Rt6k7mrlkD/2rXueP7BDyR08YEqnXXSyc=
X-Received: by 2002:a25:6846:0:b0:dcd:1854:9f43 with SMTP id
 d67-20020a256846000000b00dcd18549f43mr7756878ybc.3.1713177826892; Mon, 15 Apr
 2024 03:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713036964.git.andrea.porta@suse.com> <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
 <d7b884dd-9b70-41c3-ac2a-66b54c26d08a@gmx.net> <CAMEGJJ2R-WEqs+LgqMwDQJ_QHF840RYAqVGkbWxBs70anv6M4w@mail.gmail.com>
 <48414875-187d-4afe-ae87-6431b845eaca@gmx.net>
In-Reply-To: <48414875-187d-4afe-ae87-6431b845eaca@gmx.net>
From: Phil Elwell <phil@raspberrypi.com>
Date: Mon, 15 Apr 2024 11:43:36 +0100
Message-ID: <CAMEGJJ1xGNx0r1T_-WyoAnFtZZxxWfxudVorBu=ZVWQFnKwDEQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: broadcom: Add support for BCM2712
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jonathan Bell <jonathan@raspberrypi.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, 
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org, 
	Kamal Dasu <kamal.dasu@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Stefan,

On Mon, 15 Apr 2024 at 10:06, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Phil,
>
> Am 15.04.24 um 10:52 schrieb Phil Elwell:
> > Stefan,
> >
> >
> > On Mon, 15 Apr 2024 at 09:20, Stefan Wahren <wahrenst@gmx.net> wrote:
> >> Hi Phil,
> >>
> >> Am 14.04.24 um 00:14 schrieb Andrea della Porta:
> >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> >>> ---
> >>>    arch/arm64/boot/dts/broadcom/Makefile         |   1 +
> >>>    .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     | 313 +++++++
> >>>    arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |  81 ++
> >>>    arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 841 ++++++++++++++++++
> >>>    4 files changed, 1236 insertions(+)
> >>>    create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> >>>    create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
> >>>    create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> >>>
> >>> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> >>> index 8b4591ddd27c..92565e9781ad 100644
> >>> --- a/arch/arm64/boot/dts/broadcom/Makefile
> >>> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> >>> @@ -6,6 +6,7 @@ DTC_FLAGS := -@
> >>>    dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
> >>>                              bcm2711-rpi-4-b.dtb \
> >>>                              bcm2711-rpi-cm4-io.dtb \
> >>> +                           bcm2712-rpi-5-b.dtb \
> >>>                              bcm2837-rpi-3-a-plus.dtb \
> >>>                              bcm2837-rpi-3-b.dtb \
> >>>                              bcm2837-rpi-3-b-plus.dtb \
> >>> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> >>> new file mode 100644
> >>> index 000000000000..2ce180a54e5b
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> >>> @@ -0,0 +1,313 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/dts-v1/;
> >>> +
> >>> +#include <dt-bindings/gpio/gpio.h>
> >>> +#include <dt-bindings/interrupt-controller/irq.h>
> >>> +#include <dt-bindings/pwm/pwm.h>
> >>> +#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
> >>> +
> >>> +#define spi0 _spi0
> >>> +#define uart0 _uart0
> >>> +
> >>> +#include "bcm2712.dtsi"
> >>> +
> >>> +#undef spi0
> >>> +#undef uart0
> >>> +
> >>> +/ {
> >>> +     compatible = "raspberrypi,5-model-b", "brcm,bcm2712";
> >>> +     model = "Raspberry Pi 5";
> >>> +
> >>>
> >> according to this downstream commit [1] it's just called "Raspberry Pi
> >> 5" without Model B, but the filename and the compatible says something
> >> different. Is there still a chance to get this consistent or is it too
> >> late because the firmware expect the compatible?
> >>
> >> [1] -
> >> https://github.com/raspberrypi/linux/commit/99e359d2f2da2c820fd2a30b1ad08b32c9549adb
> > Nothing cares about the compatible string, but the product name was
> > changed too late for the firmware, which expects the current DTB file
> > name.
> should i send a pull request to address the compatible? This would avoid
> a little bit confusion in the upstreaming process, because
> devicetree/bindings/arm/bcm/bcm2835.yaml needs to be updated as well.

You think it is better to have the compatible string different to the
file name, rather than just the human-readable model string being
different? I don't agree.

Phil

