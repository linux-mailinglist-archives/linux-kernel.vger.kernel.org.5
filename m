Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8B7BA6F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjJEQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjJEQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:41:35 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0659D7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:26:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EC47440E019E;
        Thu,  5 Oct 2023 16:26:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ywce8X2Eol94; Thu,  5 Oct 2023 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696523161; bh=LNsi6kyKNbrnFjEuzko5Cj4o3hlC3He0qw0OPp2bpqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfslYQxdbC6mCAsZhvSjzdU5I04tqTQo0Yg8iABD8Iya60KMMfOkyyndBZztRxYbk
         1iZC0pmtfA8vE3sTY8ZPkUi93qDbluzSSEAFBpK3t4bokMP9N6fBCCiP+uqn2fWdhs
         EjmOz8fLNAOwhnT4Woa6+S/d+v0A9uZVTYC3A/F7AnhT9xhWHl6T4Ap8xWVzxgY3Oo
         XezHkfpGOSNNmsCHF9Ne//vyFhvntjCO6XQE/7SDylyh/lxwo8F8yTB/s4XcSwLsTe
         D9p9Jasv+R41FO4riICk9p8RN8hAhLt5D7/IBw5epXMD6LL+Uzso2dbigjxlX5RJbL
         AHoL/Kl1ZDaDB4YoxvfS5MaP2rIlwyAosd/vckEAPuVzfrt28pmRk4y3lJXEhesY9I
         xgbVuu3+F9Cdj0FcGjtORRX4OBEQJgW6R8a63a6y9rdQnGdkctKltHDo2gxLO875V/
         IR7rSVAYG7nfcV8MA3i4PixvKbz1ruK2e0fLs2umC05RhoS55IJ8kV7iyMYuFS30cQ
         aPJJCi91Ea5+PmQkoHUmCnqOuSkOOxSidlIaqZW8MTP+Y/UHBlwia5vvIB6w71A/or
         Z284Cc5oRN3DhY4WPqymYa12DeVvxXwjNsb29dPkzgip5IalBIkL6pHixuguE6w3R2
         5r6qu05+RBEazvCzyw/GhLew=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CB8D40E014B;
        Thu,  5 Oct 2023 16:25:49 +0000 (UTC)
Date:   Thu, 5 Oct 2023 18:25:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231005162545.GFZR7jiUNyNkscijUl@fat_crate.local>
References: <20230628142129.2468174-1-leitao@debian.org>
 <ZRV1bIuSXjZ+uPKB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRV1bIuSXjZ+uPKB@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Linus.

On Thu, Sep 28, 2023 at 05:45:32AM -0700, Breno Leitao wrote:
> On Wed, Jun 28, 2023 at 07:21:28AM -0700, leitao@debian.org wrote:
> > From: Breno Leitao <leitao@debian.org>
> > 
> > Create an entry for each CPU mitigation under
> > CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
> > them at compilation time.
> > 
> > If a mitigation is disabled at compilation time, it could be enabled at
> > runtime using kernel command line arguments.
> 
> I had a chat about this topic with Boris and Thomas at Kernel Recipes,
> and I would like to summarize the current state, and get it moving
> forward.
> 
> 1) The hardware mitigations are half-way added to KCONFIG. I.e., half of
> the hardware mitigations are specified under SPECULATION_MITIGATIONS,
> but not all of them.
> 	* You can enabled/disabled just half of them at build time.
> 
> 2) It is impossible to build a kernel with speculative mitigations
> disabled.
> 	* The only way to disable the mitigations is at boot time,
> 	  using the "mitigations=off" boot parameter.
> 
> 
> So, disabling SPECULATION_MITIGATIONS, will only disable the mitigations
> that are under SPECULATION_MITIGATIONS. Other mitigations will continue
> to be enabled by default. This is is misleading for the user.
> 
> Here are a few options moving forward:
> 
> 1) Create one Kconfig entry per mitigation, so, the user can pick and
> choose what to enable and disable. (Version 3 of this patch. May need a
> re-spin due to the new mitigations being added.)
> 
> 2) Keep the Kconfig entries as-is. Create a new Kconfig entry
> (CPU_MITIGATIONS_DEFAULT_OFF?) to disable the mitigations by default,
> similarly to the `mitigations=off` boot parameter (v1 of this patch)
> 
> 3) Same as 2, but, reusing SPECULATION_MITIGATIONS instead of
> creating a new Kconfig entry.
> 
> 4) Remove the current entries in SPECULATION_MITIGATIONS and the fine
> control on what to enable/disable?!
> 
> What is the preferred way?

I happen to know that Linus wanted those per mitigation, perhaps to be
able to disable only a subset of them.

Linus, what are you thoughts on it, should we continue with a Kconfig
option per mitigation or should we hide them all behind a single Kconfig
option - which would be a lot simpler and easier?

Apparently people want to completely remove the mitigations crap for
some configurations at build time already.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
