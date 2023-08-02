Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676A776D4F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHBRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjHBRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:20:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C3E70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:20:48 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E86D1EC00F8;
        Wed,  2 Aug 2023 19:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690996846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5f9hXh7y/Si9wJwqnFqQEWn1Xkw4eZtP/uLG+aXCv8w=;
        b=VmfHPbP8rHCEEMsCr6viukvimlkeDkylyP+i7OOoNCBYzLCffeSA9OtgB4YFmx4T7CfDpa
        mW1XhLGxGKguK7R/Kc50g4SZ30Qwlb0zv0z8I+qZue4d2tpu+D6MVT0gzHTLzLQms7kksV
        fH3LuQlSWTyJ1fJ7NXsO6Ff5o/lIW9w=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l9H-4NY229dO; Wed,  2 Aug 2023 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690996843; bh=5f9hXh7y/Si9wJwqnFqQEWn1Xkw4eZtP/uLG+aXCv8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9a9hWp+ngkkKn0u7WRiz67w9bu07JStf2WminiaV5rsoOITAXyILJS/zgTrMXv7e
         IIm3D/a+C3PADjt/yczMHlMZr3UkwCGpSV6kjq57aPkQtCVw823VU3+EgtbCu1Fmmy
         uTDqyzSESqSdxWH6uxY2TiEsBuh+aFV6Fh/s8oAbqqwdDjPz3vZMeJA4ZV31MGuY3a
         VU+ZfIbpNKIzBkyoSsVHtTNMAzfpcIXGJ/YCNFLkY/1pusjd89kN898Ha346wyjHgl
         qaldiXnAU96CKt9lBBkszdwuj06OSl29HmEGNOcbI75jFtC6gFXrQWdFNSWp5/hbLC
         yNDPpzotr5WF2viwFjF/1SVl5Zf7HeK1W/PVNFK/JCzcg10nTsf73TSQB7FiJk53Gx
         ebUnNcr3hdifPD20NrUFbzmQys9R4wOPvRId0Sug+F5aIN48LffZiUyO6/daskpgPX
         VSXa++AL7wapXkXMsdES9uXmxZFBEYZoEqNTvuUrxhq7GKNsBtmTQF0ZHVOwiaNy1W
         sAKMtAH+V9Ea2/HlkHX1BgFZdy7i3uhhdPQ31WdjU6dADILV1uNETNG7JMgB06Z0w1
         Q1BZQTOfMS9CtcRDr4LoVtZq6ugjIRwKa0DOFHvFHvuQeZcMItDSs1jXsmdTPcp/G4
         ocFZE5xg1qFlFfNsuRQyj4LM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A52140E0207;
        Wed,  2 Aug 2023 17:20:35 +0000 (UTC)
Date:   Wed, 2 Aug 2023 19:20:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/5] [RESEND] x86: avoid unneeded __div64_32 function
 definition
Message-ID: <20230802172030.GEZMqQXmeb98Tm+Qhg@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-3-arnd@kernel.org>
 <20230801170315.GGZMk60zojZOeuUwX7@fat_crate.local>
 <baf750f4-a42c-453a-91dc-7fd457bc1e80@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <baf750f4-a42c-453a-91dc-7fd457bc1e80@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:48:02PM +0200, Arnd Bergmann wrote:
> Right, makes sense. How about this version?
> 
> --- a/arch/x86/include/asm/div64.h
> +++ b/arch/x86/include/asm/div64.h
> @@ -71,6 +71,11 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>  }
>  #define mul_u32_u32 mul_u32_u32
>  
> +/*
> + * __div64_32() is never called on x86, so prevent the
> + * generic definition from getting built.
> + */
> +#define __div64_32
>  
>  #else
>  # include <asm-generic/div64.h>

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
