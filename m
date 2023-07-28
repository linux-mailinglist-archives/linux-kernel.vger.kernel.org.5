Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04191767610
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjG1TKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjG1TKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:10:19 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127419E;
        Fri, 28 Jul 2023 12:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNxH1DXVq13CojZAQxbzAGF9H4VnBQUSPvCaD5NY+G/TvPSH9sCy8W9ZfZK3GK6T5/VujRizQBhZGIhiG7sHCrjeb0lpanuWQkBNap0SZGWJXwQNqsN96a0zpebsRvAK0+DLpo0oVIyYmctN3ZpnLxQ1A22EJuIiyhXoKqMGzvjvDkOWjISBDmuow7jpTgtJM8FnmpvqbvNlvwEyn3dPCDU1wS+i42OQ4lg/eSGfvHTfTToGVXEtEw0Jxt36eJmhqHrKwjjcQ15eZbULknI+VSPEACP9smiaTm8p07/lGXc4glQ1yUuYWu7RwpT9n2s33xUe7bzKRZ2vTSCY4yfW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du+bGrfRZZxmTcvDOB8P3IGF9gEKfd4hAeFCQ2ByBwI=;
 b=XA1bAd1Sr0MaAz8NgqItVDdS1qIEf+HcYdhAG5jwhP89hbF7wMfgDQudPeD5YRgs6BDwiZ9DH9JWPDGQqHr1othK6/BNi88+Eq7fXdw01XNG4ZmSlZDqOu9S9DhmpwLjqhRjKmdhwVMSK7lKhTqH4vx+rHB+nHOsGVCcDeBfagdsUd4bWet2v+IWsp+gUgLdg9b9+DqH5HxYNfp6x9iP73oxtvOSssp09QJHIRWiB/DlqgvSK3qPMFWAtr7nVwrHzZx624eNlPZJjwUqih0Kk29+f6b9mSyOpFNYLg0IUsFpg0WQTIC073x4nwI9W5isXvCybfNWnudwzm4+B3t8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du+bGrfRZZxmTcvDOB8P3IGF9gEKfd4hAeFCQ2ByBwI=;
 b=J7yBGOOk0H+HOFoGQerSKStmW9o5pXPQOBqi2nKBthaM6XpPRklFck1We2S5yc58KU4lag4kcQG6dGyDb0FPE71Er7o5Dz5SNbY0MHN6E9XJlflC05onZHHa7ZnSPRtXuRiG5S9amBwqMxKlVRmXL9e9St1VpANdz5uotorUvfk=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by PA4PR04MB7855.eurprd04.prod.outlook.com (2603:10a6:102:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:10:11 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 19:10:11 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZuZEcSTfJXOh+tEO5M8hB8nDqzq/BAaYAgAhCLzA=
Date:   Fri, 28 Jul 2023 19:10:10 +0000
Message-ID: <PA4PR04MB922224D96319862CF987FE459A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <94cbb7d-68a-765-8bdf-5c8f8e41891@linux.intel.com>
In-Reply-To: <94cbb7d-68a-765-8bdf-5c8f8e41891@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|PA4PR04MB7855:EE_
x-ms-office365-filtering-correlation-id: 18bd738b-1ae5-4ab9-51e4-08db8f9e43d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyHrMx+Aoc37SRNuujqDJcjFcxfmtXRWZaBzV+bq3IgGAMaK6OzJHVvk/TQe4+87jPmTLNN/LeLC4n4Dta+ik2EUYQTY4hXWocSI13S2hSpw+/OvpGq3mckDHpM53n5JYj4lSXVWQMGCB0dxY4UVnX/qtc/NfUnukdN75CN5iJb7vU/yBqlrcCoBNjWHlJYUqbdEkCdwzhR6pXjMA1wA/VDvUL44XTzXXUl71ZnJ4mbjcGXpQNyNJRpsxI10SSLpDIvwvINO4ss3qRPE7W7Bnd5CrsttZ2yiXFkKd3g3y/g3o+bXpZ5cdkizyyMFY4jNrRDoPHbDgasWQWOv2+bReEX3MIy4prRxEpIUBF2Lrp/QBJlScJh4rzMeLQmnq6oJzR5XEPsUWywPbnPaTaAwdBcGshgzB5aDfpveWmenS3zh4dyTlnG3kNIUTDwdyCIJze8ABtDywziPk1CnN+iwX5MMejAje8Q77KEk4X8L2dNM6LULtVJHL3ORlmXG2RmDVqHV9dZcviVxsKxHJGbFznunNKzP+V0xgA7bnj/U7K5PUcbYtz0UxN8bG07vjvxYDdqXoKfSk4JrtIWYNtMyMhEmbyCuX3MUihzFTCj8QfTDf4hqUc+r/qOJIZ5aPLRBVQ0l7Nf++bR1b9a2Ric+GsjDpfTcwqrcK+aMGpAm4ws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(451199021)(30864003)(2906002)(41300700001)(316002)(7416002)(5660300002)(38070700005)(8676002)(33656002)(8936002)(86362001)(55016003)(52536014)(9686003)(6506007)(53546011)(107886003)(7696005)(478600001)(921005)(71200400001)(83380400001)(45080400002)(186003)(66574015)(4326008)(64756008)(66446008)(110136005)(38100700002)(76116006)(66476007)(66556008)(66946007)(122000001)(54906003)(21314003)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tOPj8gh5o9PmZteBJesCJdAR/EcC7tltjPviXKnUXOkgDan9zFfInboBtD?=
 =?iso-8859-1?Q?k7T0mFBtrwnJtZjyoILb02Y7gRNo2oIcQexsZQ7WaPuma0w4xem+SV86G7?=
 =?iso-8859-1?Q?2OhV93mGQx8Lu6Hi6nMMVURedKtCxQfg+zwecWNPLwFIE7nxha0bEATiEJ?=
 =?iso-8859-1?Q?lsV9L7ESpUBexBMmniKs8G3MIifkbaQBXS8GY8ub1UVrIpDpB6y1D5rq8a?=
 =?iso-8859-1?Q?d40grk6hvxRdYeFsYeyI7TRYK2cUxkR41d+JYnVspuOHqTIscB8FOZETYk?=
 =?iso-8859-1?Q?d270yNyhbzGLdXaV4Y1Okwb7Ja5v0rtvIKmjJNMt3lbD486Ekj44OK3jmQ?=
 =?iso-8859-1?Q?szGQx1sNDUrSSDU7y3ugJpoHVBPI2L4HjVvA05bwShv4cuaRzTlcS40ZJT?=
 =?iso-8859-1?Q?p6Q9vf/cd7zANhR4qaF1Ja8fwx1f08F0YpN93lq1OLCr/xX/uSSfBeoK1X?=
 =?iso-8859-1?Q?n0qxaCjp2rKfzXg26nzD+EmTpdKj9bdW46zftcKSg052bW27DJiUxVg4aK?=
 =?iso-8859-1?Q?TtOD6+oXgOwkFF75iR4LpfXP6O+cpFVmKjfUADBFxjXzufKozzCIsh4kOf?=
 =?iso-8859-1?Q?wOwTvfxSc1enBvn9Kk5OnuNJKLmC+6pPaVbMQcR2iqHKtP8f6yo89X1f53?=
 =?iso-8859-1?Q?ijMC6pOlKXmxlAmW0Hxi09SCVQyygCX3yOkIcaqio6Cs0buEP72ZoNiOKi?=
 =?iso-8859-1?Q?Wg+U/61DzKiWy5PErBaE1QMg+SUlpVzZU8xSWqYO2iA0vHOflHJTE7P9/V?=
 =?iso-8859-1?Q?KEoMQbZAOVcSAdrInqyz62kMGciHmQJzs2X6cgloCpBMdCBuCV1IoFixZY?=
 =?iso-8859-1?Q?Qc4DnpHxt9ynt/d2hp1YXFfL9wpHxusN1ZzcGAle5LDpyFtIK8KebnUY5L?=
 =?iso-8859-1?Q?DY5ks0PdMsUA5GYBSYp9zuQr60/uczg7qzsuCAOZfb29qSJFN6O7sQvv1I?=
 =?iso-8859-1?Q?qh2LglX94C/WOjxRTz2U/mwDLCb2QDiG6ci7MqpMhaHKZPDbExJy21u7T5?=
 =?iso-8859-1?Q?6qKJ6JtJSHlFsE43dO24eUfxhyr2adKOmnCGOvQX6q/6b/bbMGJdFmW2ek?=
 =?iso-8859-1?Q?DvdFl9bS3q+QTM/TUUo6ypGmyE8qF6NM8AaR2SICG8rOGlxTUd3kYman8D?=
 =?iso-8859-1?Q?Nub9U0Hz0c7t3xpXBbAmFSyZPQRpUGWnV+keicjyEQ1qsgGK8r+s6+2u0o?=
 =?iso-8859-1?Q?zVRcrUIY9O4pIlG9daRHLA8VwSIv3z8AUr4/mLXXDJi+f4J7atIk5zzFRB?=
 =?iso-8859-1?Q?8KUKJXRdK6cfqik6mM6GruktAB/uxT4aS2OZWL7gbf1iHYfc4KK6vOh/QZ?=
 =?iso-8859-1?Q?dgzY1UQuuu/JKRL7FeR10BAlHF0RbeA2fUtA3JxUMZj6knW+D2NlvN36Z7?=
 =?iso-8859-1?Q?/SH+8tQuuA2/GWZUWDYWlZL60swdEKbNU7GkPIjOzHgNemkqvhJQoHVER+?=
 =?iso-8859-1?Q?XQqF8k+gNHbhLhqWMDirC/jAqlGApMQxA6nd1fWzd0W4InPuobx2i+Oj3G?=
 =?iso-8859-1?Q?H3q6Dx4ih8D9bA0YLsaVtSO3dLMOWmnSD0R5EvCgEpdny09UTufOZnp7Nk?=
 =?iso-8859-1?Q?5RKyIseBNEXLMbpok/613Xaqw6rJXWNNz/7J1RfvgWbV7Ds4iYAlj78z/j?=
 =?iso-8859-1?Q?wskhC76pvsysf/pAL+eNumjgz4knKGXYebg33n6+J1L9W3s1i0ANRIgl8o?=
 =?iso-8859-1?Q?3gxH0BLyzxw5avUkvZ4jLAWaH+4hVJMB9W4g2QQS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bd738b-1ae5-4ab9-51e4-08db8f9e43d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 19:10:10.8469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15laXrKA8CSCk5kQG3IvJAKQtIEg7U9RGKZw6VTPSDouj66Yz78g1C87OVpHa2v6QrA8pdmSfrB92y+PfD/H0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7855
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilpo,

Thanks for the comments. See my comments below.

Updated patch will be sent out later after review comments from other revie=
wer are addressed.=20

Henry
-----Original Message-----
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>=20
Sent: Wednesday, July 19, 2023 8:13 AM
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


On Tue, 18 Jul 2023, Henry Shi wrote:

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
>  drivers/platform/x86/Kconfig            |   12 +
>  drivers/platform/x86/Makefile           |    1 +
>  drivers/platform/x86/silicom-platform.c | 1123=20
> +++++++++++++++++++++++
>  3 files changed, 1136 insertions(+)
>  create mode 100644 drivers/platform/x86/silicom-platform.c
>
> diff --git a/drivers/platform/x86/Kconfig=20
> b/drivers/platform/x86/Kconfig index 22052031c719..8c0988c2b4ce 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -188,6 +188,18 @@ config ACER_WMI
>         If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or=
 M
>         here.
>
> +

Extra newline

Henry: OK, removed.

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
> b/drivers/platform/x86/Makefile index 2cafe51ec4d8..f2f5743a9e54=20
> 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)    +=3D serial=
-multi-instantiate.o
>  obj-$(CONFIG_MLX_PLATFORM)           +=3D mlx-platform.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)                +=3D touchscreen_dmi.o
>  obj-$(CONFIG_WIRELESS_HOTKEY)                +=3D wireless-hotkey.o
> +obj-$(CONFIG_SILICOM_PLATFORM)          +=3D silicom-platform.o

Use tabs like the other lines.

Henry: OK

>  obj-$(CONFIG_X86_ANDROID_TABLETS)    +=3D x86-android-tablets/
>
>  # Intel uncore drivers
> diff --git a/drivers/platform/x86/silicom-platform.c=20
> b/drivers/platform/x86/silicom-platform.c
> new file mode 100644
> index 000000000000..90431f733682
> --- /dev/null
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -0,0 +1,1123 @@
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
> +<linux/thermal.h> #include <linux/kobject.h> #include <linux/sysfs.h>
> +
> +#define MEC_ADDR ((mec_io_base) + 0x02) #define MEC_DATA(byte)=20
> +((mec_io_base) + 0x04 + (byte)) #define EC_ADDR_LSB MEC_ADDR #define=20
> +EC_ADDR_MSB ((mec_io_base) + 0x03) #define SILICOM_MEC_MAGIC 0x5a

> +#define OFFSET_BIT_TO_CHANNEL(off, bit) ((((off) + 0x014) << 3) |=20
> +(bit)) #define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)

So you have two fields, offset and "bit", whatever that is. It would seem n=
amed define with GENMASK() for these two fields and FIELD_PREP() is appropr=
iate here. And FIELD_GET() (and perhaps also FIELD_PREP()) used in the code=
 below where appropriate.

0x14 should be named with a define.

> +#define CHANNEL_TO_BIT(chan) ((chan) & 0x07)

Unused.

Henry: OK, removed.

> +
> +static DEFINE_MUTEX(mec_io_mutex);
> +static int mec_io_base, mec_io_len;
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
> +struct silicom_device_control_data {
> +     struct   device *my_dev;
> +     int      efuse_status;
> +     int      uc_version;
> +     int      power_cycle;
> +};
> +static struct silicom_device_control_data my_dev_ctl;
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
> +static int silicom_gpio_get_direction(struct gpio_chip *gc, unsigned=20
> +int offset); static int silicom_gpio_direction_input(struct gpio_chip=20
> +*gc, unsigned int offset); static int=20
> +silicom_gpio_direction_output(struct gpio_chip *gc, unsigned int=20
> +offset, int value); static int silicom_gpio_get(struct gpio_chip *gc,=20
> +unsigned int offset); static void silicom_gpio_set(struct gpio_chip *gc,=
 unsigned int offset, int value); static void silicom_mec_led_mc_brightness=
_set(struct led_classdev *led_cdev,
> +                                           enum led_brightness=20
> +brightness); static enum led_brightness=20
> +silicom_mec_led_mc_brightness_get(struct led_classdev *led_cdev);

Try to organize the code such that no forward declarations are necessary.

Henry: OK.

> +static struct platform_device *silicom_platform_dev; static struct=20
> +led_classdev_mc *silicom_led_info __initdata; static struct gpio_chip=20
> +*silicom_gpiochip __initdata; static u8 *silicom_gpio_channels=20
> +__initdata; static struct gpio_chip silicom_gpio_chip =3D {
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
eep if the lock blocks */
> +     .can_sleep =3D true,
> +};
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
> +static struct silicom_platform_info silicom_plat_0222_cordoba_info __ini=
tdata =3D {
> +     .io_base =3D 0x800,
> +     .io_len =3D 8,
> +     .led_info =3D plat_0222_mc_led_info,
> +     .gpiochip =3D &silicom_gpio_chip,
> +     .gpio_channels =3D plat_0222_gpio_channels,
> +     /* The original generic cordoba does not have the last 4 outputs of=
 the plat_0222 BB variant,
> +      * the rest are the same, so use the same longer list, but ignore t=
he last entries here
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
> +void lock_io_modules(void)
> +{
> +     mutex_lock(&mec_io_mutex);
> +}
> +EXPORT_SYMBOL(lock_io_modules);
> +
> +void unlock_io_modules(void)
> +{
> +     mutex_unlock(&mec_io_mutex);
> +}
> +EXPORT_SYMBOL(unlock_io_modules);
> +
> +static ssize_t efuse_status_show(struct device *dev, struct device_attri=
bute *attr,
> +                   char *buf)
> +{
> +     u32 reg;
> +     u32 bank =3D 0;
> +     u32 offset =3D 0x28;

Why is this not a named define?

No need for bank & offset variables.

Henry: OK, added new named define and removed these three variables.

> +     u32 byte_pos =3D 0;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(bank, EC_ADDR_MSB);
> +     outb(offset, EC_ADDR_LSB);
> +
> +     /* Get current date from the address */
> +     reg =3D inl(MEC_DATA(byte_pos));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     my_dev_ctl.efuse_status =3D reg & 0x1;
> +
> +     return sprintf(buf, "%d\n", my_dev_ctl.efuse_status); }
> +
> +static ssize_t uc_version_show(struct device *dev,
> +                            struct device_attribute *attr,
> +                            char *buf) {
> +     u32 reg;
> +     u32 bank =3D 0;
> +     u32 offset =3D 0x0;

Ditto.

Henry: OK, added new named define and removed these three variables.

> +     u32 byte_pos =3D 0;
> +     int uc_version;
> +
> +     mutex_lock(&mec_io_mutex);
> +     outb(bank, EC_ADDR_MSB);
> +     outb(offset, EC_ADDR_LSB);
> +
> +     reg =3D inl(MEC_DATA(byte_pos));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     uc_version =3D (reg >> 8) & 0xFF;

Define a named mask with GENMASK() and use FIELD_GET().

Henry: OK, changed code to use these two macro.

> +     if (uc_version >=3D 64 && uc_version < 128) {
> +             uc_version =3D uc_version - 64;

Testing for a bit (or two bit field inside the version actually considering=
 the other if too) in version and then handcrafting & ~THATBIT?

Henry: OK, good point. Code was changed as suggested.

> +             if (uc_version < 10)
> +                     uc_version =3D 100 + uc_version;
> +             else
> +                     uc_version =3D 100 + 10 * (uc_version / 10) +=20
> + uc_version % 10;

Why is this if necessary? Doesn't the latter yield the same value as the fi=
rst one when uc_version < 10?

Henry: good point. Actually, the purpose of initial code is for uc version =
to return 1.x.y or 2.x.y, which is not an integer. I have changed the code =
to remove if check.=20

> +     } else if (uc_version >=3D 128 && uc_version < 192) {
> +             uc_version =3D uc_version - 128;
> +             if (uc_version < 10)
> +                     uc_version =3D 200 + uc_version;
> +             else
> +                     uc_version =3D 200 + 10 * (uc_version / 10) +=20
> + uc_version % 10;

Similar comments to this block.

Henry: good point. Actually, the purpose of initial code is for uc version =
to return 1.x.y or 2.x.y, which is not an integer. I have changed the code =
to remove if check.

> +     }
> +     my_dev_ctl.uc_version =3D uc_version;
> +     return sprintf(buf, "%d\n", my_dev_ctl.uc_version); }
> +
> +static ssize_t power_cycle_show(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf) {
> +     return sprintf(buf, "%d\n", my_dev_ctl.power_cycle); }
> +
> +static void powercycle_uc(void)
> +{
> +     u32 bank =3D 0;
> +     u32 offset =3D 0x24;

Named define, no need for these variables.

Henry: OK, added new named define and removed these three variables.

> +     u32 byte_pos =3D 0;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(bank, EC_ADDR_MSB);
> +     outb(offset, EC_ADDR_LSB);
> +
> +     /* Set to 1 for current date from the address */
> +     outb(1, MEC_DATA(byte_pos));

Hmm, this is really misleading. MEC_DATA() seems to calculate _an offset_, =
not data? Name things accordingly.

Henry: OK, changed the defined to  "#define MEC_DATA(offset) ((mec_io_base)=
 + 0x04 + (offset))"

> +     mutex_unlock(&mec_io_mutex);
> +}
> +
> +static ssize_t power_cycle_store(struct device *dev, struct device_attri=
bute *attr,
> +                              const char *buf, size_t count) {
> +     if (sscanf(buf, "%du", &my_dev_ctl.power_cycle) !=3D 1) {
> +             dev_err(dev, "Failed to read power_cycle\n");
> +             return -EINVAL;
> +     }
> +     if (my_dev_ctl.power_cycle > 0)
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
> +     u8 reg;
> +
> +     if (direction =3D=3D GPIO_LINE_DIRECTION_IN)
> +             return;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Get the dword offset from the channel */
> +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> +
> +     /* Get the current register */
> +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> +     if (value =3D=3D 0)
> +             reg &=3D ~(1 << (channel & 0x7));
> +     else if (value > 0)
> +             reg |=3D 1 << (channel & 0x7);
> +     else
> +             pr_err("Invalid GPIO value: %d\n", value);
> +     outb(reg, MEC_DATA((channel >> 3) & 0x03));
> +     mutex_unlock(&mec_io_mutex);
> +}
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
> +     u8 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Get the dword offset from the channel */
> +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> +
> +     /* Get the current register */
> +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     return (reg >> (channel & 0x7)) & 0x01; }
> +
> +static int __init silicom_mc_leds_register(struct device *dev,
> +                                        const struct led_classdev_mc=20
> +*mc_leds) {
> +     struct led_classdev_mc *led;
> +     int i, err;
> +
> +     for (i =3D 0; mc_leds[i].led_cdev.name; i++) {
> +             /* allocate and copy data from the init constansts */

There's a typo in the constansts but the code seems obvious enough to not n=
eed a comment at all.

Henry: OK, removed the comment line.

> +             led =3D devm_kzalloc(dev, sizeof(struct led_classdev_mc), G=
FP_KERNEL);
> +             if (IS_ERR_OR_NULL(led)) {
> +                     dev_err(dev, "Failed to alloc led_classdev_mc[%d]: =
%ld\n", i, PTR_ERR(led));
> +                     return -ENOMEM;
> +             }
> +             memcpy(led, &mc_leds[i], sizeof(*led));
> +
> +             led->subled_info =3D devm_kzalloc(dev, led->num_colors *=20
> + sizeof(struct mc_subled),

array_size() from linux/overflow.h

Henry: OK, changed to arary_size()

> +                                             GFP_KERNEL);
> +             if (IS_ERR_OR_NULL(led->subled_info)) {
> +                     dev_err(dev, "Failed to alloc subled_info[%d]: %ld\=
n",
> +                             i, PTR_ERR(led->subled_info));
> +                     return -ENOMEM;
> +             }
> +             memcpy(led->subled_info, mc_leds[i].subled_info,
> +                     led->num_colors * sizeof(struct mc_subled));

array_size()

Henry: OK, changed to arary_size()

Although a local variable could be used to hold it as it's used for alloc a=
nd this line.

Henry: Good point, allocated a local variable.=20

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
> +static void silicom_mec_led_set(int channel, int on) {
> +     u8 reg;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Get the dword offset from the channel */
> +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> +     /* Get the current LED settings */
> +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> +
> +     /* Outputs are active low, so clear the bit for on, or set it for o=
ff */
> +     if (on)
> +             reg &=3D ~(1 << (channel & 0x7));
> +     else
> +             reg |=3D 1 << (channel & 0x7);
> +
> +     /* Write back the updated register */
> +     outb(reg, MEC_DATA((channel >> 3) & 0x03));
> +
> +     mutex_unlock(&mec_io_mutex);

There's an identical code block in silicom_gpio_set(). Why not simply call =
this from silicom_gpio_set()?

Henry: these two block of date are different: silicom_mec_led_set(xxx, int =
on), argument on, when on is 1, it means turn on LED; 0 means turn off LED.=
 For  silicom_gpio_set(), the argument value, which is really the 0 or 1 bi=
t value that passed to reg.=20

> +}
> +
> +static void silicom_mec_led_mc_brightness_set(struct led_classdev *led_c=
dev,
> +                                           enum led_brightness=20
> +brightness) {
> +     struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(led_cdev);
> +     int i;
> +
> +     led_mc_calc_color_components(mc_cdev, brightness);
> +
> +     for (i =3D 0; i < mc_cdev->num_colors; i++) {
> +             silicom_mec_led_set(mc_cdev->subled_info[i].channel,
> +                                 mc_cdev->subled_info[i].brightness);
> +     }
> +}
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
> +     return reg & (1 << (channel & 0x7)) ? LED_OFF : LED_ON;

Looks identical to a part of silicom_gpio_get(). Perhaps it should call thi=
s function??

Henry: some of the code block of these two functions are similar. But funct=
ion return types are different. Gpio has status of 0 or 1, but LED has stat=
us of LED_OFF and LED_ON.

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
> +                    =20
> + silicom_mec_led_get(mc_cdev->subled_info[i].channel);
> +
> +             /* Mark the overall brightness as LED_ON if any of the subl=
eds are on */
> +             if (mc_cdev->subled_info[i].brightness !=3D LED_OFF)
> +                     brightness =3D LED_ON;
> +     }
> +
> +     return brightness;
> +}
> +
> +
> +static u32 rpm_get(void)
> +{
> +     u32 reg;
> +     u32 bank =3D 0;
> +     u32 offset =3D 0xc;

Named with a define. Remove unnecessary local vars.

Henry: OK, added new named define and removed these three variables.

> +     u32 byte_pos =3D 0;
> +
> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(bank, EC_ADDR_MSB);
> +     outb(offset, EC_ADDR_LSB);
> +     /* Get current date from the address */
> +     reg =3D inw(MEC_DATA(byte_pos));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     return reg;
> +}
> +
> +static u32 temp_get(void)
> +{
> +     u32 reg;
> +     u32 bank =3D 0;
> +     u32 offset =3D 0xc;
> +     u32 byte_pos =3D 0;

Ditto.

Henry: OK, added new named define and removed these three variables.

> +     mutex_lock(&mec_io_mutex);
> +     /* Select memory region */
> +     outb(bank, EC_ADDR_MSB);
> +     outb(offset, EC_ADDR_LSB);
> +     /* Get current date from the address */
> +     reg =3D inl(MEC_DATA(byte_pos));
> +     mutex_unlock(&mec_io_mutex);
> +
> +     return (reg >> 16) / 10;

Should that >> 16 do a FIELD_GET() for a named field, I suspect it should?

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
> +             return 0;
> +     default:
> +             return -EOPNOTSUPP;
> +     }
> +}
> +
> +static int silicom_fan_control_read_temp(struct device *dev, u32=20
> +attr, long *val) {
> +     struct silicom_fan_control_data *ctl =3D dev_get_drvdata(dev);
> +
> +     switch (attr) {
> +     case hwmon_temp_input:
> +             ctl->temp =3D temp_get();
> +             *val =3D ctl->temp;
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
> +             *str =3D "Fan Speed (RPM)";
> +             return 0;
> +     case hwmon_temp:
> +             *str =3D "Thermostat Sensor";
> +             return 0;
> +     default:
> +             return -EOPNOTSUPP;
> +     }
> +}
> +
> +static int silicom_fan_control_write(struct device *dev, enum hwmon_sens=
or_types type,
> +                                  u32 attr, int channel, long val) {
> +     return 0;
> +}
> +
> +static const struct hwmon_ops silicom_fan_control_hwmon_ops =3D {
> +     .is_visible =3D silicom_fan_control_is_visible,
> +     .read =3D silicom_fan_control_read,
> +     .write =3D silicom_fan_control_write,
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
> +     magic =3D inb(MEC_DATA(0));
> +     ver =3D inb(MEC_DATA(1));

0 and 1 should be named with defines.

OK, added #define DEFAULT_CHAN_LO 0
#define DEFAULT_CHAN_HI 0

> +     dev_dbg(&device->dev, "EC magic 0x%02x, version 0x%02x\n",=20
> + magic, ver);
> +
> +     if (magic !=3D SILICOM_MEC_MAGIC) {
> +             dev_err(&device->dev, "Bad EC magic 0x%02x!\n", magic);
> +             return -ENODEV;
> +     }
> +
> +     if (silicom_led_info) {

How can this be NULL?

Henry: OK, no need for checking. Removed.

> +             err =3D silicom_mc_leds_register(&device->dev, silicom_led_=
info);
> +             if (err) {
> +                     dev_err(&device->dev, "Failed to register LEDs\n");
> +                     return err;
> +             }
> +     }
> +
> +     if (silicom_gpiochip) {

How can this be NULL?

Henry: OK, no need to check for NULL. Removed.

> +             err =3D devm_gpiochip_add_data(&device->dev, silicom_gpioch=
ip, silicom_gpio_channels);
> +             if (err) {
> +                     dev_err(&device->dev, "Failed to register gpiochip:=
 %d\n", err);
> +                     return err;
> +             }
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
> +     my_dev_ctl.my_dev =3D root_device_register(dev_name);
> +     for (i =3D 0; i < ARRAY_SIZE(my_dev_attr); i++) {
> +             err =3D sysfs_create_file(&my_dev_ctl.my_dev->kobj, &my_dev=
_attr[i].attr);
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

How can this be NULL?

Henry: in case something wrong with info->gpiochip


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
> +                    DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
> +                    DMI_MATCH(DMI_BOARD_NAME, "80300-0222-G"),
> +              },

Incorrect indentation x6.

Henry: fixed

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

How can this by NULL?

Henry: if function platform_device_register_simple() failed to regiseter, s=
ilicom_platform_dev will be NULL,

> +             platform_device_unregister(silicom_platform_dev);
> +             silicom_platform_dev =3D NULL;

Seems unnecessary.

Henry: It is need. I saw when registering device failed, the driver crashes=
.

> +     }
> +     if (my_dev_ctl.my_dev) {
> +             root_device_unregister(my_dev_ctl.my_dev);
> +             my_dev_ctl.my_dev =3D NULL;

Ditto.

Henry: It is need. I saw when registering device failed, the driver crashes=
.


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
> +     if (my_dev_ctl.my_dev) {
> +             for (i =3D 0; i < ARRAY_SIZE(my_dev_attr); i++)
> +                     sysfs_remove_file(&my_dev_ctl.my_dev->kobj, &my_dev=
_attr[i].attr);
> +             root_device_unregister(my_dev_ctl.my_dev);
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
> +

Extra newline in the end.

Henry: OK, removed.

--
 i.

