Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B72A77C735
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjHOFoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjHOFmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B81FF5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9008E62035
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5604C433C9;
        Tue, 15 Aug 2023 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692078020;
        bh=BaMNfOafCyireaUmz1eC4g3fgf/LdePVKt7WuTi2q3c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tuzvbJvt7y6S1MI7Hl2v2ex1LSExib+r4OSRllD9IGWAWTJzRnCD9uwNcY0BW01cs
         pwtyjDi2TTfNXMbR08jovGNxbctfgeKc/2Idonr2jq9miFT42sH75lMOCY8IRKYWse
         n/xXXzZ5Oai1vMzu81a6ifegl0w4OHyrZGuU+1jIiu/kHFPE5zHLItZ1F8XGhffwd3
         YrX3eMV/gmhqkpeiuGQmTYhr20Wbhc/J8G5gIAxYntu7IjqSCxLouNIUkqG39v5WIe
         U6dgXJXxDujC95gghWVCkiJRSEowDtCSvE6V9X3oey1EOVk7eO5VuLW0WBoLz2AN95
         kOZ0pvukJMf+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96F81C41620;
        Tue, 15 Aug 2023 05:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] Update and document struct_ops
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169207802061.9126.2905452302872752735.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Aug 2023 05:40:20 +0000
References: <20230814185908.700553-1-void@manifault.com>
In-Reply-To: <20230814185908.700553-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, clm@meta.com,
        thinker.li@gmail.com, netdev@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 14 Aug 2023 13:59:06 -0500 you wrote:
> The struct bpf_struct_ops structure in BPF is a framework that allows
> subsystems to extend themselves using BPF. In commit 68b04864ca425
> ("bpf: Create links for BPF struct_ops maps") and commit aef56f2e918bf
> ("bpf: Update the struct_ops of a bpf_link"), the structure was updated
> to include new ->validate() and ->update() callbacks respectively in
> support of allowing struct_ops maps to be created with BPF_F_LINK.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Support default .validate() and .update() behavior for struct_ops links
    https://git.kernel.org/bpf/bpf-next/c/8ba651ed7fa1
  - [bpf-next,v3,2/2] bpf: Document struct bpf_struct_ops fields
    https://git.kernel.org/bpf/bpf-next/c/bb48cf1679d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


