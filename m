Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E77DA09B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjJ0Sgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjJ0Sgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:36:35 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7619A10DA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:25:43 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E31CF40E018F;
        Fri, 27 Oct 2023 18:25:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3WfGBZ6JO7lT; Fri, 27 Oct 2023 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698431138; bh=S3yEXjmpVtmI+UhgJHx5gPel0ZikVlEb1cehdIr8Qkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWn5I4J5Q4XEKUdZunJ7fDjZhVXScDev5+OI0FsDosvB/SX/+gHJahHxHBi4Lx2Ce
         mw/gvHq9nn14zEAxDRN7rgOQlEkj+cVmfVo7rBwbqe1PPCgHT0gXDVxZa3z902S0U9
         Qm8UAf8eJD3rXpOgUPJmWDU4jdXiEjRIOMXTy9Tzn4zlBYqMWdvbgN9rifk+HhIrNA
         CdKk6cTMRpCPJFt0uxkGlTCTqD/mpRu9Z99gG9Y4yQX3GtAysx625MtWOcBnsBi6zp
         zvEHpUA7qwWWGCOpsyRMxdAZjcx2G60BkvFLsCBnICKnTxEdzAQCWogSu46nipdwyT
         0u5U6qBo/5KWKlSnHT4JesNuUv+9r32YlzrT0hw/PCuVhXtUZ6MhQI5tj1x4uu+4Ux
         UVYwJMsyVPcJZn/5Y/+GKFu78iubUA5GcAwMbXZcvwgWgo5qQizd5JNHXwFYOxv14L
         N4uX0rAp3SUCUpMTO8abNWRVRcRs3leLzfEVA0+EeQ9VL7a+cnnqbvrsb6/+eq6P94
         r1DgCn63Rq6ss/QmBD7rOZjK7L1mqjVNvsNP6EtFwNkDi0OmHYTc5boWGnnnt2tThD
         QQlu3abARBi/jt+1PSxTmEvs4nrOTNLJOuyjXVoYuJ+hc2WrTB7lWq91Q9xnUB2z20
         nCX/K9wiogr5GhkR5o1qisdo=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CEB440E0173;
        Fri, 27 Oct 2023 18:25:34 +0000 (UTC)
Date:   Fri, 27 Oct 2023 20:25:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/alternative: Add per-vendor patching
Message-ID: <20231027182529.GQZTwAmY+/OQ8jYFNt@fat_crate.local>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153418.GLZTvYejCkXb03rArO@fat_crate.local>
 <20231027181147.GC26550@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027181147.GC26550@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 08:11:47PM +0200, Peter Zijlstra wrote:
> But what if I want to do ALT_FLAG_VENDOR | ALT_FLAG_NOT?

I knew you were gonna say that...

You sit down and you implement it. :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
