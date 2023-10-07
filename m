Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B11D7BC67B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbjJGJmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjJGJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:42:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8EB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 02:42:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso4842401a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696671724; x=1697276524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gy5vzVLk4tJbCeaxpwwMQD3a2ezpSt+yQcaGyBeeepM=;
        b=CaxDJ7RBiNFjrMp4cF8e9lUG9YWdQD8Rne8CMD0uxiOV45HrNbHSOFnajLttu7AN8j
         Im2iJAGcA3m73fP/ukHVMUQfznjhuSO6hsR1iygJY+y4jhb10t1XvsMgiJlXNVipNxLj
         AymVhwAgoV9e9WcmnekeQdt1u3rn1EP+zck0t+Ib1AzU9axlSTiP5jBQs89HiYkT0nZQ
         /MzxuNuot80+g9XBOOLeNAdSB8RklLWB0f2T1VSsx8eK5ZVbYIxVC1ZcZTOuTN9nepiU
         SXNYAnzFQTnwAfh9yiBbU706/u0ER/s5Z/qHdQldraQD/gdrJWEZ1Ujj8qEk+xIloQNE
         zITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696671724; x=1697276524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy5vzVLk4tJbCeaxpwwMQD3a2ezpSt+yQcaGyBeeepM=;
        b=eDah1RhvBqkdJa9m5i8/s8JF9HILdhwEzZRDotcEdMJBx8td+6Z6C3E5jTyTjpAmDY
         DthhjCGnSnnH6+okIrqjdF4Okkkk5qVhnNxxGkPL99eWuV6jSt45V+N9CKdSAbgXloKs
         zfuPUh2CfkC66DLkQH7aWF6PdzM+n6XBCXxZ6lSsfHq7q1C2vp/5S0MsCBkNrOoBkiSO
         jZoYW7YbTU36qJT5ECTj7bYuGvSlQP7VYV+dcuz/WC3xMCgxrmLzJSYc5chdiFuKDxBn
         L+XGcH8ZD9A0NA2UwFinAv8kDY9LTkgVN6JHvDcCEyxMkMR/NKV2tgvlSxLvZnphixxi
         rGCg==
X-Gm-Message-State: AOJu0YzNkUflTvRHKh33BbP+XbrGAt7VBtGyv66PZg683N2BUKor/szi
        PmWqBLnEghJd9sy4BodkW1Q=
X-Google-Smtp-Source: AGHT+IFPzxdmy5av4pILO6OuDxkIL18jPBhhO5liXcZZiLwVQ561InnhNki9gX7cn8Kx6JGH8jPL3Q==
X-Received: by 2002:a17:906:cc47:b0:9ae:552a:3d3f with SMTP id mm7-20020a170906cc4700b009ae552a3d3fmr8637780ejb.28.1696671723566;
        Sat, 07 Oct 2023 02:42:03 -0700 (PDT)
Received: from gmail.com (195-38-113-164.pool.digikabel.hu. [195.38.113.164])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b0098d2d219649sm4085223ejq.174.2023.10.07.02.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 02:42:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 7 Oct 2023 11:42:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
Message-ID: <ZSEn6BhETrwmry6D@gmail.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
 <ZR5yTecBhCFsVOtQ@gmail.com>
 <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
 <ZR8an4+JbkLS8/Ol@gmail.com>
 <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
 <CAMzpN2jdGc1P4Ha_sO5RZv8M9RsHPA+KU3a9c5BdgX5O3D5Jew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2jdGc1P4Ha_sO5RZv8M9RsHPA+KU3a9c5BdgX5O3D5Jew@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Brian Gerst <brgerst@gmail.com> wrote:

> On Fri, Oct 6, 2023 at 2:59 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On 10/5/23 13:20, Ingo Molnar wrote:
> > >
> > > * Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > >> Looking at the compiled output, the only suboptimal code appears to be
> > >> the canonical address test, where the C code uses the CL register for
> > >> the shifts instead of immediates.
> > >>
> > >>   180:   e9 00 00 00 00          jmp    185 <do_syscall_64+0x85>
> > >>                          181: R_X86_64_PC32      .altinstr_aux-0x4
> > >>   185:   b9 07 00 00 00          mov    $0x7,%ecx
> > >>   18a:   eb 05                   jmp    191 <do_syscall_64+0x91>
> > >>   18c:   b9 10 00 00 00          mov    $0x10,%ecx
> > >>   191:   48 89 c2                mov    %rax,%rdx
> > >>   194:   48 d3 e2                shl    %cl,%rdx
> > >>   197:   48 d3 fa                sar    %cl,%rdx
> > >>   19a:   48 39 d0                cmp    %rdx,%rax
> > >>   19d:   75 39                   jne    1d8 <do_syscall_64+0xd8>
> > >
> > > Yeah, it didn't look equivalent - so I guess we want a C equivalent for:
> > >
> > > -       ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
> > > -               "shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
> > >
> > > instead of the pgtable_l5_enabled() runtime test that
> > > __is_canonical_address() uses?
> > >
> >
> > I don't think such a thing (without simply duplicate the above as an
> > alternative asm, which is obviously easy enough, and still allows the
> > compiler to pick the register used) would be possible without immediate
> > patching support[*].
> >
> > Incidentally, this is a question for Uros: is there a reason this is a
> > mov to %ecx and not just %cl, which would save 3 bytes?
> >
> > Incidentally, it is possible to save one instruction and use only *one*
> > alternative immediate:
> >
> >         leaq (%rax,%rax),%rdx
> >         xorq %rax,%rdx
> >         shrq $(63 - LA),%rdx            # Yes, 63, not 64
> >         # ZF=1 if canonical
> >
> > This works because if bit [x] is set in the output, then bit [x] and
> > [x-1] in the input are different (bit [-1] considered to be zero); and
> > by definition a bit is canonical if and only if all the bits [63:LA] are
> > identical, thus bits [63:LA+1] in the output must all be zero.
> >
> > The first two instructions are pure arithmetic and can thus be done in C:
> >
> >         bar = foo ^ (foo << 1);
> >
> > ... leaving only one instruction needing to be patched at runtime.
> >
> >         -hpa
> 
> One other alternative I have been considering is comparing against
> TASK_SIZE_MAX.  The only user-executable address above that is the
> long deprecated vsyscall page.  IMHO it's not worth optimizing for
> that case, so just let it fall back to using IRET.
> 
>     if (unlikely(regs->ip >= TASK_SIZE_MAX)) return false;
> 
> compiles to:
> 
>  180:   48 b9 00 f0 ff ff ff    movabs $0x7ffffffff000,%rcx
>  187:   7f 00 00
>  18a:   48 39 c8                cmp    %rcx,%rax
>  18d:   73 39                   jae    1c8 <do_syscall_64+0xc8>
> 
> 0000000000000000 <.altinstr_replacement>:
>    0:   48 b9 00 f0 ff ff ff    movabs $0xfffffffffff000,%rcx
>    7:   ff ff 00

That sounds good - and we could do this as a separate patch on top
of your existing  patches, to keep it bisectable in case there's
any problems.

Thanks,

	Ingo
