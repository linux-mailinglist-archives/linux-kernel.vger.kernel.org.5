Return-Path: <linux-kernel+bounces-135235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5C89BD88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DC21F21F60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E664CFC;
	Mon,  8 Apr 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrKrKHma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BA5FB8F;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573427; cv=none; b=f0JUfPJ6jJb6oU1u8x17knLjuJX7NU2IyjV74QR+CIuwRIzeJAmlYGmiEenknFiCGgJm37/U+PhIs0D92KXCbGg4gW8PFGfIhYpbXcL1FyeLnn2ikMVPGNDsNBFk2SuKobg3K+9U+hGIjsZRhP7Lx3bK/+bbm4/7Og/JnslDuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573427; c=relaxed/simple;
	bh=Sf0cs3FPuJWtRCzz778/gedZgJhrTLproeI5Tr6xypI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RubKjwhTd0+REB873i7yluxvCsWAwww7eGH1M7mPJ1sYVwpdl+9kGKtU2NocRvdFY+DEARb70sNXq9EWLghqxnsRmvKY5e1/oJydHkkxUP2F1Ahb4zkPHWYxKnnfWuWWFv85bA6kHimZZ1g+0YUt7VHJnTIbNsZCBQxEvXYqQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrKrKHma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B368C43601;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712573427;
	bh=Sf0cs3FPuJWtRCzz778/gedZgJhrTLproeI5Tr6xypI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SrKrKHmaZ5HNdfoRAJO9Uw12pa/os7BY350fpt//frWQyD8vdccMlp3dvEuVLroCv
	 +uMS86AzNsQ4ORJJ4fzq/ml9z2BP5p7P1b11d6STYHHNXmpCRnlYzyTF7OieVQC1S5
	 q1sWqVmlkTTAEBlyi0lZIn/lTevzpQdD0f5VxbIC0hr8JLS4M80YnmehjpbtaGIoD0
	 E4Gera+Ol0t5Qhfmsl2/okVSBel5hdflvKpo0gKqqDuEkexAB3jTLYaV/OJQUayyHi
	 D2Wq/Znd5uXQI/5X59O7hIEM3W2PLh0SrmnlPvN2VgtuGWuTUr3DS0EiWxFq4coiF0
	 h+Oti224myfNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A5D9C54BD7;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: usb: ax88179_178a: non necessary second
 random mac address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257342742.21044.16835809046426475701.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:50:27 +0000
References: <20240405082431.8329-1-jtornosm@redhat.com>
In-Reply-To: <20240405082431.8329-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 10:24:31 +0200 you wrote:
> If the mac address can not be read from the device registers or the
> devicetree, a random address is generated, but this was already done from
> usbnet_probe, so it is not necessary to call eth_hw_addr_random from here
> again to generate another random address.
> 
> Indeed, when reset was also executed from bind, generate another random mac
> address invalidated the check from usbnet_probe to configure if the assigned
> mac address for the interface was random or not, because it is comparing
> with the initial generated random address. Now, with only a reset from open
> operation, it is just a harmless simplification.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: usb: ax88179_178a: non necessary second random mac address
    https://git.kernel.org/netdev/net-next/c/7c7be68346b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



