Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3DC7FB45A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjK1IhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344157AbjK1Ig4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:36:56 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF90AA;
        Tue, 28 Nov 2023 00:37:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D84A840E01A5;
        Tue, 28 Nov 2023 08:36:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1vHsmSMNDYS3; Tue, 28 Nov 2023 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701160617; bh=DS2d99Cf/Tm1b0CoskKzTkSL4zfPSaK6CYmxmDpIDno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8Kl7pOfZkDJ1aauL4p8L+PlN65c8sIR0dkdP1NbqWcLcQY6vEQjYeM/r0US8S9kF
         RYKot1G8DTIU2i/vJbZ1dY8cBcGfRTw5eFgwVvUfS9BBoA90TBlEUp24OXrYB919e/
         Oy9SPBMTF8mwOQGo4ENPJBFKDroY/sp19zB/SlzHi4KLsJ7dwdNlb1E3uwAjDanJoQ
         vo2I6xeoAedHIyLyWVbyRwoypXxt0W/z9QtACLsVB9EJOZcuTpIzfRI0WQVy6PL0gs
         lmvT8HdZT00moCakbNxG+hW2JFqsKP3UGOqM6ogwuTCRPnTt7vEHovr6BESHhP7Ghd
         PrmO7bjwnAbf9slrMSVBPDynMcWeQLLh9sCucQNJyRSFHTD1ls5zbvnTNuutqKbcVd
         2/D/sbPwNva3NafVp2mXa6fzDye7Dr0YJO74ghd0IpJ4svVag2MEsEKbllMGPOFaXB
         yZKZTGXbFd5A0XC5WOguBvIJ+ogDfpVmSLzBtQ8aaFnZiDT5roz378AGxU0Cs0Jl7g
         cOR129yb77LRWYUT6q9WwvjgaMIebKAbVM5H2TWl293NIL68arozCJwBKM7mI5u88B
         1N9KRnvXlfSALDR32hWnUk2p/Kit1WXMb19R1Wxy4zqEb1j33zwAYoVT0pWIswldS1
         cDLymiOsuFxx+9JUg1fX4yC8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C01D840E0031;
        Tue, 28 Nov 2023 08:36:34 +0000 (UTC)
Date:   Tue, 28 Nov 2023 09:36:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        pbonzini@redhat.com, seanjc@google.com, peterz@infradead.org,
        jgross@suse.com, ravi.v.shankar@intel.com, mhiramat@kernel.org,
        andrew.cooper3@citrix.com, jiangshanlai@gmail.com,
        nik.borisov@suse.com
Subject: Re: [PATCH v12 15/37] x86/ptrace: Cleanup the definition of the
 pt_regs structure
Message-ID: <20231128083629.GOZWWmjTe8l+IwXG5j@fat_crate.local>
References: <20231003062458.23552-1-xin3.li@intel.com>
 <20231003062458.23552-16-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003062458.23552-16-xin3.li@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:24:36PM -0700, Xin Li wrote:
> -/* Return frame for iretq */
> +
> +	/* The IRETQ return frame starts here */
>  	unsigned long ip;
> -	unsigned long cs;
> +
> +	union {
> +		u64	csx;	// The full 64-bit data slot containing CS
> +		u16	cs;	// CS selector

I know people want to start using those // one-line comments now but
this struct already uses the /* multiline ones. Can we stick to one type
pls, otherwise it'll turn into a mess.

And pls put those comments ontop, not on the side.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
