Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D397AE24D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjIYXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIYXcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:32:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17431101;
        Mon, 25 Sep 2023 16:32:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CBEC433C8;
        Mon, 25 Sep 2023 23:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695684738;
        bh=g6tAy6hdSxc4KI8v9obT1Yl+ADKftmXOjG6GSK2ZkhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmXc/1pXGW2+/HEeumfywZ51IU4Hs5ACQTZujqaS/qyTSxTlsOeh8HFq8IulI9qqu
         1uX2Fb+M5C9jdIceHxJ1lmQxiJY1GZm8asgiujFw5MmKrRdh/QqKflnkizvac1oZAB
         57w1VbzOAW4CAdDxdRUSaAZ1MUUHO5yPdcSK6Pn0pNnC+iWKqOsC7AOJ0o67I2FRR7
         sdLEBHKlWv1K4WaxL5E4yVIntF7vVbXJMupEw8UY/QrIXCEeSO57MNDIjKjWtiWMh9
         i66AoBMSH7j1uMEHB8iVA7n5QrRXc1LJyz/LJhnIATMmUI/mgPf4X9RUbC+8AQotBg
         SRix/cACrcuKw==
Date:   Tue, 26 Sep 2023 01:32:15 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] userfaultfd.2: comment on feature detection in the
 example program
Message-ID: <fgavhpky2ba3tfv6abkln7kzzayfxl5mnu5vzzzop5ct5mtmdl@dbdf2w4d4fva>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7eflzcifipfkwrsh"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7eflzcifipfkwrsh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 03/10] userfaultfd.2: comment on feature detection in the
 example program
MIME-Version: 1.0

Hi Axel,

On Tue, Sep 19, 2023 at 12:01:59PM -0700, Axel Rasmussen wrote:
> The example program doesn't depend on any extra features, so it does not
> make use of the two-step feature handshake process. This is fine, but it
> might set a bad example for programs which *do* depend on specific
> features (e.g. they may conclude they don't need to do anything to
> enable / detect them).
>=20
> No need to make the example program more complicated: let's just add a
> comment indicating why we do it the way we do it in the example, and
> describing briefly what a more complicated program would need to do
> instead.
>=20
> The comment is kept rather brief; a full description of this feature
> will be included in ioctl_userfaultfd.2 instead.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Patch applied.

Thanks,
Alex

> ---
>  man2/userfaultfd.2 | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 00d94e514..b2b79f61d 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -881,6 +881,13 @@ main(int argc, char *argv[])
>      if (uffd =3D=3D \-1)
>          err(EXIT_FAILURE, "userfaultfd");
>  \&
> +    /* NOTE: Two-step feature handshake is not needed here, since this
> +       example doesn't require any specific features.
> +
> +       Programs that *do* should call UFFDIO_API twice: once with
> +       `features =3D 0` to detect features supported by this kernel, and
> +       again with the subset of features the program actually wants to
> +       enable. */
>      uffdio_api.api =3D UFFD_API;
>      uffdio_api.features =3D 0;
>      if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D \-1)
> --=20
> 2.42.0.459.ge4e396fd5e-goog
>=20

--7eflzcifipfkwrsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSGH8ACgkQnowa+77/
2zJTTxAAlq3w3g9XKdtWdAY0IFZ8OLHqDNS4ORRDwwc6CYY0LLe7lTDsHVO0jDTl
Bl4F7WF+OcvPNu9gVwI9Ry8q3uZlOkr6WVi/2wvYV0j6FOmcYf1F4s9mRADGaadZ
qvjuQbXsXfV6es4zi1j7HpoJ4mh2UwWyYvzm4HHaiGFCeErkj7JOUPCiIY0YjtCu
HZtSMtKEzq8bhawccBa1yKABrKteu/zykDuo620dybqiDivfrvpLwjRJMJ+uZXXQ
wis+GPLry0B6ZmfhzIptVQVsm/03bNZU0YrCyGU9VoX/u6W0PqQHRmuedX61F0XI
8BmVBRpEL7F1tdGe6nCUpWmVVHTSAcb24L2hQ6n3eGOWPDNL3wAXbsIy+Vxfa5nY
DEkIttpfc4sdfU7UEJ3y/hWkZX/ZKm+CI7opeqkyiw4Qg+sZQGjgudeZ0mSccert
xgpsLgPT02ZCEqoEFjAK4z50PSrhVxycja1nbMd5ycUzS7Uy72+izckT16YsFf5b
kgvxXo4BEwps4Sfc2yhXejuVwixzvuoBfTR+GXaiLSfyj3ai/No7wtQZPt2myXT2
A7xnYpqfR9ilNaug3ZiXY+e28SAcKWCRM8OpEqIy14RKEzkMhf22zzfE6rBOkQ9g
u0wgcrNXyq4RBjKa3tQxnYeB2/3nNgAK8AT2jgKwZZ9XrFfYCCI=
=hPpM
-----END PGP SIGNATURE-----

--7eflzcifipfkwrsh--
