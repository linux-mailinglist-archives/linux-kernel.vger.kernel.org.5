Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851337CD0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjJQXYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjJQXYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:24:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859E10C4;
        Tue, 17 Oct 2023 16:23:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE3BC433C8;
        Tue, 17 Oct 2023 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697585030;
        bh=qN2ECKk/Cxny8jJMFG/9Fq46QS+Q6UKOKWNC96Q0tdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STwpUSkGknWcmTQ0Ye9D79+LBBNd2KWCDK8vBqmq+OOe0v3ZFC/+SyBt6WE5BoC3G
         kn1a1/JvL6PQdMzqIX8HMZcFCX7a7eBDnQ3zwYWoVMBKVDrjrZhcngcjFynYSGfcXS
         77k9vlQQDoQDTnP1tvlrZG5lv6E9xt0BIBIFdLMZ/pxOYscDedtBJ04QYzWvH236p/
         qCl+GHIQGbZijukhcObO2QXP0tfLSrGCiengsytaGlZUoUHaiRvH7SAJSmlnJcjIkn
         nwKaH4j/lutkv4UlHuOf6a/9i+4UqkIAIdP0E0M73jnakugD/zSFQ+QGWCa1MutCgK
         2k0d76TTPtDzw==
Date:   Wed, 18 Oct 2023 01:23:46 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list
Message-ID: <ZS8XglFnkdMdILaw@debian>
References: <20231017230110.3170850-1-axelrasmussen@google.com>
 <20231017230110.3170850-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1zR/LIJPaF8GvZmk"
Content-Disposition: inline
In-Reply-To: <20231017230110.3170850-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1zR/LIJPaF8GvZmk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2023 01:23:46 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-man@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list

Hi Axel, Mike,

On Tue, Oct 17, 2023 at 04:01:09PM -0700, Axel Rasmussen wrote:
> The list of error codes in the man page was out of date with respect to
> the current state of the kernel. Some errors were partially /
> incorrectly described.
>=20
> Update the error code listing, so it matches the current state of the
> kernel, and correctly describes all the errors.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

I'll wait a bit before applying this one, in case Mike (or Peter) want
to review it.

The other two, you can find them here, as usual:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D9ae03d21383151794b118ac8dd98b4d6e26c9689>
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D5f1acc81e55540d1276977e66d64649c6ca7b58b>

And BTW, while running `make lint build check`, I caught some accidents
=66rom a previous patch from yours:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Dbf8647d1d82205934776b474fe89e5f30e03ad25>

Cheers,
Alex

> ---
>  man2/ioctl_userfaultfd.2 | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 82aee667c..40528001e 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -413,8 +413,6 @@ On error, \-1 is returned and
>  .I errno
>  is set to indicate the error.
>  Possible errors include:
> -.\" FIXME Is the following error list correct?
> -.\"
>  .TP
>  .B EBUSY
>  A mapping in the specified range is registered with another
> @@ -433,21 +431,28 @@ field; or the
>  field was zero.
>  .TP
>  .B EINVAL
> -There is no mapping in the specified address range.
> -.TP
> -.B EINVAL
> -.I range.start
> +The specified address range was invalid.
> +More specifically,
> +no mapping exists in the given range,
> +or the mapping that exists there is invalid
> +(e.g. unsupported type of memory),
> +or the range values
> +.RI ( range.start
> +or
> +.IR range.len )
> +are not multiples of the relevant page size,
>  or
>  .I range.len
> -is not a multiple of the system page size; or,
> -.I range.len
> -is zero; or these fields are otherwise invalid.
> +is zero.
>  .TP
> -.B EINVAL
> -There as an incompatible mapping in the specified address range.
> -.\" Mike Rapoport:
> -.\" ENOMEM if the process is exiting and the
> -.\" mm_struct has gone by the time userfault grabs it.
> +.B ENOMEM
> +The process is exiting,
> +and its address space has already been torn down
> +when userfaultfd attempts to reference it.
> +.TP
> +.B EPERM
> +The userfaultfd would allow writing to a file backing the mapping,
> +but the calling process lacks such write permissions.
>  .SS UFFDIO_UNREGISTER
>  (Since Linux 4.3.)
>  Unregister a memory address range from userfaultfd.
> --=20
> 2.42.0.655.g421f12c284-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--1zR/LIJPaF8GvZmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUvF4IACgkQnowa+77/
2zIhGA/+MK4uCVY4B5Pzdede4hVOluo1X1mpyfxn13Sn2XIsl5HK7Ofu/Z6tlZIQ
NmSG9z0BdvmwzhfWP5dkE9s/bRayn8mIr0i1F0GmqH7jBzgLSkPDSg12+lJ5Vikw
30bT5APaUTG/SWQtsgNkqksJfBB6r+x4Mp9FllryxvbKsNxDJn6tXyuARSrlLhlt
tPPzjSm6S9ZPytyZPHkQKpzKIUNqalx20VWiLhXiuw2zL3ags3DNyyg3tvnOG7yS
4sVpxI/pm9ch+I+PPJCnXIwVO+20kG7NZqOso1Uuny2gQ1/Nk5XmhgXos9KmrIhM
GUcZ2ZJ/4JlOX5ISOF3uGMxknRyqCqM6MrH6rFH46Hmvct1ZPoyLCsqkhctxvc1b
Rb/YWk9y+1cnVPJCsVLz3VwWAOrtCKwr+xUO+Upjy+KDX7k50MkdRpUNsHmtAH7n
Bpkj57JWfsUUsZTxy+2KwPRNdp+KuG5W3/iUestIw/6wXEVA3DKHfF0+or9lQwkf
tIiaNbqH3+i9vJ1pyyuXZTrKYFzzdharCJTs8ZbIvva9i0HQSy0kfYnc1laPabGg
vlgMMJaLG+ZkafWe8LYTmUJmrawaegkwA2rxhdgyNZ09NPCMrcLCW7yEKnQXA3+s
F2rTVrizUtVYWyQa4gvfntyuW4VQL2RyKwQcvSFmfUp7le3FdQQ=
=irXp
-----END PGP SIGNATURE-----

--1zR/LIJPaF8GvZmk--
