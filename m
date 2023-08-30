Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6678DBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbjH3Shh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbjH3Ok0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3F193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 257386214F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 762BBC433C9;
        Wed, 30 Aug 2023 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693406422;
        bh=QoytJa3+FvhXLPVs7I051rsxKc+4d5AOmxX+36Q38rE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k/m+AyOy2ZMqASRTESImqdHu0oTmGXC8UDxCBBoRhNEQKNyESjcRZJhNzxPpqty1c
         3nnwCLTjVIxZXse9FZSQ2TrEqWClv9JjSzN1PBS+0ocxpgz+lJIEeo2pW8xfJnefql
         Wsc3jj5jk3dmPA39DvTPZGepWAFMPV8KEsMd/U5I5xypzLx+ofIYZDPmdVXGMik1ET
         84CaZH6gyMhjB8s12VxQpvKmGBVhlgmgZttDeolpJSDXmipsU1m0BYvIa6XQcMsjzU
         fNac9TD6MSCuV5m8sygwH21+u81iIMdx9o/dXlSVHNE5FHkeqoNSCGd8jObaJUxHp8
         BvVNP2H2F5y0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 551A4E29F39;
        Wed, 30 Aug 2023 14:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Clean up some standardization stuff
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169340642234.1057.1251981139768787311.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 14:40:22 +0000
References: <20230828155948.123405-1-void@manifault.com>
In-Reply-To: <20230828155948.123405-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, hch@infradead.org, hawkinsw@obs.cr,
        dthaler@microsoft.com, bpf@ietf.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 28 Aug 2023 10:59:45 -0500 you wrote:
> The Documentation/bpf/standardization subdirectory contains documents
> that will be standardized with the IETF. There are a few things we can
> do to clean it up:
> 
> - Move linux-notes.rst back to Documentation/bpf. It doesn't belong in
>   the standardization directory.
> - Move ABI-specific verbiage from instruction-set.rst into a new abi.rst
>   document. This document will be expanded significantly over time. For
>   now, we just need to get anything describing ABI out of
>   instruction-set.rst.
> - Say BPF instead of eBPF in our documents. It's just creating
>   confusion.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf,docs: Move linux-notes.rst to root bpf docs tree
    https://git.kernel.org/bpf/bpf/c/aee1720eeb87
  - [bpf-next,2/3] bpf,docs: Add abi.rst document to standardization subdirectory
    https://git.kernel.org/bpf/bpf/c/deb884072546
  - [bpf-next,3/3] bpf,docs: s/eBPF/BPF in standards documents
    https://git.kernel.org/bpf/bpf/c/7d35eb1a184a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


