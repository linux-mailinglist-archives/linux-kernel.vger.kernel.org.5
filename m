Return-Path: <linux-kernel+bounces-24993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D746682C5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6259F1F23EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694F715EB2;
	Fri, 12 Jan 2024 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dosjn+mw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75915ADB;
	Fri, 12 Jan 2024 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3e416f303so29474535ad.0;
        Fri, 12 Jan 2024 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705086670; x=1705691470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwA/JlHMoC+lenv5aURa8KNcjbpsMIVNCCYhJPebYBs=;
        b=Dosjn+mw62wk3pBOYs1Zme0edys5i4Gop5t6teig/BB1voXnkBezfpbygTe9mYctut
         869aJ7qTY6eC0azDQ65awvusVofj4Kra2xjXqSUsCOYuVUyuJcPLVKduRloC3i0inxYw
         YA1PHjNet8DS0T9RZ762uSt6MSdRKp+p8NysaX3m70kUykSZpiFdprtpuRx9ft85aTUC
         4x0/AFyBZqFTTs40ljgd6YU8f3AkNEW/HxQO5o3r2PKTuGwR07Av0psagw3g3UdNpECM
         NrL5Sai1ceWEF9kx3IS8ELgUc8HPFTu1RmnSjg6DOvAm0KMgE+7zOqVh9PKOSnplHGcQ
         xhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705086670; x=1705691470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwA/JlHMoC+lenv5aURa8KNcjbpsMIVNCCYhJPebYBs=;
        b=K5R2wFh5FbumWrC9tc8CaItE9Jm/FiN6AwlqYsCdWYgDmEVWJetnaMuT1RPLmZwxrD
         Vrd2O0g/XiZjdDldgCL4lb0rhBMIyKoHFvgaIgJy96Apu634UeXbdaEQdSqeNEJAM+uH
         neWtoOqk2bnyW/FIveiMH/93u3onzquzDMSWo14bTw43W+0vaQ8E2iiQxtLXTlCVIyCw
         yz6sMdj0kJOiOW0o3nmtuJUmxIjfi5zFgQgqXB/9hmWjP4cl//W1+9bUTxHxEjNi0EnP
         soAJV+P6vrimsB+tLlfBSKw9PDZwP3vCgvVisX3Bqgt1k0o/2WUeWotmch8JP3kvArvS
         jYAQ==
X-Gm-Message-State: AOJu0YyIkmvEtisRmVDctX0jzMdd0KEYTpDt7arZzO5z84+PXZhwMG/4
	4+c0opSVPJTGK7Wfh1QlCx8=
X-Google-Smtp-Source: AGHT+IH8dv7Dzg/uWgk0oHxeoU9Apwneep3s5N4dqYIZaIeUvLr03trHvJQBFGDFnJTOPUKqx1U6Dw==
X-Received: by 2002:a17:903:2583:b0:1d4:cf2b:2bf with SMTP id jb3-20020a170903258300b001d4cf2b02bfmr1182948plb.4.1705086670268;
        Fri, 12 Jan 2024 11:11:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b001d45f92c436sm3555345pla.5.2024.01.12.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 11:11:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 12 Jan 2024 11:11:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: broonie@kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sbinding@opensource.cirrus.com, lee@kernel.org,
	james.schulman@cirrus.com, david.rhodes@cirrus.com,
	rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael@walle.cc, linux-mtd@lists.infradead.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, michal.simek@amd.com,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Message-ID: <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>

Hi,

On Sat, Nov 25, 2023 at 02:51:30PM +0530, Amit Kumar Mahapatra wrote:
> AMD-Xilinx GQSPI controller has two advanced mode that allows the
> controller to consider two flashes as one single device.
> 
> One of these two mode is the parallel mode in which each byte of data is
> stored in both devices, the even bits in the lower flash & the odd bits in
> the upper flash. The byte split is automatically handled by the QSPI
> controller.
> 
> The other mode is the stacked mode in which both the flashes share the
> same SPI bus but each of the device contain half of the data. In this mode,
> the controller does not follow CS requests but instead internally wires the
> two CS levels with the value of the most significant address bit.
> 
> For supporting both these modes SPI core need to be updated for providing
> multiple CS for a single SPI device.
> 
> For adding multi CS support the SPI device need to be aware of all the CS
> values. So, the "chip_select" member in the spi_device structure is now an
> array that holds all the CS values.
> 
> spi_device structure now has a "cs_index_mask" member. This acts as an
> index to the chip_select array. If nth bit of spi->cs_index_mask is set
> then the driver would assert spi->chip_select[n].
> 
> In parallel mode all the chip selects are asserted/de-asserted
> simultaneously and each byte of data is stored in both devices, the even
> bits in one, the odd bits in the other. The split is automatically handled
> by the GQSPI controller. The GQSPI controller supports a maximum of two
> flashes connected in parallel mode. A SPI_CONTROLLER_MULTI_CS flag bit is
> added in the spi controller flags, through ctlr->flags the spi core
> will make sure that the controller is capable of handling multiple chip
> selects at once.
> 
> For supporting multiple CS via GPIO the cs_gpiod member of the spi_device
> structure is now an array that holds the gpio descriptor for each
> chipselect.
> 
> CS GPIO is not tested on our hardware, but it has been tested by @Stefan
> https://lore.kernel.org/all/005001da1efc$619ad5a0$24d080e0$@opensource.cirrus.com/
> 

With this patch in the mainline kernel, two of my qemu emulations
(quanta-q71l-bmc and almetto-bmc) fail to instantiate the first SPI
controller and thus fail to boot from SPI. The error message is

[    3.006458] spi_master spi0: No. of CS is more than max. no. of supported CS
[    3.006775] spi_master spi0: Failed to create SPI device for /ahb/spi@1e620000/flash@0

The problem is no longer seen after reverting this patch.

Bisect log attached for reference.

Guenter

---
# bad: [70d201a40823acba23899342d62bc2644051ad2e] Merge tag 'f2fs-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
# good: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect start 'HEAD' 'v6.7'
# bad: [de927f6c0b07d9e698416c5b287c521b07694cac] Merge tag 's390-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad de927f6c0b07d9e698416c5b287c521b07694cac
# bad: [35f11a3710cdcbbc5090d14017a6295454e0cc73] Merge tag 'mtd/for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect bad 35f11a3710cdcbbc5090d14017a6295454e0cc73
# good: [d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9] Merge tag 'slab-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect good d30e51aa7b1f6fa7dd78d4598d1e4c047fcc3fb9
# good: [fb46e22a9e3863e08aef8815df9f17d0f4b9aede] Merge tag 'mm-stable-2024-01-08-15-31' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good fb46e22a9e3863e08aef8815df9f17d0f4b9aede
# good: [063a7ce32ddc2c4f2404b0dfd29e60e3dbcdffac] Merge tag 'lsm-pr-20240105' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm
git bisect good 063a7ce32ddc2c4f2404b0dfd29e60e3dbcdffac
# bad: [f6cd66231aa58599526584ff4df1bdde8d86eac8] spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc
git bisect bad f6cd66231aa58599526584ff4df1bdde8d86eac8
# good: [18f78b5e609b19b56237f0dae47068d44b8b0ecd] spi: axi-spi-engine: improvements round 2
git bisect good 18f78b5e609b19b56237f0dae47068d44b8b0ecd
# bad: [9d93c8d97b4cdb5edddb4c5530881c90eecb7e44] spi: spi-ti-qspi: switch to use modern name
git bisect bad 9d93c8d97b4cdb5edddb4c5530881c90eecb7e44
# bad: [e6b7e64cb11966b26646a362677ca5a08481157e] spi: st-ssc4: switch to use modern name
git bisect bad e6b7e64cb11966b26646a362677ca5a08481157e
# bad: [c3aeaf2f0ec8af93189488bda3928a1ac7752388] spi: pxa2xx: Use inclusive language
git bisect bad c3aeaf2f0ec8af93189488bda3928a1ac7752388
# good: [f05e2f61fe88092e0d341ea27644a84e3386358d] ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select
git bisect good f05e2f61fe88092e0d341ea27644a84e3386358d
# bad: [88a50c1663ffa9f6b31705c6bf7a887a2c8d9434] spi: Add support for stacked/parallel memories
git bisect bad 88a50c1663ffa9f6b31705c6bf7a887a2c8d9434
# bad: [4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b] spi: Add multi-cs memories support in SPI core
git bisect bad 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b
# first bad commit: [4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b] spi: Add multi-cs memories support in SPI core

