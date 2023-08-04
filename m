Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F2D76F6C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjHDBKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHDBKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9ADE46
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B8161EFE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE8D3C433C7;
        Fri,  4 Aug 2023 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691111421;
        bh=4rWS7fKouJlmX9vgplTxwMHi8wgS2ZAlyi0J8AgXOB4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aTqWw1UKH26rn0R5KknzqCdp6ljrDjmONEepDMHuRwH/XSYu8KJQiWz3bjlu3HT40
         U1NnmyNe6+otb9Qw9aewjEIld9DzzPGhW+5f8+bWoLkQnPCmywBLTu44M0X0in+l4p
         irRlHK+FzbbloB4pDz2fhCkM7n7yN4q9RZQeWKhVmxcvJ3wTtxXws7mhl+niKr98kj
         NoVl7T9Rfwg+VfQiJrgsrAA1ZEAgP+BQ3J0OZrBPg7kekRD5uYr58kWOi8qoFSEBYG
         SEeSXCuFYkE0m/jqftgSYQz5UNjOG+FzzPS2pDztpTFvzWXzfCuTC5FgpAmTIe/xZp
         fPi+93pbBtE6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C8F7C595C1;
        Fri,  4 Aug 2023 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: bpf_struct_ops: Remove unnecessary initial
 values of variables
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169111142156.15722.3750188534512850509.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 01:10:21 +0000
References: <20230804175929.2867-1-kunyu@nfschina.com>
In-Reply-To: <20230804175929.2867-1-kunyu@nfschina.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat,  5 Aug 2023 01:59:29 +0800 you wrote:
> err and tlinks is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  v2:
>    Remove tlinks initialization assignment.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: bpf_struct_ops: Remove unnecessary initial values of variables
    https://git.kernel.org/bpf/bpf-next/c/5964d1e4594e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


