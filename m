Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D7764655
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjG0F5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjG0F4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:56:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1CD1BC1;
        Wed, 26 Jul 2023 22:56:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-267fc1d776eso350637a91.2;
        Wed, 26 Jul 2023 22:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690437357; x=1691042157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAcJJL/0x6iDH6k56IBaaZzyu/V8tW3pl6w0uT8MYx8=;
        b=MtW3Ss7Zl23nPg1vtBiORDONB220JwyiwWpXCdAFYfoPnyV5x6i4k7uNKDjuN8c0Uw
         +leKOp+8qe9crKLrIH0KwJS03Mq882zX5RU7jbbgT5VOjnRlDLOAT31ZfV9OeIB4ErY9
         lmcEJFW8psJi9CZY6zQMduQEnKD+aBVZX0VaNE6hIuWqoLLPSz6f6EK9ZQ/yS2Pip8fw
         6g/Z76uU8Pzx0RPjgSQ7AxNsfGPjvtRQB3hIT6uYnniTxECRg4bxV6jRmMm4udXeqfMN
         ai+IXSQ81bkB0wd5vqnyLCW6Q2sCfIepdq4K/tPLKP1Y/U2RZ+rMsXbSxKQmmno6ywrq
         n0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437357; x=1691042157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAcJJL/0x6iDH6k56IBaaZzyu/V8tW3pl6w0uT8MYx8=;
        b=OsdTkVUc3SkDJnnsECfeAKyHFLOUfv2+1N4jaxKGtxZEvBjLKSoIHGU/nR2Ity0JdG
         D97xid9pYVr7YoeE1j25ok2TBCSTo6u+22X7OwKwU8z1J1v6/4FgHXEVK7w6Xv3gXlN5
         Mx26TvuRpFeJcN+hN9ivEwcihiNOVm0OVpaIPX6lTl+y69A0cSBaeN7XS5QFsuvaVc3h
         pkxSJHIcIPPzR9YjAt5KrtVbjmB1qBu0YhwQGGH7uzVBADmbY5Js18CkTHD9kcLj7gbI
         6Fap90xOSNvRmlcCzlMObSDSpZa7uzLhJZZ2Qr0qAYOPxaZDWdIjHxJx8uI9uBM4kXN5
         B8zQ==
X-Gm-Message-State: ABy/qLYG3fmtaU0qhfy/7zu+S1vPAQNKjbFEtDHC60DqQbmvRwwzj2V6
        LKSHsJ8BgLd2D1053tt06pY=
X-Google-Smtp-Source: APBJJlGjUphH14lSqoGk7YSjqHZe99GonUlJp5micNhQ+t4ju7YHcGZqjF9FHRX1J3uopBZomPvTtw==
X-Received: by 2002:a17:90a:bb8f:b0:267:7021:4e33 with SMTP id v15-20020a17090abb8f00b0026770214e33mr3245920pjr.47.1690437356983;
        Wed, 26 Jul 2023 22:55:56 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090a70cf00b00267fbd521dbsm2082277pjm.5.2023.07.26.22.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:55:56 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 04244819183D; Thu, 27 Jul 2023 12:55:52 +0700 (WIB)
Date:   Thu, 27 Jul 2023 12:55:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Perf <linux-perf-users@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [perf] Build error when using LTO on 6.4
Message-ID: <ZMIG6J+zqSIGVlAq@debian.me>
References: <ca25b1b3-dc7a-b0bb-dce4-8d11eb343438@gmail.com>
 <CAP-5=fX2ar7Pfj9it8pX_ohgC7OzY59iuDFSQTY7Kcnkc3-S5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnnYVvgbwHM4MjFI"
Content-Disposition: inline
In-Reply-To: <CAP-5=fX2ar7Pfj9it8pX_ohgC7OzY59iuDFSQTY7Kcnkc3-S5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pnnYVvgbwHM4MjFI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 09:20:33PM -0700, Ian Rogers wrote:
> On Wed, Jul 26, 2023 at 8:55=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > I notice a build regression on Bugzilla [1]. Quoting from it:
> >
> > > Starting with Kernel 6.4, I see a build error when using "-flto" to b=
uild perf. This used to work fine with earlier Kernels when using either bf=
d or mold as linker when using GCC 13.1.1.
>=20
> Hmm.. strange I've never seen this work with GCC.
>=20
> > >
> > > This is the PKGBUILD I use as my build recipe: https://github.com/ms1=
78/archpkgbuilds/blob/main/packages/bpf/PKGBUILD
>=20
> If this binary is for distribution BUILD_BPF_SKEL=3D1 should be set. We
> need to make this an opt-out rather than opt-in. The last time we did
> this there was some friction:
> https://lore.kernel.org/lkml/CAHk-=3DwjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5=
KcpdEQCaA@mail.gmail.com/

The reporter runs Arch Linux. PKGBUILD is a build script to create
packages, though. See the distro doc [1] for details.

[1]: https://wiki.archlinux.org/title/PKGBUILD

--=20
An old man doll... just what I always wanted! - Clara

--pnnYVvgbwHM4MjFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMIG4QAKCRD2uYlJVVFO
o+lPAP9UioRI5BBggfSKjgjg93TNq16DLHoJzaMs4darxJ/jsAEAwM3yDTSUuRkf
J1OiU/gDqhUYnvSrGVREJFGbwwJqMAY=
=MDkJ
-----END PGP SIGNATURE-----

--pnnYVvgbwHM4MjFI--
