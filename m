Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3808B7AE23B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjIYX0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjIYX0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:26:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2D6116;
        Mon, 25 Sep 2023 16:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B2EC433C7;
        Mon, 25 Sep 2023 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695684375;
        bh=jOyx67uC5SiTnS8BEffUOwQ+irVxWeLVnsb6YQnLZ84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENn3siKcf22oNZBRFZiFRGe/3kDZ1cRe9VhX5fs/gkJBge9tHAM1fZopaBsx5kzOa
         UYnUkWT+oamvExA76HoT8LZYfjQvRxOVqYytGdap9IBp7BMCAltVUfFKNKbX2s1up3
         ZuHYMD4E9NWowqb2LDIPZD5HvYRajIsGtJRRKoRqeUki3hXSJCExTHQ6N90cYlBQ2h
         uHUb0SuYEcye3oxNG9zxY5ImyODNCCsUQkBvae9v6eMO8cOs9bjvI1HS76NZnZnVio
         1FqQZflt18eeAqblAD3uPi9Er1noWnfu+1XpEeAG7DsSRpvxXb+UlYsibskoT83aOb
         Wt7gIbWKNfexA==
Date:   Tue, 26 Sep 2023 01:26:12 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] userfaultfd.2: briefly mention two-step feature
 handshake process
Message-ID: <hdgabchiva2scg5jdzspopp5x6g3jq6fis2ihdg7rwt2fvse5d@ey5k3onkod6j>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tgqgkjx42vy67lq3"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tgqgkjx42vy67lq3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/10] userfaultfd.2: briefly mention two-step feature
 handshake process
MIME-Version: 1.0

On Tue, Sep 19, 2023 at 12:01:57PM -0700, Axel Rasmussen wrote:
> This process is critical for programs which depend on extra features, so
> it's worth mentioning here.
>=20
> Future commits will much more fully describe it in ioctl_userfaultfd.2.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Patch applied.  Thanks,
Alex

> ---
>  man2/userfaultfd.2 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 40354065c..1b2af22f9 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -200,8 +200,9 @@ the application must enable it using the
>  .B UFFDIO_API
>  .BR ioctl (2)
>  operation.
> -This operation allows a handshake between the kernel and user space
> -to determine the API version and supported features.
> +This operation allows a two-step handshake between the kernel and user s=
pace
> +to determine what API version and features the kernel supports,
> +and then to enable those features user space wants.
>  This operation must be performed before any of the other
>  .BR ioctl (2)
>  operations described below (or those operations fail with the
> --=20
> 2.42.0.459.ge4e396fd5e-goog
>=20

--tgqgkjx42vy67lq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSFxQACgkQnowa+77/
2zJzhQ//fs/V8Tpm5+m/k8G4xl6w0oXrzif8flzrufdNp4if/Z5VGlrNmo8xPh7G
YsRjHzLKAXQrn79h8vRvC459DSkMixazhRhmxcnPi45kkMJX53LNMNyzugY/20Vc
CSya5HdMV5/5m43RITW+PCQsnSmgByKP+KuPn3cuANpSF1Hyvwz1E3OXmTJN+qL2
8KPz+fRrC25+eMGmM4K/+pIwPGctelcXAx13icBj50ae+4VDsmNR9tXKuq5m0tNo
Z34PEQp2rt+PW3XnyGSsZ2k2RQV2F1utm8Jm9G7gRkb7Ub5sab9xxdt4kUDM4Faj
WawMXG/x7PfB37cU440t7eytXOhBCpHAA5SwIdPcI/V453pQs+hRYwXCwVR6UgpZ
vV6BUf/2NcHLwEp3L3dUHfgSslaoK2o+/bsZZkj/JrpdJ3PpV4DhWNCz3y4XerEu
M4huVEtzmbXFoKWHzLz2hZVZxSxNnfFY2AbZnnfi1tZVhFXeXXvNqWO98Uhyk6bE
MRqi8pEWB0fWRyya7gG7/THkrejuNtlGcxCbNH9ucqe55eZZBiDYWDopWS56P7iy
LLS2NgOsXXmBM3I/TVKmu3NvlDMt9VOzCQ4rPk6kU4i03eOPloqKqe/phCYZbBDa
Kx2cT2wxyr1TzPd/Z3iZno58u7KDTYkJhgGt+BRCkCZCL3VqBoI=
=2ZdH
-----END PGP SIGNATURE-----

--tgqgkjx42vy67lq3--
