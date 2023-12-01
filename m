Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1EF800A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378607AbjLALrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378585AbjLALrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:47:41 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A67A1B3;
        Fri,  1 Dec 2023 03:47:47 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E714A3200A8E;
        Fri,  1 Dec 2023 06:47:45 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 06:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701431265; x=1701517665; bh=7ri5tWAUJf5m69RwLv3NcQqa3J7mZD+4VnE
        JqjN5jpM=; b=cti0Sb3GU7HoMOuPP9fGsYx+/uuDBCHB/PT1vW7jwhW1F4Uye+C
        vI55yEmiRg6AG8vh8P254lCMS1Xp5f5aCW+PILNu4AX2up6wkp5oGj3+OuFQgIRg
        5vxT1ULbCv3mUctmBb9UO5SQWvVUTyuQQOAIkI7lboezTvnKJN6oB/uHdLg1mqK5
        MuWU2BUZ/b/6anWebeoIyuN7E0AjSuxuN/KD7bNDEplvDzRTLkv9ssdzz9VTg4E1
        FovAeaIkynAYJn6IURzDKYp4Z3EjvvL41WQ1N5BZkN4u9Iaa8GKiqo7xCWoTyNHe
        SAnaUpTc8zrlT7KicP+F4vzSNgWT4vXuG3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701431265; x=1701517665; bh=7ri5tWAUJf5m69RwLv3NcQqa3J7mZD+4VnE
        JqjN5jpM=; b=KiYhWAYqXPGFmvkgUsTNo4otFI1qgTbiywt89/Bq9CEkRvGLt1S
        lQy0EPd4oKpmWSXnUwPHMvsx4/swdI81PE21aQzMBPp1GpfkA2CQC198A4IdtyX+
        HVKATxbd8rcxHYtd0gelltOHeJxnt2l7C7I2cIbmuOIvj+P8p+Ey9GnkxNA5Ee15
        aKUc4rVbw8jx1Cr+eNi221KSSqul5YJOVdbCDYJIKYJSm4pgWrpF8oQ9tFQOQDqD
        fLVMI2jIic2QSaVpICvNKWnUxWNcyYh5DZVQFWcDMgRxT4L4Lryp26Vfu+2vLSdb
        vJx9azWezVFYvYEHNSPQO7r7V4kj8KW1HkA==
X-ME-Sender: <xms:4cdpZchjquCZxF_jug5S__RCc5dNASZ7uj6JWF59ncLH-zJjNMIa0A>
    <xme:4cdpZVBIiHIys14tQL0Fqd542V6CAHEXeckkibXE0gPvS2C-3TUpBhYowi9uzsvDY
    2SEBCZNnW51J1fhX90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeetvdegffdtgfegjeetgeegjeeitddvvefgieettefg
    hfeuhfevleduieeffedugeenucffohhmrghinhepihhtshdrshgsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:4cdpZUECHzYyOYjyZYJSfsYjSqupdS-c9sTYhH281jGgFNlTGJRS6Q>
    <xmx:4cdpZdTHCZ5jLtsjiUqZjnzkKicEmpB2z2sb03R8hR_6WT4YmrG-dg>
    <xmx:4cdpZZxRZl8GUKVXTerF_VVh3hqASWRmAKAXVRYDhMduPS1Y4NFsFA>
    <xmx:4cdpZeqCtBBWz_1eiiJtZQc-8_SytZ3GkvbiOqH6cheam9rnFrwAhg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0BE6C36A0075; Fri,  1 Dec 2023 06:47:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <4eb150cf-3fb7-41c8-accc-06b13e46f086@app.fastmail.com>
In-Reply-To: <20231201111512.803120-22-gregory.clement@bootlin.com>
References: <20231201111512.803120-1-gregory.clement@bootlin.com>
 <20231201111512.803120-22-gregory.clement@bootlin.com>
Date:   Fri, 01 Dec 2023 11:47:16 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 21/22] MIPS: generic: Add support for Mobileye EyeQ5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B412=E6=9C=881=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8A=E5=8D=8811:15=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
> Introduce support for the MIPS based Mobileye EyeQ5 SoCs.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  arch/mips/configs/generic/board-eyeq5.config | 43 ++++++++++++++++++++
>  arch/mips/generic/Kconfig                    | 15 +++++++
>  arch/mips/generic/Platform                   |  2 +
>  arch/mips/generic/board-epm5.its.S           | 24 +++++++++++
>  4 files changed, 84 insertions(+)
>  create mode 100644 arch/mips/configs/generic/board-eyeq5.config
>  create mode 100644 arch/mips/generic/board-epm5.its.S
>
> diff --git a/arch/mips/configs/generic/board-eyeq5.config=20
> b/arch/mips/configs/generic/board-eyeq5.config
> new file mode 100644
> index 0000000000000..d5109fda6e821
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-eyeq5.config
> @@ -0,0 +1,43 @@
> +CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_TASKSTATS=3Dy
> +CONFIG_FIT_IMAGE_FDT_EPM5=3Dy
> +CONFIG_BOARD_EYEQ5=3Dy
> +CONFIG_USE_XKPHYS=3Dy
> +CONFIG_PHYSICAL_START=3D0xa800000808000000
> +CONFIG_ZBOOT_LOAD_ADDRESS=3D0xA800000080480000
^ I wonder why are you overriding CONFIG_ZBOOT_LOAD_ADDRESS here, automa=
tic
calculation should work well.

Also I think by adding board-eyeq5.config you are hijacking CONFIG_PHYSI=
CAL_START
for `make 32r2el_defconfig` without BOARDS option as well.

Probably we should implement something to backlist this board from gener=
ic
config.

Thanks
- Jiaxun

> +CONFIG_CPU_HAS_MSA=3Dy
> +CONFIG_NET_KEY=3Dy
> +CONFIG_CAN=3Dy
> +CONFIG_PCI=3Dy
> +CONFIG_PCI_MSI=3Dy
> +CONFIG_PCI_DEBUG=3Dy
> +CONFIG_PCI_ENDPOINT=3Dy
> +CONFIG_CONNECTOR=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_MTD_CMDLINE_PARTS=3Dy
> +CONFIG_MTD_BLOCK=3Dy
> +CONFIG_MTD_RAM=3Dy
> +CONFIG_MTD_ROM=3Dy
> +CONFIG_MTD_PHYSMAP=3Dy
> +CONFIG_MTD_PHYSMAP_OF=3Dy
> +CONFIG_MTD_BLOCK2MTD=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_BLOCK=3Dy
> +CONFIG_NETDEVICES=3Dy
> +CONFIG_MACVLAN=3Dy
> +CONFIG_IPVLAN=3Dy
> +CONFIG_MACB=3Dy
> +CONFIG_MARVELL_PHY=3Dy
> +CONFIG_MICREL_PHY=3Dy
> +CONFIG_CAN_M_CAN=3Dy
> +CONFIG_SERIAL_AMBA_PL011=3Dy
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_MMC=3Dy
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_CADENCE=3Dy
> +CONFIG_RESET_CONTROLLER=3Dy
> +CONFIG_FANOTIFY=3Dy
> +CONFIG_ROMFS_FS=3Dy
> +CONFIG_ROMFS_BACKED_BY_BOTH=3Dy
> +CONFIG_PAGE_SIZE_16KB=3Dy
> \ No newline at end of file
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index 7dc5b3821cc6e..04e1fc6f789b5 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -48,6 +48,13 @@ config SOC_VCOREIII
>  config MSCC_OCELOT
>  	bool
>=20
> +config SOC_EYEQ5
> +	select ARM_AMBA
> +	select WEAK_ORDERING
> +	select WEAK_REORDERING_BEYOND_LLSC
> +	select PHYSICAL_START_BOOL
> +	bool
> +
>  comment "FIT/UHI Boards"
>=20
>  config FIT_IMAGE_FDT_BOSTON
> @@ -124,4 +131,12 @@ config VIRT_BOARD_RANCHU
>  	  Android emulator. Android emulator is based on Qemu, and contains
>  	  the support for the same set of virtual devices.
>=20
> +config FIT_IMAGE_FDT_EPM5
> +	bool "Include FDT for Mobileye EyeQ5 development platforms"
> +	select SOC_EYEQ5
> +	default n
> +	help
> +	  Enable this to include the FDT for the EyeQ5 development platforms
> +	  from Mobileye in the FIT kernel image.
> +	  This requires u-boot on the platform.
>  endif
> diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
> index 0c03623f38970..45db9824a11d6 100644
> --- a/arch/mips/generic/Platform
> +++ b/arch/mips/generic/Platform
> @@ -24,3 +24,5 @@ its-$(CONFIG_FIT_IMAGE_FDT_JAGUAR2)	+=3D=20
> board-jaguar2.its.S
>  its-$(CONFIG_FIT_IMAGE_FDT_SERVAL)	+=3D board-serval.its.S
>  its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+=3D board-xilfpga.its.S
>  its-$(CONFIG_FIT_IMAGE_FDT_MARDUK)	+=3D board-marduk.its.S
> +its-$(CONFIG_FIT_IMAGE_FDT_EPM5)	+=3D board-epm5.its.S
> +
> diff --git a/arch/mips/generic/board-epm5.its.S=20
> b/arch/mips/generic/board-epm5.its.S
> new file mode 100644
> index 0000000000000..08e8c4f183d63
> --- /dev/null
> +++ b/arch/mips/generic/board-epm5.its.S
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/ {
> +	images {
> +		fdt-mobileye-epm5 {
> +			description =3D "Mobileeye MP5 Device Tree";
> +			data =3D /incbin/("boot/dts/mobileye/eyeq5-epm5.dtb");
> +			type =3D "flat_dt";
> +			arch =3D "mips";
> +			compression =3D "none";
> +			hash {
> +				algo =3D "sha1";
> +			};
> +		};
> +	};
> +
> +    configurations {
> +		default =3D "conf-1";
> +		conf-1 {
> +			description =3D "Mobileye EPM5 Linux kernel";
> +			kernel =3D "kernel";
> +			fdt =3D "fdt-mobileye-epm5";
> +		};
> +	};
> +};
> --=20
> 2.42.0

--=20
- Jiaxun
