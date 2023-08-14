Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE477C027
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjHNS6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHNS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:58:09 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863DBC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:58:08 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64721b1bae3so4756576d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692039487; x=1692644287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oac1NakR4+HaQnJJS2KWoIl9BhM/PnITDXJaAOB1MhA=;
        b=KCQ/YHJETF/2Df9lkPM1TTVA7PA0w1q72mWHR4hS1h41MeLVSVpKsp3CBY9hITwGqK
         ownUaLQqz1gUDeCDtbmGfbE/a/OjIJQAcWLh8rCeKOybhW79U5CuO8POtNnsvXt92dIc
         lL8oK3egA15RsuGjUwIAMd1M56ljwg19utRJjeaUrYJ6vVGPO2n/m941+3xHMdpoiLPM
         R51H+/aEvwWTbLtur1yzV+lqAeXW0UxHIFnSck7ADZg4PZLkuvl+IsYjRaVO9IAIlE8Z
         6/wmM1SBVdZLB9EGtXTovRvQeJBM8n1y3DupVKEdzw0YeZRpn6FplAN+ktXOgmXTfiY6
         Wokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039487; x=1692644287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oac1NakR4+HaQnJJS2KWoIl9BhM/PnITDXJaAOB1MhA=;
        b=iGq2kPYErNADg5BER1nYcKZlbOv21nwWHACEoFvTBjlrjoqTFZGBFiOMKsUZNmD2uz
         qIUc/ZUrNuGnR9VZUYBweYCCKLRiRaduZEoSMOwgks0YA4fINyKjXJ6Oxg4rwnwYzXRp
         CjpoDPzZWpyZef6RtxjBt0S/TLKowaQY3J0xLwtLTC+Q3+Wra9Jyc9Mqyw+L5HvfQVcq
         rf8e79TlOoRfyPgVkTSvjaQ5STyt/dEXJcBdOcM4qGxY7+oCBUbSeWYfKsGwYXFyLB+d
         ur5ZmgjhskjQcV3+7E/o3lRTvweGz/sRjzOw5uGyoX3viuxTZT1M/EixG9+g1ct9PIe8
         L/gw==
X-Gm-Message-State: AOJu0Yzgk+SFlQSMrtYa3K+GWmDxVplcV/QctY4l+zWS2bKLNV3ukWZl
        KTee2OQZrgmZzjtjGRINwraNSt+FoxB13hKRUCMO3+uD8N8ead4tJD8gWg==
X-Google-Smtp-Source: AGHT+IE32kh7x2+dcklNNiRoqDp5BNyANmBCjjAzTj/cO0aLBpoCCh6CXSViX91o9TRqjJ6Mf8Rp18OSE3KZcedzIOs=
X-Received: by 2002:a0c:b317:0:b0:63c:f0f9:fedf with SMTP id
 s23-20020a0cb317000000b0063cf0f9fedfmr6421263qve.4.1692039487497; Mon, 14 Aug
 2023 11:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230811233556.97161-7-samitolvanen@google.com>
 <20230814175928.GA1028706@dev-arch.thelio-3990X> <202308141131.6B90A4205@keescook>
In-Reply-To: <202308141131.6B90A4205@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 14 Aug 2023 11:57:30 -0700
Message-ID: <CABCJKueV8N4pDBFmw0aWn3wqeyjWUVTGotiC-gjMohJtw=_97Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] riscv: SCS support
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
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

On Mon, Aug 14, 2023 at 11:33=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Mon, Aug 14, 2023 at 10:59:28AM -0700, Nathan Chancellor wrote:
> > Hi Sami,
> >
> > On Fri, Aug 11, 2023 at 11:35:57PM +0000, Sami Tolvanen wrote:
> > > Hi folks,
> > >
> > > This series adds Shadow Call Stack (SCS) support for RISC-V. SCS
> > > uses compiler instrumentation to store return addresses in a
> > > separate shadow stack to protect them against accidental or
> > > malicious overwrites. More information about SCS can be found
> > > here:
> > >
> > >   https://clang.llvm.org/docs/ShadowCallStack.html
> > >
> > > Patch 1 is from Deepak, and it simplifies VMAP_STACK overflow
> > > handling by adding support for accessing per-CPU variables
> > > directly in assembly. The patch is included in this series to
> > > make IRQ stack switching cleaner with SCS, and I've simply
> > > rebased it. Patch 2 uses this functionality to clean up the stack
> > > switching by moving duplicate code into a single function. On
> > > RISC-V, the compiler uses the gp register for storing the current
> > > shadow call stack pointer, which is incompatible with global
> > > pointer relaxation. Patch 3 moves global pointer loading into a
> > > macro that can be easily disabled with SCS. Patch 4 implements
> > > SCS register loading and switching, and allows the feature to be
> > > enabled, and patch 5 adds separate per-CPU IRQ shadow call stacks
> > > when CONFIG_IRQ_STACKS is enabled.
> > >
> > > Note that this series requires Clang 17. Earlier Clang versions
> > > support SCS on RISC-V, but use the x18 register instead of gp,
> > > which isn't ideal. gcc has SCS support for arm64, but I'm not
> > > aware of plans to support RISC-V. Once the Zicfiss extension is
> > > ratified, it's probably preferable to use hardware-backed shadow
> > > stacks instead of SCS on hardware that supports the extension,
> > > and we may want to consider implementing CONFIG_DYNAMIC_SCS to
> > > patch between the implementation at runtime (similarly to the
> > > arm64 implementation, which switches to SCS when hardware PAC
> > > support isn't available).
> >
> > I took this series for a spin on top of 6.5-rc6 with both LLVM 18 (buil=
t
> > within the past couple of days) and LLVM 17.0.0-rc2 but it seems that
> > the CFI_BACKWARDS LKDTM test does not pass with
> > CONFIG_SHADOW_CALL_STACK=3Dy.
> >
> >   [   73.324652] lkdtm: Performing direct entry CFI_BACKWARD
> >   [   73.324900] lkdtm: Attempting unchecked stack return address redir=
ection ...
> >   [   73.325178] lkdtm: Eek: return address mismatch! 0000000000000002 =
!=3D ffffffff80614982
> >   [   73.325478] lkdtm: FAIL: stack return address manipulation failed!
> >
> > Does the test need to be adjusted or is there some other issue?
>
> Does it pass without the series? I tried to write it to be
> arch-agnostic, but I never tested it on RISC-V. It's very possible that
> test needs adjusting for the architecture. Besides the label horrors,
> the use of __builtin_frame_address may not work there either...

Looks like __builtin_frame_address behaves differently on RISC-V.
After staring at the disassembly a bit, using
__builtin_frame_address(0) - 1 instead of + 1 seems to yield correct
results. WIth that change, here's the test without SCS:

# echo CFI_BACKWARD > /sys/kernel/debug/provoke-crash/DIRECT
[   16.272028] lkdtm: Performing direct entry CFI_BACKWARD
[   16.272368] lkdtm: Attempting unchecked stack return address redirection=
 ...
[   16.272671] lkdtm: ok: redirected stack return address.
[   16.272885] lkdtm: Attempting checked stack return address redirection .=
..
[   16.273384] lkdtm: FAIL: stack return address was redirected!
[   16.273755] lkdtm: This is probably expected, since this kernel
(6.5.0-rc5-00005-g5a1201f89265-dirty riscv64) was built *without*
CONFIG_ARM64_PTR_AUTH_KERNEL=3Dy nor CONFIG_SHADOW_CALL_STACK=3Dy

And with SCS:

# echo CFI_BACKWARD > /sys/kernel/debug/provoke-crash/DIRECT
[   17.429551] lkdtm: Performing direct entry CFI_BACKWARD
[   17.430184] lkdtm: Attempting unchecked stack return address redirection=
 ...
[   17.431402] lkdtm: ok: redirected stack return address.
[   17.432031] lkdtm: Attempting checked stack return address redirection .=
..
[   17.432861] lkdtm: ok: control flow unchanged.

Sami
