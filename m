Return-Path: <linux-kernel+bounces-47697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E886845174
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0EF283BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB981586FB;
	Thu,  1 Feb 2024 06:36:47 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E443273FE;
	Thu,  1 Feb 2024 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769406; cv=fail; b=BQr47oYhvb+ejQq8k5fRRDu3RrQbdr6PXlCR2JwWXNR7lpeKRTqS43zVziFjV+tmyBQAOTEPZ0whoHA/zJb4IvyAI0sDlUm/sLtGXTO1WD+B/5JgaGq3Cz9sH8ViXe5a8lSBZNXzOv0oebym/VT2u7XjE+ZTBkCOioQYkdSY70U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769406; c=relaxed/simple;
	bh=+HLEZnoBnBB46xxWurx92jfG5cQO4as0tkeiwpvupeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N1soD3vHZwUc1TftrecoN1L0nDcBf25DDg1yOOxLfGM8m7iIbqcjNvbpI2VdT1eaI/4Uk4LOJsmUck3ZCCDcvfOkcc6RmnbqlInClJybWLNXoJrBHT9mtP6InC8pLS8Ub2dUvaH5+5cpr+QXcu80ZPqGxl726oRPRJGo/yRvKp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9fTx1B0J3rYy6Le+o/7tYLTA8ayzIgpIfJ4ry25anNK6SeJwm1RZUOjCjfYXT7FM0lAVBNy1RmqTUwWBcsxSUV8xwNcWgf4/4nBodQFzwsMQ0wvB8vgPqVuQ4XlfBGXCVqReZrFOC0IQlxYHt5h47zsUR6cD5bYYSqXCNjUKqqzLy1EXn3NnJxKHNIc5cD57btMLEetO23Rh7u/qoRjrqKByD8UmwlVWdaSpCOjIILiMAgB7ZtThJ++1FpBjlvrVyH5ctBi4OM17ald8EyV9kZXbDY+vITyIHf1SCnRtJ8ygFvDTFL3RtvKQqrmlTDukLV/Ukj6bhp8Fp9K7/f6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnVnNgoEHSuY991Ujso11K/l4ZSAgbYz69xFb+G8jIA=;
 b=g81uuI+hkfQmEvKGRy0RVf+fcn3IPCHT3iQmZW1FWkTkat5BjHV+VdZHL+wPpt7oCmH0GdMl5rPYa6/QGxRh1BpoxNfUpRgnWS4F6wPP7/jn59C2ZJvgJOoHRFbSnGtj4pGUc4O2d3DEOGgDxFar8Fqu6HHjhydOl0KEoz7WWXxq1NqQyaRIejGOdNXuiW2pUwsfKMTl7vvGEk1HchbipQ7Be4AIrx0/8bO0Mth0QiUX5BK4eCd9DZmSWfbQ41S8BjADaHIWMVZSXSerDm4lDbNlo13+Wi7XohuzM6sfGYJXAt0HQVv/DW9yW1dXjhRTpe5RwTQvgRiJUkysqeGAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::14) by BJSPR01MB0786.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Thu, 1 Feb
 2024 03:02:06 +0000
Received: from BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn
 ([fe80::19a4:3d94:f6a9:97e1]) by
 BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn ([fe80::19a4:3d94:f6a9:97e1%5])
 with mapi id 15.20.7228.029; Thu, 1 Feb 2024 03:02:06 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: 'Herbert Xu' <herbert@gondor.apana.org.au>
CC: "'David S . Miller'" <davem@davemloft.net>, 'Rob Herring'
	<robh+dt@kernel.org>, 'Krzysztof Kozlowski'
	<krzysztof.kozlowski+dt@linaro.org>, 'Conor Dooley' <conor+dt@kernel.org>,
	"'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
	"'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Topic: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Index: AQHaSFqmtg6Zzl/qkUuu0ddSCEXpi7Drn0sAgAlEKdA=
Date: Thu, 1 Feb 2024 03:02:06 +0000
Message-ID:
 <BJSPR01MB065907F9CE1376F198086AD28A43A@BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn>
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
x-ms-office365-filtering-correlation-id: 6205cf6a-5795-48ac-d667-08dc22d22c47
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GXNZ1yYQVSyx4SBEny9v2ue7hE0lzCVixIeFfZ4SwTHuh3Qd/SEk5JR9k66xf1Q7a8oj5+8IVmdLgkIp3/CehZqkrLedoTJkHBwSy2n+uKeYRyt4h92JnAc9Z0CVJYB4J6weUHxTZxX0WTThW/eLjxfCUatO0NM4Vg9fzuLHBYeUb22TLrs3OWT1HNOFOm40J7DP6cF+guPW/8od1DutEUPnMDTn/telkAKuZVnDpDngoIAEropACS4LVjAXku3icI8kW/hn3xN9ugJGKtFz2ucb/ZHqZJIqtBMnLcesUbuV8vxMSBcJWnga+4Q2j/daqwQZv3FRmoepkKV7YBZ49o05fSxOfh6tXDgH0P6dNF2i4n5NSiaULwaY60CkCtAOrhTMnLKATWN3Gbol4eUKQ++uAgGhaEh9eBYHs/ZTmp0pvLDgRs6f6jnQAHNEB+Xn0f+lkOnUxGflSM3nY2E4IEHR0QJs7jQwUBn3g/TuVzh+Q6xrh6FirgRw1S6xIgfqVacyT9LTjN1gBjc9NO7m14a22PvnFii4Y5nLA2bnduSvbzYiDftFX54NcpVlmuaE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(55016003)(83380400001)(41320700001)(38070700009)(40160700002)(40180700001)(33656002)(86362001)(41300700001)(8936002)(38100700002)(26005)(9686003)(5660300002)(71200400001)(66446008)(7696005)(122000001)(6916009)(54906003)(4326008)(64756008)(76116006)(66946007)(66556008)(2906002)(8676002)(66476007)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RUsIyHQ9CvN8HvevpQiKB6C5bXZZFBx5nrPRObqCMnNkIlzMpDDyYmnPQCJd?=
 =?us-ascii?Q?qTAAWPouvRvw9csjf89mKs6nHAQmJflQzIDirHxHTuOnVAvNmBByqneezL04?=
 =?us-ascii?Q?udCXqCDIt67dBmf3+YM+JRq49cwjPLFhNdV4GH2pNiFPAIMsi9JEo6Du6Vlu?=
 =?us-ascii?Q?gWTlBOqzRCWIHD12c481F7+ZSuKa4xFhVLPsqU0RZ1M+N/7J8CBK0XRHiczZ?=
 =?us-ascii?Q?NpdDRZn/PYNtRcZ6v8FsXLdMpdizEz24kzrWTcC2ZDF+luHM7PWS4Lofn3Mc?=
 =?us-ascii?Q?/jfLvgjga5btvXLkwqu+MB5eBxkpo/vN6+WDdAHEKFPefds5JRBY1jtge2IC?=
 =?us-ascii?Q?u6ip+d4rgW2ghgQQ4iR0tJVAIdqLkbwD3liOWz/9a80148WeRj7Gwlke9zAT?=
 =?us-ascii?Q?4wp9NUsNUApMq680gulW74qRORG8TbxPialDAefid6E5i+IFkdyWKadrR8wY?=
 =?us-ascii?Q?Z9xlQ7RIYjX//vunba+tdAg7AcivjrLOgmdEYGveeJyr/2vND0rvgV1fGqeK?=
 =?us-ascii?Q?GNTyZg3jPkjoeUjW/gzGfciWxNgmdB8yySMRjoSMCAaBu0n/JXJhUkXLpzoL?=
 =?us-ascii?Q?7Sg/BwOLXQZ+rjpJxOael9jhb7U8pwtEzc8POQ6yLPLzaaQyPo6wcc+tyL99?=
 =?us-ascii?Q?s5R6FTXAqiXV2D+h5DGz+ZYc+v4SonMH59YjMl4dfEEt76BItjNqDXL1Ou5j?=
 =?us-ascii?Q?nfh/ox+VSu0xBBmghpv9e4BidzRq6XKZNBpoz9jPIdpt3BMnfvXZSIejEdL3?=
 =?us-ascii?Q?DSZchzKyKle8IvGM5zH/w9DAMH9Kd2yRSVWWxdlyoAmhkSF/i4IFBS8Nj2la?=
 =?us-ascii?Q?XnYeD6KacdbFckJ1kGL2ykXI93iVK4DRyunoif6DoEm2rZCobO+7Vy6jGgmq?=
 =?us-ascii?Q?hUlUzXDGsS7Vh4lzyScEvNbga8hcrNi8m+H9wQ6Y1vF6c/It4DJt7LGCWsbK?=
 =?us-ascii?Q?bVBBtRdhz1YmC6VTm3KFv6X9vzuE3JgxLMmzvpJn+rP1WdJqsjGV3N5IduDM?=
 =?us-ascii?Q?sbSVfyQhDeI5QT+GyWSFKwN0Q/a4LI40LqrOyy1rg9W5oggiuCGPzc1Qe4Bx?=
 =?us-ascii?Q?jpKHKScpdxnYGEpsTDCDDOs5w339rzIG6aBxDj8Ye7M6xmcColCLRGMmPcuH?=
 =?us-ascii?Q?EfJVLJA9q6X/cnR/W04qpRrjH59+EPUOooYkwNfFOq0Jx1wdGlaGwcrrRPlC?=
 =?us-ascii?Q?XwDBa081XaRGIK8QQTkOm/82l69SLrX1dJouz6087m/L5fv6Rgqgc5MDiuvX?=
 =?us-ascii?Q?ELJMqGxnG+C6ZvymrDOb0Dyu60FhQHT/dvWZSjJTfPyhfS8ayHR+VIqeqrKV?=
 =?us-ascii?Q?v5T8UNueKKuKZRw+hUduTg9+7VIt/bf4sekR3qK44BECvTLd59dAELt7GnGc?=
 =?us-ascii?Q?6XzYgwbOd+u4RIwvvrQHJxwxklOFXrc/nn2piRCgsONc15gdZCISIyxfMNid?=
 =?us-ascii?Q?L49ZHcarROQkENMykgk3FZvvG0S4cPnJC9CkxnEDHkUXKCF4U9b+0GyTiz82?=
 =?us-ascii?Q?ZCCcYolI9tyE+B1TGtbtdQSUwiR4tySLnpw4sdlqziaKhuTulwF573d8eL9M?=
 =?us-ascii?Q?jJaiss6r9XvvJnRuZyJgWsaTFpHhlwrvKH2OKfvFjByFeFF1Fiy4P0IqOkds?=
 =?us-ascii?Q?Zg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6205cf6a-5795-48ac-d667-08dc22d22c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 03:02:06.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRDZyyo6nDys3R2epIjiiEu1BoSao3vrbaNVDHqlYSr/S4oFNDkqB0u7YHdr/09DHQKzYR+DhLxjhnLWbxUhxhQxlRWOnHEC5jsSueytgiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0786

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
Thanks for reviewing this.
I am using ifdef so unused codes would not be compiled into the drivers for=
 unsupported device.=20
Is the final driver size a concern in this case?

Best regards,
Jia Jie

