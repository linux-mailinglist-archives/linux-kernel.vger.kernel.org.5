Return-Path: <linux-kernel+bounces-40727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C0B83E4D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FB01C2324B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336745955;
	Fri, 26 Jan 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYHsRXGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414C24B22;
	Fri, 26 Jan 2024 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307025; cv=none; b=bEvJa5DM7kodxuOMcuMMfthMgtxEdvaXdBbHEtHa0C4W/U58ngBfFgGhtyi5piQmfvCqtFR32hwF0y1Z72pnxtPiBD/sy+X7K9oc5EiCc/6nMwxE4S0/DmHASuTwO5AFN8HBFJVFlHW4uydcbJxA6pAo+gz4DoRMKkMcAQWYpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307025; c=relaxed/simple;
	bh=vXuMp87s4mUMjGR7JS9qQioqQWRujjmW8WiM3f1UTIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/V0JWZD8fE4uxuUFC7ybswBTmFB3Jr43OhcAXC8CJZwJP7mtR8l7cRYTOOMLwRuqu5KA7VG4WOWZ2vYbJXw1aljPjbqt5MPpPI/7nZ3Zcb/6g5hlYggROXMyrWLz7AkuVnQNyI61uIVF6VMDcCejslcXzsfoQzdnFwjln08cFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYHsRXGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2C3AC433C7;
	Fri, 26 Jan 2024 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706307024;
	bh=vXuMp87s4mUMjGR7JS9qQioqQWRujjmW8WiM3f1UTIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iYHsRXGgQh5ZvI2+TILjldF1LIikWHILRt85ozEl1c8al1F5Ce71oFrW+PkB19UbC
	 aqIcARXm/rO0Gk/X6pg4Qwm1o5oOpfqGXnKzst64tutNkopuRzOIVFLY9U4NMEk8BE
	 OdUGxj7WbqW3UTbbhtqta3g7pG3EkfYGtdQ/9Qs41+I9JSah4XZXIZsfe9p9VyIW7f
	 fPesQBp7wfYPNT46JinHao15BggDbdkUy/wCxRaW4BmpQjOKq3AtT6m35s1NXq/wx0
	 M3Yv/eMiE8qqfhKSYsN4k0UtgoArEFQ5NbGy4QzRWuXme+DC3MwuzVtn43lXwkjf41
	 UxGbATp1d23yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9DE1D8C966;
	Fri, 26 Jan 2024 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix incorrect SMC-D link group matching logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170630702469.26145.8407281649456707093.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 22:10:24 +0000
References: <20240125123916.77928-1-guwen@linux.alibaba.com>
In-Reply-To: <20240125123916.77928-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, mjrosato@linux.ibm.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 20:39:16 +0800 you wrote:
> The logic to determine if SMC-D link group matches is incorrect. The
> correct logic should be that it only returns true when the GID is the
> same, and the SMC-D device is the same and the extended GID is the same
> (in the case of virtual ISM).
> 
> It can be fixed by adding brackets around the conditional (or ternary)
> operator expression. But for better readability and maintainability, it
> has been changed to an if-else statement.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix incorrect SMC-D link group matching logic
    https://git.kernel.org/netdev/net/c/c3dfcdb65ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



