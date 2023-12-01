Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D01F80115A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378318AbjLAQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjLAQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:24:50 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409295
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:24:56 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 76B5840E025E;
        Fri,  1 Dec 2023 16:24:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ULDijd7oQAZI; Fri,  1 Dec 2023 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701447892; bh=7WhbMhAnyOhoBU4Q746ydmR+J4DH4JT1O8M8msDWMUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUJ5/8U9h36ETdBhac4ggVaMEr10j5zeZO0I5rRQQ8xYD3nIphdP9GcCZKYabzIc2
         Odd4fDelcLVRcg3ALco+Tujk2ielJ3OLKGHqcqQJvXFC2deG668UOf+c8J43f56Upw
         ew3+u0QusU5tTCbjlc+xqlakcSzLJE2bA8J3g1fp81eomH+OimOxUv0Y5eOjdnFLrp
         2ROnM7yPS7Fb0ZkaI6k24NfgpBTDlQcNj2+CFyUsR8Y6w4bLEx+GMHsupJgIbkiFzm
         FLQNKf4Mv6Fxl1LQhTlyyAT3URym5opnakBpWeyRogp0i0LG6pHfcqLTuUzjkoskzg
         ij1KdslquXtDnUj9oHqCAVtjezON1TbdOLfuXXN1JlsGnWMWi9NivAW6nQK7C3oPsi
         s09MXdAeFz7rAvUDnN+QISJtwPnZvkidaV+BjPHtrv3Ua9Q3JkxDx1QYVeFi7u5geU
         IbZAM1DY/kgPtoqQpqF6LWCAgtJ+u6HZvrTwJ5W/8KwdYnyejA1D/DfSsBQ0p2rYyF
         RBeijKxC82PEkg0PR5XObL6wVL8wpClA7ngVvNlcAzroyzuu9FS3a8SXOE9r4hCQ0M
         JztwalQWiXizdapKAgPiz4Y4JPnpdz6/hw5gzzSM2SLwjZw0L/LN9FUwU+UQH2t2LM
         9qft075kGVdZcj2rBxFEHJtA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D3EA40E0239;
        Fri,  1 Dec 2023 16:24:49 +0000 (UTC)
Date:   Fri, 1 Dec 2023 17:24:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231201162443.GBZWoIywsIqB+SNh9n@fat_crate.local>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130181051.GA3357088@dev-arch.thelio-3990X>
 <20231130193428.GNZWjjxKJ38Ruh7puz@fat_crate.local>
 <20231201161610.GA2948377@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201161610.GA2948377@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:16:10AM -0700, Nathan Chancellor wrote:
> Right, this is the diff of Fedora's configuration before and after this
> change:

Sorry, but what's the point of a .config which has EXPERT, DEBUG_KERNEL
*and* KASLR enabled?

Debugging the kernel with KASLR enabled is a futile exercise in time
waste. You should either enable KASLR and disable DEBUG_KERNEL or the
opposite. Both make very little sense to me.

Or, if there really is a valid reason for having DEBUG_KERNEL *and*
KASLR enabled, I can probably suggest another option under DEBUG_KERNEL
which says "Do stable virtual addresses" and which disables KASLR. At
least we'll have it explicit.

And the distro configs do get re-checked periodically so "it is already
in the distro config" is not really an argument I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
