Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF37F5D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbjKWLUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344996AbjKWLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:20:28 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7407CD8;
        Thu, 23 Nov 2023 03:20:34 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4966F40E0258;
        Thu, 23 Nov 2023 11:20:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4s49rXaUabG4; Thu, 23 Nov 2023 11:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700738429; bh=lhIEeBpw7QtrxS/ZHvsdGRgwiXLx1WSEEuHReDweeEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5AhGmOZ/lTXYVKRydg6dEJGUZD2vjCX1NRvrNqMdOJCU/0rKBtBj/NG59qDzd9GI
         9/Z0K/ZQE13Bodi3CsRxuFquYP28pQr1sxszcI76+SLFZJX16tOpPT9AB44wmJNkk+
         zRi6muT36Hdq6VWg7xjXpvhqzOg1bQoJEAtFGeDL2VpkpS6hVwPaTpEMep/o5X3joe
         1MANBpjtKG9o/MIJBfgOxR3RI7g/9ITC7grnaObagwgkw37BQvMxf70IIBcxwvE8Hk
         nkuFXv9OpON+AOrPKa4MNJDAtPKjbj/KUP7/hKJ1J1sJfzDo+f00vqGXHAgLmv5Vrp
         +3rihlW9neJYoZF6YFGp53Flm4zKS6VPJMUEGUhvBeRDrdhiP/UjVJXmuuXAk31LUr
         VE+ymsypj8eqpAN/Tllv6Ro7DRLF3UR+AhW3ZuKy4nE95xsYASIl456a3yn3wvwwf3
         Y4PWT/5+SJRjic84ZL81LkmEnmNrpNjwJzBgliHfSczRwGfQrYiiAERbuq3Hm/fD2z
         ENvEq+VhFvuXttZg4N4W54GqzZv5MNnViW9OA24ojNNy2kycZLWHugsFfQ0st6I8MA
         rtYdV0R2H+mVTr03DnW7YU1t/aQq3xZI4Vcv/ECzpafjQp7qJeyKamx+OrEMzetV0U
         LRHB/oargmhWqWWJprOKRdSI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C06F40E0257;
        Thu, 23 Nov 2023 11:20:18 +0000 (UTC)
Date:   Thu, 23 Nov 2023 12:20:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Message-ID: <20231123112013.GAZV81bezsrS6sdJQR@fat_crate.local>
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
 <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
 <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
 <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
 <20231122205135.GGZV5p157mBi6RYUNs@fat_crate.local>
 <CAHk-=wh03jMZRAxHFTkv0h9dZ6TmiqukzcHd4RTx7ijia_prsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh03jMZRAxHFTkv0h9dZ6TmiqukzcHd4RTx7ijia_prsg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Antonio who did that last fix to dracut:

6c80408c8644 ("fix(dracut.sh): remove microcode check based on CONFIG_MICROCODE_[AMD|INTEL]")

On Wed, Nov 22, 2023 at 01:08:41PM -0800, Linus Torvalds wrote:
> There are dracut command lines, like "--early-microcode" and
> "--no-early-microcode", so people who really want to save space could
> just force it that way. Doing the CONFIG_xyz check seems broken.
> 
> But that's for the dracut people to worry about.

Yeah, I guess something like this below.

Antonio, how about something like the totally untested thing below?

dracut would simply always build in microcode - this is the majority of
the setups anyway - and people who want to save space, do:

--no-early-microcode

?

---
diff --git a/dracut.sh b/dracut.sh
index 3b292910f324..c0a88b083f8e 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1561,20 +1561,16 @@ fi
 
 if [[ $early_microcode == yes ]]; then
     if [[ $hostonly ]]; then
-        if [[ $(get_cpu_vendor) == "AMD" || $(get_cpu_vendor) == "Intel" ]]; then
-            check_kernel_config CONFIG_MICROCODE || unset early_microcode
-        else
+        if [[ $(get_cpu_vendor) != "AMD" && $(get_cpu_vendor) != "Intel" ]]; then
             unset early_microcode
         fi
-    else
-        ! check_kernel_config CONFIG_MICROCODE \
-            && unset early_microcode
     fi
+
     # Do not complain on non-x86 architectures as it makes no sense
     case "${DRACUT_ARCH:-$(uname -m)}" in
         x86_64 | i?86)
             [[ $early_microcode != yes ]] \
-                && dwarn "Disabling early microcode, because kernel does not support it. CONFIG_MICROCODE!=y"
+                && dwarn "Disabling early microcode, unsupported configuration"
             ;;
         *) ;;
     esac

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
