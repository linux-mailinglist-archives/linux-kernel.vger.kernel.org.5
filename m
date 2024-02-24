Return-Path: <linux-kernel+bounces-79366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B986213A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0EF1C24BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35977184E;
	Sat, 24 Feb 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9CHdJI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75183EDF;
	Sat, 24 Feb 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734629; cv=none; b=b3w/Yn+qg0JfvVSf/FeQb/IWw7HqQFmu+vt8QJARwxl5M0LNmzSm5uHW1eWCy+sO20Txl0LdES21p9m2jkC9N6sY9PXHdrr4RCv38DPIF9+37/wmlJv0SKFToGyTxFHDLFzBh/Jm758HSIeJ2ZzO8rRqPCydDdar3jLqo6MHYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734629; c=relaxed/simple;
	bh=TfJJBxx8dRFDiMo/aNOa4/iMVLDgFJXJSqDBq66jT7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DXyBKV9adi9rf7YJIG+rgNKvHxG1zD8VZ9NHURJYysjFjQSYqKcLKNHuTsowxVYHuTItz2YWtYFSTx+uUZ6e9PC/mms7czwu3JT9mwUDaH6OqsI1u2e8vbyTLa8mV7Db0YzLMHubPYwHf/6FdrsNnnNPKLKf6+I2GTfs20mhkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9CHdJI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C4A8C43390;
	Sat, 24 Feb 2024 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708734629;
	bh=TfJJBxx8dRFDiMo/aNOa4/iMVLDgFJXJSqDBq66jT7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q9CHdJI6YV3dzaUpRxjVjjvNplbnnSv0AzSv12xDI6foGV+bp0O4fL/K8+ApoHqBs
	 t8Y0To0zXOFGRk/Xf7mDKu2x2dYX40MQZPwMWgnZYzTGimrzA52SKKhvhQSfeDGGYh
	 fQEyTfAoAUdH+2jPAPxHvDwTCriAMVGMy8qaD7TTcFn8E96GSJ/hh9SVHbXXUWw8nq
	 TIn+2KX6Gaz6t504iwrmhFU1+1U0IhalQTBp4TYv+fv+zo2fDA/GtSPE3XANU49Ky/
	 o6Ev9B069TUf3KPCpiW3qZj8OyuVPcaRzPEQ28qm9uglbUmVHbIdTtzk7mpgr3lNVa
	 2yEZ1VrBQ+UFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 121CAC59A4C;
	Sat, 24 Feb 2024 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: Fix xdp_rxq_info's queue_index when detaching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170873462906.19502.10313263822790280656.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 00:30:29 +0000
References: <1708398727-46308-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1708398727-46308-1-git-send-email-wangyunjian@huawei.com>
To: wangyunjian <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 brouer@redhat.com, xudingke@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 11:12:07 +0800 you wrote:
> When a queue(tfile) is detached, we only update tfile's queue_index,
> but do not update xdp_rxq_info's queue_index. This patch fixes it.
> 
> Fixes: 8bf5c4ee1889 ("tun: setup xdp_rxq_info")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/net/tun.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] tun: Fix xdp_rxq_info's queue_index when detaching
    https://git.kernel.org/netdev/net/c/2a770cdc4382

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



