Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7180E800B43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378904AbjLAMqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378844AbjLAMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:46:21 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A0DC4;
        Fri,  1 Dec 2023 04:46:26 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8312940E025A;
        Fri,  1 Dec 2023 12:46:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zksQR-TEcRDn; Fri,  1 Dec 2023 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701434781; bh=pbOmWyqxBie0Njw2wSmdFAw8jS4XcfLAnReSNgbm5N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cikcUjj3wn5FcMNDJ9pDSFB2W/DIsPnBMHvnnP21AFB4DPkXlvSKKuu2pYzG0J8eV
         nTcdrak2MIdX5mpV4aSbVmYoTIBkxWn3hCImUb9IwB/RG2YKbNyPbshU6mEGphWDnY
         sMB+mWeQ42lovnBPBZMosfFZK3KsxlTkJxl4EftCg6XhIQm8fhcthEI5sJFA2blLAS
         GgKxw97uDgM5YWZWQihQ3yqSlYR9LDnQr6gonbcv04FJC6Yf8dTgFkGQKxKiniTqgi
         J7lhBnzGMG75rK+7Ryy6DqT9gHgMj6N12obQV/oK+EYSfk4AJDkYzBJggZdQaDJA8S
         D3GAYiwAv9cP3Q/Tj5uhiu3vIiAUobVhq+ocOJB0mAi5XQLTgCmshT593FeLnTWUWQ
         AFmNn8qrM14mj2XQhuSWc2w7zbd8aEF66FO8bWqOaugt7WxArWlg/l+m8nUmYXepSg
         n35ra4FrrFq3/YSEiymG1iSVajxXafVltKtOxb9AK/W5lKKTlwiZMy0/GN/st8RuuE
         Az5I0pHof0QedCD/WrBn3oEnhHseghmTRcDhmK2CEWFcQyFODmegWcZV7eKkuvoxQn
         Zwct95qfRzjn9I1aGfYZ+MFUAMP7GAh3RdijGrcY8J5WPPF6hnUTHsvXwQy53toEHA
         y0ejk2I1gYmakdiuq9IYPdxw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0C6140E0030;
        Fri,  1 Dec 2023 12:46:14 +0000 (UTC)
Date:   Fri, 1 Dec 2023 13:46:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/percpu] x86/percpu: Declare const_pcpu_hot as extern
 const variable
Message-ID: <20231201124608.GAZWnVkA03ZrnMJgVs@fat_crate.local>
References: <20231130162949.83518-1-ubizjak@gmail.com>
 <170137899052.398.2740335306554226817.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170137899052.398.2740335306554226817.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:16:30PM -0000, tip-bot2 for Uros Bizjak wrote:
> The following commit has been merged into the x86/percpu branch of tip:
> 
> Commit-ID:     4604c052b84d66407f5e68045a1939685eac401e
> Gitweb:        https://git.kernel.org/tip/4604c052b84d66407f5e68045a1939685eac401e
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Thu, 30 Nov 2023 17:27:35 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 30 Nov 2023 20:19:33 +01:00
> 
> x86/percpu: Declare const_pcpu_hot as extern const variable
> 
> const_pcpu_hot is aliased by linker to pcpu_hot, so there is no need
> to use the DECLARE_PER_CPU_ALIGNED() macro. Also, declare const_pcpu_hot
> as extern to avoid allocating storage space for the aliased structure.
> 
> Fixes: ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20231130162949.83518-1-ubizjak@gmail.com
> Closes: https://lore.kernel.org/oe-kbuild-all/202311302257.tSFtZnly-lkp@intel.com/
> ---
>  arch/x86/include/asm/current.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
> index 0538d24..9fbd7cb 100644
> --- a/arch/x86/include/asm/current.h
> +++ b/arch/x86/include/asm/current.h
> @@ -37,8 +37,7 @@ static_assert(sizeof(struct pcpu_hot) == 64);
>  DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
>  
>  /* const-qualified alias to pcpu_hot, aliased by linker. */
> -DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
> -			const_pcpu_hot);
> +extern const struct pcpu_hot __percpu_seg_override const_pcpu_hot;
>  
>  static __always_inline struct task_struct *get_current(void)
>  {

WARNING: modpost: EXPORT symbol "const_pcpu_hot" [vmlinux] version generation failed, symbol will not be versioned.
Is "const_pcpu_hot" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm-intel.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [kernel/trace/preemptirq_delay_test.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/exfat/exfat.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/ntfs/ntfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/acpi/acpi_pad.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/display/drm_display_helper.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/ttm/ttm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/gpu/drm/i915/i915.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/misc/mei/mei.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/core/usbcore.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/cdc-acm.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/class/usblp.ko] has no CRC!
WARNING: modpost: "const_pcpu_hot" [drivers/usb/storage/usb-storage.ko] has no CRC!

And the usual fix for those things:

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index b1a98fa38828..7e6440bae63d 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -13,6 +13,7 @@
 #include <asm/preempt.h>
 #include <asm/asm.h>
 #include <asm/gsseg.h>
+#include <asm/current.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
 extern void cmpxchg8b_emu(void);

does NOT fix it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
