Return-Path: <linux-kernel+bounces-67956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5E857391
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2119F286430
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE46DDC7;
	Fri, 16 Feb 2024 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCNjiWM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F6149DE5;
	Fri, 16 Feb 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708048254; cv=none; b=bsEJsLVS88rcqBFJd0cHRFgukZcvlwkW/MzRudVfdIALAPMIpgGx1VnLIlcdINEEKLBA9vK6cWkC3z2+YYypk4rFCULMNvRJbXrEQN1N7yF3etoU9D8zFlz74JFoc+X2GgBnVo6GmoDEPh2sfpQQ6V52EOYaKu9Xh80/aAFcsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708048254; c=relaxed/simple;
	bh=o1hvIgV7egchyLLtwD9Rie1hNU90A1OCQxnNdV0kcM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e04hMEOoujIq8pSNJTV9UR4YuyvcMiAcaEcsfZACWFeqjt4bq2ilylutGp2H+d7a4q1rWv//Tb7piJUBZPKHonRnuFXLmGZ2mCbLfLCDuwFK1J2s97YWZDpbwqEfA8Qd0kiPgUgt8NCpxdC4l8w+4QSdiiYSz0TOrmEablfmqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCNjiWM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17094C43390;
	Fri, 16 Feb 2024 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708048254;
	bh=o1hvIgV7egchyLLtwD9Rie1hNU90A1OCQxnNdV0kcM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BCNjiWM4zUN9wSG3QxHZ365AzzRhaus+zeQa6IYcS4UIXJOvcPq3tK63pwF6SIAQn
	 7aJUvQ+S2akFr2unJMRW71IH7UoG9GUqifRZXugyOdc1qSt5xCkLCQksUU+/e/hRb/
	 t6A2W6shiF3lslrJWF/tAfro9MLxKJTrQ3vZAbcT5TVkAu2sgJk33TlUJzfEeExDvz
	 7WVbSe8hazByLsmX3mLq2Y7QeysHgZZLRSjqtz6VBlIC3SE+Ag1arRUKIq36pIHhOT
	 bDrlXAwCmlaxoutQvOuDmMdY6Cn44PhVDKjlMn+YxakqMg7tMSCHEPXtLZ2espm2rV
	 yvce+U6vxrVTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F21CFD8C978;
	Fri, 16 Feb 2024 01:50:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] configs/debug: add NET debug config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170804825398.15074.5229912930240995775.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 01:50:53 +0000
References: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
In-Reply-To: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, quic_qiancai@quicinc.com,
 keescook@chromium.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 akpm@linux-foundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 11:47:14 +0100 you wrote:
> The debug.config file is really great to easily enable a bunch of
> general debugging features on a CI-like setup. But it would be great to
> also include core networking debugging config.
> 
> A few CI's validating features from the Net tree also enable a few other
> debugging options on top of debug.config. A small selection is quite
> generic for the whole net tree. They validate some assumptions in
> different parts of the core net tree. As suggested by Jakub Kicinski in
> [1], having them added to this debug.config file would help other CIs
> using network features to find bugs in this area.
> 
> [...]

Here is the summary with links:
  - configs/debug: add NET debug config
    https://git.kernel.org/netdev/net-next/c/3738d710af51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



