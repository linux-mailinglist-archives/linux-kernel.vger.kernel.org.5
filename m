Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9D813572
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573926AbjLNP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjLNP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:56:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DCB11B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:56:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0A9C433C9;
        Thu, 14 Dec 2023 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702569417;
        bh=Irc7j9mhIhkTjruf9MUgxUtXcKks1NoDo+o05Js0JRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUlL/8ZQUpL92Yu4EDmQpLzUoufYW86sQ3eOU73LLU8e28ku06Q4eF+k9hlUGo/KI
         GqrdLjWcVF10n3U1YeYk5OWaGYhLZbmu7dyjYcVByBqqORc1mGbqDwcUI4jFNQ/aCC
         /+gcVYj9QYgUtUlXwcw2UoGsZ/EYNnHjHMJ/JB+ULpbO+C+leNpMRupyotFSP/RtnG
         Ie3PP2656wTWQ8QMdd67GW0Hsr/o1tuMLIyFeeRQ+fN0sTBVOH0FDFwKd0URD/orrX
         upTcn8XOKpxSU52fqQvJeUEJvWVt/r7ONfRf/hKfUDVew4KZj+7EBIxTbFUtUDTF8n
         ayblJLEV8ja9g==
Date:   Thu, 14 Dec 2023 15:56:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ASoC: qcom: common: Add qcom_snd_tdm_hw_params
 function
Message-ID: <bee0ab28-6bd3-4904-8afc-44fe7ddacb79@sirena.org.uk>
References: <20231213123556.20469-1-lujianhua000@gmail.com>
 <7b13b8b6-9048-48a3-b1a1-e62de88e8171@sirena.org.uk>
 <ZXsklsO7nOqBFgzt@Gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3QwHa6JjLmRb9NBb"
Content-Disposition: inline
In-Reply-To: <ZXsklsO7nOqBFgzt@Gentoo>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3QwHa6JjLmRb9NBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2023 at 11:51:50PM +0800, Jianhua Lu wrote:
> On Thu, Dec 14, 2023 at 11:11:06AM +0000, Mark Brown wrote:

> > The expectation is that TDM is set up by the machine driver, not from
> > hw_params - if the TDM setup can be changed from within hw_params then
> > it's hard to see how it's going to interact well with other TDM users on
> > the bus.  More usually hw_params() would be influenced by the setup done
> > in set_tdm_slot().

> Currently, qcom TDM setup need to read hw_params, if we want to move it
> to machine driver, we must hardcode some params, but it will reduce reduce
> readability.

What makes you say that TDM setup needs to read hw_params?

--3QwHa6JjLmRb9NBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV7JcMACgkQJNaLcl1U
h9CY+gf3YsZTfcu/vz6WuiAEAFNcmWZVpApi5hN7KrHcB7qQWGfbWcivQWhFfiFc
2HsD9BS9nkFG8HWmHz2DKgZltPNOIIVLnaHLBS6IaFqXCqDkWdDDpVmYTBCcIsSV
Ls8IlGaVn9ddGf//+9sCcG1yIVnEj2NXqCHSM6EcDwNRy+kvGz9UG8pKYd2clgMv
eVraA+qIr2R0jePWFgGuYGwrmy2O6/u0LHkjCnbUABHA2g8hGRvbv/Rv6IW1zKbb
D013IGVbR1TkUWGlVU5b6AOS6DLlHMwIYwqaa5Gw1EQ/Q0S2J5N5105UGICxqVBA
p1yWhSlzFo3Tjs7PQxsTZV3DHmFx
=WcEt
-----END PGP SIGNATURE-----

--3QwHa6JjLmRb9NBb--
