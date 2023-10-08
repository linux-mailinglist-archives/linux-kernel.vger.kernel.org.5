Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794907BD0BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbjJHWGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:06:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41ADAC;
        Sun,  8 Oct 2023 15:06:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC907C433C8;
        Sun,  8 Oct 2023 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696802812;
        bh=0pgaCqdeAC9oYqQwp+fAUXWfLCkTVfVj142U7LMJu84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0K1LsS9IXtU23mzJmfuhi6jxvIg8Plh0RLghOkBmWceExoHskC5FMPI6uqMcWB8v
         X51m1BBL8wZgwVXNTOUt6wNhzxzXHdPgwUb7qglsKpvmczVnW07APA/LNFGGxD/jOL
         Pr7lp51wRtBk3Il7rpgePvQDn0umhi1gv2vf/vekY95WHT3m2bIU9uRq333mXXqobL
         FYs1B3yE0wNNnK1b2JvqNsL3jnu2hqVjCX12r5nxFuHlxnneA5dXgPp6+WWQOXEpJ6
         ERVJesAPIfpVLpnB6AHeHqw2BHCoKbCJH8P8hGX91c2x7G44R4KCJnlOk4tvlR7I8o
         Uf0Sy1ay3yLyg==
Date:   Mon, 9 Oct 2023 00:06:48 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 4/5] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list
Message-ID: <ZSMn-H_BUmJMi9La@debian>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZX3Bwr4/cWeWkBvg"
Content-Disposition: inline
In-Reply-To: <20231003194547.2237424-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZX3Bwr4/cWeWkBvg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 00:06:48 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 4/5] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list

Hi Axel,

On Tue, Oct 03, 2023 at 12:45:46PM -0700, Axel Rasmussen wrote:
> The list of error codes in the man page was out of date with respect to
> the current state of the kernel. Some errors were partially /
> incorrectly described.
>=20
> Update the error code listing, so it matches the current state of the
> kernel, and correctly describes all the errors.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 2ee6a0532..95d69f773 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -388,12 +388,6 @@ On error, \-1 is returned and
>  .I errno
>  is set to indicate the error.
>  Possible errors include:
> -.\" FIXME Is the following error list correct?
> -.\"
> -.TP
> -.B EBUSY
> -A mapping in the specified range is registered with another
> -userfaultfd object.
>  .TP
>  .B EFAULT
>  .I argp
> @@ -408,21 +402,32 @@ field; or the
>  field was zero.
>  .TP
>  .B EINVAL
> -There is no mapping in the specified address range.
> -.TP
> -.B EINVAL
> +The specified address range was invalid.
> +More specifically,
> +no mapping exists in the given range,
> +or the mapping that exists there is invalid
> +(e.g. unsupported type of memory),
> +or the range values (

This produces some unwanted space.  Please apply the following fix to
your patch.

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 6e954e98c..795014794 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -432,11 +432,11 @@ .SS UFFDIO_REGISTER
 no mapping exists in the given range,
 or the mapping that exists there is invalid
 (e.g. unsupported type of memory),
-or the range values (
-.I range.start
+or the range values
+.IR ( range.start
 or
-.I range.len
-) are not multiples of the relevant page size,
+.IR range.len )
+are not multiples of the relevant page size,
 or
 .I range.len
 is zero.

>  .I range.start
>  or
>  .I range.len
> -is not a multiple of the system page size; or,
> +) are not multiples of the relevant page size,
> +or
>  .I range.len
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
> +.TP
> +.B EBUSY
> +A mapping in the specified range is registered with another
> +userfaultfd object.

Why would you move EBUSY to the end?  Do you see any reasons to order it
that way?

Thanks,
Alex

>  .SS UFFDIO_UNREGISTER
>  (Since Linux 4.3.)
>  Unregister a memory address range from userfaultfd.
> --=20
> 2.42.0.609.gbb76f46606-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--ZX3Bwr4/cWeWkBvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUjJ/gACgkQnowa+77/
2zJN7hAAm7wo2fbdDYvR3+ZwXtzAbAyd56Hr86xq4WlvzNVY8NMqnniq/PEi8f2P
yrYjeIoY6I2lIbHpM3Sh2GREALv6TfoIxaGd+6460sukgH0AxppnTjGZuv0U+rRm
C3leZZGuOAdvYeAnxIXnK9k4/35HM4KDfkTjh7hO0OvcuXU0e7UlYapm0A/cpAwM
zNBDIXgM9JL5nKKOWxFoMNCm5cK+NH9xqq0on0EYkbk5O3dJp7UXzRmjzbP+uNl1
2XVG5hdfwH8BMLxYjdqcNXl5t9rvcEMHdE2Om+c/M4FLvlsax0IE+wAV1WgPn7xm
J928Z0/a7wwIYqvZ9cM6gmqiD6wEgebQ4C2n4BAK/yMB0ukG21EZVPpiRhEvpmI0
LOYywyxxTI4a1VZxEka/lHBrCemWloylMADbMMtnm+V1ctRo4BHq71S8UheoqFQC
w2cHhYxPTCxRum1BgxAeTvTlCbYzYG7O2aEl3y7bNFWKvIKyCxs6e6OT5+o5nwoN
99YMdh8bkBkRk3dm7gvqzlhJYmJoVYj+yFzTXDq5oif/8zh9oB1qGzRIhNYj0/7T
2br7FdLGNMwlDW1maUKqqbRutvxdZOU5VD7DnlLPJgU11nqaDPQhueNp3aR2kTqS
cVaVUMoe/bg8gPRSx5YOSbMkE0R+Nwxo8/W3ywraMrCvih6l7aY=
=/Xp5
-----END PGP SIGNATURE-----

--ZX3Bwr4/cWeWkBvg--
