Return-Path: <linux-kernel+bounces-24518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3482BDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2626C283931
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA15DF07;
	Fri, 12 Jan 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="fcFd4e48"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2103.outbound.protection.outlook.com [40.107.15.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6585D8F3;
	Fri, 12 Jan 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhhMnzRQJgK50n/m/lc5gn69SNYQPOxcwjwxxo1XM1zIcEAZq8uXwwrARG65mji0srj53NZ7X8UQDbjdNfOuc/g9bSWKYrFVCQlMtJtrY/rnie2zbMBIH2UkN6fkHTtkQW6Ze/nyKH/FEhFgn1D72hNRUul7QnjhIeX68E6IuMAVpUYSfbpjbNzQF/MOSzImcSGUiwLuXnO31AF7Z6uQ2yu5gHfKGzPw42CCTRtsc4SVdwRR0s2CPoFWlYCY4bNj/gwpe4a/P1DY1xYanS0j302329KVdK57qkNxPCt5PoGBkoR83+0xjlmOLTursslZCpiwr1MmLrHtl2trptGLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHBj12WwLQC68lDRE3zb5nNbnl1dxNyrJGayh35VDww=;
 b=GOqCBTimKC63NSjPc+yMLWF4ZjSX8VN4SL8RX+ySCNtYbTes/AdqG7oiDCwb37lmEAEyCG1QNCkcv78yQWxboHbthc/zHCPWYTlzzsjFYxH1iSOgkGO1vJ2R5wY69+T8Wo329qlZZveyk3P6kNhCoxKx8Kg+BWOBJ6m5b2QXU+EDlyvCbLncotRB5zBaZRuKOoYE1e8OPAOaqxaKZ/kXENKtsXKSF1EJC/cUynAmz6HKwzTr5aqn+w7LY7Cp2pnOC1vR2DAHusFN3cx6sfSnO3f4yi+Ow33UijqmDCdK9wP6yD2u8j7DZQ2Ripjz/v0JPb5VeT4LEeG6WbsW2ICO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=none
 action=none header.from=arri.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHBj12WwLQC68lDRE3zb5nNbnl1dxNyrJGayh35VDww=;
 b=fcFd4e48IV51hLqpa9GCjdOBos+6g4DopIDZZJLsrcSOHXXo2ErF0qbn83/3KvaiocxRFkmmLvvlGMz//YtYfzKzABpEBcSEk8NhoqSsW5DlAJXZ/kUS0F8LXYGhfDfyyRnQR1mnb4C8Wem1iSj7i/nB7fPshj+fH3BgelJ6KgI=
Received: from DUZPR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::23) by GV2PR07MB9177.eurprd07.prod.outlook.com
 (2603:10a6:150:c3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 09:47:53 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::b) by DUZPR01CA0108.outlook.office365.com
 (2603:10a6:10:4bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 09:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 09:47:51 +0000
Received: from n95hx1g2.localnet (192.168.54.163) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 12 Jan
 2024 10:47:50 +0100
From: Christian Eggers <ceggers@arri.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: light: as73211: add support for as7331
Date: Fri, 12 Jan 2024 10:47:49 +0100
Message-ID: <4555448.LvFx2qVVIh@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20240103-as7331-v2-3-6f0ad05e0482@gmail.com>
References: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com> <20240103-as7331-v2-3-6f0ad05e0482@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|GV2PR07MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da0a2f4-5493-4666-2b1d-08dc13538ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qw4IWPEdMX8uZvtDHlTE8iJYPPr+IsD502URTxrqwwA2A2S9bd3NGTZKPbJkbar+RauKS4q7nIZLhzq5Qiycg4wXKBzMdYyYytIFovdADE283Edwnrm3bPBBt49EtaAt9wUwaVKCboYqbK7+HNce8cztqKGuXWPcNgqpama1ObDHL24heVTaMTwYYCPEfDedISN+NdSU5p5UpHea9OYiGjKRrrQZjWsjXJtHMEskH54xfzbfwpaGCOZazB9mWK01rYjXbyoiSEsaYay150ijqvY4mRFaUsbV59wCfciMF7oIh9io8op/RiY247+WMuRMOg72iC6pWpHH3OLo+B0WmtRC5PqGGjCGzhJWAv4NwyHJV0Br7zV5FGP2emPYkFF2RZefaLGOY4No8gi0RtQn7ZDsiRsQQHiRINLpW695z/IkXWnx7HEEyQj43HVQOF01y8Kb1rWhdgCuFZ5pDyRWdPqVJUBdFPfeqo0p/iA+bVE+SB6Xyfy/Cwk8P/VZAI6ijdfe14GkyPxNW5hi4YHzyZipWybZA0A/s6bOWiI9v1ZspOhU9xsfnuX28yTYszMhvh/xTgmCNjS1q98P+/aoDaoacHK0jp6H2HYnbzxYzSzI4zGinvHJdDUKC8lZczy0KjxdrSud3SOgI7fc2DB3kK3XlArJkF1yMEeYqgsykXUWd/eRv931psyFAKJ2lFGffltcX5wn3vWPVj2XVNcIod4PTVFS5ENccr1ihTKMhb1dueeYRp5vjVXoflOQRgNl
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(36840700001)(46966006)(86362001)(70206006)(82740400003)(966005)(478600001)(70586007)(9576002)(81166007)(356005)(16526019)(426003)(336012)(26005)(36916002)(4326008)(40480700001)(8676002)(110136005)(8936002)(54906003)(9686003)(83380400001)(316002)(41300700001)(5660300002)(2906002)(40140700001)(36860700001)(47076005)(33716001)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 09:47:51.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da0a2f4-5493-4666-2b1d-08dc13538ade
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9177

Hi Javier,

after being back from my extended Christmas holidays, I took a look
onto your changes:

On Wednesday, 3 January 2024, 13:08:53 CET, Javier Carrasco wrote:
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
> datasheet (nW/cm^2), as opposed to the units used for the AS73211
> (nW/m^2).
> 
> Add a new device-specific data structure to account for the device
> differences: channel types and scale of LSB per channel.
> 
> [1] https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf
> 
> Tested-by: Christian Eggers <ceggers@arri.de>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/Kconfig   |   5 +-
>  drivers/iio/light/as73211.c | 141 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 118 insertions(+), 28 deletions(-)
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
> index b4c6f389a292..44daf816ae57 100644
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

I would call it as73211_spec_dev_data (is the C++ One Definition Rule relevant for
the kernel?)

> +	int (*intensity_scale)(struct as73211_data *data, int chan, int *val, int *val2);
> +	struct iio_chan_spec const *channel;
s/channel/channels/

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
> @@ -316,6 +361,48 @@ static int as73211_req_data(struct as73211_data *data)
>  	return 0;
>  }
>  
> +static int as73211_intensity_scale(struct as73211_data *data, int chan,
> +				   int *val, int *val2)
> +{
> +	switch (chan) {
> +	case IIO_MOD_X:
> +		*val = AS73211_SCALE_X;
> +		break;
> +	case IIO_MOD_Y:
> +		*val = AS73211_SCALE_Y;
> +		break;
> +	case IIO_MOD_Z:
> +		*val = AS73211_SCALE_Z;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	*val2 = as73211_integration_time_1024cyc(data) * as73211_gain(data);
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int as7331_intensity_scale(struct as73211_data *data, int chan,
> +				  int *val, int *val2)
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
> +	*val2 = as73211_integration_time_1024cyc(data) * as73211_gain(data);
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
>  static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
>  			     int *val, int *val2, long mask)
>  {
> @@ -355,29 +442,13 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
>  			*val2 = AS73211_SCALE_TEMP_MICRO;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  
> -		case IIO_INTENSITY: {
> -
> -			switch (chan->channel2) {
> -			case IIO_MOD_X:
> -				*val = AS73211_SCALE_X;
> -				break;
> -			case IIO_MOD_Y:
> -				*val = AS73211_SCALE_Y;
> -				break;
> -			case IIO_MOD_Z:
> -				*val = AS73211_SCALE_Z;
> -				break;
> -			default:
> -				return -EINVAL;
> -			}
> -			*val2 = as73211_integration_time_1024cyc(data) *
> -				as73211_gain(data);
> -
> -			return IIO_VAL_FRACTIONAL;
> +		case IIO_INTENSITY:
> +			return data->spec_dev->intensity_scale(data, chan->channel2,
> +							       val, val2);
>  
>  		default:
>  			return -EINVAL;
> -		}}
> +		}
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		/* f_samp is configured in CREG3 in powers of 2 (x 1.024 MHz) */
> @@ -675,13 +746,17 @@ static int as73211_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> +	data->spec_dev = i2c_get_match_data(client);
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
> @@ -771,14 +846,28 @@ static int as73211_resume(struct device *dev)
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

Tested-by: Christian Eggers <ceggers@arri.de>




