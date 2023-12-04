Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E181803A42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbjLDQ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjLDQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:28:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719AB9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:28:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332d5c852a0so3578036f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701707315; x=1702312115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ExnfZxVYVMvXtVrPDzieFUCNS347qRDxh4C9hinedE=;
        b=qEWxb0ROnOfJMhKvDo4MvjXpD2MAGB8kZvwAzAiVX4jO7/Zy/TDimvW0xcVAKwfkUo
         YHqMPNAcD4lFRVqqeAacrPYdVJuoGVVZru978HyGQA4o7u39bexQrL48ebV6IoSu6Zed
         tqPaBGdPcJLnQH99LDPc23sIB3omMCEp5JPTk9Lm2ri5mjqXr7gGMGjhBsaERjUUn0P/
         Hwpr91AgtC8e5CKVcudPbZax3lY2Mu6dcfNHy35ovolNgehGP1+AjQXquq8auod1DjbI
         VbA5yoJNtpqNso76h1MCuT946WNW3NSS075h7x1FgFmPAbV70GtkT2E188PToy5sLHTc
         Xh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707315; x=1702312115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ExnfZxVYVMvXtVrPDzieFUCNS347qRDxh4C9hinedE=;
        b=F1lDAX0YcAxtaaNTlthVkIL7PH47oSdHF9j3QTDcPfEYHD9nWRpP75Rr2i6n8Qslar
         c0D+fnFNM3iKeGuMJiLYC9oVffA4Px+6NryYkHetzpAwEP07l8eJw87Hn6WOxr1ft16K
         vaUJFexIzFp7Wmd4uC3NTuUZ6/prv5GKA7WiD+z0vrJHWYym3fYyxcQze23HWklgkDPN
         hqmRHcL58LgTdEiXqo4mQ20jgFuSh7Ev4P5zA9PLKtd7Yujy8xfO8qNo+O7nlQebvZBw
         UdtVVq7OMWdBRHfQWIG3Zjv4ph9fDyOH9xbDwHK/9mD+ieZbF6yERwtblGZI8CG7XV+n
         ldew==
X-Gm-Message-State: AOJu0YzniribysRKzHTTzryZ4TCP1OVuP/i6lpBzCwWAxXpJkx1hf3Eb
        G1zWvO6rIcuLP7/nP9KYYy4489YOMCL3zF7iS1632Q==
X-Google-Smtp-Source: AGHT+IGnOKjeCz5yB866/XKel7WGP0XqRZykiL2PjFZMSwT0owq2u4yw/k+2hL+LNgiWmi11i0MklXo5mO20cDi5GUg=
X-Received: by 2002:a5d:50c2:0:b0:333:2fd2:5d51 with SMTP id
 f2-20020a5d50c2000000b003332fd25d51mr3535271wrt.131.1701707315273; Mon, 04
 Dec 2023 08:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20231120144642.591358648@infradead.org> <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com>
 <20231122111517.GR8262@noisy.programming.kicks-ass.net> <CABCJKufBiJjUdmnuy=HkV+dDnZ=xne-OBwPSfJ21RX9c0AzCZw@mail.gmail.com>
In-Reply-To: <CABCJKufBiJjUdmnuy=HkV+dDnZ=xne-OBwPSfJ21RX9c0AzCZw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Dec 2023 08:28:21 -0800
Message-ID: <CAKwvOd=ZgoeXQAZZoLNYmd0OyuHktsnxLtcKzH4MEoDkPXnqyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, davem@davemloft.net, dsahern@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        keescook@chromium.org, nathan@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        jpoimboe@kernel.org, joao@overdrivepizza.com, mark.rutland@arm.com
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

On Fri, Dec 1, 2023 at 3:54=E2=80=AFPM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> On Wed, Nov 22, 2023 at 3:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > So the kCFI thing is 'new' but readily inspected by objdump or godbolt:
> >
> >   https://godbolt.org/z/sGe18z3ca
> >
> > (@Sami, that .Ltmp15 thing, I don't see that in the kernel, what
> > compiler flag makes that go away?)
>
> Hmm, that looks like that's what we emit to .kcfi_traps. I suppose
> Godbolt just doesn't show the section directives?

Filter > [uncheck] Directives

>
> https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/X86/kcfi=
.ll#L30
>
> Sami



--=20
Thanks,
~Nick Desaulniers
