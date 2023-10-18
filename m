Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73B7CE12E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjJRP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjJRP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:29:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A437F7;
        Wed, 18 Oct 2023 08:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQpFCFraRtO+Gew79LKx0facMvOEmytAkrCAANFYG/E68cs/7yhziiw+NcngIHRl8lLIgOjwi3R1ZxoTEM56Jxf2fBqqpUiQYRPiUILCfQpFZDl/T+7g40g44FjFO5R29gTNiQurQszTtNKNvz1L8pH2ljLFbP0ubV7RGPZkc0YwGuWju7rnCzq9wMc3JK8iJ+//I+q/KoqJu2YrX5hZbjQugDhzV1L9jeaGoycLQJoTZW9rUkvbqpTPdPqJKbHHd92M/RTr+EaL3lNm/eppOHW/VqbB31DYSrRSCRqcfCcWtWTkPEbEnLaE/oBvlbh3eL+TgEbNjjyo9bpQPWQFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1j/COT/svTWJ/Eej6UquO9RNWg0MvcZoW9X+Vp3dJQ=;
 b=RDdGJA3+q1Sq7OIRjNsfWMl5AqtNxYXrCDes6Urs1Vq0r36QHcNdVKzF4rC+gyhU8siwgSFan+kmfYyipFxc4pZ0BPKINTKpYKB9j8MxyChE8uPzDlvzoGkF1oK7dS4YLRCWHdWZlSNHWPQPx8OifTpxicZ7jbNATYk692BswVblKoIfTPceUf5XJ2555q/9XPS1pbynLtBrnA38tSniXgjKD83aW5B0SH0VSlALCyb+EMlFG2YXJlzHOV60Ms2FJMEUV8rV4WRewvPwXz5+gfMmcKuD2vMVT0Ityf4JsOD9AYvU01FguweY6iNL8p6SSgtecSLQWpd3NyQ/zOcsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1j/COT/svTWJ/Eej6UquO9RNWg0MvcZoW9X+Vp3dJQ=;
 b=i07ah3jYWfj4LHmpJG3euwhJ8Dpn5cq+F3n9Z0z4kx85/nq8p1YCCHRb1VvDGrggfDy0Y7iW8/TCtX9KX8X6kZVjl1Du+ptDAJxYDldZwWkbbntgskaVwSvFkG8qoVlapIfFKEpEapbrAVngzPn2N136R6+AH7I8jWLztvQyu/s=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 15:28:57 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 15:28:57 +0000
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
Subject: RE: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Index: AQHaAdfPhxwnTSjaME+BxwuoDPsj6w==
Date:   Wed, 18 Oct 2023 15:28:57 +0000
Message-ID: <AM9PR04MB860351E818A6DD715A7F88FDE7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
 <20231018145540.34014-3-marcel@ziswiler.com>
In-Reply-To: <20231018145540.34014-3-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|AS5PR04MB10041:EE_
x-ms-office365-filtering-correlation-id: 7cf3213e-84d3-453a-c3b3-08dbcfeef256
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n1iqNU1QTVSZIKHyX6EQIC2xAdHnuEmrf+k6yJqBvGgXQbYdcO2PLrveVYmMjWeCEHDw6ewKSFVz9umbt9L0npDxq41Yl0LHLqP8+rzRlczjLqs+qteh7XhD4E3RP5HYsPjy/F6CQv1W7Aup3hsh/ksSFM61aNx+okzHYQV37DaWq99ukRSIfBzevGPEQIY0V/Wl+MFd/TtxrJNdKZXB/6j6p6b8C8mY8C7LCFbWqnwvANK4Smr3/CwsDEYlDDVBUCic7Yqw8SJE3XDUVKNZ4k3p9gKF3w/42Rz4SDrdgiah8LpJy0ur7UPQP4XoJbi+VvIV/1umc3U2xheVkRb6RsDnpqMJBobp6QO/LL47UQZk1jgaec7lIKujzSD+cnJhH4bXiE8h66XmUkrjpU82U+e82zz4VWbB0YpKkUjq5PrXuGD0Li1sHR3qDnPDrxuBL+aEBfK4mNBobF462KVkN8/PJSLAjpijzSbMIB6+FmNC+bm7NRU48t7DvCoFm9rYSHHNL5Gf95/xU3M7tMxX5vjl4owYEBwq6Efpr8a14gbQREPaD7aNQyKsAES7Ek2LUDxaL5JBF7cnLWPhfZwVQdZp6gD/kQ5avXd9efEov6vRIunbv3pMvNg+L8lq733e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(76116006)(54906003)(66556008)(66476007)(478600001)(66446008)(66946007)(71200400001)(110136005)(6506007)(66574015)(7696005)(4326008)(316002)(26005)(5660300002)(8676002)(38070700005)(2906002)(8936002)(52536014)(41300700001)(122000001)(83380400001)(33656002)(64756008)(9686003)(38100700002)(86362001)(53546011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CqTUmwK7KCqNK//I2OqlAon6rm/xf8ThJu8ZAMWLfKUTLxQLCcme0uOmQx?=
 =?iso-8859-1?Q?U1uhXQicH0BuitNlhJXuOSRTBbtz7SsJBnznPMfcV4+Ax/gb7mmWqrO1+P?=
 =?iso-8859-1?Q?01MUs0ja3OUQ9KUwOk00W166IOEwEdGGwFQUwpGrq2pvMRaEXvABGibU2t?=
 =?iso-8859-1?Q?oglqooWU6tIbDMh0/e6nFJbwNE6JHLyRaHvrFYDY7OlMk0ntoj05PoBcXf?=
 =?iso-8859-1?Q?Fj0YC1PIrkD2hgo9vZynXdOOErz1A+X16ZQE7l+AlJxds437UbNNeDTHnJ?=
 =?iso-8859-1?Q?0j1m/Crmeuq8E/qGz340kO35Bxu5JVnKYiS0jaoGaavNpmJIYLhVbktJDp?=
 =?iso-8859-1?Q?hM4yscmIk+uRekkOs5Nf86hTaTRWXlkmIl6xFs9Eh2bIg1ujpuPp4RQP0h?=
 =?iso-8859-1?Q?0JUrnheRAuyM3Pv4oTpAZYkNN3yZDqwjQQQFPpKX5XxwsGAl1Yy3r6q/GI?=
 =?iso-8859-1?Q?NfEvThLt1Jl4nw0tCWDNESOWvCn9H726fzXdu5eaST5TJtmEtM5xhWqVcx?=
 =?iso-8859-1?Q?0WCCkFtK2ltA5W75giySlleX8p0nbeboiXxmai46p1M3FZNEPPWk26D20z?=
 =?iso-8859-1?Q?tQVeIAVfpDX5nLNRVtItrtbBT13cOaiQolnoKf9ZXCm5fZ4pIP1D4KNl3t?=
 =?iso-8859-1?Q?Y22ZzcwNl2TeI9vqF3NPq/2eGvoAuuOj18sXAEP3gtOisSChtqy3u0sX2l?=
 =?iso-8859-1?Q?rW0Szt2gGfD/Qc6qJ1viQLu8mA7M7DqkfnFjdEW3hC9cz9Fe/YUbjNSYhh?=
 =?iso-8859-1?Q?4Xh+93WWpm/tNV70dF2IYGwGtjjafN4NrbcLNRQqRwkpka1h1CtZB1ztPV?=
 =?iso-8859-1?Q?PEjE71mK27H/WX66NQLOAx8s3RSTnKsfi/M+olpIa/oWEfkYLdltEekGDB?=
 =?iso-8859-1?Q?nmxQTKwIMvHtH4vZAyLw/9KjKFYP4qKwPFkcsCMOxZrx9CLRRfHOnHGgPM?=
 =?iso-8859-1?Q?yvzm7zl1nNOW+yaqlMMvKK9c05g7R6gJYGTKjK+ETrTfkfZwxUSrdRLMzo?=
 =?iso-8859-1?Q?OM2pMgH1cDUFiQ/RC/YSkXw3r8/sBitA0ygA6n0hYa8y7LXdKbuGE3A1D7?=
 =?iso-8859-1?Q?uFWmXdNNoo2u4ohrFtYi5gIeZWRmviutZsCyRC5GMYy9kp69lUik7u9yvk?=
 =?iso-8859-1?Q?YUIcJpR50AgRvB2k4ius9REm1O3dCURT8HCFB4K6wtUq+wrDJ0NaBWo47h?=
 =?iso-8859-1?Q?QlJ+hXqg/S39ch6bLPFPSZdWQt9//Q6GCSDJnQG5sbk21HpBq0eu75XSVq?=
 =?iso-8859-1?Q?R18vwlRKPuOC+KSF/U859Zd2O8LweYw4J9kPfpH5VYfr/P12nQWzjzDD9H?=
 =?iso-8859-1?Q?IURP3bDsOMItEYgoXa9+2RiqHeBSb6bAMaHd/uh7w0KlegoJzxULdQH24p?=
 =?iso-8859-1?Q?5anoD5sEFV/aM6nJYWu/eC8lb1C6zX/WM4XCNvaP1FstIm7RJJtccTSIA1?=
 =?iso-8859-1?Q?WyPW14KofB/tZvoXPBsHmbeUDlDJW4+uUDIXD9tZ8uEv9eleVnSktIxJjh?=
 =?iso-8859-1?Q?Gsvm210ObVULeZ/exJ/s5BHJdHUKY6bSXBzGRBfK8xYURJEdTlvAg9D1zF?=
 =?iso-8859-1?Q?I3SIYQU4yABtHnJEh9DrRWzRS2vrZDfSfew+IyeyUqV8RXEM8oE7S9S9+f?=
 =?iso-8859-1?Q?kMvfM1PXulPyRPLM0bIW9VnCWn6AKKQC3Q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf3213e-84d3-453a-c3b3-08dbcfeef256
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 15:28:57.7544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FX7qb32o0+F23GsGRT53uqsYA3PlQQhrAqjLkTlLmYayiaRQLEcboa/FBX/f045YdK9d+z/Krbg4stjvmJjoBmCh6BqAT4iRkQu2y1eTgMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
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

Thank you for your patch. This change looks good to me.

I think the scenario you are testing/resolving is:
1) Load btnxpuart.ko first (which "may" load BT-only FW if chip is powered =
on)
2) Power cycle or power on chip
3) Load WLAN driver with combo FW
Right?

Thanks,
Neeraj

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
> Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
>=20
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Unfortunately, nxp_setup() may inadvertently assume that the firmware is
> already running while the module is not even powered yet.
> Fix this by waiting up to 10 seconds for the CTS to go up as the combo
> firmware might be loaded by the Wi-Fi driver over SDIO (mwifiex_sdio).
>=20
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> Bluetooth chipsets")
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
> This is what may happen without this fix:
> [  284.588177] Bluetooth: hci0: Opcode 0x0c03 failed: -110 [  286.636167]
> Bluetooth: hci0: Setting wake-up method failed (-110) Unfortunately, even
> re-loading the btnxpuart kernel module would not recover from this
> condition.
>=20
>  drivers/bluetooth/btnxpuart.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 9cb7529eef09..4b83a0aa3459 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1021,6 +1021,16 @@ static int nxp_setup(struct hci_dev *hdev)
>                 if (err < 0)
>                         return err;
>         } else {
> +               /* The combo firmware might be loaded by the Wi-Fi driver=
 over
> SDIO (mwifiex_sdio).
> +                * We wait up to 10s for the CTS to go up. Afterwards, we=
 know that
> the firmware is
> +                * really ready.
> +                */
> +               err =3D serdev_device_wait_for_cts(nxpdev->serdev, true, =
10000);
> +               if (err) {
> +                       bt_dev_err(nxpdev->hdev, "Wait for CTS failed wit=
h %d", err);
> +                       return err;
> +               }
> +
>                 bt_dev_dbg(hdev, "FW already running.");
>                 clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>         }
> --
> 2.36.1

