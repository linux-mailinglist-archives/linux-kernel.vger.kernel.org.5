Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EE8060E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345732AbjLEVj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:39:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3BC6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:40:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so61625f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701812401; x=1702417201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kbHlqbkhYwBbDQLJMz0TJVKvZVaLjuc/LRCzX5dlF4=;
        b=SEl+lJSI5/18sOa7xg5F6Zg72YnHaaOuw4X4ako1eM5Weo4rQadC5HKdEB3SDmsfBj
         XrfJ7nf3psLYjgaZV9JwpfJpWA7bcWUZiI6u7OvExzTH+q22OF/HjMke5fJaspBCcUtx
         fMxG4lXS0pbIMp/hYQpLh+g35UIjuqWJzPI/PyxqjggmoR3YftbgIuFSO7CMaVBrS45I
         nmuxxyZASKJvOTry17Rbi1S6vV/LXQmrePsHiTFpLEvM13PL+VYNLTl9EbCrBrjYae1O
         fROWaaNhKKer6ksIx//XQ91ewO651dw96YZXrgTPrg4V3W33ZlxzZLQaKT4VRo8MIRvi
         u4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812401; x=1702417201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kbHlqbkhYwBbDQLJMz0TJVKvZVaLjuc/LRCzX5dlF4=;
        b=R/ATkP0oWA58xyt+dOdfuW8S4NzIYbOr5xdr++ksK33WnuSP3kxHveCafQpeH3r2+n
         z5korL3r5jM9wXv/p0lnDWyZSYxADBuhzEtF5nii2gIbIGXhotxBmDHDMMXHT6WRcs5c
         LsJil0SoKrCzCBXnvN252xDsgKTFLhSGxXDm5erMC7E4krGB48etPHX9nWBniiGuODDN
         ga3vYob5/9qBQI1uIGTOHvaToODT+7lTf5wjX3epMjNa+KHHw37VrIodAmmMOKNyAZjv
         iEI/3bD2iaQV9mFOBAavPTZ34NFul4zo7ELRTkpoLkPKRwP6bNA37otYbZxKJXX6OW/F
         ywHQ==
X-Gm-Message-State: AOJu0YybUfSvVDhlIWfg8xl68iBYMdDbgmabuCGhsjE64N94y6UQFdDH
        lLasik6em+3yog0ubp5XumFM7y/df+jHoeSp6h1/+eRTQUGc5y5/oH+WQQ==
X-Google-Smtp-Source: AGHT+IGMn79dOXEc4cRtYoqKYziKCkAseM49c6cHdzYaoWCqgxNOZ+I1/FwkoTDwVqORs0jMTHot/e41TNqNF/jcYS4=
X-Received: by 2002:adf:ea4a:0:b0:333:3b79:27d7 with SMTP id
 j10-20020adfea4a000000b003333b7927d7mr1299396wrn.59.1701812401438; Tue, 05
 Dec 2023 13:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com> <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
In-Reply-To: <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 13:39:47 -0800
Message-ID: <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tanzirh@google.com, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:24=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 5 Dec 2023 13:14:16 -0800 Nick Desaulniers <ndesaulniers@google.c=
om> wrote:
>
> > >
> > > The preferred way to import bit-fiddling stuff is to include
> > > <linux/bits.h>.  Under the hood this may include asm/bitsperlong.h.  =
Or
> > > it may not, depending on Kconfig settings (particularly architecture)=
.
> > >
> >
> > Just triple checking my understanding; it looks like
> > include/linux/bits.h unconditionally includes asm/bitsperlong.h (which
> > is implemented per arch) most of which seem to include
> > asm-generic/bitsperlong.h.
> >
> > include/linux/bits.h also defines a few macros (BIT_MASK, BIT_WORD,
> > BITS_PER_BYTE, GENMASK, etc).  If lib/string.c is not using any of
> > those, why can't we go straight to #including asm/bitsperlong.h?  That
> > should resolve to the arch specific impl which may include
> > asm-generic/bitsperlong.h?
>
> It's just a general rule.  If the higher-level include is present, use
> that.  Because of the above, plus I guess things might change in the
> future.

Hmm...how does one know that linux/bits.h is the higher-level include
of asm/bitsperlong.h?

Do we mention these conventions anywhere under Documentation?

>
> We've been getting better about irregular asm/include files.
>
> But bits.h is a poor example.  A better case to study is spinlock.h.
> If this tool recommended including asm/spinlock.h then that won't work
> on any architecture which doesn't implement SMP (there is no
> arch/nios2/include/asm/spinlock.h).

The tooling Tanzir is working on does wrap IWYU, and does support such
mapping (of 'low level' to 'high level' headers; more so, if it
recommends X you can override to suggest Y instead).

arch/nios/ also doesn't provide a bug.h, which this patch is
suggesting we include directly.  I guess the same goes for
asm/rwonce.h.

--=20
Thanks,
~Nick Desaulniers
