Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990476BAB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjHAREy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjHAREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:04:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD33A9C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:54 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD7361EC0478;
        Tue,  1 Aug 2023 19:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690909413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FMDibaT7suG4Vc4/I/Fv2o4jUJfFIZGSBREEjhp8Coo=;
        b=FLTM/P1OTACWIM1XV7nRgB3i0NVqny3Wv6CBvth1eaiIpxjcNO5GGJYQ/KDSbHM5Vd/b5K
        Js+6fgPI0XmzzWaMug87uSjL+G9fK6e8QER58SrPopKj4NR7be8Ry9pyNcsLvoffi/VztJ
        EzfEHqhhZFx11wNH36HXAORGcJFpFL8=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kmFoK7YLfPeN; Tue,  1 Aug 2023 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690909410; bh=FMDibaT7suG4Vc4/I/Fv2o4jUJfFIZGSBREEjhp8Coo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isfqfaioZdNPayiATOeIP8F2CiK5Hf44IWLFXYGpP/QLUYrj+Wntfcmf2YIXxNNri
         wQ5pKGwo9ASq5Fw1ObeMDanBgcuj+XItQ1KeiqRH2RDpVHcnBwG8FGSmYuRf2nNZXY
         mv79dm7DerD4X/bYne6wFJm7atXIngRvJ1jNW+EdRcYw97TTo4BWU1xhsi5g/EAFFm
         YFWnz9g83hoKBoUOw0/oV8OnfidIOhQut6e5YtR9/0CwG9aEFOt5nsAttRnUmZFgFE
         rYtHHVLKpbXvgeiwg8V9+vcw1T6b1iACxfptl1s8jYZCH5OSm+AnESPWAIX7p948ui
         gGWAYnTJd5bWAwR2GQmq2tfNll03pbS8LwK7L2imSL52Vf6/Di7Pte1LK0gQvHcwLa
         aZcmy8aUjA591WSKo72Eibu43p2uxWk+HmYMtBLvcDaC0NP533jywBvUWu0YPU8JnU
         mjoRcxEjrc5TCXIkqta+z0kE7UZ3aqOCbrBwnPXfKBzi51FmSjkK7+JqFqVjnqDzzt
         uezL3PeXVllou0pup5Ty5r1Q/6KmputIz274hvK8OBjsIywFKc6t0qtoJtVA3JKqI/
         vbcAdMaZj0+kIRAnR06nrNlidUMzjo4jeBsQj4P/EDs5OfKW/rgBu3XgTvNIW8FE9w
         7yHFYQmN2Q/p7nVpuALvK02Q=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE3FA40E01CE;
        Tue,  1 Aug 2023 17:03:21 +0000 (UTC)
Date:   Tue, 1 Aug 2023 19:03:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/5] [RESEND] x86: avoid unneeded __div64_32 function
 definition
Message-ID: <20230801170315.GGZMk60zojZOeuUwX7@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725134837.1534228-3-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:48:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The __div64_32() function is provided for 32-bit architectures that
> don't have a custom do_div() implementation. x86_32 has one, and
> does not use the header file that declares the function prototype,
> so the definition causes a W=1 warning:
> 
> lib/math/div64.c:31:32: error: no previous prototype for '__div64_32' [-Werror=missing-prototypes]
> 
> Define an empty macro to prevent the function definition from getting
> built, which avoids the warning and saves a little .text space.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/include/asm/div64.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
> index b8f1dc0761e4b..9826d5fc12e34 100644
> --- a/arch/x86/include/asm/div64.h
> +++ b/arch/x86/include/asm/div64.h
> @@ -71,6 +71,8 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>  }
>  #define mul_u32_u32 mul_u32_u32
>  
> +#define __div64_32 /* not needed */

This comment, *after* having read the commit message makes sense.

When you look at it alone, after having opened the file, makes me
scratch my head and wonder what is that thing supposed to mean. Please
extend it.

And put the comment ontop, not sideways.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
