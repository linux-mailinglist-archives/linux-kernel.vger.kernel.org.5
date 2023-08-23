Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F611785762
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjHWMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjHWMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3644E63
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cj44xXz4x2J;
        Wed, 23 Aug 2023 22:03:49 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <0aa1141e18a84d926e199093204b37ec993f0c87.1692275185.git.christophe.leroy@csgroup.eu>
References: <0aa1141e18a84d926e199093204b37ec993f0c87.1692275185.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Remove init_internal_rtc() to fix no previous prototype error
Message-Id: <169279175575.797584.8768847213468834876.b4-ty@ellerman.id.au>
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

On Thu, 17 Aug 2023 14:26:45 +0200, Christophe Leroy wrote:
> A W=1 build of mpc885_ads_defconfig throws the following error:
> 
>   CC      arch/powerpc/platforms/8xx/m8xx_setup.o
> arch/powerpc/platforms/8xx/m8xx_setup.c:41:1: error: no previous prototype for 'init_internal_rtc' [-Werror=missing-prototypes]
>    41 | init_internal_rtc(void)
>       | ^~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Remove init_internal_rtc() to fix no previous prototype error
      https://git.kernel.org/powerpc/c/4531f128eac356144545b833908b6ffbc0292e16

cheers
