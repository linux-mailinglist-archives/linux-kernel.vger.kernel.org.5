Return-Path: <linux-kernel+bounces-57396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F277684D7EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6466F287304
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067A1D6BE;
	Thu,  8 Feb 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+5c7Cr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ADE1D540;
	Thu,  8 Feb 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360029; cv=none; b=VjPvM8aF6UU7NvhGri9cQdV211lVRXXG57tRhtMzh64jvsA3YCpuOFkvB1zC33VCXMyvmvB702P4WS4mwVSN7o+AYQqH/QFH98h7/sZuHIZVSa40Uo+PCUTFhsn1OjcyxTp6t2tele65OEfLSI7QVjs0UetdMFbUUc5igrb086Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360029; c=relaxed/simple;
	bh=oqIUq0+9PWDUdp7JNIr+uhslNtaLYeLhrukFS7asBjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c+z333uonqlt33z3s1gIIfnCshaZRCyIY1ScMkShuPfaTdWpfN3q6vJroVJlJSGwKmbsiceltBCzzAmaEwium6ldowNlE1FnGQxwm8p0o0KDoDtKgOjZsmSwsIgMCkmQyO9wJIVS0yiIAI3/Yh1n90nSTqJKHLvHgoThuSn1QUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+5c7Cr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CD78C43394;
	Thu,  8 Feb 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707360028;
	bh=oqIUq0+9PWDUdp7JNIr+uhslNtaLYeLhrukFS7asBjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G+5c7Cr49LkcyojTmvwep/kbT/HMRYFQ20v3HW11MicTuxv7guWrHYkH7rSaPKicd
	 s+3C7reg3t+VPKRtDSaSIr/LBFJfwR6fwYJrCfG7IWuD5jz+tdsTsF/vfUJnKlm5jt
	 MgPL7KoQ5meWUF9BwUqAUdASHi86bQTraaoHyXcgvy3Ogh8wSJelL47XP4OoEC6Gzi
	 AvrlaxExU/vr4HsIohWyHVLa00ngPLR8huLMRjnLJSyBgjUtfGadJJsAbV3f7YJDjX
	 0E7kmJv+kl0YU62RqjkFeYaOHUZraiSEFI3bQpIAjyNjyLSB2FxJZvY3HXmMPChgO3
	 AEeUCT/kKbugg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F2F7E2F2F1;
	Thu,  8 Feb 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: change the term virtual ISM to Emulated-ISM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170736002851.13402.12604224600010407697.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 02:40:28 +0000
References: <20240205033317.127269-1-guwen@linux.alibaba.com>
In-Reply-To: <20240205033317.127269-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 11:33:17 +0800 you wrote:
> According to latest release of SMCv2.1[1], the term 'virtual ISM' has
> been changed to 'Emulated-ISM' to avoid the ambiguity of the word
> 'virtual' in different contexts. So the names or comments in the code
> need be modified accordingly.
> 
> [1] https://www.ibm.com/support/pages/node/7112343
> 
> [...]

Here is the summary with links:
  - [net-next] net/smc: change the term virtual ISM to Emulated-ISM
    https://git.kernel.org/netdev/net-next/c/b27696cd8fcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



