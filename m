Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15C7ED456
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbjKOU5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbjKOU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:57:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79111715
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:57:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7FAFC4AF7B;
        Wed, 15 Nov 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700081422;
        bh=1y5oWCNtCHL3uMIbr3vozcvY7bGYDWsi1IsJQNnbL0U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OrRFVubuLgBk+nVOQV6Bykc2IyskVKJvfX4Xhd4ljN1XRlWjWAzX3XnpaMxR/oluj
         m2eQnPycrVDhqcQMxJptFzm6AwDa64bo8djeIqoHnaWLk2ku2SZbUJjssmYmiB330X
         TvQxK8EGBxAjuGb7lZ/aEegvjm1IAmRsnnqPYhkPQUPR382zcKwuHpDk4WxpBmfFor
         PXPP9clnxvL5XT0Bb88BRHsMwGFp4nuqQkh/tDYToUjmfgXzuhG0VMKAA1JpjBYyiP
         oBmANGcDzAaBo0hmIFAvPaVDNThmkJXUZvDZge4Lfr9U9+GP6IohQMCL4mP+VybaWP
         mYzU4ha1uUtKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB6E9E270EF;
        Wed, 15 Nov 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf/tests: Remove test for MOVSX32 with offset=32
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170008142276.12596.14625966790181172770.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Nov 2023 20:50:22 +0000
References: <20231110175150.87803-1-puranjay12@gmail.com>
In-Reply-To: <20231110175150.87803-1-puranjay12@gmail.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 10 Nov 2023 17:51:50 +0000 you wrote:
> MOVSX32 only supports sign extending 8-bit and 16-bit operands into 32
> bit operands. The "ALU_MOVSX | BPF_W" test tries to sign extend a 32 bit
> operand into a 32 bit operand which is equivalent to a normal BPF_MOV.
> 
> Remove this test as it tries to run an invalid instruction.
> 
> Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com
> 
> [...]

Here is the summary with links:
  - [bpf] bpf/tests: Remove test for MOVSX32 with offset=32
    https://git.kernel.org/bpf/bpf-next/c/5fa201f37c2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


