Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FEA7CD052
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjJQXUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjJQXUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:20:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D7F5;
        Tue, 17 Oct 2023 16:20:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BF3C433C8;
        Tue, 17 Oct 2023 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697584820;
        bh=wNpEvk0qKh6nYz+ayWMmRr37IWRnGddjjXUD6ljHCLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSOouqGCnsYyQxPfXlyoccKal7pbNwsPT/wKZjjn7dOKycpjuKEPlv6vMBJVGi1+f
         gVdCvKXQbo22jDLeI4yt6j2Qj4dP0G2SWWZ9i3bpasM3igb4DYBfHwzMrR4OEmNLfb
         jgE1cG4Z8o9x1drp1mAN7/Kp7ClrwJGDUc9RdxvCEJNlH/S2FkNwEv1Y39otFMHH1d
         W3Q8eZHoZJmmIqa8yNRBodzAXAGMDmdNZTf/vBVGsPUlHm26Oyxp3QZwVzDZmRLRnk
         kBB14c0qSGbM+m9whuuLileWR7GYnr7aQAdkWydJGTbaYVkVxszYeyJZETch2Rccri
         zCBoKQAL7jnmg==
Date:   Wed, 18 Oct 2023 01:20:16 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ioctl_userfaultfd.2: document new UFFDIO_POISON
 ioctl
Message-ID: <ZS8WsKeeoBOLGy-B@debian>
References: <20231017230110.3170850-1-axelrasmussen@google.com>
 <20231017230110.3170850-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcjukqSUCbN9YfrY"
Content-Disposition: inline
In-Reply-To: <20231017230110.3170850-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gcjukqSUCbN9YfrY
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2023 01:20:16 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-man@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ioctl_userfaultfd.2: document new UFFDIO_POISON
 ioctl

On Tue, Oct 17, 2023 at 04:01:10PM -0700, Axel Rasmussen wrote:
> This is a new feature recently added to the kernel. So, document the new
> ioctl the same way we do other UFFDIO_* ioctls.
>=20
> Also note the corresponding new ioctl flag we can return in response to
> a UFFDIO_REGISTER call.
>=20
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks for the patch and the review.  Patch applied.

Cheers,
Alex

> ---
>  man2/ioctl_userfaultfd.2 | 124 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 118 insertions(+), 6 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 40528001e..a9131515c 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -405,6 +405,11 @@ operation is supported.
>  The
>  .B UFFDIO_CONTINUE
>  operation is supported.
> +.TP
> +.B 1 << _UFFDIO_POISON
> +The
> +.B UFFDIO_POISON
> +operation is supported.
>  .PP
>  This
>  .BR ioctl (2)
> @@ -886,6 +891,12 @@ does not equal the value that was specified in the
>  .I range.len
>  field.
>  .TP
> +.B EEXIST
> +One or more pages were already mapped in the given range.
> +.TP
> +.B EFAULT
> +No existing page could be found in the page cache for the given range.
> +.TP
>  .B EINVAL
>  Either
>  .I range.start
> @@ -900,9 +911,6 @@ An invalid bit was specified in the
>  .I mode
>  field.
>  .TP
> -.B EEXIST
> -One or more pages were already mapped in the given range.
> -.TP
>  .B ENOENT
>  The faulting process has changed its virtual memory layout simultaneousl=
y with
>  an outstanding
> @@ -912,14 +920,118 @@ operation.
>  .B ENOMEM
>  Allocating memory needed to setup the page table mappings failed.
>  .TP
> -.B EFAULT
> -No existing page could be found in the page cache for the given range.
> -.TP
>  .B ESRCH
>  The faulting process has exited at the time of a
>  .B UFFDIO_CONTINUE
>  operation.
>  .\"
> +.SS UFFDIO_POISON
> +(Since Linux 6.6.)
> +Mark an address range as "poisoned".
> +Future accesses to these addresses will raise a
> +.B SIGBUS
> +signal.
> +Unlike
> +.B MADV_HWPOISON
> +this works by installing page table entries,
> +rather than "really" poisoning the underlying physical pages.
> +This means it only affects this particular address space.
> +.PP
> +The
> +.I argp
> +argument is a pointer to a
> +.I uffdio_poison
> +structure as shown below:
> +.PP
> +.in +4n
> +.EX
> +struct uffdio_poison {
> +	struct uffdio_range range;
> +	                /* Range to install poison PTE markers in */
> +	__u64 mode;     /* Flags controlling the behavior of poison */
> +	__s64 updated;  /* Number of bytes poisoned, or negated error */
> +};
> +.EE
> +.in
> +.PP
> +The following value may be bitwise ORed in
> +.I mode
> +to change the behavior of the
> +.B UFFDIO_POISON
> +operation:
> +.TP
> +.B UFFDIO_POISON_MODE_DONTWAKE
> +Do not wake up the thread that waits for page-fault resolution.
> +.PP
> +The
> +.I updated
> +field is used by the kernel
> +to return the number of bytes that were actually poisoned,
> +or an error in the same manner as
> +.BR UFFDIO_COPY .
> +If the value returned in the
> +.I updated
> +field doesn't match the value that was specified in
> +.IR range.len ,
> +the operation fails with the error
> +.BR EAGAIN .
> +The
> +.I updated
> +field is output-only;
> +it is not read by the
> +.B UFFDIO_POISON
> +operation.
> +.PP
> +This
> +.BR ioctl (2)
> +operation returns 0 on success.
> +In this case,
> +the entire area was poisoned.
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.
> +Possible errors include:
> +.TP
> +.B EAGAIN
> +The number of bytes mapped
> +(i.e., the value returned in the
> +.I updated
> +field)
> +does not equal the value that was specified in the
> +.I range.len
> +field.
> +.TP
> +.B EINVAL
> +Either
> +.I range.start
> +or
> +.I range.len
> +was not a multiple of the system page size; or
> +.I range.len
> +was zero; or the range specified was invalid.
> +.TP
> +.B EINVAL
> +An invalid bit was specified in the
> +.I mode
> +field.
> +.TP
> +.B EEXIST
> +One or more pages were already mapped in the given range.
> +.TP
> +.B ENOENT
> +The faulting process has changed its virtual memory layout simultaneousl=
y with
> +an outstanding
> +.B UFFDIO_POISON
> +operation.
> +.TP
> +.B ENOMEM
> +Allocating memory for page table entries failed.
> +.TP
> +.B ESRCH
> +The faulting process has exited at the time of a
> +.B UFFDIO_POISON
> +operation.
> +.\"
>  .SH RETURN VALUE
>  See descriptions of the individual operations, above.
>  .SH ERRORS
> --=20
> 2.42.0.655.g421f12c284-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--gcjukqSUCbN9YfrY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUvFrAACgkQnowa+77/
2zLLSA//QJlLtyVG1VE2REu9OjkUgvej/adUPeZPOMBXUgGn4yCw2aaWA9vCcFAK
O0eC90Ju2qDw92q6vvVO7SVfuv9K28bM5rBLuD1Sku0uPArDeLsW940ujPmDAP6L
i5sXGv6iHqOK9nSC2xHELw15O9Gjds1hoaspujYqPI95FQ3lOkLUdz6c5TGqfh8H
VGVOR6/Pujcv1SaYWmqZtmhzBUAUea4TzEUi9ztpUe3AZTwXQlohhvB0dG364JJ3
H/sHlsKmXfQC8wdUoOzONY7npVr/vjIushM/rFiWAYJkNdau1PlXy2lOonHrze7z
819Qq3wSKdgYiuLCmMqgMDb3eCLmaEp8JbH9Gl5o4RBwcoss31JTiapYOLx7gHg3
Gbq4u9nJc6KHM6X/ELNVVh89Z2vTkWEWbKgrfO2e6Ku80oim4uy/wVse6ZCbJXk7
zxTtiLrGXhmGNyJK4oYHzGJRCxvKhFdTBhFGFdEWQtFGNxqynmXFxTaguKKpKg4h
OdDp81U6FIm3tBMGvlUttWTqAjawysrV6NnsFiEsSW0SNOD03lVELryP3X6/pn5x
X/TaT/ZQ2Z0OQiYFrJMr1d3m1h7lbBMhZJCBIFGwDckp92N/eJPkphg16izefv+T
RGVWa0Oj2b/5IEfO8DCGxeXmaXNmhqf6qWNYppC4GBP8tbAxaQg=
=bNM8
-----END PGP SIGNATURE-----

--gcjukqSUCbN9YfrY--
