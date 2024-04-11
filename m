Return-Path: <linux-kernel+bounces-140057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273FF8A0AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DE61F26B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E571513FD65;
	Thu, 11 Apr 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="SFaYfT7O"
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C51E86A;
	Thu, 11 Apr 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823102; cv=fail; b=C+qyrYButbc3m74XRtz3/tiFEBtsZ3sTyOyv36FSskLZEZCAaPfCRWId+czOW1kB6L4TGtpcbY7+emQL7suVg0oWt3V5HZUtNRsgbYIyH3dh6385RBIvccaNT6IPS9MvdgmuWOWcqb5Q+15y/B5l54w6kYbpVBO8cQzQsFI7/oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823102; c=relaxed/simple;
	bh=zR3vXwy+H4Uox3ua3KfiatjcIJDnqgUTAsRuxV4PCQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=elT+CZgDZDL/0WQg6eKEKw3AxA5BSo4QTUQYd0GQEWal2BvBej2ln6oQV9LSvc9upfPIu6pc20pJ5kV01n0LD2A7qRE1fzXxtz77HMhFiuyNWabad88g/94uDZXeFXD87OU2NGRFB7skKWprE+VA6LCup6u1SZmMC2eDBu6fyxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=SFaYfT7O; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoCM7UV27fiVD1txd++E4lnriIrR9OtpraTws3cmbU3H/0EYhh3eB0i2J1pGV2pC17n+Nnf6Ttijl05GpHtJDAV/rvpxfJ2UFU3JhzLioxAXSgIOCiSpB1bwVl9LCJUtBtD7/0DDbTyd2SicCUWBKK3120LvOe3iJNLZkSlJgH0aLQb3Wky7/48Ib2s9wCTm6qUtdWaVd4r9FxBKGxIZ9Y4cJ305ZOiFPgsv9Aj5q75SoWJgb0VnOAMoxCAQqWJwAS6ObJORH5Ua1opsjvNniBGHPkgkgFqpaTqTVxkUDeed7svotaBBDd4+38wVqA4trFfK31pz6obYTY5WXDuHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNNvgDXkjC3cUu+owJEc6EFaC+xVdW8hHx6j9+4ph+c=;
 b=bOYZpf6Kz+tgH/kRC7Y26p75DDWYJ2w5vljC+d78QMREuSbdoar13iyRT5UD2hKkz1nxJjrTDlEUY3K0kE96m4h6doRFuuqCAo/rZBspF/fAxsPGH4NXYef92itZ3Nm030CAAqWvVgCshuko5AI89YRUZ9r+rViYgH4mD1XsOdp0VWVifxf2S/7maGGQuxekDfsJSVGeeucWrmx/JYTNn9HansGT8pmTfdajoBwjmmj/dOTzgE69CzeO86ZxCO3OV1qkkq5kZ7Dl+Mya3SsmhDAclTAvXGfnkz1t20xxscUqfxq4/cF7dbbuzQyOkNbs/62q0YIjGL9yVtxNFCZFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNNvgDXkjC3cUu+owJEc6EFaC+xVdW8hHx6j9+4ph+c=;
 b=SFaYfT7OiHeExxB8Fn8tYjL1bXJ8ABo8JOnh5hvPtPwzSmIPEbN31pvuJbPzt3RTU/RVX7wMZ/AdD6nBjXJCbogNtxBlM3HMSjHcu7YvtlCN7WORgtH69nq88JvlNIsY8hJJrIrHbOBY0jFS8Q8RtnNfiLyOe5lP4/oefyLtUl4=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB2306.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Thu, 11 Apr 2024 08:11:37 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::4fff:e9f3:e95:3d05%3]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 08:11:37 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
CC: Nas Chung <nas.chung@chipsnmedia.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Sebastian
 Fricke <sebastian.fricke@collabora.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: RE: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Thread-Topic: RE: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size"
 DT prop
Thread-Index: AQHah3giAH17WLkhgEm3NaPxm3r//7FfYuJQgAA5ZYCAAyPFEA==
Date: Thu, 11 Apr 2024 08:11:36 +0000
Message-ID:
 <SE1P216MB1303CB49E8C7C83904EA337CED052@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
 <20240405164112.24571-5-brnkv.i1@gmail.com>
 <SE1P216MB130327BE82553DA3F34BBF17ED072@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
 <zrwlu2e2slf7g4izorqbzwahysz6a3diux6zjyfmgtkofzdpuj@cvfl4kqhzvef>
In-Reply-To: <zrwlu2e2slf7g4izorqbzwahysz6a3diux6zjyfmgtkofzdpuj@cvfl4kqhzvef>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|PU4P216MB2306:EE_
x-ms-office365-filtering-correlation-id: 64dd73ab-c133-4a3d-9691-08dc59ff0244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lnLzth0ic0sKIlXBCAVrIaKYFnDOizb052z7YwyLsIdsZx/pZAnDMKJEYth5X7LOk2y4dB4+X2lMS7keMtxfPkIgX3QwSkBPqEjrM9IeiSAI6buhlwg1gkQKGQUgGr2rSTwXtQOKEDjZHonQzJR+1gMW4/6oRsINSG/yN6LmTV1lefH1XRz3DIAKc6zSNJiX0uhIBa2b++41BB006q1XsY1qlseRKjphgEIanQ0d9n07KV9fFpIbVRoxvBKgeXwphLw3MoZMyEH5ZOrmstC2TvlbFYzQAc62F9vmGETQdHRx3HaD38WJqwNwt7/EhXtTZbXDKJLhe6v37P9O0Z0MEjg1IFMAH82BY4GYD0N4aVV4jkMS0xhbty5yc5vf6wnsX+kWDIW/vw8K4xhSrqn+bDg8gtv7WmcH35znLo+B+YMjBrFUgCnv1LWV+x0re2lK/k8ITIQ8wYlbLDTNr6e2tOA5V2RqO0i8VTlNOqc86ULQQQCdWmMVrlTFzGECJOxaFcjJq71QphSfrJHy8Yi3AWDvhMU9CrydFjXKtDnb2rXVHjmYnF6erGKI60WJE5ve9NKQACQZwdFgBuWptPReVQC5WMojbveiqhnCUBvw9Ojxc6c4gvzi1lDoGJEf08fJN8EaWrceOH/fY08Fg8t1geU/FPi6PshzvjAhnAHlX4UfJrOyast1LGqwSxBi4VDBbmHG90RXuxChv2KyrZSL2/cCaGzRibNUW5iUVLonHW8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T1hnOynlRth13UfpocrQIxOnyE7qMTB+YLhnbrUslAT2SNERJJ2IgkgFWtgv?=
 =?us-ascii?Q?5GtDozwXi7hmt3PscAcisIBTqJP9B1BeSEqEhl8B5v2Z19FY9pROzaKR7TH7?=
 =?us-ascii?Q?uEh+ETQ439l991Z7rST/mzkxaqvG/EXIfAdxP+D6zztC78NZrW7BC59Vb0Ez?=
 =?us-ascii?Q?YQipqmoeVcINvjjQbomP0PCI4uznxoAuN5ZOtaMb1rEv9+Czgia3nn6o078u?=
 =?us-ascii?Q?FahyCbnL4G9HLFAEPfR7euygGVuwYf696pxp5Mmwf6o2siPWBpIf1rsqz15O?=
 =?us-ascii?Q?121t/SaxEYLVnq4iYhkx09Qeqt+t75Xw/Ahbqhi5W3WS9hxdkq4bDNFg/xY2?=
 =?us-ascii?Q?uiTxArasU9EBntmc979XVln7NXu53n2LRXVq+2dq31WLJJ3CN3AMYuuq17J9?=
 =?us-ascii?Q?/1e5yVHO4VwrR0yda7LZHf9YnvbLVzGGACfV9wwijf5tsFaNHIIt5mP/4XDl?=
 =?us-ascii?Q?wa/0+sEvMrYGI2fSthDJ0ietEJ3m0ESWyBbrmSTpyD+DX0FC9YtlVSpdnE0+?=
 =?us-ascii?Q?htk5rurKNVcQmn5/LPeepr4MUcDBlu11grTiGFrAtFCz9A/+Y1DU5uovZT7t?=
 =?us-ascii?Q?B+4inrHV0h8H/0JrKMD9QuoF3DbqWR9uKS1SkR16Dw5djW/QSCcnFTRrjXOq?=
 =?us-ascii?Q?O5g3Ss01mBq4mlYz9fmSrIYfWsGDJqAt0Eu54Ue/h0Y3Fqb7JFD1eZNAXk1b?=
 =?us-ascii?Q?EfDX6HPRQtQnTMdQUzelZi8pfT4Xv5FmEtc6CKpqqsTTNmmhqO+7voWz92cl?=
 =?us-ascii?Q?G65PP1s/A3iNo0wkXjFAR9aj05erp6Qfhy+UTcs2xEG3EP5AYtvSL94OWa5R?=
 =?us-ascii?Q?eI9vRvsXD4u+CmKnLC0fNQe1v4UoHuyE+FopezE5CdDHWUBKKaPDhgjHIA+h?=
 =?us-ascii?Q?BwCYGou7OshauU80lnzlwq17AgJjTmFEdkn+0MN00iXjr1KhpzbG0bOZkQ3A?=
 =?us-ascii?Q?3i9QIBfOclLUaAwGOA53UPhxLnxaIH4WiHBN4zftqefAuACK0IYEqEDOSuxR?=
 =?us-ascii?Q?8x41krvNz992VgHbT4zuFaYInzhsIYcbfIK8/NeF/MUhoyLib989B7O5vTlM?=
 =?us-ascii?Q?oyONR3FkO9oRVVY9tizCaK7EwZf3k5hKd5SGByjSUNa99aGQJgEmYInklpiJ?=
 =?us-ascii?Q?CCpxNk0Fxez0aLGUqyrlsn+Ljgk4S3p3DceaZw8i6ASNHofDrL0kwHuyfZln?=
 =?us-ascii?Q?hrWbVQLzVdQ2Feh/goCQTKw0qlSePNIvYu1AbMCbbqBzwP9T8hD9L1VdSwL5?=
 =?us-ascii?Q?g0ondlpYAqglagj3qG9JAKsQ6Y4xDPW3vXqLCdq8/I5QN8m1jSXBClGMFAEC?=
 =?us-ascii?Q?RCn01+Ry9NfaxJPEuvTTKO2PgvK+qM4BHdlIiotUWFJbnxmuDwCcR9U/wXK7?=
 =?us-ascii?Q?W7Q/TI5zeI+ThiG2qrH7le+yRYcnXWak52FWBQnUd5OfDDgY6Zpn/EcjQAX8?=
 =?us-ascii?Q?dGYYWUF63XQ4GyAnxAvd2GKdZnLIWjQSw0mCp2MIIM1/3yRNlyQIyzKJeEuX?=
 =?us-ascii?Q?ihRomLttnyGjVtimpY5RwXb8bPVpjR6OjPexVYhm2toeQWVw3IZ5kKhxs07B?=
 =?us-ascii?Q?MQin3iU6LtZVkmuHNpTX2RR4XY7pXqWKT4jp9Q1kHFdUh/mbz9VwILeAFPZ5?=
 =?us-ascii?Q?1A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dd73ab-c133-4a3d-9691-08dc59ff0244
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 08:11:36.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdG1PayBCNQAUijLfwhTNsAHs3W2jkv1cGBtehLRWzf4ZZlZxkDZSuawkS58BjK5lQJ2Zx69LZglJlIwwOknmiM0gtV8i1n8VyWa8gq0Bqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2306

Hi Ivan

> -----Original Message-----
> From: Ivan Bornyakov <brnkv.i1@gmail.com>
> Sent: Tuesday, April 9, 2024 5:12 PM
> To: jackson.lee <jackson.lee@chipsnmedia.com>
> Cc: Nas Chung <nas.chung@chipsnmedia.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>; Sebastian
> Fricke <sebastian.fricke@collabora.com>; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: RE: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-
> size" DT prop
>=20
> Hi, Jackson
>=20
> On Tue, Apr 09, 2024 at 04:50:15AM +0000, jackson.lee wrote:
> > Hey Ivan
> >
> > > -----Original Message-----
> > > From: Ivan Bornyakov <brnkv.i1@gmail.com>
> > > Sent: Saturday, April 6, 2024 1:41 AM
> > > To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> > > <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
> > > <mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
> > > Sebastian Fricke <sebastian.fricke@collabora.com>
> > > Cc: Ivan Bornyakov <brnkv.i1@gmail.com>;
> > > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [PATCH v3 4/5] media: chips-media: wave5: drop "sram-size"
> > > DT prop
> > >
> > > Move excessive "sram-size" device-tree property to device match data.
> > > Also change SRAM memory allocation strategy: instead of allocation
> > > exact sram_size bytes, allocate all available SRAM memory up to
> sram_size.
> > > Add placeholders wave5_vpu_dec_validate_sec_axi() and
> > > wave5_vpu_enc_validate_sec_axi() for validation that allocated SRAM
> > > memory is enough to decode/encode bitstream of given resolution.
> > >
> > > Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> > > ---
> > >  .../platform/chips-media/wave5/wave5-hw.c     | 62 +++++++++++++++++=
--
> > >  .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++---
> > >  .../platform/chips-media/wave5/wave5-vpu.c    | 11 ++--
> > >  3 files changed, 72 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > index cdd0a0948a94..36f2fc818013 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > @@ -843,6 +843,36 @@ int wave5_vpu_dec_register_framebuffer(struct
> > > vpu_instance *inst, struct frame_b
> > >  	return ret;
> > >  }
> > >
> > > +static u32 wave5_vpu_dec_validate_sec_axi(struct vpu_instance *inst)
> {
> > > +	struct dec_info *p_dec_info =3D &inst->codec_info->dec_info;
> > > +	u32 bit_size =3D 0, ip_size =3D 0, lf_size =3D 0, ret =3D 0;
> >
> > The bit_size, ip_size and 1f_size is always 0? If so, why are you using
> them ?
> >
>=20
> Since I don't have documentation on Wave521, this is a placeholder for
> someone who have documentation to write proper SRAM size validation, henc=
e
> TODO comment.
>=20
> In the next patch "media: chips-media: wave5: support Wave515 decoder"
> I added validation of SRAM usage for Wave515, for which I do have
> documentation.
>=20
> >
> > > +	u32 sram_size =3D inst->dev->sram_size;
> > > +
> > > +	if (!sram_size)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * TODO: calculate bit_size, ip_size, lf_size from inst-
> > > >src_fmt.width
> > > +	 * and inst->codec_info->dec_info.initial_info.luma_bitdepth
> > > +	 */
> > > +
> > > +	if (p_dec_info->sec_axi_info.use_bit_enable && sram_size >=3D
> > > bit_size) {
> > > +		ret |=3D BIT(0);
> > > +		sram_size -=3D bit_size;
> > > +	}
> > > +
> > > +	if (p_dec_info->sec_axi_info.use_ip_enable && sram_size >=3D
> > > +ip_size)
> > > {
> > > +		ret |=3D BIT(9);
> > > +		sram_size -=3D ip_size;
> > > +	}
> > > +
> > > +	if (p_dec_info->sec_axi_info.use_lf_row_enable && sram_size >=3D
> > > lf_size)
> > > +		ret |=3D BIT(15);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  int wave5_vpu_decode(struct vpu_instance *inst, u32 *fail_res)  {
> > >  	u32 reg_val;
> > > @@ -855,9 +885,7 @@ int wave5_vpu_decode(struct vpu_instance *inst,
> > > u32
> > > *fail_res)
> > >  	vpu_write_reg(inst->dev, W5_BS_OPTION,
> > > get_bitstream_options(p_dec_info));
> > >
> > >  	/* secondary AXI */
> > > -	reg_val =3D p_dec_info->sec_axi_info.use_bit_enable |
> > > -		(p_dec_info->sec_axi_info.use_ip_enable << 9) |
> > > -		(p_dec_info->sec_axi_info.use_lf_row_enable << 15);
> > > +	reg_val =3D wave5_vpu_dec_validate_sec_axi(inst);
> > >  	vpu_write_reg(inst->dev, W5_USE_SEC_AXI, reg_val);
> > >
> > >  	/* set attributes of user buffer */ @@ -1938,6 +1966,31 @@ int
> > > wave5_vpu_enc_register_framebuffer(struct
> > > device *dev, struct vpu_instance *
> > >  	return ret;
> > >  }
> > >
> > > +static u32 wave5_vpu_enc_validate_sec_axi(struct vpu_instance *inst)
> {
> > > +	struct enc_info *p_enc_info =3D &inst->codec_info->enc_info;
> > > +	u32 rdo_size =3D 0, lf_size =3D 0, ret =3D 0;
> >
> > The rdo_size and 1f_size is always 0? If so, why are you using them ?
> >
>=20
> Same as above. It is a placeholder for someone else to implement these.
>=20
> > > +	u32 sram_size =3D inst->dev->sram_size;
> > > +
> > > +	if (!sram_size)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * TODO: calculate rdo_size and lf_size from inst->src_fmt.width
> > > and
> > > +	 * inst->codec_info-
> > > >enc_info.open_param.wave_param.internal_bit_depth
> > > +	 */
> > > +
> > > +	if (p_enc_info->sec_axi_info.use_enc_rdo_enable && sram_size >=3D
> > > rdo_size) {
> > > +		ret |=3D BIT(11);
> > > +		sram_size -=3D rdo_size;
> > > +	}
> > > +
> > > +	if (p_enc_info->sec_axi_info.use_enc_lf_enable && sram_size >=3D
> > > lf_size)
> > > +		ret |=3D BIT(15);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  int wave5_vpu_encode(struct vpu_instance *inst, struct enc_param
> > > *option,
> > > u32 *fail_res)  {
> > >  	u32 src_frame_format;
> > > @@ -1959,8 +2012,7 @@ int wave5_vpu_encode(struct vpu_instance
> > > *inst, struct enc_param *option, u32 *f
> > >
> > >  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_AXI_SEL,
> > > DEFAULT_SRC_AXI);
> > >  	/* secondary AXI */
> > > -	reg_val =3D (p_enc_info->sec_axi_info.use_enc_rdo_enable << 11) |
> > > -		(p_enc_info->sec_axi_info.use_enc_lf_enable << 15);
> > > +	reg_val =3D wave5_vpu_enc_validate_sec_axi(inst);
> > >  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_USE_SEC_AXI, reg_val);
> > >
> > >  	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_REPORT_PARAM, 0); diff --
> > > git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > > index 3809f70bc0b4..556de2f043fe 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >
> >
> > The below code is not based on the current upstream code. Where did you
> get the original code ?
> >
>=20
> What do you mean? This patch series is based on the latest linux-next.


I was confused, please ignore the above comment.

>=20
> > > @@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> > > *vpu_dev, struct vpu_buf *array,  void
> > > wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)  {
> > >  	struct vpu_buf *vb =3D &vpu_dev->sram_buf;
> > > +	dma_addr_t daddr;
> > > +	void *vaddr;
> > > +	size_t size;
> > >
> > > -	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> > > +	if (!vpu_dev->sram_pool || vb->vaddr)
> > >  		return;
> > >
> > > -	if (!vb->vaddr) {
> > > -		vb->size =3D vpu_dev->sram_size;
> > > -		vb->vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> > > -					       &vb->daddr);
> > > -		if (!vb->vaddr)
> > > -			vb->size =3D 0;
> > > +	size =3D min_t(size_t, vpu_dev->sram_size, gen_pool_avail(vpu_dev-
> > > >sram_pool));
> > > +	vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> > > +	if (vaddr) {
> > > +		vb->vaddr =3D vaddr;
> > > +		vb->daddr =3D daddr;
> > > +		vb->size =3D size;
> > >  	}
> > >
> > >  	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> > > 0x%p\n", @@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct
> > > vpu_device
> > > *vpu_dev)
> > >  	if (!vb->size || !vb->vaddr)
> > >  		return;
> > >
> > > -	if (vb->vaddr)
> > > -		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> > > -			      vb->size);
> > > +	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> > > >size);
> > >
> > >  	memset(vb, 0, sizeof(*vb));
> > >  }
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > index 1e631da58e15..9e93969ab6db 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > @@ -25,6 +25,7 @@
> > >  struct wave5_match_data {
> > >  	int flags;
> > >  	const char *fw_name;
> > > +	u32 sram_size;
> > >  };
> > >
> > >  int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned
> > > int
> > > timeout) @@ -177,17 +178,12 @@ static int wave5_vpu_probe(struct
> > > platform_device *pdev)
> > >  		goto err_reset_assert;
> > >  	}
> > >
> > > -	ret =3D of_property_read_u32(pdev->dev.of_node, "sram-size",
> > > -				   &dev->sram_size);
> > > -	if (ret) {
> > > -		dev_warn(&pdev->dev, "sram-size not found\n");
> > > -		dev->sram_size =3D 0;
> > > -	}
> > > -
> > >  	dev->sram_pool =3D of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> > >  	if (!dev->sram_pool)
> > >  		dev_warn(&pdev->dev, "sram node not found\n");
> > >
> > > +	dev->sram_size =3D match_data->sram_size;
> > > +
> > >  	dev->product_code =3D wave5_vdi_read_register(dev,
> > > VPU_PRODUCT_CODE_REGISTER);
> > >  	ret =3D wave5_vdi_init(&pdev->dev);
> > >  	if (ret < 0) {
> > > @@ -281,6 +277,7 @@ static void wave5_vpu_remove(struct
> > > platform_device
> > > *pdev)  static const struct wave5_match_data ti_wave521c_data =3D {
> > >  	.flags =3D WAVE5_IS_ENC | WAVE5_IS_DEC,
> > >  	.fw_name =3D "cnm/wave521c_k3_codec_fw.bin",
> > > +	.sram_size =3D (64 * 1024),
> > >  };
> > >
> > >  static const struct of_device_id wave5_dt_ids[] =3D {
> > > --
> > > 2.44.0
> >

