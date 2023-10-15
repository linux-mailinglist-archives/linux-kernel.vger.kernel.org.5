Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3677C9A86
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJOSAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 14:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 14:00:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB26AB;
        Sun, 15 Oct 2023 11:00:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A9FC43397;
        Sun, 15 Oct 2023 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697392832;
        bh=piHJs+ybB0MdD/qyJl2IOnZ75r2K0CHjvRZd1YpgqVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ER4bnpssTKFVdXZz70SBbEedenKnzzcs/yq32ZIkClASp+G8MDpHyKl4XN/xlXK8c
         oW8m3xk7/fG3+NC0bBQ0//SIgXXAsLT0iyMqMV32dOFF56bGSlCBI5UhRW+IUhhKdU
         2NcKvL0N6E73VYFMIRMtlEI+ffrHIiAyijQvkAHYu2cV6dyf9WwYbkcKKjnRbzl7F1
         l3kBlfRNinaIe0xeqAAPlQznYweo71o/AjPa/yxeCttrWidCba0WQ9WGu9wvzERNIv
         g8mZb3w+gU1npNtj+i5nCilsisiHEU1xiDdpuccCAGC2qTLBd51/ykE7s0Pr54EPgN
         cPmCD91cmH7Tw==
Date:   Sun, 15 Oct 2023 20:00:28 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] set_thread_area.2: Add C-SKY document
Message-ID: <ZSwovaEr5JLrZA6z@debian>
References: <20231015150732.1991997-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RQffCt7lJSAc+KXW"
Content-Disposition: inline
In-Reply-To: <20231015150732.1991997-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RQffCt7lJSAc+KXW
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Oct 2023 20:00:28 +0200
From: Alejandro Colomar <alx@kernel.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] set_thread_area.2: Add C-SKY document

Hi Guo,

On Sun, Oct 15, 2023 at 11:07:32AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> C-SKY only needs set_thread_area, no need for get_thread_area, the
> same as MIPS.
>=20
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---

Patch applied.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D1c4464ae2c40318b77e125961e24710d1784df5d>

Thanks!
Alex

>  man2/set_thread_area.2 | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/man2/set_thread_area.2 b/man2/set_thread_area.2
> index 02f65e0418f2..c43a92eb447a 100644
> --- a/man2/set_thread_area.2
> +++ b/man2/set_thread_area.2
> @@ -26,7 +26,7 @@ Standard C library
>  .B "int syscall(SYS_get_thread_area);"
>  .BI "int syscall(SYS_set_thread_area, unsigned long " tp );
>  .PP
> -.B #elif defined __mips__
> +.B #elif defined(__mips__ || defined __csky__)

I removed the parentheses here.

>  .PP
>  .BI "int syscall(SYS_set_thread_area, unsigned long " addr );
>  .PP
> @@ -42,17 +42,17 @@ These calls provide architecture-specific support for=
 a thread-local storage
>  implementation.
>  At the moment,
>  .BR set_thread_area ()
> -is available on m68k, MIPS, and x86 (both 32-bit and 64-bit variants);
> +is available on m68k, MIPS, C-SKY, and x86 (both 32-bit and 64-bit varia=
nts);
>  .BR get_thread_area ()
>  is available on m68k and x86.
>  .PP
> -On m68k and MIPS,
> +On m68k, MIPS and C-SKY,
>  .BR set_thread_area ()
>  allows storing an arbitrary pointer (provided in the
>  .B tp
>  argument on m68k and in the
>  .B addr
> -argument on MIPS)
> +argument on MIPS and C-SKY)
>  in the kernel data structure associated with the calling thread;
>  this pointer can later be retrieved using
>  .BR get_thread_area ()
> @@ -139,7 +139,7 @@ return 0 on success, and \-1 on failure, with
>  .I errno
>  set to indicate the error.
>  .PP
> -On MIPS and m68k,
> +On C-SKY, MIPS and m68k,
>  .BR set_thread_area ()
>  always returns 0.
>  On m68k,
> --=20
> 2.36.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--RQffCt7lJSAc+KXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUsKL0ACgkQnowa+77/
2zIdrhAAmxsnf5OdSwjwyyN4uq0JEjaj91iYRt8saR3EnhOWmUxjwESlXdXnx6xs
xagi7NIjtUrxZ+1x+lTIGRRm3GLjCXXxUlDWLcfu5vV4/Rika2xWbRmCQesK0JVv
FsLuI5nkTvRC9ljpErovPFwQEYITAs7u5cqHqxAK6f+Z0e9dlyhK7B1RW9XZ5X8b
XbmeTyVHv5jMGLdbhOnQyPHtke+KESarQKqhF1XgxvELKMYjIuiJi81zSPYJBUpf
zi+RYQMID2xfg3f8hgiweb3gK9oxgcmoxPTFNFD1VwnVnAdrG+rAGfAdwiQ153Az
CI0UuBk81/Y+Wljo6Wb9BkdHYv5bAE85AqW5wf0QNc0VW1wL6t9CsChrKy3xEA+Z
935Tme4iYXoC+b0ruVoGEcBr6UA6voulQWoink6CxiiutfQpCUh5/2YL7a0okNEb
KelJvtR0/bGctfc3qxHOySZk8YQnvSxZrkZNvr+LeZD4qas4sfdfMIu+Zug03BSj
ljCAa9s8f4TF+iPTo4nKDfeZXvsfLUi0g7Xb2rXsgdrgRoMnuTKrIdTS/Oy/a83H
gahmve/umFqBcWgta4frJ70T82jdCjkd8WWb04xJZZRH0w2YyawM+YNYVVrfzBQB
uiLlkjaoDeHqUHp/dGoLnmf+/kGs3yPJ6q3ervdZ9jNbZgGOq2w=
=af27
-----END PGP SIGNATURE-----

--RQffCt7lJSAc+KXW--
