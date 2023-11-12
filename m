Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465B67E91F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjKLSLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjKLSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:11:00 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D11BEF;
        Sun, 12 Nov 2023 10:10:56 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2C1640E018F;
        Sun, 12 Nov 2023 18:10:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o5jeVJy23QFH; Sun, 12 Nov 2023 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699812651; bh=P+Kou/jpj8gD2sM9ulpNQYbK457wnt04VLoVq55l99E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7TNhQv+z2v4Uj9Dap4EN/O61lvCqJRdWVwBLIM6UmS+ulbY29Rxvvrx3qZpRSWmF
         AeUJ7MTjrYYg/fhvbvVRrATM/21hQnlyfplMueSFBSKPoIdNwARVrlfKDCc/BHEkFt
         jwe7ppfKCLDcg9aohDOeRiKrpqPAUP+m7djCbv8AlacX9JX9Lmvp/PB64VBNFJyFD0
         L7GQvBSaxHmThr+NtKV069zdYbRcub0O/8s8sgBBNRQw6p/yJ+xwceiHjQ5LDkgDZu
         Gkf+z8+BvG5CS247AjIUowXurGrZa+4KXbNgZ/qD0+IbTfmqmrmfsWGGQ7Y94NGcb0
         qab+tjcU0tUeceqld8oZFrm9LplYkcbjS16iLOkv1+M/YncupJdtCFZyeSgLes9Cx5
         0Ky+/MMUMRf0eSZ0xmelWs75IV0qTvm9uguSUXu+vub5jUyNABLCP2TnrhYwZ5e9Bg
         KGpgGgWS1hm5r8snXRmnIj3jJ+P0cPJYXahgT/+wbCGOQnbLXiiz3jy6RRrJusfI80
         h1pcgxW/QawzWAluiYxg7XjMup48z97Lcb/zHlSfvOG2EviO+Yt0+hwXy2lmys9KP8
         jmsnc9qZlMpoxTLYYMpmVkxr1FwdpUTNfiLEASsqWq+37ukzGvJwpbQ2uwkXW9VbTt
         ea7xHrE2jOSzNawFyWwchZew=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85EFA40E0031;
        Sun, 12 Nov 2023 18:10:42 +0000 (UTC)
Date:   Sun, 12 Nov 2023 19:10:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Message-ID: <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 04:03:32PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> That's because dracut until the recent commit
> https://github.com/dracutdevs/dracut/commit/6c80408c8644a0add1907b0593eb83f90d6247b1
> looked for CONFIG_MICROCODE_AMD and CONFIG_MICROCODE_INTEL in the config
> file to decide what to include or not.

They've been told a bunch of times already that grepping .config for
specific symbols is not how one should check whether one should add
microcode blobs to the initrd or not because Kconfig symbols are not an
ABI.

And looking at that commit, now they're grepping for CONFIG_MICROCODE.
And that'll break again if one day we decide to make the microcode
loader built in unconditionally.

How to fix this reliably and properly?

Honestly, I don't have a good idea. If we do something like this:

grep microcode_init System.map

then that makes "microode_init" ABI and we won't be able to change it
eva. I'd need to do some digging here...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
