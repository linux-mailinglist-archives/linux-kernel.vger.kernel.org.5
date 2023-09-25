Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427117AE2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjIYXu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjIYXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:50:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ABBCD4;
        Mon, 25 Sep 2023 16:50:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052A6C433C7;
        Mon, 25 Sep 2023 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695685810;
        bh=ssvRcYJRbvcBMwmXbSD5F1sToCHWJRiM/v4IspFc1LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9Bo/yI7d/Y+3iaOC0FmpbSUs5mfLVWWByKDGW8mSSurOYXek9ZHvcxuWd03BA80t
         Z/yXBGU7tkILaRTXrMGZZXuTHeeTnimx0Bjbg4MIyFMYlmIS39WbJBs/rzri/D54YT
         e/uFqiGYm0TTnBhixhuOvme8Df+PEAEefJf+LSOul+Qo2XC6vknrgMNM5lqmJG108J
         hs4NFSV0LOXlK4LUyOfbXWZEFfDwrfqXPCsXe/q7hhnivoYBKYEuKVq2Ikn9sgkYXE
         KgRvox2P4IDkItuvf2Ecc6FSxnoI+l0UjyubrS1ntxluEt0IrUQbelzLZA+ke5ac5B
         tjCh2V1+WDkzQ==
Date:   Tue, 26 Sep 2023 01:50:06 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ioctl_userfaultfd.2: describe missing UFFDIO_API
 feature flags
Message-ID: <4a6utza2kwlghdrgpoc2p56gfzwb4lwpp6rsqed4gaecvbfdxt@f2gw6c737te6>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cjrue5kcslvl7m5p"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-7-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cjrue5kcslvl7m5p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/10] ioctl_userfaultfd.2: describe missing UFFDIO_API
 feature flags
MIME-Version: 1.0

On Tue, Sep 19, 2023 at 12:02:02PM -0700, Axel Rasmussen wrote:
> Several new features have been added to the kernel recently, and the man
> page wasn't updated to describe these new features. So, add in
> descriptions of any missing features.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---

Patch applied.

Thanks,
Alex

>  man2/ioctl_userfaultfd.2 | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index e91a1dfc8..53b1f473f 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -204,6 +204,13 @@ If this feature bit is set,
>  .I uffd_msg.pagefault.feat.ptid
>  will be set to the faulted thread ID for each page-fault message.
>  .TP
> +.BR UFFD_FEATURE_PAGEFAULT_FLAG_WP " (since Linux 5.10)"
> +If this feature bit is set,
> +userfaultfd supports write-protect faults
> +for anonymous memory.
> +(Note that shmem / hugetlbfs support
> +is indicated by a separate feature.)
> +.TP
>  .BR UFFD_FEATURE_MINOR_HUGETLBFS " (since Linux 5.13)"
>  If this feature bit is set,
>  the kernel supports registering userfaultfd ranges
> @@ -221,6 +228,22 @@ will be set to the exact page-fault address that was=
 reported by the hardware,
>  and will not mask the offset within the page.
>  Note that old Linux versions might indicate the exact address as well,
>  even though the feature bit is not set.
> +.TP
> +.BR UFFD_FEATURE_WP_HUGETLBFS_SHMEM " (since Linux 5.19)"
> +If this feature bit is set,
> +userfaultfd supports write-protect faults
> +for hugetlbfs and shmem / tmpfs memory.
> +.TP
> +.BR UFFD_FEATURE_WP_UNPOPULATED " (since Linux 6.4)"
> +If this feature bit is set,
> +the kernel will handle anonymous memory the same way as file memory,
> +by allowing the user to write-protect unpopulated ptes.
> +.TP
> +.BR UFFD_FEATURE_POISON " (since Linux 6.6)"
> +If this feature bit is set,
> +the kernel supports resolving faults with the
> +.B UFFDIO_POISON
> +ioctl.
>  .PP
>  The returned
>  .I ioctls
> --=20
> 2.42.0.459.ge4e396fd5e-goog
>=20

--cjrue5kcslvl7m5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSHK4ACgkQnowa+77/
2zKijg//Y70CRLE5sfeTvnRPNP9o+9cOLE60z1NZTTXAVlvBpJM6ag1S6Hivd/lQ
KBq3W7eOZEA5k04InXcQhLaTcuf+eeBCNgRz9oIeUvuy6yNbjo47NKT/ojX381zq
j8dq6LzhPdHAJB4jmYiZJS5FAvGEOBdIzLQ0dxJPk1i2BEcLfnqOKQ0dU7g8BB6S
mpEduHSlxKciyWOQNvOcl2oMsSqFDWbICejaov8zYdruEIWXS7nSJOTI3lLlYcKF
YiHTLc0J0SAv00F3uygTRASFR9FQt3xzlY6ponV4JKp0LIxMMQz/U24mTM6p8wF2
zpdyuckSc5IUpr5z0iVbSSWRZb5fy1Ky5xZtsTXK9ghcSEiAvt73VZRbR6zvAtg4
3WWcJSgYCvBQYA+gCWBLq+3C/RER0MFO8GCv1gXSWZ4KoBQtnwS5MYJSm+sUwj1U
BXk4Bm8EUATI1VcpJmQg5bgkyKG8kLzO9L0ONYVULBYgiYceEU2yTgXlzNGHVW4A
8OWNsqoB+AmSTuUUWcQNe1cZNz3aB/SZs0J95Zi8CntwcMCqtQBkumNY1aNJC1fQ
xR9ZEHeq5PtR5jpXQYK0YovY4MO5bTCJHM9Eig+37xMOM1q2pdx9u0nWCILsfGV7
VrdWUt+3QckgLnRRnvITNa67CQ05C2wKmSaGzrnN+WeKswqfSVQ=
=u08m
-----END PGP SIGNATURE-----

--cjrue5kcslvl7m5p--
