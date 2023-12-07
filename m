Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB91808BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443476AbjLGPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443446AbjLGPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58470137
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:20:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C27C43395;
        Thu,  7 Dec 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701962425;
        bh=dEiEnCH6cRPod+jMyaWGSwv7fjXWfQzs3JH12GvvQcc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iZ8lfI3oa91MZ711pJyHksIVSwWf7i1E7+4oWJ6toQ67AQdG+YRiaHDM8gQVw1HEx
         FRLHr+ztG/VKGQEJQei+PqHxUk0CKwpTFl7o1tbLYFhwGjM14pAdkfhd2cjEhDB8sf
         CGRFK1fPUtO+2ZMIelcmJHur34fmvmv2ubhfjmvtj/UDM8Q2OAsqxJ7VwXTP4LdaoZ
         a7Px3uAHGgoNqLHMLdSPveq8TLRZsTfaX43wZ/L3Subolvr7/Lsof+EsPUyRHdQC+s
         BvhgY3xfCZEX+vWaSiTrJOVhscbS8PJlwQcrfMVz45v0wCWeTB6QFWraVqU3dSQkLG
         K5PijnOrDZ09g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAEAAC4314C;
        Thu,  7 Dec 2023 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: fix misaligned access handling of C.SWSP and C.SDSP
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <170196242582.12999.14639879842015285303.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 15:20:25 +0000
References: <20231103090223.702340-1-cleger@rivosinc.com>
In-Reply-To: <20231103090223.702340-1-cleger@rivosinc.com>
To:     =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  3 Nov 2023 10:02:23 +0100 you wrote:
> This is a backport of a fix that was done in OpenSBI: ec0559eb315b
> ("lib: sbi_misaligned_ldst: Fix handling of C.SWSP and C.SDSP").
> 
> Unlike C.LWSP/C.LDSP, these encodings can be used with the zero
> register, so checking that the rs2 field is non-zero is unnecessary.
> 
> Additionally, the previous check was incorrect since it was checking
> the immediate field of the instruction instead of the rs2 field.
> 
> [...]

Here is the summary with links:
  - riscv: fix misaligned access handling of C.SWSP and C.SDSP
    https://git.kernel.org/riscv/c/22e0eb04837a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


