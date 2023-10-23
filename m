Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB87D3BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjJWQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJWQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:16:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB16FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:16:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27e1eea2f0dso1704635a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077765; x=1698682565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7P8oczVJ6z+n4v15CASAjFJRtKrm1cxI4uPJHeGdVo=;
        b=WGFN57xEJPykfmD370k71+0/7zCERcTMbkrd/m01xJtajuE6WvjaHNZtJ/5MX20l/j
         8jz+TvGYL2LLN1lflDfytBO+4QPYGUcH6Gd5TwFqOiz2RzdQlGSV0o6cdivsrfmdrlul
         wERHJ5iQbWOCGxhuM7U/7QFUx6LtEy5utmpv6LzKuE9cH/Wo2grIa0q9zAfXL4lMpZV4
         zhpS3n5eXuF+n1OuL82fJlpmNe7IOWqc5JU689WTbcuOXtd8NLvr2WF4S0Jxfe0YF6uT
         MgXyXhRanV1QHcdHE8s/cm9q/3PYoKhNA/gZPw1DNy6V2J+0rRM1MWvhshalpoFGPBdB
         6FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077765; x=1698682565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7P8oczVJ6z+n4v15CASAjFJRtKrm1cxI4uPJHeGdVo=;
        b=utH/asGxvAOMlyU8tOzD8a68pJJYETSs/zk85b/lRkkMxCGrcefFHjrN2dnFYYyC10
         5dUGbjqgt20AaLstVO6g8dOTtbKyqa3FB7ejhvdFDXJZ78MuWvelwWGcJSzmR/h2Elum
         mtwBiAbvJs8UnrScPI7YXj+BxCSWsLAu/3AQ7Jhn8wITcPOUmpDnVosB1wXecpbuIxN/
         cMd7rmpZmvLFBPbcpnYSzDKeHQkvy+udvmjLEM5KogN+gBt8xZ9Lt8Tch3O2Vowgbfjm
         7dz2n5PipP4u/duSpMZBtJr3KQx5TKgu8FWCGqXysFStuOTuASSV+DIIYrfZOcKZsdDY
         IDwA==
X-Gm-Message-State: AOJu0Yx8hXsTYrj9jYOSnVbegNmxBZ4cX1twBg8nXDHXczxH5/0W/sSq
        LWfUCQz+48GaBYIIo483kKCG3QHmkh40MN3MvRs=
X-Google-Smtp-Source: AGHT+IGE9ocFI9+MvERlI4Z5hqiW7HqKx/YOe7KTld8ZTi8R/3MltMbrT/7KaL/rGY5Smbt+r6SniLfQEXAjJYVpQ4k=
X-Received: by 2002:a17:90a:8a12:b0:27d:1af5:3b17 with SMTP id
 w18-20020a17090a8a1200b0027d1af53b17mr6747462pjn.26.1698077765375; Mon, 23
 Oct 2023 09:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <e78360a883edac7bc3c6a351c99a6019beacf264.1694625260.git.andreyknvl@google.com>
 <CAG_fn=UAF2aYD1mFbakNhcYk5yZR6tFeP8R-Yyq0p_7hy9owXA@mail.gmail.com> <CAG_fn=XyqgfZO=bduYPTGpM9NovQPZOzZf8cidt7=m6H092sSg@mail.gmail.com>
In-Reply-To: <CAG_fn=XyqgfZO=bduYPTGpM9NovQPZOzZf8cidt7=m6H092sSg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Oct 2023 18:15:54 +0200
Message-ID: <CA+fCnZcWki62K40j56rKopo5JcjBbm5yGwjo8nHstssP5A1asw@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] lib/stackdepot: fix and clean-up atomic annotations
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 7:22=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> On Fri, Oct 6, 2023 at 6:14=E2=80=AFPM Alexander Potapenko <glider@google=
.com> wrote:
> >
> > On Wed, Sep 13, 2023 at 7:15=E2=80=AFPM <andrey.konovalov@linux.dev> wr=
ote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Simplify comments accompanying the use of atomic accesses in the
> > > stack depot code.
> > >
> > > Also drop smp_load_acquire from next_pool_required in depot_init_pool=
,
> > > as both depot_init_pool and the all smp_store_release's to this varia=
ble
> > > are executed under the stack depot lock.
>
> Maybe add this to the comment before "if (!next_pool_required)" ?

Will do in v3.

Re removed parentheses: will restore them in v3.

Thanks!
