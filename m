Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950D078575B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjHWMD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjHWMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0163E67
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cd1y2Qz4x0W;
        Wed, 23 Aug 2023 22:03:45 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <c8253017e355638132737ff47936e290df8738d1.1692282432.git.christophe.leroy@csgroup.eu>
References: <c8253017e355638132737ff47936e290df8738d1.1692282432.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/4xx: Add missing includes to fix no previous prototype errors
Message-Id: <169279175576.797584.7773494113492179967.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:27:23 +0200, Christophe Leroy wrote:
> A W=1 build of ppc40x_defconfig throws the followings errors:
> 
>   CC      arch/powerpc/platforms/4xx/uic.o
> arch/powerpc/platforms/4xx/uic.c:274:13: warning: no previous prototype for 'uic_init_tree' [-Wmissing-prototypes]
>   274 | void __init uic_init_tree(void)
>       |             ^~~~~~~~~~~~~
> arch/powerpc/platforms/4xx/uic.c:319:14: warning: no previous prototype for 'uic_get_irq' [-Wmissing-prototypes]
>   319 | unsigned int uic_get_irq(void)
>       |              ^~~~~~~~~~~
>   CC      arch/powerpc/platforms/4xx/machine_check.o
>   CC      arch/powerpc/platforms/4xx/soc.o
> arch/powerpc/platforms/4xx/soc.c:193:6: warning: no previous prototype for 'ppc4xx_reset_system' [-Wmissing-prototypes]
>   193 | void ppc4xx_reset_system(char *cmd)
>       |      ^~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/4xx: Add missing includes to fix no previous prototype errors
      https://git.kernel.org/powerpc/c/7dac7cf1b407605c15d85ae885377ba0560ca4cd

cheers
