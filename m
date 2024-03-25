Return-Path: <linux-kernel+bounces-116394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E5889A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4E31C32F55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B113BAF9;
	Mon, 25 Mar 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+7IyK7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E5229D68;
	Mon, 25 Mar 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711334429; cv=none; b=Vo1zlzb/1+sossaHMXnt0rhBjl0BnHvzO7oNh3v5loMlrND9rrQf9u4zl3E1UymnS3aQ8wvzuBjdenbpCJlJvXTZfJtugE1F7tQhiZjH9ArClfwJokfKfLfmIMnPdw8QTsDrv7A/IqJ3yvzNX00uY3gQ39JpRJtCOUUzjAIqkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711334429; c=relaxed/simple;
	bh=zo7xBI0RIUOEwUmjoqhSEKwU6zdd9SPVoCL14vmhqFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sdHAc7iQAJI3JKEvp1+4qqomX2VewbfydTy72cMo8p+d1xAST0bAvLcVIKuphojeT6NvZzk3fgEYWvQpkKYY6wLcMnPcUkHAAEBVhA6ithwAAkQTDgITuxSw2aeC4kh4TQ7V0KZvuIgMMeO8hmW3WJxtLMdYmD8c8Bicyw+WzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+7IyK7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30AEDC43390;
	Mon, 25 Mar 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711334428;
	bh=zo7xBI0RIUOEwUmjoqhSEKwU6zdd9SPVoCL14vmhqFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y+7IyK7y+e2YJezyDzZUGgaZWhvwU6/ltC0dwIpBOo24dYfEiSbpuChHGeD0yabT5
	 5+59K44D9m2klxqpmNv54DC1FB9YPO4t+NRVz+d+qzBN6uySIlJhsfgu+NWfKOuSQX
	 ARzc4Xyb49G72AV5H081/fGjp6FtpucXPcjInd8NVNfmWMiH/L6+XJpOe2U3ej9DwH
	 L+PXrUnciO8fFYr4ihpvnpIxDvi2Xl5XCGRjC+C0XD5r40ls0mLdWyY0lwXYGWIC4+
	 WG4zfHYgII63eGqre8EcKi+r+QxrSzq3Mgbksq4cxXjWHabOFH5651dlxv8XmscJkU
	 G+vSbYb4olomA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12408D2D0EB;
	Mon, 25 Mar 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] platform/chrome: use sysfs_emit() instead of sprintf()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133442807.31480.12835456312162773473.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:40:28 +0000
References: <20240314052828.186924-1-aichao@kylinos.cn>
In-Reply-To: <20240314052828.186924-1-aichao@kylinos.cn>
To: Ai Chao <aichao@kylinos.cn>
Cc: bleung@chromium.org, tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu, 14 Mar 2024 13:28:28 +0800 you wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/platform/chrome/wilco_ec/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1] platform/chrome: use sysfs_emit() instead of sprintf()
    https://git.kernel.org/chrome-platform/c/f7496450528b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



