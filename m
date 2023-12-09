Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E680B33B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjLIIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLIIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:21:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8503C122;
        Sat,  9 Dec 2023 00:21:23 -0800 (PST)
Date:   Sat, 09 Dec 2023 08:21:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702110081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWz7AeYIHKHqsW/mXloUGmsrK7/eiI9uEX3App/Fv4g=;
        b=40QoeA05rg4QTQYMRvO8as1Pnj3+EZkr6BLVMKSgXVFUI5FsgGh2Hrg2/PChHJi6d4TvkT
        1x2FfcTGIjiRtCvYHj7HGgjzh0lzG0ZVVRyvNaw880cyFy8aGZZDt5u8dluSeWVisvXCm0
        ZTXHsNHNNurT21okWFhFwDxrR5jeqY0Wsq+Q5EbXsFWGK0uEDlHXpG59c1VnKrVvlfBj/S
        r1sUDVwpOcbyWU+lNAPo9Sx2SJnKGbkdb13BkgqMTJTYz+THysIngMz4aOQcQ66AZ71FDg
        3tSey8OTrgptMbugqpnhf4xXHNXR0rHYEDc/BgrLTb/ciOo2NMYqmI3PtpVTMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702110081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWz7AeYIHKHqsW/mXloUGmsrK7/eiI9uEX3App/Fv4g=;
        b=NnGS9SIneIZ06pnHEBieqm0l+DqqyqlXchbE5bFNCjUR7jEITXNZ7R3OpClH9qlZVGMkew
        X+BycAh6oi3kz6AA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] Documentation/x86: Document what /proc/cpuinfo is for
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231129101700.28482-1-bp@alien8.de>
References: <20231129101700.28482-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170211008011.398.14299580912908619264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     79c603ee43b2674fba0257803bab265147821955
Gitweb:        https://git.kernel.org/tip/79c603ee43b2674fba0257803bab265147821955
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 08 Dec 2023 22:57:33 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 09 Dec 2023 08:52:53 +01:00

Documentation/x86: Document what /proc/cpuinfo is for

This has been long overdue. Write down what x86's version of
/proc/cpuinfo is and should be used for.

With improvements by dhansen.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20231129101700.28482-1-bp@alien8.de
---
 Documentation/arch/x86/cpuinfo.rst | 89 ++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 08246e8..8895784 100644
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
