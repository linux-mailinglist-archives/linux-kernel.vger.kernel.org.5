Return-Path: <linux-kernel+bounces-125338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C7F89244E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDDF1F23AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874213B58F;
	Fri, 29 Mar 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QADzHlMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26091386DC;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740633; cv=none; b=JSyGP9rTdibXDLH6YvANkLkwnAu5DjInxSXOMgS/GthrF1P9GCpTWfTIIzIy42ZPJkLAzXxm9o/mD9DaHgx3obzt2Qb8qxfgYaQxlbhwMgiYYA7NMRPGyvfF29+OjCvdM6RBb6QlAjkqnvyx99jSn8gqfzqzTp2xKGuhu9jupD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740633; c=relaxed/simple;
	bh=RHrNIfF8qGtbEjvcz5lLvg1X5VU4L/Yk1Mcs2CCX8qk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UlHdkmwS89YZHRAQxYY+17Yw9fYRLqwSpgB80jfJbhRZ2HEkb8T5+eWHbeRVG9sTR0RGfusYPjQPsVGK1rK9mEp2iujYBA/SHsBftUh8ZzRkdyEvK5CywMm0sy1ffF+mHicUxQCAXDuAbR4p1bFyYfyuLn9cKycJxCrQ2RL0v0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QADzHlMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CF85C433F1;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740633;
	bh=RHrNIfF8qGtbEjvcz5lLvg1X5VU4L/Yk1Mcs2CCX8qk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QADzHlMdsw2IZpkJ5BI5hq1CH1FsNJJplHedcLC6X+DixgyrQHcG4OFkiwppygF8G
	 udJCQYNd0M7C9JfCeJ6D6RDqsME/9SHBxCux6FXpJ05aUIeu5yy7fV29vATAC8QtJ6
	 EBUMgM+axI0aFAOQHQSlGCs7y+5aHE59edHmr6DkPWPTq+2HDELCaMA+a/H8LAxsxK
	 M5aBdJTOlSbiLhH55LacOimskCwH2cYh9s3WxwwXzqfNqkZ4RH6Bu5gzjdgsPmJL1C
	 0IOikoHC3FbANeKhQitT6u7PesiE3Pu9NtvgCw12YBgQdAiLyl47K17JuouNwVGL7I
	 tiIVbhaVcfpSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 070DDD84BAF;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next][resend v1 1/1] nfc: st95hf: Switch to using gpiod
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174063302.18563.7724258165796761726.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:30:33 +0000
References: <20240326175836.1418718-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240326175836.1418718-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 19:58:36 +0200 you wrote:
> This updates the driver to gpiod API, and removes yet another use of
> of_get_named_gpio().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/nfc/st95hf/core.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [net-next,resend,v1,1/1] nfc: st95hf: Switch to using gpiod API
    https://git.kernel.org/netdev/net-next/c/b7b1c5906912

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



