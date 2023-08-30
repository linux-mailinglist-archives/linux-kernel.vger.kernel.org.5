Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5470778DD73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbjH3Su0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244553AbjH3NUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB91B2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51388617AA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C46CC433CD;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401634;
        bh=jLz1YYGHzcPF4bqPX3YGwB9P8fGgq5w35e2LcaUAALw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oildnxhOx+pk99S2flDq2SUTE6640rBDJ5ktVb2QUKCISWMt1hZiAV4RKO7t8IIs0
         INzLOApUdbHFGpRyz0R1EguyJo3tawL3IpTIcrj2i3Q1UHwmLON3o50pRxbmevR6VX
         CRXaXBAPOQmBX61GqDIj3Bevv625A67TG8rBCfEEGIK/9G/CvouCKJEZrxQqU8InVQ
         s/q9c4XZqm/OfkdAVmL2HeHavxv72M2vGHDa1ybFwiRGX6IxaAB0RZ4pzwB7DX9qRn
         xDLtmQs/65xH7UKuStqSt+chUHcNVWLMpkjyZ6G6Rg3nKH0kT3MqqHV5SNBF+05qu3
         gTqf8tEY9gD0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C8CEE4509F;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] riscv: Reduce ARCH_KMALLOC_MINALIGN to 8
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163450.19859.9050440300788859353.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <20230718152214.2907-1-jszhang@kernel.org>
In-Reply-To: <20230718152214.2907-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 18 Jul 2023 23:22:12 +0800 you wrote:
> Currently, riscv defines ARCH_DMA_MINALIGN as L1_CACHE_BYTES, I.E
> 64Bytes, if CONFIG_RISCV_DMA_NONCOHERENT=y. To support unified kernel
> Image, usually we have to enable CONFIG_RISCV_DMA_NONCOHERENT, thus
> it brings some bad effects to coherent platforms:
> 
> Firstly, it wastes memory, kmalloc-96, kmalloc-32, kmalloc-16 and
> kmalloc-8 slab caches don't exist any more, they are replaced with
> either kmalloc-128 or kmalloc-64.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: allow kmalloc() caches aligned to the smallest value
    https://git.kernel.org/riscv/c/2926715163cf
  - [v3,2/2] riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC for !dma_coherent
    https://git.kernel.org/riscv/c/f51f7a0fc2f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


