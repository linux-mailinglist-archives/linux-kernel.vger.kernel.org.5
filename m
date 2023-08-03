Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7625A76EDA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjHCPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjHCPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75A30D3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D6561DF1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AE43C433CB;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075423;
        bh=OR7ORL/WtWYYQsez0TJeKB4aloYKQCRJyB84PHkeOMc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rpFlw4AZZsJpZciYfrdUcdyYoxGa9eHUIB8rPJ+UOI53Wo03O4yxnOX/04xev9+x4
         XJlZfLp2MzbqZN5NQjccyNjJMvJ5BFElI9Pv7kiuoGe/fSEh9ewvpk2cWj4zUbqQhL
         Adv7+/oD+fY4le6Miu+LwYGTRR5GcYCrgjeaBtH8606nGp2+ADnAx/bZ47zbbzmG1U
         EdWIh9LEDbtBHum44STILNsX0SOJYlmRvghuBsRFTJERpCxn4f+9bDLKe1QvwcP9bL
         TBqOaW8LJ/zgfFeqwogkaubMsp6XgDy2QIM/g/kS25QILxKSdqIVAO/ENYsPSFJxJY
         PKMdS/rogAkhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01E7BC3274D;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Start of DRAM should at least be aligned on PMD size
 for the direct mapping
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542300.19238.17913302600007143325.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 15:10:23 +0000
References: <20230704121837.248976-1-alexghiti@rivosinc.com>
In-Reply-To: <20230704121837.248976-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, suagrfillet@gmail.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  4 Jul 2023 14:18:37 +0200 you wrote:
> So that we do not end up mapping the whole linear mapping using 4K
> pages, which is slow at boot time, and also very likely at runtime.
> 
> So make sure we align the start of DRAM on a PMD boundary.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping
    https://git.kernel.org/riscv/c/9d3e8e1ff0d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


