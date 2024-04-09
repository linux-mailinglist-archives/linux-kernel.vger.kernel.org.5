Return-Path: <linux-kernel+bounces-136240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F037C89D19D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6510A1F2257F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CC53E32;
	Tue,  9 Apr 2024 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="dgqVISCj"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26741C6E;
	Tue,  9 Apr 2024 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712638222; cv=fail; b=tZVYts6wPTYzo1s3q9/JPUxNy7DKO/+zdaXxxFvz/CeqIMct92He3pUDYK+KEYOe1YzU5gDJ6njUOo4MxHgwL+HTgH98pqKMwkHf3ijhM6tyQzvQV8gPEVsieTE3GgKhM/F0h51lN0Nz9O0+nKjeXRndZUW5GdwqzBXElrZldY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712638222; c=relaxed/simple;
	bh=VdRRLPaoQiaObhBB1JzkKyDr5nmRePD62sFuLaxedTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxIz1sdEm8QE9MRtbqmZTfsLZcicXtsb2pTj8fLYPwttWWxvwrsArGg7JUodXtCYtr0O5AUEENPP2JxX+b1UFRScT6rO1kJVzMH4yYt5C3CotG3bkSl0R1emOwQxWMyhAhuGnkRWYYicesQ2+4uCYZeQ0XvL1BKFn2P3fTlPhA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=dgqVISCj; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g52BOTnAChfEaSoqQYkn9/9ARqqD/j9bKBBhDAE7jhbEZGuRm2qBiukm7sneAMwil2m97pYvjx868ZBd1/nFg3riVxHErK6Lyz/8+iuFQZDIl+8R0Em2wBGkQ20+UKE/DY4KcPJiGZ+cwJpHKMNhDynv97TK2QsMjGjup8OOIFbGL6PBwxoBVUHnsgdq2rQ6YmRRK33u/HHgInw9a5YKUVJUvz7Lf06EvW82hSKUhtlBRXa8T5LwPimjLJMFwDCnz5LqZ+QBf+bc18S9b8EDzLOFcOM5utIu/TMzPzhFqFV9vTZSjxXuzr9CHLmtuMvMaWdNhG+bhxjYD6E1VNhC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpGfPq0PzJBgJd2pLkPRNwOdqxdqRybe96Qabqkdst4=;
 b=lbOkBRUnNaJXlgueKdXaawCI8WntTq2BXdw+yyAWBzt5P0BWLnkUHYNvQ0amvdYd9VmkzKT+wVxELUhS3EJm8JwDZRbVsWxIYB0cEiUOOHihY8DGnv5lJjOnmYGzFaDaLepZv4VTi+2n9bFQPQZuCVUlGUqU4atoecPO9k4p/RnTRtrmmHhJnFqkqbYyubMw7ng8NGChDIAtk3UnEfbFsueDJHoNjJyxFKas1JYLSJGMWpTn62OUi4gx2U0PuS1JjzOllOzYlLsjQW1We3UKT7YsQLqjONdU6loPFzDlVDakPy1sR76EvUfvWwSkKIn1d9cuxzz5TlSz53znxa0AGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpGfPq0PzJBgJd2pLkPRNwOdqxdqRybe96Qabqkdst4=;
 b=dgqVISCjMf0iyxO0/LHiBI+qtN60sVjqbPrKcFilFjucvq0G03xewRfNigRHfHgnkvvQ+zwtXiqEWIioYfGmgpMEUHCMj/Bt8L8RqUc/9jQLJZsTAyIpaLQ+inpeE+3RqBSuv+iJDtDxpXqqW+jmC6M3Ytqshs27ExNykRMpp1I=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PS2P216MB1316.KORP216.PROD.OUTLOOK.COM (2603:1096:301:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Tue, 9 Apr 2024 04:50:16 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05%3]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 04:50:15 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>, Nas Chung
	<nas.chung@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Fricke
	<sebastian.fricke@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Thread-Topic: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Thread-Index: AQHah3giAH17WLkhgEm3NaPxm3r//7FfYuJQ
Date: Tue, 9 Apr 2024 04:50:15 +0000
Message-ID:
 <SE1P216MB130327BE82553DA3F34BBF17ED072@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
 <20240405164112.24571-5-brnkv.i1@gmail.com>
In-Reply-To: <20240405164112.24571-5-brnkv.i1@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|PS2P216MB1316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MptLSYdz3lOkKRwfwJnQa0jUT5kAxVuwT9cmCKd6wABwON5U13TVy46YtUoFLRkTOZHMp/RwR/MoGc540epWZBTkoefp8b58v2oGh49/VY3GRwXCSdDapMbXdRi54CBBB0rCkdVhf+uNInRtdBIINcfj0jz7dlviAEPZy5aH9MffGKgTeaE5zqmG72OpPe18xS0BUw+PGWdHuBbBcw99mbsg9vZY2xLne6h2f5Ee87AbAFlxq7P6t7JT/PV8c39oq+prMXTzxsmLgGeoDcmdOMYbpKj3MECHJH2whEHlv4x4v4FGaoLLnnljTai5Zt4YXtG/DIxygo0ICL/0rAaB1kAUU9edQoa4l3gfOAe/N52pl+h0JkkhQVTWsxY6yAl8AqeDWdfPVfExP9Qp1cqJ21OlpBDV1qKcjlPo4F1nnkWnYWOtKXyAfVIM+G787QYTuDcIgohRDyZ0BQgpmjUAwTCFvzvwKVc7NW0buc7r2C6Citk+84DULwuCwfcEGHQeoK9b/wcOyHw9/u1vQGZFkx1ltFp4bAXRY1YLUJ0hMZrXKZ/aIXRSIu5PMrAhEaJTiK77dDyydf5xvNjX/YL9pe1MITobV89gVyf5bBDr6dd843hmq0iobu5CRDHQFsjhgfEXmctAuvxTzpoi9eTT71v6JrJKx2tnfUqAO/JVYJQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rdevoS10AvzJUEcMhD+02KVGAgNjJuwlxfrhqgtk+Gw900t4PKzxH5jkotOU?=
 =?us-ascii?Q?dlHvHAOsuQFGOk6lFY3G/XcllhvRjKdCJxLgIrsGbvu23VqFE0QXE0lVVAet?=
 =?us-ascii?Q?j1ewsJNtiZhmLhP4iv9Va95oXrNdgIK9ZggAEy6/fnnmP0TtgnLI7AwLl4kG?=
 =?us-ascii?Q?m/CIjFH35S27CsJ6gRc3DkfEb7FfrSXi07QHa7WwHZorYNBrDKpAeP4HQZEc?=
 =?us-ascii?Q?+flZ/+sqnTG6LNZe5qvZ17mZuM/wjUSt5NfeKZpzWWFgPGkjnwtMwPNUqdqi?=
 =?us-ascii?Q?tY97ENYraEHblwlXCBrTIic6MNBb8rz5CMR4+AMKTsaCDXA747CDIU7F+h+5?=
 =?us-ascii?Q?VtFSFPgO61jRbyUcT7v8PqD1DatkGtsfPnQTxtGqKWKmaFwpW1wLfpPYpzB3?=
 =?us-ascii?Q?/mS5fiU4ynqyM3mzTU+qsxo5GINI+kxp/IGkyZ3pHzL6kNh4S5NTp+T6lbf8?=
 =?us-ascii?Q?6bEofWXgCpKzpdS5uwSAuR3Q0FuXKdgTsSxnstljWeZD1TCNRDEyHUjg/0BF?=
 =?us-ascii?Q?QEpQRncRXvs3txgIVyOVzIQcl7PNEq0JAQHKkNAmWcmCxEL8CPib2iu3C6J6?=
 =?us-ascii?Q?Bcdhn8+hwWmACzrFVCSg7ZwIk9tAsFkLtuu31dlwHUEHxPrF3o4PKZp+X9YO?=
 =?us-ascii?Q?BK4KxgduyVnpoE+fRKgOZ82fBhJn6v28qt+yavcsCOTJkX+4YlHCBDw5mebk?=
 =?us-ascii?Q?h/TNwFeUm0cJZUzvxjOm20lLOb4oso5jlBtvnLSY1W6GLl+ArOQxtB3RxWrK?=
 =?us-ascii?Q?2gzL2J6NqQc1EhwbLg2j0iOJeEFj4ArHBQFG+6JZipv35r9Bn/wdQGJZHnCq?=
 =?us-ascii?Q?jEgrreVMX3fm64H+9W1lGXPuSSWgpgxHWxyOVNVYqetmdOBhWkZXddTCGcK+?=
 =?us-ascii?Q?7Ig5FrJwl/CxuuCfj7ylwVEfCt5P0v8fSpJYqOa+fXGFQjlFJhxj3krSxOI2?=
 =?us-ascii?Q?ql7OoislTGJpELCWdYSNBKYPVgz+reaBgbB5luqnR5mcLKXVgzYpOrP4jIov?=
 =?us-ascii?Q?ECUPPSDzXHiEX1gMWjnbHVk6PCTT+hYrfyigR0OBWm4+6s6iD7KDV25Fg0aj?=
 =?us-ascii?Q?C4U9ybVHiKuOv5k7GEBZSXZSi3KdqbuXkecRFcjLj02lofxAsdkpRqYB/Uzn?=
 =?us-ascii?Q?JUf6IyKQDPhM3B1oFdU3vAZ09RYjAty3ykxKTCTYmR2PE1zrZYLTxdEvhyQu?=
 =?us-ascii?Q?RZrWDx5aYFA8umZTY82RwDKtW4KcyQ3SIXhZLZ4l11weg+3zb7PmfSuXrB7M?=
 =?us-ascii?Q?o1Ot9pLXxzOBOZjaDFw5ZlH5pNgKhMT8GX5ypo2aB9nBgna1ofsa8QcJxtaJ?=
 =?us-ascii?Q?6rO4SSEaBfV7ukhHDzw4Zy2KnwSirImfTUUboEkYC6G4cTqNCCL6y8jO1NnX?=
 =?us-ascii?Q?f9ZXPxfXJwiRT3cBAijg+X1sItA4px6DjQ2rxs9UiFDMly3lJImSXzRGV+nG?=
 =?us-ascii?Q?f98YWGkQMQ7skzLlQ5xIS7Zxief6T6nhaoUAJi9lD7+5f34ULxEjRNMu52xm?=
 =?us-ascii?Q?fqukWUFhC2cskWj7UAVuMk4wb/3yt+RoSnNEIyZlikYU9SZl3Kdhh6ZyxVqp?=
 =?us-ascii?Q?CjtyCqEc4XykRB6IRBzXzIuixP25jizWWFZF1UDfDVnTusHcskh1Nnv2qnjx?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d537987d-6cc8-4ceb-8435-08dc58508c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 04:50:15.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BQdzZ79AKFi9q7qpFFgc05tX9xOReZehzWtMpEKMbUqOK8Box1IQuGBkQISVOcIAFuJkBagS+UskilV8aCmlnf2h42C5Xcr3YT4KjXHli8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2P216MB1316

Hey Ivan

> -----Original Message-----
> From: Ivan Bornyakov <brnkv.i1@gmail.com>
> Sent: Saturday, April 6, 2024 1:41 AM
> To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>=
;
> Philipp Zabel <p.zabel@pengutronix.de>; Sebastian Fricke
> <sebastian.fricke@collabora.com>
> Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size" DT
> prop
>=20
> Move excessive "sram-size" device-tree property to device match data.
> Also change SRAM memory allocation strategy: instead of allocation exact
> sram_size bytes, allocate all available SRAM memory up to sram_size.
> Add placeholders wave5_vpu_dec_validate_sec_axi() and
> wave5_vpu_enc_validate_sec_axi() for validation that allocated SRAM memor=
y
> is enough to decode/encode bitstream of given resolution.
>=20
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> ---
>  .../platform/chips-media/wave5/wave5-hw.c     | 62 +++++++++++++++++--
>  .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++---
>  .../platform/chips-media/wave5/wave5-vpu.c    | 11 ++--
>  3 files changed, 72 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> index cdd0a0948a94..36f2fc818013 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -843,6 +843,36 @@ int wave5_vpu_dec_register_framebuffer(struct
> vpu_instance *inst, struct frame_b
>  	return ret;
>  }
>=20
> +static u32 wave5_vpu_dec_validate_sec_axi(struct vpu_instance *inst) {
> +	struct dec_info *p_dec_info =3D &inst->codec_info->dec_info;
> +	u32 bit_size =3D 0, ip_size =3D 0, lf_size =3D 0, ret =3D 0;

The bit_size, ip_size and 1f_size is always 0? If so, why are you using the=
m ?


> +	u32 sram_size =3D inst->dev->sram_size;
> +
> +	if (!sram_size)
> +		return 0;
> +
> +	/*
> +	 * TODO: calculate bit_size, ip_size, lf_size from inst-
> >src_fmt.width
> +	 * and inst->codec_info->dec_info.initial_info.luma_bitdepth
> +	 */
> +
> +	if (p_dec_info->sec_axi_info.use_bit_enable && sram_size >=3D
> bit_size) {
> +		ret |=3D BIT(0);
> +		sram_size -=3D bit_size;
> +	}
> +
> +	if (p_dec_info->sec_axi_info.use_ip_enable && sram_size >=3D ip_size)
> {
> +		ret |=3D BIT(9);
> +		sram_size -=3D ip_size;
> +	}
> +
> +	if (p_dec_info->sec_axi_info.use_lf_row_enable && sram_size >=3D
> lf_size)
> +		ret |=3D BIT(15);
> +
> +	return ret;
> +}
> +
>  int wave5_vpu_decode(struct vpu_instance *inst, u32 *fail_res)  {
>  	u32 reg_val;
> @@ -855,9 +885,7 @@ int wave5_vpu_decode(struct vpu_instance *inst, u32
> *fail_res)
>  	vpu_write_reg(inst->dev, W5_BS_OPTION,
> get_bitstream_options(p_dec_info));
>=20
>  	/* secondary AXI */
> -	reg_val =3D p_dec_info->sec_axi_info.use_bit_enable |
> -		(p_dec_info->sec_axi_info.use_ip_enable << 9) |
> -		(p_dec_info->sec_axi_info.use_lf_row_enable << 15);
> +	reg_val =3D wave5_vpu_dec_validate_sec_axi(inst);
>  	vpu_write_reg(inst->dev, W5_USE_SEC_AXI, reg_val);
>=20
>  	/* set attributes of user buffer */
> @@ -1938,6 +1966,31 @@ int wave5_vpu_enc_register_framebuffer(struct
> device *dev, struct vpu_instance *
>  	return ret;
>  }
>=20
> +static u32 wave5_vpu_enc_validate_sec_axi(struct vpu_instance *inst) {
> +	struct enc_info *p_enc_info =3D &inst->codec_info->enc_info;
> +	u32 rdo_size =3D 0, lf_size =3D 0, ret =3D 0;

The rdo_size and 1f_size is always 0? If so, why are you using them ?

> +	u32 sram_size =3D inst->dev->sram_size;
> +
> +	if (!sram_size)
> +		return 0;
> +
> +	/*
> +	 * TODO: calculate rdo_size and lf_size from inst->src_fmt.width
> and
> +	 * inst->codec_info-
> >enc_info.open_param.wave_param.internal_bit_depth
> +	 */
> +
> +	if (p_enc_info->sec_axi_info.use_enc_rdo_enable && sram_size >=3D
> rdo_size) {
> +		ret |=3D BIT(11);
> +		sram_size -=3D rdo_size;
> +	}
> +
> +	if (p_enc_info->sec_axi_info.use_enc_lf_enable && sram_size >=3D
> lf_size)
> +		ret |=3D BIT(15);
> +
> +	return ret;
> +}
> +
>  int wave5_vpu_encode(struct vpu_instance *inst, struct enc_param *option=
,
> u32 *fail_res)  {
>  	u32 src_frame_format;
> @@ -1959,8 +2012,7 @@ int wave5_vpu_encode(struct vpu_instance *inst,
> struct enc_param *option, u32 *f
>=20
>  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_AXI_SEL,
> DEFAULT_SRC_AXI);
>  	/* secondary AXI */
> -	reg_val =3D (p_enc_info->sec_axi_info.use_enc_rdo_enable << 11) |
> -		(p_enc_info->sec_axi_info.use_enc_lf_enable << 15);
> +	reg_val =3D wave5_vpu_enc_validate_sec_axi(inst);
>  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_USE_SEC_AXI, reg_val);
>=20
>  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_REPORT_PARAM, 0); diff --
> git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> index 3809f70bc0b4..556de2f043fe 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c


The below code is not based on the current upstream code. Where did you get=
 the original code ?

> @@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> *vpu_dev, struct vpu_buf *array,  void wave5_vdi_allocate_sram(struct
> vpu_device *vpu_dev)  {
>  	struct vpu_buf *vb =3D &vpu_dev->sram_buf;
> +	dma_addr_t daddr;
> +	void *vaddr;
> +	size_t size;
>=20
> -	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> +	if (!vpu_dev->sram_pool || vb->vaddr)
>  		return;
>=20
> -	if (!vb->vaddr) {
> -		vb->size =3D vpu_dev->sram_size;
> -		vb->vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> -					       &vb->daddr);
> -		if (!vb->vaddr)
> -			vb->size =3D 0;
> +	size =3D min_t(size_t, vpu_dev->sram_size, gen_pool_avail(vpu_dev-
> >sram_pool));
> +	vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> +	if (vaddr) {
> +		vb->vaddr =3D vaddr;
> +		vb->daddr =3D daddr;
> +		vb->size =3D size;
>  	}
>=20
>  	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> 0x%p\n", @@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
> *vpu_dev)
>  	if (!vb->size || !vb->vaddr)
>  		return;
>=20
> -	if (vb->vaddr)
> -		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> -			      vb->size);
> +	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> >size);
>=20
>  	memset(vb, 0, sizeof(*vb));
>  }
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> index 1e631da58e15..9e93969ab6db 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -25,6 +25,7 @@
>  struct wave5_match_data {
>  	int flags;
>  	const char *fw_name;
> +	u32 sram_size;
>  };
>=20
>  int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int
> timeout) @@ -177,17 +178,12 @@ static int wave5_vpu_probe(struct
> platform_device *pdev)
>  		goto err_reset_assert;
>  	}
>=20
> -	ret =3D of_property_read_u32(pdev->dev.of_node, "sram-size",
> -				   &dev->sram_size);
> -	if (ret) {
> -		dev_warn(&pdev->dev, "sram-size not found\n");
> -		dev->sram_size =3D 0;
> -	}
> -
>  	dev->sram_pool =3D of_gen_pool_get(pdev->dev.of_node, "sram", 0);
>  	if (!dev->sram_pool)
>  		dev_warn(&pdev->dev, "sram node not found\n");
>=20
> +	dev->sram_size =3D match_data->sram_size;
> +
>  	dev->product_code =3D wave5_vdi_read_register(dev,
> VPU_PRODUCT_CODE_REGISTER);
>  	ret =3D wave5_vdi_init(&pdev->dev);
>  	if (ret < 0) {
> @@ -281,6 +277,7 @@ static void wave5_vpu_remove(struct platform_device
> *pdev)  static const struct wave5_match_data ti_wave521c_data =3D {
>  	.flags =3D WAVE5_IS_ENC | WAVE5_IS_DEC,
>  	.fw_name =3D "cnm/wave521c_k3_codec_fw.bin",
> +	.sram_size =3D (64 * 1024),
>  };
>=20
>  static const struct of_device_id wave5_dt_ids[] =3D {
> --
> 2.44.0


