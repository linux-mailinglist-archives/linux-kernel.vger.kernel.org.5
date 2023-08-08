Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8397773EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjHHQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHHQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:36 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FE190B5;
        Tue,  8 Aug 2023 08:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6b5qsos3YtTyAO8pQGzgEr6VW/3+jDg4vBujjjpvJWJYYxO6ZArOdk92ui6OmfTgUSBxq4OZaAtvEPIDDlIKUnW+FGz5I5X+2jCAwOigjnSVxQy+qUZebd5zdgjU9DuHaV4Q5K2xfPOLtOyhNSvRIpoWZj4dr1SuaScVLYlAqz+EM6PbLNnaQEabgjiWuTD+zxvbVpUMS6dIJo6TZYO1Tt2WDYYARKAPPVtjoMAonGzVrGpe6TXZbC3htB1TDm9F20HnUL2u7ZPcoBpoSKlOCoN5NUjl2ftSiJKVTLr+0dWNH9EmwtpgGkCKrSPMyd4jlf/yQxUI2Olr+JcXwF/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1k7FWmS7+PjDzhgccC2dDknRsgean7wcMokttKSBHI=;
 b=PXE1ecOdguhstwROZqgmkMZAxYJndHtdpGrWnKu9SpTJ/ja7dI07UyzeGjsCffqUCHBycf85de2oAGOnEg4BFaDqSQnQP8wSbWeZgSDm/dlA/2QQqXWRoH1S8QTiUEV2N5K7rZaWZp9iwT75V/9JWpgoHxlAeaz1dlGplVSzlsPBWytSbp6Pu3FdlGdhp0T0nKeQBjMeABDFRjmWiYeGqPS4mOj3MKnF2vfUfEA26HW+CCLh2/JVYs6DufQjd5ZxnU6PpYY3H2f5/BHTTy6EFx6KhW/LW6YoEGEB7mofN9ai8QnMgHykE3Qdc+rz6SqtvopQunGW0UtZPuyIiH5/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1k7FWmS7+PjDzhgccC2dDknRsgean7wcMokttKSBHI=;
 b=OorijbavC79GZ5xiKlPoVnT168cYU6m6O66sc7p7CrXX4xeuvUjUm2RorzfuZ+Q3G4ECvgS2Qpf+WLBz4NOT171aSwOhImFzKipaBxDD9u35oCUYybKvMHHDODgiL8a8e/nM1zoaFvDjYUTRLTH+ObSehL+Zm3CgDDXKB8xNy0I=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 07:28:42 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 07:28:41 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Victoria Milhoan <vicki.milhoan@freescale.com>,
        Franck Lenormand <franck.lenormand@nxp.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Douglass <dan.douglass@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: caam: fix PM operations definition
Thread-Topic: [PATCH] crypto: caam: fix PM operations definition
Thread-Index: AQHZySCwZG/0pHaynkm6adQZjVAvw6/gAVsg
Date:   Tue, 8 Aug 2023 07:28:41 +0000
Message-ID: <DU0PR04MB95633A3F91F9D589F17573C18E0DA@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230807111653.1794160-1-arnd@kernel.org>
In-Reply-To: <20230807111653.1794160-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|DBBPR04MB7594:EE_
x-ms-office365-filtering-correlation-id: a17330a6-4179-4fcb-9594-08db97e1175b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAm/vbebOOn0/q+mft6+YN4lPlvcEB2KFitwBOUbBWYDO2pxRA2jbUt9e8WOa+deXbyYNu6eqT5RhCE5d9FdC7Zqvv2kVdhRBXRQ5pwr2SvPoJGdAl4u50oKqMlBpYx/ox1lLXH8P+r5JrdyoG2HV9u46ydjPpc12Nma51Hxn1LDZVwPJtfRGhJMCiKXnO6VyE8ZzSS6IgpKffy55geK1BN10VPSKmLYDVzFxoOnhVJ5wlHvW/6IAOjDOhV8Vsru8snBPory3HghAIkmU9rYs9BDbBOAGiQxMHEtleHPPpGR47aQF7zPqidg4sZZTGkjGThS+/nqAfbPJmfjaut8WjGB87lLjCKguIYCcYWvaS5Pqo7dMnM0e1Fm9Ts7abL4ZbZAEMXT/01BLZgQ2jiKIk0DhvIa69w8N4dqk8+MIG2EWEqcC1rzuPl0MTwM7GeFhFqp8JuuIsDDknm/OsBrFxD+HtzKsnAkTbSv2QuMdsTQR+OJK/sGU3VtXcrLmfPgzxCJgSoXaaZZBGtiQ7+l0QYKw70soF4CwVNNXWlZOZYk9RYdXhZXrQtOdwYs+9mdBS2o6AkOUnY9iPUNoS1PLgzSP4PIaGuU90MXfzCMRFTAmYU+6ltqVWBLcjFwqLFWScCC2tEuKVdRY9rkn89FBBbB231wUfsP3sh+6+BSErD3thLCw1A9t/zFtVwpvUTx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(90011799007)(90021799007)(186006)(1800799003)(451199021)(26005)(55236004)(6506007)(53546011)(9686003)(71200400001)(7696005)(122000001)(478600001)(33656002)(38100700002)(54906003)(110136005)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(4326008)(6636002)(316002)(41300700001)(8676002)(8936002)(52536014)(5660300002)(38070700005)(44832011)(2906002)(83380400001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z7n+p3LiV1+IpOxfjnAQiG94OipvmFYVAaHfVk2zUVM9qgWfXme93IJJb426?=
 =?us-ascii?Q?6c2jbEKEbHJ2c2x+O5SwvcCm68iRpPhdsy1BA7SPHvgMlp1AtfY2D45KFCGL?=
 =?us-ascii?Q?WCYmJuyz0zGSiOOmQC/UlRlOVE4Z8PyLZRT8/m49CZBh1+tWhrqEK6nkW0kt?=
 =?us-ascii?Q?fOLfPN9O/+9xEeIcLsmYEiDhWIG2jlOaJ1tLZw8EkJMvrGygXRHScIDC8RZ3?=
 =?us-ascii?Q?/fzz+PdDQgPnfiRv8RZWydm1ZI79p9GRRnGF2lo5i3GpZbegBQeLnO7PSr4W?=
 =?us-ascii?Q?KKU62JJhjzenyl4jm10MrBMYs6bDm71wibMm6Bl5IhbjuH4I99dv2HmcU4pD?=
 =?us-ascii?Q?B4IGBIbE8H+QetevwmfL/nqKkd7qdNg2hOVWa0nPdlSD+a7zBS9YW11TL/50?=
 =?us-ascii?Q?E8373Z6/WnzPTxHvftonVXt7S6S6k4/MRb3Om1ytOfUzUQDciRuMf1Z7VCWV?=
 =?us-ascii?Q?Uu3wXXTvlNenx18dNns0KyaGNLewc607TGOhJa84DWbNUG3EqRO+raqQYiqY?=
 =?us-ascii?Q?GCzwG9AA8M9zEhSRG1t6uGZqhqDuPcBEALwtDRp8/lqU015OTUhJemht8z3v?=
 =?us-ascii?Q?/0XOSLHtRFcfEQPPOlgyh+4lkm1eeaIJqyQ/9uy6Ywlsbqm686uelRKxZ1QE?=
 =?us-ascii?Q?6S1BSPyZ6g0Q6qr04fQK72quvwCzVw1+Zs/mtNfsAhjQ9ZrddMbniQ7ZTjI7?=
 =?us-ascii?Q?g4hX1EOkIV1qIHQ987joaDfDzRRHOlJPYgKOnCEqQDS+A6VOB9Zf3WU3auRl?=
 =?us-ascii?Q?8oG7m2WUZlvLMfRae6mcGjEuirKROPq71EvBPPDC0Nn8H4x0wipq+0bYN2Jr?=
 =?us-ascii?Q?I5UgoSlgchxDuGabRGkDQMrDpBw3DeaK5o4oovXXyGtMcdFhdWAOH17DdZXC?=
 =?us-ascii?Q?cLuVeMp8OKdQOP3QJFZfgAn0sdDAUsS4zeLEfcwla1eMa57dxwfDO2dqVYvg?=
 =?us-ascii?Q?KEiUiDNBniXg9yh+UVOAB6EG4lJ7LO8Df4EtwxwcZhuwAQx2WvoTdHXdmXCc?=
 =?us-ascii?Q?18XJsmPgjeZ2qb+hMZhxMQ/z2Z9DonsK6yeGZlla4yuTkuADR9/+u47weXbT?=
 =?us-ascii?Q?7NT+MkrRUS7NUfVOMf5V4/yXQTG04IYWSdtZlUnWruKLp8XswoRLUoRRQ5ML?=
 =?us-ascii?Q?IhS/AMBEvlFUuTYO+lX7mYUcK68MGX9IlOxX0A23Atpw5zkO42S8IibToKJY?=
 =?us-ascii?Q?XUoT5WsiKeUBVbcNxlVOnhFlPXHy5VKBMHjIRwW7clLf9wUH/vf4T0FR1tsZ?=
 =?us-ascii?Q?qBjDFv2dvCUQnHZzDyLokXi2ZnDKBjq/t+6z5b7ha/BOp6bAA93MF+Vt4Vzh?=
 =?us-ascii?Q?87gbeyQtA7WVgBeDRL4qqcKE4SxLktsVX8t/+JyaxDjZ+s5F28ItbLHf6nHX?=
 =?us-ascii?Q?9pT9vO/nbYYQ6lrKuebxqCdZ8s2jGO3cXnbS9wORxWyFwJiiI6Axv8SYEAOC?=
 =?us-ascii?Q?ELT5IEn5IjwmP3+rgc4hBm4Zaksf3tnoEvKXaTYePCzyFVbaaLE3QQ7u25vs?=
 =?us-ascii?Q?umt2gd7d3BAuCz/TZCHvi6sKXVLLPa+szf8s+D6Yo3krJCDymMuxLhI/jnHG?=
 =?us-ascii?Q?BK7QzvvMw88t50DOUuP2df9D0NaDFVQVwqEnTI638m7mDQaXaKKsq/h9USa/?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17330a6-4179-4fcb-9594-08db97e1175b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 07:28:41.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTgGg9N1yvjdwXNELSX7NE2sOq+bWBLitchcX2TTIbmEjTZam1DWc9frxT9v6vDjtGU3bkuPHgHY0G+ItKCpKmpP2Ssl8KpDwdn8UmtkkCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Monday, August 7, 2023 4:47 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>;
> Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Victoria Milhoan
> <vicki.milhoan@freescale.com>; Franck Lenormand
> <franck.lenormand@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Vipul Kumar
> <vipul_kumar@mentor.com>; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; Dan Douglass <dan.douglass@nxp.com>;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] crypto: caam: fix PM operations definition
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The newly added PM operations use the deprecated SIMPLE_DEV_PM_OPS()
> macro, causing a warning in some configurations:
>=20
> drivers/crypto/caam/ctrl.c:828:12: error: 'caam_ctrl_resume' defined but =
not
> used [-Werror=3Dunused-function]
>   828 | static int caam_ctrl_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~
> drivers/crypto/caam/ctrl.c:818:12: error: 'caam_ctrl_suspend' defined but=
 not
> used [-Werror=3Dunused-function]
>   818 | static int caam_ctrl_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~
> drivers/crypto/caam/jr.c:732:12: error: 'caam_jr_resume' defined but not =
used
> [-Werror=3Dunused-function]
>   732 | static int caam_jr_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> drivers/crypto/caam/jr.c:687:12: error: 'caam_jr_suspend' defined but not=
 used
> [-Werror=3Dunused-function]
>   687 | static int caam_jr_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~
>=20
> Use the normal DEFINE_SIMPLE_DEV_PM_OPS() variant now, and use pm_ptr()
> to completely eliminate the structure in configs without CONFIG_PM.
>=20
> Fixes: 322d74752c28a ("crypto: caam - add power management support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/caam/ctrl.c | 4 ++--
>  drivers/crypto/caam/jr.c   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> a7a4583107f41..2a228a36fa15a 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -841,7 +841,7 @@ static int caam_ctrl_resume(struct device *dev)
>  	return ret;
>  }
>=20
> -static SIMPLE_DEV_PM_OPS(caam_ctrl_pm_ops, caam_ctrl_suspend,
> caam_ctrl_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(caam_ctrl_pm_ops, caam_ctrl_suspend,
> +caam_ctrl_resume);
>=20
>  /* Probe routine for CAAM top (controller) level */  static int caam_pro=
be(struct
> platform_device *pdev) @@ -1138,7 +1138,7 @@ static struct platform_drive=
r
> caam_driver =3D {
>  	.driver =3D {
>  		.name =3D "caam",
>  		.of_match_table =3D caam_match,
> -		.pm =3D &caam_ctrl_pm_ops,
> +		.pm =3D pm_ptr(&caam_ctrl_pm_ops),
>  	},
>  	.probe       =3D caam_probe,
>  };
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c index
> 316180d26f8ae..767fbf052536a 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -794,7 +794,7 @@ static int caam_jr_resume(struct device *dev)
>  	return 0;
>  }
>=20
> -static SIMPLE_DEV_PM_OPS(caam_jr_pm_ops, caam_jr_suspend,
> caam_jr_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(caam_jr_pm_ops, caam_jr_suspend,
> +caam_jr_resume);
>=20
>  static const struct of_device_id caam_jr_match[] =3D {
>  	{
> @@ -811,7 +811,7 @@ static struct platform_driver caam_jr_driver =3D {
>  	.driver =3D {
>  		.name =3D "caam_jr",
>  		.of_match_table =3D caam_jr_match,
> -		.pm =3D &caam_jr_pm_ops,
> +		.pm =3D pm_ptr(&caam_jr_pm_ops),
>  	},
>  	.probe       =3D caam_jr_probe,
>  	.remove      =3D caam_jr_remove,
> --
> 2.39.2

