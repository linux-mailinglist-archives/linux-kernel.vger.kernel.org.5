Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C578FDD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbjIAM4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346028AbjIAM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:56:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B48010CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:56:00 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79216d8e2cfso66437039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693572959; x=1694177759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp6kuqivZUwDBvAydSVxSfEt7o7hfm/DB8FgT+ioHzU=;
        b=O6xJa/d6TVzMbkg89oJ1JpValU+j7sdGzmW1a+iqKKxCVdJ/gRvEgFBjH8sk8dfOzg
         MpGztuiqMXWvDfRoyfS7EMmzDyNV0grfVicP+veADcNwlOJ5UlzK/zUYNmFZkTgMvI7R
         IXK2uby5qGPWGnc18h3QCkc33NiAozzo93owqvwBkNj9M3cUx3JDqFBcnr18ipnxYUwd
         1BdcLoHol5S63IRSJ1aBj+lR0aBrEeeiSyYzwfszVvTdaEXvSXy8O+FPGs0Eju1hxAyH
         ROXnwWJlP5jI6T8YQplCyc1yuamsr7mJTkx7CzwRs9Z7csxdSkqX+MPaxYIeYw/49nXI
         scQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572959; x=1694177759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp6kuqivZUwDBvAydSVxSfEt7o7hfm/DB8FgT+ioHzU=;
        b=Lc3FSGeyIv+UTBdel0t8PKS9aLIt7YfhB/IfWHxdFG9ag14QqOyrYAaPdpdcYlTgtC
         dE8mJDlZ0zEhoBVfDl+BNdKk1E0t+Os2rrnWzrTWjVCtG+2qTNTBq8Sv1ykrKnAriyv1
         k01MsGIHpqMSJxBrTJPiIL0n7OGbfsuYSFShXp4ajzAEtZeIOlN533OUPkgqgHGhoyJ0
         ZE0QPPqhXhCChEw23LGWF1SrcjtPw3+0Ryv/tMLAzSvAjUEJ7Saz932ZdrR3OLbBLvuD
         vxMQqVkjUSrKzkkVZ9z6BC51JAJyLsHLXfbkley2K2NokHjzLVrmHaf471uwxyTGshVB
         ZpEA==
X-Gm-Message-State: AOJu0YyFwzj6s5ZgfXe7NQXmljrj6Ic43hueXNY6Jos0OgOiAMKCcGMd
        kUgsmaov2zRiWVdT8cYE+g2p6LA9IeyicVWW5gHLdQ==
X-Google-Smtp-Source: AGHT+IHpml0xIyAhuTM6WK2ZMvP39QviO5vePqECq+n308G/C9kRkss4Wd7em/CWZ4a3YguAYG1sVgTg8cbYOm2FnN4=
X-Received: by 2002:a6b:5f17:0:b0:792:9a3e:2dd with SMTP id
 t23-20020a6b5f17000000b007929a3e02ddmr2681740iob.3.1693572959540; Fri, 01 Sep
 2023 05:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org> <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
In-Reply-To: <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 1 Sep 2023 14:55:17 +0200
Message-ID: <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 12:29=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> loop alex

(adding more people who took part in the previous discussions)

>
> On Thu, Aug 31, 2023 at 8:16=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Aug 31, 2023 at 06:52:52PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > There is no explicit gfp flags to let the allocation skip zero
> > > operation when CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy. I would like to m=
ake
> > > __GFP_SKIP_ZERO be visible even if kasan is not configured.

Hi all,

This is a recurring question, as people keep encountering performance
problems on systems with init_on_alloc=3D1
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1862822 being
one of the examples).

Brad Spengler has also pointed out
(https://twitter.com/spendergrsec/status/1296461651659694082) that
there are cases where there is no security vs. performance tradeoff
(e.g. kmemdup() and kstrdup()).

An opt-out flag was included in the initial init_on_alloc series, but
back then Michal Hocko has noted that it might easily get out of
control: https://patchwork.kernel.org/project/linux-hardening/patch/2019041=
8154208.131118-2-glider@google.com/#22600229.

Now that init_on_alloc is actually being used by people which may have
different preferences wrt. security and performance (in the cases
where this tradeoff exists), we must be very careful with the opt-out
GFP flag. Not initializing a particular allocation site in the
upstream kernel will affect every downstream user, and some may
consider this a security regression.
Another problematic case is an OS vendor mandating init_on_alloc
everywhere, but a third party driver vendor doing kmalloc(...,
__GFP_SKIP_ZERO) for their allocations.

So I think a working opt-out scheme for the heap initialization should
be two-step:
1. The code owner may decide that a particular allocation site needs
an opt-out, and make the upstream code change;
2. The OS vendor has the ability to override that decision for the
kernel they ship without the need to patch the source.

Let me quoute the idea briefly outlined at
https://lore.kernel.org/lkml/CAG_fn=3DUQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8x=
w_WEYGw@mail.gmail.com/
(unfortunately the discussion got derailed a bit):

"""
1. Add a ___GFP_SKIP_ZERO flag that is not intended to be used
explicitly (e.g. disallow passing it to kmalloc(), add a checkpatch.pl
warning). Explicitly passing an opt-out flag to allocation functions
was considered harmful previously:
https://lore.kernel.org/kernel-hardening/20190423083148.GF25106@dhcp22.suse=
.cz/

2. Define new allocation API that will allow opt-out:
  struct page *alloc_pages_uninit(gfp_t gfp, unsigned int order, const
char *key);
  void *kmalloc_uninit(size_t size, gfp_t flags, const char *key);
  void *kmem_cache_alloc_uninit(struct kmem_cache *, gfp_t flags,
const char *key);
, where @key is an arbitrary string that identifies a single
allocation or a group of allocations.

3. Provide a boot-time flag that holds a comma-separated list of
opt-out keys that actually take effect:
  init_on_alloc.skip=3D"xyz-camera-driver,some_big_buffer".
"""

A draft implementation at
https://github.com/ramosian-glider/linux/commit/00791be14eb1113eae615c74b65=
2f94b5cc3c336
(which probably does not apply anymore) may give some insight into how
this is supposed to work.
There's plenty of room for bikeshedding here (does the command-line
flag opt-in or opt-out? should we use function names instead of some
"keys"? can we allow overriding every allocation site without the need
for alloc_pages_uninit()?), but if the overall scheme is viable I can
probably proceed with an RFC.

> >
> > This bypasses a security feature so you're going to have to do a little
> > better than "I want it".
> Thanks for pointing this out. What I want to do is to give the user a
> way to exempt some types of pages from being zeroed, which could help
> on performance issues.  Could we have the most safety concern admin
> use INIT_ON_FREE while the less concerned use INIT_ON_ALLOC &
> __GFP_SKIP_ZERO as a light version method?

init_on_free has a more significant performance impact, and might be
more problematic for production use (even more opt-outs would've been
needed).

As a side note, I don't think we should repurpose the same
__GFP_SKIP_ZERO flag used by KASAN, because the semantics of the flags
may not match 1:1.
