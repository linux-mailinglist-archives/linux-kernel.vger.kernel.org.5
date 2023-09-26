Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E9E7AEC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjIZMB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:01:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA813DE;
        Tue, 26 Sep 2023 05:01:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA6C433C7;
        Tue, 26 Sep 2023 12:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695729680;
        bh=Uim1u3XxEo9b1nioZ+X62vmG9tsbAzH8qfFqw7qnGTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJ0PlzYdw442sQkc5VJTLS80QN9jJpgjdNJaddeEIrg3C2Sz8OARoueRt+6SMRueb
         yBchjj77SvMjTj4Se2h79iGcprtGdsONEtcrXpW6eAKPe5bbRdZMVQff3jITcJtEc2
         VQMlcLdDDGlRV1au5WWgJPJcWdB74IA1gG0N8adlecKz2OVh0jTysubg52T9f30kiQ
         6/YTc0tYCMgEM5vx3S5F9EYbLvJmBtexoNEFCCJczIi6g69tb/wH+AwUQb5LHf7FXC
         qZ7ihK7GsNTndT8eK7tU3VcP0qJT9Jcz0jybqvYluZ498GsoYIHNuWO7rqpziVotPi
         TgbbRbAOHhb0w==
Date:   Tue, 26 Sep 2023 14:01:16 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     linux-man@vger.kernel.org, brauner@kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH] man2/splice.2: document SPLICE_F_NOWAIT
Message-ID: <hq2223k3kdclg2i2ozwtw37yvtwnxwrw3ns4op4fkh76x3fz47@2frhfofkwzay>
References: <20230926070402.2452760-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="63e2vf4d5pezjcq2"
Content-Disposition: inline
In-Reply-To: <20230926070402.2452760-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--63e2vf4d5pezjcq2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] man2/splice.2: document SPLICE_F_NOWAIT
MIME-Version: 1.0

Hi Max,

On Tue, Sep 26, 2023 at 09:04:02AM +0200, Max Kellermann wrote:
> Patch for SPLICE_F_NOWAIT submitted to LKML:
>  https://lore.kernel.org/lkml/20230926063609.2451260-1-max.kellermann@ion=
os.com/
>=20
> In the HISTORY section, I declared Linux 6.7 as the first version to
> have this feature, but this is only speculation, because
> SPLICE_F_NOWAIT is still under discussion and has not yet been merged.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Please find some formatting issues below.

Cheers,
Alex

> ---
>  man2/splice.2 | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/man2/splice.2 b/man2/splice.2
> index e9a18e668..1e686b858 100644
> --- a/man2/splice.2
> +++ b/man2/splice.2
> @@ -89,13 +89,27 @@ call);
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

=2EBR EAGAIN .

> +This is analogous to the
> +.B RWF_NOWAIT
> +flag of
> +.BR preadv2()

=2EBR preadv2 ().

> +.
>  .TP
>  .B SPLICE_F_MORE
>  More data will be coming in a subsequent splice.
> @@ -138,6 +152,8 @@ is set to indicate the error.
>  .TP
>  .B EAGAIN
>  .B SPLICE_F_NONBLOCK
> +or
> +.B SPLICE_F_NOWAIT
>  was specified in
>  .I flags
>  or one of the file descriptors had been marked as nonblocking
> @@ -192,6 +208,9 @@ was required to be a pipe.
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

--63e2vf4d5pezjcq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSyAwACgkQnowa+77/
2zI3xw/9H9V6+vU/dq5hmfWLn7eM9CAUn7VoZkUoFwxUcY1j0gwBOjiFiV8cLxye
hz5Fzld5Px4pCpoNMgAo6Ue/rmMhtkpN3GJ3/j8A1QxRHXnqYtsBv296pbkNgmN8
6fwm4zcv8QLmXgqJsNxEz5zW2UjOsHmUaIio17NWfPNHI2MaZnNpBr7SUTMAGxUB
Cbv31gE3d/+6469uF8Qo1Z/UB04YlbV3AhlMfFYPQDBfA8w+UFzqjLKNw9m1Jvpl
ti2UPeXRe7Q/BR0cwhT6TJ/3+Ehy9O6YLO8UYt4LJ1Bs9CWEo+9QfGavwz3OfR7T
mo2rdp28DcVWp5aVdSdem6+ewx71pYL9w80vPoMpZrv87xGT+Lf5gwgqdIVOeNg7
GeOMXCmzsaZBJpn0x+swizGbBduyrTRDdmMFaUHUFwhzXshwXbQO8JGUQznDNL1V
iZdfgu9RMNjONvi8m++cM4sIiE1OsgT+Aj8cLUOjiPi5SCRPt/T1UmzL78BKDljY
QraeNEgxG8YvMzlqsB1q1d6gRNcvP4qhWSAh3mvWn4Tz8kcSSWioNk/PspdMUu/d
rWyZL5rerJEIzp4TtlMT0WeMouSghGcsNzJR2QF7Fa9JCLfzzVU7HMZLCoXaEJQf
ERgu9XQOQpBmblWI2wULErHHuFjLRprEllHme8VvQgFnOIeBdOQ=
=n2Sj
-----END PGP SIGNATURE-----

--63e2vf4d5pezjcq2--
