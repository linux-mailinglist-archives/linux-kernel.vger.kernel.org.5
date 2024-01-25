Return-Path: <linux-kernel+bounces-39265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F5E83CDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6528F1F276FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA813A246;
	Thu, 25 Jan 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKJMFM7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29E137C2E;
	Thu, 25 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215826; cv=none; b=l2j2v9DLpZDwXelRSLRoxIze5wv6qT3jLY/3vjN19Zqw66PzZ2hdD7v7ibAMxzn1LCR7LFP5gwzi1zKst2taUG3nfrRRlCuwwgv4OYQ2TdT43A09JKzk+eK0X+NDga/FcjZDsV/w/lDgMhUkbZXh0Vi67DLjw7/FcztHwh+BJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215826; c=relaxed/simple;
	bh=Rqy/AFJCDQT9Ckknyj2IIpBFakoM1s8u2yNmCjQun+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lhgRZ3eQtqcS4ipGQUzo4S/XU2BTxKA43KPu1fkWluPfM7Lq3cCXjiZXFvNqhnQl/AxwHFmE7BxS99l9rVZ7SS3Bg4KJsdbcmF7scwZNNnBZebWZPMkGBZD91Dx/ymaDte+vOGtWTGkF6M5KzfPQOj1yDMR+zHGIEZj8h9oNoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKJMFM7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF31CC433F1;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706215825;
	bh=Rqy/AFJCDQT9Ckknyj2IIpBFakoM1s8u2yNmCjQun+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OKJMFM7Cdu5lxYWJMcTdjxYN6GiCJE8onPN5MTeFaLqDr879UJt7uXJcrtQN2dBUo
	 GTgTnijwP6RJvu0sF2A2PLq/0+4zNHNJ/kBnOdtzBTTZ+h5FId2JD7ke1C7DI/F0c1
	 OU9ktc0eAd6/+KCSxcrj/kaekb7lQGBLxI+P1Ue95ploL25GWQwhWgRFbpWDsk5DJf
	 1KkhlUcBTOwe+t0awgKP5FIkaNL9CVEc+5+fBrlxO5TmUPp9X22saoquNlPL1RnGP0
	 nAXULSk5D3No0CU5XadG20DBgZeAsQKmYub4e48e9SC1QgbpreJ96bR4344wHz20UF
	 5+1/nOf6uGKLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C050CD8C966;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Enforce validation on max value of connection
 interval
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170621582578.16174.210804050492510894.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 20:50:25 +0000
References: <20240125065028.228877-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240125065028.228877-1-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jan 2024 14:50:28 +0800 you wrote:
> Right now Linux BT stack cannot pass test case "GAP/CONN/CPUP/BV-05-C
> 'Connection Parameter Update Procedure Invalid Parameters Central
> Responder'" in Bluetooth Test Suite revision GAP.TS.p44. [0]
> 
> That was revoled by commit c49a8682fc5d ("Bluetooth: validate BLE
> connection interval updates"), but later got reverted due to devices
> like keyboards and mice may require low connection interval.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Enforce validation on max value of connection interval
    https://git.kernel.org/bluetooth/bluetooth-next/c/9434e62334d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



