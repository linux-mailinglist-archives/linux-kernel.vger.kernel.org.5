Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90C08064DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376595AbjLFBxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376530AbjLFBxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:53:00 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838729A;
        Tue,  5 Dec 2023 17:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMWQFuc/S2YB5nKBZCXqLYZq0e0Lkq55wJ5hn9MiHRLdX1R3P2PrNK3DPWe3XbSXjUs3TEvJN/k0s0iK5XHGZkcuUqsHaQ7qNmSfT55sXBrQVOrPznMIeYlyov2d0e8PCL7AUckArk/pTpWGc1WsKUtTiSa9a2yOFx2waLXex242aSV0Cg2GtjrBTRhoLgdKCiv+QEXv7kOlKts/IpyjZnkQhOFU450iTYnX/mfIraxSsxWIW0B6LKTZ44Hg6+GH0d30bq2LxN+UiBf7AKE+Q9tu/pxcGzwCoLMU7ytqNuIwmnZUCYQLiZTvX+g674pesGUnn3MzYG7VGn1ud2UWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22Bh43JvnNykipc6gPj4nExRfa3NEnIt51/RSY2955I=;
 b=CTxXmSFLjVq1c9AkCqlp760UeZ1+xJdglSVlsMJoxPm4AL2asYHnyh0mcs2JPh3/hCWLX0G8f75u6Z5EYEqHONW2huVQmNrzMx/1E3YCPHdlFfw0jB9y62lvWp0luTlI6616FI1D+KJk6jX9sc736p6g3HXaEm507Ve93M5dgKmTR/GmuasKQq46Ps1XPyy9esVdmnhmMXItl+MxaaLzLbmOwI55qG8QWVyF/dZx5zb5AGxDLv8NJE46Oa+rCKL7V1X1EnCqUZBXzzzusxu71HM8i6Xc1Ml9/yT/4clgo7/so+1e9trtKj3gE4+VdKiuKoYIJ1fSI5NctBqdQ5wo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22Bh43JvnNykipc6gPj4nExRfa3NEnIt51/RSY2955I=;
 b=mOhgWW6j7Nr0DION/9Kx+AZdM9JVyca8NXTPoe8g1hiA6yUr040garHUzundk09aL5IsjSH8Kd87i1PQld5XwJaweRnrYisyOYAuYhX37soEUIWoxEXkaHskgESbdwlrOGRrsxefb7kT6cZPLdFUlSQCh9ODxtu1RFcd2rGjdy8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 01:53:04 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 01:53:04 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: added extra delay for firmware
 ready.
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: added extra delay for firmware
 ready.
Thread-Index: AQHaIdSgkWy+z6AqY0y9BY3vh1TVyLCbJ8SAgABhuSA=
Date:   Wed, 6 Dec 2023 01:53:03 +0000
Message-ID: <PA4PR04MB963836544F03B5D5D3514355D184A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128082544.613179-1-yu-hao.lin@nxp.com>
 <ZW+BZRHDta7vKZgs@francesco-nb.int.toradex.com>
In-Reply-To: <ZW+BZRHDta7vKZgs@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB8181:EE_
x-ms-office365-filtering-correlation-id: acd63203-7a01-425c-7999-08dbf5fe15e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEuPP2MfJQbvoEju7ACwAj2S8IanNDepcCtcki13BDUGzjzxaTLfG3r7k0kp5gbJcybSGrhXaWGo6iadRTMVMbsyaFTyujDD3xFny13cyt8uXazJtMzEa2Wy0QAZ7TzEPga+/HC6ABjNSfpTZAwls2aWNPW30dtuVPro5pC3/osGA+IMcAqxsvhrJG4bQp8iLiKPGopuQy7XNr9uxI/WbKOpqNiCTGEkTskP87URXUB0z6Ru8sB8Dv2W4gxoMuZrCW5mV2oXuqKeGazZfqBgLKmvU8IMHx27BYjr2CNlPoLKci0KtuVLb0LF8iyPKDPYMZLmW8TUtF6V8iBviGP/6n4LyMOKoI+F6h6pCqbtttSbqXSCa+RCrKbl6TGFZsjFr8HD3k3vf6m/XQvu8Poo2wNZe8zengaT84e2Rsawy+YICM4siM+Ly/hCF9P4aDseMkitdDrv45c9T5/y7fdKH7KSP6jvli35pmBl33qifJ+I/O9k+uO/Bu0MXRsEcaVjRoND8pgJ2QCzNqAm5Wjc3C6eNIggedYihJ28FCmIBuD12ODGh1jH6cfV3SoNG5yUrE6ASey8lwdDJ8IjXKYnmKOFETahftFAFO9Htsj3zcoUqFilMsqXyhqN8CqgehlJzelFGNzNT6oWY/4hHCGf6G/WLT2TA0EUl1fCd9BeMJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(8936002)(8676002)(4326008)(7696005)(6506007)(53546011)(52536014)(71200400001)(26005)(9686003)(54906003)(66946007)(316002)(66556008)(76116006)(66476007)(64756008)(6916009)(66446008)(478600001)(41300700001)(38070700009)(5660300002)(2906002)(86362001)(38100700002)(122000001)(33656002)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tmTXIwZEFpLOirNoE7+UyxZPfUg4FJ5xSQbQOep6rDPhsipnbZeCgFIn56pF?=
 =?us-ascii?Q?p8Gw/1XlQYTSZlfrTAKAuSRDGTD7iR5JeoJJP9w22W0xWaxsV9nuItUnT+R6?=
 =?us-ascii?Q?5NQglm0XpdPrYx7o1ywoQPlMcjI3L5aR5xOpXBjl39pEwM3bkChUp5DjrdDr?=
 =?us-ascii?Q?G61hwPsX1KiTdtmNZ1gmiMn2LUAJNw47e3iskJjbUx6TdJ7DkcBLp7Od2BJC?=
 =?us-ascii?Q?JkjevgppgbEcBXzWPa1gJLhG7pRmWQlUY3CjOLtJ9vnnTceanR2QRu44hd4Y?=
 =?us-ascii?Q?IxHhJjBlT+7RSVyPAkOCwBzIZXPRVBBHzjQGPWFE0l5izo2s/k5kOu/Svqf7?=
 =?us-ascii?Q?uNn1+xMthoH39nMYyOD1s2mZVpVy9bMO6O7tmab1qucSlpN+O6QxTPqlAH+C?=
 =?us-ascii?Q?vsx7YotEj11Ve2uSI3dqRj4NGQluZbzAG0pJ5RM6acZPT3vdCW5MgnsL0Hqq?=
 =?us-ascii?Q?xrt99IiaJKcUZTKGgKkEz4zRLYlgsmvM+haFYAGDt9nl3zD4fRExnraSrX3H?=
 =?us-ascii?Q?ZSpA9tN1hfwssphH5h1wV8NhjAa0O1C3rio9RmFSzESlnA2ZOxmPECX6YfWp?=
 =?us-ascii?Q?CKx5wqZZjgNXVrK+SOvqmtP3NY1PgxpZRvGMens/1AlUg0x36t20wpFjf0Ab?=
 =?us-ascii?Q?nab+K57DW/tTlMyGeV+IcH+SCtFf87agBfUcvvmA0fq7ZP0C/MT0KHRh/TiX?=
 =?us-ascii?Q?IZlY1JgMkYs0BlZLES3CGtc9W6hSjsCmw7jwKoOs5bTiFG6hQAlm7g9qe2Sq?=
 =?us-ascii?Q?rIRUEwQgml0nN2nWHWqLfqGr5fz3sq/e/YB1JnMsF+iK6FntCdUjYiP8op12?=
 =?us-ascii?Q?3A+T7dK4fZVtxYNen1Y2GQpPXT0YZoGmwMW9L0ZRc+QIpnykTOjMLEFcA0ky?=
 =?us-ascii?Q?R/Q6rOcyYl8DshWu4q1gJzlBXOlClF0gD9LBAOv5MWQXHttxAHjacMmnkBiz?=
 =?us-ascii?Q?O86iHyLpzBUP8jvku9Vd6PZHAXIp4nintNKwW5EaQohHFWZITcio0Uv2sbyi?=
 =?us-ascii?Q?TdQViet/dGwcQ55z5q5GeFmmjWetj26b4iOncJ4UWzKCfV7ADnHB1VLBW650?=
 =?us-ascii?Q?WFkMQOFXfhLlzNvfyy8sY+NUYnAcb5bSRlEoOON7KXwCNXKV1+h95w/qzM7V?=
 =?us-ascii?Q?DYBatd5XBh31HiOOy7vEsLQH+mKYIJS0diMTe9j3goSgNZPVRmlmAQov2EkL?=
 =?us-ascii?Q?HhIhnl1aYYt+mI9wEv222iWQFH8VOWl/VylMPUa0XsQA5NEAcXcvn9+/C0C8?=
 =?us-ascii?Q?0/QkRU6AbRS7kdzXqsfvGKbEET/FJcMhl4BjCwMouiAp8ES7kgc0V4o/8Ae2?=
 =?us-ascii?Q?441IyutRG9kD4bdYmhX13wh5oIX71lonlMbdSEtEmA5qhA6AF/edugxVx9xT?=
 =?us-ascii?Q?IPSjw2ChFydHFhYw8Qi9V92bSF1db0Co4qj/oPS/+T+s6CzwUaZDOQvLYcYT?=
 =?us-ascii?Q?KRGL+DVa2WloRbdS+3qlC2UXvPukOtnFvUQZHNVmQE5RzvSayEttkQ6tXMFw?=
 =?us-ascii?Q?bWyjoIpEYiqi8HErECaTIIXMlTrCpDJgw4r2rflXTP4zheFujLhOzm2/PH8Z?=
 =?us-ascii?Q?CgkPBNoJP9l7uGuyuYc1vHOnBjVoFvANshux/8x2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd63203-7a01-425c-7999-08dbf5fe15e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 01:53:04.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQvY9XU9huB6nB7QXafjlZlBcHkuP64FnCkVXJwIKeUt3qfRxL2luVD5zblr50CCfpqL6vOxh6VZOL9czYExpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Wednesday, December 6, 2023 4:01 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: added extra delay for firmware =
ready.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello David,
>=20
> thanks for your patch. Planning to run some test on this over the next da=
ys and
> we'll provide some actual feedback if this really solves the issue we are
> affected by.
>=20
> Just a couple of nitpicky comments on the actual patch.
>=20
>=20
> On the commit message you should use imperative mood, e.g.
>=20
> `wifi: mwifiex: add extra delay for firmware ready`
>=20
> with no period at the end of the line.
>=20

Thanks. I will fix it in patch v2.

> On Tue, Nov 28, 2023 at 04:25:44PM +0800, David Lin wrote:
> > For SDIO IW416, in a corner case FW may return ready before complete
> > full initialization.
> > Command timeout may occur at driver load after reboot.
> > Workaround by adding 100ms delay at checking FW status.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
>=20
> Add
>=20
> Cc: stable@...
>=20

Thanks. I will add "cc: stable" in patch v2.

> > ---
> >  drivers/net/wireless/marvell/mwifiex/sdio.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > index 6462a0ffe698..744e9403430a 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > @@ -783,6 +783,9 @@ static int mwifiex_check_fw_status(struct
> mwifiex_adapter *adapter,
> >               ret =3D -1;
> >       }
> >
> > +     if (!ret)
> > +             msleep(100);
> > +
>=20
> you could just add the delay after
>=20
>   if (firmware_stat =3D=3D FIRMWARE_READY_SDIO) {
>=20
> this would be more read-able to me. Adding also a short comment like
>=20
>   /* Firmware might pretend to be ready, when it's not.
>    * Wait a little bit more as a workaround */
>=20

O.K.

>=20
> Francesco

