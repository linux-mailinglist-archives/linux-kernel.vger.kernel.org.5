Return-Path: <linux-kernel+bounces-17033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B73282475F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4EFB24C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34BD2C6AB;
	Thu,  4 Jan 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L99/IJF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66E2C691;
	Thu,  4 Jan 2024 17:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBED0C433C9;
	Thu,  4 Jan 2024 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704388826;
	bh=HRsviwHGvhHc0+A1/VAhRrIYpJ8v6hnHarNxAFiV594=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L99/IJF9Nk3K2e4GxKzg6gQc3TvEHZNT3B9Ebe1B1Ad9ntltRtdCNJ1+CZne2JEO0
	 U473qGTEBLoHrKpLiBzv5gJnN/nm81ImrP3fPZcQvfNHKYvvADcjpChP98ZfM4ZQ0N
	 x/9r+GW0z/K9pMZSwsD94BUkttmPIi58oZs/x6swG/cH7l6BUsbPaxW0MIKaGdJEpT
	 QbRFLHL/iNNZvPB4mZjCFu2MQT+TjbWfOLOUwdD82svTeg1PNKmlMNfTZmHyYGctCf
	 vJpMx2QD0KGsyb9yulJUDF7mdXuH1ryAJ5tmzoAHjanzkIxDvxGytlw2LYiJydDHh0
	 YZjLw5sWvhkJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0A39C43168;
	Thu,  4 Jan 2024 17:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170438882671.7630.851380373262172325.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 17:20:26 +0000
References: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
In-Reply-To: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, lists@nerdbynature.de, noureddine@arista.com,
 0x7f454c46@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 13:42:39 +0000 you wrote:
> User won't care about inproper hash options in the TCP header if they
> don't use neither TCP-AO nor TCP-MD5. Yet, those logs can add up in
> syslog, while not being a real concern to the host admin:
> > kernel: TCP: TCP segment has incorrect auth options set for XX.20.239.12.54681->XX.XX.90.103.80 [S]
> 
> Keep silent and avoid logging when there aren't any keys in the system.
> 
> [...]

Here is the summary with links:
  - net/tcp: Only produce AO/MD5 logs if there are any keys
    https://git.kernel.org/netdev/net/c/4c8530dc7d7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



