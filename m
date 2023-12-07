Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46B808F06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443551AbjLGRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443502AbjLGRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:44:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77162122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:44:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A48C433C7;
        Thu,  7 Dec 2023 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701971081;
        bh=kE0n2gr2CaIRus73ES8kcVH1cf0yVteSBzOYtQB63UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wx2uHuTI6SpzzO+4J24LEQXHwI8kMMjn/qOqux/fXdUtdAWG2QCL8sILWDpJv+ZRF
         KHg3m32XXp9M0JHczC1pJ5mbyuf2v+IBiI4TxCk3wJuJ8gF3M9cRUR/+1F7JeGjaIn
         sGFKQ4y5dzNIUi712KgDXAfT8xTWq/lrdNamvAiVIjOxeBxsCzjK3vwAts6s3KZll+
         lAHTujKHv4mzVF64GL9BrxMY0ixS8kqGzoqDwQphiKSb7NTU8hSLtNWWvAHjjsYKSn
         eEpZKEROovsfYnyVFHO8rc0FM5HySlfHMJ+nD6KqHaBHXSEB2auLMHiVxI+C6WhlWq
         rLdKHrenbru5g==
Date:   Thu, 7 Dec 2023 17:44:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shengnan.wang@mediatek.com, yaya.chang@mediatek.com,
        10572168@qq.com, Project_Global_Chrome_Upstream_Group@mediatek.com,
        yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        jacopo.mondi@ideasonboard.com, hverkuil-cisco@xs4all.nl,
        heiko@sntech.de, jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com,
        hdegoede@redhat.com, tomi.valkeinen@ideasonboard.com,
        gerald.loacker@wolfvision.net, andy.shevchenko@gmail.com,
        bingbu.cao@intel.com, dan.scally@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <20231207-outcome-acclaim-d179c8c07fff@spud>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
 <20231207052016.25954-2-zhi.mao@mediatek.com>
 <ZXGtqwjYruBQVaUr@kekkonen.localdomain>
 <129e3a8b-5e91-424a-8ff8-b015d5175f1a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N40z4CafL7X1rYMV"
Content-Disposition: inline
In-Reply-To: <129e3a8b-5e91-424a-8ff8-b015d5175f1a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N40z4CafL7X1rYMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 01:30:35PM +0100, Krzysztof Kozlowski wrote:
> On 07/12/2023 12:34, Sakari Ailus wrote:
> >> +	ret =3D gc08a3_parse_fwnode(dev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	gc08a3 =3D devm_kzalloc(dev, sizeof(*gc08a3), GFP_KERNEL);
> >> +	if (!gc08a3)
> >> +		return -ENOMEM;
> >> +
> >> +	gc08a3->dev =3D dev;
> >> +
> >> +	gc08a3->xclk =3D devm_clk_get(dev, NULL);
> >> +	if (IS_ERR(gc08a3->xclk))
> >> +		return dev_err_probe(dev, PTR_ERR(gc08a3->xclk),
> >> +					 "failed to get xclk\n");
> >> +
> >> +	ret =3D clk_set_rate(gc08a3->xclk, GC08A3_DEFAULT_CLK_FREQ);
> >=20
> > Please see:
> > <URL:https://hverkuil.home.xs4all.nl/spec/driver-api/camera-sensor.html=
#devicetree>.
>=20
>=20
> Oh, that's cool it was documented!
>=20
> The canonical link would be:
> https://www.kernel.org/doc/html/latest/driver-api/media/camera-sensor.htm=
l#devicetree

I believe this is that answer to the "why are these needed" that I asked
on the previous version and never got a response to. Instead, they were
just removed from the binding etc.

--N40z4CafL7X1rYMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXIEgAAKCRB4tDGHoIJi
0ouqAQDUTa6OU1g0zJUvJGN1UaS5mtsII2EiSZDKd4calhNwgAD8D7luYf3WpePJ
KUxA5v4yxt6pUlaZ/sKzTzU/x1c2/QQ=
=YQab
-----END PGP SIGNATURE-----

--N40z4CafL7X1rYMV--
