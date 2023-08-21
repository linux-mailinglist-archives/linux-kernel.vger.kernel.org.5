Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F317782DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjHUQAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjHUQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:00:34 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5ADB;
        Mon, 21 Aug 2023 09:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhygkp4jhut3edZiqYMU9/zNs/qCOqE5rcftDhtd8Mc5hqO+4Ny9FO6QL3zivw41FR/av49z5WUSmeId5scyrvl/VmdDNwyTrjGaAotRAGS+EoKinZiWm2xgzBjgEJm0kXJQtXOjuqwpS0XHrREPEeU/72MNu7UK08w7N2uWA6x9CFhTIbv0IE613SHjlgrBlufESwBUj8a7BFSFQbaTHnoZeHtRy2pqvrkuk5jhxELHYk+eoIRPRLABmAWo/KwJW5+hBpk0d74fUfhHDQ7r4G/5oSpJ1mGmo28hNsbdcEj4kDY/cAPOpCEbeL5x037K4KjgQyKZJQo4Tw1GCv+oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDEKJjjsNvLcAef2JbQN9z0oYYnlQaqmRkbnbqYyOvo=;
 b=actINgI2oeaXXBrY5tQh5+Q8LWhliYz9t3+L0jOvx9NMloLqeKJr7AeoVmcDp+oqrVAMiwzs2y/CfOvbdUKHr9XmWQpgUByOa+DLnyJOxvnR6fI9Qbhhr34Z3kxwHobODUG/IUZs4p7S8Yoprweh2OpNvAXGjN1ttFHvfixcrqKQPT3JOh3vBBbgL9QdP9uXR4xniQ+A+xRRouSr1DCBl4dKCK1pAB05SsONGTGUFSqXtc7NqLJzkFSTV4mbAntr9JEDZMpwkouMAlbjp1R3RxOK0jBmKMGjhwk6LQAlZreyMUEw/hchMqO77ochnMcgGErlhva+zPRQmbsazZG+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDEKJjjsNvLcAef2JbQN9z0oYYnlQaqmRkbnbqYyOvo=;
 b=eJyCUZdQGhHyhYVfbKd2pAfMAmWJBR1gO0Ui7UXY0p7pjCfPINj86t9OpfLcyBmpEIY5viVQrH7LQLLHcNvlXPOphbJOojeC3osMiRLAaqmbcE8utJTADJUqJkY9e53b2yYnBSG59v1eTGjgpDJER+LjfO/5+U+5FvZ2cSCxWSw=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by GVXPR04MB9902.eurprd04.prod.outlook.com (2603:10a6:150:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 16:00:26 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 16:00:26 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
        Wen Wang <wenw@silicom-usa.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZ0erQKIGuJyMiIEioe7g7XMHTza/xkQCAgAAWSwCAAAnggIAC4qSAgABY6oA=
Date:   Mon, 21 Aug 2023 16:00:26 +0000
Message-ID: <PA4PR04MB922279F65781731CA3FCC7A59A1EA@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230818154341.20553-1-henryshi2018@gmail.com>
 <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net>
 <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
 <1ecd7ad-3878-c826-45a5-7123e55d8527@linux.intel.com>
In-Reply-To: <1ecd7ad-3878-c826-45a5-7123e55d8527@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|GVXPR04MB9902:EE_
x-ms-office365-filtering-correlation-id: 13487213-4763-42e2-c73e-08dba25fbc4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORFNHAGd9FzEHLxCRcA3ckXxk5/bVZgsz4e2HHOFuLhjQg2ysa9yI9KmVi8moz3ar/ydXEiHV2k8tAfyNvUAQw9ziDs9qVMc/FzzRcAybPkABE5tYkKfHDfP7xHBlbPpIyLAnATzuv1EeLO6bwswdD0spxJ1vJiAvpZQcHKZvbj00pMLd95XbCEnujaKv9SEtzlP+YbKNJl/KCofq487onVIYJNNI05Uv625lUjmtBmHYNhfC90Lm2iorA7h0YKfT/sBdAU46m+i9Ia1anYNSRnIVoAM7ENKz6426iQzlJIR8tUCuZuJONwfLJpGuZmL3O9hXmR6XLShXZ+8c/gJCkUxOABRDWv7NAp/VID4t0ieqC7edJBqOwRSByhslOHLkMRh82nCrKabor/qd+8x58NxIO5idxltcpZyuwiwr77RZZWUS/Th4Zn1fBz+bHwByoGJX+NMm/EW4gh7GxA1ybzwHBrI7mSZp6sPWstT86wi2H8wmprPaheVD+btJd8lVCVwgf1xYwe0a8frE5HCnUp7qGHIRvYymHYdziXHcLQaNfKL11VgKt9s9yNPjPM5kjv14usJn38hi+bw8epIqWwAGn09i/t3pp0hzQ34JfgV19Un/En3W9HOGgU8a/V+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(33656002)(86362001)(55016003)(122000001)(316002)(478600001)(66556008)(54906003)(66446008)(66476007)(66946007)(6916009)(64756008)(76116006)(41300700001)(38100700002)(38070700005)(9686003)(71200400001)(6506007)(53546011)(45080400002)(7696005)(2906002)(66574015)(52536014)(8676002)(8936002)(7416002)(4326008)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JcfjI8Y4SnGOuh/Y8DwvYmA/zcrfQ7Qhs1VqvpXnsgaCB+vSfdI0NaUtGD?=
 =?iso-8859-1?Q?oQbhkfJ/PZ330B31dgp950yG36Qis7KZ8mVvRVSIq0SXjGNtGYJn7PvH8A?=
 =?iso-8859-1?Q?eojSrV1piWIIik6Mka1OQT+0QPJmX8EjnuyoShheQVza86sXO/NDi3VsjT?=
 =?iso-8859-1?Q?M3kcw1ExWbi1GhfJPucQPhtrHipCNU3uPu7p07ZjVIWrCdnS8yV9fRi4sh?=
 =?iso-8859-1?Q?6KkU5gTbzCdWOjyygj1MmJPEI6p511FbCoLn5NsFhKsBDx6h6arjERcHSh?=
 =?iso-8859-1?Q?wyxZiKZG+Bz21IzJOxL8qIlSzYhutIB2H1GlSRkjNzCzjygcNZZkBP/DJY?=
 =?iso-8859-1?Q?s5JRBb7OwJG57oA6tmgWDrWVfXgI9T9u/5DiyCMbqCddVqbc5TbPDc4NNu?=
 =?iso-8859-1?Q?GFL4wjftAQ8DeJVvsNTZQacDa4x7zrsOrcAKdpgKE7eCHqCaF4ko37Shln?=
 =?iso-8859-1?Q?opnLY+BFbyQKcw6Qg5pNxbNGuxTWqgndltFeqZtrjIrqqItKb6F5OKcr6y?=
 =?iso-8859-1?Q?i15hZxBItnSTqrrqjF9Hbg8N5cdAQd+7R/3aAyMQ3x4rXQxoebwKxHn2o2?=
 =?iso-8859-1?Q?JoYYBBFfxgcbFB0SeGz8qUxxku9b3s3wxQw1zOqkafTP4Zjeae42ZG+Cgb?=
 =?iso-8859-1?Q?A5cP+zxo18SXJRiKlcjkvPkkTZPmLatayg5g5U+IZ+K2EckJess/xfi0B7?=
 =?iso-8859-1?Q?u7fkRDF2RFNzwf7+4w9o6f5B7AfQ6i+UFXJK7pVspqYz+bZlQfoawHm1Fz?=
 =?iso-8859-1?Q?9NoMC5648WQsmS+iw8zySfZASvGtUMnXv3jAE0HGrj/fZvUms+Xlcx+lyI?=
 =?iso-8859-1?Q?y1zkS3rIB7U6R0ruV0vXAkDFgFKJlUhYgSSlKNizQi9cHWOV9RXJIHrk9q?=
 =?iso-8859-1?Q?bteujkHFznFXBt82wQyGvMJj9eHXS1RMrQcG3OMzQqyFay7hJhhDebKu+9?=
 =?iso-8859-1?Q?VslOQ6JTwOv0Pkz847nI36kFWcnhnHnKGHY1h3bO0AfBQJRqPe9zbgowNZ?=
 =?iso-8859-1?Q?sSg+Gr8TpcdEppx5UwCQ/iTI/FXh8AtdtPsDHhNcZa9feQJYI+y/9eBBVc?=
 =?iso-8859-1?Q?1/PIsW2yCwiONGXCC3HFCdGQy1CG+PZYn059FihRLOITlyFY2pO12Jw84O?=
 =?iso-8859-1?Q?FtvKsi3QyTCmd5yi91hey6ovVcjDrqS30e9kpPviWOzt1ZBCj1Y8shZC8V?=
 =?iso-8859-1?Q?hrmYuKKsK5ie0HS1lb46jPipcTZENvQdFt4LjGcn3KgiPZl9M0rSwuPz3C?=
 =?iso-8859-1?Q?ysod+/sGkV5cPSm/MzvrsJ8u6MM5dcZs8UdlMDyHZ5KQrDaI3Qdb8hS1Tc?=
 =?iso-8859-1?Q?WGyTuhZldF/uQSv+3RTcp3hVXlWRFwtPNXLIZovAN03EAxQybUzPV6wY7w?=
 =?iso-8859-1?Q?Ijwrk4gXXjBm2JVPzgwk00pIx8AD/tOo0vHFmAKRJZQx4yaf6aKb3NPK9C?=
 =?iso-8859-1?Q?GnasVMiuNldfx/hAutKctIQThnUah77jfjcXJwevQ/ATGTihxzXrAIpjWR?=
 =?iso-8859-1?Q?wvx0XiVB6Lmx7TiNWHKxtRB9z+i7H9MTsc47a8GP5BdPNZmymBDJWV6dt5?=
 =?iso-8859-1?Q?Dfb6d7oVSb3nLTi4Me/w7vBQX7IAyYlp2AK01ooqIL00tE6/0tUOE6pS1/?=
 =?iso-8859-1?Q?rwcRf5eEfQOlRUYZZd/MyTvVfWQMI9CYHw9T8SMyipHYhyLck6j1ZZ2fTa?=
 =?iso-8859-1?Q?jAnGyYdZtUtIgYUibb70qUr71YmlS2XwYMlgH+jG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13487213-4763-42e2-c73e-08dba25fbc4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 16:00:26.7152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSGDdaveVVfxjaDe7uevaHIxc2233y1tx5xzbKRRgE+mwpB69EGd+EmdyetJLwIH6FCVgYQgIAjZBMob3RZutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9902
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>=20
Sent: Monday, August 21, 2023 6:40 AM
To: Huibin Shi <henrys@silicom-usa.com>
Cc: Henry Shi <henryshi2018@gmail.com>; hbshi69@hotmail.com; tglx@linutroni=
x.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kern=
el.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@=
suse.com; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org=
; linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Wen Wang <wenw@silicom=
-usa.com>; Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Add Silicom Platform Driver

Caution: This is an external email. Please take care when clicking links or=
 opening attachments.


On Sat, 19 Aug 2023, Guenter Roeck wrote:

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
> No, I do not accept this. I do not believe that the maximum=20
> temperature reported by the microcontroller is 6.553 degrees C. I=20
> suspect it reports 10th of degrees C. In that case, the number=20
> reported should be multiplied by 100 to make it milli-degrees C as expect=
ed by the ABI.

...And for that multiplication, please use the constant defined in include/=
linux/units.h instead of a literal.

Henry: will add constant define.


And please do version the patches properly, it's getting messy to track whi=
ch version is which (if something is new or not). If you use git format-pat=
ch, it has an argument that can be used to add the version, no need to add =
it by hand.

Henry: OK I will do patch version and change log for next submission. I did=
 not realize this before.=20

--
 i.

