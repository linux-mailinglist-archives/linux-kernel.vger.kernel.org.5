Return-Path: <linux-kernel+bounces-53232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630784A266
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8641C24186
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB37481AE;
	Mon,  5 Feb 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADj8qWNn"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34347F76;
	Mon,  5 Feb 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157754; cv=none; b=mECc7W2cvtAd7437HKvoh+/feWVUJ3GsB7PRIJbPNscLlndogDIJEWCC3JMK3pSCoM04xXmHtNV0lV2YqTLxue6N8TeARWeO4322e9hDieAbxBiCyTxKtxkjorb5+Oj05mAQR0GF647dS9enR70+YgR+Vin/zsjD+xK7o4ICphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157754; c=relaxed/simple;
	bh=5iJG7mTE9jvfBW/08iHqQu27z3Ad4iCGD6JVH5qMvb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asQWG2CyznhL0kS+bcU5tJ1n+A/l4FZ4MeqKAi6u3I0Qsm0WDrXa8Fj9ulhgTIXd40AWYvyl+ek4kmcmc9q5bwIkUG/WWilP2QjBHuwQvyqvQ5YcOtzVsq5EQjmTWe7hgE7Cv1hSLsCYIDeyj5JKjaHjkRU8HTuliU4S26WUPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADj8qWNn; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42aadddeaf8so35299221cf.3;
        Mon, 05 Feb 2024 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157751; x=1707762551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1B5iScXoA/5W1Dgj9FcdygomTlviOLRXfkCvdaAIug=;
        b=ADj8qWNnnjbbtOMAEdJG7pl1fucrKxqsTMigK3DrfvSv2gTHtgzRKyJ8AmH7cPstZt
         qa+Lb3Zg/BZ5rxpNGCjVjL5ndTnV3jJyq0RmnJ6GBXiv2oJXBf9Rc5MeVV7Wm9A9yIrP
         XueR7Uj+M0OImsABZCLM+QGoSfzqg9hKbV3q1ybLK8hgpuI0+Y93NhRikZ/SllCe7WDS
         lgn17e0sPJrJ1YI2oqNHD/sdUvo0TKRb8PBOQ89O5SOhZefKkSAFovEaHANb9VVQfnc4
         alWdrWjtoFLHRG1fQ5IyFizvk3Rhu2EerXGaaL+M/DhHUvRqI6qH8wxTJlsJUcLsCDEb
         66iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157751; x=1707762551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1B5iScXoA/5W1Dgj9FcdygomTlviOLRXfkCvdaAIug=;
        b=l3RrZdacSnm69w6BYCsWMWGGLSy72McYw1+Quy4QFJ2qjkyDCARDiy4HYq334KXvJh
         Ba6BK1sHPPZ9WoC2altVBa8nDDj7Rb9WTtmFveuKip+1m8v5NrlOixaYUq7aA9ErI3sX
         5nRdq/Sx9B28I+cFbf1ekkdDVSuO4g2rWpk9CHF/Mq7g1YE+I2N/syW3qwGE2eDutKj2
         WK6e3UKflLlbEGpXpLNww2IR1KvGIphKlsc/2k/bHM612XZBcuCbnItzFIcsAy7TS40W
         JaFziuOKGJuAP9j0iGH2NvTVKzmXd3Rag4qaXYQAoHJq5TQE1QlLbAGl4K1MIU2/tAA5
         SmIg==
X-Gm-Message-State: AOJu0YxH5A0U7oqoVvfl01r/ZvAO4bKKuypUxFd8sofD8BLQ9wIkJ5cA
	rw3VHvuRkY0OvPKjDg7bTT12tuFD7qpqqqvhMlIkzh+/A9GnQ+5H
X-Google-Smtp-Source: AGHT+IHqmf+8NRkOgFTYqZ0l7I79OdyNDzSSVczj7M0IK4B4h5uFk+5iD/fOq+NVxMt09K4xe9TP4A==
X-Received: by 2002:a05:6214:d6d:b0:686:a20c:faf with SMTP id 13-20020a0562140d6d00b00686a20c0fafmr338006qvs.12.1707157751371;
        Mon, 05 Feb 2024 10:29:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEoyhwJZqXSA0SA3jIMoZL90s0K9k46Lx8/CbMnWhtChHDtjS6vl3TBKc0dLaB7eStbh1xGjFJRFAh2OKTfyFbiCvmPLVlo2QdrBC1ysyXO1qfnAN8RF5aCYulqDh4y4mbcCtl/JAGS60AIEFFSDjlrzbUSACeG1NBIFPel14y2uJ3r0Moih8GGWrRJy2BqWAu0tBl9n/SBx/4N1zS+iqBI8le2Jg6sHgGsfdWrr3VI9BtP49YFDUeZ5SBhoQ+U1KUxmxj5PTEsupsVGN2RI9Kbe96C07kOzpwJStBpstzbzo9sm9Co+FTqQPYBXssqPT+1BGur+meuSH4b9HoXNyFh1wB6fdpfguH544p7+KNGGNUKYFp+c2jCW8UTp4J8oHoKFf9/9FgE37j43T5Lk4=
Received: from jernej-laptop.localnet (82-149-13-182.dynamic.telemach.net. [82.149.13.182])
        by smtp.gmail.com with ESMTPSA id b16-20020ad45190000000b0068ca40389besm212291qvp.101.2024.02.05.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:29:11 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <uwu@icenowy.me>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/2] arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and Pi
 3H board support
Date: Mon, 05 Feb 2024 19:29:08 +0100
Message-ID: <3466281.QJadu78ljV@jernej-laptop>
In-Reply-To: <Zb4zWsfzgJkZa2KQ@xhacker>
References:
 <20231228145647.1470-1-jszhang@kernel.org> <2589997.Lt9SDvczpP@jernej-laptop>
 <Zb4zWsfzgJkZa2KQ@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne sobota, 03. februar 2024 ob 13:36:42 CET je Jisheng Zhang napisal(a):
> On Tue, Jan 09, 2024 at 09:37:03PM +0100, Jernej =C5=A0krabec wrote:
> > Hi Jisheng,
>=20
> Hi Jernej,
>=20
> >=20
> > Andre gave you thorough review already, so just one additional comment
> > below.
> >=20
> > Dne =C4=8Detrtek, 28. december 2023 ob 15:56:47 CET je Jisheng Zhang na=
pisal(a):
> > > The Sipeed Longan SoM 3H is a system on module based on the Allwinner
> > > H618 SoC. The SoM features:
> > >=20
> > > - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> > > - 2/4 GiB LPDDR4 DRAM SoMs
> > > - AXP313a PMIC
> > > - eMMC
> > >=20
> > > The Sipeed Longan PI 3H is a development board based on the above SoM.
> > > The board features:
> > > - Longan SoM 3H
> > > - Raspberry-Pi-1 compatible GPIO header
> > > - 2 USB 2.0 host port
> > > - 1 USB 2.0 type C port (power supply + OTG)
> > > - MicroSD slot
> > > - 1Gbps Ethernet port (via RTL8211 PHY)
> > > - HDMI port
> > > - WiFi/BT chip
> > >=20
> > > Add the devicetree file describing the currently supported features,
> > > namely PMIC, LEDs, UART, SD card, eMMC, USB and Ethernet.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> > >  .../sun50i-h618-longan-module-3h.dtsi         |  82 +++++++++++
> > >  .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 133 ++++++++++++++++=
++
> > >  3 files changed, 216 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-=
module-3h.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanp=
i-3h.dts
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot=
/dts/allwinner/Makefile
> > > index 3aca6787a167..00db504a9b8c 100644
> > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > @@ -42,4 +42,5 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreete=
ch-cb1-manta.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> > > +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-longanpi-3h.dtb
> > >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-orangepi-zero3.dtb
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-=
3h.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
> > > new file mode 100644
> > > index 000000000000..88a7d287b73c
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
> > > @@ -0,0 +1,82 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sun50i-h616.dtsi"
> > > +
> > > +/ {
> > > +	model =3D "Sipeed Longan Module 3H";
> > > +	compatible =3D "sipeed,longan-module-3h", "allwinner,sun50i-h618";
> > > +};
> > > +
> > > +&mmc2 {
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&mmc2_pins>;
> > > +	vmmc-supply =3D <&reg_dldo1>;
> > > +	vqmmc-supply =3D <&reg_aldo1>;
> > > +	bus-width =3D <8>;
> > > +	non-removable;
> > > +	cap-mmc-hw-reset;
> > > +	mmc-ddr-1_8v;
> >=20
> > I think above is superfluous if hs200 is also defined.
>=20
> I read the mmc code again, IMHO, mmc-ddr-1_8v and mmc-hs200-1_8v
> are for different caps, the former is for MMC_CAP_1_8V_DDR and
> the later is for MMC_CAP2_HS200_1_8V_SDR, I must admit that
> mmc-hs200-1_8v does imply mmc-ddr-1_8v in normal host controllers
> but they are different, and I found other dts files also contain
> both, so I kept this as is in v2.

Yeah, this was oversight. Most DTs have only second one defined.

Best regards,
Jernej

>=20
> Thanks
>=20
> >=20
> > > +	mmc-hs200-1_8v;
> > > +	status =3D "okay";
> > > +};
> > > +
> =20
>=20





