Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4DD7D2752
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJVXmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 19:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 19:42:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF607EB;
        Sun, 22 Oct 2023 16:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxrt0G0yfanFcIdR39Cf+kol9MlXegoLBM97KqyJlXdEGU8d38POSO+7LM4VpFP16/MfBip1omw1HVewm7IYj9JZR8A+PQYyUpsB2tgCaVbSCSf1XzszQ53gWHbteXS06onZRMi5gLsSqUMEeSxJ0PdpYFyccHaC1wdMEqnTMSVYCEZAjugWi2VIo4HNUjG/YTrUNk9M5e15E4n3mRUk4Mr48/zgMNI7Xzx15SmlqwBGjFHSSGWSDJZVhIzR5pZc3Sc8kr+htsyPTTYdR0OIjfIDrK561c2yWMK5UorOdEApkwsGgenwPJ7zcEfOE1fFepGlBRGdA5lgO9o1hPnNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYSZIjon3obJR5NImfs8csYl4YufIlx0ibb+0rO0t4o=;
 b=WE27MxG3sRvvD1igKlTEZWNkP7zRC6lbVqizYuVWGbliWQ/lcslLdtTNv2HDz3hkfSEvSFBEFSBy75hGQdYGbX3V9lBqk6iTgT5ZX1IzE96Hp/YukFAMEfjQZxlXvjZChk6IX4+t71ukPeT7W6ROyTqW7u+G1dz12H1bo0Yn3MxoiIDZQfTiIQ16zBBABgRu105I2zXKyBjZxJ7wFj9ZfqH4Xo4kiMSTF9jiCMCwqa8+Jv2hJGdftivINLZxHZsyM3LM4lhor/Z3KrdsJjNuiMO3gWINE/zRMg6v36dMj3z7BMYyFKUpgAdg/EQFcsfjR3vof7JjCyMzFg8INnK/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYSZIjon3obJR5NImfs8csYl4YufIlx0ibb+0rO0t4o=;
 b=hz0ySW3KbnZx0alv7u0jBA2mzo3EnWxPpIIQRgNuCtiKgBPdr37EWrd4LPhk9rp3nlv1exyzdDjvCMWHq940kKjQxXuMKYwGtU6R9t4nz+KThUpaQNnxic3ZaL7ttjKCzrDrubxmLa+RyYuCrF9Lk531f1r/2N38gRGDP2jlmEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV8PR08MB9286.namprd08.prod.outlook.com
 (2603:10b6:408:20a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Sun, 22 Oct
 2023 23:42:42 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Sun, 22 Oct 2023
 23:42:41 +0000
Date:   Sun, 22 Oct 2023 18:42:35 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <ZTWza+S+t+UZKlwu@nixie71>
References: <20231017034356.1436677-1-anshulusr@gmail.com>
 <20231017034356.1436677-2-anshulusr@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017034356.1436677-2-anshulusr@gmail.com>
X-ClientProxiedBy: SA0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:806:130::8) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV8PR08MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce787e9-6d6e-4d37-ad40-08dbd3589509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYq8npWE01ICAuikcVnpPL+5hMduBUHk/nGGVu2y6g8w2jhjW15udDGD6YOp/rq+w8pgYmlUFAdmQp2o5Pksh2BXVx0JSWnFWXPyEyQoTJsqXUiTSxmcd/5BWQXtFEGYpMdyPvWzOqexrpEcRV3vazCU+x8ux3q9j1q9mXL8+pgqNd1rv9I3fTC+SxDeFys5gxR/tcJZuPGCGxgIX9zKMWYmIMD/xIpOZY5XWfHKOZo+crR+rqXIOmbRT+jNUcJQc5EKr7W0L4TnNsz6sFWyuERl2s7/ogEM/YxdOot+VwAlNB8wvyS1d1/3TgMrcBHkUu9QhdZaZGV3GXdUzIsu3r3I0KPneqNlwt2z6K7PmZNHRnN2fpCkLkyOc6W88D4Se6yMTtV9OD+iAIUVrq257kJKZvgcE9/hhE1eO/nVI82xq8qe52m5azflknoiVSaGRfIodfSnRGuhVF5+zTw6fHSloHjOPdke+ghg07+e/8/rnxZw5wYNzWSaJ04DtPPrVWzjVc3nrNcntmvAIibTPN8sRWCCCH7jmNrbRf4shh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39830400003)(376002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33716001)(38100700002)(2906002)(30864003)(41300700001)(86362001)(7416002)(5660300002)(8676002)(8936002)(4326008)(6506007)(6666004)(478600001)(26005)(66476007)(316002)(6916009)(54906003)(66556008)(66946007)(83380400001)(66574015)(966005)(6486002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?muVj7WAtbOHizQ6OtuvWDY8XQHMpqVG0XwkxUF5FUVIb2KjJ3YGaBt0QX7?=
 =?iso-8859-1?Q?C9e680OjWBgaVieFBsCGXyklw9zCtd5OmzZfnFhUa1aiuzywTW+mIVqFZd?=
 =?iso-8859-1?Q?NKcAvXuuDGw5uLwg7pJkLXWXAmjSB+jo05UYkxY+vaOmdohcVTeGuFO8Gh?=
 =?iso-8859-1?Q?/5ch/CA6ZSv8QdgWeSiTSpi5Pn38K/59aeoy0v6mErATz902IHrYVW6hJq?=
 =?iso-8859-1?Q?mzuIlfs03vjGR2OFmDmFHVFILmRgINdoXXiilQ1gWAr9xP6MS1gy/LK6ji?=
 =?iso-8859-1?Q?DEv4/krlu9K8aculKodfYnPMtDGqiXvC19+N+/oxilHP666F7eaDkznn6W?=
 =?iso-8859-1?Q?X+BZndPbv1kR+wu2A34R5PzfsemBd62R3PED5gdhJ2VrWudvBKaFbGOarm?=
 =?iso-8859-1?Q?L7uwb9Deo6+w8vDR5BkqMt5vxdPZaNmI0cB+tU/rk2/CaT+kCuYhJIuBdF?=
 =?iso-8859-1?Q?lMliFCzExjLrWI9BaUch/Ofvs5SskGN0IQSpaNWl5DjyXJP7KnuHjfn8Tw?=
 =?iso-8859-1?Q?9e9zXLb3MUjjSwEG9N6qOkMnI0+wv6OU0SePXh+GlLDwDjqlaAZWAjB1Yw?=
 =?iso-8859-1?Q?Lqme83oCYfiACcZwUTIAsT2HyYYtjn5AGgoi0qItLlOufP15ELI7uW5Nee?=
 =?iso-8859-1?Q?SnptzuxFO1egobud329QF2zzX2U0eoKQE8xmWuquW54pfSohoKl/W0cnGx?=
 =?iso-8859-1?Q?ychiCLasxPog/iGJaJ5hQdC1T48q1e8/KtCo24pFN4KW5Jir2u87svKPwq?=
 =?iso-8859-1?Q?av3NyeDy7XFAtETVMN1Zx6BZLrsq15y7pS9hdS8Azs7cxTiTAZfUFcJ616?=
 =?iso-8859-1?Q?uGB1Xj3YGLRtWq2o+ALFkif3xMhWbQ5BA3peQaXGhSIYEoktymV14af5ZI?=
 =?iso-8859-1?Q?BrigMmmUiYhax7QbTJUEqUcncjD/SCxLXAcRdhMrTMYywWxJQwywrrAW+v?=
 =?iso-8859-1?Q?Xy4BJeGjfQFMTUNrvvP2aaF6lQntkvKM4UO981CT9O+lEt8km3UtHeWBx3?=
 =?iso-8859-1?Q?SOcY6u1NUE5heN6qbSW4rVWEPIN9GajXQ8FTMhbGilLciTcVkHnA0pfvsj?=
 =?iso-8859-1?Q?VvlZBmTP1YDiW45BtiZ6dRElYuYYjjCDVie8PpUy13ds3z6kCxcL+P63pH?=
 =?iso-8859-1?Q?gYdgw6Oz0kkrySYe49RwHC+IdYbCxx9+Ke4gCwKFDxVbJpqGFyg+1RBUi8?=
 =?iso-8859-1?Q?VerwF+GQjrt7+F0vayzT+a8FBv/B/wQxKc07np+I1foXCTM4GnSIAjHE/1?=
 =?iso-8859-1?Q?8ca00+2uBcjeDGNMst1qYYvWMoiDrhOHOVxADDMBZuwxYscy50L0UJIPAq?=
 =?iso-8859-1?Q?WeXWgp07iyaRqbOZ39/tNxHE8aMAIV6mVbueQQS7T6HquWOb2X2OY6xF94?=
 =?iso-8859-1?Q?JkBs3Tr8ugSdsDjJ0FbgUkLFDw71RrkGLraSRC1k2rb7XF1lG2OJzhPqcg?=
 =?iso-8859-1?Q?2qBAFwx5WQ0WdNd4b7MEqyeS3izKYBgV6xpP+L7lW5UPf+9vsbK0F8vx+C?=
 =?iso-8859-1?Q?rP1zLEYocIVUJEd227DvY6dBHixVHFWXgM8A+mBpw+yVR1MoTY1x2gpfEr?=
 =?iso-8859-1?Q?wLSkPlTt7u09rS/7WDLzklAdyYQ8EH3A11cKXSei92bvmBtwgadxmUH5AP?=
 =?iso-8859-1?Q?Uod5f0IhB/9HqlIVUHK4KUqg/X4LM/Qtzf?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce787e9-6d6e-4d37-ad40-08dbd3589509
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 23:42:41.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YufB4kTcIbYsOZKDBLUVmlllXDBliqdipaFez2pv+Q4qI6DIaoWZbz8ytkaWOoi9YMHGA5XnX1/7T2xTyrjPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9286
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

On Tue, Oct 17, 2023 at 09:13:45AM +0530, Anshul Dalal wrote:
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
> ---
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
>  MAINTAINERS                              |   7 +
>  drivers/input/joystick/Kconfig           |   9 +
>  drivers/input/joystick/Makefile          |   1 +
>  drivers/input/joystick/adafruit-seesaw.c | 273 +++++++++++++++++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 drivers/input/joystick/adafruit-seesaw.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c4cce45a09d..a314f9b48e21 100644
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
> index ac6925ce8366..df9cd1830b29 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -412,4 +412,13 @@ config JOYSTICK_SENSEHAT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called sensehat_joystick.
>  
> +config JOYSTICK_SEESAW
> +	tristate "Adafruit Mini I2C Gamepad with Seesaw"
> +	depends on I2C
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
> index 000000000000..2a1eae8d2861
> --- /dev/null
> +++ b/drivers/input/joystick/adafruit-seesaw.c
> @@ -0,0 +1,273 @@
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
> + */
> +
> +#include <asm-generic/unaligned.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +/* clang-format off */

I don't think we need this directive; at least, no other input drivers have
it, or really any drivers for that matter.

> +#define SEESAW_DEVICE_NAME	"seesaw-gamepad"
> +
> +#define SEESAW_STATUS_BASE	0
> +#define SEESAW_GPIO_BASE	1
> +#define SEESAW_ADC_BASE		9
> +
> +#define SEESAW_GPIO_DIRCLR_BULK	3
> +#define SEESAW_GPIO_BULK	4
> +#define SEESAW_GPIO_BULK_SET	5
> +#define SEESAW_GPIO_PULLENSET	11
> +
> +#define SEESAW_STATUS_HW_ID	1
> +#define SEESAW_STATUS_SWRST	127
> +
> +#define SEESAW_ADC_OFFSET	7
> +
> +#define BUTTON_A	5
> +#define BUTTON_B	1
> +#define BUTTON_X	6
> +#define BUTTON_Y	2
> +#define BUTTON_START	16
> +#define BUTTON_SELECT	0

Please namespace these (e.g. SEESAW_BUTTON_A) to make it clear they refer
to device-specific bits and not standard keycodes (e.g. BTN_A). In fact,
these seem better off as part of an array of structs; more on that below.

> +
> +#define ANALOG_X	14
> +#define ANALOG_Y	15

Please namespace these as well.

> +
> +#define SEESAW_JOYSTICK_MAX_AXIS	1023
> +#define SEESAW_JOYSTICK_FUZZ		2
> +#define SEESAW_JOYSTICK_FLAT		4
> +
> +#define SEESAW_GAMEPAD_POLL_INTERVAL	16
> +#define SEESAW_GAMEPAD_POLL_MIN		8
> +#define SEESAW_GAMEPAD_POLL_MAX		32
> +/* clang-format on */
> +
> +u32 BUTTON_MASK = BIT(BUTTON_A) | BIT(BUTTON_B) | BIT(BUTTON_X) |
> +		  BIT(BUTTON_Y) | BIT(BUTTON_START) | BIT(BUTTON_SELECT);
> +
> +struct seesaw_gamepad {
> +	char physical_path[32];
> +	struct input_dev *input_dev;
> +	struct i2c_client *i2c_client;
> +};
> +
> +struct seesaw_data {
> +	__be16 x;
> +	__be16 y;
> +	u8 button_a, button_b, button_x, button_y, button_start, button_select;

Please keep these each on a separate line.

> +};

Please declare this struct as __packed, as that is how it appears to be used.

> +
> +static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
> +{
> +	int err;

Please use 'ret' for return variables that can indicate a positive value on success.

> +	unsigned char write_buf[2] = { SEESAW_GPIO_BASE, SEESAW_GPIO_BULK };
> +	unsigned char read_buf[4];

Please use standard kernel type definitions (i.e. u8 in this case).

> +
> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (err < 0)
> +		return err;

You correctly return err (or rather, ret) for negative values, but you should also
check that ret matches the size of the data sent. For 0 <= ret < sizeof(writebuf),
return -EIO.

> +	err = i2c_master_recv(client, read_buf, sizeof(read_buf));
> +	if (err < 0)
> +		return err;

And here.

> +
> +	u32 result = get_unaligned_be32(&read_buf);

Please do not mix declarations and code; all declarations must be at the
top of the function.

> +
> +	data->button_a = !test_bit(BUTTON_A, (long *)&result);
> +	data->button_b = !test_bit(BUTTON_B, (long *)&result);
> +	data->button_x = !test_bit(BUTTON_X, (long *)&result);
> +	data->button_y = !test_bit(BUTTON_Y, (long *)&result);
> +	data->button_start = !test_bit(BUTTON_START, (long *)&result);
> +	data->button_select = !test_bit(BUTTON_SELECT, (long *)&result);
> +
> +	write_buf[0] = SEESAW_ADC_BASE;
> +	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_X;
> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (err < 0)
> +		return err;
> +	err = i2c_master_recv(client, (char *)&data->x, sizeof(data->x));
> +	if (err < 0)
> +		return err;

This is starting to look like a 16-bit register map. To that end, please
consider using regmap instead of open-coding each of these standard write-
then-read operations.

Using regmap would also save you the trouble of managing the endianness
yourself, as well as having to check for incomplete transfers since its
functions return zero or a negative error code only.

> +	/*
> +	 * ADC reads left as max and right as 0, must be reversed since kernel
> +	 * expects reports in opposite order.
> +	 */
> +	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(data->x);
> +
> +	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_Y;
> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (err < 0)
> +		return err;
> +	err = i2c_master_recv(client, (char *)&data->y, sizeof(data->y));
> +	if (err < 0)
> +		return err;
> +	data->y = be16_to_cpu(data->y);
> +
> +	return 0;
> +}
> +
> +static void seesaw_poll(struct input_dev *input)
> +{
> +	struct seesaw_gamepad *private = input_get_drvdata(input);
> +	struct seesaw_data data;
> +	int err;
> +
> +	err = seesaw_read_data(private->i2c_client, &data);
> +	if (err != 0) {
> +		dev_dbg(&input->dev, "failed to read joystick state: %d\n",
> +			err);

This should be dev_err_ratelimited().

> +		return;
> +	}
> +
> +	input_report_abs(input, ABS_X, data.x);
> +	input_report_abs(input, ABS_Y, data.y);
> +	input_report_key(input, BTN_EAST, data.button_a);
> +	input_report_key(input, BTN_SOUTH, data.button_b);
> +	input_report_key(input, BTN_NORTH, data.button_x);
> +	input_report_key(input, BTN_WEST, data.button_y);
> +	input_report_key(input, BTN_START, data.button_start);
> +	input_report_key(input, BTN_SELECT, data.button_select);

I think you can make this much cleaner and smaller by defining an array
of structs, each with a key code and bit position. You can then simply
iterate over the array and call input_report_key() once per element as
in the following:

struct seesaw_btn_desc {
	unsigned int code;
	unsigned int shift;
};

static const struct seesaw_btn_desc seesaw_btns[] = {
	{
		.code = BTN_EAST,
		.mask = 5,
	},
	[...]
};

And then:

	btn_status = ...;

	for (i = 0; i < ARRAY_SIZE(seesaw_btns); i++)
		input_report_key(input, seesaw_btns[i].code,
				 btn_status & seesaw_btns[i].mask);

This would also make it easier to quickly discern what keycodes are mapped
to which bits in the register.

> +	input_sync(input);
> +}
> +
> +static int seesaw_probe(struct i2c_client *client)
> +{
> +	int err;
> +	struct seesaw_gamepad *private;

I'd rather this be called something like 'seesaw' rather than private.

> +	unsigned char register_reset[] = { SEESAW_STATUS_BASE,
> +					   SEESAW_STATUS_SWRST, 0xFF };
> +	unsigned char get_hw_id[] = { SEESAW_STATUS_BASE, SEESAW_STATUS_HW_ID };
> +
> +	err = i2c_master_send(client, register_reset, sizeof(register_reset));
> +	if (err < 0)
> +		return err;
> +
> +	/* Wait for the registers to reset before proceeding */
> +	mdelay(10);
> +
> +	private = devm_kzalloc(&client->dev, sizeof(*private), GFP_KERNEL);
> +	if (!private)
> +		return -ENOMEM;
> +
> +	err = i2c_master_send(client, get_hw_id, sizeof(get_hw_id));
> +	if (err < 0)
> +		return err;
> +
> +	unsigned char hardware_id;

Same comment as earlier with regard to mixed declarations.

> +
> +	err = i2c_master_recv(client, &hardware_id, 1);
> +	if (err < 0)
> +		return err;
> +
> +	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
> +		hardware_id);
> +
> +	private->i2c_client = client;
> +	scnprintf(private->physical_path, sizeof(private->physical_path),
> +		  "i2c/%s", dev_name(&client->dev));

This seems overly complex; can we not simply set input_dev->phys to the
literal "i2c/seesaw-gamepad"? Why to copy at runtime and incur the cost
of carrying 'physical_path' throughout the life of the module?

> +	i2c_set_clientdata(client, private);
> +
> +	private->input_dev = devm_input_allocate_device(&client->dev);
> +	if (!private->input_dev)
> +		return -ENOMEM;
> +
> +	private->input_dev->id.bustype = BUS_I2C;
> +	private->input_dev->name = "Adafruit Seesaw Gamepad";
> +	private->input_dev->phys = private->physical_path;
> +	input_set_drvdata(private->input_dev, private);
> +	input_set_abs_params(private->input_dev, ABS_X, 0,
> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
> +			     SEESAW_JOYSTICK_FLAT);
> +	input_set_abs_params(private->input_dev, ABS_Y, 0,
> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
> +			     SEESAW_JOYSTICK_FLAT);
> +	input_set_capability(private->input_dev, EV_KEY, BTN_EAST);
> +	input_set_capability(private->input_dev, EV_KEY, BTN_SOUTH);
> +	input_set_capability(private->input_dev, EV_KEY, BTN_NORTH);
> +	input_set_capability(private->input_dev, EV_KEY, BTN_WEST);
> +	input_set_capability(private->input_dev, EV_KEY, BTN_START);
> +	input_set_capability(private->input_dev, EV_KEY, BTN_SELECT);

Same comment with regard to creating an array of structs, and hence only
having to call input_set_capability() from within a small loop.

> +
> +	err = input_setup_polling(private->input_dev, seesaw_poll);
> +	if (err) {
> +		dev_err(&client->dev, "failed to set up polling: %d\n", err);
> +		return err;
> +	}
> +
> +	input_set_poll_interval(private->input_dev,
> +				SEESAW_GAMEPAD_POLL_INTERVAL);
> +	input_set_max_poll_interval(private->input_dev,
> +				    SEESAW_GAMEPAD_POLL_MAX);
> +	input_set_min_poll_interval(private->input_dev,
> +				    SEESAW_GAMEPAD_POLL_MIN);
> +
> +	err = input_register_device(private->input_dev);
> +	if (err) {
> +		dev_err(&client->dev, "failed to register joystick: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Set Pin Mode to input and enable pull-up resistors */
> +	unsigned char pin_mode[] = { SEESAW_GPIO_BASE,	SEESAW_GPIO_DIRCLR_BULK,
> +				     BUTTON_MASK >> 24, BUTTON_MASK >> 16,
> +				     BUTTON_MASK >> 8,	BUTTON_MASK };
> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
> +	if (err < 0)
> +		return err;
> +	pin_mode[1] = SEESAW_GPIO_PULLENSET;
> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
> +	if (err < 0)
> +		return err;
> +	pin_mode[1] = SEESAW_GPIO_BULK_SET;
> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
> +	if (err < 0)
> +		return err;

Please configure the HW before the input device is live and being polled.

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_seesaw_match[] = {
> +	{
> +		.compatible = "adafruit,seesaw-gamepad",
> +	},
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_seesaw_match);
> +#endif /* CONFIG_OF */

Please correct me if I am wrong, but it does not seem that OF support is
required by this driver. There are no properties beyond the standard ones
understood by the I2C core, which can match based on the ID table below.

> +
> +/* clang-format off */
> +static const struct i2c_device_id seesaw_id_table[] = {
> +	{ SEESAW_DEVICE_NAME, 0 },
> +	{ /* Sentinel */ }
> +};
> +/* clang-format on */

Again, I don't see any need for these directives.

> +

Nit: unnecessary NL.

> +MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
> +
> +static struct i2c_driver seesaw_driver = {
> +	.driver = {
> +		.name = SEESAW_DEVICE_NAME,
> +		.of_match_table = of_match_ptr(of_seesaw_match),
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
> 2.42.0
> 

Kind regards,
Jeff LaBundy
