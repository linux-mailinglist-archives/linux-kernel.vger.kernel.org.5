Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F597F28F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjKUJ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjKUJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:29:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582EC1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:29:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so5707774a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700558967; x=1701163767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWWIejbf4V8Ii2I3PkswFty/DaeIXLclOkLCoHazGNM=;
        b=Pzdt7G3fo3pMrHJ+O6jeD5K5v2XZFmr2tZK2fUtaoaKPu1tmJavw5kTwc7O5ci1Add
         PdfuHJqfqpyLfDKyxwXaB5wFHOuLIWhXIXRwrS/GjLVib0LXxNf8BBihBNfohdfs5Lvb
         VV7yRm2cGER9WCQdmEtV85wnCQY9kRB304wTKxRlW6ru7Wm+w01FPruswZo9SXhLHGHO
         JuFjbEKF2vfKOs3VDNuFoZ5+GDwPbnJ/BvkXz1E1cI4y/Qm86wbGPR0e85l+rxqKMqCE
         TU+CDfi2uLMVjdL8qSkaLQO3Y8K8jh36zVEyHy9eP78f3kZ+fD933kl4/WL1tg9BiOzY
         d3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558967; x=1701163767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWWIejbf4V8Ii2I3PkswFty/DaeIXLclOkLCoHazGNM=;
        b=vdm+q5gIM4OiJFwCNAfoKZjZXeCkD1l4NYdVnJqszNd2jv8HaM/PapxVDjk/nCcsfF
         rQpLCTlYSqZSTJ464L9PzKx2ew5jze6gkJVujwgs+GUxgsZtx5bvxkBWWEZ8KcHo/5iS
         ff40uxoIR8hc+tOz1IrxXXT6vlmlarv+uy2cJOZfCWWyU/LrtUtYXrM71K1PHUmiqJmh
         Xl4rsfxs8o79pF7EkKLd/OUMzytk/Kq0hjopXxZv/PUtYSfsf/lBfPlUEuQPmty67EOg
         bwY849iwm2kvPaIWT1JQUo1DpgKGGkQfoBneExuqXDVkmwxWlvHeYfIMQvRnL1bU149a
         A9Aw==
X-Gm-Message-State: AOJu0YzDHvF28PVtrCQbM3r1+9gM9iFLzUhTM4g5z8ltc21Z1V33B0Iu
        Z910h1QdL2aZbkoLI6dfDKotkVgnXJZgIbGRbXYlL1V+4SxWjQ==
X-Google-Smtp-Source: AGHT+IEG7P+KX7PEUvOimTW8q8S3thdgM/UHmmqWDBy17OPJzalfv+71sThQoaVdF5/x8pSqysJlBVhlxzJFqqVL21c=
X-Received: by 2002:aa7:da54:0:b0:543:5741:c9cd with SMTP id
 w20-20020aa7da54000000b005435741c9cdmr1362110eds.34.1700558967422; Tue, 21
 Nov 2023 01:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20231120153419.3045-1-ubizjak@gmail.com> <20231120171507.GGZVuUG9aSLyF52jHd@fat_crate.local>
 <CAFULd4aYe=B_Jiag1S4hO0XRXB-Y4UKh2Lat79JOLOB1h8ev4A@mail.gmail.com> <20231121090041.abqwtkbzzwxq22ke@box.shutemov.name>
In-Reply-To: <20231121090041.abqwtkbzzwxq22ke@box.shutemov.name>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 21 Nov 2023 10:29:16 +0100
Message-ID: <CAFULd4Z6MUCHKuJkT7ee9yBXU1yh1ovf9YnJLTYVaxJpfricAQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/encrypt: Use %a asm operand modifier to obtain
 %rip-relative address
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:05=E2=80=AFAM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> On Mon, Nov 20, 2023 at 08:58:29PM +0100, Uros Bizjak wrote:
> > On Mon, Nov 20, 2023 at 6:15=E2=80=AFPM Borislav Petkov <bp@alien8.de> =
wrote:
> > >
> > > On Mon, Nov 20, 2023 at 04:33:50PM +0100, Uros Bizjak wrote:
> > > > The "a" asm operand modifier substitutes a memory reference, with t=
he
> > > > actual operand treated as address.  For x86_64, when a symbol is
> > > > provided, the "a" modifier emits "sym(%rip)" instead of "sym".
> > > >
> > > > Clang allows only "i" and "r" operand constraints with an "a" modif=
ier,
> > > > so the patch normalizes the modifier/constraint pair to "a"/"i"
> > >
> > > s/the patch normalizes/normalize/
> > >
> > > > which is consistent between both compilers.
> > > >
> > > > No functional change intended.
> > > >
> > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > > ---
> > > >  arch/x86/mm/mem_encrypt_identity.c | 16 ++++------------
> > > >  1 file changed, 4 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_e=
ncrypt_identity.c
> > > > index d73aeb16417f..6a351fdd1b39 100644
> > > > --- a/arch/x86/mm/mem_encrypt_identity.c
> > > > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > > > @@ -346,9 +346,7 @@ void __init sme_encrypt_kernel(struct boot_para=
ms *bp)
> > > >        * We're running identity mapped, so we must obtain the addre=
ss to the
> > > >        * SME encryption workarea using rip-relative addressing.
> > > >        */
> > > > -     asm ("lea sme_workarea(%%rip), %0"
> > > > -          : "=3Dr" (workarea_start)
> > > > -          : "p" (sme_workarea));
> > > > +     asm ("lea %a1, %0" : "=3Dr" (workarea_start) : "i" (sme_worka=
rea));
> > >
> > > Yeah, I saw that particular subthread today.
> > >
> > > Are you sure this "a" modifier DTRT with all gcc version we support?
> > >
> > > I.e., from 5.1 onwards...
> >
> > Yes [1].
> >
> > [1] https://godbolt.org/z/aWe7b16rT
>
> But Clang generates RIP-relative load only starting from version 15.
> Clange 11 claimed to be supported.

Huh, what a bummer...

The patch is retracted then.

Thanks,
Uros.
