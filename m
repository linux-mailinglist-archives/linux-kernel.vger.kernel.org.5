Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CF7AA5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjIVAKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIVAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:10:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD39F9;
        Thu, 21 Sep 2023 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1695341408;
        bh=tanMG9jJ4szQN0Frlry+jc3htu0MpognbIA9IzXLDmg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WJ1HtAjGprT9sOYX9H9F3j3hDGGFuEljj6j8IxiQkwhHmYEE1FZa/AhvPiadqYoJm
         OVaVBYEhbzS5RO9t74DcEb/MI8XOArY8t1Luhk02UCytoAKNSR4dvl5oEYzbuf8/US
         1wdlmJb7Zjq5l17wCBTgY+Nya1tA9+fSpjz/mfAlwZ+nLLlLvUTUd9rE0Iw/oTelpg
         UJqEl8NuqVtXuB69Wp+M6K9BhZQADMao+rHNyeZ/B6FCjKF6/EveUWGbGx8AgA4gi+
         wrafubMSH1dBU3lnpbgAoVLCdzOMG8rCN6bv6VgSAr3kMWJ2I4sS/Eql60QSwmUsp/
         ppSj4ZYMCmsRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RsCMM5W9zz4wy7;
        Fri, 22 Sep 2023 10:10:07 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        <tanyuan@tinylab.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: linux-next: Tree for Sep 20 (ppc32: ADB_CUDA Kconfig warning)
In-Reply-To: <fe130d55-7b5e-4444-85ea-c3fbf4eb238d@infradead.org>
References: <20230920133714.351f83f9@canb.auug.org.au>
 <fe130d55-7b5e-4444-85ea-c3fbf4eb238d@infradead.org>
Date:   Fri, 22 Sep 2023 10:10:07 +1000
Message-ID: <87il83m5k0.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> On 9/19/23 20:37, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20230919:
>> 
>> The mm tree lost its boot warning.
>> 
>> The drm-misc tree gained a conflict against Linus' tree.
>> 
>> Non-merge commits (relative to Linus' tree): 6006
>>  3996 files changed, 459968 insertions(+), 111742 deletions(-)
>> 
>> ----------------------------------------------------------------------------
>
> 4 out of 10 randconfigs have this warning:
>
> WARNING: unmet direct dependencies detected for ADB_CUDA
>   Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
>   Selected by [y]:
>   - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]
>
> WARNING: unmet direct dependencies detected for ADB_CUDA
>   Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
>   Selected by [y]:
>   - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]
>
> WARNING: unmet direct dependencies detected for ADB_CUDA
>   Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
>   Selected by [y]:
>   - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]

Crud. Caused by:

a3ef2fef198c ("powerpc/32: Add dependencies of POWER_RESET for pmac32")

I was suspicious of that select, I should have been *more* suspicious :)

I think this is a fix. The PPC32 isn't needed because ADB depends on (PPC_PMAC && PPC32).

diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 8bdae0caf21e..84f101ec53a9 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -2,7 +2,7 @@
 config PPC_PMAC
        bool "Apple PowerMac based machines"
        depends on PPC_BOOK3S && CPU_BIG_ENDIAN
-       select ADB_CUDA if POWER_RESET && PPC32
+       select ADB_CUDA if POWER_RESET && ADB
        select MPIC
        select FORCE_PCI
        select PPC_INDIRECT_PCI if PPC32

cheers
