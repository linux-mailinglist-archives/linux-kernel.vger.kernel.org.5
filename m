Return-Path: <linux-kernel+bounces-27227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE382EC71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFBF2857EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14E175B2;
	Tue, 16 Jan 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYHjRm2P"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAD17568;
	Tue, 16 Jan 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idwpVFIVHHevVDAkON7kWMdLE3Kt4thxSHx+avu20BmwCtWia+3P42FGpykFyXvGpWzTz9vRwgRJ4uOvDkR6whTBbBfGVZsqjKidaep5PMv1LRfwCilD9XleY9iQGxWHkFTXsjW4Smbf3i6wj9lBFnfo7MD928igsuGyAVnNljRIWLQzCmChD/tZ0MTJ3Tf5Few537ehySffYCYQY1Z3aStwRJymuDSdHVGTMurZUKvA4Yd+/izG/N62X/pRJBrzTTfjWXTlJWWNkA5XdILx+aVoas85ngo3Z9mLPHzCc2pngeraaS9Ki+Bdctm51SzR0gz+foWTGnHEicb8Ruux5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX8AaQvvOhugl3Pdapny5eOmLB3UeQcOLYFGys1ZFDk=;
 b=QYIDqBIpeRpc/eJsOderBS0s1vZ1o9IAmMtXUy5KB/OwFpHbxqILydEHEEE+gj1FTfVJsKJ+Y73pJWvrjrTtHbQrIUPOn9uLf9CW1/S+9qXl+cO9SkG1AOc9Y18OULlfZDYuOAzvWSO4a8lR/WOQ66oNxzvzQBRhsghPGdWjwB016o1x3kLHqumaP0AZahtx2uFw10HGE6dB45xyBBVTsi/D+TEzQE/bWu8dCl141Uz6BCyP4E6nUBtKd3tqwXKkC7zfR+b3BAm20UnFInQDy8qjPZb3/BGuzYoFziSU6/e1i9xNS7V4h8AOOX5qFiri1hoLws+F966bgUZZ+Dkqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX8AaQvvOhugl3Pdapny5eOmLB3UeQcOLYFGys1ZFDk=;
 b=hYHjRm2PKaWJiZvaTR4/pjy41F75wNwfTWGRmXkgJ5ICOI5DPJLN6pE776VmaLgWrBnWKCfpkdfzl8U1emlQZhHEHMzKlZ84mHbmltfqsQfaXn83INXczxViLHK52SV2OJeSTCUaxP4txmCepjHru+9pP38Y4yEp4rf3LS0CYjg=
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com (2603:10a6:6:5::31) by
 AS8PR04MB8931.eurprd04.prod.outlook.com (2603:10a6:20b:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 09:59:29 +0000
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::530c:5815:14e4:2c7c]) by DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::530c:5815:14e4:2c7c%5]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 09:59:29 +0000
From: Kshitiz Varshney <kshitiz.varshney@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Varun Sethi <V.Sethi@nxp.com>, Gaurav Jain
	<gaurav.jain@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Sahil Malhotra
	<sahil.malhotra@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Meenakshi
 Aggarwal <meenakshi.aggarwal@nxp.com>, Rahul Kumar Yadav
	<rahulkumar.yadav@nxp.com>, Nikhil Singla <nikhil.singla@nxp.com>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr
 cipher test support
Thread-Topic: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr
 cipher test support
Thread-Index: AQHaMzkv0uKPr9fQ6U+/vbkIUpb10rDcXong
Date: Tue, 16 Jan 2024 09:59:29 +0000
Message-ID:
 <DB6PR04MB319097FF0EB342BA7B17E4D78F732@DB6PR04MB3190.eurprd04.prod.outlook.com>
References: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>
In-Reply-To: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR04MB3190:EE_|AS8PR04MB8931:EE_
x-ms-office365-filtering-correlation-id: e4fd5579-1377-4980-039a-08dc1679d4bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EiiL8s8cicx90vwZOkBRITxeum+YW3FqCXfw4Q8ZuTb7Nmb/6UUUwC2ZuOgc2A3nO/QWP+Ao1dWcPXzz5WkL2WASs3n+5i3pnOTRMl1Wxsz4w6KQTB2SZloWX9uFCgwo5n1iMOFQnoYwaMZ9eRjhEOMsf6bzudXdpOYibFXAqyRdIK8/G+WKrbjwfCIHtdlIxzgXr5Kmpm61teFCYq6ntU80UG+pW68Spjltu1YWFW9ebLvEjGzTs4IEdPShbEVLhNEX92abIBC1x0QTcWdtv1xLCeQT/WP/2+T0DkdORTruVGwZXsMjYWyWKLba6Y7EP0pYKp4el/GRKH7ClIaUtcx75IXKERG0kYtnMxOfzPo/UqnQnrBoptV4H8ZkaG9SVOcV4LCv4yUj8kwSieG97baKsEGVaB1ekXWJk+i2hHMlIGdSEeN36disbhfUPcWdWHAxhAi28oVcXmmQvGTMvCXmOPwdH7Xsl+AkkiqUI3tP+ncnvSOX10DiA5Dj3Wdhqj+krnNUGoL4UvJOTxVHoDVROzqRrMsAZ9yR+jSO65Y1m/j/A5Z5z4xKLS3CladBYvw89ElHUuCOdFYtgKzMVoXSg3TIPVoe5pholMNDTNUsAWUGwSj8dgjqXJFE+SnsK+oN62SBW1okcGqYHVEE1A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3190.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(122000001)(2906002)(41300700001)(33656002)(86362001)(38100700002)(53546011)(7696005)(54906003)(6506007)(64756008)(66446008)(66946007)(6636002)(66556008)(8676002)(55236004)(66476007)(316002)(9686003)(8936002)(71200400001)(478600001)(83380400001)(5660300002)(52536014)(4326008)(44832011)(26005)(76116006)(110136005)(38070700009)(921011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0okKNruLc/zhgY/uBV6YhLk+VFVpl7q6TFJJEBNXqZ32TAE73VQYtDbSWgFu?=
 =?us-ascii?Q?xh4mB+K+KlsfE99Uq+JH11z3QuRW4nS9VaikYFx0gW1G/NtFkxOFIxlcYYyv?=
 =?us-ascii?Q?niBuuc/QygJagVaKE+nc4Q63YB4VIKNiLqj9+5bMpvjtaSqP4mnI0lVtDjnG?=
 =?us-ascii?Q?tyaEMBhfUavWSCSSUP98jGRv4UCbBcJxCvdC1DmXfZNG5Lryos9bolEx1rrg?=
 =?us-ascii?Q?0L2QkJ9lBnzix7jFCsZJxznJoyxYr8XQnfMQ4Gj8tjPSDGoE4G/Xahxcuc6m?=
 =?us-ascii?Q?aiOZzQYCC2v2wtZEQ1YbK07bR5PTK68YBAifq8KL02iWGoxa6DnpCPZpGfPv?=
 =?us-ascii?Q?veRHvIxrMr9QjjLSOTqGTmnkgjCXXGS4vIVSZKQBS/cFoTUdPl5mcmef9Gw0?=
 =?us-ascii?Q?TjW5b3Qb4iZRmvk9odUEVjUqSv4zVW8zGtsMrnw+XNNB5UKwPX9GWYCA/KQo?=
 =?us-ascii?Q?8t2Wo9f4qSPdjIDlUCqV26GzXC7wEuuCeG8g0pAjkVz76z3x4RpCrwHQwvGZ?=
 =?us-ascii?Q?PjVsNWlFDR+r1NKXNueWwthwrBTvbXWRbznxBfGOtBabojIYA6c5tIkc822M?=
 =?us-ascii?Q?a94xML755/9X7kVkROkwD30kTNI/yrNgA2J1WlXr/HlaIXQ02f02pn/Hf6KR?=
 =?us-ascii?Q?OYZAaLC0c1J2VBX4l9xQMO6+6LNmPyONPqEHKj/Ud24avFMDsLWOmeK6d8WS?=
 =?us-ascii?Q?0AbVnrpV7EdP/e1aG9hxL6PAWy0eNNnfOmzWDSrJECOCh5eK9FUb9hEBEnLA?=
 =?us-ascii?Q?Z+J6KkPF5fP+KnrXl4KW31YajQEeNIqmu+AlscdPQQyQGlpJON0HC8q+VZlO?=
 =?us-ascii?Q?aTt8M/q9glASorGceKKBpq6jtlvXjCCA8tEugNAgefHt/A+V9oqeFb1xEntP?=
 =?us-ascii?Q?sTPHzB6onc4eflcatM5CLEt8avycZaBd/6nmoidGoDl0BkSyFvH3TZNPWfQV?=
 =?us-ascii?Q?YMOD3MrTF4UX9yT/8Y2wiQpu+0ydHwFOY2WQSEoOuLr2aPk8Qt6RVg66stXg?=
 =?us-ascii?Q?55ylBnqAZZAfO5mibWqjZT7JTSbOREy0iDe9s47X1Usxsq4P5YB4vA2vZtml?=
 =?us-ascii?Q?i2Tko9D/SwZO7mjXk+w8VqQfQnwoQU+zueE9ws6LipJIAAbCV31tKUeAS/E5?=
 =?us-ascii?Q?P/pWLsc0Enrb+37pEAhjMr860q1FuxgGWJWkLuKmxl3EjyfOtAk+2aL3O/JA?=
 =?us-ascii?Q?NiO+pR2L+d6VEzfQhvrLRq6Zak9qIgBTcmiI7q2bI/Y7TaHD539tNXgc6lnQ?=
 =?us-ascii?Q?eh0Zahf684BcMN/tH2qdbiwgd0N6oOs3FZWWZvlZeXpO9ypYYgStlT6rKUnk?=
 =?us-ascii?Q?IXWlElOnG7cVBYID+gowDP1/t4Pf8I0aJkve6lCmlH40v6K3BRPVEbH2hpyl?=
 =?us-ascii?Q?InBgZUY2qUfHof3uaq4+c2pq9p78aokwI+Up9G+fhQSmIIq7WBbA67eB3GXr?=
 =?us-ascii?Q?eQ/LfPhj6fva4fIFMzlQAmzx2ngIlF+vJL8SAVANTd6NIacV+x12rfQswRel?=
 =?us-ascii?Q?3qTYx/xlT25h2Cl1ByjI3PcQnfySQ6xni2LxcicxzXQVQD5kFWms6SJ6uPIm?=
 =?us-ascii?Q?75skHbPYu5sI4y2boMlPiO3tazylpvvHVAC0McPk?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3190.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fd5579-1377-4980-039a-08dc1679d4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 09:59:29.5601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYQQ1iNwR/XSkxl/u3SD6b2tLx4Sf2rRMMOkgsdf8VKZ3bL5IdDkar/645Oe3M9h/uO5Tahk/ZePdWeBQgOeTYXvKjuBO6DAzYInaDb8c2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8931

Hi Herbert,

Gentle Reminder.
Please help to merge the patch.

Regards,
Kshitiz

> -----Original Message-----
> From: Kshitiz Varshney <kshitiz.varshney@nxp.com>
> Sent: Wednesday, December 20, 2023 5:09 PM
> To: Herbert Xu <herbert@gondor.apana.org.au>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Varun Sethi
> <V.Sethi@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Sahil Malhotra <sahil.malhotra@nxp.com>;
> Vabhav Sharma <vabhav.sharma@nxp.com>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>; Rahul Kumar Yadav
> <rahulkumar.yadav@nxp.com>; Nikhil Singla <nikhil.singla@nxp.com>
> Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Kshitiz
> Varshney <kshitiz.varshney@nxp.com>
> Subject: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr
> cipher test support
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
>     Enabling CONFIG_CRYPTO_SM3_GENERIC,
> CONFIG_CRYPTO_SM4_GENERIC,
>     CONFIG_CRYPTO_HCTR2, CONFIG_CRYPTO_ARIA as module enables
> support of
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


