Return-Path: <linux-kernel+bounces-39266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF083CDCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF2C1F27718
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9B13A248;
	Thu, 25 Jan 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb38I28h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B166137C57;
	Thu, 25 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215826; cv=none; b=AAaXR/1CiBZsiJxLyvOx/10BjUjrso0GQ9Ly7KkkaG3VhuhsWLswqxYXd4aQY9eUDyGQxuZ/wfqF3zRMwLJXZQxAboGWGpu4l9I5z/KsN4s5XrNGn9V1ecsOsXgnOfKKpolfZ0VSeSKuHgXuxeTzjF1Bj8Px81+CZYUPeufm/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215826; c=relaxed/simple;
	bh=EGPXup5wTorebySd/H/IW/H3xweM3JbfKLa6avHjXcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qQl6YQegST4LrtcyYUVUELSA1CLy9NWSVC4++ZEwlbk+pZuGbBU5EexvzbBi5ryitpEoxrloK1+4tS6tef/Saw4jqP7WOSMhef8kB7gEsYsfFy9L6HEJbjXlIF6vdNv/BcwsPqhzeFXAnBojJAbs+9jg7cePjrpofLUbMH8q4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb38I28h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDC50C43399;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706215826;
	bh=EGPXup5wTorebySd/H/IW/H3xweM3JbfKLa6avHjXcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cb38I28h0HCYCNUweYziq92qdAMHcyOfqhihhJriPh8VL5hb8V1V9dknPXoyMJqja
	 5tIHQwO5wfOtgpPUFev9imujJggTartxvRZeY6gTHyAa9MvgaL2eH1feo7ARzYaZgK
	 7TbtSJghlVLD9bQ6CHt+7SEfebpokjiYPZARMB097u0frmatrkLfdGF/cqqysAqNfA
	 5op2xfPZeKv/87KHeb7Y22smrhFctorepOZnNngmcr757st/bf85sXMoybiAF/3vfx
	 iaJJ/0VCCOAo2vadBLk9oqIn5+F5naJnXw3WZ1tIuywQ6GnlD9LLR1aAzbOLAGuZbZ
	 mM+OUq04WKoNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D127CDC9A05;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next] bluetooth/btintel: fix null ptr deref in
 btintel_read_version
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170621582585.16174.6159364307548424799.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 20:50:25 +0000
References: <tencent_E60894D8E85AEEF2CD9C787A6CA82F656C0A@qq.com>
In-Reply-To: <tencent_E60894D8E85AEEF2CD9C787A6CA82F656C0A@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Jan 2024 12:40:34 +0800 you wrote:
> If hci_cmd_sync_complete() is triggered and skb is NULL, then hdev->req_skb is NULL,
> which will cause this issue.
> 
> Reported-and-tested-by: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/bluetooth/btintel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] bluetooth/btintel: fix null ptr deref in btintel_read_version
    https://git.kernel.org/bluetooth/bluetooth-next/c/693a94db9e8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



