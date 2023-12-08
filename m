Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E2480AF3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574839AbjLHV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjLHV6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:58:13 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E44172A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:57:41 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E02A940E00C7;
        Fri,  8 Dec 2023 21:57:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pu-SK4I_uqek; Fri,  8 Dec 2023 21:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702072657; bh=HyxNBBw6M4t7K4FsW/QvOnMlGlVd2OH0yYe9euKlsDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Me4aVv3Gzpsf0YqFQlL2OAjtnafSMDjF7TfgbzEUfcHH5GUjUAsCUZJXm3e80Owbr
         Ti3x2EGVBhawAJjaaO4qrN8mi5DYVnYSEPZRJWmlVqU3Ce//rg8D/CIpYnDdxEhIqu
         kLF0fZt3NQsaU4r0q8G7YNvBsmK5SH/6ZY4SwSGfySFWzbfCYgiKs17yDVG29f408r
         7haQFJKorMcIRB/RQCIRMZpad4CSg9NxrkRZdwbjqYl74zkifri81a11P0NRDygOaz
         zLgmRupOaOlcBjU4RtUeWf7vy9bApDQZ9tg7UpBe0NOMdItSRMAAUTs4dRFxrC4XoF
         KaxjUp+zamt0kaYwot+VJpDFbtbamTMhig6TxS663V7e1QFQzwnlwO2B4lU1eY3PHg
         vI6f+V9xm8/ablZA+H+m9z4/gDYxruG+woU4RiNixTC08WrexFaY2uJgKPe1dxWp50
         jN72pLsghtgniqsD+uOrttM8kOwMzScYJjhEjyXxuO/QB96RpQDx4TnTeT2q5zoX3J
         1YO1tRKs8GLWPqaI3tnU1TrVpnmpHkWXI5QBn5Hn//LBBJVl89G42a0DQFTOtCqeQd
         Qixo+U58KxbHQbCsXHhKvchQy8Pg2z2rc+VZwFUw/kz4F4BKLFlQAuRR2mF4AyMlJc
         YlBxIRUl5mRI15JW/O9MYt/c=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30F8E40E00C5;
        Fri,  8 Dec 2023 21:57:34 +0000 (UTC)
Date:   Fri, 8 Dec 2023 22:57:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2] Documentation/x86: Document what /proc/cpuinfo is for
Message-ID: <20231208215733.GEZXORTftWz1ubGdYl@fat_crate.local>
References: <20231129101700.28482-1-bp@alien8.de>
 <4afd33ba-6b7c-415f-b9ef-964a2fc840d8@intel.com>
 <20231208215537.GDZXOQ2TKjOZJlflUz@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231208215537.GDZXOQ2TKjOZJlflUz@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 29 Nov 2023 11:12:55 +0100

This has been long overdue. Write down what x86's version of
/proc/cpuinfo is and should be used for.

With improvements by dhansen.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/arch/x86/cpuinfo.rst | 89 +++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 08246e8ac835..8895784d4784 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -7,27 +7,74 @@ x86 Feature Flags
 Introduction
 ============
 
-On x86, flags appearing in /proc/cpuinfo have an X86_FEATURE definition
-in arch/x86/include/asm/cpufeatures.h. If the kernel cares about a feature
-or KVM want to expose the feature to a KVM guest, it can and should have
-an X86_FEATURE_* defined. These flags represent hardware features as
-well as software features.
-
-If users want to know if a feature is available on a given system, they
-try to find the flag in /proc/cpuinfo. If a given flag is present, it
-means that the kernel supports it and is currently making it available.
-If such flag represents a hardware feature, it also means that the
-hardware supports it.
-
-If the expected flag does not appear in /proc/cpuinfo, things are murkier.
-Users need to find out the reason why the flag is missing and find the way
-how to enable it, which is not always easy. There are several factors that
-can explain missing flags: the expected feature failed to enable, the feature
-is missing in hardware, platform firmware did not enable it, the feature is
-disabled at build or run time, an old kernel is in use, or the kernel does
-not support the feature and thus has not enabled it. In general, /proc/cpuinfo
-shows features which the kernel supports. For a full list of CPUID flags
-which the CPU supports, use tools/arch/x86/kcpuid.
+The list of feature flags in /proc/cpuinfo is not complete and
+represents an ill-fated attempt from long time ago to put feature flags
+in an easy to find place for userspace.
+
+However, the amount of feature flags is growing by the CPU generation,
+leading to unparseable and unwieldy /proc/cpuinfo.
+
+What is more, those feature flags do not even need to be in that file
+because userspace doesn't care about them - glibc et al already use
+CPUID to find out what the target machine supports and what not.
+
+And even if it doesn't show a particular feature flag - although the CPU
+still does have support for the respective hardware functionality and
+said CPU supports CPUID faulting - userspace can simply probe for the
+feature and figure out if it is supported or not, regardless of whether
+it is being advertised somewhere.
+
+Furthermore, those flag strings become an ABI the moment they appear
+there and maintaining them forever when nothing even uses them is a lot
+of wasted effort.
+
+So, the current use of /proc/cpuinfo is to show features which the
+kernel has *enabled* and *supports*. As in: the CPUID feature flag is
+there, there's an additional setup which the kernel has done while
+booting and the functionality is ready to use. A perfect example for
+that is "user_shstk" where additional code enablement is present in the
+kernel to support shadow stack for user programs.
+
+So, if users want to know if a feature is available on a given system,
+they try to find the flag in /proc/cpuinfo. If a given flag is present,
+it means that
+
+* the kernel knows about the feature enough to have an X86_FEATURE bit
+
+* the kernel supports it and is currently making it available either to
+  userspace or some other part of the kernel
+
+* if the flag represents a hardware feature the hardware supports it.
+
+The absence of a flag in /proc/cpuinfo by itself means almost nothing to
+an end user.
+
+On the one hand, a feature like "vaes" might be fully available to user
+applications on a kernel that has not defined X86_FEATURE_VAES and thus
+there is no "vaes" in /proc/cpuinfo.
+
+On the other hand, a new kernel running on non-VAES hardware would also
+have no "vaes" in /proc/cpuinfo.  There's no way for an application or
+user to tell the difference.
+
+The end result is that the flags field in /proc/cpuinfo is marginally
+useful for kernel debugging, but not really for anything else.
+Applications should instead use things like the glibc facilities for
+querying CPU support.  Users should rely on tools like
+tools/arch/x86/kcpuid and cpuid(1).
+
+Regarding implementation, flags appearing in /proc/cpuinfo have an
+X86_FEATURE definition in arch/x86/include/asm/cpufeatures.h. These flags
+represent hardware features as well as software features.
+
+If the kernel cares about a feature or KVM want to expose the feature to
+a KVM guest, it should only then expose it to the guest when the guest
+needs to parse /proc/cpuinfo. Which, as mentioned above, is highly
+unlikely. KVM can synthesize the CPUID bit and the KVM guest can simply
+query CPUID and figure out what the hypervisor supports and what not. As
+already stated, /proc/cpuinfo is not a dumping ground for useless
+feature flags.
+
 
 How are feature flags created?
 ==============================
-- 
2.42.0.rc0.25.ga82fb66fed25


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
