Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA19678575C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjHWMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjHWMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A6E62
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cg0fXrz4x2F;
        Wed, 23 Aug 2023 22:03:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <38fe1078eb403eef74dc8f29387636fd7ecdf43c.1692276041.git.christophe.leroy@csgroup.eu>
References: <38fe1078eb403eef74dc8f29387636fd7ecdf43c.1692276041.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/4xx: Remove WatchdogHandler() to fix no previous prototype error
Message-Id: <169279175575.797584.15357260120526935864.b4-ty@ellerman.id.au>
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

On Thu, 17 Aug 2023 14:40:49 +0200, Christophe Leroy wrote:
> Building ppc40x_defconfig throws the following error:
> 
>   CC      arch/powerpc/kernel/traps.o
> arch/powerpc/kernel/traps.c:2232:29: warning: no previous prototype for 'WatchdogHandler' [-Wmissing-prototypes]
>  2232 | void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
>       |                             ^~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/4xx: Remove WatchdogHandler() to fix no previous prototype error
      https://git.kernel.org/powerpc/c/ca13c130a43fe3ab625d22ada0a61e5c0b612229

cheers
