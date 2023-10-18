Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0667CE151
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbjJRPhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJRPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:37:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2CE114;
        Wed, 18 Oct 2023 08:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSHr0GVbFm1ox1EpNBdzWEm5UHir5UKEf72ba5YLvZ6vP1Vvqx5mUrtjKwfxbHSLyG+DnIJosjVzEp9fTpcKWkTX5AcSnqchz76VC0+KFesdbO+J1Bans99w4OphkgOVxyPwOH08jehl0yS9J2SaLLLR/PHh7fYSQZs+3pnw4z33wSiZ34MqTdpg7whYe/Orn0JQf0fxOOY8AieS9wUoOKiHEiKkBHNbylIOTHP1VgAmtDRLYvSQXU+zM5J2L4MMlIv5q35sPk7fRDnkY3xwoRCCEh9jYxYMNxj4vvpMAZwUfX9ypT4xpa3OuvwQOJtB4iAz1EcxMuhN+b7oy5fuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRWzqHLYvtgeZaU96S0BEhI0kOMarRYlRjumJ2L/TOQ=;
 b=Wd0pY8H8rdVpvWvQPVaPpnURkAnCiR81AqbIHvcbldckWaKmuxvjT3L+y8PRc2I8RTSKRZBXR0AX6CBcLLzvttJrKZTkgr1rsgFeUWUrGZ3PvsiMlCM61BpYm2iHfuQW8tXX8+vbqAz6Rs0oSX5FjUUszL2n9V++Ht6MEdI/gKy4o4j0w5TcjgCViyaRdaC5ElbUs+hhBngJyS+Q03U2yYApOAG/E1TKRJo4UIXfuDvlqcBLTZAuSJVzj0SUz0Ju4cLqjaZSpUPlZHp1nId0k15e9Sf4Fbow+psJ/i9IvyhfMdS5hc7o2dNyLmUQG/Sa71ua0Jaj2JAzuP2KpO65Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRWzqHLYvtgeZaU96S0BEhI0kOMarRYlRjumJ2L/TOQ=;
 b=APE2j3QuC4AWGxitbuvFiQAKpPcg3Ix7jSG/i8mzeH+qnbjAlrSBRbHTUrvamhVudZ3x+nVjkri/ALzQPX5fp2Vd4rAhOUHUifP/PgUfZXCOu26adkCz1JVtpO8w7pwrm3kbBjjLkFWY379mx1ptE8mHTLgY2K+IDJ4s8aQdPUQ=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:36:58 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 15:36:58 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Sherry Sun <sherry.sun@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Thread-Topic: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Thread-Index: AQHaAdjuQ/qnXuu8r0O7wyQJSQHZ2A==
Date:   Wed, 18 Oct 2023 15:36:58 +0000
Message-ID: <AM9PR04MB8603471C0C4BF61CC3AA3BF5E7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
 <20231018145540.34014-2-marcel@ziswiler.com>
In-Reply-To: <20231018145540.34014-2-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|PR3PR04MB7337:EE_
x-ms-office365-filtering-correlation-id: ecdccc4d-924b-4ac8-5302-08dbcff010cc
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxpdI2sLyGgm9N2TqPAfxcFFZXW9mIHtDGmhM5K0kJXWumXw9LdHYpD26qG2rZ9bpFQiuZU7lcXBsixFAELimLRsa/UXFJSA8zmm1PSpWnX6sinRcevVtuWrmLrEh8zZ+nT1T5KO+tcN8i/qX5fDI/Nnj3ydj6oWJYXlvja5UZzmt6pfqwp23tmUPpFPEb6I4IdQu3YMZ0IhbOAW4royMQ6Hpg9D25BuSTYGilxR0mVZkS+k2VZrQ00VR1DWDBYbPREuhDIXEBvE3WcUQDirUTSlA9U6tw0y+TSlF+2r+OlYFF75W3yfev1s9g8n9jONn9QtP32TmgTcnBUNdYXpoDbgQfJMRk4f/EiNwtduRhknfHpGJ9E9v8C8xAWktVh8bFLTQdhieXUTFrJUOADkSKjgiLSuNqMdbhLXwe/3affphuOOrIpHwrZkgmpxxUMRtOgMqw6692qOTKnglugvBqYMFGzPAc9WSMFiMKbvGA6eQ/ogVFHlFF0Zv5h/Q023A7rZYFf9J2/0gesSXiVoaPsixfhsBEJ3C+bJSF/LloBE4d6wJtGYLmTqu7QuTCrlTqZn/jWNYS+HtPar5hl5bUNz7DFb1WRpwfZhacSWwZk2ufo1xJSLtrYRzijdLhhp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(55016003)(64756008)(316002)(8936002)(26005)(66556008)(54906003)(83380400001)(8676002)(66446008)(66946007)(52536014)(66476007)(4326008)(53546011)(76116006)(110136005)(9686003)(71200400001)(7696005)(5660300002)(478600001)(6506007)(2906002)(38070700005)(41300700001)(122000001)(38100700002)(33656002)(86362001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kQ0KgvV5+WGaFIN06F1no6C9LG3PdgoEYhRcH5sRYapI7a+s+Qje+nW77j?=
 =?iso-8859-1?Q?F3F9Doo4aQ7OSGbMilLja9ZOgJj6vpktOXyks1IOK3Q9Z+hgSu5vUp+vXz?=
 =?iso-8859-1?Q?SdYLojCWlMbPG3jxSElUnt+w9E4JVAH+cqFqSOCno2Rd39Js4w6uEhLH74?=
 =?iso-8859-1?Q?N9XjezgkaE400OcLnJX+bvjOzrhU+D8Dw1Vj8+FIKuZjebqdnS50vj7Tqc?=
 =?iso-8859-1?Q?dFWQO7zXqR0LqOTBbAPgt3DHVrqFCTAvaPk68yiw7QDQzFaDwXv+Zdqqr6?=
 =?iso-8859-1?Q?tFRQsXd5/NF7M2e2WtXzrEXDaWbUs5QC0fN6Xx5XthgHH74hgCca60Kex1?=
 =?iso-8859-1?Q?4kb9JH+D1DUy8bEQSLZwQesW7i4QhQnxwUVfqIL7JEY0NEmYUaDm808WqP?=
 =?iso-8859-1?Q?FQSDMKOjEgPKSPw5HOf1AKGBvIc/lw60v5nYeOZZY7Fl1q8MFa4p2ygmD5?=
 =?iso-8859-1?Q?/R6/aw7yiYptmOYjSkV3OEUa5YnumnoB8syRYYeCGroFBvn8zCcDINsI6z?=
 =?iso-8859-1?Q?k0Jx7ctNi5Rk66QGILxTvc9wKY1Zq/X9ZjyXn+S4ck1Rwt7eF7rItq4ZJh?=
 =?iso-8859-1?Q?X3jQS0AoEbGYYqeEvSReVlrQT3Phys8l5JScZYc4zCodk5TsYLsDHtE+yM?=
 =?iso-8859-1?Q?C+jiWcTxzOpyFKAyTaLjC3Nh1EFAXctxQ4NBC0CJoerGAprD42h+KpCw5A?=
 =?iso-8859-1?Q?PEdAuGonGNIl5n+1H6ZssuzQoz1xxZnBd5qp7Xlp3tHuL+q32N0IQfvDYy?=
 =?iso-8859-1?Q?CBzrQaW+sU/76vZh7BazLpY4zsxy7Tm7L1jR8AcEaUCBZrGszeFo/VD7yH?=
 =?iso-8859-1?Q?29b/g7PrbCe7em3x6oP/7ENBY+cCZSOJEE8Gg4g6QJmGE+N/ufJRqXKPFX?=
 =?iso-8859-1?Q?apvKM3B3meH0wu48CQVxzXblEk1AYzZ3ui+F25PJDy9TQ48u2Tl5/qNi/8?=
 =?iso-8859-1?Q?Hk5vQ3E64KMEekvPsZnU1e1SLZDoua19rxIk1FOv7H8GYvLqNcRxMzUncu?=
 =?iso-8859-1?Q?iJZvCaR6WbEhCP1kFpnC95EcQiDwBW8xpxMSMncTKF2CtFuP24mdRsjF/l?=
 =?iso-8859-1?Q?C6tIwgDgrjeSrv27t6pvUtWrjKIn4zUji/A/9aE7XyxSC88Ou9bjl3mBFi?=
 =?iso-8859-1?Q?h6F6riakUBqmT/4ay6DBmgGOME91hK4GAruz6jax63w4jFJpFOvVDxLIyX?=
 =?iso-8859-1?Q?XorKigoB4geeKFT8pdpMPDh88NV+TwANP++JrCGIeyS8anTxg5LSCfUwhM?=
 =?iso-8859-1?Q?uLcVQmfFw8h1vQ9eutZgbYL3fl1ktNabLp1/2/Ho8k4v0KTkbaD+kduAdq?=
 =?iso-8859-1?Q?zoeJwHU+NBXDqRftSrJoS0A1lv6gK7ttW6QFFa9HRDOrT0I8QUc12/70g5?=
 =?iso-8859-1?Q?lA8V7LXOLFXe/feuiTHi4nl3DfUJcX1v3AzQiGfmmZt3kgfJSu7lTO0wJ4?=
 =?iso-8859-1?Q?XXOOxfloDafvYAS7/+outilh9Ibf1HITevjI+mPbCSSm2xkP3MqGyLbt6v?=
 =?iso-8859-1?Q?Th3F9XJM4GKEPSnW8l9/6V9pqgaZCrcHW1RkpTbgjCIuCLdThI7E1EUwAl?=
 =?iso-8859-1?Q?ChBojaSeOY0jVQbkpC1TCVkEnC43nRCcexTlF+MwYNQ7Ksr0+NQQRHVKls?=
 =?iso-8859-1?Q?QFC8dlUZWzuHxF809zYSk8nCZrOwSJiX50rJmK4iWd1aPhUbIQNb03hg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdccc4d-924b-4ac8-5302-08dbcff010cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 15:36:58.3432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEUk6vSMifpsjXZJQksK2Pou7MzFvGqzUiVJeh/LfZ+cqytFpAMCB6gbotFVg4YofE18QKciztBiFwwVS0h4Xji3zEjFb06E2VkDkewQ+Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thank you for your patch.

> From: Marcel Ziswiler <marcel@ziswiler.com>
> Sent: Wednesday, October 18, 2023 8:26 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Sherry Sun <sherry.sun@nxp.com>; Johan Hedberg
> <johan.hedberg@gmail.com>; Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>; Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>;
> linux-kernel@vger.kernel.org; Marcel Holtmann <marcel@holtmann.org>;
> Marcel Ziswiler <marcel.ziswiler@toradex.com>; Amitkumar Karwar
> <amitkumar.karwar@nxp.com>; Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.co=
m>
> Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
>=20
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Unfortunately, btnxpuart_close() may trigger a BUG: scheduling while atom=
ic.
> Fix this by properly purging the transmit queue and freeing the receive s=
kb.
>=20
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> Bluetooth chipsets")
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>=20
>  drivers/bluetooth/btnxpuart.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index b7e66b7ac570..9cb7529eef09 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1234,6 +1234,9 @@ static int btnxpuart_close(struct hci_dev *hdev)
>=20
>         ps_wakeup(nxpdev);
>         serdev_device_close(nxpdev->serdev);
> +       skb_queue_purge(&nxpdev->txq);
> +       kfree_skb(nxpdev->rx_skb);
> +       nxpdev->rx_skb =3D NULL;
>         clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
>         return 0;
>  }
This is already done in btnxpuart_flush(), which is called by hci_dev_close=
_sync(), before it calls btnxpuart_close().
Is btnxpuart_flush() not called during your testing?

Thanks,
Neeraj
