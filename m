Return-Path: <linux-kernel+bounces-40726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239583E4D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965D51F22B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964741C9C;
	Fri, 26 Jan 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSN+n9b0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418024B5B;
	Fri, 26 Jan 2024 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307025; cv=none; b=k3oGS5xlZsIzFlFADYnRGQhs0+f5UxqBV1kC7Lf0hhFeNUUne5ngg7vPZaRcpUNr0jaChPLSyqdT+6/Tg02vk5h+tppP0FgY01ucPQUDo2jdtb9lv3c4G3T6o8p6YvryoKc14mNsmGTQL+L4TF8rBMBICAYK7nnYefwPnIbuif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307025; c=relaxed/simple;
	bh=h/MG9bZdwLygxBA4lGNTQ0tNFpOL8t+QZyvAqIfIFxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mXxKb/Gr1fjuAxGE1XdmBT03zdnjFrtf8crhC+uonG2lcJJ3nZYywqFR2UKTP8nwKvWRdS5+folqiTLqaiJkngxMzy5cslkJLmH7ng/PvQ1kIWJAU1kY44DBvxF8V4+FjBUDJ95WP2lltjsaL5YnDhc2l5H+uUgP7vMW+keDFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSN+n9b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6A2DC43390;
	Fri, 26 Jan 2024 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706307024;
	bh=h/MG9bZdwLygxBA4lGNTQ0tNFpOL8t+QZyvAqIfIFxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tSN+n9b0qETYtETHkDOx9o49KGbeZFVwsYZrld2L1GPGfnU7SSb6XqbEjEHEIfbvn
	 Qito+VjeTEMrQ+AQ7ASBBoOPjKVviG8NCbt66fqMBiOpg2w8Ek+9b5zyCSDWngL2I0
	 lKQIhR2t3k+0sbVYZ7WjwkZ717JCiuWkwB7V6cR3t02cxPSeLDYOd26njQTcxVBz9g
	 lPFFXtSVtam/W5T9dXF5IP1CUfmWZQjmn7fkbjfPPyMAPcQSC89h+N4ThXaAY4dl4Y
	 yqpsDXBtFJODhZuFHQ0OT5vDR0jAJxna0TeetCMYy5/dCFLGqnsLz55A8umvMvady0
	 ysNxe9rtZs1Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EF15DFF760;
	Fri, 26 Jan 2024 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Make PTP timestamp HWRM more silent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170630702464.26145.16441639508108329995.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 22:10:24 +0000
References: <20240125134104.2045573-1-leitao@debian.org>
In-Reply-To: <20240125134104.2045573-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: pavan.chebbi@broadcom.com, michael.chan@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, gospo@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 05:41:03 -0800 you wrote:
> commit 056bce63c469 ("bnxt_en: Make PTP TX timestamp HWRM query silent")
> changed a netdev_err() to netdev_WARN_ONCE().
> 
> netdev_WARN_ONCE() is it generates a kernel WARNING, which is bad, for
> the following reasons:
> 
>  * You do not a kernel warning if the firmware queries are late
>  * In busy networks, timestamp query failures fairly regularly
>  * A WARNING message doesn't bring much value, since the code path
> is clear.
> (This was discussed in-depth in [1])
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Make PTP timestamp HWRM more silent
    https://git.kernel.org/netdev/net/c/281cb9d65a95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



