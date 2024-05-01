Return-Path: <linux-kernel+bounces-165574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7978B8E25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923B2B2253D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD412FF93;
	Wed,  1 May 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Jp9ghlFL"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B312EBDD
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580751; cv=none; b=KKM+xPf5Hrv+lVE5dOz35I99/hee8pg2ivKBrpunnHVUwG4n87gYPI9JCdci0E3oICwoB3IgmQ/eiIIl/nzdXoN9Xj8TYIcjL67GjlY70CoQDV7iG+R7Nr1Vy65BvGRq4rCq2RMOcHeA1RkI71nImPB7etfM47rn2K56hTrzXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580751; c=relaxed/simple;
	bh=lj6182TtGyMerXvAktaT+va4EK5H9EM7yQy2xaY4ZNg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OU0kogcTpCvvn4zcyq0T6NO3H3FL7i3s1+CzKuybhVysrc24/ERM/YucWjTZyq3LdO2NX98LoxClToY7Jjd5fHM9UMN4VLvtAnjnQO4FawDg2hDURKqmDXGR/98e+8KdvWCypkTKfweevy1NkpmykhQgDf/OVkfhxuWJlkD/eGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Jp9ghlFL; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CEAFD410AE
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714580745;
	bh=wycYCbLMd5yuBOu2HDuqsCYrixIlc2Lb2z75WJVmmSM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Jp9ghlFLAJ2x1hzT3mGbdyEiMNSub5aezcwMG3XFj+qx6jekSOUOFHTrY+A4Mu2T4
	 5GBLsxhmYuvFJxPwSov0rN6fhJ95OIj1H6a4KhJgWufs6ZQZTqkyO9CvZkYW8UlcVI
	 r/R6ImjC6ioob/OMMiCGceyZKAN3rKbuyLN0rnpjx5KqAOYSd2GH0nKvUa9gNcRCgo
	 hKpYyW3ac72nndmJof0JfEX155PW5W/AZBwENLqsWrIVD6fwke1R4WdZikSCblyBJx
	 GKYgW1pl5R/ApPYudUZ8CnIME94LJ3eTmzNuspr2m3oCDpMClKlJ5S90ijuoW2xwos
	 amiTGxcvED3eA==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43b0a5616ebso32244231cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580744; x=1715185544;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wycYCbLMd5yuBOu2HDuqsCYrixIlc2Lb2z75WJVmmSM=;
        b=u5rQXU+uAqaZ9ZembWBZ5haGUkuaD4I2UMdLUBCSqbp7yJdbc0Fe+UxquWoHG/2Nzw
         SIq8LvKsYUmHUOssfWzXijPiAPspsJa+cLkjD9gdqZ4XCj4HPzQl6R4BeYySiFvx4R+I
         RUfoQKbnhcpQeAqiMHOcBThW+WvdXymm4hlCTS5e/zQOhm7ni103DhUyXqFxpaFpqABW
         oulHCR4GoVIZ/YxFgtHL25O30vU0cGrIMvjN/CdLxlPSylQ6szPHLGJTxmIwyOnhQ2Fr
         kgVyI8zCbmPT/bPTJ6LXyxZDw8TfXjwgsTsHHjn+wj/QlfZf0j4xuoftOt+p7QgswboB
         Uzhg==
X-Forwarded-Encrypted: i=1; AJvYcCVHB5GizusYU/UVi2//Y8AoSLsG+ehjaYoncteKa1ZvI1LR04ynHi8YGq0PlNn0fYbKQ0YEpXYd2k7U7ZJThTwZaT5ZSMfW/lt9q4m8
X-Gm-Message-State: AOJu0Yyv1PAYNI/qGB727/6xXvPGXm41eeHtw3FAg26jc7jTZzgt8pqr
	RNzRLmOo5l/eKI/CAOfdl1VWwdj/epBk0FTrxIFGdBz6EAZXwfYIIxlTNBMfBbI93UXyuRn/Fqq
	/J8axvVu7LFg8kOfUuTBE8S6osAnN8CgscYNfVvfhTUtrgSc6jrbnubtxq9H113dRNyHJe7B1ee
	0O6+5Ag9TvASi47uZqbnB6I5NrTAEHSsPvcDHyRTK0Bp5HZsoL6BvKH+lyxaMm
X-Received: by 2002:a05:622a:314:b0:43a:cd4f:b227 with SMTP id q20-20020a05622a031400b0043acd4fb227mr2534195qtw.49.1714580744119;
        Wed, 01 May 2024 09:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe2kVLkf6u2qf3YuZKhV8dPFhEQQwlkviXB5GbiMEsirgCec00LON7FXxMJGNO9zItZm8gwljpWd0lxgy15R8=
X-Received: by 2002:a05:622a:314:b0:43a:cd4f:b227 with SMTP id
 q20-20020a05622a031400b0043acd4fb227mr2534177qtw.49.1714580743783; Wed, 01
 May 2024 09:25:43 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 May 2024 09:25:43 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <mhng-3c2a418c-ce79-4287-a890-208a5d026e70@palmer-ri-x1c9a>
References: <20240403060902.42834-1-hal.feng@starfivetech.com> <mhng-3c2a418c-ce79-4287-a890-208a5d026e70@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 1 May 2024 09:25:43 -0700
Message-ID: <CAJM55Z810=pxc+tmgw0yS+Nx=K9h=OGFxOhvtJT7nyGGg0d_nA@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
To: Palmer Dabbelt <palmer@dabbelt.com>, hal.feng@starfivetech.com
Cc: Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	aou@eecs.berkeley.edu, emil.renner.berthing@canonical.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Palmer Dabbelt wrote:
> On Tue, 02 Apr 2024 23:09:02 PDT (-0700), hal.feng@starfivetech.com wrote:
> > Add support for StarFive JH7110 SoC and VisionFive 2 board.
> > - Clock & reset
> > - Cache
> > - Temperature sensor
> > - PMIC (AXP15060)
> > - Restart GPIO
> > - RNG
> > - I2C
> > - SPI
> > - Quad SPI
> > - USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
> > - Audio (I2S / TDM / PWM-DAC)
> > - Camera Subsystem & MIPI-CSI2 RX & D-PHY RX
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >
> > Hi,
> >
> > As more drivers of StarFive JH7110 VisionFive 2 board are upstream,
> > add support for them in riscv defconfig.
> >
> > Best regards,
> > Hal
> >
> > ---
> >  arch/riscv/configs/defconfig | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index fc0ec2ee13bc..a4eb66b30d95 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -111,6 +111,7 @@ CONFIG_PCIE_XILINX=y
> >  CONFIG_PCIE_FU740=y
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> > +CONFIG_SIFIVE_CCACHE=y
> >  CONFIG_MTD=y
> >  CONFIG_MTD_BLOCK=y
> >  CONFIG_MTD_CFI=y
> > @@ -154,24 +155,36 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> >  CONFIG_VIRTIO_CONSOLE=y
> >  CONFIG_HW_RANDOM=y
> >  CONFIG_HW_RANDOM_VIRTIO=y
> > +CONFIG_HW_RANDOM_JH7110=m
> > +CONFIG_I2C=y
> >  CONFIG_I2C_CHARDEV=m
> > +CONFIG_I2C_DESIGNWARE_PLATFORM=y
> >  CONFIG_I2C_MV64XXX=m
> >  CONFIG_I2C_RIIC=y
> >  CONFIG_SPI=y
> > +CONFIG_SPI_CADENCE_QUADSPI=m
> > +CONFIG_SPI_PL022=m
> >  CONFIG_SPI_RSPI=m
> >  CONFIG_SPI_SIFIVE=y
> >  CONFIG_SPI_SUN6I=y
> >  # CONFIG_PTP_1588_CLOCK is not set
> >  CONFIG_GPIO_SIFIVE=y
> > +CONFIG_POWER_RESET_GPIO_RESTART=y
> > +CONFIG_SENSORS_SFCTEMP=y

If this needs an update anyway this temperature sensor shouldn't be critical to
boot and can be left as a module.

/Emil

> >  CONFIG_CPU_THERMAL=y
> >  CONFIG_DEVFREQ_THERMAL=y
> >  CONFIG_RZG2L_THERMAL=y
> >  CONFIG_WATCHDOG=y
> >  CONFIG_SUNXI_WATCHDOG=y
> >  CONFIG_RENESAS_RZG2LWDT=y
> > +CONFIG_MFD_AXP20X_I2C=y
> >  CONFIG_REGULATOR=y
> >  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> > +CONFIG_REGULATOR_AXP20X=y
> >  CONFIG_REGULATOR_GPIO=y
> > +CONFIG_MEDIA_SUPPORT=m
> > +CONFIG_V4L_PLATFORM_DRIVERS=y
> > +CONFIG_VIDEO_CADENCE_CSI2RX=m
> >  CONFIG_DRM=m
> >  CONFIG_DRM_RADEON=m
> >  CONFIG_DRM_NOUVEAU=m
> > @@ -183,6 +196,10 @@ CONFIG_SOUND=y
> >  CONFIG_SND=y
> >  CONFIG_SND_SOC=y
> >  CONFIG_SND_SOC_RZ=m
> > +CONFIG_SND_DESIGNWARE_I2S=m
> > +CONFIG_SND_SOC_STARFIVE=m
> > +CONFIG_SND_SOC_JH7110_PWMDAC=m
> > +CONFIG_SND_SOC_JH7110_TDM=m
> >  CONFIG_SND_SOC_WM8978=m
> >  CONFIG_SND_SIMPLE_CARD=m
> >  CONFIG_USB=y
> > @@ -196,6 +213,11 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
> >  CONFIG_USB_RENESAS_USBHS=m
> >  CONFIG_USB_STORAGE=y
> >  CONFIG_USB_UAS=y
> > +CONFIG_USB_CDNS_SUPPORT=m
> > +CONFIG_USB_CDNS3=m
> > +CONFIG_USB_CDNS3_GADGET=y
> > +CONFIG_USB_CDNS3_HOST=y
> > +CONFIG_USB_CDNS3_STARFIVE=m
> >  CONFIG_USB_MUSB_HDRC=m
> >  CONFIG_USB_MUSB_SUNXI=m
> >  CONFIG_NOP_USB_XCEIV=m
> > @@ -233,6 +255,13 @@ CONFIG_VIRTIO_BALLOON=y
> >  CONFIG_VIRTIO_INPUT=y
> >  CONFIG_VIRTIO_MMIO=y
> >  CONFIG_RENESAS_OSTM=y
> > +CONFIG_STAGING=y
> > +CONFIG_STAGING_MEDIA=y
> g
> I don't think we want staging on in defconfig.
>
> > +CONFIG_VIDEO_STARFIVE_CAMSS=m
>
> Is it just for this?  I think we can just exclude that from defconfig
> until it gets out of staging, we should be able to boot without it.
> According to the TODO userspace isn't there yet, so I think it should be
> pretty safe.
>
> > +CONFIG_CLK_STARFIVE_JH7110_AON=y
> > +CONFIG_CLK_STARFIVE_JH7110_STG=y
> > +CONFIG_CLK_STARFIVE_JH7110_ISP=y
> > +CONFIG_CLK_STARFIVE_JH7110_VOUT=y
> >  CONFIG_SUN8I_DE2_CCU=m
> >  CONFIG_SUN50I_IOMMU=y
> >  CONFIG_RPMSG_CHAR=y
> > @@ -244,6 +273,9 @@ CONFIG_RZG2L_ADC=m
> >  CONFIG_RESET_RZG2L_USBPHY_CTRL=y
> >  CONFIG_PHY_SUN4I_USB=m
> >  CONFIG_PHY_RCAR_GEN3_USB2=y
> > +CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
> > +CONFIG_PHY_STARFIVE_JH7110_PCIE=m
> > +CONFIG_PHY_STARFIVE_JH7110_USB=m
> >  CONFIG_LIBNVDIMM=y
> >  CONFIG_NVMEM_SUNXI_SID=y
> >  CONFIG_EXT4_FS=y
> >
> > base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

