Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D480F5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376696AbjLLSv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjLLSvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:51:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D236C19A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:51:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E49BC433C8;
        Tue, 12 Dec 2023 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702407101;
        bh=dsv616JxuKXa+9HnLUwoLHTRzosx3BRQ5em0FE7Wdi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hilZNWnTPGBcJppGAc3Ra51k1swo6WEjxlJvulR/NT7rAMgcsyZn/2mMdOXAo8k2u
         d6JquEwEOgdE3xHIK+puKGbF64+jG7CZeXdRpV5WtchLQMfpJKfQ3mGPTtq+hzrAKO
         W+FWYIRRljOLiGZxqCMYL5Zd9V6ZHihWLlCXNBW+fa87m8A34i2/iNEGp5EM2NxC7k
         ozA4yFqRi1JD7wgbWcVyyNufsWwsJcTuboXLSChed8W4MpcxY90j39R2KR/y+Yb+pB
         L7qKpIQC2bYh2RuqSpBwZo31nX3CkwmY8kXhtC108ejoPasGyN7GhtiGN9v07SvhfO
         4NnphCQGRzcCA==
Date:   Tue, 12 Dec 2023 18:51:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, broonie@kernel.org,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Message-ID: <20231212-mouth-choice-40a83caa34ec@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V9Oj+WVlG5N/W7nM"
Content-Disposition: inline
In-Reply-To: <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V9Oj+WVlG5N/W7nM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:00:39AM -0800, Guenter Roeck wrote:
> On Tue, Dec 12, 2023 at 05:15:51PM +0000, Conor Dooley wrote:
> > On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
> > > From: Joel Stanley <joel@jms.id.au>
> > >=20
> > > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> > >=20
> > > https://www.nuvoton.com/products/cloud-computing/security/trusted-pla=
tform-module-tpm/
> > >=20
> > > Add a compatible string for it, and the generic compatible.
> > >=20
> > > OpenBMC-Staging-Count: 3
> >=20
> > Delete this from every patch that it appears from.
> >=20
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.=
au
> > > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > > ---
> > >  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_ti=
s_i2c.c
> > > index a897402cc36a..9511c0d50185 100644
> > > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > > @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> > >  #ifdef CONFIG_OF
> > >  static const struct of_device_id of_tis_i2c_match[] =3D {
> > >  	{ .compatible =3D "infineon,slb9673", },
> > > +	{ .compatible =3D "nuvoton,npct75x", },
> > > +	{ .compatible =3D "tcg,tpm-tis-i2c", },
> >=20
> > What's the point of the generic compatible if you are adding the device
> > specific ones to the driver anyway?
> >=20
>=20
> $ git grep infineon,slb9673
> Documentation/devicetree/bindings/trivial-devices.yaml:          - infine=
on,slb9673

Hmm, this would then need to be moved into the new schema, out of
trivial devices.

> drivers/char/tpm/tpm_tis_i2c.c: { .compatible =3D "infineon,slb9673", },
> $ git grep nuvoton,npct75x
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> $ git grep tcg,tpm-tis-i2c
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:             compatibl=
e =3D "tcg,tpm-tis-i2c";

pog, undocumented compatibles.

> It looks like at least the generic entry is needed, given that it is quite
> likely that there is hardware out there using it. Other than that, this
> makes me wonder: Is there some official guideline describing if and when
> to use (only) generic devicetree compatible entries and when specific ones
> may / should / have to be used ? I suspect the answer to your question mi=
ght
> simply be "because we did not know better", and it might be helpful to be
> able to say "please see XXX for details".

To me using generic compatibles is okay when there is another mechanism
to identify the device. This patch would make more sense if the addition
of nuvoton,npct75x was omitted and the dt-binding had

properties:
  compatible:
    items:
      - enum:
          - infineon,slb9673
          - nuvoton,npct75x
      - const: tcg,tpm-tis-i2c

And whenever new i2c tpms showed up the device specific compatible was
added to the bindings and the driver had only* the generic compatible
static const struct of_device_id of_tis_i2c_match[] =3D {
	{ .compatible =3D "infineon,slb9673", },
	{ .compatible =3D "tcg,tpm-tis-i2c", },
};

* well, and the existing one since that cannot be removed.

--V9Oj+WVlG5N/W7nM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXirtAAKCRB4tDGHoIJi
0pVCAP9eEmViq9zfDvETMM5iORAPbi28FpIFeXMWyuql8hUi6AEA94t1EPXiXh8e
thK7zLOAbzpr0XigoTjBCCrT5zJs5wI=
=bTRp
-----END PGP SIGNATURE-----

--V9Oj+WVlG5N/W7nM--
