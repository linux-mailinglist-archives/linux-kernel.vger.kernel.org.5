Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB07B02F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjI0L3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjI0L33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:29:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2512FF3;
        Wed, 27 Sep 2023 04:29:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFE2C433C8;
        Wed, 27 Sep 2023 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695814167;
        bh=UyhTf+WxTHqj+BId15bKhzPOMMpXRo5MRgMrwKeWdrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWC/7EoEoKMVgvQ/C1k949L/W4UvaYESeuNPqwv8PIs/O1sa30qvwNy4+4wH5RHrn
         rXCDSNCBjYJE+fSKQORaJlXVMNMaTYuxAna9jVSW0PqQadd4xRLqBxvNRu4GdYj5aQ
         xfYq3Q17QTE2ysP+F3XdPozVqtsQDfT90ONTPsj6M3SFVnSZ2U+O0cH70bOVJdxfkr
         hzmA+zE3tGhdrmxfQxEOuKTifNUCf6NSLd7nbxeRYS+Jbc6dQYk4OVedvC1A5ed8Xs
         SB1g4uQM0msEIiwvZ1TcThkc/KJrUO8bBzZ1/G8DaVvb5yxxhZ/Ka96wM8wPmZkEug
         5vEOMz/Lc3Mcw==
Date:   Wed, 27 Sep 2023 13:29:23 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     linux-man@vger.kernel.org, brauner@kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v2] man2/splice.2: document SPLICE_F_NOWAIT
Message-ID: <zt5lslryl7gr6qvuahpuziodcvh3rd6qw5pbxx2m6rinmn6yrz@xt46qxmtknen>
References: <hq2223k3kdclg2i2ozwtw37yvtwnxwrw3ns4op4fkh76x3fz47@2frhfofkwzay>
 <20230926134339.2919289-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="du3gk64fs5h5i6jq"
Content-Disposition: inline
In-Reply-To: <20230926134339.2919289-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--du3gk64fs5h5i6jq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] man2/splice.2: document SPLICE_F_NOWAIT
MIME-Version: 1.0

Hi Max,

On Tue, Sep 26, 2023 at 03:43:39PM +0200, Max Kellermann wrote:
> Patch for SPLICE_F_NOWAIT submitted to LKML:
>  https://lore.kernel.org/lkml/20230926063609.2451260-1-max.kellermann@ion=
os.com/
>=20
> In the HISTORY section, I declared Linux 6.7 as the first version to
> have this feature, but this is only speculation, because
> SPLICE_F_NOWAIT is still under discussion and has not yet been merged.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Thanks for the patch.  It LGTM.  Please ping when the kernel patch is
merged or something.

Thanks,
Alex

> ---
>  man2/splice.2 | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/man2/splice.2 b/man2/splice.2
> index e9a18e668..a07c001ac 100644
> --- a/man2/splice.2
> +++ b/man2/splice.2
> @@ -89,13 +89,26 @@ call);
>  in the future, a correct implementation may be restored.
>  .TP
>  .B SPLICE_F_NONBLOCK
> -Do not block on I/O.
> +Do not block on I/O on pipes.
>  This makes the splice pipe operations nonblocking, but
>  .BR splice ()
>  may nevertheless block because the file descriptors that
>  are spliced to/from may block (unless they have the
>  .B O_NONBLOCK
> -flag set).
> +flag set or
> +.B SPLICE_F_NOWAIT
> +is specified).
> +.TP
> +.B SPLICE_F_NOWAIT
> +If no data is immediately available on
> +.I fd_in
> +and it is not a pipe, do not wait (e.g. for backing storage or locks),
> +but return immediately with
> +.B EAGAIN.
> +This is analogous to the
> +.B RWF_NOWAIT
> +flag of
> +.BR preadv2 ().
>  .TP
>  .B SPLICE_F_MORE
>  More data will be coming in a subsequent splice.
> @@ -138,6 +151,8 @@ is set to indicate the error.
>  .TP
>  .B EAGAIN
>  .B SPLICE_F_NONBLOCK
> +or
> +.B SPLICE_F_NOWAIT
>  was specified in
>  .I flags
>  or one of the file descriptors had been marked as nonblocking
> @@ -192,6 +207,9 @@ was required to be a pipe.
>  Since Linux 2.6.31,
>  .\" commit 7c77f0b3f9208c339a4b40737bb2cb0f0319bb8d
>  both arguments may refer to pipes.
> +.PP
> +.B SPLICE_F_NOWAIT
> +was added in Linux 6.7.
>  .SH NOTES
>  The three system calls
>  .BR splice (),
> --=20
> 2.39.2
>=20

--du3gk64fs5h5i6jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUUEhMACgkQnowa+77/
2zLiXg//fTK72X+xAq/qsIkW/9tkOcu7G3VR6OklYNJmKteLxlYRsPbaQu/bOmhB
8rcfLMGY2nJb+zVCom1GEBYurqIZX1EhNhHdCPvs4XN0/PaglBMt/eonQRbLfLE+
WWFX6bKrz8/u3nPCRR5/qL+HEp3ari5Ge8Ff8cdUbrFH3Gc+73WcKMdi64WtlPeA
/RyWlwZKGOOFwhFVf6sFB2QxxA745r2f4js/FipeH9Kn0jIl7uXv4+AOPBY8vDdi
I4MAhZZo9EDNC83UFh3jcs/Tbh6n9mAvzz/hoE+z+v6SNcSIjcXhXNq0Sm7omn3G
ZyP44qQbe6wO92LA6X+aZyVyYCOMtx4oIbfD75cGOlfzm1CD7SG2+VX1SE3ebLRK
P4k+9dFaEWG1hV8QGO8QTTCMnexqrYQIdT2p2RbYaIEmDaiswA2F4y1ENW38BQF9
F/CFSfuifG1JjZxmu+w9C5qWovR7wSTabBh3GdWAfXYUnNTrx3BsQXK/O0+tvqb4
/5/t3ioIKUVx1THkQKW4XkIOaO6T60+DaW7cKyh9vYBCj//JbEmp3HsxAxo1X6j/
j/z6M+NJrBKeMnKFV6lIYUrG+7v/MmIVvaVk/tzVAmLKDqgujM/9lZyAqXYK2h4I
xQAn6eT0NM+Jq8JcDlS8edzU/IEDK/UUYDbAwMD6i5tyLENzZHU=
=BP1p
-----END PGP SIGNATURE-----

--du3gk64fs5h5i6jq--
