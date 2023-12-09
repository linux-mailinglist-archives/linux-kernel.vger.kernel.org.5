Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1480B56F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjLIRQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjLIRQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:16:26 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0F10D0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:16:31 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so37568771fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702142190; x=1702746990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxsGmux7dCseCaLJY44QbjcD0adKvjqkLZqQBFGfOv8=;
        b=aUun7pUW7kJbhB2rEd4E7RrslUO7kPYNcK9lQorbeWmLxmuRWiM8RsK6GNg2WHpzT8
         U1cw+d+HuUy4AHjclluRt1Eg4Fai20js4cLwQ0JlhIs9fbTBHWsj4WFhHb7zDsjXsIeZ
         C62ZmoKuOkOIeMnytFzWiEZ2fLTWc3u3gYzb7y3tg6tIMB1/MWg/d6gGStd1/agrJP0d
         VtT1nfw0ehPndS8TTQXvlvaFpPiN1Pe4HlDkSCER9OIRIJAxCbwSdqUj/CFUgkL9ij8b
         vEsi0Iw8Fvet5nTJ0Z1/tZMtlbvN+cLWbA6r0GpKAaaiPpHiQQgG1h9YINOkhgOHKid2
         m3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142190; x=1702746990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxsGmux7dCseCaLJY44QbjcD0adKvjqkLZqQBFGfOv8=;
        b=PbQTnfBoDQsH4SfKQhAsuUYK84Ldk6AkoZe/Uy5HagHP2Dbu2WO7K77EoeSLPFx4LL
         +KNdkZH3IsPbiJ/0+pOlhQRhv2kDM0Ucp5nGiUQAonNSMxpr4y4qEW20niGrmVpigK2T
         yc9t5Sc2eE4xhnPHW1g9ycZD2WAK7NV+URKRfyCvmnmc820+IB9oHuG5mWRlbhzlSRhK
         PGVpJ3FO64DIXS2BHLOoUyn4M/FxmyBgNWA1yfL7J5LK+Yyqhrb88YCRre4iMhB3FMUD
         zVUYS1W31ErwkuB0T5+EPZjZS/nRw54uhHIUrTSLXAmNVD3ASZ/8p84HgDJe64I3UcvC
         Yh+g==
X-Gm-Message-State: AOJu0Yy4tckkWDPgwyJ/iuWrK4+/qoarRj4Aa/JYmmjl4ppXpxkKTZv3
        cqTedEw8RZ+/q5+jHlvJCTa2ToAjpzA5jc9OZA==
X-Google-Smtp-Source: AGHT+IHE7bAmPMqyoVm/iHYZZX99SvHrEMIYKRR1bBwSekxWwwiV7AMRK1JcNMYaNdWc/Zo5chV/WiINw9sDqeYAn6Q=
X-Received: by 2002:a19:5f57:0:b0:50c:221a:f19 with SMTP id
 a23-20020a195f57000000b0050c221a0f19mr529354lfj.43.1702142189525; Sat, 09 Dec
 2023 09:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20231206004654.2986026-1-mhal@rbox.co>
In-Reply-To: <20231206004654.2986026-1-mhal@rbox.co>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 9 Dec 2023 12:16:17 -0500
Message-ID: <CAMzpN2jcEGBcEKbNjwMJ+VCMc-_N1GcpVkGgAhy=XzomJP-Ogw@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: UMIP emulation leaking kernel addresses
To:     Michal Luczaj <mhal@rbox.co>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, luto@kernel.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 5, 2023 at 8:22=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> User space executing opcode SGDT on a UMIP-enabled CPU results in
> #GP(0). In an effort to support legacy applications, #GP handler calls
> fixup_umip_exception() to patch up the exception and return a dummy
> value:
>
>         if (static_cpu_has(X86_FEATURE_UMIP)) {
>                 if (user_mode(regs) && fixup_umip_exception(regs))
>                         goto exit;
>         }
>
> SGDT is emulated by decoding the instruction and copying dummy data to
> the memory address specified by the operand:
>
>         uaddr =3D insn_get_addr_ref(&insn, regs);
>         if ((unsigned long)uaddr =3D=3D -1L)
>                 return false;
>
>         nr_copied =3D copy_to_user(uaddr, dummy_data, dummy_data_size);
>         if (nr_copied  > 0) {
>                 /*
>                  * If copy fails, send a signal and tell caller that
>                  * fault was fixed up.
>                  */
>                 force_sig_info_umip_fault(uaddr, regs);
>                 return true;
>         }
>
> Decoder handles segmentation, so for "sgdt %ss:(%rax)" the value of
> `uaddr` will be correctly (in compatibility mode) shifted by the base
> address of the segment. There's a catch though: decoder does not check
> segment's DPL, nor its type.
>
> ptrace() can be used to prepare a RPL=3D3 selector for a S=3D0/DPL=3D0
> segment, potentially one with a kernel space base address. On return to
> user space, CPU will reject such selector load; exception will be
> raised. But because the #GP handler sees no distinction between
> SGDT-induced #GP(0) and IRET-induced #GP(selector), emulator will kick
> in and process the malformed @regs->ss.
>
> If the first 4 GiB of user space are unmapped or non-writable,
> copy_to_user() will fail, and signal to user will reveal `uaddr` -- i.e.
> the (part of) kernel address. On x86_64, addresses of GDT_ENTRY_TSS (for
> each CPU) and GDT_ENTRY_LDT (when in use) can be fully leaked in a few
> steps.

A different way to plug this is to harden ptrace (and sigreturn) to
verify that the segments are code or data type segments instead of
relying on an IRET fault.

Brian Gerst
