Return-Path: <linux-kernel+bounces-143507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919EE8A3A50
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F25B2189F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734413ADA;
	Sat, 13 Apr 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CStO0Vbn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898ADDA3;
	Sat, 13 Apr 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973630; cv=none; b=dTRo4sjRbiPpNRB+atWGKsyt1sUZ1Ukp9vB09lB5lEo9oRHZFxwKgNEtnKTysWG2LfJZDGufI+IL9YkpOmQx7ihN5m7B+qOwNpDeh3XzbvjyzF7459hNc/QIe3u/INyjfK2tBgY5FKSSbtEXt7O2GlKDlD9i2X9mri+g22YPnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973630; c=relaxed/simple;
	bh=ms+bUVd/IKUymPV47kf9GehhxekDnUfPq318Bj94ZjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BT9DmhQfKoppiEHD0EAgBT52Zuw+bMB2XvL1K5m2zJrT7/sjstzW5MzZSEm1yu17oeb4s1SXgZwpCmL7aU4q9m1zmiHlM2qQ8xB61wyrNJqVGj0IIGe+uNSc300pOyUAxNe/kwt3oy0AeB7nM7aA7An+/gHmr8Q9Y8Ap6IP1DTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CStO0Vbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DADFC2BBFC;
	Sat, 13 Apr 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712973630;
	bh=ms+bUVd/IKUymPV47kf9GehhxekDnUfPq318Bj94ZjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CStO0VbnDmSdlYEC6Ko/ZjlSzPnocz8vtEVow4Kzu8S8pyPb8Bso2ItXHDkXUtHG2
	 Mz2toMIr4Z2LezXXIQGAm5aKhRl9YoGtw29Wr71cmie+0g55XPvC1tG1dVaoB4r7Hu
	 0t65J/SuYoh3WzT5y9XCbyAG58keNlRMlmmabWtW9x2gGLM9+ZmbAmDoJ+s2XLABPV
	 Ozj/N2olHsoBSn61/ZawTa8SvyXKW1B4ByE6PnJ5bXZ0022alddiGp9lM4tphImzSo
	 +DUfeYgn9dB4FDrsNkmG6n9PyWmm5ez73kMpxBOKs1FVVY9j/yyx0zZYzX6xnl6ApJ
	 ZGaW17VPw80PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDE47DF7859;
	Sat, 13 Apr 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: nfc: remove inappropriate attrs check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297362997.26889.4301912686279451050.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:00:29 +0000
References: <20240410034846.167421-1-linma@zju.edu.cn>
In-Reply-To: <20240410034846.167421-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: krzysztof.kozlowski@linaro.org, andreyknvl@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 11:48:46 +0800 you wrote:
> Revert "NFC: fix attrs checks in netlink interface"
> This reverts commit 18917d51472fe3b126a3a8f756c6b18085eb8130.
> 
> Our checks found weird attrs present check in function
> nfc_genl_dep_link_down() and nfc_genl_llc_get_params(), which are
> introduced by commit 18917d51472f ("NFC: fix attrs checks in netlink
> interface").
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: nfc: remove inappropriate attrs check
    https://git.kernel.org/netdev/net-next/c/a799de0e5985

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



