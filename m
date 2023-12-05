Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF6805C68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346945AbjLEPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442364AbjLEPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:17:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A4D4B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:17:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB449C433CC;
        Tue,  5 Dec 2023 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789426;
        bh=u0cVlqpFIgozphn0YtMmI9Rg2WyYQkpa6+1c55rCtGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVPxDDVUw6LLgBi39Y8flaTz8ZCCZ7QiPkWL3GRS6G/voXLm0rD7sJ8VIvOS3vaMV
         trQ6MvyyFlxMkhuxNY6udO6XIaCsg/X6RdvejTiUklrlEqtuf1HCQFjs5xtbP+Ggtq
         z8SU7ZMiyWwaUzlUEIkmNZrLASsszr/HpnTLhNH+g8K7xU0shXpttOeOltkGgRUlyD
         u2GKJK9TfFohG2zhefeHtrQ7DZ3KId6CoDvrn6oAuOLx8hDsKUCH+kNpzplTsXUo37
         hcGZghH52jZ7uVNST4ugKEOrTDrYZyfU2MJfQI4cgtefy8cRLRrT0vc1Vg5+rlcfP4
         d4FZKjIXEORfA==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        rafael@kernel.org, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: irq: set the correct node for VMAP stack
Date:   Tue,  5 Dec 2023 15:16:36 +0000
Message-Id: <170178641072.13754.15163791015207648414.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231124031513.81548-1-shijie@os.amperecomputing.com>
References: <ZV-EA46rBJ9WK4UH@arm.com> <20231124031513.81548-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 11:15:13 +0800, Huang Shijie wrote:
> In current code, init_irq_stacks() will call cpu_to_node().
> The cpu_to_node() depends on percpu "numa_node" which is initialized in:
>      arch_call_rest_init() --> rest_init() -- kernel_init()
> 	--> kernel_init_freeable() --> smp_prepare_cpus()
> 
> But init_irq_stacks() is called in init_IRQ() which is before
> arch_call_rest_init().
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: irq: set the correct node for VMAP stack
      https://git.kernel.org/arm64/c/75b5e0bf90bf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
