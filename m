Return-Path: <linux-kernel+bounces-107458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080087FCCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB62B281ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672317EF0F;
	Tue, 19 Mar 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLNOkz4c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64C7E793;
	Tue, 19 Mar 2024 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847683; cv=none; b=UC2lfyxTv5fKtoxr/2LhIlqY2rnzWWjO2QF0fv13XqRc14LCI2e91y8NtE+HbZC7wGAYobhT65Ra68jkH7kS0CFProST58YKTZB/fXfLmkzip0yTfAt09ih0ZzyuX+UE7HWPGQJvuh1zWgrA8R/anAklzEEx3ZXEVth+iF+VGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847683; c=relaxed/simple;
	bh=twPAGHLRBfsKsVkZnbEjvZL3s7zbC0tncAHC1XaK5dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcftx417ig2JjhZs5L0v1DgGs66xIwuhAKkZEFTFyiqoEE0PKtDKRew1arQAheCJIq8vFuGOj/qYuLRFBanJUC8kTQ/n1Bbcdb9lBZpFVtILbLnF8Pwc9H7QEwFLfOZvOI9LIsU2KDdI6nSYD+F7RwOjD5ELFQ6y5DMHeBi18zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLNOkz4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2359CC43399;
	Tue, 19 Mar 2024 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710847683;
	bh=twPAGHLRBfsKsVkZnbEjvZL3s7zbC0tncAHC1XaK5dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aLNOkz4cvgP1n1ejCT2N6nMtG34TkOVZKmpeOHR1pQavuvfOYncHU15WkcRtF4aj2
	 L7ZoZYCeFk4BS5E7LVKkqLcWHJmEs+Q1frc4y678/hHLB8RD/H/XlSa+th3+iKNpk1
	 B1dm4zamjFPbsh+vs07bYijeuhGC4HfwFS/JScdSNrr2ou5xQzyzicUkMJjKEy0cxa
	 RjzMD1dvoUJVNQJorw8mjoMvMkLaZY7byjGb7AulZSF+rG6WUE3q4kBv1VM8Twb+K0
	 nFmJ7ned9qNAdzAfkybmHPpZpySbyfqC/s+Ia5w9YGLhPC3IC2fOFCWHdWxYHy3B/j
	 DMv+/K5p0jNsw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so6848773e87.0;
        Tue, 19 Mar 2024 04:28:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOxkivFdnlO2k9pONoBeYd9kmK5rPmRRYPVc0UuBmqERnaw3Diud8HZcp5Vwfe56DO9F2eYF8JrkcoJQ4gdoGTaSERS0ETo7S0P11XyxE5MLmSdHyfo/fJOyhELd69mhpehbsQ
X-Gm-Message-State: AOJu0YznXpvmK/lMLbGGMdpT3A3AhuK6MjE3DvIqv5ojZL4h5QDlldK8
	TbM6wraG3FTvbZCfUvp3XkyXZStL353leIqhlyG5SGsFXOqZ9DsQHLOU5+1OqZiR5ZnB5vl+SQf
	wLtlNkqewhA8D5Af7QndG8tBkcBs=
X-Google-Smtp-Source: AGHT+IFuJ71AXk5oIxu/Mg+E3aUBqrdsvOXSQqcuefNzr510oW03gHr6ZtrrRueXdvAf3Effm3UBjhILjS124+F3JCg=
X-Received: by 2002:a2e:241a:0:b0:2d4:70e8:3630 with SMTP id
 k26-20020a2e241a000000b002d470e83630mr9168960ljk.48.1710847681507; Tue, 19
 Mar 2024 04:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87frwrjc0i.ffs@tglx> <20240318230927.2191933-1-acdunlap@google.com>
In-Reply-To: <20240318230927.2191933-1-acdunlap@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Mar 2024 12:27:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF97CkB4PY8vcWv+WjAN5rv1yhYH-ECSc=-CLRrJmRepg@mail.gmail.com>
Message-ID: <CAMj1kXF97CkB4PY8vcWv+WjAN5rv1yhYH-ECSc=-CLRrJmRepg@mail.gmail.com>
Subject: Re: [PATCH v4] x86/asm: Force native_apic_mem_read() to use the MOV instruction
To: Adam Dunlap <acdunlap@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Arjan van de Ven <arjan@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Peter Gonda <pgonda@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 00:10, Adam Dunlap <acdunlap@google.com> wrote:
>
> When done from a virtual machine, instructions that touch APIC memory
> must be emulated. By convention, MMIO access are typically performed via
> io.h helpers such as 'readl()' or 'writeq()' to simplify instruction
> emulation/decoding (ex: in KVM hosts and SEV guests) [0].
>
> Currently, native_apic_mem_read() does not follow this convention,
> allowing the compiler to emit instructions other than the MOV
> instruction generated by readl(). In particular, when compiled with
> clang and run as a SEV-ES or SEV-SNP guest, the compiler would emit a
> TESTL instruction which is not supported by the SEV-ES emulator, causing
> a boot failure in that environment. It is likely the same problem would
> happen in a TDX guest as that uses the same instruction emulator as
> SEV-ES.
>
> To make sure all emulators can emulate APIC memory reads via MOV, use
> the readl() function in native_apic_mem_read(). It is expected that any
> emulator would support MOV in any addressing mode it is the most generic
> and is what is ususally emitted currently.
>
> The TESTL instruction is emitted when native_apic_mem_read() is inlined
> into apic_mem_wait_icr_idle(). The emulator comes from insn_decode_mmio
> in arch/x86/lib/insn-eval.c. It's not worth it to extend
> insn_decode_mmio to support more instructions since, in theory, the
> compiler could choose to output nearly any instruction for such reads
> which would bloat the emulator beyond reason.
>
> [0] https://lore.kernel.org/all/20220405232939.73860-12-kirill.shutemov@linux.intel.com/
>
> Signed-off-by: Adam Dunlap <acdunlap@google.com>
> Tested-by: Kevin Loughlin <kevinloughlin@google.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
> An alterative to this approach would be to use inline assembly instead
> of the readl() helper, as that is what native_apic_mem_write() does. I
> consider using readl() to be cleaner since it is documented to be a simple
> wrapper and inline assembly is less readable. native_apic_mem_write()
> cannot be trivially updated to use writel since it appears to use custom
> asm to workaround for a processor-specific bug.
>
> Patch changelog:
> V1 -> V2: Replaced asm with readl function which does the same thing
> V2 -> V3: Updated commit message to show more motivation and
> justification
> V3 -> V4: Fixed nits in commit message
>
> Link to v2 discussion: https://lore.kernel.org/all/20220908170456.3177635-1-acdunlap@google.com/
>
>  arch/x86/include/asm/apic.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 9d159b771dc8..dddd3fc195ef 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -13,6 +13,7 @@
>  #include <asm/mpspec.h>
>  #include <asm/msr.h>
>  #include <asm/hardirq.h>
> +#include <asm/io.h>
>
>  #define ARCH_APICTIMER_STOPS_ON_C3     1
>
> @@ -96,7 +97,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
>
>  static inline u32 native_apic_mem_read(u32 reg)
>  {
> -       return *((volatile u32 *)(APIC_BASE + reg));
> +       return readl((void __iomem *)(APIC_BASE + reg));
>  }
>
>  static inline void native_apic_mem_eoi(void)
> --
> 2.43.0.594.gd9cf4e227d-goog
>

