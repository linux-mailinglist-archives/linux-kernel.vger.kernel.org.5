Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884AB7FD38E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjK2KF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjK2KF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:05:27 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D861FE5;
        Wed, 29 Nov 2023 02:05:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d011cdf562so6730985ad.2;
        Wed, 29 Nov 2023 02:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252328; x=1701857128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpQndnRiODx+tos8fdE4dhL+06RTmhorpUhO5hT0DMc=;
        b=dPw/5QnshuN0bjj9rRxZozm2OjLoTv3+NhOC3Y6n69Li/cGVn85hxrdeq9OM9qsxvE
         EaGdtdr+4R+9l6hcYFeDwo9/VKsxlGTCKoCb3tpMGeZbiU5Ebf3PkvibHHQj/A3tQXdW
         6ZANj429WFzckS+yyOQPIaVtN7dCaGKkXQ5R5OYkN+a6OcTOT645WowvsvDKQjrCyKXw
         4UamErNBaBPU1k2Fq2xIIFzL/IcuJxJDsKdZQjp6FEVApD7BUlg9xLjn2ZGT109/hy9J
         nFd1JeK/mChUPI2wlsuvzvMxfRue80texMI/XFbM9CVB67v/cQMe+auUA/ix1ahBtR02
         j0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252328; x=1701857128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpQndnRiODx+tos8fdE4dhL+06RTmhorpUhO5hT0DMc=;
        b=Eyw4K0ZdPEbX6dRD8Uhr+OYvMP+xEnSM7Lkq0gZWEDRe+t0/oeh7MzSoDZWS2jgEqU
         poIkOCXOJwF3pCCnppP2G6Wy5UzffGAoDNUfIb6NVoUoW8Q/fEm3PCoUaGfhlCgBuzg2
         Pn7YNTf0siYJFWWY5Cp1rE3ruP0IHbwB6ua52TbLTqxjzh1ybzUGy79eT6YGbhflWrd3
         rfr8gOx8pwToJXBDTROM1G4ISOCqqc0zdNCSbCko5fziwsqPj3obefhxd4y0wxhMEExG
         ydbzaf4TtKBvX9jcMI3O0knSsdlhHmKlszVkBCsFOnwvuaUVEgn10a1vmaf8+7/OK7AA
         6pAA==
X-Gm-Message-State: AOJu0Yz5Tnam9oXeT8OfVfeK7/BL1uh0EZo8HNbUm4jW5tYUAnwbP8HG
        4mdBJyy4EtDuFf3QrsTxi4U=
X-Google-Smtp-Source: AGHT+IFHz1EOBr29DpBEQyHQO01oqfVMNvqkP1ezQq262jWCjWECYCTqM2o+9jGXSDx+XO+Xey/PSw==
X-Received: by 2002:a17:902:f687:b0:1d0:e37:8c14 with SMTP id l7-20020a170902f68700b001d00e378c14mr3871818plg.34.1701252328212;
        Wed, 29 Nov 2023 02:05:28 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001cc131c65besm11862520plz.168.2023.11.29.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:05:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id C6DF71140D81A; Wed, 29 Nov 2023 16:58:36 +0700 (WIB)
Date:   Wed, 29 Nov 2023 16:58:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: btrfs: super.c:416:25: error: 'ret' undeclared (first use in
 this function); did you mean 'net'?
Message-ID: <ZWcLTJB8wrLUwuVf@archie.me>
References: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
 <ZWbjXV85zDXen_YH@archie.me>
 <CA+G9fYtByCCzrbM-a4du2b5rJVn_UaCz1HaMZMcBAcfyUBXPSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8g5cYfr1bA2m8oZD"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtByCCzrbM-a4du2b5rJVn_UaCz1HaMZMcBAcfyUBXPSA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8g5cYfr1bA2m8oZD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 02:29:42PM +0530, Naresh Kamboju wrote:
> On Wed, 29 Nov 2023 at 12:38, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Tue, Nov 28, 2023 at 05:55:51PM +0530, Naresh Kamboju wrote:
> > > Following x86 and i386 build regressions noticed on Linux next-202311=
28 tag.
> > >
> > > Build log:
> > > -----------
> > > fs/btrfs/super.c: In function 'btrfs_parse_param':
> > > fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this
> > > function); did you mean 'net'?
> > >   416 |                         ret =3D -EINVAL;
> > >       |                         ^~~
> > >       |                         net
> > > fs/btrfs/super.c:416:25: note: each undeclared identifier is reported
> > > only once for each function it appears in
> > > fs/btrfs/super.c:417:25: error: label 'out' used but not defined
> > >   417 |                         goto out;
> > >       |                         ^~~~
> > > make[5]: *** [scripts/Makefile.build:243: fs/btrfs/super.o] Error 1
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Links:
> > >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20=
231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/log
> > >
> > >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20=
231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/detail=
s/
> > >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54=
ID51BFjRBS06YQ3U/
> > > - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54I=
D51BFjRBS06YQ3U/config
> > >
> >
> > Is it W=3D1 build? I can't reproduce on btrfs tree with
> > CONFIG_BTRFS_FS_POSIX_ACL=3Dy and without W=3D1.
>=20
> My config did not set this
> # CONFIG_BTRFS_FS_POSIX_ACL is not set

OK.

>=20
> Do you think the system should auto select the above config as default wh=
en
> following config gets enabled ?
>=20
> CONFIG_BTRFS_FS=3Dm
> (or)
> CONFIG_BTRFS_FS=3Dy
>=20

Nope, leave it as is.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--8g5cYfr1bA2m8oZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWcLQQAKCRD2uYlJVVFO
oz05AQDW4tcs+qseWAL5BBtuPRoexDBDprBofv0Ia95ssWcdqgD/Y3FQpjWSjs8q
d7X5Lsdki4Ydbwkio5K/IdQJQ6O8qAE=
=xISu
-----END PGP SIGNATURE-----

--8g5cYfr1bA2m8oZD--
