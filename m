Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B402B7BAB65
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjJEUUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJEUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:20:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3B898
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:20:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso2564860a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696537250; x=1697142050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jv/z3TB3Odt5goRzCnIbFz+i1mSEunZSJuHFe7ma6pE=;
        b=Gy11ekm7tZFGinKteR0oykhw19NyU8lddDed1sYR/FJu1r5IbZEOkdpQSMA3LOwp4C
         4anScqGhsbpXlYCQ2dbRVeRoHMN7fFqAHaK8f0aaB+LLI+pZ0VKIUq7L10SOLCH/BtVo
         YCTtHS31IUeHykShJ4dVcDMQyRmCLwnT0f5xTZgUWiufKuYpPhWgIKu7mRZJl5NnQHLG
         PfmppwMSb/bjyjCl287LRs8PlyWf1Sj6qf5ZY4DQOp5cSeIfTDP4/0uGM2RLmAUgYePx
         aHs5xW/AVamvPManttv3L1fyelHojOSG0JVS3oFhSEmG1Dwa88uY30JOg58JP37qRvAK
         H8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696537250; x=1697142050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv/z3TB3Odt5goRzCnIbFz+i1mSEunZSJuHFe7ma6pE=;
        b=RxUoEIb3AgDNB9ya1RsD0n7tCMNQ0oLN1Qk91q+nisAcY1TT0vokus9EkNmLcYxznT
         weAussFVZOoy+/qsna5IhY10xkH+HPHoycnHgWC6nHylhGjQnbdstx0DK9xJ7dSKQVjd
         RwU+xFs0xySfW8ckAZvHrLGCBg94e3Yc/2NUDykmKMnU2rf8wx3b29Q/yEAk+EZ2hXu8
         qrbXmfhPclWTM1pCXlIZRuUdKB/Ac+UAcyO7I4Rt0WBpyQ5SasK4X2557vPj6/QoF641
         12xb7y1mQiRr758GnuONQLYxAdCdFL0YwfbxS2TgmjYdTYRL4iPLiA1zM8sVT/qLRXFX
         TwuA==
X-Gm-Message-State: AOJu0Yw/NpAFIFdYUcuCbuyZAE8gl7MoVLNWksBNs4KN6Hy7upFn3fuP
        zhZA37159xwDvq7VTDqj5HW9ubgTJKU=
X-Google-Smtp-Source: AGHT+IEFLFlebN696oBhy+XzvLgEiPCSBtDKfh3zoDq5Ggg6bBY1wh/gP8/MYuPwca7XWAad3mqv0A==
X-Received: by 2002:a17:906:3156:b0:9b2:bdaf:25da with SMTP id e22-20020a170906315600b009b2bdaf25damr5468166eje.17.1696537250050;
        Thu, 05 Oct 2023 13:20:50 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906831100b009a16975ee5asm1661820ejx.169.2023.10.05.13.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 13:20:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Oct 2023 22:20:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
Message-ID: <ZR8an4+JbkLS8/Ol@gmail.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
 <ZR5yTecBhCFsVOtQ@gmail.com>
 <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Brian Gerst <brgerst@gmail.com> wrote:

> Looking at the compiled output, the only suboptimal code appears to be
> the canonical address test, where the C code uses the CL register for
> the shifts instead of immediates.
> 
>  180:   e9 00 00 00 00          jmp    185 <do_syscall_64+0x85>
>                         181: R_X86_64_PC32      .altinstr_aux-0x4
>  185:   b9 07 00 00 00          mov    $0x7,%ecx
>  18a:   eb 05                   jmp    191 <do_syscall_64+0x91>
>  18c:   b9 10 00 00 00          mov    $0x10,%ecx
>  191:   48 89 c2                mov    %rax,%rdx
>  194:   48 d3 e2                shl    %cl,%rdx
>  197:   48 d3 fa                sar    %cl,%rdx
>  19a:   48 39 d0                cmp    %rdx,%rax
>  19d:   75 39                   jne    1d8 <do_syscall_64+0xd8>

Yeah, it didn't look equivalent - so I guess we want a C equivalent for:

-       ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
-               "shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57

instead of the pgtable_l5_enabled() runtime test that 
__is_canonical_address() uses?

Thanks,

	Ingo
