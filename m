Return-Path: <linux-kernel+bounces-97760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D527A876F0D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685441F21B38
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA6364AE;
	Sat,  9 Mar 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhP04Pos"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21093339A0;
	Sat,  9 Mar 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956834; cv=none; b=N0huyY2ykLVCelvxG7uC6MZdUSOdr/baDhVEFn55BSBAz5e4MDqrnFW/5Zf1AoQWCvkK3NaKxy+tVInQqixaptdXFwVKig+73PkfZSd+XsgZgNR4ZT36OCD7d+kRWZgO9UOcvzzSs5VJuQqdX1HfMQuLYJM3yMXSZlqAU0NpiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956834; c=relaxed/simple;
	bh=f9h0aUwkHSkFxdwat1UPrzjytUlZpdJPyyvzfDn+llc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXXQg0XRwzJJoa9rZrtIc9CsQi63EkVmluekWtn3fmiNKJFLhZV/OqGwETf8/SPNpqTT8pd9f/pQRa6OwX7WSbVtJdYH0V2foAcT2GWXhngo+TPB9ggzIjQjUBtexAvczSSAZsxK2W3GCaUwGXNwy12oA2e5Ecuvf5CFt8cRdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhP04Pos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F5EBC433F1;
	Sat,  9 Mar 2024 04:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709956833;
	bh=f9h0aUwkHSkFxdwat1UPrzjytUlZpdJPyyvzfDn+llc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UhP04PosjVap8pwrzPtsplXKlUBWkY7MbcDIKGWvblYC4gORNtwHn08tt7XjpALk3
	 vHXwfsWoPIy4vmTzAdMO9uQlyipchzN18x8b3TL8QimU22/sBOkWG33c4chalkJzN4
	 l6/44yvW1zzIzJrNmUZB6MzmW7UNzdLgpssmqE1xSWoNI2WYjpX1kyijkCf+5IBZ7Q
	 j9gzey5KKJm10gsP50uwvV1hapkb4di+JVHOuMuyBGGvwQ9qo+EOtqj/Tltwj1xJ3s
	 eBHSXSO/6JAWP46vZo3gJbFIpOGg53k3mS9ymTvJP/8S8iVoai3WgcezoMcS+Ooatx
	 vaLBhjKSphxVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69E56D84BD9;
	Sat,  9 Mar 2024 04:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] tools: ynl: Fix spelling mistake "Constructred" ->
 "Constructed"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170995683342.6217.6572863239425146555.git-patchwork-notify@kernel.org>
Date: Sat, 09 Mar 2024 04:00:33 +0000
References: <20240308084458.2045266-1-colin.i.king@gmail.com>
In-Reply-To: <20240308084458.2045266-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 08:44:58 +0000 you wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/net/ynl/lib/ynl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] tools: ynl: Fix spelling mistake "Constructred" -> "Constructed"
    https://git.kernel.org/netdev/net-next/c/6de3b6c75dd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



