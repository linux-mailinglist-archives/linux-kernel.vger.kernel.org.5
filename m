Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D599B765059
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjG0Jxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjG0JxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765797;
        Thu, 27 Jul 2023 02:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75EDC61DFA;
        Thu, 27 Jul 2023 09:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3684EC433C7;
        Thu, 27 Jul 2023 09:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690451603;
        bh=EdAZ9yCp4NjWVpXzH6AhTQQee2XgoMhciT9wDsXDj3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkkEAksCAqLlikCk9JjEcjPhux5P1puAANDl8+6/+YFdpP9MyxEJZmjYWgS9TNlVR
         D/PuEZi9uV2jU/E9C4t4GZeWLZTMBKdLz3XRpkg24gGeTKUymJLOlyRVjPhhAUhd1J
         R7XfjrbP+K1pz3BowFAxrPEyZSH7yb3kNfhihY0wUPK43CKgVjQtKxfdhC+BKb4kSZ
         vauM0v1qddB3XFsxJ84JTIG98VtZ4Sezo0oPi8G0dyOHMT7P7uRtPK7SJwMFGT0iRT
         wsSpKH6SkCMDV4cWplBERK47w7DXi27cZLxp9y98ByFJ5lFKGEO9cER2P8IuDSrw2p
         /+AUJuabvTyIw==
Date:   Thu, 27 Jul 2023 10:53:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 05/28] dt-bindings: net: Add support for QMC HDLC
Message-ID: <20230727-decidable-sterile-06ef617c144b@spud>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-6-herve.codina@bootlin.com>
 <20230727-talcum-backside-5bdbe2171fb6@spud>
 <20230727110948.7926a532@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O7XSXK7XxHjViR5H"
Content-Disposition: inline
In-Reply-To: <20230727110948.7926a532@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O7XSXK7XxHjViR5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 11:09:48AM +0200, Herve Codina wrote:
> On Thu, 27 Jul 2023 09:19:59 +0100
> Conor Dooley <conor@kernel.org> wrote:
> > On Wed, Jul 26, 2023 at 05:02:01PM +0200, Herve Codina wrote:

> If needed, I can change to:
>   title: QMC (QUICC Multichannel Controller) HDLC
> Let me known if it is better to you.

If it were me writing the binding, I'd probably use something like
"Freescale/NXP QUICC Multichannel Controller (QMC) HDLC", but it is not
a big deal, I just had a "wtf is this" moment :)



> > > +  fsl,qmc-chan:
> >=20
> > Perhaps I am just showing my lack of knowledge in this area, but what is
> > fsl specific about wanting a reference to the channel of a "QMC"?
> > Is this something that hardware from other manufacturers would not also
> > want to do?
>=20
> The QMC and the QMC channel are something specific to the SoC. This IP is=
 only
> available on some Freescale/NXP SoCs.
>=20
> When I upstreamed the 'fsl,qmc-audio.yaml', I first used a generic name f=
or this
> property and Kristoff asked to change to a vendor prefixed name.
>   https://lore.kernel.org/linux-kernel/1dfade07-f8c4-2e16-00dc-c7d1837082=
59@linaro.org/
>=20
> Based on this, as the property 'fsl,qmc-chan' has the exact same meaning =
in
> fsl,qmc-audio.yaml and fsl,qmc-hdlc.yaml, I use the same name.

Okay, thanks for explaining!

--O7XSXK7XxHjViR5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMI+iwAKCRB4tDGHoIJi
0qi3APwL74Mb2llAu7YBw/3bmeFa7gR7fA/ofP+aXSE3vKilNwEAr7q9DVx5VZdT
1kkQaOjZ61gQb0aNwEfyWDLEqkpWAgw=
=qYki
-----END PGP SIGNATURE-----

--O7XSXK7XxHjViR5H--
