Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2647DF8F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjKBRlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjKBRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:41:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11800111;
        Thu,  2 Nov 2023 10:41:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507962561adso1551722e87.0;
        Thu, 02 Nov 2023 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698946889; x=1699551689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzn2jzHX+bghret/10VQDzh2tp42g6RR3V+PJfEnQNs=;
        b=O4C/AZ0jrdYVTN6I8F+GNhswd8cQ8ik4HoWZVmcyiKGJjAfGXzdMoe1uKtc6nJJ/q8
         MFP8vMmCnhDsrUarsmgtNUjJCZ5Lim8ViPOmH9xVbafpmJth6hRRPWu6k5Q8JR5mLery
         vr3mpd5sdCbMUxMSgcSuVPHy/gjndvNMvpzyTkF6tkmwsz4gxQSoj7sjciHFHrZuSAD4
         4dJiHB8zyaa9cn+SaTPX3W8sP1F+KVhinFX2IIYMn84Gfd7jj+uyUajULclp7Wf9G3S+
         +GzOOVTndQQvydqBWIHW/iRtOE7doiKwo2PNmQ48mpOSZl8aFVyJiaUB4PNJhD2thf5g
         ++VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946889; x=1699551689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzn2jzHX+bghret/10VQDzh2tp42g6RR3V+PJfEnQNs=;
        b=XchHQeB3QTzzYXbmH+7hwJ7ewpUp4qcK6NFB2dvZaf7HG6vgI7Y9pyPjJO0rYeH0to
         Tnd0vmXCQ8Z9nAW3SPczK1nDSF8IRpl0pVN51pa8Rmmk/jEd7mOxv4rqI2Nu9Gs9VkdW
         jfiVaZxC9lTc3iF3hGCeRGgmSsH7MX1RUZWPSXHT8LTwPdt+YclKxnf2mU9Fs2BGhWsP
         ytq0QqfqezmVeo7B50Mb26Ezzy8KUWjgyXL9xS6/u9rB6Of/wVxClAxIZtstVC/zsIlD
         S3NdFX6eFZOpglVRO1A+O421UrWAiXVZG6KsqMtAiM/5aAu7HKCD2+ICpiAtLf6ZyFuF
         saxw==
X-Gm-Message-State: AOJu0YwMyrrnd8TK1SXcHQLB4XtuHN74qz30sEwpTV/MAFuC/rqrQTmv
        1EbBCBG2BarA/4Mu7gQP5lzrTndILWVJKtIrPv4=
X-Google-Smtp-Source: AGHT+IGiX/x1OeMpg5zMvPzpvu3QAh2I977YZzenzk1i1Vz8QsslB2cWZM9Sae79AsW+N7cleNN+fwD8Qt1tHg79Go4=
X-Received: by 2002:a19:ad44:0:b0:4fb:9f93:365f with SMTP id
 s4-20020a19ad44000000b004fb9f93365fmr14300107lfd.38.1698946888958; Thu, 02
 Nov 2023 10:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230908144320.2474-1-puranjay12@gmail.com> <20230908144320.2474-2-puranjay12@gmail.com>
 <ZUPL-TeBpl1WEN7M@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZUPL-TeBpl1WEN7M@FVFF77S0Q05N.cambridge.arm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Nov 2023 10:41:17 -0700
Message-ID: <CAADnVQKNtMw1JBShJsf003ogfuCF+J7_NeQcKQjgVVAM26ZDDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] arm64: patching: Add aarch64_insn_copy()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 9:19=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> Hi Puranjay,
>
> On Fri, Sep 08, 2023 at 02:43:18PM +0000, Puranjay Mohan wrote:
> > This will be used by BPF JIT compiler to dump JITed binary to a RX huge
> > page, and thus allow multiple BPF programs sharing the a huge (2MB)
> > page.
> >
> > The bpf_prog_pack allocator that implements the above feature allocates
> > a RX/RW buffer pair. The JITed code is written to the RW buffer and the=
n
> > this function will be used to copy the code from RW to RX buffer.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  arch/arm64/include/asm/patching.h |  1 +
> >  arch/arm64/kernel/patching.c      | 41 +++++++++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm=
/patching.h
> > index 68908b82b168..f78a0409cbdb 100644
> > --- a/arch/arm64/include/asm/patching.h
> > +++ b/arch/arm64/include/asm/patching.h
> > @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
> >  int aarch64_insn_write(void *addr, u32 insn);
> >
> >  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> > +void *aarch64_insn_copy(void *dst, const void *src, size_t len);
> >
> >  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
> >  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> > diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.=
c
> > index b4835f6d594b..243d6ae8d2d8 100644
> > --- a/arch/arm64/kernel/patching.c
> > +++ b/arch/arm64/kernel/patching.c
> > @@ -105,6 +105,47 @@ noinstr int aarch64_insn_write_literal_u64(void *a=
ddr, u64 val)
> >       return ret;
> >  }
> >
> > +/**
> > + * aarch64_insn_copy - Copy instructions into (an unused part of) RX m=
emory
> > + * @dst: address to modify
> > + * @src: source of the copy
> > + * @len: length to copy
> > + *
> > + * Useful for JITs to dump new code blocks into unused regions of RX m=
emory.
> > + */
> > +noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len=
)
> > +{
> > +     unsigned long flags;
> > +     size_t patched =3D 0;
> > +     size_t size;
> > +     void *waddr;
> > +     void *ptr;
> > +     int ret;
> > +
> > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > +
> > +     while (patched < len) {
> > +             ptr =3D dst + patched;
> > +             size =3D min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> > +                          len - patched);
> > +
> > +             waddr =3D patch_map(ptr, FIX_TEXT_POKE0);
> > +             ret =3D copy_to_kernel_nofault(waddr, src + patched, size=
);
> > +             patch_unmap(FIX_TEXT_POKE0);
> > +
> > +             if (ret < 0) {
> > +                     raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +                     return NULL;
> > +             }
> > +             patched +=3D size;
> > +     }
> > +     raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +
> > +     caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
>
> As Xu mentioned, either this needs to use flush_icache_range() to IPI all=
 CPUs
> in the system, or we need to make it the caller's responsibility to do th=
at.
>
> Otherwise, I think this is functionally ok, but I'm not certain that it's=
 good
> for BPF to be using the FIX_TEXT_POKE0 slot as that will serialize all BP=
F
> loading, ftrace, kprobes, etc against one another. Do we ever expect to l=
oad
> multiple BPF programs in parallel, or is that serialized at a higher leve=
l?

bpf loading is pretty much serialized by the verifier.
It's a very slow operation.
