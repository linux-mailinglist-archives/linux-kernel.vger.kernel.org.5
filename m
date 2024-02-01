Return-Path: <linux-kernel+bounces-47695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F4845170
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFCAB22A82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217F157E91;
	Thu,  1 Feb 2024 06:36:35 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7B273FE;
	Thu,  1 Feb 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769394; cv=fail; b=H9+ImRWrJ1AqZ++FJ/BpEYQ4fPK+rnnkWsLLu7kHvNwN0zSposOjlAWVn3eU1A2HF79I0HGS+xegJJSFGVjQXAZ85yfZQ0OkSgtBPJBj7i4R8MEpIkoeRlonXGUs7dh05Zwv71PH1+nTocMdRIZV6ppL9d4j72qCNJNDQ2vGUMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769394; c=relaxed/simple;
	bh=mgqucM4IFSLnmpRzbuQGbsDmsBOrHAf0bv8evjvKvNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7XrFl9NGzN9YIYACag9nKnLwJI02dv0XbOpSyh2qsz7UOoVKNjF/k3kuf0xwREwPkfD4YH5YIbYiLjt/1YvIQtGwN14glloyRWXGt5Q0CqYijiVA5dzC0yyvcmVdEC+6RwRMbkJwyV8WpY2YyWjpSFvqxkDxt3fun8CN8TBkEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYfldbH0w2MRUgSOysyj4MhwFEFKYlD41q7b/rV/qhZhj8NF6mcQXmsaWvWaJU9LIs/ZIoOdu5fIwY6jsYYqQ8EgQIXjCR5RlJu0m5iuCEDhx4PdbUO5T+AdBT+9WiXLbebqU9T3Z951kLXfMadzaUmk8E24n9tT2/d+STex0uH18UwUoyfCXT+0Cr/vvP/PUNhbpiLr7DVhKM9mdrwn/BygEjkI/tnNx4mtuufItjG61vFvielPOYgM08nxyHs9WSyEpf/U9HnuaA9eu2jKqq59VTK3Nqx5PnPUtI72YeB6jd3nDMZ3g1Bt6q7LGTl9PXsFH7yjXqr1ebjBKTHGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccv51G/g3IFSwWo6jUoOz/xSKSc2p04peMx77j+Tc6s=;
 b=nOUN/CNZaBoTKZ3UbuuHCnbVXWX3WWnG7rVOIj5eUNsQvy7GL8SLT+KtzGrZ1/F9lzWY62dIzfVUdemDZK96UwtmXWHi27cFvUAdy47zsM1M303uAPpe2TqJja5ns6GC21Q2o0O25RzVH6DxcEIovGGvdb7HepQ+RhEZbdec4QcIChJOaYJ8EX5twA0XkvDeTtfpF+PcBZj6Gt6JXKNZFEkoxOVby5rVW/B82tu4W/GlESdauNVizfIP2Y5o6PpQ7j34jlyvbITeIJH0/YQDBfrr0K5i2/OYFHfBZ4V5V3p70K8uK0z9o5pTBF9TyillB1mMkIDmS0AYx5alTEsXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::14) by BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Thu, 1 Feb
 2024 03:02:00 +0000
Received: from BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn
 ([fe80::19a4:3d94:f6a9:97e1]) by
 BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn ([fe80::19a4:3d94:f6a9:97e1%5])
 with mapi id 15.20.7228.029; Thu, 1 Feb 2024 03:01:59 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S . Miller" <davem@davemloft.net>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Topic: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Index: AQHaSFqmtg6Zzl/qkUuu0ddSCEXpi7Drn0sAgAgJJNA=
Date: Thu, 1 Feb 2024 03:01:59 +0000
Message-ID:
 <BJSPR01MB0659C3FE1262DF8CC7F7DA468A43A@BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
 <20240116090135.75737-5-jiajie.ho@starfivetech.com>
 <ZbNCKrTLXmPcsrSH@gondor.apana.org.au>
In-Reply-To: <ZbNCKrTLXmPcsrSH@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0659:EE_|BJSPR01MB0786:EE_
x-ms-office365-filtering-correlation-id: b835bf45-142c-4720-3f12-08dc22d2288e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0x2zXVRtxdxeTtJGNH+CQFh0FOheHlyAWX44VXoMuqgTObvRWw/o1wJFL+sQwPXnqIy1CUYGQyNUhUwlsNOjznT60kCrqsGzeViediDZx+aLB+shDUiL32qd0RYu10p67bInCrLnIIoaKNGS1inhA+wO5lHafd0ez6QsE6cOxlB0AFlPjm9AxknZO3//Omux/hsOiSaXFvf3u0EqsqPCs3RoRBBAEtiRefW6G3ThLq0gIQyMV2MMQgmKCspXg8A5RVP/bfgnv3qQ3Ied95IisgvliRavKnwt6Q0YCwfXfv/QDonA4RLLa8X8L1J95nNTEC97bC7/ZzSBvOxNJdQj7JeaADvv4moh9pSn37AYZa+pxn3W7eOW226CKWC9jFDkjBUG3wGv3olskqIISbQINNYCh8iRE3+zQCvpD2HNHBBNiXjyttK367QyYraMjaILqVSwv9kuaB12E0Ncgh+UWW+HGDAIw/zmq0EdrRZb6smJYZku8jUN0qcU536mvmH6PtX6ud/pGCz7JRVdwHMcdtIqAOYvwjmYvB93c/mkYUDvrIy7yCgEu3rFM7oHVS85
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(55016003)(83380400001)(41320700001)(38070700009)(40160700002)(40180700001)(33656002)(86362001)(41300700001)(8936002)(38100700002)(26005)(9686003)(5660300002)(71200400001)(66446008)(7696005)(122000001)(6916009)(54906003)(4326008)(64756008)(76116006)(66946007)(66556008)(2906002)(8676002)(66476007)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IFZnV6saD2SwxTxrhk6g6+fO3GrQlNURycjFgn9y2XVO5nHJGoTxMKwnaYBr?=
 =?us-ascii?Q?5XFJaoFdRk3bFBD9iVFiPiFXbiF6wwIvDtfysYVQjmo5ygMpP1sqdaJ+JY9d?=
 =?us-ascii?Q?rQQQT28MFvSzweC6DoNNsQu2AbA6AmkxLBv41wnHtDGndfl7ltlyu0/MOdP+?=
 =?us-ascii?Q?M8+t2m6rz5eymOQWd2idu9VRKSo9Y3SjKIryQmjksl9oK3820NhzChOsaKjN?=
 =?us-ascii?Q?lEVJ4lPnflENGszDFaCz/ELivLtUIvpx4aEnA/Gb+IgjTNgS16IByVoXm3Sm?=
 =?us-ascii?Q?93bQfL7NQTeQInm9pfb2i0Veykbbinb+HF4eEBr8tACLyn0QfOoCEYuvNTwo?=
 =?us-ascii?Q?8Wo6eJlLZuGHj8qXuPAbmmHZDDKnzb/+M6qKfqmLwvMMjdUsdT5HZLdWXz40?=
 =?us-ascii?Q?G7dStdlSAp6OpVFyDkpVrgL2gt4WV20Pwg5Rg984Sa9JgbTvQvprhKhwxEAq?=
 =?us-ascii?Q?XTSDIIaI2o5xUcL16DaaRd4owPt6BB7xpMeP1GIBAwLof04OgL/R4v/O2JWr?=
 =?us-ascii?Q?vYbyR2k0IoglefeLOTJbOxnlVMIeTg9P926em8OKFPussowuquf+krK/W77s?=
 =?us-ascii?Q?oBrdqK7+vtp0NpMr9wv+2AbNh1k6V1HlMP86HQg/mjx6Ldx2hdWpn1m6ks1u?=
 =?us-ascii?Q?i5Zgf1M9VLfkMH2C70NR2MhEzFJvt6aQhJ9JJkJK1hiq+eMu6a8XAxBNg7Kj?=
 =?us-ascii?Q?ggF+2qvcr+JmCMfnitLYC58UU9sSPCeznPcsr6rnLhw2d2yPd20TnjKgcLTM?=
 =?us-ascii?Q?+NTLH9WNuJ98GSybYin7ygrwLpNjH0MisBDKJbcVd7faMpKvBZuXVz2aGxSb?=
 =?us-ascii?Q?vuzSgg77f7HpNT4+cbPEaHTeGhMc4VSshfSVjF7eNnNzgK6RfDkKPyn2IeOK?=
 =?us-ascii?Q?TuZKpC2Bwk6Yaantk6DROHxVFAIxjomfRITKs30DFTVewaFyKBckyWMXhPb8?=
 =?us-ascii?Q?Ft+FOeasjBSB0dSLWhpG4nFbQuETDaII6kbXxE6sdkQNE+9a6Uiny5rLr0Hb?=
 =?us-ascii?Q?W03wlYIgdPUAgBZlo+3wC3mw+Ve6gEprnqCJ6U7CQf1YZrbOus2e4cMdTY4L?=
 =?us-ascii?Q?GBAr62MG/LyMxTe8F0i5FTfdieK6yLeDmzDyRJCt6Vvoj5tHOWuE/WUE3Um6?=
 =?us-ascii?Q?/7LmEtL8t0FypPQHauI8GBFT/hod+odvymG594c9yVEZUd2LSVNIXrI9WtGr?=
 =?us-ascii?Q?nuoX/KJXY50RVtsoMReietQJVetyQL6WYuD3If0dbN7GguQ7SaXF2+sdrErD?=
 =?us-ascii?Q?2IL3YTrq7lFZm2qzBnB1xH8nxzhEClO79P4whgnnHlRHNFOsFZnhMGvLaSyC?=
 =?us-ascii?Q?iXFyh1Z18pddPFa8pWQfzYmzz9jd888DsTMP988zj5LpxdJhtek2qBZrvl69?=
 =?us-ascii?Q?mOdit9hLcpg7s6SR+17JlUHoaDwmBE5uqW26MusHtBKaUlk6eUyTcXUitksB?=
 =?us-ascii?Q?Pz+BCIFcZmh2l1Pvf7Gttz6U4mOq7httSO//Md3jU5ElxB7Y1TSHOdS0jMhO?=
 =?us-ascii?Q?b+qYlNAc4GSiX4XNrdGp0G1MLQnKG4VkkdALkR462YalWzxIyjGizq1pkPet?=
 =?us-ascii?Q?mH3N7gXiOqAIWgVQsSFtiiZnQJLQ8w1BTkbc+BgAZTRdMflf/mn3vDz0s9wz?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b835bf45-142c-4720-3f12-08dc22d2288e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 03:01:59.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6blqKGDP8VJDoQMEIjOA0SrE3nQjB70wu33yZi8Vf29ts4CP41Fod+9M365L1OyhOCRUYQ+rfzFI7HZq64Xt/z0chi+tQ3gmHvoaU1W89d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0786

> On Tue, Jan 16, 2024 at 05:01:34PM +0800, Jia Jie Ho wrote:
> > Add driver support for SM3 hash/HMAC for JH8100 SoC. JH8100 contains a
> > separate SM algo engine and new dedicated dma that supports 64-bit
> > address access.
> >
> > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > ---
> >  drivers/crypto/starfive/Kconfig       |  25 +-
> >  drivers/crypto/starfive/Makefile      |   3 +
> >  drivers/crypto/starfive/jh7110-cryp.c |  48 ++-
> > drivers/crypto/starfive/jh7110-cryp.h |  59 +++
> > drivers/crypto/starfive/jh7110-hash.c |  20 +-
> > drivers/crypto/starfive/jh8100-sm3.c  | 532
> ++++++++++++++++++++++++++
> >  6 files changed, 677 insertions(+), 10 deletions(-)  create mode
> > 100644 drivers/crypto/starfive/jh8100-sm3.c
> >
> > diff --git a/drivers/crypto/starfive/Kconfig
> > b/drivers/crypto/starfive/Kconfig index 0fe389e9f932..e6bf02d0ed1f
> > 100644
> > --- a/drivers/crypto/starfive/Kconfig
> > +++ b/drivers/crypto/starfive/Kconfig
> > @@ -5,7 +5,7 @@
> >  config CRYPTO_DEV_JH7110
> >  	tristate "StarFive JH7110 cryptographic engine driver"
> >  	depends on (SOC_STARFIVE && AMBA_PL08X) || COMPILE_TEST
> > -	depends on HAS_DMA
> > +	depends on HAS_DMA && !CRYPTO_DEV_JH8100
> >  	select CRYPTO_ENGINE
> >  	select CRYPTO_HMAC
> >  	select CRYPTO_SHA256
> > @@ -24,3 +24,26 @@ config CRYPTO_DEV_JH7110
> >  	  skciphers, AEAD and hash functions.
> >
> >  	  If you choose 'M' here, this module will be called jh7110-crypto.
> > +
> > +config CRYPTO_DEV_JH8100
> > +	tristate "StarFive JH8100 cryptographic engine drivers"
> > +	depends on (SOC_STARFIVE && DW_AXI_DMAC) || COMPILE_TEST
> > +	depends on HAS_DMA
> > +	select CRYPTO_ENGINE
> > +	select CRYPTO_HMAC
> > +	select CRYPTO_SHA256
> > +	select CRYPTO_SHA512
> > +	select CRYPTO_SM3_GENERIC
> > +	select CRYPTO_RSA
> > +	select CRYPTO_AES
> > +	select CRYPTO_CCM
> > +	select CRYPTO_GCM
> > +	select CRYPTO_CBC
> > +	select CRYPTO_ECB
> > +	select CRYPTO_CTR
> > +	help
> > +	  Support for StarFive JH8100 crypto hardware acceleration engine.
> > +	  This module provides additional support for SM2 signature
> verification,
> > +	  SM3 hash/hmac functions and SM4 skcipher.
> > +
> > +	  If you choose 'M' here, this module will be called jh8100-crypto.
> > diff --git a/drivers/crypto/starfive/Makefile
> > b/drivers/crypto/starfive/Makefile
> > index 8c137afe58ad..67717fca3f5d 100644
> > --- a/drivers/crypto/starfive/Makefile
> > +++ b/drivers/crypto/starfive/Makefile
> > @@ -2,3 +2,6 @@
> >
> >  obj-$(CONFIG_CRYPTO_DEV_JH7110) +=3D jh7110-crypto.o
> > jh7110-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o
> > jh7110-aes.o
> > +
> > +obj-$(CONFIG_CRYPTO_DEV_JH8100) +=3D jh8100-crypto.o jh8100-crypto-
> objs
> > +:=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.=
o
> > diff --git a/drivers/crypto/starfive/jh7110-cryp.c
> > b/drivers/crypto/starfive/jh7110-cryp.c
> > index fe33e87f25ab..fb7c19705fbf 100644
> > --- a/drivers/crypto/starfive/jh7110-cryp.c
> > +++ b/drivers/crypto/starfive/jh7110-cryp.c
> > @@ -106,6 +106,26 @@ static irqreturn_t starfive_cryp_irq(int irq, void
> *priv)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +#ifdef CONFIG_CRYPTO_DEV_JH8100
> > +static irqreturn_t starfive_cryp_irq1(int irq, void *priv) {
> > +	u32 status;
> > +	u32 mask;
> > +	struct starfive_cryp_dev *cryp =3D (struct starfive_cryp_dev *)priv;
> > +
> > +	mask =3D readl(cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
> > +	status =3D readl(cryp->base + STARFIVE_SM_IE_FLAG_OFFSET);
> > +
> > +	if (status & STARFIVE_SM_IE_FLAG_SM3_DONE) {
> > +		mask |=3D STARFIVE_SM_IE_MASK_SM3_DONE;
> > +		writel(mask, cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
> > +		tasklet_schedule(&cryp->sm3_done);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +#endif
> > +
> >  static int starfive_cryp_probe(struct platform_device *pdev)  {
> >  	struct starfive_cryp_dev *cryp;
> > @@ -156,6 +176,16 @@ static int starfive_cryp_probe(struct
> platform_device *pdev)
> >  		return dev_err_probe(&pdev->dev, ret,
> >  				     "Failed to register interrupt handler\n");
> >
> > +#ifdef CONFIG_CRYPTO_DEV_JH8100
> > +	tasklet_init(&cryp->sm3_done, starfive_sm3_done_task, (unsigned
> > +long)cryp);
> > +
> > +	irq =3D platform_get_irq(pdev, 1);
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, irq, starfive_cryp_irq1, 0,
> > +			       pdev->name, (void *)cryp);
> > +#endif
> >  	clk_prepare_enable(cryp->hclk);
> >  	clk_prepare_enable(cryp->ahb);
> >  	reset_control_deassert(cryp->rst);
> > @@ -191,8 +221,17 @@ static int starfive_cryp_probe(struct
> platform_device *pdev)
> >  	if (ret)
> >  		goto err_algs_rsa;
> >
> > +#ifdef CONFIG_CRYPTO_DEV_JH8100
> > +	ret =3D starfive_sm3_register_algs();
> > +	if (ret)
> > +		goto err_algs_sm3;
> > +#endif
> >  	return 0;
> >
> > +#ifdef CONFIG_CRYPTO_DEV_JH8100
> > +err_algs_sm3:
> > +	starfive_rsa_unregister_algs();
> > +#endif
> >  err_algs_rsa:
> >  	starfive_hash_unregister_algs();
> >  err_algs_hash:
> > @@ -213,7 +252,9 @@ static int starfive_cryp_probe(struct
> platform_device *pdev)
> >  	reset_control_assert(cryp->rst);
> >
> >  	tasklet_kill(&cryp->hash_done);
> > -
> > +#ifdef CONFIG_CRYPTO_DEV_JH8100
> > +	tasklet_kill(&cryp->sm3_done);
> > +#endif
>=20
> Please use if instead if ifdef where possible:
>=20
> 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_JH8100))
> 		tasklet_kill(&cryp->sm3_done);
>=20

Hi Herbert,
I am using ifdef so unused codes wouldn't be compiled into the driver for u=
nsupported variant.
Is the compiled driver size a concern for such cases?=20

Thanks for review this.=20

Regards,
Jia Jie

