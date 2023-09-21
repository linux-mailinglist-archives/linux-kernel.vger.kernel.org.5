Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB17A9FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjIUU1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjIUU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:47 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A9102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:07:21 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-415155b2796so10441cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695326840; x=1695931640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr0HDINOfnSGJvR8CBUjdsC1w8o7oheg4iDN7h3/HXE=;
        b=wDXn9xPMveNFhs697QYomVuMlz2fhaoARhXF7lm7PRp+dKjZPmEG8R6NxT8E4jE7cY
         cWiw34zP1tMw1DpJrqTXzX463AjcAPhgW5s2vFijkRQQt2LwmkIe+2cgFE2eF1VITqNf
         9GHs1DOTsF78UibfB9VuA4bajbzVFEZpuqHvpIECdzd+WBVr4tilLP2GvRjWmtEz3lhq
         QGZNfD/VN+sJLyued1T4aGyJ72E3bnyKoPq+mFRwwHua2AAb99xtpCe6EhxL/KcsEml0
         LP5Mjlqd1Pb3ekVMpXvOrUKvstGpVTp3T00DUoqw0jLaVaU2Do58zkDAKyV1wk88EPuZ
         8afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695326840; x=1695931640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr0HDINOfnSGJvR8CBUjdsC1w8o7oheg4iDN7h3/HXE=;
        b=a9kFAfvoxQemxFUuVZU+E3fhTX6EJPsbFsNRT1pq9bGtmXmSicGcy4Xp75tVcwvL/R
         loY1GOsRBdarscJK4nwouNLv5EcC2KPMqJbtGqpW6p9Uqyzq9/VuYGt3cjxS/YJeWK+V
         +AM0HQZ3G8GeKoZhtwAG2cukmDdJDC8owtAFfWVb0jOXRqifFQxRhxLnp7oy+hbttBUv
         41Mapn50LrJBtztkhGw6ApH7210rWuBpz4s2IszWnuiZZ+PK13C9G41kEBKs1OULReAv
         U/YdQICb094jS5g8t3P+sNFZ2KSsYxihcuHMIBiyYNAlqMScD17/dW2u5b1DujmG9gPA
         Lugg==
X-Gm-Message-State: AOJu0YzFQcDI1HdLEEGvuxsFKdmnQBp7zHj/IIh6GNoqLG/LTn3TK4rz
        7E93R+cGqNIriroT2KqEgBMRxXL72Nbxya4ReP0bWw==
X-Google-Smtp-Source: AGHT+IH0gCAT1sAA8hGaX5ATILmSw1EKt7QL2mCymfDxgFKVwgUruuWjFLtvCDR/IJe5MiaSCavn7dCTsUM4ZMrt1Lc=
X-Received: by 2002:a05:622a:1aa9:b0:40f:d1f4:aa58 with SMTP id
 s41-20020a05622a1aa900b0040fd1f4aa58mr14332qtc.8.1695326840269; Thu, 21 Sep
 2023 13:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230920001728.1439947-1-maskray@google.com> <20230921072655.GA14803@noisy.programming.kicks-ass.net>
 <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com>
 <20230921153537.GG14803@noisy.programming.kicks-ass.net> <CAFP8O3K6Lgxe=Res9d2GKipRYdXqzv3wa_0PLtDcyn7g7H=z5w@mail.gmail.com>
 <20230921171900.GB29413@noisy.programming.kicks-ass.net> <CAFP8O3JpkWTXnxYxa45uANNMQ34g2VUPnfj7-oWn3oq9egUb-A@mail.gmail.com>
 <20230921192253.GA39480@noisy.programming.kicks-ass.net>
In-Reply-To: <20230921192253.GA39480@noisy.programming.kicks-ass.net>
From:   Fangrui Song <maskray@google.com>
Date:   Thu, 21 Sep 2023 13:07:09 -0700
Message-ID: <CAFP8O3Kmep3zXNk3=s5qpMQ3-TnfEYxeCkLi3e-DTqQc=Fs4TQ@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation, objtool: Use absolute relocations for annotations
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:22=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, Sep 21, 2023 at 10:36:27AM -0700, Fangrui Song wrote:
>
> > Well, only if the clever assembler doesn't support 32-bit absolute
> > relocation for a 64-bit architecture.
> > I don't know such an architecture. In addition, as long as the
> > architecture intends to support DWARF32, it has to support 32-bit
> > absolute relocations for a 64-bit architecture.
>
> Ooh... my bad. For some reason I thought that absolute meant native word
> size. But you already mentioned R_X86_64_32 (and I failed to check) and
> that is indeed an absolute (S+A) relocation of 32bit (dword) size.
>
> And apparently we also have R_X64_64_16 and R_X86_64_8, which would even
> allow something like:
>
> #define OBJTOOL_ANNOTATE(type)                          \
>         "999:\n\t"                                      \
>         ".pushsection .discard.objtool_annotate\n\t"    \
>         ".byte 999b\n\t"                                \
>         ".byte " __stringify(type) "\n\t"               \
>         ".popsection\n\t"
>
> And since we only read the relocation and don't care for the actual
> result that would actually work just fine.
>
> Anyway, thanks for bearing with me.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!  I assume that the patch can be picked up without me doing anything=
 :)

Yes, x86 also supports 1-byte and 2-byte absolute relocation types,
which are missing from some other architectures.
If we want to optimize for RELA, we can use R_*_NONE by utilizing
`.reloc ., BFD_RELOC_NONE, .text.foo` (as mentioned in the commit
message).
(binutils 2.26 https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;=
h=3D740bdc67c057ee8012327420848eb134e1db4211;
I added the support to most LLVM targets in 2021).

However, this is just 4 byte per entry difference compared with the
large sizeof(Elf{32,64}_Rel), so not worth the trouble:)

--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
