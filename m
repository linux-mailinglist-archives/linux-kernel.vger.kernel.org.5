Return-Path: <linux-kernel+bounces-14352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69C821BC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A705D282DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6602F9E0;
	Tue,  2 Jan 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrB+yTFM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF20F4EE;
	Tue,  2 Jan 2024 12:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB12C433CA;
	Tue,  2 Jan 2024 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704199225;
	bh=QG9Kpo8W5whXZbfe9bFcCh6MgRU8/208K4BwLb5snWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OrB+yTFM6PY6VLqCpFcsbleigPZLGev+1ZsYnCXZ5VbO2nBnxv+9CGA33+Ph24q6O
	 cilSwTqcYZk1uM9y/rt8xz9QlbC498gJSCsxUuX2atajGRBtUtpkq/y3Iv1NVV0Gs/
	 /E+8bY9QJiu6TzFeAmxIQhZVFdeHMiTkj1768wi8uYq9RU8wtIqJp8+pF67sqOFgRX
	 PAXSH9qLlkTuhWP1TLEMH8OuElE5VMSQOIjrEvfHGCIpi12P/KLZYrQE/AE1IMbC3N
	 Mx21oAwy2BrqVvrjEHwhxXnA2neGf6ZKx1oFc9/YLV+nTZ1WiWCdShZfVhDFMl598I
	 6kXmA7vPu12ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A202DDCB6CE;
	Tue,  2 Jan 2024 12:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] ptp: ocp: Use DEFINE_RES_*() in place
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170419922565.22517.5327255644560804577.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 12:40:25 +0000
References: <20231221140607.2760115-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231221140607.2760115-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jonathan.lemon@gmail.com, vadfed@fb.com,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 16:06:07 +0200 you wrote:
> There is no need to have an intermediate functions as DEFINE_RES_*()
> macros are represented by compound literals. Just use them in place.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ptp/ptp_ocp.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] ptp: ocp: Use DEFINE_RES_*() in place
    https://git.kernel.org/netdev/net-next/c/07938d774f18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



