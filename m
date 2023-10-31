Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC437DCBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjJaL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjJaL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:26:29 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C000B97;
        Tue, 31 Oct 2023 04:26:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 882F840E0199;
        Tue, 31 Oct 2023 11:26:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PEu3gr-Fzv-u; Tue, 31 Oct 2023 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698751580; bh=HpQ8ZkAVavcyZf/94v7pvHGWiVGSMkblV18kYeeITcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdR6KpbXenVdYcGY0s5/zFnql2bUXkU7ZJ/pjnbSISP26SIaJHQVYxLUxMiT/Jy9m
         AFzCk4tft5qFD4R3vL0cfC0YQYYt54nrob0SYZ5UVtK9pUT4VLUoo+lOVvcju8Kw5o
         TJQfy2BHRr5ROGhBGfy53Hy5a/CzEuq96CciJp7zUG39lbRxldxUvhBEKYdQHloC3c
         gozROJwGMVBBWH5hg+eJ8tTyu6AXPIGV7G2aJkQ/PQ0kVtxlXjOaHOzxKhPxEVs6JW
         3YbbsdZ+6DpSzAiLiTacYH2PlHSIeJyVzDCkgAJg4n6DULLNTXLf4irkXK8HORq64f
         HTHzSCkjtLnM2qZYp6RebhXAt0b2KqRkua1WnKWZPPMBhqKie3ost+cYy0Kd8miE2+
         9IFf0Uy2h5zwnMcNO+NML1HwgWe/AbLGg5hBZgDWoyIuCjONM+8XEU4bQWntslVr4/
         JM3q4rZH4rbyG0t1M92Crj3xBqKitxh2IAec1wLsSAyUdkUlb7sJt7mZNAg7n1jyp5
         dyTmmwvrFDhDmsvk/xUZZLK9vDImChT2R14pIPi8KO0xFEOZgHYMeCAuY7iVhRxEJT
         0nrz1Feg13Uq0VPggME7XL5Kjne1tiw1BQ19AbrF7OWmKXJS0HaceDhpz1b/Ibn/Bj
         /4r2Gw3vsVjbpG57sGCLqRbA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A369D40E014B;
        Tue, 31 Oct 2023 11:26:05 +0000 (UTC)
Date:   Tue, 31 Oct 2023 12:25:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] x86: Let AS_WRUSS depend on X86_64
Message-ID: <20231031112558.GAZUDkRrkEStZqDnz4@fat_crate.local>
References: <20231031102111.32142-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031102111.32142-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-kbuild@vger.kernel.org

On Tue, Oct 31, 2023 at 11:21:11AM +0100, Jiri Slaby (SUSE) wrote:
> Since commit 18e66b695e78 ("x86/shstk: Add Kconfig option for shadow
> stack"), AS_WRUSS is set even in 32-bit .configs. It is due to how
> Kbuild works. .config is not considered during make oldconfig (and other
> make *config), so standard (64-bit) gcc is invoked from 'as-instr'
> Kbuild tests. And such gcc indeed reports that wruss is supported, so
> AS_WRUSS=y is set.
> 
> Provided the wruss instruction is 64-bit only (and used in pure 64-bit
> X86_USER_SHADOW_STACK), it has little sense to have AS_WRUSS=y set on
> 32-bit.
> 
> Therefore, make the whole test dependent on X86_64 to ensure it's set
> only on 64-bit.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Pengfei Xu <pengfei.xu@intel.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/Kconfig.assembler | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> index 8ad41da301e5..a5b5241711e3 100644
> --- a/arch/x86/Kconfig.assembler
> +++ b/arch/x86/Kconfig.assembler
> @@ -27,5 +27,6 @@ config AS_GFNI
>  
>  config AS_WRUSS
>  	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
> +	depends on X86_64
>  	help
>  	  Supported by binutils >= 2.31 and LLVM integrated assembler
> -- 
> 2.42.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
