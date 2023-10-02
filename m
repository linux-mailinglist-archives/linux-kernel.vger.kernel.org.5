Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6B7B574D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbjJBP6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbjJBP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:58:49 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80F91
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:58:46 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-78f1210e27fso7304664241.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696262325; x=1696867125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/uBY1GHK5wM8Sw0r1xr8kkIVh7PpQ9+l557Rxtbl80=;
        b=Pc7dFJlYTRopiol2lzwUFAHigo2IMLSYGRyMF9T0hPL/qJwLZ/OHPF4xthoEazJ7VW
         4L+IevofZ3PFQsGMvoP6OXLPnKpZ+j7NE4kDB2dDyNnVPT2Twz99DLakTHI5O+0ux9p0
         mtuX5YX7WxrsXH1Ka85C4Qqk2sfnCGlKv+nFDnDJYm2XgMqFFCmwRBI0aWAs0xo6exVu
         YERYjRcNEtTT4igoIy0CQZlV4WZmgMhWJl8yn6m34UQW5/KeoHPfOu9pE0iL/HCe3UjV
         ZItTjFykQHMNdA4C4xlC218BBOiEc9apsxICASsjCqkoV9H6y2VNE+djvL3VtJoSvxm+
         I4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262325; x=1696867125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/uBY1GHK5wM8Sw0r1xr8kkIVh7PpQ9+l557Rxtbl80=;
        b=cxaPaVmGHaaltP3FV9+SpfmZxAyg3yp+p+yMCo/aARwpHDmAwJIrPb/JQYZy6tMIeg
         ObB1RBSLYEKvGtTClRlaM98SPdWTECecUh+FU7Yas5FGD/yQYS+SjyeL6R4CkzB47p0z
         tbHicO308cZDbFBuDCDb9/aY8yEUybh/MGfoCtDgdPhfBBmrsfEplfdxm0KZeR9Rs5Jb
         YNF5cUb6Al0vknjqhUra1nrEJACE2h206VMYBijcyDZ+DE6LI0hMGll4mS9YzPM7p9vr
         UYXDAR9j3ioTqmqdj7CfdBbWYemE2p1/uUu5X3ZXm66Ra2EklQU6b7BnO/A1BUp5dZFO
         wQOw==
X-Gm-Message-State: AOJu0YxluODNG10F9bJN9sjC9GN2/0GDk8YDxT5fqiHKWWfkdz1QuQLF
        AOOZM95drVBQlSzkapCRQP0hBW4yRecBFkI1fdMeLQ==
X-Google-Smtp-Source: AGHT+IFW1CmNUWYkc6jWoQN9D8Ez4GQmg0IhD/dCqR+ig8ardwLgD7Q08r9vAe22Az/mJ0aZENlZbqM+iJIDMe5iWf8=
X-Received: by 2002:a05:6102:2db:b0:452:cfeb:160d with SMTP id
 h27-20020a05610202db00b00452cfeb160dmr10233920vsh.26.1696262325473; Mon, 02
 Oct 2023 08:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <20230929211155.3910949-6-samitolvanen@google.com> <202309291452.66ED9B4D83@keescook>
 <CABCJKufxUVoO+yJ+513W5FOFu6u45N=6wZe6a69u+8LU6A_N2Q@mail.gmail.com>
 <20230930-emporium-share-2bbdf7074e54@spud> <202309301400.4E1AD87@keescook>
 <CAKbZUD08W9_HB9F7tQqwreYvVapgVMOkS3QokzwHPcBnFnVMig@mail.gmail.com> <8d305ae1-4235-6ae8-7dfb-9f432fdfcd41@ghiti.fr>
In-Reply-To: <8d305ae1-4235-6ae8-7dfb-9f432fdfcd41@ghiti.fr>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 2 Oct 2023 08:58:07 -0700
Message-ID: <CABCJKucscLdmyD8zJ=aOJDT9zbChW3=ZMXPgudPqykfOemR+fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: mm: Update mmap_rnd_bits_max
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 2, 2023 at 12:02=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> On 01/10/2023 17:19, Pedro Falcato wrote:
> > On Sun, Oct 1, 2023 at 2:51=E2=80=AFAM Kees Cook <keescook@chromium.org=
> wrote:
> >> On Sat, Sep 30, 2023 at 10:02:35AM +0100, Conor Dooley wrote:
> >>> On Fri, Sep 29, 2023 at 03:52:22PM -0700, Sami Tolvanen wrote:
> >>>> On Fri, Sep 29, 2023 at 2:54=E2=80=AFPM Kees Cook <keescook@chromium=
.org> wrote:
> >>>>> On Fri, Sep 29, 2023 at 09:11:58PM +0000, Sami Tolvanen wrote:
> >>>>>> ARCH_MMAP_RND_BITS_MAX is based on Sv39, which leaves a few
> >>>>>> potential bits of mmap randomness on the table if we end up enabli=
ng
> >>>>>> 4/5-level paging. Update mmap_rnd_bits_max to take the final addre=
ss
> >>>>>> space size into account. This increases mmap_rnd_bits_max from 24 =
to
> >>>>>> 33 with Sv48/57.
> >>>>>>
> >>>>>> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >>>>> I like this. Is RISCV the only arch where the paging level can be c=
hosen
> >>>>> at boot time?
> >>>> I haven't seen this elsewhere, but I also haven't looked at all the
> >>>> other architectures that closely. arm64 does something interesting
> >>>> with ARM64_VA_BITS_52, but I think we can still handle that in
> >>>> Kconfig.
> >>> AFAIU, x86-64 can do this also:
> >>>
> >>>        no4lvl          [RISCV] Disable 4-level and 5-level paging mod=
es. Forces
> >>>                        kernel to use 3-level paging instead.
> >>>
> >>>        no5lvl          [X86-64,RISCV] Disable 5-level paging mode. Fo=
rces
> >>>                        kernel to use 4-level paging instead.
> >> Ah-ha! Okay, well, then let's track this idea:
> >> https://github.com/KSPP/linux/issues/346
> > (Replying here for visibility, tell me if you want to move this
> > discussion to github)
> >
> > AIUI, x86 cannot do this for compat reasons. Even if you enable LA57,
> > mmap only gives you < 48-bit addresses, for compatibility with things
> > like JITs, etc that stash information in the upper 16 bits. You need
> > to pass a > 48-bit mmap hint to get 57-bit addresses.
> >
> > I imagine riscv does not have this issue yet, due to little
> > accumulated cruft, but it may be wise to check against popular JITters
> > for these problems on riscv code.
> >
>
> We already encountered those issues and the same solution was recently
> merged (restrict to sv48 unless otherwise specified):
> https://lore.kernel.org/all/20230809232218.849726-1-charlie@rivosinc.com/

We recently ran into this issue when bringing up Android as well
because qemu defaults to Sv57 and some userspace bits weren't happy
with >48-bit mmap addresses.

Note that this patch uses MMAP_VA_BITS, which is 48 for both Sv48 and
Sv57, which is why mmap_rnd_bits_max will be 33 even with Sv57.

Sami
