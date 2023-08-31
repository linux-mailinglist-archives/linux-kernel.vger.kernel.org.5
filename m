Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F778E539
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbjHaEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjHaEEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:04:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BDD95
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:04:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbncG10wsz4wy4;
        Thu, 31 Aug 2023 14:04:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <5e0f97d5cbcd05238b56b4424ab096468296824d.1692684461.git.christophe.leroy@csgroup.eu>
References: <5e0f97d5cbcd05238b56b4424ab096468296824d.1692684461.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/64e: Fix circular dependency with CONFIG_SMP disabled
Message-Id: <169345455027.11824.17933728050023011677.b4-ty@ellerman.id.au>
Date:   Thu, 31 Aug 2023 14:02:30 +1000
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

On Tue, 22 Aug 2023 08:07:50 +0200, Christophe Leroy wrote:
> asm/percpu.h includes asm/paca.h which needs struct tlb_core_data
> which is defined in mmu-e500.h
> 
> asm/percpu.h is included from asm/mmu.h in a #ifdef CONFIG_E500
> before the inclusion of mmu-e500.h
> 
> To fix that, move the inclusion of asm/percpu.h into mmu-e500.h
> after the definition of struct tlb_core_data
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64e: Fix circular dependency with CONFIG_SMP disabled
      https://git.kernel.org/powerpc/c/0e2a34c467a0de2b0309d033e2700ce608e3fbf4

cheers
