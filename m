Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35278575D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjHWMEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjHWMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433A2E63
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cf19WWz4x1S;
        Wed, 23 Aug 2023 22:03:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <830923f0e0375a14609204246d302c7476a8f948.1692279855.git.christophe.leroy@csgroup.eu>
References: <830923f0e0375a14609204246d302c7476a8f948.1692279855.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/4xx: Remove pika_dtm_[un]register_shutdown() to fix no previous prototype
Message-Id: <169279175575.797584.12867145459460437286.b4-ty@ellerman.id.au>
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

On Thu, 17 Aug 2023 15:44:26 +0200, Christophe Leroy wrote:
> ppc4xx_defconfig with W=1 results in:
> 
>   CC      arch/powerpc/platforms/44x/warp.o
> arch/powerpc/platforms/44x/warp.c:369:5: error: no previous prototype for 'pika_dtm_register_shutdown' [-Werror=missing-prototypes]
>   369 | int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/platforms/44x/warp.c:374:5: error: no previous prototype for 'pika_dtm_unregister_shutdown' [-Werror=missing-prototypes]
>   374 | int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/4xx: Remove pika_dtm_[un]register_shutdown() to fix no previous prototype
      https://git.kernel.org/powerpc/c/81554d10b22a211e4598a067a0f84b6e9e492669

cheers
