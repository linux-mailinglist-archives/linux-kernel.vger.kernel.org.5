Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B97AE289
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjIYXiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjIYXiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:38:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1D116;
        Mon, 25 Sep 2023 16:38:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D9BC433C8;
        Mon, 25 Sep 2023 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695685082;
        bh=O205pMaIZFX+IR8T15rQWZacKabki5WR2NjlY+l6r5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVsIQtynqPYGfJ74Hj5ksmkMzU1K/gDiRxQ5DLIVvR4CE2yXDwSgOFm7UssP8H8x5
         +G9UNuUwrHhhCUvBTxIO7CVsFcT0hCgsw5v0FYaJQ9gNyq8wBBXYi18I6wRRTKMqsz
         XB+rAEDdQbMOeHdzdqXv/E+IiJglWMsBwNKhO5t0wt4jNa54f+n6HyxM+8qvDGrbpw
         6OXtC7druCMKsXLTanJyAqdCmyUgpUvjVcXIyx1UuRfh2h3G8ptlj8OJTZiMvKxdbT
         JOagx6UCY70sA+E9GyP+V4KQj5XhABibYbcbX5kapl1XpOnxxka7n5kLXGJJwOFyMu
         1GgrwW8/oXERg==
Date:   Tue, 26 Sep 2023 01:37:58 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] ioctl_userfaultfd.2: fix a few trivial mistakes
Message-ID: <fn2nopit4w4gu26ysqzffzobukvlvj77adykh5ythobk6rcljb@sdfwmlzpnf2f>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7vgy4blmhwfscbm4"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7vgy4blmhwfscbm4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/10] ioctl_userfaultfd.2: fix a few trivial mistakes
MIME-Version: 1.0

On Tue, Sep 19, 2023 at 12:02:00PM -0700, Axel Rasmussen wrote:
> - Fix missing paragraph tag. The lack of this tag yielded no blank line
>   in the rendere dpage, which is inconsistent with style elsewhere.
>=20
> - The description of UFFDIO_WRITEPROTECT was a sentence fragment; the
>   last half of the sentence was left out by mistake. Add it in to fix
>   the issue.
>=20
> - move UFFDIO_WRITEPROTECT 'since' to its own line All other ioctls
>   note the kernel version introduced on a separate line from the ioctl
>   name. Update UFFDIO_WRITEPROTECT to match the existing style.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---

Patch applied.

Thanks,
Alex

>  man2/ioctl_userfaultfd.2 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index b5281ec4c..339adf8fe 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -31,6 +31,7 @@ using calls of the form:
>  ioctl(fd, cmd, argp);
>  .EE
>  .in
> +.PP
>  In the above,
>  .I fd
>  is a file descriptor referring to a userfaultfd object,
> @@ -351,6 +352,7 @@ operation is supported.
>  .B 1 << _UFFDIO_WRITEPROTECT
>  The
>  .B UFFDIO_WRITEPROTECT
> +operation is supported.
>  .TP
>  .B 1 << _UFFDIO_ZEROPAGE
>  The
> @@ -693,7 +695,8 @@ field of the
>  structure was not a multiple of the system page size; or
>  .I len
>  was zero; or the specified range was otherwise invalid.
> -.SS UFFDIO_WRITEPROTECT (Since Linux 5.7)
> +.SS UFFDIO_WRITEPROTECT
> +(Since Linux 5.7.)
>  Write-protect or write-unprotect a userfaultfd-registered memory range
>  registered with mode
>  .BR UFFDIO_REGISTER_MODE_WP .
> --=20
> 2.42.0.459.ge4e396fd5e-goog
>=20

--7vgy4blmhwfscbm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSGdYACgkQnowa+77/
2zK1TA/0DhG5yr7StwFzK4NjnJiDDw+3oacXTZgx6sa0kYYJDqe3o0Bb5SosjsGE
ltXNDkCkF+0PaUc85M4zaqpuLtQk/1dYDcn8ySRkl4smkbNhrWd6Bl/2RZc+uUJI
KHob3h7Ilt/NIoDuHQBnjleuFrQHQ1ofUZ5RSq5BRyn7JFmTu3Unls8bHWMu+YE/
X8knCMHGQbKm0Y6u9QhMB8rOgUM967n9tV+0i201XmFYkqInb6cbVr0xNCfDRl8m
paC6fGbhxeyqDxpSbJi6xa3d4/PZ1PTl7XxuUC3fTCkx6t2r27UVLeWcb5r4fTV7
zV1+tg+dnFxJYyO4LTQCgDYA8jUKjWCmebkXg5MHUB/XXwFxWZk78TNNCgIf/poj
weGXn8XbJamFujFPzhAlNlNC07zZPWsHgo5wusxilBFEw2TwmxLxJZjTQmOS3K4c
RIbxD5ALLiOPYEfasYOZkMLxtLIiXHAwuG8Z5Wj3Lu0HaTkJy7D2fMxtATIcmQ5R
SMhT6QvoT1GtJNn2zGJ3McSwFkK356ECwocQuUp+MTRnSX/OxAQ3raf/VlNhujOA
MQMSo6jQdIh4/Rt2HRHgKK+ql7O2FwyTVB2Iw5jiu/NssYokU6qzUq+xZID979ib
4dGcxnIv9+ChW2xfaEA0Kd25ODId3Iiz/qYHcOldYym1txp+Eg==
=x8ug
-----END PGP SIGNATURE-----

--7vgy4blmhwfscbm4--
