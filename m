Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7850479EB42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjIMOjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:39:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CA490;
        Wed, 13 Sep 2023 07:39:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64A7C433C8;
        Wed, 13 Sep 2023 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694615989;
        bh=RJoIfCcg3Gqvlc6Pv3L0lR4WCeRLMrROYaRGXX3uIAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0mv2ujnNPBV1QjbllewX4FCxcYj7UIsM7RYsumCnJYKKZxxARRvsgTPkchtVUrOG
         Rml9dusWCC3tOaFcBAlQZ+HyhFi21PQ2icCnZXU3YytqIFh6XOGdkU+3kNu8TwDyhB
         WJRDtBek5vWld2P/ShKcBo1SVBdzlme7UdBJijsO2e7k/u1AEtQ98HIez9iAnnMUp4
         WtYw87YW09XXT8g6GAGAFdOQxLYlJqVfeq92qL/KbAHqYFGZFctKtSpKUUK5BmqQUq
         W6tyh/Uvo62Cr0+7zVDD/qfL/7JXV4Zt19ttI2wt2FXW7Ioi+S8Uq74Ra8HfNT3oE4
         dbw/bY7nHM5AQ==
Date:   Wed, 13 Sep 2023 15:39:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
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
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 25/31] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20230913-faceless-sloppy-9c408191630a@spud>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912101444.225809-1-herve.codina@bootlin.com>
 <20230912-overplay-donated-080eb97803d6@spud>
 <20230912185405.GA1165807-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f/ltRk1gE1+sCzTa"
Content-Disposition: inline
In-Reply-To: <20230912185405.GA1165807-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f/ltRk1gE1+sCzTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 01:54:05PM -0500, Rob Herring wrote:
> > > +  lantiq,data-rate-bps:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [2048000, 4096000, 8192000, 16384000]
> >=20
> > -kBps is a standard suffix, would it be worth using that instead here?
> > What you have would fit as even multiples.
> > Otherwise Rob, should dt-schema grow -bps as a standard suffix?
>=20
> Yeah, I think that makes sense. I've added it now.

Cool, thanks!

--f/ltRk1gE1+sCzTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQHJrQAKCRB4tDGHoIJi
0iNbAQCQvNI/6rj3MUcE4cZYQRwXdY48ReUFl3upkSIAwL59UwEA5YVuiJyYj+pl
y+M6tf6hogZBT32WxEtJnwijye97rQw=
=lb0d
-----END PGP SIGNATURE-----

--f/ltRk1gE1+sCzTa--
