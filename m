Return-Path: <linux-kernel+bounces-28863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42C8303E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142CF1F27C17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840931CF90;
	Wed, 17 Jan 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KyRR/iu/"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E91B81B;
	Wed, 17 Jan 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488524; cv=fail; b=jKiiXgkUKiQQhnM6uvAZeJqeGWYI7K7uLI0xyiTUeEBSP0UrM++ux7jMqS6toEXI111htdxDddbnkPBVL/Wy+GB3a5McX+fWhYlZix1BbZqRbreGkG1vYYqTbWi3yHYa1ekeojPMpaIBcOlW0pyJyi2PFRgxJpk3ibFxkafUNZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488524; c=relaxed/simple;
	bh=eowWJeDpwF9StYqlrzUbPTjrUJMMus+HwR8iy8+oaKc=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=BurQFN619m6R6jZPRlwXX49iRW3mpjG4AxdHuo+J7vAKAgGxy0iyj4ewTzNke3BWCsfNs3wabIz2dENXPcOONZnleRrnSPoehbtvoz5HxWV6qTq9KbWCsn5flEFaBeMBwEtUOFraEEt9uTYRU6NJt26MyrzZxRthyeVF3ctcAqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KyRR/iu/; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUPEgIVxHGakEhmNUwrisw7e6DXve2Nyz9lBZr1STdTTME5iulTMgZXUVdIVa+WP2HDTWq2+5pd4gDDy7QKZ8aD+hSgaG24KrkDEnxLkZOnri6HFnoOHtXrU30rH5k9dWqTsxwBZXSRjyrUajLqham5sJFVREWabgFW0Wf7XHayzHCkplW0rUh85awlDJgD27hS2O36JB4PFEfmg90/kFPWKBLqFfo2wEab4wi7Ydjw9NYDZosw+MwdRXLOh23dvCvJfGF5X/q/U3VCF6qSoeJsIAVq5JFb0VZgylbZ5Uf6jtZ+mI/rXx7CyrhJvn8IKWzRBAYsTkU3yq9ulAnxoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubN8N78DQAqUufOE2rBOmD4XlLKYq6uMNv8270iIjes=;
 b=cH4364s3vY2KL/LrNi5laZ4z1nTe31DiMFptpGr6/7WsxG3lPij3O0L558OgQNpvskcJ07hTPZkqsrPrSwcKWpdV9Upg/U+nNvmcqCI2J/bbK5bpDXfb+enC/ECgdeiMrLHzz5BJRKPkHZKplmOafMJt9zBrrMulQaMlZkSMKekxKK734uxcD3GoW1P9C+A/lOsCeV7CuawOh7b/aDkqtvC5RH7MHG0LbsaToCDxVvQ2Wil+wO4JMfpwOOY+UjjaXtMAs6YYnWxNSm4AiOmhgVXbmRY7sptZ6W4g7qGNxRTtEE/Msm4yGrCEp/lnqLZ7l5Yum77+c9YZNlbzZHfpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubN8N78DQAqUufOE2rBOmD4XlLKYq6uMNv8270iIjes=;
 b=KyRR/iu/Pdfa8+8x78sUqh4/tmkmNBRptdOmGsja5GcTqmCdrJYEfgcAxVBbLj65QcPH74+3u0TkJS0tGmWsxoKDiVSgaehTPSU493pBwimN7kbMum+LFj4HhcUR0h2525kZhL7DQxIyPTOAkthejZktQTuxY5TcEy8h+nZ//Ec=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 10:48:39 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::72db:548e:8011:b12f%5]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 10:48:39 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Horia Geanta <horia.geanta@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>, Meenakshi Aggarwal
	<meenakshi.aggarwal@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Silvano Di
 Ninno <silvano.dininno@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
Thread-Topic: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
Thread-Index: AQHaSGCYr0WDHP3yKEe2VG16zWQxl7Dda8kAgABkXzA=
Date: Wed, 17 Jan 2024 10:48:39 +0000
Message-ID:
 <AM0PR04MB6004E3B9AB6DB6BE3F6BE48BE7722@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20240116094405.744466-1-gaurav.jain@nxp.com>
 <20240117043308.GA1137@sol.localdomain>
In-Reply-To: <20240117043308.GA1137@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM7PR04MB7142:EE_
x-ms-office365-filtering-correlation-id: b94f9908-8b0a-425b-a818-08dc1749dd5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G7O/Y8Do8fe8fJpKtWQstOVq7PNYv0eQBonXVNYqenDHaveJDWyHbi9mCDd91hxLqyZA/BD7Zri+iAsI2RO7Fi2wkrOBLr4N8Xi5QuWATm8N+O46JQyM9TWxv8HDA0LEu4u+PoXpZWzoEA6meDUbq6/yxTo1KiblCd595NSP1EcrJbIky5ayfP29/+ekI27xX32o9MEztxcqQtzy5KVtbtHjEz25Gg82B8KFCYGmAc6PLI7vzFFZEvqLvSWoIWZUYvSL2PLImosYcV0fn1SPVT8WVvlQGXjszcYYw44CsDAKYzEm8EsoOu1S2Jfjy0bQS2sR014e3uoQBzBGikcyAQHOVqPSQ7G1VvuO+otcV1tCtTJ6fdq12YIAW6LISy3e3x2/KxEyzVUvAnDQnm3XcYxt/zaQzGlnnZPEbomtV6amZDosXJBL+E8ab6leIbcsi8Aod4pJJS3MisYVlJHYNp9pPXAvdwuwd/UDZz5DxFCmI/U+7GpyHFJyt1hg03QVDMi8zMZ2HDYtg+jSL+kDORrRhrugkn3Tyq13/90T9A4tZFvOIDUPeTv51ew16zKWcrCjybXHV2sAfpbirjtuvapvu4xviImDNmBV7GrGOf5mPJBdqhB7VEhlvuooKy2fIQHDQwdYkikOwBbifzUcxq0Oyn/WI6APVgFPTNt0EOc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(2906002)(33656002)(86362001)(41300700001)(38100700002)(54906003)(76116006)(66556008)(66476007)(66446008)(64756008)(6916009)(66946007)(6506007)(7696005)(55236004)(316002)(9686003)(53546011)(71200400001)(478600001)(8936002)(8676002)(83380400001)(5660300002)(4326008)(52536014)(44832011)(26005)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?puhkOylePyK0lDZkb2xQuwk2FJlVpZnOmJ7v9gjNAlVoMNwsCsDkvB+zIQDp?=
 =?us-ascii?Q?raPyayqVay0RUVIPtQehvY35leWXDCbxkcBVvpAKXSknNWVssokENc2xibRQ?=
 =?us-ascii?Q?sscYOCpe+5Yfyvh8eM84V3w/7ccTstVxVokdsI2GMZTtYh9pvogT5H6ISELY?=
 =?us-ascii?Q?sajaIx5pFXEPTQMnWUlGbuv2rMQIYMn6sURN3FALvzfpfEUpxGOWH9K55YwU?=
 =?us-ascii?Q?4bVRdMLMT+4N6c4EUF+beLNFHwEwooqXQBV31fDhNmxi3dH1nhKFSi93gAnb?=
 =?us-ascii?Q?/jkQO7WbW1PDQncToD8cb6ScgDsaKf9U0Cs4XtHQ0C7EJ8nAEYvYy7YmkVfZ?=
 =?us-ascii?Q?0hgpzeO3UM0a0FuAD1DHwzKzgPYK/cykiRF4c/eLRLXnP4H46XNuyW9gvpBj?=
 =?us-ascii?Q?b5ZoXq9Pu9c8FRZg+AGy6eii1Hg3WB764CaSVDmFVhAF/wN501wpaZOL1+BC?=
 =?us-ascii?Q?TSrIchDObaIbDQFHvDjkj1SKtHgx7QBOA/L0FeIQxEA7AmxBFfb1DiwfYISS?=
 =?us-ascii?Q?sHdB4h9AeStWlCa2REiij06eCpVMqyOMPV0kmb+1+lrkvM/JUHVDO2pG4TrC?=
 =?us-ascii?Q?af/kpXGCoPuAgT1vnVcgkucR2jM1SXWRlacW+6L0WWLvcNQLSwV0hqkos1JT?=
 =?us-ascii?Q?2GJlkWMi/VRV/9vauQWNIxqPqFvw9/6sIxsXY5WyXipOvCGCQdHhUxFGe0yw?=
 =?us-ascii?Q?NStxSWi+euruU88S6eREW+M9wh7mDqURkdDU1NQHLtxve7FQy16L+zedEdUf?=
 =?us-ascii?Q?IIpoKfKAAmdhk9uv4wcWlBZ6KuechBHDoSjArDRKdJy3Hoj/b/3/pZLmxoqK?=
 =?us-ascii?Q?uwS4IbXgj2HaQQam77atcJ+zuAf1YC3btRNskG2/cGyLwRPSPgfY5W5m4l8O?=
 =?us-ascii?Q?BZjGXkC+u4UepARUyJYF7DnUgGVJ7EkV0n4EOQcNvX9YSYWVU4k4Ijpvj7Hk?=
 =?us-ascii?Q?jXhZIssqH56nyW4Wblnz+2v5CruGXlV8sh9kzMYple1cWKBXmN+QugawRyQR?=
 =?us-ascii?Q?6QWyYfDTFoXNojDAb6e/ZiEMnxyoPVfP08mg2qlExTWfl/CiBpO/pq68QGWo?=
 =?us-ascii?Q?CRFSPUoluT0Qf0dPrilAO/N+nDlGJci/rrrMwH72dY2f8bDm7lF/iIchF1WL?=
 =?us-ascii?Q?vedgdnJcFL4GajWcBnGFrRU2DgNWo+E2GLfcYsITUuJ2r8UuSZe70yh8YINj?=
 =?us-ascii?Q?LFNfvH9NKC+Wad+sdLaRRQmil+QhoxqDrEDzWQLdZLT1HLqQQM+HaA65DRMP?=
 =?us-ascii?Q?f1apqkINzvfZ0sacjHndjGCTggJrkETK3MwlOqwuG31VKkC3AuYmhShD0+HD?=
 =?us-ascii?Q?ayA43lKUgLXXgnyZvY1RExZ58Y/xMGRdmDx6SbWzgH52o5KiLK2a89QXXGAo?=
 =?us-ascii?Q?aDDnBEbKEg1GnGl7b9IHg1sHW0Shw1I6MtEmUbT5/MJNF7cztSzsjRbWiE5f?=
 =?us-ascii?Q?QlyFalQybJUnR8vFWuLqmE3Ww0BuVQztQUx7mrx/jVZPvBEJ/teWBRfgFwKm?=
 =?us-ascii?Q?9zlzxxdnM0rHIBaQpEKFh/7oN0JDjEuERdQGoxmbhn7nOZmgDeEqrfGIpXUU?=
 =?us-ascii?Q?cjzMHduC9Y8PSOHsHoz8DLTclAv+K+CHZ1PFqh7a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b94f9908-8b0a-425b-a818-08dc1749dd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 10:48:39.3737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEFUtpZoHfyB/IOLBdzGk/RtvQ0If6wkETJzj+M1V0dXidl7gJoFsRGj/quLuuCMUGdt72lPKPFKI/FjnUGGCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142



> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Wednesday, January 17, 2024 10:03 AM
> To: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Horia Geanta <horia.geanta@nxp.com>; Pankaj
> Gupta <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Meenakshi
> Aggarwal <meenakshi.aggarwal@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; Silvano Di Ninno <silvano.dininno@nxp.com>; linux=
-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx <linux=
-
> imx@nxp.com>
> Subject: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Tue, Jan 16, 2024 at 03:14:05PM +0530, Gaurav Jain wrote:
> > ahash_alg->setkey is updated to ahash_nosetkey in ahash.c so updating
> > the handling of setkey in caam driver.
> >
> > Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when
> > wrapping shash")
> > Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> > ---
> >  drivers/crypto/caam/caamalg_qi2.c | 4 ++--
> >  drivers/crypto/caam/caamhash.c    | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/crypto/caam/caamalg_qi2.c
> > b/drivers/crypto/caam/caamalg_qi2.c
> > index a148ff1f0872..93a400e286b4 100644
> > --- a/drivers/crypto/caam/caamalg_qi2.c
> > +++ b/drivers/crypto/caam/caamalg_qi2.c
> > @@ -4571,7 +4571,7 @@ static int caam_hash_cra_init(struct crypto_tfm
> > *tfm)
> >
> >       ctx->dev =3D caam_hash->dev;
> >
> > -     if (alg->setkey) {
> > +     if (crypto_hash_alg_has_setkey(halg)) {
> >               ctx->adata.key_dma =3D dma_map_single_attrs(ctx->dev, ctx=
->key,
> >                                                         ARRAY_SIZE(ctx-=
>key),
> >                                                         DMA_TO_DEVICE,
> > @@ -4611,7 +4611,7 @@ static int caam_hash_cra_init(struct crypto_tfm
> *tfm)
> >        * For keyed hash algorithms shared descriptors
> >        * will be created later in setkey() callback
> >        */
> > -     return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> > +     return crypto_hash_alg_has_setkey(halg) ? 0 :
> > + ahash_set_sh_desc(ahash);
> >  }
> >
> >  static void caam_hash_cra_exit(struct crypto_tfm *tfm) diff --git
> > a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
> > index 290c8500c247..4d50356b593c 100644
> > --- a/drivers/crypto/caam/caamhash.c
> > +++ b/drivers/crypto/caam/caamhash.c
> > @@ -1804,7 +1804,7 @@ static int caam_hash_cra_init(struct crypto_tfm
> *tfm)
> >       } else {
> >               if (priv->era >=3D 6) {
> >                       ctx->dir =3D DMA_BIDIRECTIONAL;
> > -                     ctx->key_dir =3D alg->setkey ? DMA_TO_DEVICE : DM=
A_NONE;
> > +                     ctx->key_dir =3D crypto_hash_alg_has_setkey(halg)
> > + ? DMA_TO_DEVICE : DMA_NONE;
> >               } else {
> >                       ctx->dir =3D DMA_TO_DEVICE;
> >                       ctx->key_dir =3D DMA_NONE; @@ -1862,7 +1862,7 @@
> > static int caam_hash_cra_init(struct crypto_tfm *tfm)
> >        * For keyed hash algorithms shared descriptors
> >        * will be created later in setkey() callback
> >        */
> > -     return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> > +     return crypto_hash_alg_has_setkey(halg) ? 0 :
> > + ahash_set_sh_desc(ahash);
> >  }
> >
>=20
> Thanks.  Did you also consider putting something in struct caam_hash_alg =
(the
> struct in which this driver embeds its ahash_alg structure) that indicate=
s whether
> the algorithm is an HMAC or not?  Other drivers use that solution.

Crypto/ahash.c has this API to check the setkey so I used to differentiate =
between HMAC & only hash.
Let me know if this change is not sufficient, will add the flag in caam_has=
h_alg.

Gaurav=20
>=20
> - Eric

