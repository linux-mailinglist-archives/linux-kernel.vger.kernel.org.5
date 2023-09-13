Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678D79EC22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbjIMPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjIMPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:07:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61B7B7;
        Wed, 13 Sep 2023 08:07:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54C1C433C8;
        Wed, 13 Sep 2023 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694617655;
        bh=SYzUOpvEWA+yyqFFVtA92rfi3iMtgTA3kqi44w7DWsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sK8vGcMPpRNYhDpRYfwH/9KknVNkBCBwMjnCJ+uPuDQYPqN/G2Vu75ziBRwFhUaQ4
         dpDON6WakckbrSsU+lv+faFmsX14Gz3ML2PXVwK+vWOHp4bWsqv2RPkjsg/ohAb4bH
         glRlXqtvF67qTtbsubSMOq9Y79ZPgcICMMAr4nsAXhrPrrrODwmnzVOjWKt4ySzkYu
         hCi9Ig06KgXS0ZjOMbA6Dys4acf6rYdK8xhQGOu4wjDiYjUlXVL5Pv8YgqsJgDiqAn
         6JA1SBbPJ49x+pvBHSw6C08enJ35TR+2KFlwreS2b5HR3EVDJU6i8VG7yRXbGXgewS
         buDvy7lYjZ8lA==
Date:   Wed, 13 Sep 2023 16:07:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Myunguk Kim <mwkim@gaonchips.com>
Cc:     alsa-devel@alsa-project.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, fido_max@inbox.ru,
        joabreu@synopsys.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, robh+dt@kernel.org,
        tiwai@suse.com, u.kleine-koenig@pengutronix.de,
        xingyu.wu@starfivetech.com
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Message-ID: <71628b39-fd59-45ee-bad9-3e6bd42cb97d@sirena.org.uk>
References: <ZP8Irf6g+sG6Ax9j@finisterre.sirena.org.uk>
 <20230913040902.1496711-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JskZn6gM/rV4+uuO"
Content-Disposition: inline
In-Reply-To: <20230913040902.1496711-1-mwkim@gaonchips.com>
X-Cookie: Use extra care when cleaning on stairs.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JskZn6gM/rV4+uuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 01:09:03PM +0900, Myunguk Kim wrote:

> In this case, it is not used through the DMA API.=20
> The connection relationship is as follows.
>   i2s --- pcm_dmaengine ---  DMA IP (ie. pl330)
> So, control was possible only by directly setting the maxburst property.

pcm_dmaengine is a wrapper binding the DMA API into ASoC...

--JskZn6gM/rV4+uuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUB0C4ACgkQJNaLcl1U
h9CYPwf/eIOjdsbfVUtd+7nrcZMXcCeLgXOgT8xemnVvr78ESGnp7aH/Ke/IloW/
5cFGLOAQJfUeknUFd/X5Cp0UJpqgBwvQYheCaRU8wLr7vV6B7KBkIaOB7ZEfurT3
kupI6QMqDaey8qlwKeO0YC6nMGVlDE+1Fef86159QscpyReQJcGOa/f9zbiS+ohl
WkDgQbWBZCao8OUtgyE1uwJnPy6K2HxrJTpb4OwP1Bx40W3d4Hj1arAPpKUL+lv+
x/iUSv+fA/4JY0Rtem4HKlFIOhVxer9u1WAvBMTMM6wWhTOS5biVXGXb2kjm5/O4
+g414PVgdcpHlHA3iBf2v21S9zGLnQ==
=5GdS
-----END PGP SIGNATURE-----

--JskZn6gM/rV4+uuO--
