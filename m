Return-Path: <linux-kernel+bounces-36275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08404839E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D941F21CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C71469F;
	Wed, 24 Jan 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCidxcvB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A791872;
	Wed, 24 Jan 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059831; cv=none; b=ZV4a0pYGRjlFn697d+qC5tBlHY4079K4Z4iSBCZal0TQv+cdJMrG8iT9r6ARxRlDrnvWzSURvf2O2ZrPurN7bczCALrqDxR6cMAPWXVQFiE2o9mUOpqfVNPysAXjPMUSEoJWaUwxVlPcIkONf/zNt3VbpVrK8SHHGrLBz2nQoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059831; c=relaxed/simple;
	bh=3mHtlfZjEwIzA755NkkaOfCnUWWE2Q/12sL2IWiuegU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PT9Pxxp5dL2rR9q77OQzUr/qm7R6XyiuuSwg4IuK7u5+YrjtFkUtj7w9zdRWgvBzG+F5nxmtfRknQnihAoYHyLaRV4Fe/wqSQS1Qkq0TUMOyao/ho3Jq0uAmb3jlLMCWsEy59rcjpAFBRPW2PMHxV1xm5ksWISmde9JvY3k2Jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCidxcvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EBF6C433B1;
	Wed, 24 Jan 2024 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706059831;
	bh=3mHtlfZjEwIzA755NkkaOfCnUWWE2Q/12sL2IWiuegU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HCidxcvBJS34/+aTwEBpJ68cVE92EZIEnAVqYvgvt5DM/Jwk70ud9We5acLAEzcOm
	 9+bV7JMCB/VY7HzCNwqvLki/6ac79ZuThI9t5URQ8CG0sg7NPeUaHXlKiGeCHbKd//
	 hOAosLri9oq5ogHVAq1YyLptAGoZXJ39Dg3JWxMZ/ry+hXNcp6IWVGZBbn8ZM6s34a
	 EN5/+DDV4O9d4QOjaVhq2hBRVfZJHljS0Y8dNZwOOkk5aOlB+vMgZuu7olyaZWN/0n
	 XQo1WseGH+h6nu62KAnTUVaOIxfo4lNIet936NWsvwIzHoZ4eDJuQgEahf4fEsvMoH
	 rne4RxBC+Kw9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DC63DFF760;
	Wed, 24 Jan 2024 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605983124.14933.9916722082205803213.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 01:30:31 +0000
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
In-Reply-To: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: timur@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, marijn.suijten@somainline.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 13:02:22 +0100 you wrote:
> This SoC family was destined for server use, featuring Qualcomm's very
> interesting Kryo cores (before "Kryo" became a marketing term for Arm
> cores with small modifications). It did however not leave the labs of
> Qualcomm and presumably some partners, nor was it ever productized.
> 
> Remove the related drivers, as they seem to be long obsolete.
> 
> [...]

Here is the summary with links:
  - net: ethernet: qualcomm: Remove QDF24xx support
    https://git.kernel.org/netdev/net-next/c/a2a7f98aeeec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



