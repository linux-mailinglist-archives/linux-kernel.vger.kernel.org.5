Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E457DB1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjJ3BAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3BAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:00:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E284BE;
        Sun, 29 Oct 2023 18:00:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso3888241b3a.2;
        Sun, 29 Oct 2023 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698627630; x=1699232430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yM3bj0rbBL/9ahZnFNJ1BZ/2B4Z9gVw0ViqgRvqDFxQ=;
        b=baEXbdapK+PD4FBEoo1iBpMr6AKWeed6pF4NVC+3t5cnAx+B5Z/mxkq3qbhxDotya2
         kbYK13fxtvLrH5g7TsxKt0TI3bIBnnvhFoVr09qoADoikkAwsPdmfov6Pxn1tUIaLsSY
         3YrRhcRL1U29xGSzl3JAWiikHLpCT+uI/T31tzxzIrXNDd9vgsR2hsYmqPuSz0sC9Yn1
         mdqNjutXqce8gMLRdgBeMNEj3dItUg8vY7X9NOnVaExtH9hb3zUsf50pVme8VyFb4oDF
         5jaIsGwVI4QOOwBDnhvKmM9MdU3Yj2a9J4yLTjyJv3XoUqOHCfj8Lft8VGzTynsjw3FH
         plIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698627630; x=1699232430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM3bj0rbBL/9ahZnFNJ1BZ/2B4Z9gVw0ViqgRvqDFxQ=;
        b=pKVN5FDdMLgZdjEcNkk2/i/MKDUWODSAfa7/hSgJO1yfDEhyYgyof4lpHCgkmJ9qkI
         kdQbJlCnRj+/6TQqzLokkTYIUsXZFwIYDGRloPDanKKUYzmHob8BUBfNmOxMmdEMnJvx
         iwpBCGhb4DYFWr44CO4rgTcQsIxTrvBgYRKUkLuSgnJhb/FymlVZqWNT8y/27bITN9oS
         wy1FcqrRhYl48gMD9i7H4EEGEmojv9/fN8xN5MC3swmFJnuBx/OLlVfM6jBcpEZNy73g
         qj4sDotx2c2BqBq6eNgqJZ3EQ0s9iFt3JxrXnjWNXPPFht6Bi8aArXvChJ8kfX6zo39O
         RuvQ==
X-Gm-Message-State: AOJu0YxoquOLGN0ks3nXFu653aYfg2q0bIpleK9TBzuHvt0sRmxfA3Zm
        VI0tWdyWpSyZUoiYQbN56b81YfZOfRw=
X-Google-Smtp-Source: AGHT+IGUEqwA9TfhXYwEcBKwZhJjsY5VNP/UOZLJZUM2YONqX1HnXpM02hmCNe0xrobBQa9jbHIixw==
X-Received: by 2002:a05:6a20:7d95:b0:169:cd02:65e9 with SMTP id v21-20020a056a207d9500b00169cd0265e9mr11792797pzj.33.1698627630397;
        Sun, 29 Oct 2023 18:00:30 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090ab88400b0027df6ff00eesm4360964pjr.19.2023.10.29.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 18:00:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 26FEE954130D; Mon, 30 Oct 2023 08:00:26 +0700 (WIB)
Date:   Mon, 30 Oct 2023 08:00:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ariel Miculas <amiculas@cisco.com>, linux-doc@vger.kernel.org
Cc:     serge@hallyn.com, Phillip Lougher <phillip@squashfs.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: filesystems: document the squashfs specific
 mount options
Message-ID: <ZT8AKXruPLR0oUIM@debian.me>
References: <20231029161924.50648-1-amiculas@cisco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4FtQT5HRz676trB8"
Content-Disposition: inline
In-Reply-To: <20231029161924.50648-1-amiculas@cisco.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4FtQT5HRz676trB8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 06:19:24PM +0200, Ariel Miculas wrote:
> +2.1 Mount options
> +-----------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +errors=3D%s              Specify whether squashfs errors trigger a kerne=
l panic
> +                       or not
> +
> +		       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                         continue  errors don't trigger a panic (default)
> +                            panic  trigger a panic when errors are encou=
ntered,
> +                                   similar to several other filesystems =
(e.g.
> +                                   btrfs, ext4, f2fs, GFS2, jfs, ntfs, u=
bifs)
> +
> +                                   This allows a kernel dump to be saved,
> +                                   useful for analyzing and debugging the
> +                                   corruption.
> +                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +threads=3D%s             Select the decompression mode or the number of =
threads
> +
> +                       If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set:
> +
> +		       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                           single  use single-threaded decompression (de=
fault)
> +
> +                                   Only one block (data or metadata) can=
 be
> +                                   decompressed at any one time. This li=
mits
> +                                   CPU and memory usage to a minimum, bu=
t it
> +                                   also gives poor performance on parall=
el I/O
> +                                   workloads when using multiple CPU mac=
hines
> +                                   due to waiting on decompressor availa=
bility.
> +                            multi  use up to two parallel decompressors =
per core
> +
> +                                   If you have a parallel I/O workload a=
nd your
> +                                   system has enough memory, using this =
option
> +                                   may improve overall I/O performance. =
It
> +                                   dynamically allocates decompressors o=
n a
> +                                   demand basis.
> +                           percpu  use a maximum of one decompressor per=
 core
> +
> +                                   It uses percpu variables to ensure
> +                                   decompression is load-balanced across=
 the
> +                                   cores.
> +                        1|2|3|...  configure the number of threads used =
for
> +                                   decompression
> +
> +                                   The upper limit is num_online_cpus() =
* 2.
> +                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +                       If SQUASHFS_CHOICE_DECOMP_BY_MOUNT is **not** set=
 and
> +                       SQUASHFS_DECOMP_MULTI is set:
> +
> +		       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                          2|3|...  configure the number of threads used =
for
> +                                   decompression
> +
> +                                   The upper limit is num_online_cpus() =
* 2.
> +                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--4FtQT5HRz676trB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZT8AIwAKCRD2uYlJVVFO
o5wjAQCsgbmSs7ucDXi9WqJ5A/Tf7HwOfCe7yWvzuqjkUcqcuAEArnipjFsP96Ve
bTHe4jPw2SCfz9icTUtm4UsAhcm6BA8=
=8P7/
-----END PGP SIGNATURE-----

--4FtQT5HRz676trB8--
