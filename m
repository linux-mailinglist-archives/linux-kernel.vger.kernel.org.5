Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18E7C88D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjJMPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:38:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B101B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23000C433C7;
        Fri, 13 Oct 2023 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697211484;
        bh=px0hJPJGEqtnzB/MjJ58emJOrCiTxUB3k4inPhEhfaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzuXey+AHMzZAixNzyFupLKEPwKIBR+pbSrkdDOop+ewZvwoQMoJMNICYcA85ENaK
         dZhagi2FO/JOY2mbsIulNwL5kcylmuSYX/p3XK0F+61PmKWGg8rhXHEblDitKsQlLj
         xh9ZImfa61APFcqWUhJafjZaZZuPiWoHpqzFzKOmFXQbfSOFnp1wNoolJGGcQxa6OV
         hICmMZNEGycnkFfpMUO7ZEsCWKkc3Iy0jN5kwWi/GutSXjqy3Y03J0x1mLSi2S5GQl
         xUIVwWEMSgl1ITDyaCXCH7hh0o3TxUXp1I+4QuEKpw95niQ/qm/2DO9dFGDUFt3j6H
         tu+sZwR3lP4FQ==
Date:   Fri, 13 Oct 2023 16:38:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ninad Palsule <ninad@linux.ibm.com>
Cc:     joel@jms.id.au, eajames@linux.ibm.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, lakshmiy@us.ibm.com
Subject: Re: [PATCH v1] regulator: core: Convert warning to debug print
Message-ID: <ZSlkWZvtEFfSkqNE@finisterre.sirena.org.uk>
References: <20231012174235.2424670-1-ninad@linux.ibm.com>
 <aa596890-d98a-41c2-bc10-8c1db58ea23a@sirena.org.uk>
 <4ecd19e5-9dfa-4157-9384-92c722064b2e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n28rsL+V8HFb05jF"
Content-Disposition: inline
In-Reply-To: <4ecd19e5-9dfa-4157-9384-92c722064b2e@linux.ibm.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n28rsL+V8HFb05jF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 04:45:48PM -0500, Ninad Palsule wrote:

> You are right there are regulators for these supplies but they are managed
> by the
> hardware hence not added in the device tree. I checked dts/aspeed directo=
ry
> and
> non of the machine has =E2=80=9Cvcc-supply=E2=80=9D defined and lot of th=
em use eeprom.

Fixed voltage regulators can be used for this.

> Also, I thought that this message is only useful in the lab to indicate
> developer
> whether they missed the device tree definition or not but its not useful =
in
> the
> field.=C2=A0 Hence proposed to put it under DEBUG.

The theory is that it shouldn't come up in the field since people see it
during development and fix things then, are people actually looking at
these logs?  I think my understanding was that they're mostly BMCs
people interacted with via a UI of some kind.

--n28rsL+V8HFb05jF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpZFYACgkQJNaLcl1U
h9BRbgf7BMkUCUTTzJyxK6t4pfQKCOwLc61M58ANJQuO0pPn29IzNSupCAkwNkn2
yUTyz1wZnx7FiFqqfbqz2A0w3l9xye0xFaTw2oF7rl9F11Sux6xLw+srEUKpQqbj
J9s2s1XMpuEz6T7xhWUK0h+KPZGo9ZTJofW+7aeS2iGRFT135UBRK8rXXLnOVOT3
g/KzLlXPpi3Zj0K5Khgfjj/pFcgEoB2vfnNKXAtuiGUYmPo/tsvW3vEtGaM+5A9j
rB8nJ8DqV6cteY/qo8LX1Qbb3tBsOiWVt+G0k8Mv7jrRIvKYw/fHeKgrBOpSe+rQ
ulxMn9YTFLNkXc68+ataqIu7Wom+0A==
=WMBi
-----END PGP SIGNATURE-----

--n28rsL+V8HFb05jF--
