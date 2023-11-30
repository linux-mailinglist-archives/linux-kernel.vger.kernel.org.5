Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A47FF469
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjK3QJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3QJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:09:04 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB610D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:09:11 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D8C5540E025A;
        Thu, 30 Nov 2023 16:09:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vmHrqSSke-0k; Thu, 30 Nov 2023 16:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701360547; bh=zTZtvACEq3f++TrUvZqGHtgrh6jfU8EyKSKKffsszfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmVb/fcOJfZOj0Ym/Jmy7Yjv+6UCd4lN0F7aglUEE+40lemBTbWTx2PDiJbgG8OBm
         00Busuq/B51qRcsDdCuVqsl8f9rX+Ox0Fz8mEXzOlfNL1HkAUvl3y6yyUPcBLvDcbE
         sq9dUDasOE7PFfM9T6dQCDB5MUrkG5A+oHnBnz66SUb/pTCeLpgXKsppnz4GUXl9xP
         me7pOFLPolGo+PLEGTBMzkxtgSWJ8n1qlJVFXMdKoVtGy1vwwULkAk2Il5SFgvJCfm
         He5kctnnJE3lNt7TSha2zcIvYY3Qn3aGPY3/eaE59QO1jQIIrT+23/ThI+tR3Cxp0q
         PVNaUPO0CmV9MPzwl+HPC86ofPGjjFcqfsPjnQED/EiKGplAhI1UpWtf/RIrOxqru4
         AEeSBMowXxlgaM8kHLdTGgusP6fqePOMOfWUwR4ca4GKaRjMvxBi7YxSxKeghhKfTb
         NmCRwZR15O3OuagrNNmIlSi8wyWc0MFKi1bvLqRID411/mH+HMInY5VVMRHCQNWe35
         cDZubK7fRFN6F6/Avckho8LvhQAZDm/ii1KkojAe16PrenvMOzctBZonOUh/wT2TnT
         o08LcTdhGdR+5f3JGntTkHEo5zXKXGkP4c+YYfs4NvGYOa3OgVMYhNgfS49bS1N+3r
         DuGsWaQhX3IYNv4kGyDzqqEg=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9F9D40E01AD;
        Thu, 30 Nov 2023 16:09:04 +0000 (UTC)
Date:   Thu, 30 Nov 2023 17:09:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH] x86/ia32: State that IA32 emulation is disabled
Message-ID: <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
References: <20231130155213.1407-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130155213.1407-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:52:13PM +0100, Borislav Petkov wrote:
> +static inline bool ia32_enabled_verbose(void)
> +{
> +#ifdef CONFIG_IA32_EMULATION
> +	pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
> +#endif
> +	return ia32_enabled();
> +}

As Nik rightfully points out offlist, this should rather be something
like:

---
	bool enabled = ia32_enabled();

#ifdef CONFIG_IA32_EMULATION
	if (!enabled)
		pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
#endif

	return enabled;
---

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
