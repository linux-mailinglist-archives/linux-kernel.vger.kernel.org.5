Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC876BD9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHATWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjHATWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:22:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F581BFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:22:35 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2ED231EC00D9;
        Tue,  1 Aug 2023 21:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690917753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c/RRuNGpmCCaUtjrgZ1nbQ0/GjRcNBS+oG40tfrcyF0=;
        b=jdPXySA0H5noc7+EItmpA25XMlxgEY9VHTlfYa+XWhfIkQZ7mBZVUofE89rjNQxUpW9Ijl
        9FcDzZLZPta3uWphJQkKJigqOGI5LJhz8X9gjzLztfaz/8H0953MlCXvTHZApI0O99MgM/
        3gugtaiSdyy1P2SPiQ/DIa2HDXn+t4E=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KsIQZoxGU-wo; Tue,  1 Aug 2023 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690917750; bh=c/RRuNGpmCCaUtjrgZ1nbQ0/GjRcNBS+oG40tfrcyF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzoYB8Iuk2FV6pVat8v2eS6ZhZ+kG+tRIYEC0MJMJe7RO+woPSksGS/k7UxKjEG2D
         0a084ioLas1j9GE25kjkpD8Bhqw7PgCyaBHIt9rWRYn2iLeRySaBPAiNZXXxxhm1Bb
         JYeuTQu+SXshT+i3IZz4Xw9QgmzZIE8Q+HDr5NCSM7Z46D3VZFpKaEriBjnCB+LnCT
         Xw6jxKNhAlvYQkoghTpcJbJyHSm1xL5F2D+sZJvIgVzSGblL5Wcv+CjIfH3hW/YnRX
         ktipr/0AtDkdCBlNUtUD8Id7ZLx5alez6s621dyPNsSpd7ByFcoOFmsbbeAOLdPd1n
         Ryr4q1MXJcKj2EW+oRrsonR8mKR3WlxDJWMnX6VEgvVcq0e1tw4Z5SxkOn1Qnr1jna
         0T3lFiNPo4wKH5lAuzwJYWboyUdqAOiGdXm2ckvI2rQ8aIT4CS6oEFPSv3LEcXdjek
         5c0SKdXSuV4xpGRDO4reHBz0E4EdYYBTOmbwIUSMgngVZhj7dBZhHCi8iBCCeguMeS
         gwvjlmpSBTS8Qwar1QlK3YNBNLwQj0StoQ/+/plaYDXkibGIxiSf5wBv5O0DinkLQZ
         3uV1AQ8cdNu2hOuHIpe7MGMK1U02VMyIvOcZ+DJKHinfpKckPj9plC+lN79PMAbugt
         0cEuDTNZ0J89l3Xvy7+oPEws=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B64440E019D;
        Tue,  1 Aug 2023 19:22:22 +0000 (UTC)
Date:   Tue, 1 Aug 2023 21:22:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/5] [RESEND] x86: qspinlock-paravirt: fix
 mising-prototype warnings
Message-ID: <20230801192217.GHZMlbaVMBavu909lb@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725134837.1534228-4-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:48:35PM +0200, Arnd Bergmann wrote:
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 89842bb7ec9cc..64a6bba70d183 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -73,11 +73,13 @@ DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>  
>  DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>  
> +#ifdef CONFIG_SMP
>  void __init native_pv_lock_init(void)
>  {
>  	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  		static_branch_disable(&virt_spin_lock_key);
>  }
> +#endif

Can you add an empty UP stub instead?

We all have a great aversion against ifdeffery...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
