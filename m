Return-Path: <linux-kernel+bounces-154987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D464C8AE3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAE51C226C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C4080020;
	Tue, 23 Apr 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exFm2Vrw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0607D3E6;
	Tue, 23 Apr 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871830; cv=none; b=sJYIoAvDkiDpRFUQ3et95IdQeiTjUrh4dCjTV5gK4eXfaXyocLIf/ja1VlQGrF+B/HlXIypE2/Lk7C+8L0/bXHqygret5A5wT3to2usiQWr9SdC5hUisi6LU3Wx8y67LVP/2n8F63bE5xruFhgX35kvrFF6XuU/EK4/PzdySGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871830; c=relaxed/simple;
	bh=Nq9WyZ1f/AyPelh/YiIXTtOGifGc5Zz8SfWRvAnWDdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zzh5ZpXjPRGYe2KkR5c/c8LpcMAxY6DfHREpfEymiZmo29OhNQGY2bkxz6bbwCluvpUixHCqWAt+r/ulZJMgrwScAWf6YLvi8gwEBGzbrp3cmCHW3j0vhiAY5iq+7ueSiDVfQXfod53fR8tTrmnda/ejfrmtKZDeymJHYwEw79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exFm2Vrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9395C2BD11;
	Tue, 23 Apr 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713871829;
	bh=Nq9WyZ1f/AyPelh/YiIXTtOGifGc5Zz8SfWRvAnWDdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=exFm2VrwQCGJUFP88430cybowGq0K29utUWcg7Pj1nxZuWIAy2v8YRsPHOj1hpwJQ
	 LX8TpLx6yuHDTDLdU5yCeMH+P0dpJ97RdLkNmpYFKX6QUtP4oIakOBbTq//lXLCidC
	 bBeu2F1MEdjWp1JJgSTuD1+YIPPLIzXZhXSaBeQjAuoO2//EdiRKHG+YiEq80KayHQ
	 frnmzwXlF4D4OoIBRsqqD4xW+vJVSdHFN6WUrRDuuY6JKL1XJwDgeEErSSeMitEEfE
	 UT8WlauNKo9kNANSPPkAFgR8x2DhEylnMlPwtatVuUt2njdIB+GT0sjsg6GtOM+8/8
	 8KXng6PRcHgug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C97DC00448;
	Tue, 23 Apr 2024 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: ipa: eight simple cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171387182963.10035.7202226202218402214.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 11:30:29 +0000
References: <20240419151800.2168903-1-elder@linaro.org>
In-Reply-To: <20240419151800.2168903-1-elder@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Apr 2024 10:17:52 -0500 you wrote:
> This series contains a mix of cleanups, some dating back to
> December, 2022.  Version 1 was based on an older version of
> net-next/main; this version has simply been rebased.
> 
> The first two make it so the IPA SUSPEND interrupt only gets enabled
> when necessary.  That make it possible in the third patch to call
> device_init_wakeup() during an earlier phase of initialization, and
> remove two functions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: ipa: maintain bitmap of suspend-enabled endpoints
    https://git.kernel.org/netdev/net-next/c/2eca73444036
  - [net-next,v2,2/8] net: ipa: only enable the SUSPEND IPA interrupt when needed
    https://git.kernel.org/netdev/net-next/c/6f3700266369
  - [net-next,v2,3/8] net: ipa: call device_init_wakeup() earlier
    https://git.kernel.org/netdev/net-next/c/19790951f031
  - [net-next,v2,4/8] net: ipa: remove unneeded FILT_ROUT_HASH_EN definitions
    https://git.kernel.org/netdev/net-next/c/5043d6b16211
  - [net-next,v2,5/8] net: ipa: make ipa_table_hash_support() a real function
    https://git.kernel.org/netdev/net-next/c/b81565b7fd02
  - [net-next,v2,6/8] net: ipa: fix two bogus argument names
    https://git.kernel.org/netdev/net-next/c/f2e4e9ea82f9
  - [net-next,v2,7/8] net: ipa: fix two minor ipa_cmd problems
    https://git.kernel.org/netdev/net-next/c/319b6d4ef087
  - [net-next,v2,8/8] net: ipa: kill ipa_version_supported()
    https://git.kernel.org/netdev/net-next/c/dfdd70e24e38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



