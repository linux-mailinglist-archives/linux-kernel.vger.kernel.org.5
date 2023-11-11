Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C407E899A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 08:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjKKHSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 02:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKKHSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 02:18:37 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F0B3C19;
        Fri, 10 Nov 2023 23:18:34 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f0820b7657so1500125fac.2;
        Fri, 10 Nov 2023 23:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699687113; x=1700291913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOZLPp3iTdJ6EIEXe2onS5kyeS9N6DBt5ZBEg7R82sc=;
        b=U8jKtj5zXj02QMRbRfEDW2HLiBx7RWDzhV6NDzjOk1CahbEo0IHn/CJjjkBVGIR+5/
         pRSzSLoGH7+4z/K400tHR3+SirSNxfOVIZD3JD6mAI4VLETd5EDY3P8SbkuQvuv7QjjU
         G5GOaOiUmckr/rY6ViGVt0QdVWb0VWYAnXwGlFDvHnmxsk3U8zsmkCzcDqQcdunh2qxH
         Mc0RNeN3Vnt0Y07nl8WEkgsvG1tQ4Na0TzANPs+OlXnazBSBYdpEUpy3tVh9TiLbS1PS
         2DfWmugnXT40H9zjIE9YcHtEEh65IkchWPX28UODXkksQic5cAl1CUFUYxjcyv1yEE2n
         hUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699687113; x=1700291913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOZLPp3iTdJ6EIEXe2onS5kyeS9N6DBt5ZBEg7R82sc=;
        b=QXFqGGE05jXTpR2f49Pm/AEeEccuqoA2gQK6Uk+cJ1z77E8y/ATxZrVCrSLoytimwk
         b2V7+8URroW6VMPN93N+Pgw5gTZzFwuGacoamI/KVMOcZRsL14NVK/o9EHRQefgI7nSk
         onLzQOUv7RxGAqxNkGC0xzn7NNt/ZzyGuTHSOtztMCehKi7Fg6F5zlq1azEyEYCslYKs
         isOrUvdMKq/h1JS68+RmHZwXJlADEEvHjfL3Limzb8hKojr+zFDocpg9aqVdcEcc7JOH
         59ZpXX7oCj9zH6P6qziYbkTToju+lS4EaApiFoZRXs45DZ50an593MaYxUyoNvwmEVwf
         N6MA==
X-Gm-Message-State: AOJu0YyquJ5/mzBnNlI3MvFrzaR3qCVe2bC6A4LKn8AKGKkb/4R8j6y2
        VqW0sDftCYrk4RxHiCl0t5M=
X-Google-Smtp-Source: AGHT+IHHxN9PcqwAh3RcEddheG9yMob3J/GjVHKV1sD3GirummkkRWmfxhsPebsccMNx7TBW05ruSg==
X-Received: by 2002:a05:6870:e94:b0:1ef:b0df:1347 with SMTP id mm20-20020a0568700e9400b001efb0df1347mr1870152oab.29.1699687113071;
        Fri, 10 Nov 2023 23:18:33 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t17-20020a62d151000000b006934e7ceb79sm801204pfl.32.2023.11.10.23.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 23:18:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 009AF10205C0D; Sat, 11 Nov 2023 14:02:49 +0700 (WIB)
Date:   Sat, 11 Nov 2023 14:02:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>,
        Linux PA-RISC Mailing List <linux-parisc@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam James <sam@gentoo.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        John David Anglin <dave@parisc-linux.org>
Subject: Re: Bisected stability regression in 6.6
Message-ID: <ZU8nGV4sg-l9-pkf@archie.me>
References: <75318812c588816e0c741b4cd094524f@matoro.tk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SYX4VuAo7JKsa6gn"
Content-Disposition: inline
In-Reply-To: <75318812c588816e0c741b4cd094524f@matoro.tk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SYX4VuAo7JKsa6gn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 01:31:01AM -0500, matoro wrote:
> Hi Helge, I have bisected a regression in 6.6 which is causing userspace
> segfaults at a significantly increased rate in kernel 6.6.  There seems to
> be a pathological case triggered by the ninja build tool.  The test case I
> have been using is cmake with ninja backend to attempt to build the nghtt=
p2
> package.  In 6.6, this segfaults, not at the same location every time, but
> with enough reliability that I was able to use it as a bisection regressi=
on
> case, including immediately after a reboot.  In the kernel log, these show
> up as "trap #15: Data TLB miss fault" messages.  Now these messages can a=
nd
> do show up in 6.5 causing segfaults, but never immediately after a reboot
> and infrequently enough that the system is stable.  With kernel 6.6 I am
> completely unable to build nghttp2 under any circumstances.
>=20
> I have bisected this down to the following commit:
>=20
> $ git bisect good
> 3033cd4307681c60db6d08f398a64484b36e0b0f is the first bad commit
> commit 3033cd4307681c60db6d08f398a64484b36e0b0f
> Author: Helge Deller <deller@gmx.de>
> Date:   Sat Aug 19 00:53:28 2023 +0200
>=20
>     parisc: Use generic mmap top-down layout and brk randomization
>=20
>     parisc uses a top-down layout by default that exactly fits the generic
>     functions, so get rid of arch specific code and use the generic versi=
on
>     by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
>=20
>     Note that on parisc the stack always grows up and a "unlimited stack"
>     simply means that the value as defined in
> CONFIG_STACK_MAX_DEFAULT_SIZE_MB
>     should be used. So RLIM_INFINITY is not an indicator to use the legacy
>     memory layout.
>=20
>     Signed-off-by: Helge Deller <deller@gmx.de>
>=20
>  arch/parisc/Kconfig             | 17 +++++++++++++
>  arch/parisc/kernel/process.c    | 14 -----------
>  arch/parisc/kernel/sys_parisc.c | 54
> +----------------------------------------
>  mm/util.c                       |  5 +++-
>  4 files changed, 22 insertions(+), 68 deletions(-)
>=20
> I have tried applying ad4aa06e1d92b06ed56c7240252927bd60632efe ("parisc: =
Add
> nop instructions after TLB inserts") on top of 6.6, but it does NOT fix t=
he
> issue.
>=20
> Let me know if there is anything I can answer on this.  I can provide full
> remote access with BMC if it would help.

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 3033cd4307681c

--=20
An old man doll... just what I always wanted! - Clara

--SYX4VuAo7JKsa6gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZU8nFgAKCRD2uYlJVVFO
o23FAQDe8rV4FDxZYGdTaBcAH36/kizVQAo4vNmQYrguq2cquQEA3PCAFUeNq8fP
LnZloRB9w+yHouJRxTYsD/RNnnVuxAU=
=41LN
-----END PGP SIGNATURE-----

--SYX4VuAo7JKsa6gn--
