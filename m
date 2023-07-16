Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91783754D2F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 05:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGPDMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 23:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPDMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 23:12:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D72C7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 20:12:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b9cdef8619so21128995ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 20:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689477138; x=1692069138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWn13c9f1M/8viQCOKsJa8B4NPDT5f2J9jrudPMX6BM=;
        b=Dk7tg4NeoDHBveKLdPLYXeFSYRUAqoyXh9PvGDt/8cZJdUm1Si7DX4mb+o6JiARy68
         4K2ynaKg8vaQYV5wG2a6agRCAKcFMdG76yFQFV17wjzbzrQPbruW4k+xJ8RH73CowEaV
         N2aOcj98U69XMhEL698Cq3aIGyjpYjKZu3a2q7nqeEkf7qvY4hgimF5XoQ4weJYgv8LQ
         O4x2LbQ7gUMJ3GnOuAMTRNbIu6yMVNCOPO88aYWSrCkzf1RMITs0eGFgb1LaIGh3//LB
         6lKjskf7ksyxNz6PYO8Mbipp6iazbUJ5zriIA559em64Hu5lmgldZI4CR+0UsEJ2Cxf0
         jWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689477138; x=1692069138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWn13c9f1M/8viQCOKsJa8B4NPDT5f2J9jrudPMX6BM=;
        b=e1NQzhQgsfr+InqQ9Kg1lj1VVopHsjtslq3+2PFeh+8LQo0KZYn3IejH81YOfhKxhf
         XO3aabGp34tlLqbXVJWHZo6ZjX29fJhuE55bOJJWaU4nW9GilrbBVRCHKfftWj7OJJMP
         EreRXOwk1M7tw4JIDmbek7KQDCxDWGCX8LqeIaUOZYmwDwKtlAqUT/xB+89uXvDNvxKZ
         WQLiwXrPrESA7aAaMmwZkHDjPh0v4/bdiSKclfm1QjklOhnm59QtTHXAwqmlwJINQYJE
         FgVrIw5eVKTGZAca+59b6fm1DwdJV1wfLPV3s9kWLbh+WqM3Tuv6lNwnAxt7Rcd0DjUB
         GOEg==
X-Gm-Message-State: ABy/qLavVanZfmGSNyQfcjN643IdzeOi3QxbTucjb98yLXxxIM/3l/zd
        +EfkxpSiTI4im2NaSBzxbWg=
X-Google-Smtp-Source: APBJJlFz60QuiBe9CzCnF7c0Fnkq2vo0ZvCE1iu7Z3EawbryxkJd5Kp3ffPDKIXOjhB2mphUJJ2Z3g==
X-Received: by 2002:a17:903:2606:b0:1b3:f5c3:7682 with SMTP id jd6-20020a170903260600b001b3f5c37682mr6650815plb.68.1689477138561;
        Sat, 15 Jul 2023 20:12:18 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b001b8649e52f8sm10074521plk.254.2023.07.15.20.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 20:12:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B7ABF80F26C1; Sun, 16 Jul 2023 10:12:13 +0700 (WIB)
Date:   Sun, 16 Jul 2023 10:12:13 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hughd@google.com
Cc:     Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [bug/bisected] I see "mm/pgtable-generic.c:53: bad pmd
 (____ptrval____)(8000000100077061)" every boot time
Message-ID: <ZLNgDXj0WfFUOJAJ@debian.me>
References: <CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xM6pUvZ1vpmzR5ZF"
Content-Disposition: inline
In-Reply-To: <CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xM6pUvZ1vpmzR5ZF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2023 at 02:24:59PM +0500, Mikhail Gavrilov wrote:
> Hi,
> It's ok that I see "mm/pgtable-generic.c:53: bad pmd
> (____ptrval____)(8000000100077061)" every boot time?
> Unfortunately bisect couldn't say which of commits
> # possible first bad commit:
> [be872f83bf571f4f9a0ac25e2c9c36e905a36619] mm/pagewalk:
> walk_pte_range() allow for pte_offset_map()
> # possible first bad commit:
> [7780d04046a2288ab85d88bedacc60fa4fad9971] mm/pagewalkers:
> ACTION_AGAIN if pte_offset_map_lock() fails
> # possible first bad commit:
> [2798bbe75b9c2752b46d292e5c2a49f49da36418] mm/page_vma_mapped:
> pte_offset_map_nolock() not pte_lockptr()
> # possible first bad commit:
> [90f43b0a13cddb09e2686f4d976751c0a9b8b197] mm/page_vma_mapped:
> reformat map_pte() with less indentation
> # possible first bad commit:
> [45fe85e9811ede2d65b21724cae50d6a0563e452] mm/page_vma_mapped: delete
> bogosity in page_vma_mapped_walk()
> # possible first bad commit:
> [65747aaf42b7db6acb8e57a2b8e9959928f404dd] mm/filemap: allow
> pte_offset_map_lock() to fail
> # possible first bad commit:
> [0d940a9b270b9220dcff74d8e9123c9788365751] mm/pgtable: allow
> pte_offset_map[_lock]() to fail
> definitely first bad because my machine on which I am was doing
> bisection is unbootable on these commits.
> I hope Hugh Dickins can figure out what's going on here. He is the
> author of these commits.
>=20
> All mine machines are based on the AMD platform two 7950X and one 5900HX.
>=20
> It seems that this message is harmless for the system in any way, but
> I can't judge it is a bug or not.
> >From the user side it looks like regression because on commit
> 46c475bd676bb05077c8a38b37f175552f035406 this message was absent.

What are you doing on your system that leads into this regression?

Anyway, I'm adding this regression to be tracked with regzbot:

#regzbot ^introduced: 0d940a9b270b92
#regzbot title: undescribed regression due to allowing failing pte_offset_m=
ap[_lock]()

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--xM6pUvZ1vpmzR5ZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLNgAgAKCRD2uYlJVVFO
o5uJAP9iv4ViJIKdFG+k40g7iok8mka4Z3j6kKH8KU5kHl4aEAEAqhMxhrZhAUHR
jW1OtUnuCuHNrm4RxJPOGZpWMi8yZwQ=
=JI3s
-----END PGP SIGNATURE-----

--xM6pUvZ1vpmzR5ZF--
