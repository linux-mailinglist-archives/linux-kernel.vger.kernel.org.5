Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325DE79D9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjILUUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjILUU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1332410D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:20:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A83DC433CA;
        Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694550025;
        bh=gU/CeO6Y/T1uavamob8EZRBzi77IzZ7qj2zJ7oTQMBo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=obbcqfaHsYA2dOc9urGdZ6AGLjEfPrMnjD1rNHGNmY70wJoLJkTPRIR9OLeNij+5P
         iqVGZh1xteAPm18aaCoduzHjQXmx6cGfxvtgW3zEtZBB4crdsVfha8pqdDsnDo3lpt
         YikCT7NTwNa0RCMkm/G7C8ikeXUFQsxB6jp/2cj4nZHFWDxyZfpvyBBHskYMbYZLAw
         +RYMavHAGnuAEok6ewyjgam4Cwcrg9NhZ4SyDJg6y57KEDhdhDIcDBKbgWqob8VCfe
         9LTAegjGiM0sxEN6Qd4PWd3gWSAD710n9n/mRgLdgDsZximiVDsm3DDvEDc6ucsz7I
         ESUYFCRPmfcJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CE56E1C290;
        Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: fix unpriv_disabled check in test_verifier
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169455002550.29579.5589738448347101961.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 20:20:25 +0000
References: <20230912120631.213139-1-asavkov@redhat.com>
In-Reply-To: <20230912120631.213139-1-asavkov@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, eddyz87@gmail.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Sep 2023 14:06:31 +0200 you wrote:
> Commit 1d56ade032a49 changed the function get_unpriv_disabled() to
> return its results as a bool instead of updating a global variable, but
> test_verifier was not updated to keep in line with these changes. Thus
> unpriv_disabled is always false in test_verifier and unprivileged tests
> are not properly skipped on systems with unprivileged bpf disabled.
> 
> Fixes: 1d56ade032a49 ("selftests/bpf: Unprivileged tests for test_loader.c")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: fix unpriv_disabled check in test_verifier
    https://git.kernel.org/bpf/bpf/c/d128860dbb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


