Return-Path: <linux-kernel+bounces-14992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB658225D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12BE1C21A35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C0655;
	Wed,  3 Jan 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnCrYyOm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3757E;
	Wed,  3 Jan 2024 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C07ACC433C9;
	Wed,  3 Jan 2024 00:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704240623;
	bh=OgbpcBg5BQ4CqHWiS4qH/O+UuhEmibGTTyMm73CySfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QnCrYyOmpeM4TwHq9NcL6GNulV17TrkdZIcPoCsNLr9+VPEoGQVL8oL9nSbs97kFV
	 oC1Dm7KNOsTNfCKPs3NLsbQgneAA2KNT7C2c7oNBm1YDcfqdp14wBQtc/dLTS+f1pd
	 13N/2rkWvSEQa7zJmngni17XIHj/EM1Nh7oiBMlfZNddByUs89FTAdNqnhsrdPv/eQ
	 Gc4zNhx5i/jakKY8xn4U+vxAiLA7Rtcv1AzEjFynnP4QtGEJvGFFyUj+ZHHUu9oXaU
	 kFlX4XpleLn/VVcggpdzZmyrjFZ1rpKnRXEbV2sUc17WXEU1JlMnfjnh3ol/3vLrR7
	 vl/HzG7ZIzfJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A50A7C395C5;
	Wed,  3 Jan 2024 00:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] [v2] sfc: fix a double-free bug in efx_probe_filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170424062367.8088.17756583344625723793.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 00:10:23 +0000
References: <20231225112915.3544581-1-alexious@zju.edu.cn>
In-Reply-To: <20231225112915.3544581-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: horms@kernel.org, ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Dec 2023 19:29:14 +0800 you wrote:
> In efx_probe_filters, the channel->rps_flow_id is freed in a
> efx_for_each_channel marco  when success equals to 0.
> However, after the following call chain:
> 
> ef100_net_open
>   |-> efx_probe_filters
>   |-> ef100_net_stop
>         |-> efx_remove_filters
> 
> [...]

Here is the summary with links:
  - [net,v2] sfc: fix a double-free bug in efx_probe_filters
    https://git.kernel.org/netdev/net/c/d5a306aedba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



