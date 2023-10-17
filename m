Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C67CD040
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQXHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQXHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:07:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F06A4;
        Tue, 17 Oct 2023 16:07:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B770C433C8;
        Tue, 17 Oct 2023 23:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697584059;
        bh=dQ/jJ2xxWGs7cQZAVsrD6X/7JuhRJv3DnLJDerRLn6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzSnZNakYO8sxlX35q0nBc9AmKMn5dI0a6pJkwlfB0nEcckuChl5ROBBpYOW4pCma
         DqNe4DaBP8tlIDBh5/NSxkjIdi7XMMMtLTgzWoSfP6IuW4/enOk0pS5eQOAny7HcD6
         tCdEdyvJJMmlCwTqGlNzdL/X4Ro3reKuH353yK3js2sD5rBBztwovdVVDftl+WWO+a
         9ZR0BnICVepJxlniffGYEPS/ln7jQPsS51xhyOqBb+Mus909l6zyBWpobbVrOZl80Z
         dEaBQhO6VuEccEm5u7O6H+t7JAhlxLsycBWTf1kHXLBLtGJlpGHLQu6dgEkmN+QNLe
         HQ7MKTkJz0eSw==
Date:   Wed, 18 Oct 2023 01:07:35 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
Message-ID: <ZS8Tt4Lbdxk8RCYY@debian>
References: <20231017230110.3170850-1-axelrasmussen@google.com>
 <20231017230110.3170850-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B7otR/Eb6YTSxL7p"
Content-Disposition: inline
In-Reply-To: <20231017230110.3170850-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B7otR/Eb6YTSxL7p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2023 01:07:35 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-man@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error

On Tue, Oct 17, 2023 at 04:01:08PM -0700, Axel Rasmussen wrote:
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
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Hi Axel,

Patch applied.  Thanks, and thank you too Mike for the review.

Cheers,
Alex

> ---
>  man2/ioctl_userfaultfd.2 | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index e68085262..82aee667c 100644
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
> @@ -305,14 +313,6 @@ feature was enabled,
>  but the calling process doesn't have the
>  .B CAP_SYS_PTRACE
>  capability.
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
> 2.42.0.655.g421f12c284-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--B7otR/Eb6YTSxL7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUvE7cACgkQnowa+77/
2zIOhhAAjzb72Z6tKi3eHS6l+e35iLyzpvcPrNlSuUau0nB+QkBtcWHxa0Zkob4x
rQ5LRqtu1D76dZT/v8jcYhgjaCmAPfKCuy31gZBm7ezxnGi3JLh5nGN6OaMtYMoV
U7+XJPOcd1MezBHB+vIWRZ3KvpEpiBN7BiVAjogvUj6bXhchcOlTGTcI1Uc1XjQ2
JsB0a7N5VjI0tj1FAEtsmIY7tawA0AAzaZN/+CQQjOVarWFmG8w/1lOYMZLtY6o/
wtDMMwTTymKTUoJRlbGUS/HCQITcIu+xn+TbzZ4/hMR68Rtqvxb922fNavPpe16X
48h1MXKl38qfbEgX1HK/abwmBlTyA39FMLCCDlTYpZUBhEZl71ORdYoQFZdRXTKX
UVSviOhjqd9Hj+u+fT60x1qO3cr/l+9l9GRn/Ow9NtGOWb/wtw+t4qiFaC0i9HQ/
dSv2Rtemyc4U6pL74Tvk/ZqW9qMJ3Zvr6sNtyxx8FX84dmEQkTNgOueUn85puOvB
LNc4YYclgx0nrz50zz4rxyd24yjf/O4bI+hhmnmM7gFBd7GGkCEFvCM01B7ysOVU
j+nu8XDcYUvfW69XgqYUqudjZNSBB1yNUjjiZMKOPEim2bWhccyrmLfgjOQVVpYW
NVd5+wFUN1/oJbedwUb1zdMcrwtEoc3AJ/o03g59wse85LGbL7I=
=A5RY
-----END PGP SIGNATURE-----

--B7otR/Eb6YTSxL7p--
