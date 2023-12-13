Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14410811AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379351AbjLMRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjLMRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:25:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07263113
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:25:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DAAC433C7;
        Wed, 13 Dec 2023 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702488329;
        bh=Rs0hFmb82Hqzf21komSWkj3oRer1VDXhJ1YU2zeFSOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMpGevCv+58vaeJ2syLdMAqiJgyb4eQgqR6ZhV2w61es773mAvKNPl2Ly68gJRQVz
         y40rlFES3wHtKDhehVtCrbaKOqMWZnirM0z3oPxn+JsM9O5VazFtGQHmboilT/K+hi
         iJ8GWOHWUAGuOifX8CJs86hP9FdXGJJFhfGGsTJ1tCm0PctigtVeFN0SyrOT32Ywh1
         CY6lq5T4tUYTH+RhTiQmU+Xee+PSYF2pjEn+FN2WyoLWLyB8OAdgW83MDS7hvYJ3UL
         DA/Xt+m8puU6rJ4ilMh/3Kh1A47H+a2FajtLRSCSPTRyobkHUyKa4tSgA7+Zkao4M1
         YCDp3/SfjbeNA==
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: irq: set the correct node for shadow call stack
Date:   Wed, 13 Dec 2023 17:25:19 +0000
Message-Id: <170246934075.98561.2845796203103432401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231213012046.12014-1-shijie@os.amperecomputing.com>
References: <20231213012046.12014-1-shijie@os.amperecomputing.com>
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

On Wed, 13 Dec 2023 09:20:46 +0800, Huang Shijie wrote:
> The init_irq_stacks() has been changed to use the correct node:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=75b5e0bf90bf
> 
> The init_irq_scs() has the same issue with init_irq_stacks():
> 	cpu_to_node() is not initialized yet, it does not work.
> 
> This patch uses early_cpu_to_node() to set the init_irq_scs()
> with the correct node.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: irq: set the correct node for shadow call stack
      https://git.kernel.org/arm64/c/7b1a09e44dc6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
