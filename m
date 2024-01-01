Return-Path: <linux-kernel+bounces-13837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82C821341
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832A31C21687
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3D1C2D;
	Mon,  1 Jan 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="FrL3QcE8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2133.outbound.protection.outlook.com [40.107.247.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C617C9;
	Mon,  1 Jan 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJQBaYi69QPwrTurjeM8sjbP1V9hmS5zRf3WHcn5crtRFxuCgP4F1JcNjTbT6LvkoJ7OhhF/l8y2WHjEPEhpy7Bfmn3yhKVsWmDc6VKuLcKkDZsTRH0jtdbU62sghYdFO98++MhbnaiE386drSR7uURi2VEyB5LdKOPH7ike5Jhk5QJtPc4fc1ZiCQ0gOqdfxX1jGNYrPD3TYgYdkZBB0NFC6e8D+ZxWIMzs4W36YTpH+dwl4+hJ+FnvslOCn8S+soqmcZl4OQC9u3AB9BS520Ea5qoClpkTfIljSrQ3Vj14CeRDdt9FSl6T5uE4MnUBa3GKPceag9WKuf4T7v7Mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H0hmoHbP3ZH2ytsSUisW809rpMRMa1mvWggycD3jH0=;
 b=AwAyRz3r1SUkcq2ZJGr1hPkQFNu5+ZNTyG+kGrHLKQPGcxNBS0U+5qrHbjM/dnjYf3P6DQ5exvWxLnmygiUmfq1Jfobd2IF4jnZ8mLITLjWXB3s5F2YIGLdQ9TBXK23TJ2yWRAYoFoc6D+iyBg1nzfpVl9VnjPF9kLIdLoYDQ8lfUWMlZhMS7aUz+RsPT/orsivjxF2LYXq4G3mYG21o41YH54d31N7vBVblns4PKASNuu0WtTM7ylOA9NbwWqGaygEkYCXN1xTkan7c3Mss6qqjWmnvLAyuYBePzVk2NcXG214+PvoqFKSU0YEA0o0biWCg/5i+BYgQgo5sZt7Osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=none
 action=none header.from=arri.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H0hmoHbP3ZH2ytsSUisW809rpMRMa1mvWggycD3jH0=;
 b=FrL3QcE8FV/F4eEY4DUWnK4eewC2EFugXofoS5c0dE8SG/sf2sgefQ6ZvA2TlFyEWN89R5tlKSKEq9x4gyBa+VfOmFSJHZj25fp+R/BR4M2NOsEfgePSddBmFZKp4IYJ+9KBndpJUdXcWTLF7jFvKwZMgQs4Jbf3aoEnzLSChj4=
Received: from DU2P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::29)
 by AS4PR07MB9632.eurprd07.prod.outlook.com (2603:10a6:20b:4f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 08:20:09 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::ef) by DU2P250CA0024.outlook.office365.com
 (2603:10a6:10:231::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Mon, 1 Jan 2024 08:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Mon, 1 Jan 2024 08:20:08 +0000
Received: from n95hx1g2.localnet (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 1 Jan
 2024 09:20:07 +0100
From: Christian Eggers <ceggers@arri.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/2] io: light: as73211: add support for as7331
Date: Mon, 1 Jan 2024 09:20:07 +0100
Message-ID: <2337038.ElGaqSPkdT@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20231220-as7331-v1-2-745b73c27703@gmail.com>
References: <20231220-as7331-v1-0-745b73c27703@gmail.com> <20231220-as7331-v1-2-745b73c27703@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|AS4PR07MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: f098f6be-ee93-495e-78c4-08dc0aa27778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U7BR8gusP/UlXrKg6dQ+NbX8n2ZKtVE2by+5vbeVICFZxrtF55KAtTnX4Y6/SPQiIm9p17PVYmZYDbR92t/nkrU6hL+AXV/TZ9IMQ94KHrkLLdvq6sbgwW/22w6SIdp1nC7GwtYSlYtE925BU4NEEsVQeaSI/KEIWznCxheMzycIn6vRC9aGUPt9hJuR4RzGySFAW09CoSTWS+2hXDNlNKlAPyT8RjYIrbnyp+8KDNuCWoJofFCjqwP5M0DtkZyJIracCGAbUtsVYvT4gtoLkBvEReq9PtPUwdF0MOOzuaLAbIEWwTEM6bYS2OF2wga0La+bHV0qQ4jqkLrxwNBDUs06CkANqla6pABgu43kWqKtBKMQ6wnuNHXxWyXl1NzFwQuH2yw/bIrmWQkhfbnJZVV27Pdky5wOaH4NTaXiwrFYXqF5Xhv6aP10POq5WW7Jk/3J+gojbb9WPwAJHGbJIcZkL2XhgkF2OMXtk+aCDdXS2a/Oih95uMfGQ1tviahO3VYAOyGCdhhPCO4z75qxlJ5pAOJKaed5Gk6HSiajU4Svk6J5YTR7T+tseSudNayRCejMH3wSBn9wOtpRapgWbiHZDuQa3ylXXPy3Kh0+3ctQ63wULDXenxfeijwu4BYTi6Nlw73UX3SWDEl//ti1qVH7z0UNpf6rvgJyyXBeFkJmx0IhIS7v467BaOT4slniS+LZcTHiunF/5VOJ0Htu1DrdIsQRyeFDlEJlyBzIzCL2Bm0bbKRXd9V74KdW+LgruTcIl2Qsn1aFKInI+kuVzA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39840400004)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40140700001)(40480700001)(9686003)(36916002)(70206006)(70586007)(86362001)(41300700001)(426003)(336012)(83380400001)(16526019)(81166007)(356005)(33716001)(26005)(47076005)(2906002)(4326008)(5660300002)(30864003)(478600001)(9576002)(966005)(36860700001)(110136005)(316002)(54906003)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 08:20:08.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f098f6be-ee93-495e-78c4-08dc0aa27778
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9632

On Saturday, 23 December 2023, 11:46:14 CET, Javier Carrasco wrote:
> The AMS AS7331 is a UV light sensor with three channels: UVA, UVB and
> UVC (also known as deep UV and referenced as DUV in the iio core).
> Its internal structure and forming blocks are practically identical to
> the ones the AS73211 contains: API, internal DAC, I2C interface and
> registers, measurement modes, number of channels and pinout.
> 
> The only difference between them is the photodiodes used to acquire
> light, which means that only some modifications are required to add
> support for the AS7331 in the existing driver.
> 
> The temperature channel is identical for both devices and only the
> channel modifiers of the IIO_INTENSITY channels need to account for the
> device type.
> 
> The scale values have been obtained from the chapter "7.5 Transfer
> Function" of the official datasheet[1] for the configuration chosen as
> basis (Nclk = 1024 and GAIN = 1). Those values keep the units from the
> datasheet (nW/cm^2) because no additional upscaling is required to work
> with integers as opposed to the scale values for the AS73211. Actually
> if the same upscaling is used, their values will not fit in 4-byte
> integers without affecting its sign.
> 
> Instead, the AS7331-specific function to retrieve the intensity scales
> returns decimal values as listed in the datasheet for every
> combination of GAIN and Nclk, keeping the unit as nW/cm^2.
> To achieve that, a fractional value is returned.
> The AS73211 scales use nW/m^2 units to work with integers that fit in
> a 4-byte integer, and in that case there is no need to modify the value
> type.
> 
> Add a new device-specific data structure to account for the device
> differences: channel types and scale of LSB per channel.
> 
> [1] https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/Kconfig   |   5 +-
>  drivers/iio/light/as73211.c | 146 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 122 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 143003232d1c..fd5a9879a582 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -87,13 +87,14 @@ config APDS9960
>  	  module will be called apds9960
>  
>  config AS73211
> -	tristate "AMS AS73211 XYZ color sensor"
> +	tristate "AMS AS73211 XYZ color sensor and AMS AS7331 UV sensor"
>  	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	 If you say yes here you get support for the AMS AS73211
> -	 JENCOLOR(R) Digital XYZ Sensor.
> +	 JENCOLOR(R) Digital XYZ and the AMS AS7331 UVA, UVB and UVC
> +	 ultraviolet sensors.
>  
>  	 For triggered measurements, you will need an additional trigger driver
>  	 like IIO_HRTIMER_TRIGGER or IIO_SYSFS_TRIGGER.
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index ec97a3a46839..d53a0ae5255a 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor
> + * Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor and AMS AS7331
> + * UVA, UVB and UVC (DUV) Ultraviolet Sensor
>   *
>   * Author: Christian Eggers <ceggers@arri.de>
>   *
> @@ -9,7 +10,9 @@
>   * Color light sensor with 16-bit channels for x, y, z and temperature);
>   * 7-bit I2C slave address 0x74 .. 0x77.
>   *
> - * Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf
> + * Datasheets:
> + * AS73211: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf
> + * AS7331: https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf
>   */
>  
>  #include <linux/bitfield.h>
> @@ -84,6 +87,20 @@ static const int as73211_hardwaregain_avail[] = {
>  	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048,
>  };
>  
> +struct as73211_data;
> +
> +/**
> + * struct spec_dev_data - device-specific data
> + * @intensity_scale:  Function to retrieve intensity scale values.
> + * @channel:          Device channels.
> + * @num_channels:     Number of channels of the device.
> + */
> +struct spec_dev_data {
> +	int (*intensity_scale)(struct as73211_data *data, int chan, int *val, int *val2);
> +	struct iio_chan_spec const *channel;
> +	int num_channels;
> +};
> +
>  /**
>   * struct as73211_data - Instance data for one AS73211
>   * @client: I2C client.
> @@ -94,6 +111,7 @@ static const int as73211_hardwaregain_avail[] = {
>   * @mutex:  Keeps cached registers in sync with the device.
>   * @completion: Completion to wait for interrupt.
>   * @int_time_avail: Available integration times (depend on sampling frequency).
> + * @spec_dev: device-specific configuration.
>   */
>  struct as73211_data {
>  	struct i2c_client *client;
> @@ -104,6 +122,7 @@ struct as73211_data {
>  	struct mutex mutex;
>  	struct completion completion;
>  	int int_time_avail[AS73211_SAMPLE_TIME_NUM * 2];
> +	const struct spec_dev_data *spec_dev;
>  };
>  
>  #define AS73211_COLOR_CHANNEL(_color, _si, _addr) { \
> @@ -138,6 +157,10 @@ struct as73211_data {
>  #define AS73211_SCALE_Y 298384270  /* nW/m^2 */
>  #define AS73211_SCALE_Z 160241927  /* nW/m^2 */
>  
> +#define AS7331_SCALE_UVA 340000  /* nW/cm^2 */
> +#define AS7331_SCALE_UVB 378000  /* nW/cm^2 */
> +#define AS7331_SCALE_UVC 166000  /* nW/cm^2 */
> +
>  /* Channel order MUST match devices result register order */
>  #define AS73211_SCAN_INDEX_TEMP 0
>  #define AS73211_SCAN_INDEX_X    1
> @@ -176,6 +199,28 @@ static const struct iio_chan_spec as73211_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(AS73211_SCAN_INDEX_TS),
>  };
>  
> +static const struct iio_chan_spec as7331_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.address = AS73211_OUT_TEMP,
> +		.scan_index = AS73211_SCAN_INDEX_TEMP,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		}
> +	},
> +	AS73211_COLOR_CHANNEL(LIGHT_UVA, AS73211_SCAN_INDEX_X, AS73211_OUT_MRES1),
> +	AS73211_COLOR_CHANNEL(LIGHT_UVB, AS73211_SCAN_INDEX_Y, AS73211_OUT_MRES2),
> +	AS73211_COLOR_CHANNEL(LIGHT_DUV, AS73211_SCAN_INDEX_Z, AS73211_OUT_MRES3),
> +	IIO_CHAN_SOFT_TIMESTAMP(AS73211_SCAN_INDEX_TS),
> +};
> +
>  static unsigned int as73211_integration_time_1024cyc(struct as73211_data *data)
>  {
>  	/*
> @@ -316,6 +361,50 @@ static int as73211_req_data(struct as73211_data *data)
>  	return 0;
>  }
>  
> +static int as73211_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
> +{
> +	unsigned int scale;
> +
> +	switch (chan) {
> +	case IIO_MOD_X:
> +		scale = AS73211_SCALE_X;
> +		break;
> +	case IIO_MOD_Y:
> +		scale = AS73211_SCALE_Y;
> +		break;
> +	case IIO_MOD_Z:
> +		scale = AS73211_SCALE_Z;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	scale /= as73211_gain(data);
> +	scale /= as73211_integration_time_1024cyc(data);
> +	*val = scale;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int as7331_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
> +{
> +	switch (chan) {
> +	case IIO_MOD_LIGHT_UVA:
> +		*val = AS7331_SCALE_UVA;
> +		break;
> +	case IIO_MOD_LIGHT_UVB:
> +		*val = AS7331_SCALE_UVB;
> +		break;
> +	case IIO_MOD_LIGHT_DUV:
> +		*val = AS7331_SCALE_UVC;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	*val2 = as73211_gain(data) * as73211_integration_time_1024cyc(data);
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
>  static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
>  			     int *val, int *val2, long mask)
>  {
> @@ -355,30 +444,12 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
>  			*val2 = AS73211_SCALE_TEMP_MICRO;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  
> -		case IIO_INTENSITY: {
> -			unsigned int scale;
> -
> -			switch (chan->channel2) {
> -			case IIO_MOD_X:
> -				scale = AS73211_SCALE_X;
> -				break;
> -			case IIO_MOD_Y:
> -				scale = AS73211_SCALE_Y;
> -				break;
> -			case IIO_MOD_Z:
> -				scale = AS73211_SCALE_Z;
> -				break;
> -			default:
> -				return -EINVAL;
> -			}
> -			scale /= as73211_gain(data);
> -			scale /= as73211_integration_time_1024cyc(data);
> -			*val = scale;
> -			return IIO_VAL_INT;
> +		case IIO_INTENSITY:
> +			return data->spec_dev->intensity_scale(data, chan->channel2, val, val2);
>  
>  		default:
>  			return -EINVAL;
> -		}}
> +		}
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		/* f_samp is configured in CREG3 in powers of 2 (x 1.024 MHz) */
> @@ -676,13 +747,20 @@ static int as73211_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> +	if (dev_fwnode(dev))
> +		data->spec_dev = device_get_match_data(dev);
> +	else
> +		data->spec_dev = i2c_get_match_data(client);
> +	if (!data->spec_dev)
> +		return -EINVAL;
> +
>  	mutex_init(&data->mutex);
>  	init_completion(&data->completion);
>  
>  	indio_dev->info = &as73211_info;
>  	indio_dev->name = AS73211_DRV_NAME;
> -	indio_dev->channels = as73211_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(as73211_channels);
> +	indio_dev->channels = data->spec_dev->channel;
> +	indio_dev->num_channels = data->spec_dev->num_channels;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
> @@ -772,14 +850,28 @@ static int as73211_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(as73211_pm_ops, as73211_suspend,
>  				as73211_resume);
>  
> +static const struct spec_dev_data as73211_spec = {
> +	.intensity_scale = as73211_intensity_scale,
> +	.channel = as73211_channels,
> +	.num_channels = ARRAY_SIZE(as73211_channels),
> +};
> +
> +static const struct spec_dev_data as7331_spec = {
> +	.intensity_scale = as7331_intensity_scale,
> +	.channel = as7331_channels,
> +	.num_channels = ARRAY_SIZE(as7331_channels),
> +};
> +
>  static const struct of_device_id as73211_of_match[] = {
> -	{ .compatible = "ams,as73211" },
> +	{ .compatible = "ams,as73211", &as73211_spec },
> +	{ .compatible = "ams,as7331", &as7331_spec },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, as73211_of_match);
>  
>  static const struct i2c_device_id as73211_id[] = {
> -	{ "as73211", 0 },
> +	{ "as73211", (kernel_ulong_t)&as73211_spec },
> +	{ "as7331", (kernel_ulong_t)&as7331_spec },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, as73211_id);
> 
> 

As I still work with Linux 6.1, I backported this patch for
that version. A short test with an as73211 didn't show any
differences.

If I shall test further revisions of this patch, I can do this
after the 9th of January.


If I shall test further revisions of this patch, I can do this
after the 9th of January.


Tested-by: Christian Eggers <ceggers@arri.de>




