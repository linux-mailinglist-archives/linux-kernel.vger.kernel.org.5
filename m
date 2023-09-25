Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F401D7AE2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjIYX4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIYX4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:56:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05C10A;
        Mon, 25 Sep 2023 16:56:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCCFC433C8;
        Mon, 25 Sep 2023 23:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695686170;
        bh=BMrAGXuGExETbvl5OiPJxS7FFi7b70fqhN0uHMUVHQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFJAIlatXeyOUDs74QXRdl2atE/vvik57PP8PsLPzOPzYJIHXS5PUkApsT9KW+SAh
         wj7wy/yd8YtQh2GK39lImhNCGiQ/eLstIImoKBLHE7RkWNcjhwhK80pXtnjc0loFtB
         D6JbzCOyLvnmKJwkmM0ld75rz9qJiMkJ51o4KQfNmuYZ6sn4LKf7KX8ri2Jfm2ZFcG
         xj+691RvxkWxKF89n+bbEogBf2JTBElhAy6TLaWyp6/IhDubLMirWgnLtjf37UeM/+
         zLlOTYxjVjc/trSXzY9KXs/veAdh8btFXZRNwjvJMpO8ChX6FLwCz3dKF/gMBVUT7Z
         nImkyVzEws5/w==
Date:   Tue, 26 Sep 2023 01:56:06 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
Message-ID: <s4p5qch6llhedcr736vityb6ttvajk5xip7ebdijgw6zt4jbkk@nt2qh2ixmi3e>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-9-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sywgjbkq4kcpxg35"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-9-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sywgjbkq4kcpxg35
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 08/10] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
MIME-Version: 1.0

Hi Axel,

On Tue, Sep 19, 2023 at 12:02:04PM -0700, Axel Rasmussen wrote:
> The old FIXME noted that the zeroing was done to differentiate the two
> EINVAL cases. It's possible something like this was true historically,
> but in current Linux we zero it in *both* EINVAL cases, so this is at
> least no longer true.
>=20
> After reading the code, I can't determine any clear reason why we zero
> it in some cases but not in others. So, some simple advice we can give
> userspace is: if an error occurs, treat the contents of the structure as
> unspecified. Just re-initialize it before retrying UFFDIO_API again.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

I can't apply this patch due to conflicts (due to not having applied two
of the previous ones).  Please resend all remaining patches in following
revisions of the patch set.

The applied ones are here:

<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=3Dcontr=
ib>

It's kind of like Linux's 'next' branch.

Cheers,
Alex

> ---
>  man2/ioctl_userfaultfd.2 | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 1aa9654be..29dca1f6b 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -272,6 +272,14 @@ operation returns 0 on success.
>  On error, \-1 is returned and
>  .I errno
>  is set to indicate the error.
> +If an error occurs,
> +the kernel may zero the provided
> +.I uffdio_api
> +structure.
> +The caller should treat its contents as unspecified,
> +and reinitialize it before re-attempting another
> +.B UFFDIO_API
> +call.
>  Possible errors include:
>  .TP
>  .B EFAULT
> @@ -305,14 +313,6 @@ twice,
>  the first time with no features set,
>  is explicitly allowed
>  as per the two-step feature detection handshake.
> -.\" FIXME In the above error case, the returned 'uffdio_api' structure is
> -.\" zeroed out. Why is this done? This should be explained in the manual=
 page.
> -.\"
> -.\" Mike Rapoport:
> -.\"     In my understanding the uffdio_api
> -.\"     structure is zeroed to allow the caller
> -.\"     to distinguish the reasons for -EINVAL.
> -.\"
>  .SS UFFDIO_REGISTER
>  (Since Linux 4.3.)
>  Register a memory address range with the userfaultfd object.
> --=20
> 2.42.0.459.ge4e396fd5e-goog
>=20

--sywgjbkq4kcpxg35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSHhYACgkQnowa+77/
2zKnPw//YWI1d9zlIUx+sIQ+etTFDCgb9G1nFfGeE4qSWGNBDOFlK6D7cKCKBS9P
mihPubSpiM1xaW281n2kDjxOolWeVwXTJFudUgeSoDPSp9895Pr3FImawj3EbnOp
rnvn8jmihpy8MhgXMo9onszAC7fvY2vrzeb8e1ftDc6Y0We66Nhl2GtHHpzqtiuv
G2SoAD7d1ZtK15iU/vYwaSGe/0NZ7HP19ROw2mx/WUDEu0HnzKaN0mgDP1XiMz8w
Jk6Pxip6e10FeKRzawKps4znFFZP3SfoS6we7whdRkC/fXVTod7eTWMkmwdY+bN2
PnOQAxKQg7OT6FPcOcH0AgP8Dxgd+9OLiFwbsmYpkdKW4jy3FSq+I0dsCnX+luXd
ILfApGDtwhhVwFniVq/KsRFkCnlFF/vU70WqUtF5ufpBfOgjcPsSK0PRdNYFojym
vX+AZf5Gjc7nHysBGTkK3JRQNRTSYkvQY+ZjsWyMs5ATdgxbq5g/QkkS5iOL7ML3
Vv2AVbFCmcDX1Arx96nxntaaWI0nDixcRWd8QTgtbYdv5r0Bl4nevr+aRmCgGLST
+XbKSLF4oT+eHAlOwUFNeUWZmhv97zTK3K5PIX6mk4vx8ETdvKQz8tn4d+vvKxJj
6qy3FiJc6w79ZIx5/zsx4jHMd9joKg39cgLxMhUVR5G6A8Canow=
=Pua0
-----END PGP SIGNATURE-----

--sywgjbkq4kcpxg35--
