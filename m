Return-Path: <linux-kernel+bounces-78450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D528613B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D4C1F22374
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE49B80036;
	Fri, 23 Feb 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrcwK9Ku"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA687EEEF;
	Fri, 23 Feb 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697514; cv=none; b=DnjFEx28sxlnEC/OdhG7R2JvfZ7ibQpHogJhl4RkJRb+GhdcwFQTKr5ShiOxQzWM0nJwrUxaYZ2p6mrSf3WzjDYwyAiImyeMgY9TCeMVv83jojZ594njUGf5ekRaC+IUOPyRXYXmB+kOiqiySEVCG2AWYs6g9aLnmgg5vdJUgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697514; c=relaxed/simple;
	bh=lS2dUxvfGKo6wWIIBDLvBT2OPcFUwrZz3XK7Mg/19dI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AsQ1lzQHZpiw/xHADadrFpYw+KZw3NZqdIMeOS8Kh+CzQ4Z4vVq8rO5S/E61CYJ1aqAhGVZmwCrKv4iwW+y81WRQGZkNPN4rtvCp4xH5cfDzvG6AO+R6p6Tfg8is8WCNSIgcwsJnlOYazjpfYwcXZvzXK2rTVfXZdr2EZYPhOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrcwK9Ku; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d2770e44d0so1384921fa.2;
        Fri, 23 Feb 2024 06:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708697508; x=1709302308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jF2eUYlaVX9kvdDNbNOH9h9nnfRJxUg3rTjdOWmj7/k=;
        b=nrcwK9KuGWaBXDJwNI/+3YgSpVOmqF01tbEoJOiKvGX9rksL1DE8Vc/LyFXE7vzqVg
         MubUc2AE2ZDTQA168VJEhX/5SS1iPGAmn+OHs+Qmtc2F0W5+1GLaMs5wO5ioVoqjYGb+
         T4kxSYWvtxWR77ugB2YDUXqMNZprSLQFbNvfHqUx4hNQ9z3w9DdCpHYTB86pzf2YXgM8
         JTESNqISDDyx4ww3AoCF1jQNvvbpS29S2t25BfnppNgWR5ZUI6OZ4btPee2PXx9ZhXxp
         0he63TNaOp2PdGzMGng56m1SVPEra9ViGjlHN65CBsP5cz4ynGgN4OLFMgU5LlI2SYTk
         Mibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708697508; x=1709302308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jF2eUYlaVX9kvdDNbNOH9h9nnfRJxUg3rTjdOWmj7/k=;
        b=rgthvfp0iyMatDHpBCfNDtT2joWALxFUImEwcuBUSNg/UbNi/LqINpwAh8QewQhKxZ
         mzJzGU5QAeTCV3k1l2/VL7K9e/jSZ4HIwIkfPV7IHOepuMDpKm4gKDFV8M8NoH3w4ChQ
         9iIR5Gud0B8bxX3DRWSqlTZfSrplBqJ+jgvxtlPQ5jbNUUhFb1iDvKTvvGBCVv61MuqV
         Z+JRjlp4Y3C8D9eapn7Qe/PYoVP5WjaPKUt0EfWXr23W+9PQWoGC9vEqGkCVzq/JW1wq
         vtv05UjqRDgZ1Ok5jf+XRpdPHxdxJgfxeRxlOGRsNVfqvkSKHqfL/OS544NRpmy/MmzC
         gBHA==
X-Forwarded-Encrypted: i=1; AJvYcCVwCPcQdIC9AHdaZqNobvzBIR8niCRoAgWcFrw6ICoHLDI5FixbCmg7oAF8UW3mW5ItZNMbrvUoaVQeqwaT239A7EWwAxzmkGtrL1txSWp0IPMUoSgu4szRvSRskiXGZemrj3RXXy+1J+Zsp5+81Z6pxRtcoLmSCqnlAC1WouiddjAKmnHEcJS++9ev77PhxJKCL5PEMdsA4LDqj42lAUQ=
X-Gm-Message-State: AOJu0Yz1pHgaDMPGChKWGxT5jOKHfbju9NpWaIhdKPhkj6xqkvcMokno
	gSp9moW3JJGqvZmUsvuj1Wt8c84X1DtK4FqTpg+NJZY9rszLdp3M
X-Google-Smtp-Source: AGHT+IG0LbAIcfVJwRO5wqYFpkO80Hd+IPz5tVqtBLtEztNI3xwyRGpmHRQkhzg/V4xPWSXb9x9DhA==
X-Received: by 2002:a2e:b1c9:0:b0:2d2:2dbb:3898 with SMTP id e9-20020a2eb1c9000000b002d22dbb3898mr1412276lja.31.1708697507612;
        Fri, 23 Feb 2024 06:11:47 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id bq7-20020a5d5a07000000b0033cf29a67c7sm3141731wrb.7.2024.02.23.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:11:47 -0800 (PST)
Message-ID: <42f73fe3c3918133f555b6b4748aaf051188b4fb.camel@gmail.com>
Subject: Re: [PATCH v15 3/3] iio: adc: ad7173: add AD7173 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,  ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 23 Feb 2024 15:15:08 +0100
In-Reply-To: <20240223133758.9787-3-mitrutzceclan@gmail.com>
References: <20240223133758.9787-1-mitrutzceclan@gmail.com>
	 <20240223133758.9787-3-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 15:37 +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

Any reason for dropping my rb tag? Anyways...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> V14-> V15
> =C2=A0- Use local var for dev instead of &st->sd.spi->dev
> =C2=A0- Use sizeof(*st->config_cnts)
> =C2=A0- Use device_property_match_property_string()
> =C2=A0- ENODATA error when no channels are specified
> V13-> V14
> =C2=A0- Update year copyright range
> =C2=A0- Drop the ad_sigma_delta_info.irq_flags assigment
> =C2=A0- Use spi_setup() after spi mode assigment
> =C2=A0- Check IS_ENABLED(CONFIG_COMMON_CLK) for clk registering, drop fwn=
ode NULL
> check
> =C2=A0- Rename variable fwnode
> V12-> V13
> - Add precursor patch for new irq_num attribute in ad_sigma_delta_info an=
d
> ad_sigma_delta structs
> - Split=C2=A0 *_fw_parse_channel_config() into *_channel_config and *_dev=
ice_config
> - Reorder probe calls to ad_sd_init to use correctly the optional irq_num
> attribute
> - Require=C2=A0 in probe interrupt named "rdy" to be present
> - If external clock not present, register clk provider
> - If external clock present, get clock and enable
> - Add constants, strings for clock selections
> V11-> V12
> =C2=A0- rename refin, refin2 to vref, vref2
> V10-> V11 <no changes>
> V9 -> V10 <no changes>
> V8 -> V9
> =C2=A0- Add '(x)' to some macro's definition to reduce NO of checks
> =C2=A0- Use reg 0 constant definition in debug_reg_access()
> =C2=A0- Rename=C2=A0 channels_st_priv_arr to chans_st_arr
> =C2=A0- Remove unnecessary u32 cast from read_raw()
> =C2=A0- Compute read_raw() offset instead of constant
> =C2=A0- Add offset comments to data rate arrays
> =C2=A0- Removed redundant newline in _parse_channel_config()
> V7 -> V8
> =C2=A0- remove Kconfig commas
> =C2=A0- reorder include <...gpio/regmap.h>
> =C2=A0- GPO12_DATA(x)=C2=A0 from BIT(x) -> BIT(x+0)
> =C2=A0- use the same pointer to dev in ad7173_setup()
> =C2=A0- rewrite temp channel read_raw scale for better readability
> =C2=A0- add comment to explain temp channel offset
> =C2=A0- follow multi-line comment style
> =C2=A0- change ref_sel type to signed int
> =C2=A0- use fwnode_property_match_property_string()
> V6 -> V7
> =C2=A0- format Kconfig supported models using '-'
> =C2=A0- include types.h instead of stddef.h
> =C2=A0- change device_info->num_gpios type to u8
> =C2=A0- reorder fields in ad7173_state, place ad_sigma_delta
> =C2=A0- reorder fields in ad7173_device_info, group by type
> =C2=A0- add default case in read_raw()
> =C2=A0- rename ad7173_debug() to ad7173_debug_reg_access()
> =C2=A0- remove explicit u8 cast
> =C2=A0- remove return 0; for offset in read_raw()
> =C2=A0- add '\n' to error messages
> =C2=A0- reorder probe variables -> reversed xmas tree
> =C2=A0- remove redundant inner commas in of_match and id_table
> =C2=A0- simplify selected reference code by setting default value and ign=
oring
> =C2=A0=C2=A0 fwnode_property_read_string() error
> =C2=A0- use match_string() for finding selected reference
> =C2=A0- err on no channels specified
> =C2=A0- add missing fwnode_handle_put(child) on err return branches
> =C2=A0- remove spi_set_drvdata() from probe
> =C2=A0- remove offset variable from find_live_config(), not used
> =C2=A0- add comment showing a generic LRU implementation might be used if=
 one
> =C2=A0=C2=A0 will exist
> =C2=A0- MISC:=C2=A0 add blank line to chanel_config struct, trailing comm=
a
> ref_sel_str[],
> =C2=A0=C2=A0 remove blank line in update_scan_mode(), add spaces around '=
/'
> V5->V6 <no changes>
> V4 -> V5
> =C2=A0- List Kconfig supported models one per line
> =C2=A0- Include <array_size.h> and <container_of.h>
> =C2=A0- Remove bits.h and kernel.h include
> =C2=A0- Add spaces before '\' on multi-line definitions
> =C2=A0- Change constant definition name from "..._MICROV" to "..._uV"
> =C2=A0- Change ad7173_channel_config attributes order for grouping by typ=
e
> =C2=A0- Remove redundant {} in ad7173_gpio_init()
> =C2=A0- Add array with reference select strings
> =C2=A0- Change parsing of device tree adi,reference-select from integer t=
o string
> =C2=A0- Change indentation=C2=A0 for ad7173_find_live_config() header
> =C2=A0- Use struct_group() in config struct
> =C2=A0- Use offsetofend() and sizeof_field() in ad7173_find_live_config()
> =C2=A0- Split line on logic operator in ad7173_find_live_config() at conf=
igs
> comparison
> =C2=A0- Use IDA for config slots allocation
> =C2=A0- Reverse xmas tree order for probe local variables
> =C2=A0- Use BIT() for computing bipolar channels offset
> =C2=A0- Change (MICRO/MILLI) to MILLI in read_raw for integer part of sam=
pling
> frequency
> =C2=A0- MISC: remove blank line, use 0 value dirrectly, one line statemen=
t
> devm_kcalloc()
> V3 -> V4
> =C2=A0- cleaned up includes
> =C2=A0- add ad7173_gpio_disable(), include to devm actions
> =C2=A0- remove iio_device_claim_direct_mode() from update_scan_mode()
> =C2=A0- always set differential iio_chan attribute to true, retain bipola=
r info
> only in private struct
> =C2=A0- store multiple regulators in state for voltage references
> =C2=A0- compute read_raw offset depending on channel used reference
> =C2=A0- configure channel setup using selected reference
> =C2=A0- add ad7173_get_ref_voltage_milli()=20
> =C2=A0- clean up ad7173_fw_sparse_channel_config() changing array access =
of channel
> structs to pointers
> =C2=A0- retain chip name in st->info structure
> =C2=A0- use spi_device_get_match_data() in probe
> V2 -> V3
> =C2=A0- change Kconfig GPIO_REGMAP and REGMAP_SPI to be conditioned by GP=
IOLIB
> =C2=A0- cast chip info to (kernel_ulong_t) to suppress warnings
> =C2=A0- adjust copyright year to reflect the out-of-tree history
> =C2=A0- remove unused sysfs and trigger header files
> =C2=A0- clean up defined macros by using FIELD_PREP( ) inline
> =C2=A0- use DECLARE_BITMAP( ) for defiining cfg_slots_status
> =C2=A0- use clear/set _bit instead of assign_bit
> =C2=A0- rename state field regmap to reg_gpiocon_regmap to better represe=
nt usage
> =C2=A0- replace container_of( ) usages to ad_sigma_delta_to_ad7173( )
> =C2=A0- improve readability of sampling frequency conversion in write_raw=
( )
> 				specifying conversion from Micro to Milli
> =C2=A0- use iio_device_claim_direct_mode( ) correctly in write_raw( )
> =C2=A0- flip logic in write_raw( ) to reduce line length
> =C2=A0- pass only state struct to gpio_init function
> =C2=A0- remove else branch at end of probe
> =C2=A0- remove comma after list terminator for of_match and id_table arra=
ys
> =C2=A0- clarify write_raw( ) realbits 32 bit size check in a comment
> =C2=A0- change parsed fw property 'adi,bipolar' to 'bipolar' to matched r=
eferenced
> adc.yaml=20
> =C2=A0- use reg_set_base for gpio regmap xlate=20
> V1 -> V2
> =C2=A0- keep original out-of-tree AD7173 naming
> =C2=A0- remove gpio_cleanup
> =C2=A0- handle 32bit realbits offset case
> =C2=A0- use iio_device_claim_direct_mode, drop own mutex
> =C2=A0- use dev_err_probe
> =C2=A0- cleanup headers include
> =C2=A0- use GENMASK() and FIELD_PREP()
> =C2=A0- use HZ_PER_MHZ
> =C2=A0- change #ifdef GPIOLIB to if( IS_ENABLED(CONFIG_GPIOLIB))=20
> =C2=A0- use gpio-regmap
> =C2=A0- change boolean flag in info struct to number of gpios
> =C2=A0- NIH memset64
> =C2=A0- use struct pointers for config comparison
> =C2=A0- use spi_write_then_read for ADC reset
> =C2=A0- use stack allocated buffer for reset
> =C2=A0- define constant for reset sequence size
> =C2=A0- use kcalloc instead of kzalloc
> =C2=A0- change of naming to fw of dt parse function
> =C2=A0- change de-referencing chain to local variable dev in multiple loc=
ations
> =C2=A0- drop write_raw_get_fmt
> =C2=A0- add driver private data to spi_device_id table
> =C2=A0- use fsleep() instead of usleep_range()
> =C2=A0- put config value inline
> =C2=A0- align read/write raw arguments
> =C2=A0- remove zeroed values from channel templates structure
> =C2=A0- define constants for temperature sensor positive and negative inp=
uts
> =C2=A0- always enable temperature channel
> =C2=A0- configure spi clock phase and polarity from driver
> =C2=A0misc changes (test bit, return disable all, indentation fix, change
> statements to single line)
>=20
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 17 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7173.c | 1104 +++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 1122 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad7173.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3b73c509bd68..c32054afdfc4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -70,6 +70,23 @@ config AD7124
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will
> be
> =C2=A0	=C2=A0 called ad7124.
> =C2=A0
> +config AD7173
> +	tristate "Analog Devices AD7173 driver"
> +	depends on SPI_MASTER
> +	select AD_SIGMA_DELTA
> +	select GPIO_REGMAP if GPIOLIB
> +	select REGMAP_SPI if GPIOLIB
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD7173 and simi=
lar
> ADC
> +	=C2=A0 Currently supported models:
> +	=C2=A0=C2=A0 - AD7172-2
> +	=C2=A0=C2=A0 - AD7173-8
> +	=C2=A0=C2=A0 - AD7175-2
> +	=C2=A0=C2=A0 - AD7176-2
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad7173.
> +
> =C2=A0config AD7192
> =C2=A0	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d2fda54a3259..dd4210a3634f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> =C2=A0obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> =C2=A0obj-$(CONFIG_AD7091R8) +=3D ad7091r8.o
> =C2=A0obj-$(CONFIG_AD7124) +=3D ad7124.o
> +obj-$(CONFIG_AD7173) +=3D ad7173.o
> =C2=A0obj-$(CONFIG_AD7192) +=3D ad7192.o
> =C2=A0obj-$(CONFIG_AD7266) +=3D ad7266.o
> =C2=A0obj-$(CONFIG_AD7280) +=3D ad7280a.o
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> new file mode 100644
> index 000000000000..3dde473cf859
> --- /dev/null
> +++ b/drivers/iio/adc/ad7173.c
> @@ -0,0 +1,1104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
> + * Copyright (C) 2015, 2024 Analog Devices, Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/container_of.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/idr.h>
> +#include <linux/interrupt.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +
> +#define AD7173_REG_COMMS		0x00
> +#define AD7173_REG_ADC_MODE		0x01
> +#define AD7173_REG_INTERFACE_MODE	0x02
> +#define AD7173_REG_CRC			0x03
> +#define AD7173_REG_DATA			0x04
> +#define AD7173_REG_GPIO			0x06
> +#define AD7173_REG_ID			0x07
> +#define AD7173_REG_CH(x)		(0x10 + (x))
> +#define AD7173_REG_SETUP(x)		(0x20 + (x))
> +#define AD7173_REG_FILTER(x)		(0x28 + (x))
> +#define AD7173_REG_OFFSET(x)		(0x30 + (x))
> +#define AD7173_REG_GAIN(x)		(0x38 + (x))
> +
> +#define AD7173_RESET_LENGTH		BITS_TO_BYTES(64)
> +
> +#define AD7173_CH_ENABLE		BIT(15)
> +#define AD7173_CH_SETUP_SEL_MASK	GENMASK(14, 12)
> +#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
> +#define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
> +
> +#define AD7173_CH_ADDRESS(pos, neg) \
> +	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
> +	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> +#define AD7173_AIN_TEMP_POS	17
> +#define AD7173_AIN_TEMP_NEG	18
> +
> +#define AD7172_ID			0x00d0
> +#define AD7173_ID			0x30d0
> +#define AD7175_ID			0x0cd0
> +#define AD7176_ID			0x0c90
> +#define AD7173_ID_MASK			GENMASK(15, 4)
> +
> +#define AD7173_ADC_MODE_REF_EN		BIT(15)
> +#define AD7173_ADC_MODE_SING_CYC	BIT(13)
> +#define AD7173_ADC_MODE_MODE_MASK	GENMASK(6, 4)
> +#define AD7173_ADC_MODE_CLOCKSEL_MASK	GENMASK(3, 2)
> +#define AD7173_ADC_MODE_CLOCKSEL_INT		0x0
> +#define AD7173_ADC_MODE_CLOCKSEL_INT_OUTPUT	0x1
> +#define AD7173_ADC_MODE_CLOCKSEL_EXT		0x2
> +#define AD7173_ADC_MODE_CLOCKSEL_XTAL		0x3
> +
> +#define AD7173_GPIO_PDSW	BIT(14)
> +#define AD7173_GPIO_OP_EN2_3	BIT(13)
> +#define AD7173_GPIO_MUX_IO	BIT(12)
> +#define AD7173_GPIO_SYNC_EN	BIT(11)
> +#define AD7173_GPIO_ERR_EN	BIT(10)
> +#define AD7173_GPIO_ERR_DAT	BIT(9)
> +#define AD7173_GPIO_GP_DATA3	BIT(7)
> +#define AD7173_GPIO_GP_DATA2	BIT(6)
> +#define AD7173_GPIO_IP_EN1	BIT(5)
> +#define AD7173_GPIO_IP_EN0	BIT(4)
> +#define AD7173_GPIO_OP_EN1	BIT(3)
> +#define AD7173_GPIO_OP_EN0	BIT(2)
> +#define AD7173_GPIO_GP_DATA1	BIT(1)
> +#define AD7173_GPIO_GP_DATA0	BIT(0)
> +
> +#define AD7173_GPO12_DATA(x)	BIT((x) + 0)
> +#define AD7173_GPO23_DATA(x)	BIT((x) + 4)
> +#define AD7173_GPO_DATA(x)	((x) < 2 ? AD7173_GPO12_DATA(x) :
> AD7173_GPO23_DATA(x))
> +
> +#define AD7173_INTERFACE_DATA_STAT	BIT(6)
> +#define AD7173_INTERFACE_DATA_STAT_EN(x) \
> +	FIELD_PREP(AD7173_INTERFACE_DATA_STAT, x)
> +
> +#define AD7173_SETUP_BIPOLAR		BIT(12)
> +#define AD7173_SETUP_AREF_BUF_MASK	GENMASK(11, 10)
> +#define AD7173_SETUP_AIN_BUF_MASK	GENMASK(9, 8)
> +
> +#define AD7173_SETUP_REF_SEL_MASK	GENMASK(5, 4)
> +#define AD7173_SETUP_REF_SEL_AVDD1_AVSS	0x3
> +#define AD7173_SETUP_REF_SEL_INT_REF	0x2
> +#define AD7173_SETUP_REF_SEL_EXT_REF2	0x1
> +#define AD7173_SETUP_REF_SEL_EXT_REF	0x0
> +#define AD7173_VOLTAGE_INT_REF_uV	2500000
> +#define AD7173_TEMP_SENSIIVITY_uV_per_C	477
> +
> +#define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
> +#define AD7173_MAX_CONFIGS		8
> +
> +enum ad7173_ids {
> +	ID_AD7172_2,
> +	ID_AD7173_8,
> +	ID_AD7175_2,
> +	ID_AD7176_2,
> +};
> +
> +struct ad7173_device_info {
> +	const unsigned int *sinc5_data_rates;
> +	unsigned int num_sinc5_data_rates;
> +	unsigned int num_channels;
> +	unsigned int num_configs;
> +	unsigned int num_inputs;
> +	unsigned int clock;
> +	unsigned int id;
> +	char *name;
> +	bool has_temp;
> +	u8 num_gpios;
> +};
> +
> +struct ad7173_channel_config {
> +	u8 cfg_slot;
> +	bool live;
> +
> +	/* Following fields are used to compare equality. */
> +	struct_group(config_props,
> +		bool bipolar;
> +		bool input_buf;
> +		u8 odr;
> +		u8 ref_sel;
> +	);
> +};
> +
> +struct ad7173_channel {
> +	unsigned int chan_reg;
> +	unsigned int ain;
> +	struct ad7173_channel_config cfg;
> +};
> +
> +struct ad7173_state {
> +	struct ad_sigma_delta sd;
> +	const struct ad7173_device_info *info;
> +	struct ad7173_channel *channels;
> +	struct regulator_bulk_data regulators[3];
> +	unsigned int adc_mode;
> +	unsigned int interface_mode;
> +	unsigned int num_channels;
> +	struct ida cfg_slots_status;
> +	unsigned long long config_usage_counter;
> +	unsigned long long *config_cnts;
> +	struct clk *ext_clk;
> +	struct clk_hw int_clk_hw;
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +	struct regmap *reg_gpiocon_regmap;
> +	struct gpio_regmap *gpio_regmap;
> +#endif
> +};
> +
> +static const unsigned int ad7173_sinc5_data_rates[] =3D {
> +	6211000, 6211000, 6211000, 6211000, 6211000, 6211000, 5181000,
> 4444000,	/*=C2=A0 0-7=C2=A0 */
> +	3115000, 2597000, 1007000, 503800,=C2=A0 381000,=C2=A0 200300,=C2=A0 10=
0500,=C2=A0
> 59520,	/*=C2=A0 8-15 */
> +	49680,	 20010,	=C2=A0 16333,=C2=A0=C2=A0 10000,=C2=A0=C2=A0 5000,=C2=A0=
=C2=A0=C2=A0 2500,=C2=A0=C2=A0=C2=A0
> 1250,		/* 16-22 */
> +};
> +
> +static const unsigned int ad7175_sinc5_data_rates[] =3D {
> +	50000000, 41667000, 31250000, 27778000,	/*=C2=A0 0-3=C2=A0 */
> +	20833000, 17857000, 12500000, 10000000,	/*=C2=A0 4-7=C2=A0 */
> +	5000000,=C2=A0 2500000,=C2=A0 1000000,=C2=A0 500000,	/*=C2=A0 8-11 */
> +	397500,=C2=A0=C2=A0 200000,=C2=A0=C2=A0 100000,=C2=A0=C2=A0 59920,	/* 1=
2-15 */
> +	49960,=C2=A0=C2=A0=C2=A0 20000,=C2=A0=C2=A0=C2=A0 16666,=C2=A0=C2=A0=C2=
=A0 10000,	/* 16-19 */
> +	5000,					/* 20=C2=A0=C2=A0=C2=A0 */
> +};
> +
> +static const struct ad7173_device_info ad7173_device_info[] =3D {
> +	[ID_AD7172_2] =3D {
> +		.name =3D "ad7172-2",
> +		.id =3D AD7172_ID,
> +		.num_inputs =3D 5,
> +		.num_channels =3D 4,
> +		.num_configs =3D 4,
> +		.num_gpios =3D 2,
> +		.has_temp =3D true,
> +		.clock =3D 2 * HZ_PER_MHZ,
> +		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +	},
> +	[ID_AD7173_8] =3D {
> +		.name =3D "ad7173-8",
> +		.id =3D AD7173_ID,
> +		.num_inputs =3D 17,
> +		.num_channels =3D 16,
> +		.num_configs =3D 8,
> +		.num_gpios =3D 4,
> +		.has_temp =3D true,
> +		.clock =3D 2 * HZ_PER_MHZ,
> +		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +	},
> +	[ID_AD7175_2] =3D {
> +		.name =3D "ad7175-2",
> +		.id =3D AD7175_ID,
> +		.num_inputs =3D 5,
> +		.num_channels =3D 4,
> +		.num_configs =3D 4,
> +		.num_gpios =3D 2,
> +		.has_temp =3D true,
> +		.clock =3D 16 * HZ_PER_MHZ,
> +		.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> +		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> +	},
> +	[ID_AD7176_2] =3D {
> +		.name =3D "ad7176-2",
> +		.id =3D AD7176_ID,
> +		.num_inputs =3D 5,
> +		.num_channels =3D 4,
> +		.num_configs =3D 4,
> +		.num_gpios =3D 2,
> +		.has_temp =3D false,
> +		.clock =3D 16 * HZ_PER_MHZ,
> +		.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> +		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> +	},
> +};
> +
> +static const char *const ad7173_ref_sel_str[] =3D {
> +	[AD7173_SETUP_REF_SEL_EXT_REF]=C2=A0=C2=A0=C2=A0 =3D "vref",
> +	[AD7173_SETUP_REF_SEL_EXT_REF2]=C2=A0=C2=A0 =3D "vref2",
> +	[AD7173_SETUP_REF_SEL_INT_REF]=C2=A0=C2=A0=C2=A0 =3D "refout-avss",
> +	[AD7173_SETUP_REF_SEL_AVDD1_AVSS] =3D "avdd",
> +};
> +
> +static const char *const ad7173_clk_sel[] =3D {
> +	"ext-clk", "xtal"
> +};
> +
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +
> +static const struct regmap_range ad7173_range_gpio[] =3D {
> +	regmap_reg_range(AD7173_REG_GPIO, AD7173_REG_GPIO),
> +};
> +
> +static const struct regmap_access_table ad7173_access_table =3D {
> +	.yes_ranges =3D ad7173_range_gpio,
> +	.n_yes_ranges =3D ARRAY_SIZE(ad7173_range_gpio),
> +};
> +
> +static const struct regmap_config ad7173_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.rd_table =3D &ad7173_access_table,
> +	.wr_table =3D &ad7173_access_table,
> +	.read_flag_mask =3D BIT(6),
> +};
> +
> +static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int offset, unsigned int *reg,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *mask)
> +{
> +	*mask =3D AD7173_GPO_DATA(offset);
> +	*reg =3D base;
> +	return 0;
> +}
> +
> +static void ad7173_gpio_disable(void *data)
> +{
> +	struct ad7173_state *st =3D data;
> +	unsigned int mask;
> +
> +	mask =3D AD7173_GPIO_OP_EN0 | AD7173_GPIO_OP_EN1 |
> AD7173_GPIO_OP_EN2_3;
> +	regmap_update_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, mask,
> ~mask);
> +}
> +
> +static int ad7173_gpio_init(struct ad7173_state *st)
> +{
> +	struct gpio_regmap_config gpio_regmap =3D {};
> +	struct device *dev =3D &st->sd.spi->dev;
> +	unsigned int mask;
> +	int ret;
> +
> +	st->reg_gpiocon_regmap =3D devm_regmap_init_spi(st->sd.spi,
> &ad7173_regmap_config);
> +	ret =3D PTR_ERR_OR_ZERO(st->reg_gpiocon_regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to init regmap\n");
> +
> +	mask =3D AD7173_GPIO_OP_EN0 | AD7173_GPIO_OP_EN1 |
> AD7173_GPIO_OP_EN2_3;
> +	regmap_update_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, mask,
> mask);
> +
> +	ret =3D devm_add_action_or_reset(dev, ad7173_gpio_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	gpio_regmap.parent =3D dev;
> +	gpio_regmap.regmap =3D st->reg_gpiocon_regmap;
> +	gpio_regmap.ngpio =3D st->info->num_gpios;
> +	gpio_regmap.reg_set_base =3D AD7173_REG_GPIO;
> +	gpio_regmap.reg_mask_xlate =3D ad7173_mask_xlate;
> +
> +	st->gpio_regmap =3D devm_gpio_regmap_register(dev, &gpio_regmap);
> +	ret =3D PTR_ERR_OR_ZERO(st->gpio_regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to init gpio-
> regmap\n");
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_GPIOLIB */
> +
> +static struct ad7173_state *ad_sigma_delta_to_ad7173(struct ad_sigma_del=
ta
> *sd)
> +{
> +	return container_of(sd, struct ad7173_state, sd);
> +}
> +
> +static struct ad7173_state *clk_hw_to_ad7173(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ad7173_state, int_clk_hw);
> +}
> +
> +static void ad7173_ida_destroy(void *data)
> +{
> +	struct ad7173_state *st =3D data;
> +
> +	ida_destroy(&st->cfg_slots_status);
> +}
> +
> +static void ad7173_reset_usage_cnts(struct ad7173_state *st)
> +{
> +	memset64(st->config_cnts, 0, st->info->num_configs);
> +	st->config_usage_counter =3D 0;
> +}
> +
> +static struct ad7173_channel_config *
> +ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_c=
onfig
> *cfg)
> +{
> +	struct ad7173_channel_config *cfg_aux;
> +	ptrdiff_t cmp_size;
> +	int i;
> +
> +	cmp_size =3D sizeof_field(struct ad7173_channel_config, config_props);
> +	for (i =3D 0; i < st->num_channels; i++) {
> +		cfg_aux =3D &st->channels[i].cfg;
> +
> +		if (cfg_aux->live &&
> +		=C2=A0=C2=A0=C2=A0 !memcmp(&cfg->config_props, &cfg_aux->config_props,
> cmp_size))
> +			return cfg_aux;
> +	}
> +	return NULL;
> +}
> +
> +/* Could be replaced with a generic LRU implementation */
> +static int ad7173_free_config_slot_lru(struct ad7173_state *st)
> +{
> +	int i, lru_position =3D 0;
> +
> +	for (i =3D 1; i < st->info->num_configs; i++)
> +		if (st->config_cnts[i] < st->config_cnts[lru_position])
> +			lru_position =3D i;
> +
> +	for (i =3D 0; i < st->num_channels; i++)
> +		if (st->channels[i].cfg.cfg_slot =3D=3D lru_position)
> +			st->channels[i].cfg.live =3D false;
> +
> +	ida_free(&st->cfg_slots_status, lru_position);
> +	return ida_alloc(&st->cfg_slots_status, GFP_KERNEL);
> +}
> +
> +/* Could be replaced with a generic LRU implementation */
> +static int ad7173_load_config(struct ad7173_state *st,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7173_channel_config *cfg)
> +{
> +	unsigned int config;
> +	int free_cfg_slot, ret;
> +
> +	free_cfg_slot =3D ida_alloc_range(&st->cfg_slots_status, 0,
> +					st->info->num_configs - 1,
> GFP_KERNEL);
> +	if (free_cfg_slot < 0)
> +		free_cfg_slot =3D ad7173_free_config_slot_lru(st);
> +
> +	cfg->cfg_slot =3D free_cfg_slot;
> +	config =3D FIELD_PREP(AD7173_SETUP_REF_SEL_MASK, cfg->ref_sel);
> +
> +	if (cfg->bipolar)
> +		config |=3D AD7173_SETUP_BIPOLAR;
> +
> +	if (cfg->input_buf)
> +		config |=3D AD7173_SETUP_AIN_BUF_MASK;
> +
> +	ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_SETUP(free_cfg_slot), 2,
> config);
> +	if (ret)
> +		return ret;
> +
> +	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7173_FILTER_ODR0_MASK & cfg->o=
dr);
> +}
> +
> +static int ad7173_config_channel(struct ad7173_state *st, int addr)
> +{
> +	struct ad7173_channel_config *cfg =3D &st->channels[addr].cfg;
> +	struct ad7173_channel_config *live_cfg;
> +	int ret;
> +
> +	if (!cfg->live) {
> +		live_cfg =3D ad7173_find_live_config(st, cfg);
> +		if (live_cfg) {
> +			cfg->cfg_slot =3D live_cfg->cfg_slot;
> +		} else {
> +			ret =3D ad7173_load_config(st, cfg);
> +			if (ret)
> +				return ret;
> +			cfg->live =3D true;
> +		}
> +	}
> +
> +	if (st->config_usage_counter =3D=3D U64_MAX)
> +		ad7173_reset_usage_cnts(st);
> +
> +	st->config_usage_counter++;
> +	st->config_cnts[cfg->cfg_slot] =3D st->config_usage_counter;
> +
> +	return 0;
> +}
> +
> +static int ad7173_set_channel(struct ad_sigma_delta *sd, unsigned int
> channel)
> +{
> +	struct ad7173_state *st =3D ad_sigma_delta_to_ad7173(sd);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D ad7173_config_channel(st, channel);
> +	if (ret)
> +		return ret;
> +
> +	val =3D AD7173_CH_ENABLE |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, st-
> >channels[channel].cfg.cfg_slot) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->channels[channel].ain;
> +
> +	return ad_sd_write_reg(&st->sd, AD7173_REG_CH(channel), 2, val);
> +}
> +
> +static int ad7173_set_mode(struct ad_sigma_delta *sd,
> +			=C2=A0=C2=A0 enum ad_sigma_delta_mode mode)
> +{
> +	struct ad7173_state *st =3D ad_sigma_delta_to_ad7173(sd);
> +
> +	st->adc_mode &=3D ~AD7173_ADC_MODE_MODE_MASK;
> +	st->adc_mode |=3D FIELD_PREP(AD7173_ADC_MODE_MODE_MASK, mode);
> +
> +	return ad_sd_write_reg(&st->sd, AD7173_REG_ADC_MODE, 2, st-
> >adc_mode);
> +}
> +
> +static int ad7173_append_status(struct ad_sigma_delta *sd, bool append)
> +{
> +	struct ad7173_state *st =3D ad_sigma_delta_to_ad7173(sd);
> +	unsigned int interface_mode =3D st->interface_mode;
> +	int ret;
> +
> +	interface_mode |=3D AD7173_INTERFACE_DATA_STAT_EN(append);
> +	ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_INTERFACE_MODE, 2,
> interface_mode);
> +	if (ret)
> +		return ret;
> +
> +	st->interface_mode =3D interface_mode;
> +
> +	return 0;
> +}
> +
> +static int ad7173_disable_all(struct ad_sigma_delta *sd)
> +{
> +	struct ad7173_state *st =3D ad_sigma_delta_to_ad7173(sd);
> +	int ret;
> +	int i;
> +
> +	for (i =3D 0; i < st->num_channels; i++) {
> +		ret =3D ad_sd_write_reg(sd, AD7173_REG_CH(i), 2, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct ad_sigma_delta_info ad7173_sigma_delta_info =3D {
> +	.set_channel =3D ad7173_set_channel,
> +	.append_status =3D ad7173_append_status,
> +	.disable_all =3D ad7173_disable_all,
> +	.set_mode =3D ad7173_set_mode,
> +	.has_registers =3D true,
> +	.addr_shift =3D 0,
> +	.read_mask =3D BIT(6),
> +	.status_ch_mask =3D GENMASK(3, 0),
> +	.data_reg =3D AD7173_REG_DATA,
> +};
> +
> +static int ad7173_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->sd.spi->dev;
> +	u8 buf[AD7173_RESET_LENGTH];
> +	unsigned int id;
> +	int ret;
> +
> +	/* reset the serial interface */
> +	memset(buf, 0xff, AD7173_RESET_LENGTH);
> +	ret =3D spi_write_then_read(st->sd.spi, buf, sizeof(buf), NULL, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* datasheet recommends a delay of at least 500us after reset */
> +	fsleep(500);
> +
> +	ret =3D ad_sd_read_reg(&st->sd, AD7173_REG_ID, 2, &id);
> +	if (ret)
> +		return ret;
> +
> +	id &=3D AD7173_ID_MASK;
> +	if (id !=3D st->info->id)
> +		dev_warn(dev, "Unexpected device id: 0x%04X, expected:
> 0x%04X\n",
> +			 id, st->info->id);
> +
> +	st->adc_mode |=3D AD7173_ADC_MODE_SING_CYC;
> +	st->interface_mode =3D 0x0;
> +
> +	st->config_usage_counter =3D 0;
> +	st->config_cnts =3D devm_kcalloc(dev, st->info->num_configs,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*st->config_cnts), GFP_K=
ERNEL);
> +	if (!st->config_cnts)
> +		return -ENOMEM;
> +
> +	/* All channels are enabled by default after a reset */
> +	return ad7173_disable_all(&st->sd);
> +}
> +
> +static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st=
,
> +						 u8 reference_select)
> +{
> +	int vref;
> +
> +	switch (reference_select) {
> +	case AD7173_SETUP_REF_SEL_EXT_REF:
> +		vref =3D regulator_get_voltage(st->regulators[0].consumer);
> +		break;
> +
> +	case AD7173_SETUP_REF_SEL_EXT_REF2:
> +		vref =3D regulator_get_voltage(st->regulators[1].consumer);
> +		break;
> +
> +	case AD7173_SETUP_REF_SEL_INT_REF:
> +		vref =3D AD7173_VOLTAGE_INT_REF_uV;
> +		break;
> +
> +	case AD7173_SETUP_REF_SEL_AVDD1_AVSS:
> +		vref =3D regulator_get_voltage(st->regulators[2].consumer);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (vref < 0)
> +		return vref;
> +
> +	return vref / (MICRO / MILLI);
> +}
> +
> +static int ad7173_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long info)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	struct ad7173_channel *ch =3D &st->channels[chan->address];
> +	unsigned int reg;
> +	u64 temp;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* disable channel after single conversion */
> +		ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_CH(chan->address),
> 2, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			temp =3D AD7173_VOLTAGE_INT_REF_uV * MILLI;
> +			temp /=3D AD7173_TEMP_SENSIIVITY_uV_per_C;
> +			*val =3D temp;
> +			*val2 =3D chan->scan_type.realbits;
> +		} else {
> +			*val =3D ad7173_get_ref_voltage_milli(st, ch-
> >cfg.ref_sel);
> +			*val2 =3D chan->scan_type.realbits - !!(ch-
> >cfg.bipolar);
> +		}
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			/* 0 Kelvin -> raw sample */
> +			temp=C2=A0=C2=A0 =3D -ABSOLUTE_ZERO_MILLICELSIUS;
> +			temp=C2=A0 *=3D AD7173_TEMP_SENSIIVITY_uV_per_C;
> +			temp <<=3D chan->scan_type.realbits;
> +			temp=C2=A0=C2=A0 =3D DIV_U64_ROUND_CLOSEST(temp,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> AD7173_VOLTAGE_INT_REF_uV *
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MILLI);
> +			*val=C2=A0=C2=A0 =3D -temp;
> +		} else {
> +			*val =3D -BIT(chan->scan_type.realbits - 1);
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		reg =3D st->channels[chan->address].cfg.odr;
> +
> +		*val =3D st->info->sinc5_data_rates[reg] / MILLI;
> +		*val2 =3D (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO /
> MILLI);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7173_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long info)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	struct ad7173_channel_config *cfg;
> +	unsigned int freq, i, reg;
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		freq =3D val * MILLI + val2 / MILLI;
> +		for (i =3D 0; i < st->info->num_sinc5_data_rates - 1; i++)
> +			if (freq >=3D st->info->sinc5_data_rates[i])
> +				break;
> +
> +		cfg =3D &st->channels[chan->address].cfg;
> +		cfg->odr =3D i;
> +
> +		if (!cfg->live)
> +			break;
> +
> +		ret =3D ad_sd_read_reg(&st->sd, AD7173_REG_FILTER(cfg-
> >cfg_slot), 2, &reg);
> +		if (ret)
> +			break;
> +		reg &=3D ~AD7173_FILTER_ODR0_MASK;
> +		reg |=3D FIELD_PREP(AD7173_FILTER_ODR0_MASK, i);
> +		ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(cfg-
> >cfg_slot), 2, reg);
> +		break;
> +
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
> +static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 const unsigned long *scan_mask)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	int i, ret;
> +
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		if (test_bit(i, scan_mask))
> +			ret =3D ad7173_set_channel(&st->sd, i);
> +		else
> +			ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_CH(i), 2,
> 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned i=
nt
> reg,
> +				=C2=A0=C2=A0 unsigned int writeval, unsigned int
> *readval)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	u8 reg_size;
> +
> +	if (reg =3D=3D AD7173_REG_COMMS)
> +		reg_size =3D 1;
> +	else if (reg =3D=3D AD7173_REG_CRC || reg =3D=3D AD7173_REG_DATA ||
> +		 reg >=3D AD7173_REG_OFFSET(0))
> +		reg_size =3D 3;
> +	else
> +		reg_size =3D 2;
> +
> +	if (readval)
> +		return ad_sd_read_reg(&st->sd, reg, reg_size, readval);
> +
> +	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
> +}
> +
> +static const struct iio_info ad7173_info =3D {
> +	.read_raw =3D &ad7173_read_raw,
> +	.write_raw =3D &ad7173_write_raw,
> +	.debugfs_reg_access =3D &ad7173_debug_reg_access,
> +	.validate_trigger =3D ad_sd_validate_trigger,
> +	.update_scan_mode =3D ad7173_update_scan_mode,
> +};
> +
> +static const struct iio_chan_spec ad7173_channel_template =3D {
> +	.type =3D IIO_VOLTAGE,
> +	.indexed =3D 1,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type =3D {
> +		.sign =3D 'u',
> +		.realbits =3D 24,
> +		.storagebits =3D 32,
> +		.endianness =3D IIO_BE,
> +	},
> +};
> +
> +static const struct iio_chan_spec ad7173_temp_iio_channel_template =3D {
> +	.type =3D IIO_TEMP,
> +	.indexed =3D 1,
> +	.channel =3D AD7173_AIN_TEMP_POS,
> +	.channel2 =3D AD7173_AIN_TEMP_NEG,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type =3D {
> +		.sign =3D 'u',
> +		.realbits =3D 24,
> +		.storagebits =3D 32,
> +		.endianness =3D IIO_BE,
> +	},
> +};
> +
> +static void ad7173_disable_regulators(void *data)
> +{
> +	struct ad7173_state *st =3D data;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
> +}
> +
> +static void ad7173_clk_disable_unprepare(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static unsigned long ad7173_sel_clk(struct ad7173_state *st,
> +				=C2=A0=C2=A0=C2=A0 unsigned int clk_sel)
> +{
> +	int ret;
> +
> +	st->adc_mode &=3D !AD7173_ADC_MODE_CLOCKSEL_MASK;
> +	st->adc_mode |=3D FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK, clk_sel);
> +	ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_ADC_MODE, 0x2, st-
> >adc_mode);
> +
> +	return ret;
> +}
> +
> +static unsigned long ad7173_clk_recalc_rate(struct clk_hw *hw,
> +					=C2=A0=C2=A0=C2=A0 unsigned long parent_rate)
> +{
> +	struct ad7173_state *st =3D clk_hw_to_ad7173(hw);
> +
> +	return st->info->clock / HZ_PER_KHZ;
> +}
> +
> +static int ad7173_clk_output_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad7173_state *st =3D clk_hw_to_ad7173(hw);
> +	u32 clk_sel;
> +
> +	clk_sel =3D FIELD_GET(AD7173_ADC_MODE_CLOCKSEL_MASK, st->adc_mode);
> +	return clk_sel =3D=3D AD7173_ADC_MODE_CLOCKSEL_INT_OUTPUT;
> +}
> +
> +static int ad7173_clk_output_prepare(struct clk_hw *hw)
> +{
> +	struct ad7173_state *st =3D clk_hw_to_ad7173(hw);
> +
> +	return ad7173_sel_clk(st, AD7173_ADC_MODE_CLOCKSEL_INT_OUTPUT);
> +}
> +
> +static void ad7173_clk_output_unprepare(struct clk_hw *hw)
> +{
> +	struct ad7173_state *st =3D clk_hw_to_ad7173(hw);
> +
> +	ad7173_sel_clk(st, AD7173_ADC_MODE_CLOCKSEL_INT);
> +}
> +
> +static const struct clk_ops ad7173_int_clk_ops =3D {
> +	.recalc_rate =3D ad7173_clk_recalc_rate,
> +	.is_enabled =3D ad7173_clk_output_is_enabled,
> +	.prepare =3D ad7173_clk_output_prepare,
> +	.unprepare =3D ad7173_clk_output_unprepare,
> +};
> +
> +static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D indio_dev->dev.parent;
> +	struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> +	struct clk_init_data init =3D {};
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +		return 0;
> +
> +	init.name =3D fwnode_get_name(fwnode);
> +	init.ops =3D &ad7173_int_clk_ops;
> +
> +	st->int_clk_hw.init =3D &init;
> +	ret =3D devm_clk_hw_register(dev, &st->int_clk_hw);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					=C2=A0=C2=A0 &st->int_clk_hw);
> +}
> +
> +static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_channel *chans_st_arr, *chan_st_priv;
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D indio_dev->dev.parent;
> +	struct iio_chan_spec *chan_arr, *chan;
> +	unsigned int ain[2], chan_index =3D 0;
> +	struct fwnode_handle *child;
> +	int ref_sel, ret;
> +
> +	if (st->info->has_temp) {
> +		chan_arr[chan_index] =3D ad7173_temp_iio_channel_template;
> +		chan_st_priv =3D &chans_st_arr[chan_index];
> +		chan_st_priv->ain =3D
> +			AD7173_CH_ADDRESS(chan_arr[chan_index].channel,
> chan_arr[chan_index].channel2);
> +		chan_st_priv->cfg.bipolar =3D false;
> +		chan_st_priv->cfg.input_buf =3D true;
> +		chan_st_priv->cfg.ref_sel =3D AD7173_SETUP_REF_SEL_INT_REF;
> +		st->adc_mode |=3D AD7173_ADC_MODE_REF_EN;
> +
> +		chan_index++;
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		chan =3D &chan_arr[chan_index];
> +		chan_st_priv =3D &chans_st_arr[chan_index];
> +		ret =3D fwnode_property_read_u32_array(child, "diff-channels",
> +						=C2=A0=C2=A0=C2=A0=C2=A0 ain, ARRAY_SIZE(ain));
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		if (ain[0] >=3D st->info->num_inputs ||
> +		=C2=A0=C2=A0=C2=A0 ain[1] >=3D st->info->num_inputs) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Input pin number out of range
> for pair (%d %d).\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ain[0], ain[1]);
> +		}
> +
> +		ret =3D fwnode_property_match_property_string(child,
> +							=C2=A0=C2=A0=C2=A0 "adi,reference-
> select",
> +							=C2=A0=C2=A0=C2=A0
> ad7173_ref_sel_str,
> +							=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad7173_ref_sel_str));
> +		if (ret < 0)
> +			ref_sel =3D AD7173_SETUP_REF_SEL_INT_REF;
> +		else
> +			ref_sel =3D ret;
> +
> +		if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_EXT_REF2 &&
> +		=C2=A0=C2=A0=C2=A0 st->info->id !=3D AD7173_ID) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL, "External
> reference 2 is only available on ad7173-8\n");
> +		}
> +
> +		ret =3D ad7173_get_ref_voltage_milli(st, ref_sel);
> +		if (ret < 0) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot use reference %u\n",
> ref_sel);
> +		}
> +		if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_INT_REF)
> +			st->adc_mode |=3D AD7173_ADC_MODE_REF_EN;
> +		chan_st_priv->cfg.ref_sel =3D ref_sel;
> +
> +		*chan =3D ad7173_channel_template;
> +		chan->address =3D chan_index;
> +		chan->scan_index =3D chan_index;
> +		chan->channel =3D ain[0];
> +		chan->channel2 =3D ain[1];
> +		chan->differential =3D true;
> +
> +		chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0], ain[1]);
> +		chan_st_priv->chan_reg =3D chan_index;
> +		chan_st_priv->cfg.input_buf =3D true;
> +		chan_st_priv->cfg.odr =3D 0;
> +
> +		chan_st_priv->cfg.bipolar =3D fwnode_property_read_bool(child,
> "bipolar");
> +		if (chan_st_priv->cfg.bipolar)
> +			chan->info_mask_separate |=3D
> BIT(IIO_CHAN_INFO_OFFSET);
> +
> +		chan_index++;
> +	}
> +	return 0;
> +}
> +
> +static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D indio_dev->dev.parent;
> +	unsigned int num_channels;
> +	int ret;
> +
> +	st->regulators[0].supply =3D
> ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
> +	st->regulators[1].supply =3D
> ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF2];
> +	st->regulators[2].supply =3D
> ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_AVDD1_AVSS];
> +
> +	/*
> +	 * If a regulator is not available, it will be set to a dummy
> regulator.
> +	 * Each channel reference is checked with regulator_get_voltage()
> before
> +	 * setting attributes so if any channel uses a dummy supply the
> driver
> +	 * probe will fail.
> +	 */
> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(st->regulators), st-
> >regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable
> regulators\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, ad7173_disable_regulators, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add regulators disable
> action\n");
> +
> +	ret =3D device_property_match_property_string(dev, "clock-names",
> +						=C2=A0=C2=A0=C2=A0 ad7173_clk_sel,
> +						=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad7173_clk_sel));
> +	if (ret < 0) {
> +		st->adc_mode |=3D FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK,
> AD7173_ADC_MODE_CLOCKSEL_INT);
> +		ad7173_register_clk_provider(indio_dev);
> +	} else {
> +		st->adc_mode |=3D FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK,
> AD7173_ADC_MODE_CLOCKSEL_EXT + ret);
> +		st->ext_clk =3D devm_clk_get(dev, ad7173_clk_sel[ret]);
> +		if (IS_ERR(st->ext_clk))
> +			return dev_err_probe(dev, PTR_ERR(st->ext_clk),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get external
> clock\n");
> +
> +		ret =3D clk_prepare_enable(st->ext_clk);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable external
> clock\n");
> +
> +		ret =3D devm_add_action_or_reset(dev,
> ad7173_clk_disable_unprepare,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->ext_clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D fwnode_irq_get_byname(dev_fwnode(dev), "rdy");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Interrupt 'rdy' is
> required\n");
> +
> +	ad7173_sigma_delta_info.irq_line =3D ret;
> +
> +	num_channels =3D device_get_child_node_count(dev);
> +
> +	if (st->info->has_temp)
> +		num_channels++;
> +
> +	if (num_channels =3D=3D 0)
> +		return dev_err_probe(dev, -ENODATA, "No channels
> specified\n");
> +	st->num_channels =3D num_channels;
> +
> +	indio_dev->channels =3D devm_kcalloc(dev, sizeof(*indio_dev->channels),
> +					=C2=A0=C2=A0 num_channels, GFP_KERNEL);
> +	if (!indio_dev->channels)
> +		return -ENOMEM;
> +
> +	st->channels =3D devm_kcalloc(dev, num_channels, sizeof(*st->channels),
> +				=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
> +	indio_dev->num_channels =3D num_channels;
> +	return ad7173_fw_parse_channel_config(indio_dev);
> +}
> +
> +static int ad7173_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct ad7173_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	ida_init(&st->cfg_slots_status);
> +	ret =3D devm_add_action_or_reset(dev, ad7173_ida_destroy, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad7173_info;
> +
> +	spi->mode =3D SPI_MODE_3;
> +	spi_setup(spi);
> +
> +	ad7173_sigma_delta_info.num_slots =3D st->info->num_configs;
> +	ret =3D ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad7173_fw_parse_device_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad7173_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ENABLED(CONFIG_GPIOLIB))
> +		return ad7173_gpio_init(st);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ad7173_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7172-2",
> +	=C2=A0 .data =3D &ad7173_device_info[ID_AD7172_2]},
> +	{ .compatible =3D "adi,ad7173-8",
> +	=C2=A0 .data =3D &ad7173_device_info[ID_AD7173_8]},
> +	{ .compatible =3D "adi,ad7175-2",
> +	=C2=A0 .data =3D &ad7173_device_info[ID_AD7175_2]},
> +	{ .compatible =3D "adi,ad7176-2",
> +	=C2=A0 .data =3D &ad7173_device_info[ID_AD7176_2]},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7173_of_match);
> +
> +static const struct spi_device_id ad7173_id_table[] =3D {
> +	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
> +	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
> +	{ "ad7175-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_2]},
> +	{ "ad7176-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7176_2]},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad7173_id_table);
> +
> +static struct spi_driver ad7173_driver =3D {
> +	.driver =3D {
> +		.name	=3D "ad7173",
> +		.of_match_table =3D ad7173_of_match,
> +	},
> +	.probe		=3D ad7173_probe,
> +	.id_table	=3D ad7173_id_table,
> +};
> +module_spi_driver(ad7173_driver);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafo.de>");
> +MODULE_AUTHOR("Dumitru Ceclan <dumitru.ceclan@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7172/AD7173/AD7175/AD7176 ADC drive=
r");
> +MODULE_LICENSE("GPL");


