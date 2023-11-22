Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B27F4887
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbjKVOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbjKVOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:07:33 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F9283;
        Wed, 22 Nov 2023 06:07:29 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9850440E0258;
        Wed, 22 Nov 2023 14:07:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NPAV8wuf1POr; Wed, 22 Nov 2023 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700662045; bh=ig/bMqSNzXntQhFY3R6soUJmrEAX/ZR070rutZI0ReE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYI1XMDXBDNHMr8TVN1S4BhVUZdYyPwY9Xe3w9TB5NbyQ0e6hj3JaEFt4iytEr+/t
         Vv+9bEYkmZjsKHHa1o/PwNPkL4LorF9yb5pP5erpcJaGVbky26QYWHhGK1KodV0j4I
         rKS95E5mC2eeAokwvR7yXTL89ecologBizm9mUzgwqJSp8ygD/eW+ZH6DylGWre8Vx
         oCmQLSNbfbXgG35x26tL0DFWz68zskUazAgyfUG+zKHVHPSxnCa8ET9N3P0yp1Hfb8
         r1GV7bv6pbindFpQJZPQYHaFHXt9afg99xz4B5/GDHuw1DyzPEeAHLMr1x6P3Dbrtv
         9mp29QZg5SIt56fvc9huZgFmxXMllnUHI3Mld/aldXJ8ONgemppQJT2TokycZDwxS2
         f5y0PU+HXmu5AYO7jqUHSVwGYbDzlf2f0nDsvEl4ekoU139vev01gp/0w7cpK8LSN1
         c8xMkF7/u1XmTUq+TxLvSuDg3qO31YUB3v6fzB62UvyeN0i7vMTkjqp9pRLStxnbHN
         qErmw0786bDCd7ktgHWb3SK/grjfDRg7poMstduHj+j729tuNcqAfCG0MZRMPkOvl+
         IMA7bMXfQhYfXwmNT20tH1ZzEpA4qKa71zjUgZxa3rohSfkFIGq+vZDgl5Pjo/t6A8
         U9oDF63Eg8lm0vv4MiC3XtOc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A38D840E024E;
        Wed, 22 Nov 2023 14:07:15 +0000 (UTC)
Date:   Wed, 22 Nov 2023 15:07:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, initramfs@vger.kernel.org
Subject: Re: [PATCH] x86: Add a "x86" ELF note namespace
Message-ID: <20231122140710.GDZV4LDmgF9lXtXdDZ@fat_crate.local>
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
 <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <20231122132419.GBZV4BA399sG2JRFAJ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122132419.GBZV4BA399sG2JRFAJ@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:24:43PM +0100, Borislav Petkov wrote:
> Displaying notes found in: .notes
>   Owner                Data size        Description
>   ...
>   x86                  0x00000004       Unknown note type: (0x00000000)
>   description data: 01 00 00 00
>   ^^^^^^^^^^^^^^

Note to self: since this is a u32, the next version should define that
only the 1st bit is valid and the rest are reserved. So that they can be
used as a bitfield in case something more needs to be communicated in
the future and we don't waste a whole u32 just for one bit of
information...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
