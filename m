Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4967EF897
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjKQUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjKQUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:21:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A748D7A;
        Fri, 17 Nov 2023 12:21:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D83C433C8;
        Fri, 17 Nov 2023 20:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700252467;
        bh=6kWbUec2vNPLzBAifXthIFUfHalLUWmEkimnUqjKqEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUILNHC2ssKkG8uhrL9stAje1hf/ECM1DWKoQc4BqdV1E+TajxE4VZK+2R8GFiUcX
         N0xHEFdpTBEPr5CbsmJu3kzi9aghy+DU7btdWnxMnqsSKAdNQ6RZRNaIiIuMqR3XEi
         Ff4lVFDNEByTdN4l6fxaS0aRmO2Mzbavu0yzA1bhZUkY1PN8bsoznE79wyIedLZp70
         eFYY7AZdtSKOBOOlGt6sgnJJTLgCPguTn0lEQJarFqfP6URPr6vVfKGyABiq9Q9jbS
         aoglYiwaTYR9Fvj0wibWmt/Az9KR3d+jZWJJJ/w1Nz0nu+7q59tI9OhA8FX4UWrx9r
         RaVKtfqcXYXZA==
Date:   Fri, 17 Nov 2023 20:21:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ASoC: cs43130: Allow configuration of bit clock and
 frame inversion
Message-ID: <ZVfLMIbCpShVAYBf@finisterre.sirena.org.uk>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
 <20231117141344.64320-4-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXGxTGDM5lWFigCq"
Content-Disposition: inline
In-Reply-To: <20231117141344.64320-4-mstrozek@opensource.cirrus.com>
X-Cookie: I'm ANN LANDERS!!  I can SHOPLIFT!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXGxTGDM5lWFigCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 02:13:40PM +0000, Maciej Strozek wrote:
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>

This breaks an x86 allmodconfig build:

In file included from /build/stage/linux/include/linux/device.h:15,
                 from /build/stage/linux/include/linux/platform_device.h:13,
                 from /build/stage/linux/sound/soc/codecs/cs43130.c:16:
/build/stage/linux/sound/soc/codecs/cs43130.c: In function =E2=80=98cs43130=
_pcm_set_fmt=E2=80=99
:
/build/stage/linux/sound/soc/codecs/cs43130.c:1519:32: error: =E2=80=98stru=
ct cs43130_pr
ivate=E2=80=99 has no member named =E2=80=98dev=E2=80=99
 1519 |                 dev_err(cs43130->dev, "Unsupported invert mode 0x%x=
\n",
      |                                ^~
/build/stage/linux/include/linux/dev_printk.h:110:25: note: in definition o=
f mac
ro =E2=80=98dev_printk_index_wrap=E2=80=99
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
    =20
\
      |                         ^~~
/build/stage/linux/sound/soc/codecs/cs43130.c:1519:17: note: in expansion o=
f macro =E2=80=98dev_err=E2=80=99
 1519 |                 dev_err(cs43130->dev, "Unsupported invert mode 0x%x=
\n",
      |                 ^~~~~~~

--OXGxTGDM5lWFigCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVXyy0ACgkQJNaLcl1U
h9DeRwf+KIpYlfkMyt9MmI83/N6mLFgUrX9iljFpCxPqw+pMruJQXx1VPrhE5qRC
Ew5LK6C0ZG7fL4hb91OWfZc23VQdnLGF3Lif+4lQf6RIuSOt2uIITL0avcW+y8uu
ONKKXdrXELRjOZMd0LG/zZbxUpArS4c2MN/hZhGPBl19HUPwE5mh/FR+wFqb6gdI
rON7pEU5d2u5Bq0QtrmXq8CxqRkqAECYmnZSak4ji8gZ2O80ujqBW2GGAsb4UlUf
HgR7bXDmjroP6X1V8apf0+X+SnOGXQ46lalOJo6DlhsR9lvmiVhf69hHrTfXGK40
QqlkK7rIr3GdzDlhW7eWRTQxD51d+A==
=4iUp
-----END PGP SIGNATURE-----

--OXGxTGDM5lWFigCq--
