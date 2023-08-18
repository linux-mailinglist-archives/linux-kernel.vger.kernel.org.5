Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F0780E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377521AbjHROb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHROb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:31:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2107.outbound.protection.outlook.com [40.107.13.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB05C2723;
        Fri, 18 Aug 2023 07:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdMoCAoJhXP6BwEDMKOVBANAsoCI88c7aJFc2Ls3uWpHSjZ5IjqdZtHOZg/dubjsanCk9q7lV0B8KeL62xfl3D94Xkqt2J2GHIr+fCVKGo4GnWmoh4qr6X0Ji7Py93LrEiO7SWkOBpNL31B356fkJzW2vzPvqIdIWdLkoTDa19z442xApHS27HLDYV/IeGTrGSmWj0Vq5nWJiiH3StcE1Tdk8Nqm4ETf0nPtHTY1+DcoLJfdZUlSX3K7wTVvdyH4XsqAtp3t2NMlZvAS9PnqKfe5PS2ZVZIx1tWBNmuGtRQZ8xJy0KwsLb4fXkQE73tBhB3B1Js7RM3IU/8UpdGqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjXzpuwr1ESBtabxA+7J0gahYLAajdH3YyneG38KRjg=;
 b=d7S3wLqIvWi1MifoyU32VePsJPkLwwnAalx6D1mRL6bKovBa07giva2VzR17QuYM5xMinOFOa3UeCPuLsweHCsEBcUQwsAaDCWxhxqVOUxdv+39Ygg0EeaDdzDzZZXKoUnJApEePaoKsbFathOaMLSKyvekOX5me/alrwQHejBx4krUEIvVgYaWHYXimigwVIRgKky8kzshqZQouq8kgWiwIMbWx4E8R7RYo77Dt3zvEKKO1pxZfAP5B+PI+JsfgHu9B0BMc82cBUXpWeO5hdxBu9vEVzHGuPntJ4p1fJi2lIycfWFwyBWHWBiItcZ42eCprboS0vgVqmi4Fk7c5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjXzpuwr1ESBtabxA+7J0gahYLAajdH3YyneG38KRjg=;
 b=C8Xle8/WnNFzt0jr63LIagat2clxmrhp1pG2jySSkkQd4zWIB3shtbQNwe5c+EcuIYXm0OFU9egarrG3fYsLeTpk9tSV5uvlDWGdu5XOSotZiOBGUshxfdB5FBeSAaJewqIBQujXgo5WX24pY9xEi8pS0Yzc/0ivVMHqF1ZVi3E=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by DBBPR04MB7931.eurprd04.prod.outlook.com (2603:10a6:10:1eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.32; Fri, 18 Aug
 2023 14:31:20 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 14:31:20 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
        "linux@roeck-us.net" <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZz33ADZ1WWgTenEy1OsAW00UH1a/uJJMAgAH8f0A=
Date:   Fri, 18 Aug 2023 14:31:19 +0000
Message-ID: <PA4PR04MB92229C1766A896502B65E02E9A1BA@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230815133759.7690-1-henryshi2018@gmail.com>
 <e376de55-5962-875-2c51-928a4fdfcea@linux.intel.com>
In-Reply-To: <e376de55-5962-875-2c51-928a4fdfcea@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|DBBPR04MB7931:EE_
x-ms-office365-filtering-correlation-id: 8cfa1f3c-1104-4bd0-ac72-08db9ff7ca2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnkwLdhYpUwZKvVyOvMt4QrL8FQnLO/ZcSGPM6mJnxse2/s30hNRD/HossUQR/VvKnnm/z2rIPsGc0YDNcIB9O++M/G0BWXIzf1ruZ5g2ylOXbVnsMIdlWRfvgGPYYKFNlJKWEmEZysqDonVPPO9zGvs3Wkp81OHG8n+lsTSn0ttbR2n9y82A6BHuaCcx0xEz3y4MZdG5E7Me+SQmvyBcN+q47oEVUxs9FcByu1g4WEVVcWFPP9Ed6q7wBhEm9EEpJ4ADoUEunr7R9TDZaAj1x+lOtolg/phNW07UqED8ra/cP+zels9r55NLSRwZ0Sg0Nk77mZFBvpGOvnrK3PGPwIpqyk2FJ9M4TGYY5OhK/RSCXXFr+jzNbTel1WfVMzmXGN/wloV40HwOzwMvxzRIrijPtejyyzkvJ1mttaoZi/z246ZJjfHhTXp0gjBrAybUKBW66OAjJWBI6da2Fj/BCPCKLPPvhTPzEH4mvPYoJtvhnsiRCZyRR2CrQIP+NIX0uvpAe+5yeGutrQB+odc/UnTPj7sKyd1wPD3+ivQ40D7cCX7usY+E2LqZDkgVPnhVku0Qm3+Lcvf1OuqZb8q6/5ST6spFsAYBzotgQsJh+Kj7ZHWfkiN1Etq5QF3pF7G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(136003)(376002)(366004)(396003)(1800799009)(451199024)(186009)(9686003)(7696005)(41300700001)(53546011)(33656002)(7416002)(2906002)(86362001)(83380400001)(30864003)(107886003)(5660300002)(52536014)(38070700005)(38100700002)(122000001)(66574015)(6506007)(55016003)(8676002)(8936002)(4326008)(71200400001)(64756008)(54906003)(66476007)(45080400002)(66946007)(76116006)(110136005)(316002)(66556008)(66446008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y1w+Zke1lEc8BIzcxtTlDuUPVobH19QbzajlrdKS5PcEaZuUp/mSAmlPqg?=
 =?iso-8859-1?Q?8CnEkt/rplQhoq1XzFITgnPwEhqh/HKC5G1PjpD5umirzJveE+JIFTVtI7?=
 =?iso-8859-1?Q?2T+7wVzRpvO+i4XsIsr1HquufLczx02CnSuQqATmHu1rv73qlmgAxuRpKm?=
 =?iso-8859-1?Q?Cl6O8HpSoly1rhYuEinfINmYKpY1O4f1vtuUdXbUkiDkxguxPuhjdjD5uj?=
 =?iso-8859-1?Q?vUOUyPH2UyKOV+CpIDJym9ULnMOq7pI8QRnTdmw+QxfOpFwjRFZod796dY?=
 =?iso-8859-1?Q?RVQa80UovmcveR/RvYeoHd6c3+bKlehMsP1ldfAITsdTTBsUUJJ5adZOUb?=
 =?iso-8859-1?Q?XnCd4/nR0Vuj5vdfcKRQNMgET40j6AbLgLj0ZgxKAk3ExClsf81/DAq0wf?=
 =?iso-8859-1?Q?Zudhc7A1eZh62vxo/5l6iKNicoerr/06jkoUH5gigajEyQHlyAUrdSFqhS?=
 =?iso-8859-1?Q?bcx63JrVqSiGr5rqrlyYyjQi3W/LaPI+HodwvMWNBtTGj+nJWmNDlizD7V?=
 =?iso-8859-1?Q?H8H0cGRTytmMjv8AqnrR3Dxe0iHrslmU7Vibq+cA6FnaBoJ0U1gQzV8Lge?=
 =?iso-8859-1?Q?baAPwscdtp3JnG8bpRpW+G51/pTqF6U2riBoYhpryrmM7uQ6zottNaLlZ0?=
 =?iso-8859-1?Q?tUYmwTyxuHqycQX1dURv2MXIlDLkfgl06wRsq4L2tYBSG4rvLQ/exlxKaU?=
 =?iso-8859-1?Q?MU65CoO8vCDiPEr1n+licDjf+eSj4kF2WhyhV5Al68Kc/mdAD2s9pvuH+7?=
 =?iso-8859-1?Q?THGgZunX6t496kzXsK9xJO7D5YtA+/1bTtZRDdkDrnQz+xslJA9425FvZy?=
 =?iso-8859-1?Q?A+6SITCS+LJSlStQcL82WvWNQwZa5Soqi4YGXi1i315TOQbZPh0mRAU4fD?=
 =?iso-8859-1?Q?algVdh114trsBWuMNa/mXRpa6RVxaL+yASuBkeYyNeLcaaHNOFoBHVWUcQ?=
 =?iso-8859-1?Q?CO8V/E+TWKOkQOvVu2riQVjkYo/Q6+GjAhHHA3kfiOegqIHrYEQHeDwABO?=
 =?iso-8859-1?Q?2mH6Zqbq82xBBTDlJHH6n5ohzfyUjwQ+LcjcRIMIuX310NcJ9QK5Dwyd8F?=
 =?iso-8859-1?Q?Xw1Cdn/3HkK5jRwrrPNbHqEsCIaHa2CBv3YNjwbM+QQZ5r3ymUdKHiVgcl?=
 =?iso-8859-1?Q?hCbrCHM5zzExXzZp0k/SixETptJxm+jlFyRJRIiFmOk/wZfa8GN/HIhXpG?=
 =?iso-8859-1?Q?hAFxuo09vH/PNX0709p+k1vmYQbmiN1WJk6lV/yqrMDV+qBQuPLI5/Lcut?=
 =?iso-8859-1?Q?paDvuduzzVybLXoD2bCPMs9mH9zqEsiHVD/OavBbe1i3QFOoEz86KziXUz?=
 =?iso-8859-1?Q?N6MeJ6GwjWauKzpCaJ3cD8tA1i4jQxpSzKzd21tbm+O45gEkOFWpibee5X?=
 =?iso-8859-1?Q?eE1PzWSGhVFEArLzzVkUWdOnmX0V3eXA7vN6lYGCPLln/4s/9NP0wWAoDE?=
 =?iso-8859-1?Q?cRtVhJK9X4+bZUKoLUYq/iAJrAJ2fQfi+hfJKoMbOTsNzxit1nExhCRrhH?=
 =?iso-8859-1?Q?U2kYlE4/LH4o3HMYKfWfjMbNWYoxmgobZGIib/iPoHucn92F8MkbtPDUXR?=
 =?iso-8859-1?Q?AcQ52toe5jC3GmPbLDH1hhcuhHJsVS5h1jRH2ztcG8IPheH46qP2MkGUGw?=
 =?iso-8859-1?Q?N6zve85wVMVrqTKk4eXpZnjZDJfGQK/gD8yQTux00C2BB3ri/UCYT4pNK4?=
 =?iso-8859-1?Q?RvJVrmf/rZVfF7dfnf2K2BCrFhuZ4gt8yTawAEx1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfa1f3c-1104-4bd0-ac72-08db9ff7ca2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 14:31:20.0064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfUR+thnUnIZOaT4C3H8X5QzWbhm3MaPXtX4g8/M9v3zMsQ73L8ISe7FbJxGX/JQfQsWr1JWdfGdrfDO64cRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7931
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilpo,

See my comments below.

Thanks.
Henry

-----Original Message-----
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>=20
Sent: Thursday, August 17, 2023 4:07 AM
To: Henry Shi <henryshi2018@gmail.com>
Cc: hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de=
; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redh=
at.com; markgross@kernel.org; jdelvare@suse.com; linux@roeck-us.net; LKML <=
linux-kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org; linux-h=
wmon@vger.kernel.org; hb_shi2003@yahoo.com; Huibin Shi <henrys@silicom-usa.=
com>; Wen Wang <wenw@silicom-usa.com>
Subject: Re: [PATCH] Add Silicom Platform Driver

Caution: This is an external email. Please take care when clicking links or=
 opening attachments.


On Tue, 15 Aug 2023, Henry Shi wrote:

> The Silicom platform (silicom-platform) Linux driver for Swisscom=20
> Business Box (Swisscom BB) as well as Cordoba family products is a=20
> software solution designed to facilitate the efficient management and=20
> control of devices through the integration of various Linux=20
> frameworks. This platform driver provides seamless support for device=20
> management via the Linux LED framework, GPIO framework, Hardware=20
> Monitoring (HWMON), and device attributes. The Silicom platform=20
> driver's compatibility with these Linux frameworks allows applications=20
> to access and control Cordoba family devices using existing software=20
> that is compatible with these frameworks. This compatibility=20
> simplifies the development process, reduces dependencies on=20
> proprietary solutions, and promotes interoperability with other=20
> Linux-based systems and software.
>
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---

You should use version the submission (vXX should appear already in the
subject) and provide the version history in a list (listing version to vers=
ion changes).

Henry: OK.

>  drivers/platform/x86/Kconfig            |   11 +
>  drivers/platform/x86/Makefile           |    1 +
>  drivers/platform/x86/silicom-platform.c | 1053=20
> +++++++++++++++++++++++
>  3 files changed, 1065 insertions(+)
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
> index 000000000000..f8d1eb68b105
> --- /dev/null
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -0,0 +1,1053 @@
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
> +#define IO_REG_BANK 0 #define DEFAULT_CHAN_LO 0 #define=20
> +DEFAULT_CHAN_HI 0
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
> +     int      temp;
> +     int      fan_speed;
> +};
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
> +     u8 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Get the dword offset of the register for this LED from the chann=
el */
> +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> +     /* Get the current LED settings */
> +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     /* Outputs are active low */
> +     return silicom_mec_port_get(channel) ? LED_OFF : LED_ON;

Why is code now done twice, first in this function and then it calls
silicom_mec_port_get() which does the same thing?? Perhaps you forgot to re=
move it from this function while you added the call.

Henry: Yes, those lines should be removed.=20

> +}
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
> +                                    =20
> + mc_cdev->subled_info[i].brightness);

Align the arguments to the same column please.

Henry: OK

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


> +static ssize_t efuse_status_show(struct device *dev, struct device_attri=
bute *attr,
> +                                                             char=20
> +*buf) {
> +     u32 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(IO_REG_BANK, EC_ADDR_MSB);
> +     outb(0x28, EC_ADDR_LSB);

That 0x28 is some HW offset right? It should be named to what is found at t=
hat address with a define. Fiven the function name, perhaps something
along the lines of #define MEC_EFUSE_STATUS     0x28

Henry: OK

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
> +     outb(0x0, EC_ADDR_LSB);

Named define for 0x0.

Henry: OK.

> +
> +     reg =3D inl(MEC_DATA(DEFAULT_CHAN_LO));
> +     mutex_unlock(&mec_io_mutex);
> +     uc_version =3D FIELD_GET(GENMASK(15, 8), reg);

In general, it's more useful to have #define with name for GENMASK() like t=
his, but see below...

> +     if (uc_version >=3D 64 && uc_version < 128) {
> +             uc_version &=3D ~(1 << 6);
> +             uc_version =3D 100 + uc_version;
> +     } else if (uc_version >=3D 128 && uc_version < 192) {
> +             uc_version &=3D ~(1 << 7);
> +             uc_version =3D 200 + uc_version;
> +     }

I see you probably missed what I tried to say earlier. Does this version fi=
eld have two distinct fields? How about this:

#define MEC_VERSION_MAJOR       GENMASK(15, 14)
#define MEC_VERSION_MINOR       GENMASK(13, 8)

        uc_version =3D FIELD_GET(MEC_VERSION_MAJOR, reg) * 100 +
                     FIELD_GET(MEC_VERSION_MINOR, reg);

...you might want to add something for >=3D 192 values (or accept they'll b=
e in 300..3xx range if that's okay, I don't know the internals of this fiel=
ds so I cannot tell which is preferred here).

I think the results are identical to what the above code does but doesn't r=
equire any if()s (sans >=3D 192 that might need additional check).

Henry: Good suggestion.=20

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
> +     outb(0x24, EC_ADDR_LSB);

Named define for 0x24.

Henry: OK

--
 i.


