Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD0F7E9DED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjKMN5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjKMN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:57:16 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FED54
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:57:12 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1CE7F40E0171;
        Mon, 13 Nov 2023 13:57:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bimc4FpwqRg5; Mon, 13 Nov 2023 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699883827; bh=/Xv6YqaVx2Uqc+B0ZtgaLioLedmrT3VC28U0wm7nbnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YokQeuw4aV1A6/uTz1/a04NW1A5PSV7gjaNsWEkohTSmulHz7hWX5NzsddEe7wyPQ
         /WcLvXnYO1+NLuD69NBvHvTr0NGC+UsA1HvI0YAl43o24snYnef2xgUvhKoRHWw/Wx
         wNJfbLP4KRs28o8lfMNgEJe1E5lDZ/bAH1NwtkTu+mW9l5EhzCPm2nIlgAF0+5josQ
         7Smw/sB7IBX1QS0kX7yKPCH9hUCYMukLMqAI+tCPzcTNRxVdktiHV1FQDbKDkVDjiS
         MBMDi8tMeFGOX50zYLo8Z7tsD1mSlgxja3NShfR8jJITbDzWAD+u0hC1LTqllzfX10
         abcrxU0mLZEclTRMIJcc1dShGZaBzCQoM/IzszFgPri0XV8s4tY1mYrV0Yl3+DyFTs
         TQYd63q6WgOAXTdkbrNj8pJgTZHnwshrkmssv9cNdzrJ6C82lCfmOcxfym/qNt2FzM
         LZGG8ALwQcY4PUY92/BX5paJ4q6IywjuEvl94uPLMN0pinoOuZ4qB9fA8yv0V6KZjC
         rF0TOTXR+pFWOcNsFrwkIl2HG1pdEqjKZ4PeyY7jO0iJVauprmWcR+W7Lpq106TCW5
         b1nk+8XSFcKADrtCjbkWtKmaaSF4N72i/kdjwvRfjkc5rGbANI7eJD7G/NGNsgfU8+
         SET6KYXMPoeakRSR4+PVzSOo=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C06F740E0031;
        Mon, 13 Nov 2023 13:57:03 +0000 (UTC)
Date:   Mon, 13 Nov 2023 14:56:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Juergen Gross <jgross@suse.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mtrr: Document missing function parameters in kernel-doc
Message-ID: <20231113135657.GBZVIrKWD8gvvXz8u2@fat_crate.local>
References: <202311130104.9xKAKzke-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202311130104.9xKAKzke-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:54:18AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1b907d0507354b74a4f2c286380cd6059af79248
> commit: 29055dc74287467bd7a053d60b4afe753832960d x86/mtrr: Support setting MTRR state for software defined MTRRs
> date:   5 months ago
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231113/202311130104.9xKAKzke-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231113/202311130104.9xKAKzke-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311130104.9xKAKzke-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/x86/kernel/cpu/mtrr/generic.c:125: warning: Function parameter or member 'start' not described in 'mtrr_type_lookup_fixed'

...

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Mon, 13 Nov 2023 14:52:52 +0100
Subject: [PATCH] x86/mtrr: Document missing function parameters in kernel-doc

Add text explaining what they do.

No functional changes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311130104.9xKAKzke-lkp@intel.com/
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202311130104.9xKAKzke-lkp@intel.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 2d6aa5d2e3d7..d3524778a545 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -428,6 +428,10 @@ void __init mtrr_copy_map(void)
  * from the x86_init.hyper.init_platform() hook.  It can be called only once.
  * The MTRR state can't be changed afterwards.  To ensure that, X86_FEATURE_MTRR
  * is cleared.
+ *
+ * @var: MTRR variable range array to use
+ * @num_var: length of the @var array
+ * @def_type: default caching type
  */
 void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
 			  mtrr_type def_type)
@@ -492,13 +496,15 @@ static u8 type_merge(u8 type, u8 new_type, u8 *uniform)
 /**
  * mtrr_type_lookup - look up memory type in MTRR
  *
+ * @start: Begin of the physical address range
+ * @end: End of the physical address range
+ * @uniform: output argument:
+ *  - 1: the returned MTRR type is valid for the whole region
+ *  - 0: otherwise
+ *
  * Return Values:
  * MTRR_TYPE_(type)  - The effective MTRR type for the region
  * MTRR_TYPE_INVALID - MTRR is disabled
- *
- * Output Argument:
- * uniform - Set to 1 when the returned MTRR type is valid for the whole
- *	     region, set to 0 else.
  */
 u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 {
-- 
2.42.0.rc0.25.ga82fb66fed25


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
