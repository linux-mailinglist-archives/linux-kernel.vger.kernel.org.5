Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E682771BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHGH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjHGH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:58:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CB1DD;
        Mon,  7 Aug 2023 00:58:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3777wDxA085845;
        Mon, 7 Aug 2023 02:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691395093;
        bh=Ot+EwPTtK0XG+hFiXM+l4z1CfL6TspQfgqrl0+ZOes8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=l7e1pfu3YOAGx1gkCKVaLiSbrXlqk8iskKDTnAFoM8DLMMBWZ2oKCnisxmHdGy46o
         jxIYi1mt59ylqNX4PVzUrWtv/d3GM1IuJ6ukQjqPtvnqSGtfvUt9SL6m0P8OvrcOfY
         LRnWH+RTOeqjCoy8fZNa+QeujVsAu3VFpuB7l2no=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3777wDDI098051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 02:58:13 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 02:58:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 02:58:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3777wCvc121911;
        Mon, 7 Aug 2023 02:58:13 -0500
Date:   Mon, 7 Aug 2023 13:28:17 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>
Subject: Re: [PATCH v8 04/16] media: cadence: Add support for TI SoCs
Message-ID: <nuvsezmkvihi4vxcfx6ao2l6nxtwb7m5edaogjv7e5xsjryass@s3gpozvacw7s>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-4-fb7d3661c2c9@ti.com>
 <000f45c5-d7dd-237e-1e1b-72056acd4af1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ijfxspukfjubg5h"
Content-Disposition: inline
In-Reply-To: <000f45c5-d7dd-237e-1e1b-72056acd4af1@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2ijfxspukfjubg5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for the review.

On Aug 05, 2023 at 23:06:43 +0200, Krzysztof Kozlowski wrote:
> On 31/07/2023 10:29, Jai Luthra wrote:
> > Multiple TI SoCs (J721E, AM62) use this CSI2RX receiver, integrated with
> > an external DPHY and a pixel-grabber IP that unwraps the pixel data and
> > send it to memory via DMA.
> >=20
> > Add a separate compatible for the TI-specific version of this IP.
> >=20
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> > New in v8
> >=20
> >  drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/med=
ia/platform/cadence/cdns-csi2rx.c
> > index 0d879d71d818..b087583d636f 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -559,6 +559,7 @@ static void csi2rx_remove(struct platform_device *p=
dev)
> > =20
> >  static const struct of_device_id csi2rx_of_table[] =3D {
> >  	{ .compatible =3D "starfive,jh7110-csi2rx" },
> > +	{ .compatible =3D "ti,j721e-csi2rx" },
>=20
> Why do you need it? It's redundant - already compatible with cdns. No
> need to add empty match entries.
>=20

Understood, will drop this patch in the next revision and re-introduce=20
later whenever we add something SoC specific in the driver.

> >  	{ .compatible =3D "cdns,csi2rx" },
> >  	{ },
>=20
>=20
> Best regards,
> Krzysztof
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--2ijfxspukfjubg5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTQpBcACgkQQ96R+SSa
cUW4DxAAuOkfKD+dnrSbirnBn5H8fc4jAXTQVeThmFbBa8Mvbw7tLvuSQfffgaAe
YVAgf2QOV+RN9nO8B4kkRGg+QqjmVD06MqcbwYwlzrEKZoQxxhlPSFczodKg24aR
PDgEkGquRZhWkG1Asrw3PwzV2lbQ/JTfuoHQNdvUkJ/61H/WKJMDGjaFJmi+/GIL
Rqxdo8zLIA89Xkeja4KZKQlFCwmKvfHXeNqNCn3CTFt03mqj91DVHPIWyH6MsSqi
D5ei9DZAJIQ3yzk2/H9W3GJy33J5+KMnCUG3t67AR1O+KEUUAO/j3DGSB86i/bF7
m7fn7mjn88FB7XoNcDesxJGfNK0sATX/yNOWZROrxUxnMB+E4CC4XkncB+1tMDhG
uOLZ9JRRjvHZ3yZkxSaolZQd9PwpRwswMW/nTJ1aKfzFJWzIAaScEWDqAJ2rpm53
mjTcHFoED49PmKIjBKRZATOYNaEid8zPzPuIy4NFdr0iG87cR9d/k15hoVlE8olr
6VxPvIw2a0SdgROH1J7GF8iY4AO3ZzZcVlZyFU4qjnT8ggGoSHFvNRAdHZnYAcTe
NWqmaqAHE9FzzCJ0KwX8ZNc9MBkUSh2v0PERgaJ3/QJFDcSoUr4iAkQIRAF+ki2t
Es+LUolItJVoV6z9GExGY0l99/ocuyw/LFcbe7gE1GiHlIj3hXw=
=3zUg
-----END PGP SIGNATURE-----

--2ijfxspukfjubg5h--
