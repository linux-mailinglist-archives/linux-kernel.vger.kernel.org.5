Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556777BED23
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378800AbjJIVVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjJIVU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:20:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEBF132
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFF51C433C8;
        Mon,  9 Oct 2023 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886424;
        bh=sKVXctHEh62JJk3vAH4XnrG9P6djuHmpEHt96khoJ9o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qCk3BgdcSQI+q6NsahWBwtVfYMV1x4ZCHzyFTKTZNBk7oXEg3KPKBk47NTYfoVs2J
         /Y5L1GmR4WOLuBiKPHnAk0hmGaFNSpS4HgalKedJ2VI3AncH5BLzqZ22JrX0mgB1HV
         1HmSmATn0bTgvYkf2e81aHzRAtZJBDxmH4f592OQRSHStclvgEQhz8ohqWHHxA6bhy
         +Qj9L12V52GVgSSgjBjcwIqZY3/SQMFurktusMkw1bIMHHbBR8CETYth+VvTi7ABNk
         Rcljl6DBarIwbO934qxp6raP3FDCzO2qeqjPOVdd50vQ7YpSuqrLTS73fhDhkFo9BR
         Y1TY7BLVjBjNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4D58E11F47;
        Mon,  9 Oct 2023 21:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix verifier log for async callback return
 values
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169688642465.32608.1593187002988701901.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Oct 2023 21:20:24 +0000
References: <20231009161414.235829-1-void@manifault.com>
In-Reply-To: <20231009161414.235829-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
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

On Mon,  9 Oct 2023 11:14:13 -0500 you wrote:
> The verifier, as part of check_return_code(), verifies that async
> callbacks such as from e.g. timers, will return 0. It does this by
> correctly checking that R0->var_off is in tnum_const(0), which
> effectively checks that it's in a range of 0. If this condition fails,
> however, it prints an error message which says that the value should
> have been in (0x0; 0x1). This results in possibly confusing output such
> as the following in which an async callback returns 1:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix verifier log for async callback return values
    https://git.kernel.org/bpf/bpf/c/829955981c55
  - [bpf-next,2/2] bpf/selftests: Add testcase for async callback return value failure
    https://git.kernel.org/bpf/bpf/c/57ddeb86b311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


