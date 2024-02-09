Return-Path: <linux-kernel+bounces-58964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C784EF43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC47A28319F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246BE56E;
	Fri,  9 Feb 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQh1FNhJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034574C92;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448269; cv=none; b=RVVD4MTLxU0nGVmz43qa3q/4dJIVOLxZfBe+YVjnflVb9mjOGzVfxe7M6u5mfyFfxzdYify02GfwJLMiUF/+yHgriDRx9GTnE9IbpLQSatyJ0X9j2mEHKjvO2wGgxi7TCfSitdMA7VZ967RgnEEN+r+nMrOPlUTp3cR/nixHS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448269; c=relaxed/simple;
	bh=FUmi3UXZdl0m8BCeA4JszAk2qUkSpIO4EAqIdRWeN+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fpwSyOFMFiFF7HNIYIJEMuLYloPz/4zmEk+k6pKQ8eY+omAW6IVJs1Wc2eFOBZ4uHwwqg3WGvnKt8yBlMblkdhOCLsulGH1sYHf8T0a44G/DChK6GZwp9DI5/MupUM8X1nq4rap1cPaWLtnGJsjxWYlqQCJqi07IOj7NV/gHDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQh1FNhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83134C4166B;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=FUmi3UXZdl0m8BCeA4JszAk2qUkSpIO4EAqIdRWeN+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lQh1FNhJnbthcpvsB5Ez3ycypln3bV/qMo98iJOhLXiQxFM9SOXVMBA9D950FI1ES
	 SyRgUAgqErUXcMAABfFzimthwYWTcqwqI7qVPMCIfO6G3Umz6Ey8T7JickLLUh0prS
	 nqo2TbYhEDxXuWgvgrwW86tTv5ejXix9d7Y/zDV9KQGeTaqZU5v5gDE8lXSmU4yOJt
	 wbS7PbIq0/euR7meqcaK0jZ21z7rF3z69NYd3u9shyhjl3sUpRJ9wZ5VKa6bijIiVR
	 W/YDhJqb7AipUbsuNniZ03MI+wE1H0chWLhlD5o897uFdRImWaj5Oly26rN6qIaC/a
	 5MPyORgfedzgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 708B8D8C96E;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] netxen_nic: remove redundant assignment to variable
 capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826845.23533.8151257630099768804.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240206115049.1879389-1-colin.i.king@gmail.com>
In-Reply-To: <20240206115049.1879389-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: manishc@marvell.com, rahulv@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 11:50:49 +0000 you wrote:
> The variable capability is being assigned a value that is never
> read and is being re-assigned later. The assignment is redundant and
> can be removed. Also remove empty line before assignment to capability.
> 
> Cleans up clang scan build warning:
> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1189:2: warning:
> Value stored to 'capability' is never read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - [next] netxen_nic: remove redundant assignment to variable capability
    https://git.kernel.org/netdev/net-next/c/a6c15d7ff29c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



