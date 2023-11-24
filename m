Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D697A7F721D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbjKXKxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjKXKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:53:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF291BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:53:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-285636785ddso1216277a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700823199; x=1701427999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G13q4Npyv/Ly9t6e83+KIY+krKu4thVjMslYff6WcPI=;
        b=EJcSyp3YLMqAnDWIZf7+QSxzyWIrVOM7ZFjx3xpbO/iP6aZZA8sQDS1x5VcRUmyycm
         dqvXwdlpdXnCxTwaAR7UYflX8598ojNcUeCB/Fl1x0g+vAZ8fI/W1nozcP7/sA3f0r8P
         WtSmDnbYwSYLuD5NVoJ/qBU7lBd30GunQ5oXSebijFz6c+O0sMrNsYUf8PLqI8bbYByX
         ix0CmYpasQuH+G/2OIgkff6IKJZwZOUjLLSAT4fTBZqBuZNdZsto2hV6ZcmHikQX1EuD
         sIVd03GrhmBpIOrvB5n5gjljOU2GhlaQOtCIS/S/PF8OX+dpamYYua+nsW+vREnthu0n
         PcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823199; x=1701427999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G13q4Npyv/Ly9t6e83+KIY+krKu4thVjMslYff6WcPI=;
        b=ELQJ2Zr9ag5LzMuzqvmpuM6XuEcNZL1XhF1QpKqwC/CUqyMA3OUHsJq8lPjp4womEM
         M9cpR3BJZV+Oa0i2A6/icmokAIx2EIMHA13JbAK8LYOchuy2f1mlC+MbbJ1OSrAeSVCY
         UepBmoklrM67R8fxiarWrVSAhirlXvMYIpEeLdt58A1ziX2wKJKhYge/ouJs92yi1aXo
         J+adSiPqx0CgszlELO70onbdZBaWGPYh8zXxiAsWMlhpHMLS6WJK0Xjp/kdR7o8vcCqK
         SYa4YGbgpk0SwBENp/k8tDrv+ZE9fV9daiIt9vz8X0d3E243pcCMfxL9Vyv+zNkSSJ6c
         2ZPQ==
X-Gm-Message-State: AOJu0Yzr+8mYxC5g9ODbOmT4dvCtruVcDYCqOQfvA1S3uepnNFtBZcD6
        cqFK1+P4/LdbJTN5rAAfhT5gfG+vle0m1xxHKPW4Dg==
X-Google-Smtp-Source: AGHT+IFIeQIFowpfBFOWrzbJuo6dqXpVySOYNiIwl+Kh/YJg26vm2tehxdWw4alf5s2od+tF6f8fxXN9ap5KOjqXBjQ=
X-Received: by 2002:a17:90b:4d0e:b0:280:62a7:3743 with SMTP id
 mw14-20020a17090b4d0e00b0028062a73743mr2278223pjb.30.1700823199176; Fri, 24
 Nov 2023 02:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu> <20231124101519.GP3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231124101519.GP3818@noisy.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date:   Fri, 24 Nov 2023 11:53:06 +0100
Message-ID: <CAEg0e7j1AvzTyaQ45wUP9QnsMpCG=ZMzcLNFYhGPPSgAwsty6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > The upcoming RISC-V Ssdtso specification introduces a bit in the senvcf=
g
> > CSR to switch the memory consistency model at run-time from RVWMO to TS=
O
> > (and back). The active consistency model can therefore be switched on a
> > per-hart base and managed by the kernel on a per-process/thread base.
>
> You guys, computers are hartless, nobody told ya?

That's why they came up with RISC-V, the ISA with hart!

> > This patch implements basic Ssdtso support and adds a prctl API on top
> > so that user-space processes can switch to a stronger memory consistenc=
y
> > model (than the kernel was written for) at run-time.
> >
> > I am not sure if other architectures support switching the memory
> > consistency model at run-time, but designing the prctl API in an
> > arch-independent way allows reusing it in the future.
>
> IIRC some Sparc chips could do this, but I don't think anybody ever
> exposed this to userspace (or used it much).
>
> IA64 had planned to do this, except they messed it up and did it the
> wrong way around (strong first and then relax it later), which lead to
> the discovery that all existing software broke (d'uh).
>
> I think ARM64 approached this problem by adding the
> load-acquire/store-release instructions and for TSO based code,
> translate into those (eg. x86 -> arm64 transpilers).
>
> IIRC Risc-V actually has such instructions as well, so *why* are you
> doing this?!?!

Not needing a transpiler is already a benefit.
And the DTSO approach also covers the cases where transpilers can't be used
(e.g. binary-only executables or libraries).

We are also working on extending ld.so such, that it switches to DTSO
(if available) in case the user wants to start an executable that was
compiled for Ztso or loads a library that was compiled for Ztso.
This would utilize the API that is introduced in this patchset.
