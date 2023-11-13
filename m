Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04EB7E9449
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjKMBxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMBxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:53:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39513171E;
        Sun, 12 Nov 2023 17:53:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA40C433C8;
        Mon, 13 Nov 2023 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699840421;
        bh=XM9slHSuHenZFKSKWvvQ6DDBmN0fQyrYpW8MWDgIWQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFRWmE7eQJ/aTD5Mxtenkz//2MYKZtNl9tyxUnpeh+LWPlfHtucmPCkEE+tVMCwJh
         HFQ6Chd6SaagJ4siodStopahCVtR4TKSfxAWdH9XHU+xsQbiUECq9tPpJN+Esgz4yT
         lyHWQ578XPnYCRzXc1yl0GYslbTxoF+B+7ZhvdfUEq3TRb6JJmIte5qz+PyQXnQN3k
         qAd2UZVT0FCrDo+cTEuy1gYr/j46xVHrjUYNlOFRnOWT5nLUp01qu7nlgD75nnyV08
         PlI32ybE7TzLEFCdrdkAQoM1k6WllfNkdB6ZKZtwlC97sbZyUteT4gGlOvpdK84bnW
         obwuJcxqfz8bQ==
Date:   Sun, 12 Nov 2023 20:53:24 -0500
From:   Wolfram Sang <wsa@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linus.walleij@linaro.org, codrin.ciubotariu@microchip.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "i2c: pxa: move to generic GPIO recovery"
Message-ID: <ZVGBlBQ+8tWodl4H@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, andi.shyti@kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, linus.walleij@linaro.org,
        codrin.ciubotariu@microchip.com, stable@vger.kernel.org
References: <20231110093039.190076-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qEUhyd/zH8KpS+AA"
Content-Disposition: inline
In-Reply-To: <20231110093039.190076-1-robert.marko@sartura.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qEUhyd/zH8KpS+AA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 10:30:11AM +0100, Robert Marko wrote:
> This reverts commit 0b01392c18b9993a584f36ace1d61118772ad0ca.
>=20
> Conversion of PXA to generic I2C recovery, makes the I2C bus completely
> lock up if recovery pinctrl is present in the DT and I2C recovery is
> enabled.
>=20
> So, until the generic I2C recovery can also work with PXA lets revert
> to have working I2C and I2C recovery again.
>=20
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: stable@vger.kernel.org # 5.11+

Applied to for-current, thanks!


--qEUhyd/zH8KpS+AA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVRgZAACgkQFA3kzBSg
Kbatng//Zrp13u+PGqC/LepdrqLGxOqtkeZgDDl6YzZ5fv9ZQDwJfO/zGcnKm4Oh
+iT68p2iyjerdzwRNXs7Y82ifKRcg+XnuqO67XTfTLKT+lDnbXC2D09GAPO7naF5
dA03JyfwloaPQZuF5KEe0NGg6Mz3EzunGpO4DwQUI7TEP8DqbtuLLCW6nStrSCvd
aF1D5To7bi7jCMkj4XIJcdb6iocePcie0dZD7WvXMY+gIfCt8OupJEmq51u07wR1
pPhi0NTDcAQRszjgUNAHp0S224dIFSuhDxclwn7naLmgAofS860uX1exhK4Ff2Qh
ugAPrZKF8Y6wXdlAITVtAoMIYKGXiD2PQhKSFQYiMaFygwfem/q8kYB/SbciMtYY
y4GR6g9IHjD5gybfijqzIbvbNKoZGiTaeMHhoY+s8padSW5X/AqDeS4GlVa/S0eH
yQMSmJJ75pfGUVajfFp5SDD9jYfLooUPhAS8yoOw1hR+lcjTSRllXuhIxPqeE/Zm
uElJ9fA3imCZOdO6UQ1kEDLL0+NnF2aB30Qe1/vjUQWHMW47+oE2fLhOwxwKLWRy
OmYVfLd67yT6kHRUJ72EQJ0KGW5lvCUdbK0InIK3d7FclZWKXuNA5GqOKiLeZ65r
z2BDNlRf6XGQ7hOPGibKHC2y7RP6q95UtzEVxVFvs7XSK6q8vL4=
=sbB+
-----END PGP SIGNATURE-----

--qEUhyd/zH8KpS+AA--
