Return-Path: <linux-kernel+bounces-15339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DBF822A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCF31C231AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2978818625;
	Wed,  3 Jan 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rFjvGIFM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D88182CC;
	Wed,  3 Jan 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3ZLDelv/CHAtpZJhRrrnmviQRaYXQRSFXD1n9j15YmUrV8ZI1nPolZLhUgirhfDfkKLKfOjtsKBFX1AS8fEcQRpkNPeQs3rLQc91DTgJK6RxL2IfD4PGFwGtVFGEDAEJcoWg2j9WdB+BtkZXOaNlnlDXVHAHJgsqJfk0gqIKrGpjuYmq5qemcx+U926OSORLlOvDBCd8qlo8p8+4e+836T5Bwx7VPfFQOyxXbM2C4+Wc1NKArhcALVHPfwJIC5+hMRFYsGmQYNNihhgBZTGk08en7m0VSU3o4vslAgTn5Pt3lBzxS+ZcSS1KxX8wo4bkbSxDsasFsDfZq5PI0pCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch2dIGZGp6xFKWNcOivo44gfdSxK+ZDzrxZ6mw0vKbk=;
 b=SHdhy2mE0Wsa9wst3D7myj+/hVm2SaiUL3rFwDIBn0l8o2gEanjqhPpPMMMTPwgAnhOQ0GXGSdQ3q6IvL9SdQ2vpoholLYVnar2fHrwpz2+euUQmIl5+jq+JdXvgCagzLwjXlRFy9NOs2kbW9DzlS+s/sHpMAmVkQxaMsHF5xSkhJ1nsH2CWIa+gDQXO6DpBPPyYAokFbd8bgoR4AwQn8katPs92BIUwNxar5IQ+Sc68LjPQc5k+1EJu8HIUJm4mljW/1yGB31cmMlWUZQ8VPtQ9rQHdb/5+mwWTnDH3TrsXflhdbKADERxe0XWb+XsuKrFj4qImMDU31UZIVKCO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch2dIGZGp6xFKWNcOivo44gfdSxK+ZDzrxZ6mw0vKbk=;
 b=rFjvGIFMJ+SkbcBLV7jwJu/P5yfXEbNmclISI//cPGBsRjJUK1QgsoO4Yd8nN5dPaS4YfRCnP7kYP4Uj8a9grjJv8+ghdOo2GvuXn7FSbs1br/+2No0Cw59bD6OkVLoCvL3pHekMOxiORTB8j6fcTDBMjqpWL44iOQjcM24E/Fw=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 09:43:06 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::f62e:ed0f:3b06:a7d8]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::f62e:ed0f:3b06:a7d8%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 09:43:06 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Kshitiz Varshney <kshitiz.varshney@nxp.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Varun
 Sethi <V.Sethi@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Sahil Malhotra
	<sahil.malhotra@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Meenakshi
 Aggarwal <meenakshi.aggarwal@nxp.com>, Rahul Kumar Yadav
	<rahulkumar.yadav@nxp.com>, Nikhil Singla <nikhil.singla@nxp.com>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr
 cipher test support
Thread-Topic: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr
 cipher test support
Thread-Index: AQHaMzkx+V0IkxKncUGvMavsJEEKarDH67qA
Date: Wed, 3 Jan 2024 09:43:05 +0000
Message-ID:
 <AM0PR04MB6004679655AB5F69C8F12012E760A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>
In-Reply-To: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PA4PR04MB9415:EE_
x-ms-office365-filtering-correlation-id: 283edc66-6daa-4ccf-57f9-08dc0c406328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 etoOMfBZKAspLTw27SZGBk9GSyGgfmFbif2bzVYDPKGJRP840cF84i1k7fi7wDaA0kySeREUiwH/ny+DhYBp9L2j72hMCgmb27O4Plz/PeQ3x33hHMuAGLhlc32ZhRqUfqoRhYM5tw+BXYBxUS4sV1OgmP114Sr65DOC9hClC5mGrrryc3jQkgjpuOZH6fjFHJmbzoThC94XIQK11D6wGBYJb3P6KjBeVVAv9IgagS3sI7TIBG7y7Nttq/LmQsF/OHL1+3qYnx8GY3GyJYGHauCKYDpK2DMDaQN9TWh+o+N0kB4H2YBM8pc0/dOO0PngskOurWPn+xbGMLgXu5Gj9LnycrLqLCOVB3842fzwCcWD3k+ncDctoZCjvMLO2aCfFvTg8IS/lORP2ZstUUJW2vvM4Pg4TVDmBYzvT6NbmhoEnMMLcaWLuQog2aD3DT98pGoxxin0aXbMI9xGRySvpMw8s3IsKoHnXR3rsoy6pdHERtACTRQIw75AFz+ccZjyK2RKkijl+gRkOAvkM06V037tSsOb7pANZfNnjnPsUu4EY9UzMbnkH3ckaSLPK4TDIF1fuWoLSjFk1ozStHxtCNWw8uF0xN8EtkdTOmNfwT+D07GuyQoPdHmDfOvKmOJ9aHdvtNbY2SihiQ0gQKgEZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(921011)(53546011)(66946007)(7696005)(66476007)(66446008)(6506007)(64756008)(66556008)(9686003)(55236004)(76116006)(38070700009)(86362001)(38100700002)(122000001)(83380400001)(26005)(2906002)(478600001)(6636002)(4326008)(44832011)(71200400001)(5660300002)(316002)(8676002)(8936002)(41300700001)(110136005)(52536014)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2RgTQ2JQG9v9/kAxLLQ4iXA6XZy/f3HtPsnP4dSD7+3N7UIp4XO6Q9TfXzBF?=
 =?us-ascii?Q?kD/ar7lu0uZuMFR9YmwuIPunepRfRhSbg6zDCtOdLxHLUocA81va1B3Xm2Z5?=
 =?us-ascii?Q?q7W5yoZ0e46+BPWuJK8hfHMFFzVJMcyM/hQxW7hf7ai7D6Os5ohB98wNeQ5o?=
 =?us-ascii?Q?eghEXi6WEcaRIjXbP1W20t6DvQJ4cLr6EuJLZanhnQQv43mb4dt3VVtx/VMt?=
 =?us-ascii?Q?nlPuGRB1H+ddco7CjaVMB1gWvx1bFSyLI3zDd+x6NonHIJ7O1gxaI3Z2Z77w?=
 =?us-ascii?Q?iUoKSe2XZr8HB/M4vovYxEOpfRBZnvTWFqwV9qFuLhaaZVelT42zN7iLjyjB?=
 =?us-ascii?Q?rGkqfWDplg5dp2BTV/m+fie6Ph6JKudcJI9JuBScFxJ6KodRwfLFq6fePlGM?=
 =?us-ascii?Q?Pm8+1r03OUIRXuvMREyOZ4Q1zq6VU6SGk08q/4oGh3fCYW0FtnIxgosKI71G?=
 =?us-ascii?Q?Blzo9raymXhpX+lS8shWjTZe13yFQ+XGD+RdNBOBucxJVaWOQshuuWUs96mw?=
 =?us-ascii?Q?ZKIhmz/3N3kWruxHzTMB58xXW/4H4FuV7WiMQnrSCL1oO1TtRDoGorfnpnKs?=
 =?us-ascii?Q?Z5Ge+kAOuh/oQQztroqcyyZPzvd+eatwgLfbDZlxeKRVtygXmnS4Eh270jM3?=
 =?us-ascii?Q?ZjccYe0MjeK3U+662Pg2OHSQwduWsY6n0GZretcLjjnVwpDdhF83kHhhfsx9?=
 =?us-ascii?Q?6DhWn3hWXKYz5CcG6foSy0upXaT8p32EjUp+2c65A5IucNr6O0LDHXpMnfG5?=
 =?us-ascii?Q?63CwiUYmYnqCCOslDEs1w846pFcRSg8dUzMwgEctGANfryJb9tGQFZOeRiO7?=
 =?us-ascii?Q?ql+nzYJUbke3O6+MlFVuc+AR1vFGLWBe0WKN+NgPRmRnj7OyfHX0KVANTsRz?=
 =?us-ascii?Q?QXw0XdhO4j41x1ONfy4VUzowUo1B5N0oN620E90lUYW9S8KAZUcekCZPDAZv?=
 =?us-ascii?Q?ALbpTkhP/qBFt6mLxUvzZ166zlOK4fFdpSDZE3xEbMXsayVu5oNzzVZqQ+DT?=
 =?us-ascii?Q?iMesuNIcwg54Nn8u01MEpfLuhhuuovMo8X3Oxdabv5m8fcuXvrcd+dPLqXzP?=
 =?us-ascii?Q?vGg1J4uvmokvzcArIjO1KZyMQlmI+HfLItTHiDJWADtb3mFhd0sVpjtnWWsq?=
 =?us-ascii?Q?sByrmUQDJQbe+49bZkj3hJlFj7ErA6ai0vAqLu4ASrH919UAWwyFG295DGth?=
 =?us-ascii?Q?ukmet7tjbXlrB86fkMdTNc2pAnGdmJ1aO1VLl/L1vMTfr8xmtsT5x+JC5e3t?=
 =?us-ascii?Q?JGz6odw4hgXLmLMgquE2dNiiGy6Rt1KO3AWUXdEM+nbuqX+6OAFONQ807eMy?=
 =?us-ascii?Q?12p87gsI6B0SVlrZD5EPt1lhiNtGIJ+JsITqfhzEuw9apNOIjJKb19OGd+Kr?=
 =?us-ascii?Q?cTN7YDOAerRXw+itc3h2hINf4h18F72xsRgbA5AYCgOj4KZVwI+s6m4GrnPj?=
 =?us-ascii?Q?ws93/5vs0ovn8GRMVLfSg+KEBHQXTu3LuIFHNxziYIBrmfi9wwGkHSM3IEfA?=
 =?us-ascii?Q?wFR4TWixmOe2zhTe3rVWRpx22Rh3puZAwGenu2Kc9sF2bpyXvK4zUFIcAOV+?=
 =?us-ascii?Q?4+29puJJNQWGpJW2/KLfsRMi3OuS8dHZd9v1sXKE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283edc66-6daa-4ccf-57f9-08dc0c406328
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 09:43:06.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQMv3ND6mwO+HXFdWypWY9iG98H+gyPKCBccxyDz4wWEqI0LVCvBF+/cbTrP1iQE2cmAanljsxYgNin4RDYQ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Kshitiz Varshney <kshitiz.varshney@nxp.com>
> Sent: Wednesday, December 20, 2023 5:09 PM
> To: Herbert Xu <herbert@gondor.apana.org.au>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Varun Sethi
> <V.Sethi@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Sahil Malhotra <sahil.malhotra@nxp.com>; Vabhav
> Sharma <vabhav.sharma@nxp.com>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>; Rahul Kumar Yadav
> <rahulkumar.yadav@nxp.com>; Nikhil Singla <nikhil.singla@nxp.com>
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Kshitiz
> Varshney <kshitiz.varshney@nxp.com>
> Subject: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr c=
ipher
> test support
>=20
>     Enable config for sm3, sm4, polyval, xctr cipher test as built in mod=
ule.
>=20
>     Issue:-
>     Multiple crypto tests like sm3, sm4 xctr and polyval failing.
>=20
>     skcipher: failed to allocate transform for xctr(aes): -2
>     alg: self-tests for xctr(aes) using xctr(aes) failed (rc=3D-2)
>     alg: self-tests for sm3 using sm3 failed (rc=3D-2)
>     tcrypt: failed to load transform for sm3: -2
>     alg: hash: failed to allocate transform for polyval: -2
>     alg: self-tests for polyval using polyval failed (rc=3D-2)
>=20
>     Resolution:-
>     Enabling CONFIG_CRYPTO_SM3_GENERIC, CONFIG_CRYPTO_SM4_GENERIC,
>     CONFIG_CRYPTO_HCTR2, CONFIG_CRYPTO_ARIA as module enables support
> of
>     sm3, sm4, aria, polyval & xctr.
>=20
>     Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig
> index 0a90583f9f01..627f57da9d5b 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -484,3 +484,7 @@ CONFIG_DEBUG_FS=3Dy
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_SCHED_DEBUG is not set
>  # CONFIG_FTRACE is not set
> +CONFIG_CRYPTO_HCTR2=3Dm
> +CONFIG_CRYPTO_SM3_GENERIC=3Dm
> +CONFIG_CRYPTO_SM4_GENERIC=3Dm
> +CONFIG_CRYPTO_ARIA=3Dm
> --
> 2.25.1


