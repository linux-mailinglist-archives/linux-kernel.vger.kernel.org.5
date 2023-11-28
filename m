Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF67FC455
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjK1ThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjK1Tg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:36:59 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407001735
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:37:06 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 649F140E014B;
        Tue, 28 Nov 2023 19:37:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AHtZN2RFQ7ha; Tue, 28 Nov 2023 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701200222; bh=RBnI524LCcNEb+SQrW6PdQzUocyNF4UhSvuVYRD2uNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKQTvkYn0aub8zn9vlzyikfhQTa5NZmWxdf6idZnklSzxvXK51NT7XlkXZyvrV0JS
         SuVf/TLHpyql0s6Vwu9F6Dj4gEXSzx4lv7qrRtlXBqelmCCfJVfOQtvka/B40p5Uj/
         7BjTB5xsr0CdDCf62M2+qU9fTIediL8jGu6OSK24ggUUaztDItfJDmhm5UP/ExLxR1
         +QJPE2O4hbNh02vJJX/hK0jkYWdfw3hP/zd84ia8ACcfBZosjEfFbT80jNW9Ov+jx0
         WLiqlv6mOJ6RFxBL7zorLGjrndoRWu0SCa5OLVaeMbOjdRqNZAa791Cu5mo2AnvssN
         ox2NEBbm5Iv/ljhxqBlcP1XsKFzCHid3Kc9OSQHtMp6wvfle0JjmtUItPKUGFqMyRT
         Vvj0kH1u/WffUXr/97rlu/n6bR8DuyTup8cc4Jt4eJH+NSpBQ8UCxRxEH7A3H0E7Ko
         lD88C7IWi5+lrhPvS07O+rywgoEXiI3WBDetFqpycdstlOoQIKO9lfyotLwegztxe/
         MciYqpusHtdtZNV+N9xemWUm2pBB1bxEOwtWADt/EC/dVblqVR8alV3Z9/S0d9agV1
         B76n+38u4uUpFtRfs2xxXChp4OSsJk43z+c8hr+wYfn29IB0l2S4l/aTnFC260D9W3
         nS2SDtame+wLLfSAtuIFXhAU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 985F540E0031;
        Tue, 28 Nov 2023 19:36:55 +0000 (UTC)
Date:   Tue, 28 Nov 2023 20:36:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Update power flags
Message-ID: <20231128193650.GFZWZBUqhLD4AJzeO3@fat_crate.local>
References: <20231128-powerflags-v1-1-87e8fe020a3d@weissschuh.net>
 <20231128191217.GDZWY7kYC9bE9Qkg25@fat_crate.local>
 <15ea49d1-5c6e-4459-8ef1-4bca573b8b93@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15ea49d1-5c6e-4459-8ef1-4bca573b8b93@t-8ch.de>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:25:40PM +0100, Thomas Wei=C3=9Fschuh wrote:
> > The beginning of Documentation/arch/x86/cpuinfo.rst tries to explain
> > why.
>=20
> Isn't this introduction more about the cpuinfo "flags" fields?

That's why I said "tries to explain". See below - I've been meaning to
write this for a long time now.

>   power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14] [15]

Yeah, nothing cares about those - see below.

Thx.

---
diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/=
cpuinfo.rst
index 08246e8ac835..95c7ebcc13a9 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -13,6 +13,29 @@ or KVM want to expose the feature to a KVM guest, it c=
an and should have
 an X86_FEATURE_* defined. These flags represent hardware features as
 well as software features.
=20
+The /proc/cpuinfo list is not exhaustive and represents an ill-fated
+attempt from long time ago to put feature flags in an easy to find place
+for userspace. However,
+
+* the amount of feature flags is growing by the CPU generation, leading
+to unparseable and unwieldy /proc/cpuinfo
+
+* what is more, those feature flags even need to be in that file because
+userspace doesn't even care about them - glibc et al already use CPUID
+to find out what the target machine supports and what not. And even if
+it doesn't do that and the hw supports CPUID faulting, userspace can
+simply probe for the feature and figure out if it is supported or not
+
+* furthermore, those flag strings become an ABI the moment they appear
+there and maintaining them forever when nothing even uses them is a lot
+of wasted effort
+
+So, the current use of /proc/cpuinfo is to show features which the
+kernel has *enabled* and supports. As in: the CPUID feature flag is
+there, there's an additional setup which the kernel has done while
+booting and the functionality is there and ready to use. A perfect
+example for that is "user_shstk".
+
 If users want to know if a feature is available on a given system, they
 try to find the flag in /proc/cpuinfo. If a given flag is present, it
 means that the kernel supports it and is currently making it available.


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
