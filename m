Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6D7FEF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbjK3MtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjK3MtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:49:15 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C6810C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:49:22 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C132040E0239;
        Thu, 30 Nov 2023 12:49:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kGKO4CzjoTx3; Thu, 30 Nov 2023 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701348557; bh=0V+gpDULSlHvbaa1wy5kknuoNyhtcWb+gEj8aeU5IjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cgw8rmXRswxoehbF+/EBHe7s+ax/h97tIB6Zq7KJIh/3eLQtEpgZwXVPFRwZeBdB4
         Ta9fqoJ3ZRKZrp7mQCplT0F7ldeVAFVTViWzpWJgUR1hVEQhb+RL0ZTRzYuO+jji0c
         MAm5oxidwkl/KZ/BYnM4Jx7/lUivZOdEl/JoDa4D10Mm0PLGYIkEl0Ql1Waff/9aQP
         tN8etuI1mONEoOqWYdNpxFeq/m0lxZV8hRUK481NOTz16OlTd71MnpTlwKEKDfizWR
         nWsgCeAFdC4hjXwjV3PB52o+2rvjxLD1P7JZtDOy4Eds6cNlAy0Tpgu9gDdglamWvj
         xeSOPsqFTxi2MRUXJ8jP3nRG8dy3gE1oXeb7S9pFeB6CokLHFzHgMj0ybV2StvZy8r
         6f9NauOvemLNguJYNdTGPmPqynHWNwq665nbo4f/z1lXGs/nIaEaSMcyUNxhh9FChp
         dvfimUVDmDEgPs8lQokZQJZi60d4917LCPVn6F4Tq62q4Prb/I2LVYNnb04MQQaPni
         gbg3eodQuwlv6PK4acei3Kyr7D97GTkIaTNSO3x2+lnI6SGcmF9gBuRwatpwkFG2Vb
         1GxjhDytx6CknAHdeKpnPkaRwr6pXR0GiSLT7hvT1LL+oxPbTYwqG/oUnXZ+d3phfU
         ZEfGTnxCiifC1u5DNkf+P+4M=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 856E940E0030;
        Thu, 30 Nov 2023 12:49:14 +0000 (UTC)
Date:   Thu, 30 Nov 2023 13:49:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231130124909.GEZWiExTP4J1pjNxPq@fat_crate.local>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130120831.GB20153@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130120831.GB20153@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:08:31PM +0100, Peter Zijlstra wrote:
> Works for me, but I have "nokaslr no_hash_pointers" on all my machines
> by now. It goes right along with "debug ignore_loglevel
> sysrq_always_enabled earlyprintk=serial,ttyS0,115200" :-)

Bah, there's cmdline switches. Lemme add them to all my scripts starting
guests and grub too. Thanks for the hint!

I guess we could still do the Kconfig dependency when we're on new
machines, without the scripts.

Btw, I'm not the only one who's walked right into this one:

config KCOV
        bool "Code coverage for fuzzing"

	...

          If RANDOMIZE_BASE is enabled, PC values will not be stable across
          different machines and across reboots. If you need stable PC values,
          disable RANDOMIZE_BASE.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
