Return-Path: <linux-kernel+bounces-96943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A8287636E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB8F1C20F84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906056463;
	Fri,  8 Mar 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ7iiB32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC955E7E;
	Fri,  8 Mar 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898031; cv=none; b=d9l/XBvnVXsaL+EeQ4ZmOGXjc9Om4+QImfxUL8FB7ZJ4nbrugNvaE2JbaZvkFRs16cjPqLSuQbondF+faV38xc+o6BuOqt+Ji2IErISUh2ROSJl1iYV8mfgQezSdpBSb6vuq2dO+bZGA97NWU7RrYkuyW7NihIBUaJkK2tqtfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898031; c=relaxed/simple;
	bh=jqEUhr6X+7mZr8wkiU5E72NI3YPTXVm7kVn+EnH2w5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j4MJLCkNIRB+LhX8hrvIbGHkXyqhmkfECLiOBZYS5qQAV0ffUshWAcS0KNNGeiPwL9QdRsptwkIbKkKN4dc/JRXe729D2e3UNaXV/b4T2vVOVio/r4Ki+0Qi674e7mY7gqCldDde9T7cllsrnoDTHnVenvZM9TSnEsGQYDk1zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ7iiB32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC331C43390;
	Fri,  8 Mar 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709898030;
	bh=jqEUhr6X+7mZr8wkiU5E72NI3YPTXVm7kVn+EnH2w5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PJ7iiB32cnMg7bI7cliCDiF28zyBmnJrogP4tsPVofBTkYIYrez8ew8xtfKVFBpPX
	 4eI2/nRiChYkOnMjjfmYwPVNtQd7gBCoYyYCLavd+NPoXCtrHwuGAMq33U/nkymbKD
	 JkBWqZ63M4/73IAsBt+oOPSLj+b9jDys2GReWxMosUMsAffBhBj2woZmMwjmTrQ3pU
	 a3NlFnGjkj98A/sbvslFPy2vNELufozQIhtaqQeEoAQkAM6b7O05+unNmZxYkK9E5U
	 KUzFNOiyfj25XfWNstadRbO+ZEdedApzlvOYtJKrCDq9N6vUPYU6Y+h0NNtnodEsQL
	 NVOCg/o0dbpig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91744D84BBF;
	Fri,  8 Mar 2024 11:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Add Jeff Kirsher to .get_maintainer.ignore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989803059.22806.2831505421819574635.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 11:40:30 +0000
References: <20240306154703.1392919-1-kuba@kernel.org>
In-Reply-To: <20240306154703.1392919-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Mar 2024 07:47:03 -0800 you wrote:
> Jeff was retired as the Intel driver maintainer in
> commit 6667df916fce ("MAINTAINERS: Update MAINTAINERS for
> Intel ethernet drivers"), and his address bounces.
> But he has signed-off a lot of patches over the years
> so get_maintainer insists on CCing him.
> 
> We haven't heard from him since he left Intel, so remapping
> the address via mailmap is also pointless. Add to ignored
> addresses.
> 
> [...]

Here is the summary with links:
  - [net-next] Add Jeff Kirsher to .get_maintainer.ignore
    https://git.kernel.org/netdev/net-next/c/7221fbe84f2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



