Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54847BD0E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbjJHWZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344789AbjJHWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:25:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4A9B9;
        Sun,  8 Oct 2023 15:25:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FBEC433C7;
        Sun,  8 Oct 2023 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696803948;
        bh=QrkuFelQkgF4dmVeOtjNdhlzBMRjrCcoF4SOVif4oIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXvXe2g3qldchM8UvdGuaMQL0oYBVvRQCvD0QUHj6Li4OR/OXp00Cs7Cq/q3Yx0OQ
         3tFhu+8VHTqsXUTjOwe2RiKkmnHKjXDsGrmK4jm/P19/I+LEvJcBhbvB0NL9Uqx+E5
         MFRY+XIRejnrU6x9805L1AT0puETUp3t4hN19k5Hk5X6X0Whub8dxSfwNYVwqnD98q
         w4VUeDhE0/iVaUEEw/nH86v3j1gLaHl7KH2YTqQq73o/Q7DKxKlbKiN9FFCBlPiZlO
         1L0oGx2rM2lw2MTY6E0gMZWuNqYT3K2X2WEkC9+4ELMuq/+lHIcTLxGVRqMGIYMlFs
         Uo6Jof74j06jA==
Date:   Mon, 9 Oct 2023 00:25:44 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ioctl_userfaultfd.2: correct and update
 UFFDIO_API ioctl error codes
Message-ID: <ZSMsaC-GUVbvMM_9@debian>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xg0NzKVlmIEGA05n"
Content-Disposition: inline
In-Reply-To: <20231003194547.2237424-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xg0NzKVlmIEGA05n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 00:25:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ioctl_userfaultfd.2: correct and update
 UFFDIO_API ioctl error codes

Hi Axel,

On Tue, Oct 03, 2023 at 12:45:44PM -0700, Axel Rasmussen wrote:
> First, it is not correct that repeated UFFDIO_API calls result in
> EINVAL. This is true *if both calls enable features*, but in the case
> where we're doing a two-step feature detection handshake, the kernel
> explicitly expects 2 calls (one with no features set). So, correct this
> description.
>=20
> Then, some new error cases have been added to the kernel recently, and
> the man page wasn't updated to note these. So, add in descriptions of
> these new error cases.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Patch applied.

Thanks,
Alex

> ---
>  man2/ioctl_userfaultfd.2 | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index ef352a69d..28dd2fcdd 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -256,17 +256,31 @@ refers to an address that is outside the calling pr=
ocess's
>  accessible address space.
>  .TP
>  .B EINVAL
> -The userfaultfd has already been enabled by a previous
> -.B UFFDIO_API
> -operation.
> -.TP
> -.B EINVAL
>  The API version requested in the
>  .I api
>  field is not supported by this kernel, or the
>  .I features
>  field passed to the kernel includes feature bits that are not supported
>  by the current kernel version.
> +.TP
> +.B EINVAL
> +A previous
> +.B UFFDIO_API
> +call already enabled one or more features for this userfaultfd.
> +Calling
> +.B UFFDIO_API
> +twice,
> +the first time with no features set,
> +is explicitly allowed
> +as per the two-step feature detection handshake.
> +.TP
> +.B EPERM
> +The
> +.B UFFD_FEATURE_EVENT_FORK
> +feature was enabled,
> +but the calling process doesn't have the
> +.B CAP_SYS_PTRACE
> +capability.
>  .\" FIXME In the above error case, the returned 'uffdio_api' structure is
>  .\" zeroed out. Why is this done? This should be explained in the manual=
 page.
>  .\"
> --=20
> 2.42.0.609.gbb76f46606-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--Xg0NzKVlmIEGA05n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUjLGgACgkQnowa+77/
2zJlIA//Y16WCTGtmYOnY6FKmX5w6ECWQE1OpB05FcYSRYBUlIhAwfgcBRWQ3ZWZ
ji+X7zzEQlrziC4hoKmbhiTq26Zvc8cighajyi5xKiAPou3shriMHJLMybRncB0b
nzE8eZPc+1M64tE3iJop7Kdh8We3uVvIrXDaeWNCwhLGUlfFdE9GhJaiY37tWmGj
lkCnXitB9lelweX7feZm+aOy/LKa8AW9jcNdn9s9vrLvUmOPcaH+AWOr5vfz4/4q
R2iI/zWou7GElOvNYMkXwZ3KKhH5UpVe/KzKPADo98H7dLOug/D685bFimRWTC6Q
jaOxMS5iTr1dFZHBj+c4V2RWBcrGspFLiCpTwnMOJAn1iATupofHDqPdrVgmkULr
M1jiel4faoHdzTA8eKlNeEEs0FSB2UIioR9fkbB6v9ts7+tSLI4M8TjqvLhG03g4
gNeZ1AsFgJH+bgAhA53ZPSTGVLNiiv91zawY5/inkuOrGU5v7RgJHUCkHGX0j2zD
Y8egedLm0hc4WYOCaSWnO1gtFE6KLJZjWc/4PNSJFTQf76iocBx3jpfhDWXLUfAf
phlmVOsVwMoYEQx3xPdk7rByO/8h4B3rLPP6g0cIr/54oPWKs6G6kfUU2zCnizx+
diSwyLdB5OBV/p9ejJJyHFsBAbhHMtjZnKqyj+JllYCZ4J/j19U=
=elyF
-----END PGP SIGNATURE-----

--Xg0NzKVlmIEGA05n--
