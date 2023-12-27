Return-Path: <linux-kernel+bounces-12230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259C81F1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE93283CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03047A63;
	Wed, 27 Dec 2023 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="Jp7kVIf0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4047766;
	Wed, 27 Dec 2023 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labundy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labundy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbcB105pMvB+fkGIyKUMgRmZomMBW0Qora806pqwdwAxvyLajJnkjsKwKgA7FIzgEdhDTM4uNO22+iN7C6m/QgVzy6n0469JDQo1FE4THiaJlJRXMBPK5jplgRWus1osFAB9X1nVPBqRHGhN7OaaG3/uXLcBueMaSuoEVvDTxrqO2iifP0AEgY6XaVMSsYJRZs6pTQvvDJcgOBj182BoSfqeQItoISkPh3U3euQl52TQE+3LC1fUf74HR/3ca8YILls17sG29+uVnSE0keGwPZdICv1/gluSPdPcBJdB5TSh8b5FtbCFW795DRGNAjUqn66kU2uQ8TLBIp8Y+61Pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHAiy6MzEZo9opkSRZU3EwfpaAYsSbi5qUUFiidW6mA=;
 b=hm+UzsIIkINBBYYBcT9io5fCMbwv6BBBPw5aLAc/wsjq6oeI1oC+KmiSgXBtZntKR+7dLCBfxyrXhsHhAH2JoP486OAJPRbBUInFxyYmG5mMIrJ19/BkSivRLxU0W1Ov4wfAmhAwotQCz75pmAlNVZP6Az5/NWT5pjSX7oeKI/X5ZBr/faS+jZdAu9we0p/IBTouik+X4BLrKbBRgv65nKi+6JITMeUF8EjTHCpJYWjcpMs2GmFIBJmDmm3zpqFHlgEDlyGdogi5pw8SpsVdRjilSXCPUPq5kxuWM8mg/PUJpWaVm9glo37eGul5XQu1cd8AoIt8RaAI6iK/uk/vRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHAiy6MzEZo9opkSRZU3EwfpaAYsSbi5qUUFiidW6mA=;
 b=Jp7kVIf0OHTWMQYDy2lnm1wYNlT0leTTQhK+HcW3feJbErC2McSBhYCqasKVxKe+tANBCi9hZ6KeLslmKletP6yBnegqOU2IsJwOfagA71zjMtDS5uW4ecNMCyzYYgQVFdPZUhpVeR12r5wZKKX8HbvWyr0DciSKUBkUIz3ULKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DS0PR08MB9304.namprd08.prod.outlook.com
 (2603:10b6:8:1b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.17; Wed, 27 Dec
 2023 19:43:13 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7159.006; Wed, 27 Dec 2023
 19:43:13 +0000
Date: Wed, 27 Dec 2023 13:43:05 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RESEND v11 2/2] input: joystick: driver for Adafruit
 Seesaw Gamepad
Message-ID: <ZYx+SeaWi1AG2ryN@nixie71>
References: <20231215031125.284939-1-anshulusr@gmail.com>
 <20231215031125.284939-2-anshulusr@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215031125.284939-2-anshulusr@gmail.com>
X-ClientProxiedBy: SN7PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:806:f3::15) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DS0PR08MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc394ee-c301-4eec-b377-08dc07140fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XEo5Tbp/Z1YflgkyrMLPux8D3Cwkkc5StfXPTCERI7HbV1irmmcW1TDziepX5LlYj/84lNFYe9u/TCg6IQz5uZmvIplps9lk46W7dTkrUEawboRpwl/oGjxYrDG/PRPOu2UbGlMlRvzzEyTJh0fxmHDZWgKCY2s3J2hymKQwjSaqN1nnArvWisIJe7K6XMVe0kIkdc/rPsHJQXbe6yjHejeUHkomsD7Wmo9PCiFbDLRWvWcnLeUWjYR2gmiyj+sc1xVoamdq7HKWldsfby8tc8G4gj+6mBOqbl0ra7wAagIhrTL6c03ngR4RLz0wbcYandLGMVZli/6z0d9UE4AY7VHsKCQiDnfePAIdZM4S/jyCyQ08BjJGcjfgIVoPNX9R9bcqt5AM/hoGQQGasCxmo6DQDeOoqSDMz9fFBq8Zjhp5DFDka5g6Q/nWb4EbVMyUHXD8ZzLhBXgw8/fdBKVfu1yt1XciRbkPJ6NEJ+DTZxtupHBSxPwK53rp4bgB8Op6gAls90aphqCVkApPrDRnWawKPABWt4XAlqgPsz2DRvuusfTMDZ0RkYn5T012KC/Vn1HDjUnrlot8Qhv6kPLyW4g0+x9HPO4V65dfMOHJJ1YfVSpucYkjE2AdSi4Eg7175PETcN5eDHGeB1hL8zhEow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39830400003)(136003)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(66574015)(30864003)(86362001)(83380400001)(38100700002)(66946007)(41300700001)(6486002)(66476007)(66556008)(6916009)(2906002)(5660300002)(26005)(7416002)(6512007)(9686003)(966005)(8676002)(8936002)(478600001)(6666004)(33716001)(54906003)(316002)(4326008)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1RejJgpJGY/q3MqFp4DhjMyB4H65Zf5GjP3WkruDUPPc3afXV5aUKSoje3?=
 =?iso-8859-1?Q?iAhv+Q9f5afqw8kCEUELZfMOCQi9W+NrH7shpHa5Yf8T2iX6raoLB2+291?=
 =?iso-8859-1?Q?NXvp04D4836Hn6ymI/fMq9veEQVWysUsk1JRL33AC6H17EvI8MxfxtYkHD?=
 =?iso-8859-1?Q?zgrAVpqzEFHqk+khFpaSBi3FXvg2KI0AaaaMoDTVsPPHo2fvqGXOq2A30B?=
 =?iso-8859-1?Q?i2Bd0cNUiWWXaWewLSJEOTEDlVtJ/altQCbly6+aN9iyN04OItxQaniNmF?=
 =?iso-8859-1?Q?zmsnlUO/1jrOX6im4Ixf56zTm9p/FMWW45R+ORg1bDRVZcmqv+E0svKntn?=
 =?iso-8859-1?Q?VLZHyH3jEtHQyEeS9BsX1ypVCzRVhujJVB1fm6p2TxH4TwhZxhgGCE2ouT?=
 =?iso-8859-1?Q?t2GIEUqH3LD6mbg+THu0N7Zrx8Z2193sLP64eHp4CbX6PDzIjwsKKCvSLi?=
 =?iso-8859-1?Q?M9e/IVwUOxdiRrFLjPXHqFi0WZhzWKz4tmMWxBMhlHsWaGzUybcjzjYlbS?=
 =?iso-8859-1?Q?W0yv/vR/epd9MB/8p4ktcHF+/6zkBHm9Kh1jhw3R5olmWC0ln5IaQ1VKQT?=
 =?iso-8859-1?Q?Lp8Z/ihTUiHCuKOniIoySyveJU5PXSIRw3tA8kM7f6i0vaLRqlKaxF7r+5?=
 =?iso-8859-1?Q?Ifs174JSMV8GCFpNC/25kcsmaaIeGK75wpBJr/G4D5II7y6Ia9UltB/IJe?=
 =?iso-8859-1?Q?Pn7T1ry5Jqxf+ZTUe2fX5r5MUM3u2G+Y/lqG5i5vcwBCOvWbGVX8Tl0R4w?=
 =?iso-8859-1?Q?XrpX7jsYWPbQ2jrUeWgWQTxRmsHJ9nU+zed9Jz92WnN7Hiku8rQJ7GZkOW?=
 =?iso-8859-1?Q?K9Xlh3g6Y9KtqeCUjyHI4P7By7ubgyY6y+f9rrm00VzLu6z0rfREp9rk3C?=
 =?iso-8859-1?Q?9tiI5viER/yPaAwI6/Xe9AsA5O/j/55U9ZIckMmHwP5IFXiMm0Xab2bR+l?=
 =?iso-8859-1?Q?Y8W6bLuFTOZq0sBVrgKGrPcMsuf+BcL2odaBdfao3JoOY3zi2UOknlyiv0?=
 =?iso-8859-1?Q?vaTK4kajJHl1Fx89g6TbhOkss/8SkSUimYbXmcCdbVLZYtKwG1LRWvoSjy?=
 =?iso-8859-1?Q?JPGJ2t7BcfVgtmzNwGP/4x/jt37R2SNjstLBLuRxKgPjHtgOSTsWr518iK?=
 =?iso-8859-1?Q?m5zJ57HWubSklE2ysUS2dh0wAkGU47XbUSwir5PpAOzG9IzeptpxfLRF3l?=
 =?iso-8859-1?Q?ogNLJ+i6bZTOquhJLt4+PL/mocIVnQAGcz7BsCQwYUKygBUI8eT7QDl+to?=
 =?iso-8859-1?Q?9KnRI6pEc+kNeO8CIPjzsbHwB8i7MSq4NxTE+SiY/WkjIArI+6PT6yftD0?=
 =?iso-8859-1?Q?a1enSQNgklBnDsxskCgrRq+aey4pkUOLkC7UgywSjICUjFImYqSFw4xCW/?=
 =?iso-8859-1?Q?/8J2bpKF89Mwy3e6Ycmu9AHYY7RR9qa/gqbJkcNbHIe0nPbKfLTXxceSDU?=
 =?iso-8859-1?Q?KwXGIyzm700XI0+XySNx+tqUUSnCFmxZ84S4dhmlBpx6HPxrYgS+f4Yvgj?=
 =?iso-8859-1?Q?ZEriwEpXb2hwlSP9s+Mmn8osQNTN+Qbbq1UU/CPafJrWCmISASqMfdny5z?=
 =?iso-8859-1?Q?1oZuDkZ+f2urdkRC2FYCuxOhAdnFEXe4Gk1+Ts0Xh4gxIwn5rWVrmQu1Lk?=
 =?iso-8859-1?Q?UkBDdeV8V/W5yxCi6KvrnVEHPfdX+8qJ5H?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc394ee-c301-4eec-b377-08dc07140fe3
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 19:43:13.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27bfYvlC98BDRaVPumxUv2bAfqJksYKZwDchxX5fOCpopSnaYBKN2mWlziVc8FO4WPXElE9FXIWQD3KbvWlH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB9304

Hi Anshul,

Looking great so far, just a few more comments.

On Fri, Dec 15, 2023 at 08:41:23AM +0530, Anshul Dalal wrote:
> Adds a driver for a mini gamepad that communicates over i2c, the gamepad
> has bidirectional thumb stick input and six buttons.
> 
> The gamepad chip utilizes the open framework from Adafruit called 'Seesaw'
> to transmit the ADC data for the joystick and digital pin state for the
> buttons. I have only implemented the functionality required to receive the
> thumb stick and button state.
> 
> Steps in reading the gamepad state over i2c:
>   1. Reset the registers
>   2. Set the pin mode of the pins specified by the `BUTTON_MASK` to input
>       `BUTTON_MASK`: A bit-map for the six digital pins internally
>        connected to the joystick buttons.
>   3. Enable internal pullup resistors for the `BUTTON_MASK`
>   4. Bulk set the pin state HIGH for `BUTTON_MASK`
>   5. Poll the device for button and joystick state done by:
>       `seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)`
> 
> Product page:
>   https://www.adafruit.com/product/5743
> Arduino driver:
>   https://github.com/adafruit/Adafruit_Seesaw
> 
> Driver tested on RPi Zero 2W
> 
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> ---
> 
> Changes for v11:
> - Removed `of_match_ptr` to prevent warning:
>   'seesaw_of_table' defined but not used
>   on non OF platforms
> 
> Changes for v10:
> - no updates
> 
> Changes for v9:
> - Added of_device_id
> 
> Changes for v8:
> - Updated invalid references to `adafruit_seesaw` to `adafruit-seesaw`
> 
> Changes for v7:
> adafruit-seesaw.c
> - Fixed formatting for macro definitions
> - Made SEESAW_BUTTON_MASK static const
> - Removed __be16 type for x and y fields of seesaw_data
> - Used sparse_keymap implementation instead of custom keymap
> - Used i2c_msg instead of i2c_master_send and recv in
>   seesaw_register_read
> - Use temporary variable `adc_data` to store data received from ADC
> - Changed read_buf from u8[4] to __be32
> - Use usleep_range instead of msleep
> - Removed 'Reviewed-by: Thomas Weiﬂschuh' due to large number of changes
>   since last review
> Kconfig:
> - Added `select INPUT_SPARSEKMAP`
> 
> Changes for v6:
> - Added TODO
> - Removed `clang-format` directives
> - Namespaced device buttons
> - Removed `char physical_path[32]` field from `struct seesaw_gamepad`
> - Added `packed` attribute to `struct seesaw_data`
> - Moved from having booleans per button to single `u32 button_state`
> - Added `seesaw_button_description` array to directly associate device
>   buttons with respective keycodes
> - Added wrapper functions `seesaw_register_` around `i2c_master_` API
> - Ratelimited input error reporting with `dev_err_ratelimited`
> - Removed `of_device_id`
> 
> Changes for v5:
> - Added link to the datasheet
> - Added debug log message when `seesaw_read_data` fails
> 
> Changes for v4:
> - Changed `1UL << BUTTON_` to BIT(BUTTON_)
> - Removed `hardware_id` field from `struct seesaw_gamepad`
> - Removed redundant checks for the number of bytes written and received by
>   `i2c_master_send` and `i2c_master_recv`
> - Used `get_unaligned_be32` to instantiate `u32 result` from `read_buf`
> - Changed  `result & (1UL << BUTTON_)` to
>   `test_bit(BUTTON_, (long *)&result)`
> - Changed `KBUILD_MODNAME` in id-tables to `SEESAW_DEVICE_NAME`
> - Fixed formatting issues
> - Changed button reporting:
>     Since the gamepad had the action buttons in a non-standard layout:
>          (X)
>       (Y)   (A)
>          (B)
>     Therefore moved to using generic directional action button event codes
>     instead of BTN_[ABXY].
> 
> Changes for v3:
> - no updates
> 
> Changes for v2:
> adafruit-seesaw.c:
> - Renamed file from 'adafruit_seesaw.c'
> - Changed device name from 'seesaw_gamepad' to 'seesaw-gamepad'
> - Changed count parameter for receiving joystick x on line 118:
>     `2` to `sizeof(write_buf)`
> - Fixed invalid buffer size on line 123 and 126:
>     `data->y` to `sizeof(data->y)`
> - Added comment for the `mdelay(10)` on line 169
> - Changed inconsistent indentation on line 271
> Kconfig:
> - Fixed indentation for the help text
> - Updated module name
> Makefile:
> - Updated module object file name
> MAINTAINERS:
> - Updated file name for the driver and bindings
> 
> Previous versions:
> v11: https://lore.kernel.org/lkml/20231127161158.1651716-2-anshulusr@gmail.com/
> v10: https://lore.kernel.org/lkml/20231121123409.2231115-2-anshulusr@gmail.com/
> v9: https://lore.kernel.org/lkml/20231121101751.2189965-2-anshulusr@gmail.com/
> v8: https://lore.kernel.org/lkml/20231108005337.45069-2-anshulusr@gmail.com/
> v7: https://lore.kernel.org/lkml/20231106164134.114668-2-anshulusr@gmail.com/
> v6: https://lore.kernel.org/lkml/20231027051819.81333-2-anshulusr@gmail.com/
> v5: https://lore.kernel.org/lkml/20231017034356.1436677-2-anshulusr@gmail.com/
> v4: https://lore.kernel.org/lkml/20231010184827.1213507-2-anshulusr@gmail.com/
> v3: https://lore.kernel.org/linux-input/20231008185709.2448423-2-anshulusr@gmail.com/
> v2: https://lore.kernel.org/linux-input/20231008172435.2391009-2-anshulusr@gmail.com/
> v1: https://lore.kernel.org/linux-input/20231007144052.1535417-2-anshulusr@gmail.com/
> ---
>  MAINTAINERS                              |   7 +
>  drivers/input/joystick/Kconfig           |  10 +
>  drivers/input/joystick/Makefile          |   1 +
>  drivers/input/joystick/adafruit-seesaw.c | 318 +++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 drivers/input/joystick/adafruit-seesaw.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81d5fc0bba68..b3f101edc24b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -441,6 +441,13 @@ W:	http://wiki.analog.com/AD7879
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/input/touchscreen/ad7879.c
>  
> +ADAFRUIT MINI I2C GAMEPAD
> +M:	Anshul Dalal <anshulusr@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
> +F:	drivers/input/joystick/adafruit-seesaw.c
> +
>  ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
>  M:	Jiri Kosina <jikos@kernel.org>
>  S:	Maintained
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index ac6925ce8366..7755e5b454d2 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -412,4 +412,14 @@ config JOYSTICK_SENSEHAT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called sensehat_joystick.
>  
> +config JOYSTICK_SEESAW
> +	tristate "Adafruit Mini I2C Gamepad with Seesaw"
> +	depends on I2C
> +	select INPUT_SPARSEKMAP
> +	help
> +	  Say Y here if you want to use the Adafruit Mini I2C Gamepad.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called adafruit-seesaw.
> +
>  endif
> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
> index 3937535f0098..9976f596a920 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)		+= n64joy.o
>  obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
>  obj-$(CONFIG_JOYSTICK_PXRC)		+= pxrc.o
>  obj-$(CONFIG_JOYSTICK_QWIIC)		+= qwiic-joystick.o
> +obj-$(CONFIG_JOYSTICK_SEESAW)		+= adafruit-seesaw.o
>  obj-$(CONFIG_JOYSTICK_SENSEHAT)	+= sensehat-joystick.o
>  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
> diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
> new file mode 100644
> index 000000000000..0f4a54c9519e
> --- /dev/null
> +++ b/drivers/input/joystick/adafruit-seesaw.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
> + *
> + * Driver for Adafruit Mini I2C Gamepad
> + *
> + * Based on the work of:
> + *	Oleh Kravchenko (Sparkfun Qwiic Joystick driver)
> + *
> + * Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
> + * Product page: https://www.adafruit.com/product/5743
> + * Firmware and hardware sources: https://github.com/adafruit/Adafruit_Seesaw
> + *
> + * TODO:
> + *	- Add interrupt support
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#define SEESAW_DEVICE_NAME	     "seesaw-gamepad"
> +
> +#define SEESAW_STATUS_BASE	     0x00
> +#define SEESAW_GPIO_BASE	     0x01
> +#define SEESAW_ADC_BASE		     0x09
> +
> +#define SEESAW_GPIO_DIRCLR_BULK	     0x03
> +#define SEESAW_GPIO_BULK	     0x04
> +#define SEESAW_GPIO_BULK_SET	     0x05
> +#define SEESAW_GPIO_PULLENSET	     0x0b
> +
> +#define SEESAW_STATUS_HW_ID	     0x01
> +#define SEESAW_STATUS_SWRST	     0x7f
> +
> +#define SEESAW_ADC_OFFSET	     0x07
> +
> +#define SEESAW_BUTTON_A		     0x05
> +#define SEESAW_BUTTON_B		     0x01
> +#define SEESAW_BUTTON_X		     0x06
> +#define SEESAW_BUTTON_Y		     0x02
> +#define SEESAW_BUTTON_START	     0x10
> +#define SEESAW_BUTTON_SELECT	     0x00
> +
> +#define SEESAW_ANALOG_X		     0x0e
> +#define SEESAW_ANALOG_Y		     0x0f
> +
> +#define SEESAW_JOYSTICK_MAX_AXIS     1023
> +#define SEESAW_JOYSTICK_FUZZ	     2
> +#define SEESAW_JOYSTICK_FLAT	     4
> +
> +#define SEESAW_GAMEPAD_POLL_INTERVAL 16
> +#define SEESAW_GAMEPAD_POLL_MIN	     8
> +#define SEESAW_GAMEPAD_POLL_MAX	     32

Normally we want to include units in #defines that represent actual units,
e.g. SEESAW_GAMEPAD_POLL_INTERVAL_MS.

> +
> +#define MSEC_PER_USEC		     1000

I think you meant USEC_PER_MSEC here, which is already defined. But I think
you should just drop it entirely; more on that below.

> +
> +static const u32 SEESAW_BUTTON_MASK =
> +	BIT(SEESAW_BUTTON_A) | BIT(SEESAW_BUTTON_B) | BIT(SEESAW_BUTTON_X) |
> +	BIT(SEESAW_BUTTON_Y) | BIT(SEESAW_BUTTON_START) |
> +	BIT(SEESAW_BUTTON_SELECT);
> +
> +struct seesaw_gamepad {
> +	struct input_dev *input_dev;
> +	struct i2c_client *i2c_client;
> +};
> +
> +struct seesaw_data {
> +	u16 x;
> +	u16 y;
> +	u32 button_state;
> +};
> +
> +static const struct key_entry seesaw_buttons_new[] = {
> +	{ KE_KEY, SEESAW_BUTTON_A, .keycode = BTN_SOUTH },
> +	{ KE_KEY, SEESAW_BUTTON_B, .keycode = BTN_EAST },
> +	{ KE_KEY, SEESAW_BUTTON_X, .keycode = BTN_NORTH },
> +	{ KE_KEY, SEESAW_BUTTON_Y, .keycode = BTN_WEST },
> +	{ KE_KEY, SEESAW_BUTTON_START, .keycode = BTN_START },
> +	{ KE_KEY, SEESAW_BUTTON_SELECT, .keycode = BTN_SELECT },
> +	{ KE_END, 0 }
> +};
> +
> +static int seesaw_register_read(struct i2c_client *client, u8 register_high,
> +				u8 register_low, char *buf, int count)
> +{
> +	int ret;
> +	u8 register_buf[2] = { register_high, register_low };
> +

This method of passing "high" and "low" 8-bit registers is unnatural. It
seems this device effectively has a 16-bit register map, so this function
should simply accept a u16 for the register address, and then declare the
following:

	__be16 register_buf = cpu_to_be16(register);

Finally, just #define all the register addresses to fit this model instead
of splitting them into a base and offset as the Arduino code appears to do.
For example, the GPIO registers would look like the following:

#define SEESAW_GPIO_BULK	     0x0104
#define SEESAW_GPIO_BULK_SET	     0x0105
#define SEESAW_GPIO_PULLENSET	     0x010b

It seems the ADC and STATUS groups can follow suit as well.

> +	struct i2c_msg message_buf[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags,
> +			.len = sizeof(register_buf),
> +			.buf = register_buf,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags | I2C_M_RD,
> +			.len = count,
> +			.buf = buf,

You shouldn't burden all callers of seesaw_register_read() with having to cast
their data values to (char *) outside of this function; it defeats the purpose
of having a helper. Please redefine buf as a *void, then do the following here:

			.buf = (u8 *)&buf,

> +		},
> +	};

Please add a newline between declarations and code.

> +	ret = i2c_transfer(client->adapter, message_buf,
> +			   ARRAY_SIZE(message_buf));
> +

Nit: extraneous newline.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int seesaw_register_write_u8(struct i2c_client *client, u8 register_high,
> +				    u8 register_low, u8 value)
> +{
> +	int ret;
> +	u8 write_buf[3] = { register_high, register_low, value };

Same idea here. Simply accept a u16 for the register address, and then do
the following:

	put_unaligned_be16(register, write_buf);
	write_buf[sizeof(register)] = value;

> +
> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int seesaw_register_write_u32(struct i2c_client *client,
> +				     u8 register_high, u8 register_low,
> +				     u32 value)
> +{
> +	int ret;
> +	u8 write_buf[6] = { register_high, register_low };
> +
> +	put_unaligned_be32(value, write_buf + 2);

And here:

        put_unaligned_be16(register, write_buf);
	put_unaligned_be32(value, sizeof(register));

> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
> +{
> +	int ret;
> +	__be16 adc_data;
> +	__be32 read_buf;
> +
> +	ret = seesaw_register_read(client, SEESAW_GPIO_BASE, SEESAW_GPIO_BULK,
> +				   (char *)&read_buf, sizeof(read_buf));
> +	if (ret)
> +		return ret;

Normally in the input subsystem, we use 'error' for return values that can only
be zero (success) or a negative error code (failure). Here, we have a mix of 'ret'
and 'err'. It's fine to use 'ret' for the above calls to i2c_* API, but please
use 'error' for the rest.

> +
> +	data->button_state = ~be32_to_cpu(read_buf);
> +
> +	ret = seesaw_register_read(client, SEESAW_ADC_BASE,
> +				   SEESAW_ADC_OFFSET + SEESAW_ANALOG_X,
> +				   (char *)&adc_data, sizeof(adc_data));
> +	if (ret)
> +		return ret;
> +	/*
> +	 * ADC reads left as max and right as 0, must be reversed since kernel
> +	 * expects reports in opposite order.
> +	 */
> +	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(adc_data);
> +
> +	ret = seesaw_register_read(client, SEESAW_ADC_BASE,
> +				   SEESAW_ADC_OFFSET + SEESAW_ANALOG_Y,
> +				   (char *)&adc_data, sizeof(adc_data));
> +	if (ret)
> +		return ret;
> +	data->y = be16_to_cpu(adc_data);
> +
> +	return 0;
> +}
> +
> +static void seesaw_poll(struct input_dev *input)
> +{
> +	int err, i;
> +	struct seesaw_gamepad *private = input_get_drvdata(input);
> +	struct seesaw_data data;
> +
> +	err = seesaw_read_data(private->i2c_client, &data);
> +	if (err) {
> +		dev_err_ratelimited(&input->dev,
> +				    "failed to read joystick state: %d\n", err);
> +		return;
> +	}
> +
> +	input_report_abs(input, ABS_X, data.x);
> +	input_report_abs(input, ABS_Y, data.y);
> +
> +	for_each_set_bit(i, (long *)&SEESAW_BUTTON_MASK,
> +			 BITS_PER_TYPE(SEESAW_BUTTON_MASK)) {
> +		if (!sparse_keymap_report_event(
> +			    input, i, data.button_state & BIT(i), false)) {

This line break is difficult to read; please include at least one variable
on top, like the following:

		if (!sparse_keymap_report_event(input, i,
						data.button_state & BIT(I),
						false))
			dev_err_ratelimited(...);

Note that curly braces are not required here.

> +			dev_err_ratelimited(&input->dev,
> +					    "failed to report keymap event");
> +		};
> +	}
> +
> +	input_sync(input);
> +}
> +
> +static int seesaw_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	u8 hardware_id;
> +	struct seesaw_gamepad *seesaw;
> +
> +	ret = seesaw_register_write_u8(client, SEESAW_STATUS_BASE,
> +				       SEESAW_STATUS_SWRST, 0xFF);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for the registers to reset before proceeding */
> +	usleep_range(10 * MSEC_PER_USEC, 15 * MSEC_PER_USEC);

It's perfectly fine, and quite common, to simply write these out as 10000
and 15000.

> +
> +	seesaw = devm_kzalloc(&client->dev, sizeof(*seesaw), GFP_KERNEL);
> +	if (!seesaw)
> +		return -ENOMEM;
> +
> +	ret = seesaw_register_read(client, SEESAW_STATUS_BASE,
> +				   SEESAW_STATUS_HW_ID, &hardware_id,
> +				   sizeof(hardware_id));
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
> +		hardware_id);
> +
> +	/* Set Pin Mode to input and enable pull-up resistors */
> +	ret = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
> +					SEESAW_GPIO_DIRCLR_BULK,
> +					SEESAW_BUTTON_MASK);
> +	if (ret)
> +		return ret;
> +	ret = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
> +					SEESAW_GPIO_PULLENSET,
> +					SEESAW_BUTTON_MASK);
> +	if (ret)
> +		return ret;
> +	ret = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
> +					SEESAW_GPIO_BULK_SET,
> +					SEESAW_BUTTON_MASK);
> +	if (ret)
> +		return ret;
> +
> +	seesaw->i2c_client = client;
> +	seesaw->input_dev = devm_input_allocate_device(&client->dev);
> +	if (!seesaw->input_dev)
> +		return -ENOMEM;
> +
> +	seesaw->input_dev->id.bustype = BUS_I2C;
> +	seesaw->input_dev->name = "Adafruit Seesaw Gamepad";
> +	seesaw->input_dev->phys = "i2c/" SEESAW_DEVICE_NAME;
> +	input_set_drvdata(seesaw->input_dev, seesaw);
> +	input_set_abs_params(seesaw->input_dev, ABS_X, 0,
> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
> +			     SEESAW_JOYSTICK_FLAT);
> +	input_set_abs_params(seesaw->input_dev, ABS_Y, 0,
> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
> +			     SEESAW_JOYSTICK_FLAT);
> +
> +	ret = sparse_keymap_setup(seesaw->input_dev, seesaw_buttons_new, NULL);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"failed to set up input device keymap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = input_setup_polling(seesaw->input_dev, seesaw_poll);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to set up polling: %d\n", ret);
> +		return ret;
> +	}
> +
> +	input_set_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_INTERVAL);
> +	input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MAX);
> +	input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MIN);
> +
> +	ret = input_register_device(seesaw->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to register joystick: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id seesaw_id_table[] = {
> +	{ SEESAW_DEVICE_NAME },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
> +
> +static const struct of_device_id seesaw_of_table[] = {
> +	{ .compatible = "adafruit,seesaw-gamepad"},
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, seesaw_of_table);
> +
> +static struct i2c_driver seesaw_driver = {
> +	.driver = {
> +		.name = SEESAW_DEVICE_NAME,
> +		.of_match_table = seesaw_of_table,
> +	},
> +	.id_table = seesaw_id_table,
> +	.probe = seesaw_probe,
> +};
> +module_i2c_driver(seesaw_driver);
> +
> +MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
> +MODULE_DESCRIPTION("Adafruit Mini I2C Gamepad driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

Kind regards,
Jeff LaBundy

