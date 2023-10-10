Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C0F7C40C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjJJUHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjJJUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:06:54 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BAB93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:04:45 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2B6B40E014B;
        Tue, 10 Oct 2023 20:04:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KGg7Umx757r3; Tue, 10 Oct 2023 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696968281; bh=BDKdSZWI1t4rPS1G0WEtrLn+R5W1McIc6NS5rdPWBYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXrESqsNZb+oI+9Em3rNQHFUgFwk8Ia+3gekXb7BpntVGHMAWHxxcEIiUsQp5RHJ4
         msKRfmQd/xPW0g96dJjl9yW+gLJzQO0Dv+zY7HoxDv+nO5lMjSG6QFVv+nnQtKnFoR
         LD6PlMxymWFxUKP15mE+lqgT60MbOSU8Sv3cw/sppUFXn07aOjgFVTCUaEPR/1M0V9
         3+nI7l35GWkN27jWMxRj8f++eyB7FcFNBLuTieXPw4v67MHXJ4k31T2Qwz66u6V4ay
         WjWm/zBHv0xnYG326YWQrDNuwXl8/ZCnLPcd3rjTV0qRJ1HSAMPrOsByBOG2yW0GnZ
         8ErDhLwxgIO5DkuE8L4UInAUeAA+H9ZmGT7TCYhpsjagFdLWAIFLTsK/Bdl45fEr7/
         J8DmGDpz5XDv6vYSAzd659rdW2v6daEhFSUCuDrQ/E7CqUqxgIpuwLIbBln89g2Vus
         Gk6Axy7av8NH/FtWGwugiTMGGWi9Evl97Wq3XwtIwi9RZ2VGGzH2D+4U2giiEVIXFm
         w89JvoIuL2005FACZKF8H96WnhesTdCYg7qkBNRY/+7n52jb5Wko7kQonbElsWBjPA
         J13MntSFWfSrMNiv5Drowr7gYnFIXVsR2HypLUrNz7190fYRVSQ0kETuujo5LZVLal
         e7Z5CVUVZKlbyDbIky8DawPw=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5DAB40E0187;
        Tue, 10 Oct 2023 20:04:34 +0000 (UTC)
Date:   Tue, 10 Oct 2023 22:04:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010195721.p5pb273kevg7ydxz@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:57:21PM -0700, Josh Poimboeuf wrote:
> Also we could make objtool properly detect the non-relocated jump
> target.

I was wondering about that... I guess it can compute the JMP target and
compare it to the address of __x86_return_thunk?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
