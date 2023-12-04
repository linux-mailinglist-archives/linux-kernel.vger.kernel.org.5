Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0E80392D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjLDPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjLDPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:50:01 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F1E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:50:06 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1FD6940E025E;
        Mon,  4 Dec 2023 15:50:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JrKhSOLI5D3a; Mon,  4 Dec 2023 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701705003; bh=Vo6ACIul/s8PeELnHpXtugdkNS4j0Em8H+F2OScobtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaYeeYPE7h08tJJMMsojtPUR/kbPMq7JDlfMkhVtb0QtiAvXJTVGAwFvNbISktcaa
         IUSQ3cTdUl9cvJ5crmWsf/7vdnYE7zqcnwLQ3+qmMXFrlqg/QjVNsqJEEQ1tb6v32f
         9wxSYbj15pvq9EAtkIiL1MYFQppJxd9g8TfuK/FjaNfRik3jm+suw/hrZG/O8CPhMv
         O5jRPzY8gRJaASuivLo6bEok5IQBlih8CdJ2RKvZSIhvGKdW6oHbWPlCB4LaIl1Op4
         5claSRckFEk5/BKGzXJB5Nlt/Qh3asS8dV7vWRq0KW/oXh/AnfUTk9ox7Ii5uICP4v
         H6DReEH1/YZbj0YvK0llVSdNLAMv9L9vbmNXROuPWRqSPNEbuBOEPaWUO0SELRqjY8
         KH/DnNT6J9EpzEkyitWa9nXcPy+42xq5RmHqdcscchCiSNBvkO2g30n78nQITkfreo
         7nIkpfgoqUQgzrMAxNi3vHLFZNcZCkdbp5rmTBejmsw3GAsMpKtbPdyumt/2XXzc2R
         6xDtB9ynOgKXzoklWDuzhzW8BJoVEPT8c4ap/bED/GcD2afzGeJfZZuARFAdzrjiFH
         ZBPQtaXbzgbCI1xsiX4jEl9gE93JJSfd+D3vxet7o1IXn/OLRTCAPczum3Nx3A6mIG
         9i3rXmvOycPuw64y5bkMHLgU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E6EB40E0195;
        Mon,  4 Dec 2023 15:49:59 +0000 (UTC)
Date:   Mon, 4 Dec 2023 16:49:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231204154954.GDZW31IjgG6A0HSULH@fat_crate.local>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130120831.GB20153@noisy.programming.kicks-ass.net>
 <20231130124909.GEZWiExTP4J1pjNxPq@fat_crate.local>
 <ZW2tBy_8U5cfEkmk@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZW2tBy_8U5cfEkmk@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:42:15AM +0000, Mark Rutland wrote:
> Later, in December 2016 we made KCOV adjust the address to remove the KASLR
> offset in commit:
> 
>   4983f0ab7ffaad1e ("kcov: make kcov work properly with KASLR enabled")

Neat trick, I should remember that. Might come in handy.

> ... so I think that's been stale for ~7 years, and we just forgot to clean up
> the Kconfig.debug text.

Ok, I guess you'll clean it up then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
