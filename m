Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F16759BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGSRA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932F172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6484617B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D00B7C433C8;
        Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689786022;
        bh=0QHWh0ZyANR6sFatpI3iKS3ZiOSU5OuS3djaKj/sziU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OqyU8S0M6KQ75CgbpxWGTj2LHaNSUQhp/Tai5zgIv78YVVTZqJVyvtyg8tRet1Krl
         IUdXijrAvMhqznxgcA6B9vaqRGMt4BWdLe6gMFzQ/E3GrzE2I5ncHqHSf7S9EZ7d1g
         11rZnQ8+PxLfa6BhrN0N7jOV3UEu+qKr2YC5+cXLyyD5CL/i3BXbIR6AGAl1xk2mT6
         beFKbxKyIDrXescyXjB0E744cl9KvBLKK1ppO2UzvdX664tc4zvy0zmMaDvm1cWIeV
         2nJnCbPc1e03s3N1YTgq3uhWpmcnlrPsvZpTA/k7o3v23wfm+vGQE3rNAK7cKoJS5V
         SM5Nk6KyWyS6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8392C6445A;
        Wed, 19 Jul 2023 17:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 x86: initialize the variable "first_off" in save_args()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168978602267.22183.12710540348045539494.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 17:00:22 +0000
References: <20230719110330.2007949-1-imagedong@tencent.com>
In-Reply-To: <20230719110330.2007949-1-imagedong@tencent.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     yhs@fb.com, davem@davemloft.net, dsahern@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, imagedong@tencent.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        flyingpeng@tencent.com, dan.carpenter@linaro.org
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Jul 2023 19:03:30 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> As Dan Carpenter reported, the variable "first_off" which is passed to
> clean_stack_garbage() in save_args() can be uninitialized, which can
> cause runtime warnings with KMEMsan. Therefore, init it with 0.
> 
> Fixes: 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING")
> Cc: Hao Peng <flyingpeng@tencent.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/09784025-a812-493f-9829-5e26c8691e07@moroto.mountain/
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, x86: initialize the variable "first_off" in save_args()
    https://git.kernel.org/bpf/bpf-next/c/492e797fdab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


