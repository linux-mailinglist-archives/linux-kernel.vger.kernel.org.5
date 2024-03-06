Return-Path: <linux-kernel+bounces-93863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155618735FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEF9B25A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8880058;
	Wed,  6 Mar 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOnwqT5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BC80030;
	Wed,  6 Mar 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726428; cv=none; b=TpsDGH5jKP2HPJxXzVulF6DWFZpyEQpAJmlM0EHm3zZ2L6gsSpUXxmy6tUCZe+kfZLkK6E9iuoJYMvmjiu0kC89t9OW+5LJNTEYYhbOrggOKk4rxdIt32AvVDd2Hv+tT/98cmPgD1aLkrlv+RvO9WPB+ooB9q8UKqjqCWMO39Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726428; c=relaxed/simple;
	bh=UlT76hoWI/+CWtKU73Zz9E+7JQ1mESXPZqU9NcgzHsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oi1zIsrV2Cm7QdnbD4g8/Yw22IcGRq9vw6aB0w5HKKB5mDIXBbISX6PvlHdZqaFK893x3OtYs4Y3I/HQZtQ3vHZWzi+ShsHxomJ0ONmiNn81a/n+q8PE1NYne13vKaJ/PLUlqlIPYBG7stGgYxKfDyjeLwjx8XbQSv6GGd0vNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOnwqT5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E778C43394;
	Wed,  6 Mar 2024 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709726427;
	bh=UlT76hoWI/+CWtKU73Zz9E+7JQ1mESXPZqU9NcgzHsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jOnwqT5LUyu6p3D+KTyuZ0VuTCdLGSl3ybDRgaUsvhTRe+Rlt60mcow47p/Vf/7ZM
	 huT0AgX8oijp8GX9olmNOtQMGLeOpVPw8nrJngqJe2nRslAImElAn5OH90aOpqwkoA
	 Dh1Ps+Mpjl9ckhkJ63Rv70HjMfyPTGa+H0hQ0HEKegI2zMVXgZMEXY8X+7VW28mpAA
	 Lieomfl1Q3J+Nxb7Ean9BvJto7knV7IUF0b/nFbb4OBXTO+NtOCYYgAPPZOSx9SWzK
	 mIr4yJf2lDvpU92GN8FcVHiUw8d6ocU29mBzb4lD8RJvSD1lazPfV2Ew3EiA9hIlxv
	 639usfhIfDN7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46C64D84BDB;
	Wed,  6 Mar 2024 12:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] net/rds: fix WARNING in rds_conn_connect_if_down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170972642728.4677.2906308095353738542.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 12:00:27 +0000
References: <tencent_AFA7C146CBD2DFC65989A8EEDAAED20CB106@qq.com>
In-Reply-To: <tencent_AFA7C146CBD2DFC65989A8EEDAAED20CB106@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: horms@kernel.org, allison.henderson@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
 syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Mar 2024 08:13:08 +0800 you wrote:
> If connection isn't established yet, get_mr() will fail, trigger connection after
> get_mr().
> 
> Fixes: 584a8279a44a ("RDS: RDMA: return appropriate error on rdma map failures")
> Reported-and-tested-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> [...]

Here is the summary with links:
  - [V2] net/rds: fix WARNING in rds_conn_connect_if_down
    https://git.kernel.org/netdev/net/c/c055fc00c07b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



