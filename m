Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73D758E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGSHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGSHAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:00:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA0E43;
        Wed, 19 Jul 2023 00:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7phQGmcrfUOgIrucXyKCKqmclRK4v5OhpsySQiYSRhFWM7PK5F1HMZY2pmdVBDmEylZvgxoQCsO77zl/b+WJpEG8WqoAcRF4GLRXLs18dMuPWfpz2xEGxCeJbYxJfh2pQXQXBpvpNtx7QmebSOmQh/zLm9eAsdv7SbvQ5PQAD2BSuuZCdTWpQUd7+cIp8585KY9+HZIqzL1XCtnpfy0K0AbLj/Z9Nn7lwc5FXM/Kgm9rXLH9iWchyW8/aZAdQfaTKNZOo+xufnE5mbeLg/Jx15UvQdpUWkRlkr2jcAe05H9ok06mp03jmde9QORN9mYJIRgWdqQ/jEF7+CKmfM/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q2JV6PVoUBktVYfAK84danWO9+wZpz8v4lyb6psz2k=;
 b=WONm8igIISJ4UPsI+5AlxdJEWCBaoCweKxcuXo4QSdPzOc5KVn1QVbFz+4crXNcjjI1N7OSYvrgw2/KnSnUQXDIzOc95XxHTUCNv3Cot1cKi09O+eospqEAJtxbDPrR8hRO8Sfk9+aj3tjT+FFpX7YevF8a/3uWv3zPEf7t3Ena1tlIr8/vpa+QO+sGspx5qjTdhz+xRfciaErejgL64tMoeDDUtrCx1eqj1TyE/Q2Ex7NSoLQ5cyHaJgvw1X8zBRMW8dotWyq4iXKk7sOpVCsPzwM/4Ps5+7SdHnddMZbsuV3kee4HSHygPbSF9f1KJWTXX1kt2mFwaPSsO9BMluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q2JV6PVoUBktVYfAK84danWO9+wZpz8v4lyb6psz2k=;
 b=GBJYZQxBE2aIveRMBqLYUfXmihTXViTbHaSl32hISsy6vNitkI49Hqzby9zDKeTSbGaVkpfmhe5NnWy1LTTIPKL6YhcQL9WMA3fQzLkmd1N/gXK6U2Rhm2X0YXNwD7GNFDkJ5DlBLx088WK31VYTLE9kO7/WPz7cAhPeIt1rUBQ=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB7655.eurprd04.prod.outlook.com (2603:10a6:20b:292::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 07:00:46 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 07:00:46 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Bastian Krause <bst@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] crypto: caam - adjust RNG timing to support more devices
Thread-Topic: [PATCH] crypto: caam - adjust RNG timing to support more devices
Thread-Index: AQHZnQeck2v36DTv3UmJ9e2grSaJgq++HokAgAFf5ACAAWGXIA==
Date:   Wed, 19 Jul 2023 07:00:46 +0000
Message-ID: <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
In-Reply-To: <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|AS8PR04MB7655:EE_
x-ms-office365-filtering-correlation-id: b41922f9-de40-4f1d-4b96-08db8825e0b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JuVvNcvU+1O+HQOVR2r2QYFs3YMNM42tjuiUDvr72b9fYwd1Dm1nBGFb76upvUCdk3ujnlDJi0IlCU+18MPjB6CT/UMnYVRlz3M1o35s34WbgPmB9aaLVVvIBIvvY+2WndlPJ1wthJlkE7xbvrcjlRa98oenQV+Xn9UIO8lfuv2X1uuAwi0vsGE3v7bVRu8QxCyum/2lEO8LqKzcODmVUikh9ZqDGUACpvv8gaZC+Hask2MnO5RLmX0BJKBg9pIPmVgwxehl2OlNaPz8EoFNC3BVzRxjM8XO7SExg6ObvP25y7GzfIW4J0rlF4KZ4Cxsft96rAa+xHPCLSRH97kKGuP88aqvSNAAwHbID5Zxg6B3MGr0ZY+6nC8WOg3zePt1ARwWiJPqyu1Z7H4djtg8oGTfiaiOOg0nep4dzkFQNdRbTuit9kQeEwo+VEkOFvUPAtHDVLj6FBArvUwxg3xMgPz++c72Cdlh8EaUs2jff8AQn0A5S8arxDeMIo0zC+P7sOMAIMMvT91w/klTaFaoChK7VZdSnUR6ZY5y+16uKd9QETagKUlZFluirVo56fKYXkAp4KFsLP5s0BVnZIPUDnuFjRa5SiuUYFfezikTAUM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(186003)(9686003)(6506007)(53546011)(83380400001)(55016003)(86362001)(33656002)(122000001)(38100700002)(38070700005)(66476007)(66446008)(66946007)(76116006)(64756008)(66556008)(4326008)(316002)(41300700001)(8676002)(5660300002)(8936002)(52536014)(44832011)(2906002)(7696005)(45080400002)(71200400001)(966005)(110136005)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?BgnqBKVE6/D33UJKdIZWn8ZsH3Q9twQyd7QZsWnCNb9nC/enWhxelea9yC?=
 =?iso-8859-2?Q?RkMq0kHyGZGBr+9vOV0dR7H9JSBp9UG29OVJp8Ie5QTo+JPMRFIi3O52Ck?=
 =?iso-8859-2?Q?uQCSwEqnx/JfbdPWvpRVUdwgf3MjxQxqDXBfrJKjXBb1itZU14lr1js74n?=
 =?iso-8859-2?Q?+i8o5jMUE0G9fXuYmcSccaL03eoePkLgJdR8GBCsNGixv+kAGsWQh6BXuR?=
 =?iso-8859-2?Q?9jQ7Hm9deUlsD7P/IvaWsadA4fzareiyhmPVZntf8o80YGgpkLqRzsTFUd?=
 =?iso-8859-2?Q?KZK9W1akUXnmVaJ+yM/oB1XjBT4eciGiq19Jn6nNSrR/h9vgfxwW+8e6cd?=
 =?iso-8859-2?Q?8Z6hD1LVVHc6r2vcBsXuHEExDWxEAyPxTc3hl0brcewHxrCqdRoJbLkBB4?=
 =?iso-8859-2?Q?pVVjLum0BIMMPpW4FtiurEFPxqXsyewr9YsOMtrlh1sIBCDGJHLi+XrBlU?=
 =?iso-8859-2?Q?kU1EsW5DMwZy6w1I4C6gH1QIoVEMI7MS41U0gWpjLJ5qEKod2Qp1kmn5vM?=
 =?iso-8859-2?Q?bbOnOT95omIyNd8ttUCuaezajNiePqr9N/yhmv/0UARnlfSf5a3BmqU1DD?=
 =?iso-8859-2?Q?vuL1FptNrzsQxaxzRGWyHKxUwxOARNs532azxUl+nPOS1Agsg4uODhYoe2?=
 =?iso-8859-2?Q?86hRMe/YyeZCcariq+cdw+S/bWq6YyBYAN9yiXN8CrWOrGoqWLzh+3luW4?=
 =?iso-8859-2?Q?MdBC+0pLjdo2dYJkAOw6/Q1d2LkwBXzy84VFmzmjWCvtvo7R6QfYBDZHFk?=
 =?iso-8859-2?Q?XX1bTHJZEiTjeHyuAE47DoGuU3NNbJ3W8+4iTVjZqZZVMMdjFx23hYDuVk?=
 =?iso-8859-2?Q?JuwZDTpcfRQnoYbxiqFb9j+RsmX51n4uq+qywCxGQ1zp5/PMAI+lQwZ5qN?=
 =?iso-8859-2?Q?yRu/eyNNBVDz/7rYZPq1h4HuGx6REoghpxH9iTt2iXmePbyK0j1TzT/eGe?=
 =?iso-8859-2?Q?xLb1JOw/QbaFmvE0zhuEx2YsYYiXtWPqytOW1C99rjOJM/dJ0JWYwd7up8?=
 =?iso-8859-2?Q?MDx1IsL0WKDUiqk/UPZXIaYr/jIt5/uQm8W+Dp+xGOLl5R0bLFFx5ujWMx?=
 =?iso-8859-2?Q?C9SagfyFvL7t1pJG1cR5umMNLaPPecHqwlvRFQxa1o67Gk7jrXq0llhetk?=
 =?iso-8859-2?Q?38PwkA0wJFnDmG1JsFEWtV32TDGjSOu7p9ph2xOqR2CSfzp6bbqUu+IJpq?=
 =?iso-8859-2?Q?rUgiCGBX3mc2gEzQKNkVM5GL8UuB2wlCE5i65pSpdIGxaELfFues68pj+M?=
 =?iso-8859-2?Q?aA5lg3miLlKM2kHwx7GiOgJZspeNRWEv78nwEGXG27EJNBBYnP44EAj3Mj?=
 =?iso-8859-2?Q?ReyDpxTWYxABCQ/gYJ87iBjtsh+MpCjfoF3uF0LLKPpjDvmvHAm120epT1?=
 =?iso-8859-2?Q?JnI+bmMTer6HEjy/cN3N7wQH2Wd9m75Jf23fz10heBuTFgcRYklujiD5gt?=
 =?iso-8859-2?Q?RqnXNvS6sH0VMaIqxVCdksNmLEK1nUbr+nR5t2Pv+eKkoZaQJMvmDhuF7+?=
 =?iso-8859-2?Q?pIOqYHYLoZsve1Pk1RzWWljQnJpsA/zp5CQYkAbwIc/fSuT9n+gFpnxgIa?=
 =?iso-8859-2?Q?TH9N58fVbD9s+xIqUa/8UnHvMkHimBI978Uo/EixjkhP4DWW6wQS5Mo/tx?=
 =?iso-8859-2?Q?mcOuPiYHU0gHlYhw7/JscYaIkU6MA1lON1N/HnLbdpR09lWrGRMIZj4A49?=
 =?iso-8859-2?Q?oRAi1Dtacg9V93IDQE82Yq+oYAxKHuj1zQXykvdaYwvJK3e+eLa3QOF1sl?=
 =?iso-8859-2?Q?NuDg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41922f9-de40-4f1d-4b96-08db8825e0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 07:00:46.8031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuZWZeRdRVrnl7nlLNWwRb7esjRogmleGy8LzGKu6AcSHZsGAlfS0VJTRfCxsqlU0mV6wxESXTzfNg68cFKWHRKjf4gkOdszMgZcQFyqVDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastian,

We have tested the patch on i.mx8mm board and we did not face any issue wit=
h the patch.

Please share your imx8mm board revision and complete logs (including bootlo=
ader logs),
It will help in investigating the issue you are facing.

Thanks,
Meenakshi

> -----Original Message-----
> From: Bastian Krause <bst@pengutronix.de>
> Sent: Tuesday, July 18, 2023 3:13 PM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Victoria Milhoan <vicki.milhoan@freescale.com>; Dan Douglass
> <dan.douglass@nxp.com>; Vipul Kumar <vipul_kumar@mentor.com>;
> kernel@pengutronix.de
> Subject: Re: [PATCH] crypto: caam - adjust RNG timing to support more dev=
ices
>
> On 7/17/23 14:43, Bastian Krause wrote:
> > On 6/12/23 10:26, meenakshi.aggarwal@nxp.com wrote:
> >> From: Victoria Milhoan <vicki.milhoan@freescale.com>
> >>
> >> Adjust RNG timing parameters to support more i.MX6 devices.
> >>
> >> Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
> >> Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
> >> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
> >> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>
> >> ---
> >>   drivers/crypto/caam/ctrl.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > This patch seems to breaks CAAM RNG instantiation on an i.MX8MM at my e=
nd:
> >
> > caam 30900000.crypto: Entropy delay =3D 3200 caam 30900000.crypto:
> > Entropy delay =3D 3600 [...] caam 30900000.crypto: Entropy delay =3D 12=
400
> > caam 30900000.crypto: failed to instantiate RNG
> > caam: probe of 30900000.crypto failed with error -11
> >
> > If I revert this patch or increase RTSDCTL_ENT_DLY_MAX to a value >
> > 66800, it works again:
> >
> > caam 30900000.crypto: Entropy delay =3D 32800 caam 30900000.crypto:
> > Entropy delay =3D 33200 [...] caam 30900000.crypto: Entropy delay =3D
> > 66800 caam 30900000.crypto: Instantiated RNG4 SH0 caam
> > 30900000.crypto: Instantiated RNG4 SH1 caam 30900000.crypto: device ID
> > =3D 0x0a16040100000000 (Era 9) caam 30900000.crypto: job rings =3D 2, q=
i =3D
> > 0 caam algorithms registered in /proc/crypto caam 30900000.crypto:
> > caam pkc algorithms registered in /proc/crypto caam 30900000.crypto:
> > registering rng-caam Executing RNG SELF-TEST with wait
> > random: crng init done
> > caam 30900000.crypto: rng crypto API alg registered prng-caam
>
> This ^ was the kernel log for..
>
>
> --- a/drivers/crypto/caam/regs.h
> +++ b/drivers/crypto/caam/regs.h
> @@@ -522,7 -522,7 +522,7 @@@ struct rng4tst
>    #define RTSDCTL_ENT_DLY_SHIFT 16
>    #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
>    #define RTSDCTL_ENT_DLY_MIN 3200
> --#define RTSDCTL_ENT_DLY_MAX 12800
> ++#define RTSDCTL_ENT_DLY_MAX 70000
>    #define RTSDCTL_SAMP_SIZE_MASK 0xffff
>    #define RTSDCTL_SAMP_SIZE_VAL 512
>          u32 rtsdctl;            /* seed control register */
>
>
> For completion's sake: Reverting this patch..
>
>
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -383,7 +383,7 @@ static void kick_trng(struct device *dev, int ent_del=
ay)
>                  /* min. freq. count, equal to 1/4 of the entropy sample =
length */
>                  wr_reg32(&r4tst->rtfrqmin, val >> 2);
>                  /* max. freq. count, equal to 16 times the entropy sampl=
e length */
> -               wr_reg32(&r4tst->rtfrqmax, val << 4);
> +               wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
>          }
>
>          wr_reg32(&r4tst->rtsdctl, (val << RTSDCTL_ENT_DLY_SHIFT) |
>
>
> ..produces this kernel log (without RNG SELF-TEST):
>
> caam 30900000.crypto: Entropy delay =3D 3200 caam 30900000.crypto: Entrop=
y
> delay =3D 3600 caam 30900000.crypto: Instantiated RNG4 SH0 caam
> 30900000.crypto: Instantiated RNG4 SH1 caam 30900000.crypto: device ID =
=3D
> 0x0a16040100000000 (Era 9) caam 30900000.crypto: job rings =3D 2, qi =3D =
0 caam
> algorithms registered in /proc/crypto caam 30900000.crypto: caam pkc
> algorithms registered in /proc/crypto caam 30900000.crypto: registering r=
ng-
> caam caam 30900000.crypto: rng crypto API alg registered prng-caam
> random: crng init done
>
> Regards,
> Bastian
>
> >>
> >> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> >> index 5fed3cf354c0..62dd069942e4 100644
> >> --- a/drivers/crypto/caam/ctrl.c
> >> +++ b/drivers/crypto/caam/ctrl.c
> >> @@ -383,8 +383,8 @@ static void kick_trng(struct device *dev, int
> >> ent_delay)
> >>       wr_reg32(&r4tst->rtsdctl, val);
> >>       /* min. freq. count, equal to 1/4 of the entropy sample length
> >> */
> >>       wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
> >> -    /* disable maximum frequency count */
> >> -    wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
> >> +    /* max. freq. count, equal to 16 times the entropy sample length
> >> +*/
> >> +    wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
> >>       /* read the control register */
> >>       val =3D rd_reg32(&r4tst->rtmctl);
> >>   start_rng:
> >
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pen/
> gutronix.de%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C1f556
> d6802434c00ef4f08db87736527%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638252701909887583%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&sdata=3D2vCBBdo%2FAkyz%2BaLXcDyeursw3Gle%2FKosiO%2FdPysOd3
> Q%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

