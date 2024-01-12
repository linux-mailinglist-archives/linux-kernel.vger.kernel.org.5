Return-Path: <linux-kernel+bounces-24756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655AA82C1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFAC1F23B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133206E2B4;
	Fri, 12 Jan 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="u8fa3VLg"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74E29D0A;
	Fri, 12 Jan 2024 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4DQdDhH0uYyLwpIKC6Rxp0UwVzeOJEOXuyGXwFZnsyJ5vjl6Hb+JzZY5PvkUxgF7Qu7UfzvJ1+Czl8oGIFyNW40EQtZgyllZXphjJ1vSps4+W4YG0GMCNUfxbMPeolLULJWcHgUaL0DpGTvXRVEfPruthlP3WfkFNM9hgCDO47p7rV2QIQ9Qq0TphxIrVHD76MKwPm8SVZbnTss2RemwV1ZGWin7WpHoY3sm0PfQFPhfMQepVIqJyF3bZRtDb/1H1gjrGWonwJC4esRWR9Idr1gAc9AJPvKeyYfq8BcZ2nnLc2FY0HM/t0sXjL6L9UdS7SGifNFDtrnMN23vgzFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc+tgQ2fvqOrk9RTZNlFTMGg4bxfxcwmUmE0SU11V18=;
 b=oBxKM9JUbEc71slOAm+VmSNDoR0YNLBV0soyZnBVt2FjA9DQRB9qVbxOVCxlpMcCZLa8ZG/ZHPPD5ielgN692SdcTVDgrym7lUKeW+9EkwBL+D7ezgz+iTr+c9P71hXjkYsTJAWMpgc/9yCDLUjFrC1cLfkyBHVcPGNNXtWH4/fen+XThCaY3aRDMQvAml3Ut2nC9uhBq91W3MZIw6kFhzz2n6uB+fgtO9MknAR/I+zAmP8GN+rLbNdh92Mdm2/tzOEIg9AoPosPQTTE6CpuPOqPmqKxK3iuFSI8mLew04pLKuHoYP7bn4gihMKLEZdgdmAMq6DNbXMVIx/YvXrcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc+tgQ2fvqOrk9RTZNlFTMGg4bxfxcwmUmE0SU11V18=;
 b=u8fa3VLgXmZP8ySQqihENjUW5817vdpsmWRjBk5YUHHHBqv8Ge53Ha6o/JuVb4c1ABnPJvYJVT7oN048FVSUwpKwKd5X/vF3AKBD/B0e8nxPMpro68q0mNXA3joRIGgXMOf0hUdxNE3jGcXRFdPzrGSMJQdE40gUEc/qgaYXiTc=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB11333.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Fri, 12 Jan
 2024 14:31:11 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7202.014; Fri, 12 Jan 2024
 14:31:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij
	<linus.walleij@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
Thread-Topic: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
Thread-Index: AQHaRWNYeOFbn4ZS1k+YsSHgigQSfrDWPJeQ
Date: Fri, 12 Jan 2024 14:31:10 +0000
Message-ID:
 <TYCPR01MB112699FAB53E6E4647893516B866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240112142621.13525-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240112142621.13525-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240112142621.13525-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB11333:EE_
x-ms-office365-filtering-correlation-id: 1f5765be-f5bc-49bf-8898-08dc137b1f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CKpviayrrMUGC7c014o+mFdZ+usU1KLcULHM94tciZXjdipGc3ftGbruLSMz4sWNzlVNclf0BIji/AHbC/DN/g/r+kqkwqMovU6rQjVW+WV49Bvx9Tt/bU26xoCMntwECcY+XnPF6BYw2I22dsUQvKMKObf69j3cJIyWfaWQMt5wToeneaPFoyLXC1gB+mmqrivWmq09bIbr8g5xHizpdXLNZim2+tc6sbpH0Z6gnLw1ZmabwMUIf1jZmOaINrQ0PMmAIR/KqUw8+mzIouCCRxDEfrhktZW6slT8KBHrDPScIW/ZLO3Yw524X1VTvILH3WJ2Q057DGnjbEwTpcTk9AswIo38Odsnl/lfj2xw7fZfxkCHP2Fzskq6IKoFlKppuEFWH5NNbZXUXAEYbblUHdWzZ0m7eHRmwvIiImZyG/+NwOM0dT0AwHiTxNwEpAB4sLybHx6xMRJm5ZWIgTEKrh0msF38pmHZw2YX1jusl2yRCKjgZM5cLUniiveXWqgjuunR+zXo/kipCFh5bfi1PY+RnREEw0ClwIOHK57uMQMB1XnRHrgtsvZTimrz6JdtM1as/6PztrFr/HyZUrZnjZbjM3eFWZWOXMv93Ccr8Pu1Rwl7kzmPHUZGQqGaAeEa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(71200400001)(53546011)(9686003)(7696005)(6506007)(478600001)(41300700001)(55016003)(54906003)(66946007)(66556008)(66446008)(64756008)(110136005)(86362001)(66476007)(316002)(76116006)(33656002)(26005)(83380400001)(122000001)(107886003)(38100700002)(7416002)(2906002)(52536014)(5660300002)(4326008)(8676002)(8936002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ca2NAhlpkA1bJCCRX98L2Z5CynkLYvLhyk3oapZs6v7anxQAYWV+8sA47hih?=
 =?us-ascii?Q?NrBbCQW89pDz/tZtR8S/z9ttArIhm/rkbeO04ABzo8XD7STRgTfE5FfvN7Y4?=
 =?us-ascii?Q?AnRDrKXkCfQiZBh5XBh7ITgrcW6vJsc6NTgYuJVvL0SMRKc0QvmF6JhVyDmk?=
 =?us-ascii?Q?/defASdZJNxISscdlneTT1v4nBHjlQ+lEuH0DpIMeeUM0hHDSBSYMHu1BecO?=
 =?us-ascii?Q?s1CLR+mG8Y0n9fTV/QVdXSNKoDDV+9c0zR03gHPhP6Q+ZmSEtVXYnSvokoB2?=
 =?us-ascii?Q?tkrQLnF662n/JoSNwm334bKEB40BQozO912CPb6mnmS4e0yR0gnCs5v1v4up?=
 =?us-ascii?Q?BSBmil9Qr4BUl5998k5YTXeEDrpudRU2/V6aa7SFq66Ho/qZQ67JlpUnrA/j?=
 =?us-ascii?Q?VXkau5WM3be3/Ik8D7em0u2G8iwEYqa6aong/I+EvALLGRMHoQ8oYGSb1G/6?=
 =?us-ascii?Q?X8rdHtFTsnLJg0fh3gjdjNGhYQCjPWEVVBycul1uETnDvKwRgzwrchmAuBw9?=
 =?us-ascii?Q?pPn4C9MfuAqZn46mtW8U1r8b/mLJ6K5S9LmMw7PHHykHMcGP/1cIOiQ98Wsv?=
 =?us-ascii?Q?t/LPliAfef+0/Tsbrzy8uXzGB1TcCtsrcxGCns8oPX6oNRWVF6p0LKRt5ZgP?=
 =?us-ascii?Q?AvjgBKyQm9ZvCP+UIHPtilRNPexJgSU0c+q85/gEhXOi8qblGBm9pabtfcXI?=
 =?us-ascii?Q?a77n55qsZB9yzOJyXPnn4sKZ/x7newr1i+NNnehuG5YpGkl+zd+k6P1qu2qK?=
 =?us-ascii?Q?Ua0cwgvA1caX27DlyVCmMZxZj0p4r9pxdjCYU9oQbgU2JU5uS0axSdrLsDLh?=
 =?us-ascii?Q?p/idmdw849g5H9vUXSlGU1una5aS2o8gLod+ndCnSEU1VIh8XjQmM8FQL2np?=
 =?us-ascii?Q?aLE3Jl6kS078VLR0/de1iB/lni6XzLA9LJKzgz/QB+lhALpvSx4L0qugBwuO?=
 =?us-ascii?Q?n/kfceQswGQRplEK1cLUahNc4vw3isXFEhyUMdy7PB2XO6SUc/xg3LXSLvSC?=
 =?us-ascii?Q?YTyHEF+ZlnDM1sD+dBgbFBN54qbEZp3t8qqSWNQmKbGw9yxWI6ezlBtfGfAc?=
 =?us-ascii?Q?oi2rnmG+APKJMpdiMrcKFECO2IC5LbETeyNbnik70vE+Ut+WldOCTg7hQgx6?=
 =?us-ascii?Q?DEW1K8Pdv5jmaD8dT0Kgv/GPSScDfPMRrGmI6B+9e5jpYyDbZG5pBiin3ou0?=
 =?us-ascii?Q?XJQAlVy4z7nYactonuaVu7Urg2ZR338sGbIjun/mRemS7BaR7oboOVMRUBgN?=
 =?us-ascii?Q?bY3tlISfjNh2U3wD8Rg5zqrAwEmHk05/t69jsOsCNkD8s8FykziPG7u+E4ZO?=
 =?us-ascii?Q?gouaqYj5eSZVbbthKrOHIJMcQSdhr13sOZU4v1NQkDairPvg9JeM1LnruwoZ?=
 =?us-ascii?Q?rO1uFwwyJ0f2H0Epunm7rHx/GuOKlhxUCtYiACvKfaVqmogXuVkyz569hqYk?=
 =?us-ascii?Q?6B61d74S/WVNUPVoK0ld55IlzvLFnbzhglQTpECLwifja9P4scvq+pd+OckZ?=
 =?us-ascii?Q?fBTd8vEWk6jlszwINIgLUqAhfEdS7iDH+AI+Qly94O72s4noW8iME7jQ2TOC?=
 =?us-ascii?Q?MV4JqEoydQRh/RzwmlLhNVCj/ImJAjexb8MqeUIWnKrT21IzchoQhLhIyAYb?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5765be-f5bc-49bf-8898-08dc137b1f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 14:31:10.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxZDUjeS8yWaCRtxXyZFgJxsfLo0ar3UChj4lrAX7LLZSsf8wDvMB1oNRkl6RP//+uvUO1pUyfoWqa3ToLxsugzBsAYOHOWZOn/qEtdvPXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11333


Hi Prabhakar,

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Friday, January 12, 2024 2:26 PM
> Subject: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
> port pins P19 to P28
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add the missing port pins P19 to P28 for RZ/Five SoC. These additional
> pins provide expanded capabilities and are exclusive to the RZ/Five SoC.
>=20
> Couple of port pins have different configuration and are not identical fo=
r
> the complete port so introduce struct rzg2l_variable_pin_cfg to handle
> such cases and introduce the PIN_CFG_VARIABLE macro. The actual pin confi=
g
> is then assigned in rzg2l_pinctrl_get_variable_pin_cfg().
>=20
> Add an additional check in rzg2l_gpio_get_gpioint() to only allow GPIO
> pins which support interrupt facility.
>=20
> While at define RZG2L_GPIO_PORT_PACK() using
> RZG2L_GPIO_PORT_SPARSE_PACK().
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 213 +++++++++++++++++++++++-
>  1 file changed, 204 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 8b8644d2c355..04bb21d564d4 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -57,6 +57,8 @@
>  #define PIN_CFG_IOLH_C			BIT(13)
>  #define PIN_CFG_SOFT_PS			BIT(14)
>  #define PIN_CFG_OEN			BIT(15)
> +#define PIN_CFG_VARIABLE		BIT(16)
> +#define PIN_CFG_NOGPIO_INT		BIT(17)
>=20
>  #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
>  					(PIN_CFG_IOLH_##group | \
> @@ -76,17 +78,23 @@
>  					 PIN_CFG_FILNUM | \
>  					 PIN_CFG_FILCLKSEL)
>=20
> -/*
> - * n indicates number of pins in the port, a is the register index
> - * and f is pin configuration capabilities supported.
> - */
>  #define PIN_CFG_PIN_MAP_MASK		GENMASK(35, 28)
>  #define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
>  #define PIN_CFG_MASK			GENMASK(19, 0)
>=20
> -#define RZG2L_GPIO_PORT_PACK(n, a, f)	((((1ULL << (n)) - 1) << 28) | \
> -					 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a))
> | \
> -					 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
> +/*
> + * m indicates the bitmap of supported pins, a is the register index
> + * and f is pin configuration capabilities supported.
> + */
> +#define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)
> 	(FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
> +
> FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
> +						 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
> +
> +/*
> + * n indicates number of pins in the port, a is the register index
> + * and f is pin configuration capabilities supported.
> + */
> +#define RZG2L_GPIO_PORT_PACK(n, a, f)
> 	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
>=20
>  /*
>   * BIT(63) indicates dedicated pin, p is the register index while @@ -
> 200,6 +208,18 @@ struct rzg2l_dedicated_configs {
>  	u64 config;
>  };
>=20
> +/**
> + * struct rzg2l_variable_pin_cfg - pin data cfg
> + * @cfg: port pin configuration
> + * @port: port number
> + * @pin: port pin
> + */
> +struct rzg2l_variable_pin_cfg {
> +	u32 cfg:20;
> +	u8 port:5;

 u32 ??
> +	u8 pin:5;

 u32 ??

Cheers,
Biju


