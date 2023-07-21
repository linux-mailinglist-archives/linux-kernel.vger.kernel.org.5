Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6338475BD98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGUFAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUFAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:00:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5415B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1689915638;
        bh=zOaO/BDiMViyIwV25A6Bb8YgrTQHlQUOzuaNQJEjFbI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kMSCklilWZrrZg224QJpabopJPo7ZDKutmdB2yp5BfMhoOC8ytdTiPCgv1tuqMpM9
         JDwhRDIVruD0cm3BHtEo9ZchHtb9yLW3Va1h9p/ZfEfzDFqIE6oZiNpC5ZJuFuKNCB
         G+kl6hkBtS2kAcIwjmZZ4XdNxHATlUKSb+mNsRJkOmxXRqdKFOmdDLUvQPQ3bZKDru
         XBHiNpdW1cxCSo14NGh0Uo7VwsgdUR/dPXFOYXGjkT1Ms/N/Xv6eavsPWxPsU1TnWA
         Tr5qRQrxX5LSMkC+MyLx8N9vtvB1JuUKZJ1m1KrAlWPxgDDu9bIdl2A0+fdyZyNNZj
         sGeqSFaV9P/cA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6cnf1zwhz4wxx;
        Fri, 21 Jul 2023 15:00:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: (subset) [PATCH v4 00/15] powerpc/objtool: uaccess validation
 for PPC32 (v4)
In-Reply-To: <168986105076.1117384.18255319220057556882.b4-ty@ellerman.id.au>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
 <168986105076.1117384.18255319220057556882.b4-ty@ellerman.id.au>
Date:   Fri, 21 Jul 2023 15:00:38 +1000
Message-ID: <87mszpj1u1.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 11 Jul 2023 18:08:26 +0200, Christophe Leroy wrote:
>> This series adds UACCESS validation for PPC32. It includes
>> a dozen of changes to objtool core.
>> 
>> It applies on top of series "Cleanup/Optimise KUAP (v3)"
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=363368&state=*
>> 
>> It is almost mature, performs code analysis for all PPC32.
>> 
>> [...]
>
> Applied to powerpc/fixes.
>
> [01/15] Revert "powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLAGS() with asm goto"
>         https://git.kernel.org/powerpc/c/b49e578b9314db051da0ad72bba24094193f9bd0

Sorry that's b4 getting confused, I actually applied the v5 that I sent:

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20230712134552.534955-1-mpe@ellerman.id.au/

cheers
