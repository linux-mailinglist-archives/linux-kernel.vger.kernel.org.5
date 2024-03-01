Return-Path: <linux-kernel+bounces-88411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29F86E13D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8945D1C21D8B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394F3FB83;
	Fri,  1 Mar 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms5g/OxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086B22318;
	Fri,  1 Mar 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297111; cv=none; b=h9yYUNLiFy++y7ujwpxaqi6hJKk6G9nA3dfsFnq+BygyM5Fur03vdgfJarRT4uPMPta4hSZfh6zfsTPTwRLCDWOdPt2CGjMtTkzAQuCKHg5lf0jVJNCw2DZNj5mVSrG1UaSKbtK8iXZAt5kn/AOovL5vhZ3iinT4poOBNb9FK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297111; c=relaxed/simple;
	bh=98o10zTss0mAEXMGzWPoEeL9M9D3BtORwDqagTBpay4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZJwxIb2aQ5ch/m393rss4P+gr1jMh3bwtQV+gqlYDF/kPyDsxNrwhlhjZRzyzaxkstN4FcUp7T/j8p6CEq1KcT1nZ6Ch2u5rv2S7e2PJyPbUAdPxZiB7bBwLREJ3vP7TpiwaLZ8836Spshu3KxnQuJxfbpckDVe+PdYXUKO85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms5g/OxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972E6C43601;
	Fri,  1 Mar 2024 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709297110;
	bh=98o10zTss0mAEXMGzWPoEeL9M9D3BtORwDqagTBpay4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ms5g/OxF6wUGQ9bqfJ2Sm09jM2DCTS5ZfHcfVyxIYHkZS+SlMP8d1EIT2328GzWn5
	 +Wl8l+H3+1vcZYxxU2LFrC3VsTmOz4uEzZfjI64pGO6fgXR718D95dNWAH45N9KhTd
	 OkmZxotNFsm6LPjq8I1mY+3vb7gsOFHOQ/yMnpz5bbqz4owlSWxLU7JA+/+gCt5HRW
	 mKU1pMU6tlsw78vSO+lz1Nw6Dhefp2huJzUcSsUfwFpgK6uxs6ujwGJsQKAfs6+TNZ
	 pef3qb716qRUGdr/85jmyIP0RpbROB8AJI6HARoytXaeL3+GB2ktZVsWpYBCqP6But
	 tKJ5Ns3MvYb4g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131c48055cso2123574e87.1;
        Fri, 01 Mar 2024 04:45:10 -0800 (PST)
X-Gm-Message-State: AOJu0Yy614saiHPT0xHVLuRsskYLEwwe2XfQVbCs/NEMKVwt7L3hXx27
	V6YNqDBpL8RRSYNfv0LjanfWavd5cbmxt5OHUfXcK1fOKj6k3TqdiK4VqcGWxA00oUz2zqf9ekG
	bs55NMnEe8QFFdHrmC/mahMr65NY=
X-Google-Smtp-Source: AGHT+IHCMqQHC6Q3m3IZ2gKJRxlP4P8j6bh/AJC5Z6iYOH0vRhtVVAGKMDgVrruf/XgHOanLBBSfEIaFIZ7X8elOdEo=
X-Received: by 2002:a19:f805:0:b0:513:ed5:16af with SMTP id
 a5-20020a19f805000000b005130ed516afmr1219416lff.21.1709297108660; Fri, 01 Mar
 2024 04:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124103859.611372-1-ubizjak@gmail.com> <170929679278.398.4143931058196373559.tip-bot2@tip-bot2>
In-Reply-To: <170929679278.398.4143931058196373559.tip-bot2@tip-bot2>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Mar 2024 13:44:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGc5_AM2AkE+h8EcvYjAGHqeDWRyVRYUGfBjeubeUmJ6Q@mail.gmail.com>
Message-ID: <CAMj1kXGc5_AM2AkE+h8EcvYjAGHqeDWRyVRYUGfBjeubeUmJ6Q@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot: Use 32-bit XOR to clear registers
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 13:39, tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/boot branch of tip:
>
> Commit-ID:     721f791ce1cddfa5f2bf524ac14741bfa0f72697
> Gitweb:        https://git.kernel.org/tip/721f791ce1cddfa5f2bf524ac14741bfa0f72697
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Wed, 24 Jan 2024 11:38:59 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 01 Mar 2024 12:47:37 +01:00
>
> x86/boot: Use 32-bit XOR to clear registers
>
> x86_64 zero extends 32-bit operations, so for 64-bit operands,
> XORL r32,r32 is functionally equal to XORQ r64,r64, but avoids
> a REX prefix byte when legacy registers are used.
>

.. and so this change is pointless churn when not using legacy
registers, right?

> Slightly smaller code generated, no change in functionality.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20240124103859.611372-1-ubizjak@gmail.com
> ---
>  arch/x86/kernel/head_64.S         | 6 +++---
>  arch/x86/kernel/sev_verify_cbit.S | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d295bf6..86136a7 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -169,7 +169,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>         ANNOTATE_NOENDBR
>
>         /* Clear %R15 which holds the boot_params pointer on the boot CPU */
> -       xorq    %r15, %r15
> +       xorl    %r15d, %r15d
>

   0: 4d 31 ff              xor    %r15,%r15
   3: 45 31 ff              xor    %r15d,%r15d


>         /*
>          * Retrieve the modifier (SME encryption mask if SME is active) to be
> @@ -178,7 +178,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>         movq    sme_me_mask, %rax
>  #else
> -       xorq    %rax, %rax
> +       xorl    %eax, %eax
>  #endif
>

This conflicts with my RIP-relative boot cleanup series.

>         /* Form the CR3 value being sure to include the CR3 modifier */
> @@ -295,7 +295,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>
>  .Llookup_AP:
>         /* EAX contains the APIC ID of the current CPU */
> -       xorq    %rcx, %rcx
> +       xorl    %ecx, %ecx
>         leaq    cpuid_to_apicid(%rip), %rbx
>
>  .Lfind_cpunr:
> diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
> index 3355e27..1ab65f6 100644
> --- a/arch/x86/kernel/sev_verify_cbit.S
> +++ b/arch/x86/kernel/sev_verify_cbit.S
> @@ -77,7 +77,7 @@ SYM_FUNC_START(sev_verify_cbit)
>          * The check failed, prevent any forward progress to prevent ROP
>          * attacks, invalidate the stack and go into a hlt loop.
>          */
> -       xorq    %rsp, %rsp
> +       xorl    %esp, %esp
>         subq    $0x1000, %rsp
>  2:     hlt
>         jmp 2b

