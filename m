Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE47A7E7800
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbjKJDa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjKJDa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:30:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C14681
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:30:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 481B4C433C9;
        Fri, 10 Nov 2023 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699587024;
        bh=rtAxl1XIygp6DGaBTvt0mWqDxNItsd1DoVkKb9H5nU8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jxOo+PaEXuse7iXtrzf0N7TggUmafmOoE9JQnEXmLUqUDU8intKyyZTNJI9jgUSce
         LNT2TA/t90LnF4ul22QS6gIB3NmzapUtNaY7hi+MPZzoS/LBACg1QZovMTZZwXd5Cx
         bSTxS1pM0k2DyxAUubeBhKc2Q10Z6u6l0pF5YoTnr89EtykTd3QvvuQYkUxz2JbYwc
         lyzxC42Xk3QU1RPq9KcX6aw5bQ8LhnVBwwNydpnGOXbdKeGE0sF7ywyacxMBDqGqPs
         PKbFXiyTe/bYDDggdyOgMAuuBZloGzNmPHb0Mihz1c8Cfow18BmhC2Lpn/JuLbF7/e
         Uzqt579hHuMWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CD20C691EF;
        Fri, 10 Nov 2023 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3] selftests: bpf: xskxceiver: ksft_print_msg: fix format type
 error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169958702417.21601.7609791725807208554.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Nov 2023 03:30:24 +0000
References: <20231109174328.1774571-1-anders.roxell@linaro.org>
In-Reply-To: <20231109174328.1774571-1-anders.roxell@linaro.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  9 Nov 2023 18:43:28 +0100 you wrote:
> Crossbuilding selftests/bpf for architecture arm64, format specifies
> type error show up like.
> 
> xskxceiver.c:912:34: error: format specifies type 'int' but the argument
> has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
>  ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
>                                                                 ~~
>                                                                 %llu
>                 __func__, pkt->pkt_nb, meta->count);
>                                        ^~~~~~~~~~~
> xskxceiver.c:929:55: error: format specifies type 'unsigned long long' but
>  the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
>  ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
>                                     ~~~~             ^~~~
> 
> [...]

Here is the summary with links:
  - [PATCHv3] selftests: bpf: xskxceiver: ksft_print_msg: fix format type error
    https://git.kernel.org/bpf/bpf/c/fe69a1b1b6ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


