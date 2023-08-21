Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02904782E52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjHUQXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjHUQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:23:15 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2125.outbound.protection.outlook.com [40.107.13.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF5E8;
        Mon, 21 Aug 2023 09:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFXYhhtV9NCXtq7iQToTf+4UBEJoCSflw7W3owqX54Ho5KAdRSYO3tgVL+5ttgGLsgG018fxYOkctejMxXfuuqtcxYUB4/6sfQz0R8/mGp2tlFuzVRWTCYbJv8XwQcQ2jyykbg5Ll8F0m/gwKOI6vIGuVPjFNyKxdezjqI6LVqDCqUr8Owb+behasqfbBYuvObR3mbiYew080+/7LWnoombCsAmugIrKSoAcaCNGhvYtOmR6ipbDD2rhlvfI7QWmIR3g6EDeXq1mtlzyQomFvMR3CA1w+CPlaZ837lpBrK3J9th8XfrSk0NYy73G8iBwew4sXRUlTOwu64af/d1F6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0zP44al7Mwd9VCHpsJRuguL1rNHGy5CXW07SzibznY=;
 b=DBIvpJBfBaEgnlh5gN3Qz777HAsMP/mtnD9OdbscDN5WNai4EdQNVS2pASCl6VyHY++LKGbySR2wNekUnhH7eK8g0lmNKbbfaUuVq5wS/F9mWYqPriGt1C42UVuv1HSCfObyR9SZTgH3EtICe61BNVg/f1W+c7IHgcg4Xk854BIL/PrpRvWyKlKKxTzL88C94dAmwLkiaBLsUwEoYruwOZEdnK+tCZGVgTEUr2fHyULI1M9CwPPt+l3eC3eWVdsGEC14vKLmovwg+mcQiQX9IiUs9aGwG5BRRCQZVRSG0XtFxqKu0CbKPmZzkV6EwDQLwex8rKmU2ZLwzmfpgAY0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0zP44al7Mwd9VCHpsJRuguL1rNHGy5CXW07SzibznY=;
 b=N/3Xx2BZnHiVgCCryvXYoA1m87aE17wT2DygjfL/X1D6o8QnO0BLaSrTp32L5jdnWKRPwxHKE1X0428a3QTLubTnBN6maEhBXDtgUR4VqdF4fcT5KwjcbwDsXxx0Cqx3hxQ5GPMWj+F7+Fussw77fHpDjtEwEW3ikeTlM+xvJKw=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 16:23:08 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 16:23:08 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
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
Thread-Index: AQHZ0erQKIGuJyMiIEioe7g7XMHTza/xkQCAgAAWSwCAAAnggIADNjHAgAAIbQCAAAGaMA==
Date:   Mon, 21 Aug 2023 16:23:08 +0000
Message-ID: <PA4PR04MB9222A8B83329A105DD1BEFD09A1EA@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230818154341.20553-1-henryshi2018@gmail.com>
 <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net>
 <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
 <PA4PR04MB9222CA6111C291AE1C7D1B3D9A1EA@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <b0ad739c-7c96-4603-87aa-94fbce220ec8@roeck-us.net>
In-Reply-To: <b0ad739c-7c96-4603-87aa-94fbce220ec8@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|PA4PR04MB7919:EE_
x-ms-office365-filtering-correlation-id: 4df4ee2c-6258-4c15-d32f-08dba262e7f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rmNQJNG/FLB+At3nDDOix6GcFe+sxrKLtK2wjrPpyJn0SK9ymzVgIg6zHuDp9nCsREtxPO41YgaZ+++b38aP85L8nn3ja/dmDRONH1MHeMZK3BZvqXDWrhCEaj+2dAZX5ACFFTSymAZ3rfOibXPc/7wzv8g6IJlQok1arKQkcrZjCSz6ADXyRZW18qYnK4F23CCUOEdT0JlJwT7rlU0O4l/RcJKyAz9gZSpTIY1hgkTigkylUPBdvJEpCR8pJlnDBvDP4GGa1aY97Fpo9RT5araDDkAwOyl+2E1913DJomhimggPfg7ozQr97eF8scIER8pX7EcveWPaCQ1MoLdKL5aCS7ia2bVyJvZBDS6GN6L7ULlMziMix1/8ypbGONgDBA9gYFLN7ZtxHLcJbdUapt95nsTPllOEuQgubkOlnLQNQjcfjI1YVj2PSLMUvmvkZ1dKqs29aBqOS06jKqfaeh9M/CCFyrIHib+M+HCdKzTHozkLJb6iBFl0UFeyVTpl8Hmt46N+UtB/lRmKHsQ6ZQPfjIux7ImSIwqtQ07TYNI92Xd3Tin6dtQonEneSyzKC+p+q/SthpzHbN436ccb/r5pvxgXCi+7KE07jMhkPp20f17wMkYUdUegBXbKeIvR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39850400004)(136003)(1800799009)(451199024)(186009)(478600001)(107886003)(71200400001)(53546011)(9686003)(7696005)(45080400002)(4326008)(8936002)(83380400001)(8676002)(2906002)(52536014)(5660300002)(7416002)(6506007)(316002)(54906003)(41300700001)(76116006)(66556008)(66476007)(6916009)(66446008)(64756008)(66946007)(38070700005)(38100700002)(33656002)(55016003)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?deqfEWHvRq1zB4iw5/EaocvZL7dOb9HW6ftdd0eZmgPITT26bGhaawh0YXkp?=
 =?us-ascii?Q?fXNbAulmwQDvnW97300h2/ZkodLx3ne/laZhw9vls18LUYjmJ5hWR704fwZQ?=
 =?us-ascii?Q?vQQn1X1gRjPo5QrjtTuaTFynEqHbTpc1/yaQEcMPf0hHmKKQAdUPMRktpGhR?=
 =?us-ascii?Q?siJtmqorPr4VehE8mmh6SLIrONiUnsu+NaJ8R/AB8slq7dSKciVrQDl+FxIB?=
 =?us-ascii?Q?brCm0B5mIOBQaASFHeY6kWv8lRQuvdtRKvuCWBZg8NxZS9scLSc4F6Ecnyfl?=
 =?us-ascii?Q?IM8vgtOpXuOySd1mPmGQn+vnUQDZUoNkSiu8TN55T76iNqD/1wJPPDr4EOtv?=
 =?us-ascii?Q?djdJQrKzJyutgxZE2kH+bHu5hi7DLaXmY15rxnoW8zP9C2YhP1ortTLrd3is?=
 =?us-ascii?Q?Jl3NVNhAIz6CrvY5Cs5GdcIqi71q1L6jSDskym793iSA/YwHIgUQUEL7aHpM?=
 =?us-ascii?Q?W4lEEWTyKl36GrQXvGT9MAwjkpUq1onJSPcKjEraYHxL6WcbUaAc7HmHrcfK?=
 =?us-ascii?Q?LXsYWA9RPgOKQDsR8+F+U2cL0e/Qwoe9RqdYJOUQXYJ1EmzWPspwqKQrZaOT?=
 =?us-ascii?Q?Mqop0Pt8BC8cP/zyqNzmc5vvrSXOPQxULME1p5z7mueF9x5uem4MmMtzMSZi?=
 =?us-ascii?Q?+YBMRoyQw91e2Js7AtvaLZ6VAxtKva0QGv8LinLvfRoExujjv6deDAC4m3WM?=
 =?us-ascii?Q?oCGor3Mc4YkU9V1QIE0X4tFgiPkXMs+h7jzW2kfv9V5Yf922qt+oCvUK43V3?=
 =?us-ascii?Q?NNTyX3jBaq5PNLffuMGnoje9RsactRTMFLF6DgMDaeRaIHz0vWfcA9091nCH?=
 =?us-ascii?Q?41Eph4d6jB67SCmqHeAq+nsaUL6nhDYDsXFLkV4rjhx+zJPe+0uEshfYX3uN?=
 =?us-ascii?Q?pUHt5gz9Pstc9JLEkd62NdG/27vRooCncBezYs2duovgk4deQlbI/xS2iTUF?=
 =?us-ascii?Q?PedMLrgfLVLouTR49Qq4YvMiEhpDDYuim+QPOptxU+Xw5S9rNV85QvMMk7Ak?=
 =?us-ascii?Q?hp4lme/behDj4WGGDun0dyTHEmtN8S2JhRV0EYGKFB/p6T6lyXG9kH/LB4mk?=
 =?us-ascii?Q?WDiBv87Tpi2ZOzd7GjyRhQeSoTmOcK0cpFw/7++tXWK9Uxpf6HQ+h6sTL19J?=
 =?us-ascii?Q?N8NimuK62mOaS+ckFMmSK94OZQ1yGHmzR37CzS9Tfk30PQyW1BeoL2QU28Yc?=
 =?us-ascii?Q?q8iQ7QYpET0ue6wetfP4gkDkoGZrtpjpBhA+Cv5KGVdgq8wmOYcUvDk2SKlT?=
 =?us-ascii?Q?dfRVhHYQHzxmG+NXC9lFO8yn/wPe2DUqUQ4XJMtd3lheP3u490ie4lTa/9TR?=
 =?us-ascii?Q?CXv1WeG2iB3a0yx8v9fr7mB2fcFlSy3agOwvtEmphxAJGqjcvAZui/ctj2if?=
 =?us-ascii?Q?El/Uc8NUdmUClDGC/sudnqLWbR27+u/6WuNUpz//NjsGlsVY7g7oAw+C+UOG?=
 =?us-ascii?Q?jvzP4EZyj7Ilw2F7QR8YBp+K7MG0B9GzPf9QJr2CWZEmls+P7oZynaWX2X2i?=
 =?us-ascii?Q?KCUjJ6iVJpFzUQ7bUMaq+Jt79vfzyoYZ57HT1So7NAO52quDFG3DTw2dTeWj?=
 =?us-ascii?Q?s9TD/la+C2kW9Ey3I8e/iAWvW+klou6cJMKTHDsQnBHvILs5N1DuDjRSzjQw?=
 =?us-ascii?Q?vA2gj9qWqHnQOPjBBSica7x/JY68aSpHLBP6QnjAn3yK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df4ee2c-6258-4c15-d32f-08dba262e7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 16:23:08.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44iz2bBElli4eyI3CJDMGmj6XSO6GsKEYzTVjGp4DFXaTDmaQNGQlTzf/GY4kDiQQegRNdyN+gh8UpF/r+gT8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

OK, I see your point. I will make the change to let driver return milli-deg=
rees return (reg >> 16) * 100.

The 32 bits register exposed by micro-controller has its upper 16 bits repr=
esent temperature.

Thanks
Henry

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Monday, August 21, 2023 12:09 PM
To: Huibin Shi <henrys@silicom-usa.com>
Cc: Henry Shi <henryshi2018@gmail.com>; hbshi69@hotmail.com; tglx@linutroni=
x.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kern=
el.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@=
suse.com; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org=
; linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Wen Wang <wenw@silicom=
-usa.com>
Subject: Re: [PATCH] Add Silicom Platform Driver

Caution: This is an external email. Please take care when clicking links or=
 opening attachments.


On Mon, Aug 21, 2023 at 03:48:33PM +0000, Huibin Shi wrote:
> Guenter,
>
> See my comments below.
>
> Thanks
> Henry
>
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Saturday, August 19, 2023 10:36 AM
> To: Huibin Shi <henrys@silicom-usa.com>
> Cc: Henry Shi <henryshi2018@gmail.com>; hbshi69@hotmail.com;=20
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;=20
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;=20
> hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com;=20
> linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;=20
> linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Wen Wang=20
> <wenw@silicom-usa.com>
> Subject: Re: [PATCH] Add Silicom Platform Driver
>
> Caution: This is an external email. Please take care when clicking links =
or opening attachments.
>
>
> On Sat, Aug 19, 2023 at 02:20:32PM +0000, Huibin Shi wrote:
> > Hi Guenter,
> >
> > Thanks for your comments. Probably, I should not resubmit patch too rus=
hed. I will add version number to subject and change log in cover letter fo=
r next resubmission.
> >
> > See my comments below. Please let me know whether you accept my explana=
tion.
> >
> > Henry
> > -----Original Message-----
> [ ... ]
>
> > > +
> > > +static u32 temp_get(void)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     mutex_lock(&mec_io_mutex);
> > > +     /* Select memory region */
> > > +     outb(IO_REG_BANK, EC_ADDR_MSB);
> > > +     outb(0xc, EC_ADDR_LSB);
> > > +     /* Get current data from the address */
> > > +     reg =3D inl(MEC_DATA(DEFAULT_CHAN_LO));
> > > +     mutex_unlock(&mec_io_mutex);
> > > +
> > > +     return (reg >> 16) / 10;
> >
> > The hwmon ABI expects temperatures to be reported in milli-degrees C.
> > The above sets the maximum temperature to 65,535 / 10 =3D 6,553 milli-d=
egrees or 6.553 degrees C. It is very unlikely that this is correct.
> >
> > Again, I commented on this before.
> >
> > Henry: this is due to an internal implementation of MIcor-controller fi=
rmware, instead of putting real temperature to the register, it put (real t=
emperature * 10 ) to the register. So, in order to report correct temperatu=
re to user space application, the read value is divided by 10, then report =
to user space.
> >
> > Please let me know if you accept this. If not, I can change the code, b=
ut let user space application to do adjustment.
>
> No, I do not accept this. I do not believe that the maximum temperature r=
eported by the microcontroller is 6.553 degrees C. I suspect it reports 10t=
h of degrees C. In that case, the number reported should be multiplied by 1=
00 to make it milli-degrees C as expected by the ABI.
>
> Henry: OK, I will remove "/10" in driver, and let user space application =
(or script) to the calculation.
>

Sorry, I completely fail to understand why you refuse to follow the ABI.
The temperature must be reported in milli-degrees C, not in some arbitrary =
unit, period.

FWIW, that really deserves a NACK now.



Guenter
