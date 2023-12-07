Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F9808861
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379473AbjLGMob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379458AbjLGMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:44:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070D10C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:44:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmDVn5DVkz4xPL;
        Thu,  7 Dec 2023 23:44:33 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20231120232332.4100288-1-masahiroy@kernel.org>
References: <20231120232332.4100288-1-masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
Message-Id: <170195271160.2310221.3176675115907278770.b4-ty@ellerman.id.au>
Date:   Thu, 07 Dec 2023 23:38:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 08:23:32 +0900, Masahiro Yamada wrote:
> crtsavres.o is linked to modules. However, as explained in commit
> d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
> and always-y"), 'make modules' does not build extra-y.
> 
> For example, the following command fails:
> 
>   $ make ARCH=powerpc LLVM=1 KBUILD_MODPOST_WARN=1 mrproper ps3_defconfig modules
>     [snip]
>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such file or directory
>   make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platforms/cell/spufs/spufs.ko] Error 1
>   make[2]: *** [Makefile:1844: modules] Error 2
>   make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350: __build_one_by_one] Error 2
>   make: *** [Makefile:234: __sub-make] Error 2
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: add crtsavres.o to always-y instead of extra-y
      https://git.kernel.org/powerpc/c/1b1e38002648819c04773647d5242990e2824264

cheers
