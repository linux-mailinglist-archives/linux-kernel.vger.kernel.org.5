Return-Path: <linux-kernel+bounces-58961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C384EF41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803E71C263D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13EDDF55;
	Fri,  9 Feb 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWBReY4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C24A39;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448268; cv=none; b=laRtEjsoxaOrhYC5UY7y41D7aE6/Q0gpYoaU6x3vdedEoHN7n0DzHGeitlQFzre+zNVCn1ACk/Agb6UJqfKIQ+rL3K5kkrMQhj9YDqZd+6l4thSB9RO7zDyHmdNi53E9ArwtG+og6cuNm8n+D8OPMbgfg6l8/2Xsw3pBrzYojm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448268; c=relaxed/simple;
	bh=FEMqaacTifvkDTFtuSZUUgOdKMQSWteN9s+tEL6XsAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=apRgIDYa2xwix2yeHxZHYuFlswtJW0KRxIFX0ksJBBuaNl/FSHxrrNuIBX1Q5Yk9EEuOmh8gcbzT6UacdLX7RT7+g+LQAVk1dZObbiPvvzOPdmXIXWgV7WnFNz5PvuixbKyOjthD3Jcnn3fLCDUVlhDf5LeThBphsQQW1vBxM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWBReY4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 508A7C43399;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=FEMqaacTifvkDTFtuSZUUgOdKMQSWteN9s+tEL6XsAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gWBReY4ek5rOgXgjJwYEzt69Q6LyqASV1NPpzz4cqmQHsXQkN9Gt9upafCKOuTphJ
	 f18pCRH1WR22OH+fzRukqa4Xf/ygIOk63WHjbWkGUu+VmHMtD5g5mf9c0d58BqqnF5
	 U0COOkSGxEdB4lyz65gkEee1YJttkptiulqh2i/Yzlp8u7xZELXM81DDi7CxfJaM7M
	 gdBjRWTLyL0M9u0EBuSk0IXUnl4b5Zbvh6TQw6eSmS6IRIEsKzCQ5VkNYJ4E301s/N
	 jNSvttXSe5fzANmxebRZv5G7EPEpAVgvJBvj+MwhSzqi5SvZkWqWrJKcjBQhRl2vZ+
	 h+68iJtEdlUdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3231AC395FD;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qed: remove duplicated assignment to variable opaque_fid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826820.23533.14107446456675150623.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240205215530.1851115-1-colin.i.king@gmail.com>
In-Reply-To: <20240205215530.1851115-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 21:55:30 +0000 you wrote:
> Variable opaque_fid is being assigned twice with the same value
> in two identical statements. Remove the redundant first assignment.
> 
> Cleans up clang scan build warnin:
> drivers/net/ethernet/qlogic/qed/qed_rdma.c:1796:2: warning: Value
> stored to 'opaque_fid' is never read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - qed: remove duplicated assignment to variable opaque_fid
    https://git.kernel.org/netdev/net-next/c/5c80e62a2ac5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



