Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A187819F7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjHSOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjHSOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:21:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2090.outbound.protection.outlook.com [40.107.104.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4DB61B7;
        Sat, 19 Aug 2023 07:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7cKLTfxNOGrRmWEVOzBt/7rDu7fBBQN3UrFa5Rg8VHLdm09KPof0WFepEuXqG+5SrdUZxNU22JMsCr5mI18kp4vo6Trq7h4YKrTyin4OZD9f0GUJwdnti8RIHpTSDKR7rbrLt6YZpy1qPcRqPU4oGaFySl3xuRo7VlZzaYF5ujBb+FIWT8DLCjvtnzRrhZZJ2ijBCJZnCkaKSIXC8zPzruotNRmFum1LVavVU0hTkVjXMChRsrutMF6kP2rJskiu+JsFh+0rS/eOkqkkONEoJH+SBXlNOu9DyHmOwt8qXatmfLTut2xleKkg7aaFLZ1Gm3mzXQ8tlQ9prDDx47Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJMy2Sce3yrwZJG/wHOr9TCoPKR7+1buDtVy3mmAfNw=;
 b=WaSN0I3IsaueRBMIhGhvPKW0v2Sb3mtpLB9DeE8Aqed4YQ3aelle1zXhM45MRXXxaLsUzXD00JtJw1F2cCloyMasc3Jp5gLbywdxaUtbnhdx5R3nIXgFRlY8a3hsUF70ds4G7so9Cb+cXeOXEqKouc+zCFRMKxOWlLT+DGLw5jPCHfJ5LZ80qI8AegmEV33GxfGViS4uuZgoTEA54IjNZcGf0rWF9mUqfeznhW06yq40w1v3IW3LYNdJxUl6Hbe+EoLqJWDxRdB7LoKSIGmoCQ7YBjqTo2Lv6vQlD8idD8/XXkEIYjQOTVeQ/9uP9Y6RAatiXAUjJHR+kjnKWrAuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJMy2Sce3yrwZJG/wHOr9TCoPKR7+1buDtVy3mmAfNw=;
 b=PsGohbLi4yCwj31lNAqN2qxIawtRmEDXdRMAaO6dQq2OdeFwXBiJp9Ff2vpvGgTrE6mToWAtX7GbXfpgiC8plGYqQX4jYJ7Ov1hDsKXqqv/Ano3KlCz0lY+lCKhbsYlJPm4nEGn+UEk86YMi7zKWRQ6eqCZeUftwQtP1kesVgSY=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Sat, 19 Aug
 2023 14:20:32 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 14:20:32 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Henry Shi <henryshi2018@gmail.com>
CC:     "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZ0erQKIGuJyMiIEioe7g7XMHTza/xkQCAgAAWSwA=
Date:   Sat, 19 Aug 2023 14:20:32 +0000
Message-ID: <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230818154341.20553-1-henryshi2018@gmail.com>
 <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net>
In-Reply-To: <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|PAXPR04MB8943:EE_
x-ms-office365-filtering-correlation-id: 5851f69f-dfdb-4ec6-b3d8-08dba0bf7288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdVMOQ13Diblafwisp/r1k9A1Ed83pANetlkcjcwounjrqp5S1iNe2gmAu4ghQ2r6yJth250FGSH/7J/3UyRzbVtgTJeJVPADcIo8173KHHxwAjfGs3xZEqCGvAJCCtVBcWrqTkvsPFIAgw2aUF9Bc7CqpwhFjgWlflES1vEubbv/kgF9Wkemy5hTXWtkT7cFFPq7RH6Nr0m5hQxpHg2OBLapfyaTWOtFAFN1GCK6trumwwYAORgUOenl0qj56qsnSKo4BDPt5lXCMMXfYMOetap3UP9YPqbq1oSFz3zf8VPI5Rzo9+hhqKXwsslxh1CjzbJsc9EMptDoYhNXOTHp0e9dn7BxCJmY/PQXLWQSGvCZx/HvKPuABoF9wc/YuaT1V2xnJSw100bCO8gsqCLzgeVCCwF2DjNnw6kU7KAnCe6xfG41EPa1FO1ATXzKnC09/HJGEUoQWxdk3y26vfD7KY0wl6Ikyp/vlNy4GFSicgqfyRHxmRVeDmZiMoP06TcPX19OcEGyBQAVqZqdC0aj9nbGqaKzbSjiY2i8WsIZDo8+nQ1hjohkK65Dj02FXtkqwH0vWmqngvpkf4HNszTX0Yg7Aa2jH/Oo9oERANJBBQNnJQguM62VnptxyMas/5A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39840400004)(366004)(1800799009)(451199024)(186009)(4326008)(7416002)(122000001)(71200400001)(45080400002)(478600001)(86362001)(41300700001)(8936002)(52536014)(8676002)(38070700005)(38100700002)(66476007)(66946007)(64756008)(55016003)(110136005)(316002)(107886003)(2906002)(33656002)(83380400001)(54906003)(5660300002)(66446008)(9686003)(66556008)(53546011)(6506007)(7696005)(76116006)(30864003)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YBQ9e81tLcAOsq8mPdEut/B0lsaLLlQD/dFhVY8wzskJHsgZOXlYL28Ui5kG?=
 =?us-ascii?Q?+VF+uNkhrRjLsHSp3+eSWrYnFBC7eLEm/C9q3U1CdyFGrGaTMCpIALjmjCV+?=
 =?us-ascii?Q?60li++YOIY/TbJxsdG8DKP0wsQq3yzgTjqVx7VwZ0wnoIWvcr/a/16zc7xQ2?=
 =?us-ascii?Q?TDUsIYVsJcvoNF7Z4ZQlAYPLURv2ojR/c80pbkwEYIednLprI9TTYJTJsWQ/?=
 =?us-ascii?Q?4OuZ6dsF2tZT6dZ1dzcw0IFi8faBEm8eq2iIzoBK6Js7uzqfCxEsK1X1f+uT?=
 =?us-ascii?Q?Xp239pTvCcWGrqKBnfptQThbJeajmuU/aPb8ksU3Km6XwRNchq/aflco8pd2?=
 =?us-ascii?Q?NPogXe5sqBIeamtQkUt5LlpX9vNk6sI8APewsOlG8IzNX4H+ztU6jX/yShTG?=
 =?us-ascii?Q?9V9VLx1/wm3z01m9Qm2GF9BzGg2QLQyJW9EzCsjRHhJL+/08RepvaoZA8qlR?=
 =?us-ascii?Q?KUa3HgzFDXioSWvol6zEWTxdFCIFef9QXLUrJxnD8m6/ZLxesGiBWXVvL2ok?=
 =?us-ascii?Q?ZHjGlDi6oqgNOwsnl5ffcPL/UgOBc2wW2Sm1gkJ6eghZKaIQkhVNvzikF3+J?=
 =?us-ascii?Q?ykIaW99vpnJLVVseqws9JJRLCedZtndsXks9mtr+0fSprzwDFl4zi5iVpcbn?=
 =?us-ascii?Q?PfGeixrnZBc1GAG2PRrePyiNrMv+hQKPGN5zVpNcckzgCAn5/IMumBgrlZrh?=
 =?us-ascii?Q?1b20nKKhnZLyHmRRgxib37taI4/MeOqKdRw/uS8RoBx0LRD/YMCfu6Jnjexn?=
 =?us-ascii?Q?z+dFE01F4NiICDP/fk1emq+Lh+reKSfdtdcAo2lcY/6YZELzDXdm1NMcEBEB?=
 =?us-ascii?Q?Tu0WzLIJPMXuNzoUHZYXg9lop2nmMfbioBFI2K5uo+VDmb70QKIpENjaSVSf?=
 =?us-ascii?Q?vYJh9SeF+gTs9GaHQCGVkkDy8g3n5K9+ftDQdFqtqkDEyoIqxdWgiqK5K4n/?=
 =?us-ascii?Q?tx1GMXkF/0ZUYA2yzxa1t7XFLvw2HsXGnBop5xyTSYzPFePfiMkasi5cT3iK?=
 =?us-ascii?Q?k+knnuw9IK7Q0GZiEdLcW4JOEAxg3bcJNzFCVL9JmwP8fAs6DxkBS/y3S/lg?=
 =?us-ascii?Q?5py9Y+kJzf0zYWXdtHIXo1l9qq92O2oMvcXnB9wYn6xya2q0cmvotBiH28Ye?=
 =?us-ascii?Q?vmGEa8iR30PUPqBg0epSyIlWwBPNOtTYYsj5PlY0im4x3AsqZL8bORtxNsg0?=
 =?us-ascii?Q?SAUxY48Dz9BxYLdMxBbXxwqxGkfL0Z3nXyOFbjyVT8l3jgHwLeorIzYkMSWw?=
 =?us-ascii?Q?bAcqXd8cbsn0H4rqy+eaD6lscsElIESW6fwaNjKj5HS+JjC8Y72SakHmHXlT?=
 =?us-ascii?Q?dFJxZ3EL0V0S99WMq7I5puE0UMg7LezRCZ+BvNqZoY7VUrnYdFp454XZGXZ7?=
 =?us-ascii?Q?WCJD6rO3mvLkS8Yuh3G+neyFNO/9uw8xKUNklvGWcgbzUFSiImcU/XOKlIwX?=
 =?us-ascii?Q?aSc4oBpdPBXDhbgXgHaSImbsSwFeAiuTiRPgdwfLbuMJeme1TFmD0hITRgXv?=
 =?us-ascii?Q?SFU1t/JUWMBuUz434grdLlmlvi28PhXuEdns2yNSdp1bHiNthqnXudkIcycU?=
 =?us-ascii?Q?2mjvo6QTJdRB3VbUlwU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5851f69f-dfdb-4ec6-b3d8-08dba0bf7288
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 14:20:32.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1iEEDrcIPn1hJPuYzMXOaq6A8QdLbSiViv0Z1dw4iMoVxoI2OzjwMKEMTCVvYxiU2kJAiyRvIuJH/4WxpP9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for your comments. Probably, I should not resubmit patch too rushed.=
 I will add version number to subject and change log in cover letter for ne=
xt resubmission.

See my comments below. Please let me know whether you accept my explanation=
.

Henry
-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Saturday, August 19, 2023 8:41 AM
To: Henry Shi <henryshi2018@gmail.com>
Cc: hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de=
; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redh=
at.com; markgross@kernel.org; jdelvare@suse.com; linux-kernel@vger.kernel.o=
rg; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org; hb_sh=
i2003@yahoo.com; Huibin Shi <henrys@silicom-usa.com>; Wen Wang <wenw@silico=
m-usa.com>
Subject: Re: [PATCH] Add Silicom Platform Driver

Caution: This is an external email. Please take care when clicking links or=
 opening attachments.


On Fri, Aug 18, 2023 at 11:43:41AM -0400, Henry Shi wrote:

Description missing.

Henry: I forgot it for last submission, I realized it after I send out emai=
l.

This is at least v4 of this patch. No versioning, no change log.

Henry: Will add version and change log for next submission.

That was commented on before. This is the last time I am going to provide f=
eedback, even more so since most of my previous feedback was ignored.

Note that my comments only refer to problems in hwmon code and do by no mea=
ns suggest that the rest of the code may be acceptable.

> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---
>  drivers/platform/x86/Kconfig            |   11 +
>  drivers/platform/x86/Makefile           |    1 +
>  drivers/platform/x86/silicom-platform.c | 1046=20
> +++++++++++++++++++++++
>  3 files changed, 1058 insertions(+)
>  create mode 100644 drivers/platform/x86/silicom-platform.c
>
> diff --git a/drivers/platform/x86/Kconfig=20
> b/drivers/platform/x86/Kconfig index 22052031c719..7680c0dbcd8d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -188,6 +188,17 @@ config ACER_WMI
>         If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or=
 M
>         here.
>
> +config SILICOM_PLATFORM
> +     tristate "Silicom Edge Networking device support"
> +     depends on DMI
> +     select LEDS_CLASS_MULTICOLOR
> +     select GPIOLIB
> +     help
> +       This option enables support for the LEDs/GPIO/etc downstream of t=
he
> +       embedded controller on Silicom "Cordoba" hardware and derivatives=
.
> +
> +       If you have a Silicom network appliance, say Y or M here.
> +
>  source "drivers/platform/x86/amd/Kconfig"
>
>  config ADV_SWBUTTON
> diff --git a/drivers/platform/x86/Makefile=20
> b/drivers/platform/x86/Makefile index 2cafe51ec4d8..9355ebbc56ca=20
> 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)    +=3D serial=
-multi-instantiate.o
>  obj-$(CONFIG_MLX_PLATFORM)           +=3D mlx-platform.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)                +=3D touchscreen_dmi.o
>  obj-$(CONFIG_WIRELESS_HOTKEY)                +=3D wireless-hotkey.o
> +obj-$(CONFIG_SILICOM_PLATFORM)               +=3D silicom-platform.o
>  obj-$(CONFIG_X86_ANDROID_TABLETS)    +=3D x86-android-tablets/
>
>  # Intel uncore drivers
> diff --git a/drivers/platform/x86/silicom-platform.c=20
> b/drivers/platform/x86/silicom-platform.c
> new file mode 100644
> index 000000000000..ddf9961e2b9e
> --- /dev/null
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -0,0 +1,1046 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// silicom-platform.c - Silicom MEC170x platform driver // //=20
> +Copyright (C) 2023 Henry Shi <henrys@silicom-usa.com>
> +
> +#include <linux/dmi.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h> #include <linux/module.h>=20
> +#include <linux/hwmon.h> #include <linux/mutex.h> #include=20
> +<linux/platform_device.h> #include <linux/string.h> #include=20
> +<linux/kobject.h> #include <linux/sysfs.h> #include <linux/bits.h>=20
> +#include <linux/bitfield.h>
> +
> +#define MEC_ADDR ((mec_io_base) + 0x02) #define MEC_DATA(offset)=20
> +((mec_io_base) + 0x04 + (offset)) #define EC_ADDR_LSB MEC_ADDR=20
> +#define EC_ADDR_MSB ((mec_io_base) + 0x03) #define SILICOM_MEC_MAGIC=20
> +0x5a #define OFFSET_BIT_TO_CHANNEL(off, bit) ((((off) + 0x014) << 3)=20
> +| (bit)) #define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)=20
> +#define MEC_VERSION_MAJOR GENMASK(15, 14) #define MEC_VERSION_MINOR=20
> +GENMASK(13, 8) #define IO_REG_BANK 0 #define DEFAULT_CHAN_LO 0=20
> +#define DEFAULT_CHAN_HI 0 #define MEC_EFUSE_LSB_ADDR 0x28 #define=20
> +MEC_POWER_CYCLE_ADDR 0x24
> +
> +static DEFINE_MUTEX(mec_io_mutex);
> +static int mec_io_base, mec_io_len;
> +static struct device *my_dev;
> +static int efuse_status;
> +static int mec_uc_version;
> +static int power_cycle;
> +
> +struct silicom_fan_control_data {
> +     struct   device *hdev;

Unnecessary.

> +     int      temp;

Unused

Henry: OK, will remove it for next submission.

> +     int      fan_speed;

Unnecessary.

Henry: OK, will remove it for next submission.

> +};

This entire data structure is unnecessary. I did comment on that before.

> +
> +static const struct hwmon_channel_info *silicom_fan_control_info[] =3D {
> +     HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL),
> +     HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +     NULL
> +};
> +
> +struct silicom_platform_info {
> +     int io_base;
> +     int io_len;
> +     struct led_classdev_mc *led_info;
> +     struct gpio_chip *gpiochip;
> +     u8 *gpio_channels;
> +     u16 ngpio;
> +};
> +
> +static const char * const plat_0222_gpio_names[] =3D {
> +     "AUTOM0_SFP_TX_FAULT",
> +     "SLOT2_LED_OUT",
> +     "SIM_M2_SLOT2_B_DET",
> +     "SIM_M2_SLOT2_A_DET",
> +     "SLOT1_LED_OUT",
> +     "SIM_M2_SLOT1_B_DET",
> +     "SIM_M2_SLOT1_A_DET",
> +     "SLOT0_LED_OUT",
> +     "WAN_SFP0_RX_LOS",
> +     "WAN_SFP0_PRSNT_N",
> +     "WAN_SFP0_TX_FAULT",
> +     "AUTOM1_SFP_RX_LOS",
> +     "AUTOM1_SFP_PRSNT_N",
> +     "AUTOM1_SFP_TX_FAULT",
> +     "AUTOM0_SFP_RX_LOS",
> +     "AUTOM0_SFP_PRSNT_N",
> +     "WAN_SFP1_RX_LOS",
> +     "WAN_SFP1_PRSNT_N",
> +     "WAN_SFP1_TX_FAULT",
> +     "SIM_M2_SLOT1_MUX_SEL",
> +     "W_DISABLE_M2_SLOT1_N",
> +     "W_DISABLE_MPCIE_SLOT0_N",
> +     "W_DISABLE_M2_SLOT0_N",
> +     "BT_COMMAND_MODE",
> +     "WAN_SFP1_TX_DISABLE",
> +     "WAN_SFP0_TX_DISABLE",
> +     "AUTOM1_SFP_TX_DISABLE",
> +     "AUTOM0_SFP_TX_DISABLE",
> +     "SIM_M2_SLOT2_MUX_SEL",
> +     "W_DISABLE_M2_SLOT2_N",
> +     "RST_CTL_M2_SLOT_1_N",
> +     "RST_CTL_M2_SLOT_2_N",
> +     "PM_USB_PWR_EN_BOT",
> +     "PM_USB_PWR_EN_TOP",
> +};
> +
> +static u8 plat_0222_gpio_channels[] =3D {
> +     OFFSET_BIT_TO_CHANNEL(0x00, 0),
> +     OFFSET_BIT_TO_CHANNEL(0x00, 1),
> +     OFFSET_BIT_TO_CHANNEL(0x00, 2),
> +     OFFSET_BIT_TO_CHANNEL(0x00, 3),
> +     OFFSET_BIT_TO_CHANNEL(0x00, 4),
> +     OFFSET_BIT_TO_CHANNEL(0x00, 5),
> +     OFFSET_BIT_TO_CHANNEL(0x00, 6),
> +     OFFSET_BIT_TO_CHANNEL(0x00, 7),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 0),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 1),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 2),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 3),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 4),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 5),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 6),
> +     OFFSET_BIT_TO_CHANNEL(0x01, 7),
> +     OFFSET_BIT_TO_CHANNEL(0x02, 0),
> +     OFFSET_BIT_TO_CHANNEL(0x02, 1),
> +     OFFSET_BIT_TO_CHANNEL(0x02, 2),
> +     OFFSET_BIT_TO_CHANNEL(0x09, 0),
> +     OFFSET_BIT_TO_CHANNEL(0x09, 1),
> +     OFFSET_BIT_TO_CHANNEL(0x09, 2),
> +     OFFSET_BIT_TO_CHANNEL(0x09, 3),
> +     OFFSET_BIT_TO_CHANNEL(0x0a, 0),
> +     OFFSET_BIT_TO_CHANNEL(0x0a, 1),
> +     OFFSET_BIT_TO_CHANNEL(0x0a, 2),
> +     OFFSET_BIT_TO_CHANNEL(0x0a, 3),
> +     OFFSET_BIT_TO_CHANNEL(0x0a, 4),
> +     OFFSET_BIT_TO_CHANNEL(0x0a, 5),
> +     OFFSET_BIT_TO_CHANNEL(0x0a, 6),
> +     OFFSET_BIT_TO_CHANNEL(0x0b, 0),
> +     OFFSET_BIT_TO_CHANNEL(0x0b, 1),
> +     OFFSET_BIT_TO_CHANNEL(0x0b, 2),
> +     OFFSET_BIT_TO_CHANNEL(0x0b, 3),
> +};
> +
> +static struct platform_device *silicom_platform_dev; static struct=20
> +led_classdev_mc *silicom_led_info __initdata; static struct gpio_chip=20
> +*silicom_gpiochip __initdata; static u8 *silicom_gpio_channels=20
> +__initdata;
> +
> +static int silicom_mec_port_get(unsigned int offset) {
> +     u8 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Get the dword offset from the channel */
> +     outb((offset >> 3) & 0xfc, MEC_ADDR);
> +
> +     /* Get the current register */
> +     reg =3D inb(MEC_DATA((offset >> 3) & 0x03));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     return (reg >> (offset & 0x7)) & 0x01; }
> +
> +static enum led_brightness silicom_mec_led_get(int channel) {
> +     /* Outputs are active low */
> +     return silicom_mec_port_get(channel) ? LED_OFF : LED_ON; }
> +
> +static void silicom_mec_port_set(int channel, int on) {
> +     u8 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Get the dword offset from the channel */
> +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> +     /* Get the current port settings */
> +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> +     /* Outputs are active low, so clear the bit for on, or set it for o=
ff */
> +     if (on)
> +             reg &=3D ~(1 << (channel & 0x7));
> +     else
> +             reg |=3D 1 << (channel & 0x7);
> +     /* Write back the updated register */
> +     outb(reg, MEC_DATA((channel >> 3) & 0x03));
> +     mutex_unlock(&mec_io_mutex);
> +}
> +
> +static enum led_brightness silicom_mec_led_mc_brightness_get(struct=20
> +led_classdev *led_cdev) {
> +     struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(led_cdev);
> +     enum led_brightness brightness =3D LED_OFF;
> +     int i;
> +
> +     for (i =3D 0; i < mc_cdev->num_colors; i++) {
> +             mc_cdev->subled_info[i].brightness =3D
> +                     silicom_mec_led_get(mc_cdev->subled_info[i].channel=
);
> +             /* Mark the overall brightness as LED_ON if any of the subl=
eds are on */
> +             if (mc_cdev->subled_info[i].brightness !=3D LED_OFF)
> +                     brightness =3D LED_ON;
> +     }
> +
> +     return brightness;
> +}
> +
> +static void silicom_mec_led_mc_brightness_set(struct led_classdev *led_c=
dev,
> +                                                                        =
            =20
> +enum led_brightness brightness) {
> +     struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(led_cdev);
> +     int i;
> +
> +     led_mc_calc_color_components(mc_cdev, brightness);
> +     for (i =3D 0; i < mc_cdev->num_colors; i++) {
> +             silicom_mec_port_set(mc_cdev->subled_info[i].channel,
> +             mc_cdev->subled_info[i].brightness);
> +     }
> +}
> +
> +static int silicom_gpio_get_direction(struct gpio_chip *gc, unsigned=20
> +int offset) {
> +     u8 *channels =3D gpiochip_get_data(gc);
> +
> +     /* Input registers have offsets between [0x00, 0x07] */
> +     if (CHANNEL_TO_OFFSET(channels[offset]) < 0x08)
> +             return GPIO_LINE_DIRECTION_IN;
> +
> +     return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int silicom_gpio_direction_input(struct gpio_chip *gc,=20
> +unsigned int offset) {
> +     int direction =3D silicom_gpio_get_direction(gc, offset);
> +
> +     return direction =3D=3D GPIO_LINE_DIRECTION_IN ? 0 : -EINVAL; }
> +
> +static void silicom_gpio_set(struct gpio_chip *gc, unsigned int=20
> +offset, int value) {
> +     u8 *channels =3D gpiochip_get_data(gc);
> +     int direction =3D silicom_gpio_get_direction(gc, offset);
> +     int channel =3D channels[offset];
> +
> +     if (direction =3D=3D GPIO_LINE_DIRECTION_IN)
> +             return;
> +
> +     if (value)
> +             silicom_mec_port_set(channel, 0);
> +     else if (value =3D=3D 0)
> +             silicom_mec_port_set(channel, 1);
> +     else
> +             pr_err("Wrong argument value: %d\n", value); }
> +
> +static int silicom_gpio_direction_output(struct gpio_chip *gc,=20
> +unsigned int offset, int value) {
> +     int direction =3D silicom_gpio_get_direction(gc, offset);
> +
> +     if (direction =3D=3D GPIO_LINE_DIRECTION_IN)
> +             return -EINVAL;
> +
> +     silicom_gpio_set(gc, offset, value);
> +
> +     return 0;
> +}
> +
> +static int silicom_gpio_get(struct gpio_chip *gc, unsigned int=20
> +offset) {
> +     u8 *channels =3D gpiochip_get_data(gc);
> +     int channel =3D channels[offset];
> +
> +     return silicom_mec_port_get(channel); }
> +
> +
> +static struct mc_subled plat_0222_wan_mc_subled_info[] __initdata =3D {
> +     {
> +             .color_index =3D LED_COLOR_ID_WHITE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 7),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_YELLOW,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 6),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 5),
> +     },
> +};
> +
> +static struct mc_subled plat_0222_sys_mc_subled_info[] __initdata =3D {
> +     {
> +             .color_index =3D LED_COLOR_ID_WHITE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 4),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_AMBER,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 3),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 2),
> +     },
> +};
> +
> +static struct mc_subled plat_0222_stat1_mc_subled_info[] __initdata =3D =
{
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 1),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_GREEN,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0c, 0),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_BLUE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 7),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_YELLOW,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 6),
> +     },
> +};
> +
> +static struct mc_subled plat_0222_stat2_mc_subled_info[] __initdata =3D =
{
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 5),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_GREEN,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 4),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_BLUE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 3),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_YELLOW,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 2),
> +     },
> +};
> +
> +static struct mc_subled plat_0222_stat3_mc_subled_info[] __initdata =3D =
{
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 1),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_GREEN,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0d, 0),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_BLUE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0e, 1),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_YELLOW,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x0e, 0),
> +     },
> +};
> +
> +static struct led_classdev_mc plat_0222_mc_led_info[] __initdata =3D {
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:wan",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(plat_0222_wan_mc_subled_info),
> +             .subled_info =3D plat_0222_wan_mc_subled_info,
> +     },
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:sys",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(plat_0222_sys_mc_subled_info),
> +             .subled_info =3D plat_0222_sys_mc_subled_info,
> +     },
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:stat1",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(plat_0222_stat1_mc_subled_info),
> +             .subled_info =3D plat_0222_stat1_mc_subled_info,
> +     },
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:stat2",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(plat_0222_stat2_mc_subled_info),
> +             .subled_info =3D plat_0222_stat2_mc_subled_info,
> +     },
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:stat3",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(plat_0222_stat3_mc_subled_info),
> +             .subled_info =3D plat_0222_stat3_mc_subled_info,
> +     },
> +     { },
> +};
> +
> +static struct gpio_chip silicom_gpio_chip =3D {
> +     .label =3D "silicom-gpio",
> +     .get_direction =3D silicom_gpio_get_direction,
> +     .direction_input =3D silicom_gpio_direction_input,
> +     .direction_output =3D silicom_gpio_direction_output,
> +     .get =3D silicom_gpio_get,
> +     .set =3D silicom_gpio_set,
> +     .base =3D -1,
> +     .ngpio =3D ARRAY_SIZE(plat_0222_gpio_channels),
> +     .names =3D plat_0222_gpio_names,
> +     /* We're using a mutex to protect the indirect access, so we can sl=
eep if the
> +      * lock blocks
> +      */
> +     .can_sleep =3D true,
> +};
> +
> +static struct silicom_platform_info silicom_plat_0222_cordoba_info __ini=
tdata =3D {
> +     .io_base =3D 0x800,
> +     .io_len =3D 8,
> +     .led_info =3D plat_0222_mc_led_info,
> +     .gpiochip =3D &silicom_gpio_chip,
> +     .gpio_channels =3D plat_0222_gpio_channels,
> +     /* The original generic cordoba does not have the last 4 outputs of=
 the plat_0222
> +      * BB variant, the rest are the same, so use the same longer list, =
but ignore the
> +      * last entries here
> +      */
> +     .ngpio =3D ARRAY_SIZE(plat_0222_gpio_channels),
> +
> +};
> +
> +static struct mc_subled cordoba_fp_left_mc_subled_info[] __initdata =3D =
{
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 6),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_GREEN,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 5),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_BLUE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x09, 7),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_AMBER,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x09, 4),
> +     },
> +};
> +
> +static struct mc_subled cordoba_fp_center_mc_subled_info[] __initdata =
=3D {
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 7),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_GREEN,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 4),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_BLUE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 3),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_AMBER,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x09, 6),
> +     },
> +};
> +
> +static struct mc_subled cordoba_fp_right_mc_subled_info[] __initdata =3D=
 {
> +     {
> +             .color_index =3D LED_COLOR_ID_RED,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 2),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_GREEN,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 1),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_BLUE,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x08, 0),
> +     },
> +     {
> +             .color_index =3D LED_COLOR_ID_AMBER,
> +             .brightness =3D 1,
> +             .intensity =3D 0,
> +             .channel =3D OFFSET_BIT_TO_CHANNEL(0x09, 5),
> +     },
> +};
> +
> +static struct led_classdev_mc cordoba_mc_led_info[] __initdata =3D {
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:fp_left",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(cordoba_fp_left_mc_subled_info),
> +             .subled_info =3D cordoba_fp_left_mc_subled_info,
> +     },
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:fp_center",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(cordoba_fp_center_mc_subled_info=
),
> +             .subled_info =3D cordoba_fp_center_mc_subled_info,
> +     },
> +     {
> +             .led_cdev =3D {
> +                     .name =3D "multicolor:fp_right",
> +                     .brightness =3D 0,
> +                     .max_brightness =3D 1,
> +                     .brightness_set =3D silicom_mec_led_mc_brightness_s=
et,
> +                     .brightness_get =3D silicom_mec_led_mc_brightness_g=
et,
> +             },
> +             .num_colors =3D ARRAY_SIZE(cordoba_fp_right_mc_subled_info)=
,
> +             .subled_info =3D cordoba_fp_right_mc_subled_info,
> +     },
> +     { },
> +};
> +
> +static struct silicom_platform_info silicom_generic_cordoba_info __initd=
ata =3D {
> +     .io_base =3D 0x800,
> +     .io_len =3D 8,
> +     .led_info =3D cordoba_mc_led_info,
> +     .gpiochip =3D &silicom_gpio_chip,
> +     .gpio_channels =3D plat_0222_gpio_channels,
> +     .ngpio =3D ARRAY_SIZE(plat_0222_gpio_channels),
> +};
> +
> +static struct platform_driver silicom_platform_driver =3D {
> +     .driver =3D {
> +             .name =3D "silicom-platform",
> +     },
> +};
> +
> +static ssize_t efuse_status_show(struct device *dev, struct device_attri=
bute *attr,
> +                                                             char=20
> +*buf) {
> +     u32 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(IO_REG_BANK, EC_ADDR_MSB);
> +     outb(MEC_EFUSE_LSB_ADDR, EC_ADDR_LSB);
> +
> +     /* Get current data from the address */
> +     reg =3D inl(MEC_DATA(DEFAULT_CHAN_LO));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     efuse_status =3D reg & 0x1;
> +
> +     return sprintf(buf, "%d\n", efuse_status); }
> +
> +static ssize_t uc_version_show(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     char *buf) {
> +     u32 reg;
> +     int uc_version;
> +
> +     mutex_lock(&mec_io_mutex);
> +     outb(IO_REG_BANK, EC_ADDR_MSB);
> +     outb(DEFAULT_CHAN_LO, EC_ADDR_LSB);
> +
> +     reg =3D inl(MEC_DATA(DEFAULT_CHAN_LO));
> +     mutex_unlock(&mec_io_mutex);
> +     uc_version =3D FIELD_GET(GENMASK(15, 8), reg);
> +     if (uc_version >=3D 192)
> +             pr_err("uc version not supported\n");
> +
> +     uc_version =3D FIELD_GET(MEC_VERSION_MAJOR, reg) * 100 +
> +                             FIELD_GET(MEC_VERSION_MINOR, reg);
> +
> +     mec_uc_version =3D uc_version;
> +     return sprintf(buf, "%d\n", mec_uc_version); }
> +
> +static ssize_t power_cycle_show(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf) {
> +     return sprintf(buf, "%d\n", power_cycle); }
> +
> +static void powercycle_uc(void)
> +{
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(IO_REG_BANK, EC_ADDR_MSB);
> +     outb(MEC_POWER_CYCLE_ADDR, EC_ADDR_LSB);
> +
> +     /* Set to 1 for current data from the address */
> +     outb(1, MEC_DATA(DEFAULT_CHAN_LO));
> +     mutex_unlock(&mec_io_mutex);
> +}
> +
> +static ssize_t power_cycle_store(struct device *dev, struct device_attri=
bute *attr,
> +                              const char *buf, size_t count) {
> +     if (sscanf(buf, "%du", &power_cycle) !=3D 1) {
> +             dev_err(dev, "Failed to read power_cycle\n");
> +             return -EINVAL;
> +     }
> +     if (power_cycle > 0)
> +             powercycle_uc();
> +
> +     return count;
> +}
> +
> +static struct device_attribute my_dev_attr[] =3D {
> +     {
> +             .attr =3D {.name =3D "efuse_status", .mode =3D 0644},
> +             .show =3D efuse_status_show,
> +             .store =3D NULL
> +     },
> +     {
> +             .attr =3D {.name =3D "uc_version", .mode =3D 0644},
> +             .show =3D uc_version_show,
> +             .store =3D NULL
> +     },
> +     {
> +             .attr =3D {.name =3D "power_cycle", .mode =3D 0644},
> +             .show =3D power_cycle_show,
> +             .store =3D power_cycle_store
> +     },
> +};
> +
> +static int __init silicom_mc_leds_register(struct device *dev,
> +                                        const struct led_classdev_mc=20
> +*mc_leds) {
> +     struct led_classdev_mc *led;
> +     int i, err;
> +
> +     for (i =3D 0; mc_leds[i].led_cdev.name; i++) {
> +             led =3D devm_kzalloc(dev, sizeof(struct led_classdev_mc), G=
FP_KERNEL);
> +             if (!led)
> +                     return -ENOMEM;
> +             memcpy(led, &mc_leds[i], sizeof(*led));
> +
> +             led->subled_info =3D devm_kzalloc(dev, led->num_colors * si=
zeof(struct mc_subled), GFP_KERNEL);
> +             if (!led->subled_info)
> +                     return -ENOMEM;
> +             memcpy(led->subled_info, mc_leds[i].subled_info,=20
> + led->num_colors * sizeof(struct mc_subled));
> +
> +             err =3D devm_led_classdev_multicolor_register(dev, led);
> +             if (err) {
> +                     dev_err(dev, "Failed to register[%d]: %d\n", i, err=
);
> +                     return err;
> +             }
> +     }
> +
> +     return 0;
> +}
> +
> +static u32 rpm_get(void)
> +{
> +     u32 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(IO_REG_BANK, EC_ADDR_MSB);
> +     outb(0xc, EC_ADDR_LSB);
> +     /* Get current data from the address */
> +     reg =3D inw(MEC_DATA(DEFAULT_CHAN_LO));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     return reg;
> +}
> +
> +static u32 temp_get(void)
> +{
> +     u32 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(IO_REG_BANK, EC_ADDR_MSB);
> +     outb(0xc, EC_ADDR_LSB);
> +     /* Get current data from the address */
> +     reg =3D inl(MEC_DATA(DEFAULT_CHAN_LO));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     return (reg >> 16) / 10;

The hwmon ABI expects temperatures to be reported in milli-degrees C.
The above sets the maximum temperature to 65,535 / 10 =3D 6,553 milli-degre=
es or 6.553 degrees C. It is very unlikely that this is correct.

Again, I commented on this before.

Henry: this is due to an internal implementation of MIcor-controller firmwa=
re, instead of putting real temperature to the register, it put (real tempe=
rature * 10 ) to the register. So, in order to report correct temperature t=
o user space application, the read value is divided by 10, then report to u=
ser space.=20

Please let me know if you accept this. If not, I can change the code, but l=
et user space application to do adjustment.=20

> +}
> +
> +static umode_t silicom_fan_control_fan_is_visible(const u32 attr) {
> +     switch (attr) {
> +     case hwmon_fan_input:
> +     case hwmon_fan_label:
> +             return 0444;
> +     default:
> +             return 0;
> +     }
> +}
> +
> +static umode_t silicom_fan_control_temp_is_visible(const u32 attr) {
> +     switch (attr) {
> +     case hwmon_temp_input:
> +     case hwmon_temp_label:
> +             return 0444;
> +     default:
> +             return 0;
> +     }
> +}
> +
> +static int silicom_fan_control_read_fan(struct device *dev, u32 attr,=20
> +long *val) {
> +     struct silicom_fan_control_data *ctl =3D dev_get_drvdata(dev);
> +
> +     switch (attr) {
> +     case hwmon_fan_input:
> +             ctl->fan_speed =3D rpm_get();
> +             *val =3D ctl->fan_speed;

Storing data in fan_speed is unnecessary.

Henry: OK, it will be removed.

> +             return 0;
> +     default:
> +             return -EOPNOTSUPP;
> +     }
> +}
> +
> +static int silicom_fan_control_read_temp(struct device *dev, u32=20
> +attr, long *val) {
> +     switch (attr) {
> +     case hwmon_temp_input:
> +             *val =3D temp_get();
> +             return 0;
> +     default:
> +             return -EOPNOTSUPP;
> +     }
> +}
> +
> +static umode_t silicom_fan_control_is_visible(const void *data,
> +                                       enum hwmon_sensor_types type,
> +                                       u32 attr, int channel) {
> +     switch (type) {
> +     case hwmon_fan:
> +             return silicom_fan_control_fan_is_visible(attr);
> +     case hwmon_temp:
> +             return silicom_fan_control_temp_is_visible(attr);
> +     default:
> +             return 0;
> +     }
> +}
> +
> +static int silicom_fan_control_read(struct device *dev, enum hwmon_senso=
r_types type,
> +                                 u32 attr, int channel, long *val) {
> +     switch (type) {
> +     case hwmon_fan:
> +             return silicom_fan_control_read_fan(dev, attr, val);
> +     case hwmon_temp:
> +             return silicom_fan_control_read_temp(dev, attr, val);
> +     default:
> +             return -EOPNOTSUPP;
> +     }
> +}
> +
> +static int silicom_fan_control_read_labels(struct device *dev, enum hwmo=
n_sensor_types type,
> +                                        u32 attr, int channel, const=20
> +char **str) {
> +     switch (type) {
> +     case hwmon_fan:
> +             *str =3D "Fan Speed";
> +             return 0;
> +     case hwmon_temp:
> +             *str =3D "Thermostat Sensor";
> +             return 0;

Those labels have no practical value.

Henry: Those labels will be used by user space code to identify Silicom_pla=
tform driver.=20

> +     default:
> +             return -EOPNOTSUPP;
> +     }
> +}
> +
> +static const struct hwmon_ops silicom_fan_control_hwmon_ops =3D {
> +     .is_visible =3D silicom_fan_control_is_visible,
> +     .read =3D silicom_fan_control_read,
> +     .write =3D NULL,

Unnecessary.

Henry: OK, will be removed silicom_fan_control_is_visible.

> +     .read_string =3D silicom_fan_control_read_labels, };
> +
> +static const struct hwmon_chip_info silicom_chip_info =3D {
> +     .ops =3D &silicom_fan_control_hwmon_ops,
> +     .info =3D silicom_fan_control_info, };
> +
> +static int __init silicom_platform_probe(struct platform_device=20
> +*device) {
> +     int i, err;
> +     u8 magic, ver;
> +     struct silicom_fan_control_data *ctl;
> +     const char *name =3D "Silocom_Fan_Monitor";
> +     const char *dev_name =3D "Silicom_platform";
> +
> +     mec_io_base =3D 0x0800;
> +     mec_io_len =3D 8;
> +     if (!devm_request_region(&device->dev, mec_io_base, mec_io_len, "me=
c")) {
> +             dev_err(&device->dev, "couldn't reserve MEC io ports\n");
> +             return -EBUSY;
> +     }
> +
> +     /* Sanity check magic number read for EC */
> +     outb(0x00, MEC_ADDR);
> +     magic =3D inb(MEC_DATA(DEFAULT_CHAN_LO));
> +     ver =3D inb(MEC_DATA(DEFAULT_CHAN_HI));
> +     dev_dbg(&device->dev, "EC magic 0x%02x, version 0x%02x\n",=20
> + magic, ver);
> +
> +     if (magic !=3D SILICOM_MEC_MAGIC) {
> +             dev_err(&device->dev, "Bad EC magic 0x%02x!\n", magic);
> +             return -ENODEV;
> +     }
> +
> +     err =3D silicom_mc_leds_register(&device->dev, silicom_led_info);
> +     if (err) {
> +             dev_err(&device->dev, "Failed to register LEDs\n");
> +             return err;
> +     }
> +
> +     err =3D devm_gpiochip_add_data(&device->dev, silicom_gpiochip, sili=
com_gpio_channels);
> +     if (err) {
> +             dev_err(&device->dev, "Failed to register gpiochip: %d\n", =
err);
> +             return err;
> +     }
> +
> +     ctl =3D devm_kzalloc(&device->dev, sizeof(*ctl), GFP_KERNEL);
> +     if (!ctl)
> +             return -ENOMEM;
> +
> +     ctl->hdev =3D devm_hwmon_device_register_with_info(&device->dev, na=
me, ctl,
> +                             &silicom_chip_info, NULL);
> +
> +     my_dev =3D root_device_register(dev_name);
> +     for (i =3D 0; i < ARRAY_SIZE(my_dev_attr); i++) {
> +             err =3D sysfs_create_file(&my_dev->kobj, &my_dev_attr[i].at=
tr);
> +             if (err) {
> +                     pr_debug("failed to create the foo file in /sys/dev=
ices/Silicom_platform\n");
> +                     break;
> +             }
> +     }
> +
> +     return err;
> +}
> +
> +static int __init silicom_platform_info_init(const struct=20
> +dmi_system_id *id) {
> +     struct silicom_platform_info *info =3D id->driver_data;
> +
> +     dev_info(&silicom_platform_dev->dev, "Detected %s\n",=20
> + id->ident);
> +
> +     mec_io_base =3D info->io_base;
> +     mec_io_len =3D info->io_len;
> +     silicom_led_info =3D info->led_info;
> +     silicom_gpio_channels =3D info->gpio_channels;
> +     silicom_gpiochip =3D info->gpiochip;
> +     if (silicom_gpiochip)
> +             silicom_gpiochip->ngpio =3D info->ngpio;
> +
> +     return 1;
> +}
> +
> +static const struct dmi_system_id silicom_dmi_ids[] __initconst =3D {
> +     {
> +             .callback =3D silicom_platform_info_init,
> +             .ident =3D "Silicom Cordoba (Generic)",
> +             .matches =3D {
> +                     DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
> +                     DMI_MATCH(DMI_BOARD_NAME, "80300-0214-G"),
> +             },
> +             .driver_data =3D &silicom_generic_cordoba_info,
> +     },
> +     {
> +             .callback =3D silicom_platform_info_init,
> +             .ident =3D "Silicom Cordoba (Generic)",
> +             .matches =3D {
> +                     DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
> +                     DMI_MATCH(DMI_BOARD_NAME, "80500-0214-G"),
> +             },
> +             .driver_data =3D &silicom_generic_cordoba_info,
> +     },
> +     {
> +              .callback =3D silicom_platform_info_init,
> +              .ident =3D "Silicom Cordoba (plat_0222)",
> +              .matches =3D {
> +                     DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
> +                     DMI_MATCH(DMI_BOARD_NAME, "80300-0222-G"),
> +              },
> +             .driver_data =3D &silicom_plat_0222_cordoba_info,
> +     },
> +     { },
> +};
> +
> +static int __init silicom_platform_init(void) {
> +     struct device *dev;
> +     int err;
> +
> +     /* register a platform device to act as the parent for LEDS, etc. *=
/
> +     silicom_platform_dev =3D platform_device_register_simple("silicom-p=
latform", -1, NULL, 0);
> +     if (IS_ERR(silicom_platform_dev)) {
> +             err =3D PTR_ERR(silicom_platform_dev);
> +             pr_err("failed to register silicom-platform device: %d\n", =
err);
> +             goto silicom_init_register_err;
> +     }
> +     dev =3D &silicom_platform_dev->dev;
> +
> +     err =3D dmi_check_system(silicom_dmi_ids);
> +     if (err =3D=3D 0) {
> +             dev_err(dev, "No DMI match for this platform\n");
> +             err =3D -ENODEV;
> +             goto silicom_init_probe_err;
> +     }
> +
> +     /* Directly probe the platform driver in init since this isn't a
> +      * hotpluggable device.  That means we don't need to register a dri=
ver
> +      * that needs to wait around in memory on the chance a matching dev=
ice
> +      * would get added.  Instead run once in __init so that we can free=
 all
> +      * those resources when the __init region is wiped
> +      */
> +     err =3D platform_driver_probe(&silicom_platform_driver, silicom_pla=
tform_probe);
> +     if (err) {
> +             dev_err(dev, "Failed to probe platform driver %d\n", err);
> +             goto silicom_init_probe_err;
> +     }
> +
> +     return 0;
> +
> +silicom_init_probe_err:
> +     if (silicom_platform_dev) {
> +             platform_device_unregister(silicom_platform_dev);
> +             silicom_platform_dev =3D NULL;
> +     }
> +     if (my_dev) {
> +             root_device_unregister(my_dev);
> +             my_dev =3D NULL;
> +     }
> +
> +silicom_init_register_err:
> +     return err;
> +}
> +
> +static void __exit silicom_platform_exit(void) {
> +     int i;
> +
> +     if (silicom_platform_dev) {
> +             platform_device_unregister(silicom_platform_dev);
> +             platform_driver_unregister(&silicom_platform_driver);
> +     }
> +
> +     if (my_dev) {
> +             for (i =3D 0; i < ARRAY_SIZE(my_dev_attr); i++)
> +                     sysfs_remove_file(&my_dev->kobj, &my_dev_attr[i].at=
tr);
> +             root_device_unregister(my_dev);
> +     }
> +     mutex_destroy(&mec_io_mutex);
> +}
> +
> +module_init(silicom_platform_init);
> +module_exit(silicom_platform_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Henry Shi <henrys@silicom-usa.com>");=20
> +MODULE_DESCRIPTION("Platform driver for Silicom network appliances");
> +
> +MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids);
