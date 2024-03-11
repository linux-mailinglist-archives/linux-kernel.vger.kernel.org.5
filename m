Return-Path: <linux-kernel+bounces-99548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D88789DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941EA1F21B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05757305;
	Mon, 11 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHtfv+9T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD803CF6A;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191432; cv=none; b=t124qO5IekVaWzHmaFUgG7gfWWKOxMWrARjonDc4HnQpAvU6PDQPHEGW/E4fNXm5DaqW8QqUnLCYKWtg+2fUcZ0QiJAYkjldSsSukenVQrPpxo6N0fAIg0MQ153T4iC7YhAoFcd4axr5U1SiGqfqtwp10ThsC33pDemWvSZ1R/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191432; c=relaxed/simple;
	bh=RKd4KvIVsiKfmsQPL+OTvUcFBnZ/+QcQIzjHjvJ1Ris=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qqdBDo+cIAqTVgsttyQnmFkS2PP+xhQnc2XmLUNm3RUIq+ap9uv9gtkuTBg0kb6nI9p/dIO7miMm1cIZbqtmYrQkIMx6EQKL26x4jtP3oCn4kL5yK2PvgE7lk7abm1KrWxA6hCwgd8zb8qiZMhJaryI1UBux4INrz2ffmRNh5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHtfv+9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA3AFC43394;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710191431;
	bh=RKd4KvIVsiKfmsQPL+OTvUcFBnZ/+QcQIzjHjvJ1Ris=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHtfv+9TOIo7qpcBEIfmSXQcM5ZCdtyfaOLM8hk7QRKD8isuXtOFpu3oTssFChbKP
	 3Nec8USezyUhthcZS7DRWqJPUz8e2aQwtaDXfRAKfSi/2WIJwcAo0XaMoDsL3/LDrr
	 iWsxYrlU2RZqhSQb+ZyWR+HZ0WSFxd1/dbGqiUPz+6kYg8M8v1oe77asp+fqUVtXrP
	 IjP1bY8wW8jmPbyKLvUuo6ZVA1I7zZVWOkvJd4Ogk8ok5T5vhuBb5TPzUhrtOn9kaz
	 NAJ3nNyBYe5oSqcMY0vRHq+C7I85jg7PGsDngiuXmX2wFE8MAemDWlwjlSZuw9ZRXc
	 3og8kBryilEyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1313C39563;
	Mon, 11 Mar 2024 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: make ptp_class constant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019143171.14853.3804892624016553605.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 21:10:31 +0000
References: <20240305-ptp-v1-1-ed253eb33c20@marliere.net>
In-Reply-To: <20240305-ptp-v1-1-ed253eb33c20@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Cc: richardcochran@gmail.com, yangbo.lu@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 Mar 2024 17:11:27 -0300 you wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the ptp_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> [...]

Here is the summary with links:
  - ptp: make ptp_class constant
    https://git.kernel.org/netdev/net-next/c/c057eddcb45a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



