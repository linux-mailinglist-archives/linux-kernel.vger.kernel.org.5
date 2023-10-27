Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32BA7DA27F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbjJ0VcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0VcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:32:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C502B0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:32:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC7AC433C8;
        Fri, 27 Oct 2023 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698442335;
        bh=qK3hvJNS0Aliw7xtqaQfDoHDTkfG6rrB9PlIHENXp2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reF7VfnS5duq0mgeS8r0udz14EQe/24l9fbm+CaxS8xqcPXiyjpMlFomtdjZOld0l
         FCGKPxe3nEo7NT+AK4suFsZvpjJUDcRD52NaNJC+N3XV0BsmFwZQAsikAmph5MUyyM
         0ZTBdehoku4xvH8VJothhg4ER63PIl0ELl71CU3qbWVVkjPKms42zdPEz3Uiek6YKK
         3XNNuV47dAyC7zIjEyBNOz5C42v6IJGcBrwBJcNh6Q4n87Hd4QP/DPLz4sOelc56rg
         BcM9h9IUw2CslM5WYiBkpkArldS3krV+fYFZ6GG2lNAb6AY/vAxP0iWZNyhO5WsFaQ
         WgteBjRB4g0gg==
Date:   Fri, 27 Oct 2023 22:32:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] regulator: dt-bindings: Allow system-critical
 marking for fixed-regulator
Message-ID: <ZTwsXCQ2bz7KlgFl@finisterre.sirena.org.uk>
References: <20231026144824.4065145-1-o.rempel@pengutronix.de>
 <20231026144824.4065145-4-o.rempel@pengutronix.de>
 <20231027212440.GA3392484-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mZLwjrO5zan/3GHq"
Content-Disposition: inline
In-Reply-To: <20231027212440.GA3392484-robh@kernel.org>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mZLwjrO5zan/3GHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 04:24:40PM -0500, Rob Herring wrote:
> On Thu, Oct 26, 2023 at 04:48:22PM +0200, Oleksij Rempel wrote:

> > In certain projects, the main system regulator, composed of simple
> > components including an under-voltage detector and capacitors, can be
> > aptly described as a fixed regulator in the device tree. To cater to
> > such use cases, this patch extends the fixed regulator binding to
> > support the 'system-critical-regulator' property. This property
> > signifies that the fixed-regulator is vital for system stability.

> There is no programming interface for fixed-regulators, so how do you=20
> know an under/over voltage condition?

There's support for interrupts now - it's a just a simple signal so if
the interrupt is asserted you know there's an error but that's all you
know.

--mZLwjrO5zan/3GHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU8LFsACgkQJNaLcl1U
h9A20Qf+PcLBGuaFuQS105GCX+siPedNjWr631UhJBQWdT8ZOVMYOQynB3gBheJh
yPf4FZDN0CW6fx+KTGWJUmSOy8fDez9M78hl8XMAxd9NhrcUxqbVjl6AFfBv6UES
lXLkRxxpHTqTw7XySJFDl0s3tyLqgTN7cdqlYXghyjwEV8tudTv7kkl9pPhVyCP8
xylX/nz+F8sZOuAJ/RWVMcUKZBf3wblNR9x170gTEkof/9lsAt2004O/VmIBZplQ
mjuWPwy7OX0TXct4MxncJAYCqkWcZxGOjSuBr9iAhUV2tA6t7DuW3B35HL+gnQD/
JKjSM0hTcSrykL81qfXqn54ozzUdWA==
=9OwE
-----END PGP SIGNATURE-----

--mZLwjrO5zan/3GHq--
