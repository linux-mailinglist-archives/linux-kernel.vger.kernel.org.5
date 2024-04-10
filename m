Return-Path: <linux-kernel+bounces-138497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F389F24A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375D11F236BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D782E400;
	Wed, 10 Apr 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3oNT3Nr"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CD17580;
	Wed, 10 Apr 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752270; cv=none; b=drPPJ2ya+mnO8Ng6JStXAlPSAVyR1i7/XzxQv19rvOdy9An9BdCff+1MAUmD1stkIkOGuD2Vn3j+5F/wsBjONhB1g7HFA6cGsbi9k/8t8Bi74b549PI/l2+DlqaPDSvjGEajHrvP1JnKunRssq2jq4+5L9MS0L/82IA8zC7eiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752270; c=relaxed/simple;
	bh=V0FKXchDOf/+RL+XFq1JbNIqY9J7NVTGsS8s4IUfbbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi2rBe+/xdPTItIeyqd7dzYawxD7ft1nsBSteX1GzuzypbjksNIqa4t0Trl7D4qz7NkFU91mV5bK54bD3ZQRRVgTqSHQE8Jvn7Z5D9wf59FsLTKiNJqJ4Pvs76z8BniIpy9fy/VfcEBd5eHXAec1TputqfshIZDUyie6KtAj+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3oNT3Nr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so6270550b3a.3;
        Wed, 10 Apr 2024 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712752267; x=1713357067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMushfYdFYVuMvhx8RS9TIW7gm9aXjkpyov2m3swVqM=;
        b=N3oNT3Nr6mkIfwwtIEGsAMLHByvTR7vEAOU5WF+uXWMhB5RtokN+2oDkp4iU1/zuO9
         uu5Mw1FJMTPKrx6ccis7r7Raz0H5gAZfGysjza/lPLu0aHy/rxFKeLsTzIgYRp/HWIuH
         K9zGZXkGGT8IHqEJVfDywwMZ/pbea+1LyFVjR0y0HfiGHCWn2K9G/xHr14sWXLJI+JCE
         TE5hKoGK4e9H+pKmfDE3qHu0nFDGdlu2X54O3wi2AiV1RuLBKLXNccpzOSgn7S28whOD
         sLCXwpStv2A3/DI/dl+BrIF6epYx9Rl24ZsS8yDkDuyFfRtPQ6XA+T3l0y3pznxL4B5b
         HhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752267; x=1713357067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMushfYdFYVuMvhx8RS9TIW7gm9aXjkpyov2m3swVqM=;
        b=fYQslpgKyexSU3HAWYrx4XKAnUAYRvRFX6HhH2v60f6AH5yGtKJ5gI3WKVFjlALcRX
         9ei6m8CFpiiGZq6mCYkztcZvBBPBud7T/QWd6JjPyxnVWBwT26b6FCMbm3btMuyJBpFe
         Gd2hhmw1PkrN3SMOpJ9AhEWdZds2P0vIMAe/lU0SZ4oEYmLf/Dm5m0xqh+nfjco2LRr2
         B2djBqyqAYC/u/fzMWvugNynM9s5GY8mNRtoWHc8EEXvRvechh5F/bF7G7lYpaTYB3R0
         +65+jAi00e4xOU4pq/NMegHzfb6+/8BRNJ8oVzUEG+jaG6ezQe1l4zDAJ6hCjWf56N/D
         6znw==
X-Forwarded-Encrypted: i=1; AJvYcCUS+Xo/NsBefqFC2UqSFNsuBZE6VSVD/AD5DTnHLO+HORyPAXQovVYLpEDpvBtEDW9WCvIhnKBO5lMKA0rQvJCQN3v8i84Jaz1R45TIWAbaSG7etnNIpF19B8KHvwYVdJYNT74uPj3iVQliyKE=
X-Gm-Message-State: AOJu0Yww6J3ihTC8SCgG8UNt3vyBpp1jzrJEgvS01Wu2F1zBAcVVpolA
	OecueGj3V6O169PWTLyOp30Zxpj7GMAr8aa5T3d+aeuk2XmcucCn
X-Google-Smtp-Source: AGHT+IG+J427G++TngO22BwEDROi76Khc7mJyNjGNuEYqElmO58D7pIWcHVHanFGEWFu6DJ5dNi2qQ==
X-Received: by 2002:a05:6a00:c91:b0:6e6:9af4:409a with SMTP id a17-20020a056a000c9100b006e69af4409amr2904186pfv.33.1712752266992;
        Wed, 10 Apr 2024 05:31:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006e56e5c09absm10299929pfn.14.2024.04.10.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:31:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 05:31:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] watchdog: add HAS_IOPORT dependencies
Message-ID: <5ccf31c4-cd45-44e6-a8a8-e9b4151ffeb2@roeck-us.net>
References: <20240410084201.1481930-1-schnelle@linux.ibm.com>
 <20240410084201.1481930-2-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410084201.1481930-2-schnelle@linux.ibm.com>

On Wed, Apr 10, 2024 at 10:42:01AM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
> and may be merged via subsystem specific trees at your earliest
> convenience.
> 

For almost all of those, the HAS_IOPORT "dependency" is really only
necessary due to COMPILE_TEST because both ARM and X86 select HAS_IOPORT.
Has anyone thought about introducing something like COMPILE_TEST_IOPORT
or similar ?

config COMPILE_TEST_IOPORT
	def_bool COMPILE_TEST && HAS_IOPORT

Thanks,
Guenter

>  drivers/watchdog/Kconfig | 58 +++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6bee137cfbe0..1904896376b7 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -482,6 +482,7 @@ config 21285_WATCHDOG
>  config 977_WATCHDOG
>  	tristate "NetWinder WB83C977 watchdog"
>  	depends on (FOOTBRIDGE && ARCH_NETWINDER) || (ARM && COMPILE_TEST)
> +	depends on HAS_IOPORT
>  	help
>  	  Say Y here to include support for the WB977 watchdog included in
>  	  NetWinder machines. Alternatively say M to compile the driver as
> @@ -1075,7 +1076,7 @@ config ACQUIRE_WDT
>  
>  config ADVANTECH_WDT
>  	tristate "Advantech SBC Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  If you are configuring a Linux kernel for the Advantech single-board
>  	  computer, say `Y' here to support its built-in watchdog timer
> @@ -1084,7 +1085,7 @@ config ADVANTECH_WDT
>  
>  config ADVANTECH_EC_WDT
>  	tristate "Advantech Embedded Controller Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	select ISA_BUS_API
>  	select WATCHDOG_CORE
>  	help
> @@ -1117,7 +1118,7 @@ config ALIM7101_WDT
>  
>  config EBC_C384_WDT
>  	tristate "WinSystems EBC-C384 Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	select ISA_BUS_API
>  	select WATCHDOG_CORE
>  	help
> @@ -1127,7 +1128,7 @@ config EBC_C384_WDT
>  
>  config EXAR_WDT
>  	tristate "Exar Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	select WATCHDOG_CORE
>  	help
>  	  Enables watchdog timer support for the watchdog timer present
> @@ -1138,7 +1139,7 @@ config EXAR_WDT
>  
>  config F71808E_WDT
>  	tristate "Fintek F718xx, F818xx Super I/O Watchdog"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	select WATCHDOG_CORE
>  	help
>  	  This is the driver for the hardware watchdog on the Fintek F71808E,
> @@ -1150,7 +1151,7 @@ config F71808E_WDT
>  
>  config SP5100_TCO
>  	tristate "AMD/ATI SP5100 TCO Timer/Watchdog"
> -	depends on (X86 || COMPILE_TEST) && PCI
> +	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
>  	select WATCHDOG_CORE
>  	help
>  	  Hardware watchdog driver for the AMD/ATI SP5100 chipset. The TCO
> @@ -1189,7 +1190,7 @@ config SC520_WDT
>  
>  config SBC_FITPC2_WATCHDOG
>  	tristate "Compulab SBC-FITPC2 watchdog"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the built-in watchdog timer on the fit-PC2,
>  	  fit-PC2i, CM-iAM single-board computers made by Compulab.
> @@ -1214,7 +1215,7 @@ config SBC_FITPC2_WATCHDOG
>  
>  config EUROTECH_WDT
>  	tristate "Eurotech CPU-1220/1410 Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  Enable support for the watchdog timer on the Eurotech CPU-1220 and
>  	  CPU-1410 cards.  These are PC/104 SBCs. Spec sheets and product
> @@ -1222,7 +1223,7 @@ config EUROTECH_WDT
>  
>  config IB700_WDT
>  	tristate "IB700 SBC Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the hardware watchdog on the IB700 Single
>  	  Board Computer produced by TMC Technology (www.tmc-uk.com). This
> @@ -1239,7 +1240,7 @@ config IB700_WDT
>  
>  config IBMASR
>  	tristate "IBM Automatic Server Restart"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the IBM Automatic Server Restart watchdog
>  	  timer built-in into some eServer xSeries machines.
> @@ -1249,7 +1250,7 @@ config IBMASR
>  
>  config WAFER_WDT
>  	tristate "ICP Single Board Computer Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is a driver for the hardware watchdog on the ICP Single
>  	  Board Computer. This driver is working on (at least) the following
> @@ -1271,7 +1272,7 @@ config I6300ESB_WDT
>  
>  config IE6XX_WDT
>  	tristate "Intel Atom E6xx Watchdog"
> -	depends on (X86 || COMPILE_TEST) && PCI
> +	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
>  	select WATCHDOG_CORE
>  	select MFD_CORE
>  	select LPC_SCH
> @@ -1301,6 +1302,7 @@ config ITCO_WDT
>  	select WATCHDOG_CORE
>  	depends on I2C || I2C=n
>  	depends on MFD_INTEL_PMC_BXT || !MFD_INTEL_PMC_BXT
> +	depends on HAS_IOPORT # for I2C_I801
>  	select LPC_ICH if !EXPERT
>  	select I2C_I801 if !EXPERT && I2C
>  	help
> @@ -1331,7 +1333,7 @@ config ITCO_VENDOR_SUPPORT
>  
>  config IT8712F_WDT
>  	tristate "IT8712F (Smart Guardian) Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the built-in watchdog timer on the IT8712F
>  	  Super I/0 chipset used on many motherboards.
> @@ -1344,7 +1346,7 @@ config IT8712F_WDT
>  
>  config IT87_WDT
>  	tristate "IT87 Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	select WATCHDOG_CORE
>  	help
>  	  This is the driver for the hardware watchdog on the ITE IT8607,
> @@ -1392,7 +1394,7 @@ config KEMPLD_WDT
>  
>  config SC1200_WDT
>  	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is a driver for National Semiconductor PC87307/PC97307 hardware
>  	  watchdog cards as found on the SC1200. This watchdog is mainly used
> @@ -1415,7 +1417,7 @@ config SCx200_WDT
>  
>  config PC87413_WDT
>  	tristate "NS PC87413 watchdog"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the hardware watchdog on the PC87413 chipset
>  	  This watchdog simply watches your kernel to make sure it doesn't
> @@ -1429,7 +1431,7 @@ config PC87413_WDT
>  
>  config NV_TCO
>  	tristate "nVidia TCO Timer/Watchdog"
> -	depends on (X86 || COMPILE_TEST) && PCI
> +	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
>  	help
>  	  Hardware driver for the TCO timer built into the nVidia Hub family
>  	  (such as the MCP51).  The TCO (Total Cost of Ownership) timer is a
> @@ -1458,7 +1460,7 @@ config RDC321X_WDT
>  
>  config 60XX_WDT
>  	tristate "SBC-60XX Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This driver can be used with the watchdog timer found on some
>  	  single board computers, namely the 6010 PII based computer.
> @@ -1498,7 +1500,7 @@ config SBC7240_WDT
>  
>  config CPU5_WDT
>  	tristate "SMA CPU5 Watchdog"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  TBD.
>  	  To compile this driver as a module, choose M here: the
> @@ -1506,7 +1508,7 @@ config CPU5_WDT
>  
>  config SMSC_SCH311X_WDT
>  	tristate "SMSC SCH311X Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the hardware watchdog timer on the
>  	  SMSC SCH3112, SCH3114 and SCH3116 Super IO chipset
> @@ -1518,7 +1520,7 @@ config SMSC_SCH311X_WDT
>  
>  config SMSC37B787_WDT
>  	tristate "Winbond SMsC37B787 Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the hardware watchdog component on the
>  	  Winbond SMsC37B787 chipset as used on the NetRunner Mainboard
> @@ -1564,7 +1566,7 @@ config VIA_WDT
>  
>  config W83627HF_WDT
>  	tristate "Watchdog timer for W83627HF/W83627DHG and compatibles"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	select WATCHDOG_CORE
>  	help
>  	  This is the driver for the hardware watchdog on the following
> @@ -1594,7 +1596,7 @@ config W83627HF_WDT
>  
>  config W83877F_WDT
>  	tristate "W83877F (EMACS) Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the hardware watchdog on the W83877F chipset
>  	  as used in EMACS PC-104 motherboards (and likely others).  This
> @@ -1609,7 +1611,7 @@ config W83877F_WDT
>  
>  config W83977F_WDT
>  	tristate "W83977F (PCM-5335) Watchdog Timer"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the hardware watchdog on the W83977F I/O chip
>  	  as used in AAEON's PCM-5335 SBC (and likely others).  This
> @@ -1622,7 +1624,7 @@ config W83977F_WDT
>  
>  config MACHZ_WDT
>  	tristate "ZF MachZ Watchdog"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  If you are using a ZF Micro MachZ processor, say Y here, otherwise
>  	  N.  This is the driver for the watchdog timer built-in on that
> @@ -1635,7 +1637,7 @@ config MACHZ_WDT
>  
>  config SBC_EPX_C3_WATCHDOG
>  	tristate "Winsystems SBC EPX-C3 watchdog"
> -	depends on X86 || COMPILE_TEST
> +	depends on (X86 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This is the driver for the built-in watchdog timer on the EPX-C3
>  	  Single-board computer made by Winsystems, Inc.
> @@ -2197,7 +2199,7 @@ comment "PCI-based Watchdog Cards"
>  
>  config PCIPCWATCHDOG
>  	tristate "Berkshire Products PCI-PC Watchdog"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This is the driver for the Berkshire Products PCI-PC Watchdog card.
>  	  This card simply watches your kernel to make sure it doesn't freeze,
> @@ -2212,7 +2214,7 @@ config PCIPCWATCHDOG
>  
>  config WDTPCI
>  	tristate "PCI-WDT500/501 Watchdog timer"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.
>  
> -- 
> 2.40.1
> 

