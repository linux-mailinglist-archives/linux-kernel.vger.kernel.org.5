Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01D777F90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjHJRsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjHJRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:48:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2117.outbound.protection.outlook.com [40.107.104.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F402D47;
        Thu, 10 Aug 2023 10:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICDfZkcV/NL4SlODOD1X5XY7PeABAZXpfJ3rXuWHz8VMSKhfVCFYsvzqdb0PQhorhSp29Yeok7VoSLKadnmP5jf715Vi6TlW9MS++pgv694ZEjiRK8VkMwzz9H9ahhU5lAVzMvnQIGlOSjtMspVUBPWrrICRi3A7zGekWWLGRDJRKH0qvDYbwlD0F9jlMEZFvdNHURhiZeB2qnRGBFRlfJ6A1bnl9Ac06dLVrdPI/MYsyLM0UDSMkEPymXIYZQi1vO3OqiH51J0V31mA3MBDyk/3xOkJdwr+6UO+TALxbxTJmsSTUHYaFyh18WVIKyT3YX/iJXH/liduWHiQJVUulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9ptBL72rB01dk/uKGXa7+DM91k+Xzq7l5EXWEF5N1I=;
 b=I/91EkoEnG0byU3/bSRxMCQrSSH9b2XA+wzyUXFz76lbd3PJx56Sqr4M3M26xpw+pksbzJnis9lQ7xUxMRTDR9P17j/IcqtLeZoqIQL1m572yPmmKemk5Osa3nwT7gq/blcyKX3jPXAe/4O6qdn8rKGnZOp8E2WT7i8hDR9U2MAd/jT988TTg7fZbwOFEuctF/Q+83PKh9KQzFT/xte4m2VDc7g2dsHkMtP6XM+h2VDN+CkRYq+yDS4e9ujmmpGkg0jaDM/uUdDb8C1aB2/kJBeam+6sTf9Rd2HZLj2zzAkVS8BkNEefdYBCRCPiW8dnHbo4KVRe9awOD+MLid2csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9ptBL72rB01dk/uKGXa7+DM91k+Xzq7l5EXWEF5N1I=;
 b=Pg801RQZyH98TXdJBzVNBB7SAlYNVUZzxqAMaYTCeDoHtfIEH9cX4aWfgDVLiSUPlxJ9+U9r8Zz7v6jmGShDKXQoXrbmMaqvLhuhowQ6jpmrWt1vULUJDl6NSe1Hpf7Nzzyo00RkGKIxh8kxru0v6gZcou14UUuH4tyB4EpXiIQ=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by DBBPR04MB8057.eurprd04.prod.outlook.com (2603:10a6:10:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 17:48:30 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 17:48:29 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZuZEcSTfJXOh+tEO5M8hB8nDqzq/BAaYAgAhCLzCAD07vAIAIVRGw
Date:   Thu, 10 Aug 2023 17:48:29 +0000
Message-ID: <PA4PR04MB922238E924D10FE9A5B2625D9A13A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <94cbb7d-68a-765-8bdf-5c8f8e41891@linux.intel.com>
 <PA4PR04MB922224D96319862CF987FE459A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <58da791d-866c-ce2f-94bb-1feff8506c2@linux.intel.com>
In-Reply-To: <58da791d-866c-ce2f-94bb-1feff8506c2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|DBBPR04MB8057:EE_
x-ms-office365-filtering-correlation-id: bef6beb2-ee60-4fb3-c784-08db99ca01f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbFbYGoTEVsnv0IMteDP16Wkll4L/wu4JaIe8XolnLum2rpmE/rAYDCWTqeohN8+OzoC7uRt63ucdA2yoLr8w69/P+dkHvUqPYXg80E29LGN/u7+z+Nj8g2a7RQVPE7s6PyAFxSFNvvDoILrXrX6MvPz6aad6JVVsyhBqUYBm+X3Wv+iUnvAfx5m7GQIlGBYI1hPFQ+mOoJ8vYlYFge8835DUUhLBnvEzP+ItFoqc21L6hRe1tt6JKG1DKB0zRCjlxKzEsq4IKdqwgXXUXTYBAtIqI01kpARmf4pmldEw870AxXj0ysntax4xgrw2OfHj+Rpj4V8N7wjzmm1jLssKH1fr1iig1gLnQvukVYWpAPwoPAnxu3NgEQ2XNxKXFyq+q7t2X8Kl19NtTwWH+w4SCyPN3Jf4DG8tAr9ocq1okTptXKMleWIXVm4S/qL95KhhK9nSXQ1vsb3B1omrxMIYSaLCyVbypBz66ik28FHhejaQyR3mXwRB1KFtA/2XnV9sk5EonV4QpvOB0tuWXQwBg5HJ0R1Vr0ZUyhrr7HmNuFKw0Ayl5y0K5zPyix2kDqIDcCloJA7NAQGasIRx6I5pfYfeU367+eVZv2mijJvPP3bfLFE8YdcfrOUr6ES6Fd3djsPsV1kHWWAlMFr6sVHZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39850400004)(346002)(136003)(366004)(186006)(1800799006)(451199021)(54906003)(83380400001)(30864003)(66574015)(38100700002)(122000001)(76116006)(2906002)(55016003)(8676002)(33656002)(316002)(8936002)(5660300002)(66556008)(7416002)(41300700001)(66476007)(64756008)(107886003)(66946007)(66446008)(53546011)(6916009)(52536014)(4326008)(86362001)(478600001)(45080400002)(9686003)(6506007)(71200400001)(38070700005)(7696005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Si+V8CSCztr7hOmjXWIGsXeni7+Wac9WTArGutuAv0h++PrMnDTR04bhkh?=
 =?iso-8859-1?Q?fPqb0q784mjuxb6pYVc7AasWpe6kJ8g5l5/GYsbGsm/1EtO9WOGZq6AUfW?=
 =?iso-8859-1?Q?lgbgOHlSxt+IAAajECLPra+zpyu6/nRuMdYZSb2or1UCwryWtwYYmc16rr?=
 =?iso-8859-1?Q?ZrCUTUnjUEN/7C3SgsxCItM0CHJNDECixD5oefZLDDtwtimUMg/jDcjTn3?=
 =?iso-8859-1?Q?H2J6ZUCMLYJQgzsaMAfVEWdEv0nQppk3m6qC3liRt9B9O/6SAoKnU4WSQl?=
 =?iso-8859-1?Q?ImZwlDgss+lNwwtMcfyu+cGxKtSUqaebjrkdSAQ5IVQ+F87WNoP6M295HR?=
 =?iso-8859-1?Q?UF0NIvne5aqxd8ZanGBIMBdjRAGL6237vnCOVKTuKzPCYNROAMgZoWuO71?=
 =?iso-8859-1?Q?z6d5qR8WSarAUdmD8aBsA6jVlxQvDaZt77NdMp0v8zEYQT6xiduduguTR4?=
 =?iso-8859-1?Q?lsLTEJpQKV+f242v+AAqzLH8lyKwoewr2p8DGDB5vgELE2sYDeljM7FdYR?=
 =?iso-8859-1?Q?FkTICacoPLqy6dYhl9+VYnO7UFnIK/hy0osmYVk4mqSd0bhsprFLMP8o4Y?=
 =?iso-8859-1?Q?NxmI1NtFpjgjLEyMfS7pOGVU7BzLc+OgOsOVcd2Z8cAP6GvoTNLNmpav7Z?=
 =?iso-8859-1?Q?ndpzYl0PbxrsC83TGIUhkVworL5uzeUOrYWi3mN+XPkCL/QRnc8shsQ3bZ?=
 =?iso-8859-1?Q?yNMMkXhXb9VhluT3gCUKj2xx4Q3KO1wHGVzQxqsjMsoIYp5dKzaBMcD4bk?=
 =?iso-8859-1?Q?8xDF3L1cQYdC953OhzhLNZ3m55OxNXfejLP8MRHFcxlu4CAkFCxsenHnr+?=
 =?iso-8859-1?Q?Wa3OVfJXA8BQvq+W49LxOjYolapCE9DyRJ0bw8VBXtFTU+Vf4cmryqWkUF?=
 =?iso-8859-1?Q?b8d7RmMm8Lpl4WuJny4iZKqLL5nD56CuuSdvdZ+7yuxuSizggAigHyYByC?=
 =?iso-8859-1?Q?BQnUKQT3iWoAXT/aF/zC2FvPYMoUsVzWiG6s+vqT0e+VomYTqBbzS7SMqr?=
 =?iso-8859-1?Q?Lx9/KuyYDFnzoz63GgNqudSBQAzaFSPtS1tWvjptzyv6Oxo8hjynlSQCDd?=
 =?iso-8859-1?Q?+46O3I+iw9IifpA4+q+jxIZN9DM9iK4Kv+sE2EaPCyu/wcqJmRqvhxwnEc?=
 =?iso-8859-1?Q?NJVsgxNjIzsgiYSgYNtQe6/r1RfwVjubXGHYLesh8fGK/M+D7z3sXykoDo?=
 =?iso-8859-1?Q?Mf/xiOyHtW84R2RWGrLDA4M5Js4JLSCtbuJ74ps2buCZYM461pUGKgI1IH?=
 =?iso-8859-1?Q?FKSiRIfykJqBry3afVfRhx1FfWMsOMsKQ41qRBmYbmcrKM4JMOZkEZrQcE?=
 =?iso-8859-1?Q?mOs/RqXC0yrBZiDgY1Uenzunjp+TAHWmapLzS6zE4xvETNg1lcyGjSOfGp?=
 =?iso-8859-1?Q?vjgEUI8ff5CGTX7KVQzO/fyVzlICE7fDKBkS1i+HDAbWSyk/iGJbQbfEX4?=
 =?iso-8859-1?Q?LlueLdL5lg6BzF6dbS5JJMUrnpbohrLfR+9jE+vMpGSv8WtEVPSww8uke2?=
 =?iso-8859-1?Q?AsYNWyMwGgq+EOKpNHxjxIX2Fjt8KaphJC3k/fb9A8dS0Xm/BQPTH+d3sc?=
 =?iso-8859-1?Q?6sWPCuHbG2NUgAEE6EaBS2q8KaOgNR0ujDpHdJLC0hgiaeaMPUVZozgZd/?=
 =?iso-8859-1?Q?QXoNwtLgZJJMfOYgH5AmaDlnaW8CsC2UXWW6OkbUwPC9NZJc06jOr/JHcR?=
 =?iso-8859-1?Q?IoqpNMDoyVfiT5lk6tC4ng1YXSi8oCbA9puMnyEd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef6beb2-ee60-4fb3-c784-08db99ca01f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 17:48:29.7705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2JMq7mVjVRF6yagqQpQPs7zLdplYlA33uw7rNKrWlfyS58IYV+xGxizq2HM5KN8mvPx7KP3m6WjkRLUFCvaKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8057
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilpo,=20

See my comments below.

Thanks.
Henry
----Original Message-----
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>=20
Sent: Thursday, August 3, 2023 8:07 AM
To: Huibin Shi <henrys@silicom-usa.com>
Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.i=
ntel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@ker=
nel.org; jdelvare@suse.com; linux@roeck-us.net; linux-kernel@vger.kernel.or=
g; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org; hb_shi=
2003@yahoo.com; Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver

Caution: This is an external email. Please take care when clicking links or=
 opening attachments.


On Fri, 28 Jul 2023, Huibin Shi wrote:

> Ilpo,
>
> Thanks for the comments. See my comments below.
>
> Updated patch will be sent out later after review comments from other rev=
iewer are addressed.
>
> Henry
> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Wednesday, July 19, 2023 8:13 AM
> To: Henry Shi <henryshi2018@gmail.com>
> Cc: hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com;=20
> bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org;=20
> hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org;=20
> jdelvare@suse.com; linux@roeck-us.net; LKML=20
> <linux-kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org;=20
> linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Huibin Shi=20
> <henrys@silicom-usa.com>; Wen Wang <wenw@silicom-usa.com>
> Subject: Re: [PATCH] Add Silicom Platform Driver
>
> Caution: This is an external email. Please take care when clicking links =
or opening attachments.
>
>
> On Tue, 18 Jul 2023, Henry Shi wrote:
>
> > The Silicom platform (silicom-platform) Linux driver for Swisscom=20
> > Business Box (Swisscom BB) as well as Cordoba family products is a=20
> > software solution designed to facilitate the efficient management=20
> > and control of devices through the integration of various Linux=20
> > frameworks. This platform driver provides seamless support for=20
> > device management via the Linux LED framework, GPIO framework,=20
> > Hardware Monitoring (HWMON), and device attributes. The Silicom=20
> > platform driver's compatibility with these Linux frameworks allows=20
> > applications to access and control Cordoba family devices using=20
> > existing software that is compatible with these frameworks. This=20
> > compatibility simplifies the development process, reduces=20
> > dependencies on proprietary solutions, and promotes interoperability=20
> > with other Linux-based systems and software.
> >
> > Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> > ---
> >  drivers/platform/x86/Kconfig            |   12 +
> >  drivers/platform/x86/Makefile           |    1 +
> >  drivers/platform/x86/silicom-platform.c | 1123
> > +++++++++++++++++++++++
> >  3 files changed, 1136 insertions(+)  create mode 100644=20
> > drivers/platform/x86/silicom-platform.c
> >

> > +void lock_io_modules(void)
> > +{
> > +     mutex_lock(&mec_io_mutex);
> > +}
> > +EXPORT_SYMBOL(lock_io_modules);
> > +
> > +void unlock_io_modules(void)
> > +{
> > +     mutex_unlock(&mec_io_mutex);
> > +}
> > +EXPORT_SYMBOL(unlock_io_modules);

These are unused.

Henry: This will be used by another Silicom driver, which source code is no=
t pushed to kernel repository.=20


> > +     u32 byte_pos =3D 0;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Select memory region */
> > +     outb(bank, EC_ADDR_MSB);
> > +     outb(offset, EC_ADDR_LSB);
> > +
> > +     /* Set to 1 for current date from the address */
> > +     outb(1, MEC_DATA(byte_pos));
>
> Hmm, this is really misleading. MEC_DATA() seems to calculate _an offset_=
, not data? Name things accordingly.
>
> Henry: OK, changed the defined to  "#define MEC_DATA(offset) ((mec_io_bas=
e) + 0x04 + (offset))"

Not much better, unfortunately. Call it MEC_OFFSET() or MEC_DATA_OFFSET() i=
nstead of MEC_DATA().

Henry: Agree.

> > +static void silicom_gpio_set(struct gpio_chip *gc, unsigned int=20
> > +offset, int value) {
> > +     u8 *channels =3D gpiochip_get_data(gc);
> > +     int direction =3D silicom_gpio_get_direction(gc, offset);
> > +     int channel =3D channels[offset];
> > +     u8 reg;
> > +
> > +     if (direction =3D=3D GPIO_LINE_DIRECTION_IN)
> > +             return;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset from the channel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +
> > +     /* Get the current register */
> > +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> > +     if (value =3D=3D 0)
> > +             reg &=3D ~(1 << (channel & 0x7));
> > +     else if (value > 0)
> > +             reg |=3D 1 << (channel & 0x7);
> > +     else
> > +             pr_err("Invalid GPIO value: %d\n", value);
> > +     outb(reg, MEC_DATA((channel >> 3) & 0x03));
> > +     mutex_unlock(&mec_io_mutex);
> > +}
> > +
> > +static int silicom_gpio_direction_output(struct gpio_chip *gc,=20
> > +unsigned int offset, int value) {
> > +     int direction =3D silicom_gpio_get_direction(gc, offset);
> > +
> > +     if (direction =3D=3D GPIO_LINE_DIRECTION_IN)
> > +             return -EINVAL;
> > +
> > +     silicom_gpio_set(gc, offset, value);
> > +
> > +     return 0;
> > +}
> > +
> > +static int silicom_gpio_get(struct gpio_chip *gc, unsigned int
> > +offset) {
> > +     u8 *channels =3D gpiochip_get_data(gc);
> > +     int channel =3D channels[offset];
> > +     u8 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset from the channel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +
> > +     /* Get the current register */
> > +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> > +     mutex_unlock(&mec_io_mutex);
> > +
> > +     return (reg >> (channel & 0x7)) & 0x01; }

> > +static void silicom_mec_led_set(int channel, int on) {
> > +     u8 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset from the channel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +     /* Get the current LED settings */
> > +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> > +
> > +     /* Outputs are active low, so clear the bit for on, or set it for=
 off */
> > +     if (on)
> > +             reg &=3D ~(1 << (channel & 0x7));
> > +     else
> > +             reg |=3D 1 << (channel & 0x7);
> > +
> > +     /* Write back the updated register */
> > +     outb(reg, MEC_DATA((channel >> 3) & 0x03));
> > +
> > +     mutex_unlock(&mec_io_mutex);
>
> There's an identical code block in silicom_gpio_set(). Why not simply=20
> call this from silicom_gpio_set()?
>
> Henry: these two block of date are different: silicom_mec_led_set(xxx,=20
> int on), argument on, when on is 1, it means turn on LED; 0 means turn=20
> off LED. For  silicom_gpio_set(), the argument value, which is really=20
> the 0 or 1 bit value that passed to reg.

The necessary conversion (and checks) can be made before/when calling the f=
unction from another. The code is so identical that I don't buy it cannot b=
e done (I've diff'ed those functions against each other so I know for sure!=
).

Henry: OK, I will change it in next submission.

> > +}
> > +
> > +static void silicom_mec_led_mc_brightness_set(struct led_classdev *led=
_cdev,
> > +                                           enum led_brightness
> > +brightness) {
> > +     struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(led_cdev);
> > +     int i;
> > +
> > +     led_mc_calc_color_components(mc_cdev, brightness);
> > +
> > +     for (i =3D 0; i < mc_cdev->num_colors; i++) {
> > +             silicom_mec_led_set(mc_cdev->subled_info[i].channel,
> > +                                 mc_cdev->subled_info[i].brightness);
> > +     }
> > +}
> > +
> > +static enum led_brightness silicom_mec_led_get(int channel) {
> > +     u8 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Get the dword offset of the register for this LED from the cha=
nnel */
> > +     outb((channel >> 3) & 0xfc, MEC_ADDR);
> > +     /* Get the current LED settings */
> > +     reg =3D inb(MEC_DATA((channel >> 3) & 0x03));
> > +     mutex_unlock(&mec_io_mutex);
> > +
> > +     /* Outputs are active low */
> > +     return reg & (1 << (channel & 0x7)) ? LED_OFF : LED_ON;
>
> Looks identical to a part of silicom_gpio_get(). Perhaps it should call t=
his function??
>
> Henry: some of the code block of these two functions are similar. But=20
> function return types are different. Gpio has status of 0 or 1, but=20
> LED has status of LED_OFF and LED_ON.

The same comment as above for the set. I think the return types can be conv=
erted in the calling function before returning.

Henry: OK.

> > +static int __init silicom_platform_info_init(const struct=20
> > +dmi_system_id *id) {
> > +     struct silicom_platform_info *info =3D id->driver_data;
> > +
> > +     dev_info(&silicom_platform_dev->dev, "Detected %s\n",
> > + id->ident);
> > +
> > +     mec_io_base =3D info->io_base;
> > +     mec_io_len =3D info->io_len;
> > +     silicom_led_info =3D info->led_info;
> > +     silicom_gpio_channels =3D info->gpio_channels;
> > +     silicom_gpiochip =3D info->gpiochip;
> > +     if (silicom_gpiochip)
>
> How can this be NULL?
>
> Henry: in case something wrong with info->gpiochip

But how can that occur? Both struct defining silicom_platform_info provide =
a non-NULL value. There's no need for such safety construct which cannot be=
 every true within the kernel code.

Henry: OK, will remove checking.=20

> > +static int __init silicom_platform_init(void) {
> > +     struct device *dev;
> > +     int err;
> > +
> > +     /* register a platform device to act as the parent for LEDS, etc.=
 */
> > +     silicom_platform_dev =3D platform_device_register_simple("silicom=
-platform", -1, NULL, 0);
> > +     if (IS_ERR(silicom_platform_dev)) {
> > +             err =3D PTR_ERR(silicom_platform_dev);
> > +             pr_err("failed to register silicom-platform device: %d\n"=
, err);
> > +             goto silicom_init_register_err;

Instead of goto, return directly as there's nothing to rollback:

return err;

Henry: OK.

> > +     }
> > +     dev =3D &silicom_platform_dev->dev;
> > +
> > +     err =3D dmi_check_system(silicom_dmi_ids);
> > +     if (err =3D=3D 0) {
> > +             dev_err(dev, "No DMI match for this platform\n");
> > +             err =3D -ENODEV;
> > +             goto silicom_init_probe_err;
> > +     }
> > +
> > +     /* Directly probe the platform driver in init since this isn't a
> > +      * hotpluggable device.  That means we don't need to register a d=
river
> > +      * that needs to wait around in memory on the chance a matching d=
evice
> > +      * would get added.  Instead run once in __init so that we can fr=
ee all
> > +      * those resources when the __init region is wiped
> > +      */
> > +     err =3D platform_driver_probe(&silicom_platform_driver, silicom_p=
latform_probe);
> > +     if (err) {
> > +             dev_err(dev, "Failed to probe platform driver %d\n", err)=
;
> > +             goto silicom_init_probe_err;
> > +     }
> > +
> > +     return 0;
> > +
> > +silicom_init_probe_err:
> > +     if (silicom_platform_dev) {
>
> How can this by NULL?
>
> Henry: if function platform_device_register_simple() failed to=20
> regiseter, silicom_platform_dev will be NULL,

Ah, sorry. I should have mentioned that that branch should return error ins=
tead rather than gotoing here.

Henry: OK.=20

> > +             platform_device_unregister(silicom_platform_dev);
> > +             silicom_platform_dev =3D NULL;
>
> Seems unnecessary.
>
> Henry: It is need. I saw when registering device failed, the driver crash=
es.

From which access of silicom_platform_dev??

> > +     }
> > +     if (my_dev_ctl.my_dev) {
> > +             root_device_unregister(my_dev_ctl.my_dev);
> > +             my_dev_ctl.my_dev =3D NULL;
>
> Ditto.
>
> Henry: It is need. I saw when registering device failed, the driver crash=
es.

Ah, I didn't notice it before but this should be properly arranged into rev=
erse order such that goto xx can target the correct amount of rollback (in =
reverse order than init). Add xx labels as necessary for each rollback step=
 you need to jump to.

Henry: OK.

> > +     }
> > +
> > +silicom_init_register_err:
> > +     return err;
> > +}


--
 i.
