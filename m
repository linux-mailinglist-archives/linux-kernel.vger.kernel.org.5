Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6515B782D84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjHUPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjHUPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:48:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2098.outbound.protection.outlook.com [40.107.7.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674EEA1;
        Mon, 21 Aug 2023 08:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNqo8Oj/PB/fJXSE7rA+b+CAGj0eWO76CLHVFna+fTZv97R/Ng+mYhrswvYi+5SeR9W8LsVpW3N+/syzkUEoxphygAm5t8zRVn9uykDSl7K3tdEYyMsLJsQORCDNkEWy6CjKDCrnLRnEcakMCQ/r+eBztsmSTrM4mMUNndonbe76kSZyzZ64dglWURJLnzyeQlar6BiX7UEuxHIKkhW6axG+uy3qFnMIu/lxsN+ylSHl6xYqc43kVXeZm9zx+LP7PwjU22U12Vo3gxkGB+JsxSFQsVH8mC3t07l77pyP0Mo4R6UapYCfBqR47n59hP7HraRr1DZ6hMOylcMUQ1TI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtoWvOfeldTYGE55hsufUxHhvZzYf3beR8VAkpWWdH8=;
 b=nUSdHxdOgt3miETgxjPVTejOFG8fRXFRZZsNmdOgc1zDIUaPLuK7oOx3uEz2rSd2eyRo6VzJzeatyWnWRQs31n3gS+oN9z9B4dYgVwNtn/rBY4rALZyvHJrApih2nNM2/8C35fDwzdBCF+ht5SjVvn++WsmePEdSEWFAexCy0ebBlGzLqa3B1Oc4eBoBFUEkHqs9eAdCNhT3AtY5ngBIUmRSI8xpHLsqu5yaO2NfQuJ2rIib4qVpoJd8li0JDvda0IJjDibO4RpOG4pYePomHroQyHYMxmDr86TvoqcZLtF5XImeV1urJvGYpywad5axt61Gf0JYJpxMfOhlSPycrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtoWvOfeldTYGE55hsufUxHhvZzYf3beR8VAkpWWdH8=;
 b=E4gsoWBfF0na9c5hD74ch+xyvbv+2+VRtoCDh9Y1ktVdmhqALe3UUhyPTkdcxF0dXRBOx/kdJPXhLuL9LjVKca4bGi+vbH/cgiHO1c9IRXxQaxW0l0u6T853kdjlGkCqkfnAQs7q91N8nM3B72YkPZyrGeRujoV+P0qgwbi7On8=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 15:48:33 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:48:33 +0000
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
Thread-Index: AQHZ0erQKIGuJyMiIEioe7g7XMHTza/xkQCAgAAWSwCAAAnggIADNjHA
Date:   Mon, 21 Aug 2023 15:48:33 +0000
Message-ID: <PA4PR04MB9222CA6111C291AE1C7D1B3D9A1EA@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230818154341.20553-1-henryshi2018@gmail.com>
 <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net>
 <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
In-Reply-To: <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|GVXPR04MB10071:EE_
x-ms-office365-filtering-correlation-id: ee0742b7-c232-4a17-fe87-08dba25e1334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4c5VyiBzUVF14duB+1bZy/SSQLey5hs2JGrMxTwLLDtKzTu9YUMIHAmJEmqVF4bGvkKuA1hRGYl3oDIUcJ4AyYdDbs162ilWAKeEQQh+jDwzVhLCtxAaYEPTbkxlS2jhwLvpbcr/r8m1kPaFi63E4nzuxn0OGdVxLxrOd1EtacGxgoScULiiIuRGDdWAWnRQwyty9bor/F51a5gLV41lwD4Xq9ETJwpH7Sgd0+vHjkwvksnTOUbHZz+hNMDm+FP+OIBhYMsKfjEJb8RiKTNg6qWHsAGGBLW6b87Wddr5cpe1w7fuFSQFw/y7/aMcPgk6tZf235U4LIY6RPznOIWcoBc++bVJVl3D8ec9/y/U2i6YUmjsTqVTkgh38HsfR1VHwnm7S4s7B2ZxmZ3tl67NfQwr8dU+PWwQ0sik3V2Ic5ZmCIdOFBl3MmxXoCnzkoGCkDcNi4itdEpwhZQ4Jz2rX41bOyvUrPG3n/aSXuYHzD7ev+zjfoG2/vYIySFY3SSV6ebyxCXPbVqf9dl55mDdfHFHjX1WJ8uq98+GkLEAQnAxJWI9fi7bmlfv22MNl0qxnK5sGmSoSlI7DllV57OF0HYN/EbJ2MPbPKxnX2agqYrmM9LE4ileUXoqyslbOZB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39850400004)(451199024)(186009)(1800799009)(122000001)(316002)(107886003)(9686003)(6506007)(71200400001)(53546011)(7696005)(45080400002)(4326008)(83380400001)(5660300002)(8936002)(8676002)(2906002)(52536014)(7416002)(41300700001)(64756008)(76116006)(66556008)(66946007)(66476007)(66446008)(54906003)(478600001)(6916009)(38070700005)(38100700002)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nAZDUPS07qP0goe8Xy+8DoaW+st++s7SRcvD4ygISiC9ZlWVw2sXRViArfzK?=
 =?us-ascii?Q?sijFhICq+v2yUc1A0CGzMxmddLkAVM1fy0JlrCTonTQb42jSqq5A9fy2RtAl?=
 =?us-ascii?Q?q2v+hYlr39bcbiIO7skOHB9+NAWxiNMRR/l4qHSgVx9D71/fUNAkUA2wdVd1?=
 =?us-ascii?Q?mTArWmE/nMK/71FcF6oRhW60z/jYDwd3ixP1f3sT+I6OSx4dhyy2HtmfhZne?=
 =?us-ascii?Q?eEH9STOaWJcAxcSBLPF74rR2vLtb26hlqqnNLTQrZ5ZksppQ6rlXOP3QqoxM?=
 =?us-ascii?Q?QRU6Po5iY2vBZgzq0ftYBhj72O4yBz2AVTCyHaiHLaY95ajLRYJ4gb/JY8wZ?=
 =?us-ascii?Q?S7KdK9s8br0ZF5wMQYLLfBaj3wGjrGS+Q62ljGlXWlHyNVMOTTwT43N/drSZ?=
 =?us-ascii?Q?C+jOXi/FG9NAVpYt62H3V04Z8cTcvKxUamCiHoirh1L2PIp/N1Sanl5KldSF?=
 =?us-ascii?Q?tYqwD+llgTKT/juYPoKUfCHWAQ5ZT/+P/w0kkcLfjLyXlvxuErZYC1W/kv9H?=
 =?us-ascii?Q?Ic2HKC/XQfjztER54VEjFz8O2fUvtHxgKrwNqi057FZjj64ZC3yDeUAK0u5B?=
 =?us-ascii?Q?vwEMcIL68bizGtFz33Wn+VNdNZtNLG0KEsDBtopAk89j9qIwgOf5fM3SFeob?=
 =?us-ascii?Q?rdXu5TXcH1vsJnRnkHcqk1kCnag/z/VjDZ4pDvGinWzNuaPAfA2q61O0yuXX?=
 =?us-ascii?Q?HyGvideoU9g9dNhbzJ3jxq373BrVcF8eGLjaWVAw3d+uk4E7KAlvzDTtFh4Q?=
 =?us-ascii?Q?lzA9GVN8jngefW7t9TfjmReFFY7QwzJDVbFFUJMt6Lzc8fbo5ekCfo13geG7?=
 =?us-ascii?Q?3Oo5RcvYi7ARpECENic2in/3f84hJvLBxrrv5GYFJWSzHQSev2/I2Bwi5rZZ?=
 =?us-ascii?Q?+TUnGbKm9AtPs4PgoO8VxkX97YpUfZ1j1xBAZyqHRhbuPOuJZo3k1aPg2nsi?=
 =?us-ascii?Q?dhRLJ5nndFyaWWeeJ3lU7axVtIrnKQroPE2+YKAQFicYXbpdmftUs/4Ak4bk?=
 =?us-ascii?Q?JSvzusgk+2KgF+jk9dtBi/QxLV67Gzq6ryOR4MPRwhjI2zUdsawKYWVFtHvX?=
 =?us-ascii?Q?1v4c7zT2m4dVTUFLhMInT2LL7hdiJUr9s7OuBxdhI49EaLREig4KIC1Zcc07?=
 =?us-ascii?Q?uufPBvgqL4j2Eq2i/oOYdj2YNb9IBB81DCPEhFkwpka+kYE88Nqq8GYr7BXP?=
 =?us-ascii?Q?pQ3UEotJcY69zaaEfrINSWyNttxhgurWKmRBudMVAUbEwh4yyjJk5bL4PZCz?=
 =?us-ascii?Q?1Ce+FkkvjdfdaRmWVtbSldmbSHNzYmv1T6dVw2hhx1G88wcHbmySRPvKTXYW?=
 =?us-ascii?Q?7yeJnP9IwjLFnpWnennbGdeQLBQtGhp7QjCqCdL0M60+YUnX7H4kvejnmSv3?=
 =?us-ascii?Q?sVPPsOdbMOlgZDkHWsYmsY763ZJt54F22/udjA3zMGlCawwuP+L38Z7eh9CU?=
 =?us-ascii?Q?1cML6CXTXjLbyvcupeJzR8fYAnPOFkBXFE60Y0QHyl4ZlZe8BOvnLotIO42z?=
 =?us-ascii?Q?ECoPb9+WB8sBFErTLJR6fdNZgJkekjQ//ysOMI4bdbTjux1AzocDAKbiiBBv?=
 =?us-ascii?Q?/RIRlErFzg7Xufaxkf2XqL//oGrvrB9aJuzhjWEpiPUlMoiPchXkJVjZUmme?=
 =?us-ascii?Q?iSQx7surGF5oH367REJFu7q8ZBGYy7C6KC/9ud0n0KC8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0742b7-c232-4a17-fe87-08dba25e1334
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 15:48:33.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoYQiY51OlB1A3e92nuhh7yqscvUD9iFXP9IDf0A7PiTydyNLg0rUe05yhOb+oiVEvRxxhMgKztZPcAUSLzTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter,

See my comments below.

Thanks
Henry

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Saturday, August 19, 2023 10:36 AM
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


On Sat, Aug 19, 2023 at 02:20:32PM +0000, Huibin Shi wrote:
> Hi Guenter,
>
> Thanks for your comments. Probably, I should not resubmit patch too rushe=
d. I will add version number to subject and change log in cover letter for =
next resubmission.
>
> See my comments below. Please let me know whether you accept my explanati=
on.
>
> Henry
> -----Original Message-----
[ ... ]

> > +
> > +static u32 temp_get(void)
> > +{
> > +     u32 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Select memory region */
> > +     outb(IO_REG_BANK, EC_ADDR_MSB);
> > +     outb(0xc, EC_ADDR_LSB);
> > +     /* Get current data from the address */
> > +     reg =3D inl(MEC_DATA(DEFAULT_CHAN_LO));
> > +     mutex_unlock(&mec_io_mutex);
> > +
> > +     return (reg >> 16) / 10;
>
> The hwmon ABI expects temperatures to be reported in milli-degrees C.
> The above sets the maximum temperature to 65,535 / 10 =3D 6,553 milli-deg=
rees or 6.553 degrees C. It is very unlikely that this is correct.
>
> Again, I commented on this before.
>
> Henry: this is due to an internal implementation of MIcor-controller firm=
ware, instead of putting real temperature to the register, it put (real tem=
perature * 10 ) to the register. So, in order to report correct temperature=
 to user space application, the read value is divided by 10, then report to=
 user space.
>
> Please let me know if you accept this. If not, I can change the code, but=
 let user space application to do adjustment.

No, I do not accept this. I do not believe that the maximum temperature rep=
orted by the microcontroller is 6.553 degrees C. I suspect it reports 10th =
of degrees C. In that case, the number reported should be multiplied by 100=
 to make it milli-degrees C as expected by the ABI.

Henry: OK, I will remove "/10" in driver, and let user space application (o=
r script) to the calculation.

[ ... ]

> > +static int silicom_fan_control_read_labels(struct device *dev, enum hw=
mon_sensor_types type,
> > +                                        u32 attr, int channel,=20
> > +const char **str) {
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             *str =3D "Fan Speed";
> > +             return 0;
> > +     case hwmon_temp:
> > +             *str =3D "Thermostat Sensor";
> > +             return 0;
>
> Those labels have no practical value.
>
> Henry: Those labels will be used by user space code to identify Silicom_p=
latform driver.
>

The driver is identified by the driver name, not by the name of a temperatu=
re sensor or fan speed attribute. Any other driver could return "Fan Speed"=
 or "Thermostat Sensor" here. Userspace relying on such values to identify =
the driver are simply broken.

Henry: Good point.=20

When this driver installed, there is one directory created under /sys/class=
/hwmon/, called hwmon#. The exact # for the newly created directory can be =
different at run time. So the intention here is let user space software to =
identify the right directory for Silicom-platform driver. I can change the =
driver return to "Silicom-platform: Fan Speed" and "Silicom-platform: Therm=
ostat Sensor" to identify silicom-platform driver. Any objection?

> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static const struct hwmon_ops silicom_fan_control_hwmon_ops =3D {
> > +     .is_visible =3D silicom_fan_control_is_visible,
> > +     .read =3D silicom_fan_control_read,
> > +     .write =3D NULL,
>
> Unnecessary.
>
> Henry: OK, will be removed silicom_fan_control_is_visible.

The NULL pointer assignment is unnecessary. I have no idea what that has to=
 do with silicom_fan_control_is_visible(), or why you would want to remove =
that function.

Henry: OK, will remove the NULL pointer assignment.

Guenter
