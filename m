Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99F75FD01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGXRSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGXRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:17:59 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F12B10D5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:17:58 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40694b191cfso11105581cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1690219077; x=1690823877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYSBbwb0q7mkdVpvxRgFuvQmjMykcBQE+odbDhlX2Es=;
        b=OTGPEUMaZkmEGJhZuPPaE7EZ65sIqpFRcjmJpWnc56LqjLKnDcSe0BDMfj0WK6jQpC
         1AFo/BHJEWX8lB7UGSzlzAlyPuBgGZliyW3Gw5URzFJg4warwLTO/olLrbIcHoOJr0ws
         /SEiJelGVnNhIBlKopNw2pgQUIONiJTMpavAZLBRMYW0goyTI+MJQo0x9OLo5lmOzMKO
         iP3mm3WOh/brK8yfgwNVQODAbxY7YUU5IYH7zOnW92dKkAZ7KBEAmMxpWVfJDuTBV7cb
         RgTIChkNhihcPbfuHP0zh6di77B4kj2nuzxMGQUOpT5wyWlGYrMYpB+QEIdvcmfLY3nC
         X9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219077; x=1690823877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYSBbwb0q7mkdVpvxRgFuvQmjMykcBQE+odbDhlX2Es=;
        b=Jzf+rUvn9v5Bgw/llULWF/rB9SFEOmyDh/eHArA7HF5wDbF2ZT8Ze5k7kJu3bOq0ms
         iGmYub0a5goc2mnR5IroD8SUD7OAZeJ2aasin7bHMQA3oDiaAMvVB4nqV8N04MhRcKLg
         a9izSOBXD8Izm+mLOYZ3WRTr37cJww24fuMnf5uOtMvF2X88v65GlqjiVUJjy19qXUhX
         /Jze+Fp/kCN274krwX6w/QY/0Wnv7DCj1bM9oNL9kFAcbv6Z4ato+knE/dc60JnP9L+P
         fyxUVan15M9fbo/DKTX7TILuo+k5wv8iAJ8rYse2c0Q4/kjBI4/oX44aDnsl5F07GluZ
         Y6mQ==
X-Gm-Message-State: ABy/qLYwJ5hxj70a5L7z872mNrOknWKpPvAnTexaDqt4ur4Cr8mWR+in
        FpHzhu14dilrokkS+W14F6GvlWhpkkq4A9aUweigtg==
X-Google-Smtp-Source: APBJJlEgh6eXM3hYeN5fH1jeltcLY7xxixaWZ2KePlt78V6dhQhW0u99v1a/m1HTda+aR4pbFg2gjm5swOjZaDmLm+8=
X-Received: by 2002:ac8:5b92:0:b0:403:aed5:a3b3 with SMTP id
 a18-20020ac85b92000000b00403aed5a3b3mr400763qta.66.1690219076185; Mon, 24 Jul
 2023 10:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
 <CA+CK2bBb1YPXSU_YswN6hmf5pqDcc0O6KMw7C3nNCM0ztqm76Q@mail.gmail.com> <20230724100231.94abdfb007bea270d607a760@linux-foundation.org>
In-Reply-To: <20230724100231.94abdfb007bea270d607a760@linux-foundation.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 24 Jul 2023 13:17:20 -0400
Message-ID: <CA+CK2bDdytE67t=3g9k-yo7dEHf=zWA8T4Ty4J9iKKsYV9g0vQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Remove unused parameters in page_table_check
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 1:02=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 22 Jul 2023 17:48:31 -0400 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > On Thu, Jul 13, 2023 at 5:25=E2=80=AFAM Kemeng Shi <shikemeng@huaweiclo=
ud.com> wrote:
> > >
> > > Hi all, this series remove unused parameters in functions from
> > > page_table_check. The first 2 patches remove unused mm and addr
> > > parameters in static common functions page_table_check_clear and
> > > page_table_check_set. The last 6 patches remove unused addr parameter
> > > in some externed functions which only need addr for cleaned
> > > page_table_check_clear or page_table_check_set. There is no intended
> > > functional change. Thanks!
> >
> > NAK
> >
> > Both, mm and addr are common arguments that are used for PTE handling
> > in many parts of memory management even when they are not used in
> > every function.
> >
> > Currently, they are not used in page table check, but it is possible
> > we may need to use them in the future when support for other arches or
> > different types of page tables (i.e. extended page table) is added. It
> > is going to be hard to again modify all arch dependent code to add
> > these arguments back.
> >
> > Also, internally at Google we are using these arguments, as we have a
> > module that maps user memory in a way that is incompatible with
> > upstream, and these arguments are used to support this module.
> >
>
> I don't think these are very good arguments for carrying cruft in the
> mainline kernel.
>
> If such an architecture is introduced in the future or if google
> upstreams that module then we can restore one or both of these
> arguments at that time.  This is hardly insurmountable:

There is another argument: as a follow-up to
https://lore.kernel.org/linux-mm/20230722231508.1030269-1-pasha.tatashin@so=
leen.com/,
I plan to improve the debugging message instead of simple WARN_ON(), I
want to print more information about what went wrong, what it means,
and what was expected behaviour. Having more data about the mm, and
the addr, is going to be useful for this extended warning message.

set_p**_at functions have prototype like this: set_p**_at(mm, addr,
ptep, pte), in these functions mm, and addr are also not used, as they
call something like: set_pte(ptep, pte); directly, yet having access
to mm, and addr is useful during debugging instead of rewriting them
all over the kernel.

Thank you,
Pasha

>
>  arch/arm64/include/asm/pgtable.h | 12 +++---
>  arch/riscv/include/asm/pgtable.h | 12 +++---
>  arch/x86/include/asm/pgtable.h   | 16 ++++----
>  include/linux/page_table_check.h | 66 ++++++++++++--------------------
>  include/linux/pgtable.h          |  6 +--
>  mm/page_table_check.c            | 50 +++++++++---------------
>  6 files changed, 65 insertions(+), 97 deletions(-)
>
>
