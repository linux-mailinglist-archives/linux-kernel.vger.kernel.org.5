Return-Path: <linux-kernel+bounces-99590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DD878A67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616C71C21569
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2757860;
	Mon, 11 Mar 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTjaV4ln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4D56B9D;
	Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194435; cv=none; b=VLdpITIyFIXbf2wdtdSWMvImn5J2Dq+eNpFmGfVO5tJ+/f2H4WbJNAUSJZFVvANK+qKMEes+ZgBbgQy0NVKl0LdWP41Jsov3PPfgWHVA3xXoc7E1C4yhONnKbahf36SJM93pFfFtPmIRVjHNOn4Mc2BQiuWc4VnZ3xhqRqGDwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194435; c=relaxed/simple;
	bh=AvPE0MWkoiSBvXUofuuPo2NvsFXH3G0ZocpFpP/0V8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LiqYmJ3/hT321In6vqlVhJQhIKMxBBRh4cYW0qlptzRCNq2imGae00Twopx6FE8A5rx+N36kW5A1JBIZmqXrai0hope3RqMjQfcrLJsBWp+1CXJErtPs7CWLyGiidBcwfL359jDHDZ6C8rJ4z0H5b5i8x37Y8Na1g05mbBL4vYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTjaV4ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 890EBC43394;
	Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710194434;
	bh=AvPE0MWkoiSBvXUofuuPo2NvsFXH3G0ZocpFpP/0V8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sTjaV4lnoZZdQpJanXFJGv7qQ4RSt1AeT7BEZrr/6OpYFVxZiRlJ1TuLHg9jhaggk
	 XbnUx++51+30OqxW1mIOGyGYTHIu9wuPWhWFxouTIrmsqF8UyGRZHsdkitlbD2jrSr
	 Hh3Qr9nyFqkXqdzWe5wy5gwGKnkZWjxnubFSK1oTbCfznLz7TvevfR6LOsO35CWize
	 A+kzlHjmQvdbJvG4nfoWFAm2f+CZg8lHynNnq+yceBlZYvdPzSxljEdF3mQNMO60eT
	 Mj/tPg0wf0HXQujK7R08q/7QB6ya/dcqn1CL8V1ZffHvORZKVqmObXlCTxp+FRQjBh
	 OA7nIP5CA/K3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FAC5C395F1;
	Mon, 11 Mar 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: netconsole: Add continuation line prefix to
 userdata messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019443445.9697.5244091581871121870.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:00:34 +0000
References: <20240308002525.248672-1-thepacketgeek@gmail.com>
In-Reply-To: <20240308002525.248672-1-thepacketgeek@gmail.com>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, leitao@debian.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Mar 2024 16:25:24 -0800 you wrote:
> Add a space (' ') prefix to every userdata line to match docs for
> dev-kmsg. To account for this extra character in each userdata entry,
> reduce userdata entry names (directory name) from 54 characters to 53.
> 
> According to the dev-kmsg docs, a space is used for subsequent lines to
> mark them as continuation lines.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: netconsole: Add continuation line prefix to userdata messages
    https://git.kernel.org/netdev/net-next/c/2b3953585953

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



