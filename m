Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48387F1DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjKTT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKTT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:58:47 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888BC92
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:58:42 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507b9408c61so6435909e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700510321; x=1701115121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6WkgVUoD3SnWmkPFjtoqV6NgRmZV236ikrSdXbMFDs=;
        b=WRilgRtxvpWMwFhorRm/HYaaLUvx6bj5clcUzG0mAWQUUvoUXmmwZhD+IgbI+GNK3r
         LaI1oJ2nQ7QNzXTOEr+sl+pTQswWIH4PLBUzQNEbNFRy71G1aKXqcYsJN9JvTXVKt5Ae
         tGIGr/+UgDbYmypQi2BuLw9NpH+b3X2UWd9Vbm+DeR4dfVVkXLEE1HZsyqyHapJ4DLfk
         eulTUyi83RDouVQDoYAHeYL2BR2tUVpsn3iyhJM4IgSpY1Kh510lWB6S30PQddq8iIdG
         q2IZykYBZYzOweU3I3MV9tmwMK65GrB9BHfPyfwEtp7yj74e/1ahf5tnPv71d1dQRsLw
         Rexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510321; x=1701115121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6WkgVUoD3SnWmkPFjtoqV6NgRmZV236ikrSdXbMFDs=;
        b=c+iNMKHVlbkAMaHhZLTn9kTHIdDREP6ZfpMHtHP/f21JROUMWRwvrY05OXGmLWdTeN
         91WGe8k6UY97BN0SHR5pNfy8u3jE1ujQKf3UOxFLbyx1yb/QfhYmd3sRzWLDiTv3RCCe
         AaAMfUvvqU8ibsSRe/l3luX8fWseLcVB1R15NRyvnkoJUtk5AzCNK82b78uebvEqmKWs
         4P13OZQcz/nM0Yqbc1FxSbAK4cFSASKYJGaAurr58nZYziCTX761vneKuI1d+52Lv4A9
         Mp+qSNjnKeKR9tF2gaup6c6pdN7b0XituPgWkzKE4yCYFsE9DehOcHccoPr7yoFsNyXy
         +3fg==
X-Gm-Message-State: AOJu0YzZiScMvBIZ0SDmNzFYrgF8GV+zHNPA89KYHTQZjpSjEYfxmm7i
        704uPRFkSQaAOngm8zzDAlH/eyh+9GpuosIkg4Q=
X-Google-Smtp-Source: AGHT+IEtqiMAMzLAZTYK1FgRvLuCO1/fevEHjBBJc2aEPDRa6CSoRPOdaZC953NsTzNIXIlcGJtBPDw7F79H7Jq5uEc=
X-Received: by 2002:a05:6512:312a:b0:500:99a9:bc40 with SMTP id
 p10-20020a056512312a00b0050099a9bc40mr6023187lfd.69.1700510320296; Mon, 20
 Nov 2023 11:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20231120153419.3045-1-ubizjak@gmail.com> <20231120171507.GGZVuUG9aSLyF52jHd@fat_crate.local>
In-Reply-To: <20231120171507.GGZVuUG9aSLyF52jHd@fat_crate.local>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 20 Nov 2023 20:58:29 +0100
Message-ID: <CAFULd4aYe=B_Jiag1S4hO0XRXB-Y4UKh2Lat79JOLOB1h8ev4A@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/encrypt: Use %a asm operand modifier to obtain
 %rip-relative address
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Mon, Nov 20, 2023 at 6:15=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Nov 20, 2023 at 04:33:50PM +0100, Uros Bizjak wrote:
> > The "a" asm operand modifier substitutes a memory reference, with the
> > actual operand treated as address.  For x86_64, when a symbol is
> > provided, the "a" modifier emits "sym(%rip)" instead of "sym".
> >
> > Clang allows only "i" and "r" operand constraints with an "a" modifier,
> > so the patch normalizes the modifier/constraint pair to "a"/"i"
>
> s/the patch normalizes/normalize/
>
> > which is consistent between both compilers.
> >
> > No functional change intended.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/mm/mem_encrypt_identity.c | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encry=
pt_identity.c
> > index d73aeb16417f..6a351fdd1b39 100644
> > --- a/arch/x86/mm/mem_encrypt_identity.c
> > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > @@ -346,9 +346,7 @@ void __init sme_encrypt_kernel(struct boot_params *=
bp)
> >        * We're running identity mapped, so we must obtain the address t=
o the
> >        * SME encryption workarea using rip-relative addressing.
> >        */
> > -     asm ("lea sme_workarea(%%rip), %0"
> > -          : "=3Dr" (workarea_start)
> > -          : "p" (sme_workarea));
> > +     asm ("lea %a1, %0" : "=3Dr" (workarea_start) : "i" (sme_workarea)=
);
>
> Yeah, I saw that particular subthread today.
>
> Are you sure this "a" modifier DTRT with all gcc version we support?
>
> I.e., from 5.1 onwards...

Yes [1].

[1] https://godbolt.org/z/aWe7b16rT

Thanks,
Uros.
