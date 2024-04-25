Return-Path: <linux-kernel+bounces-158826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CF8B256B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF671C22FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB414D71E;
	Thu, 25 Apr 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiGYOPlo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC714D701
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059632; cv=none; b=QRRu5L4Xx30Q363dHAWchob+UQnwnKboUSlnbu3bdAo6FGJWFKwC/UvCKK12Q/SzrXF5t28La7lK6dhJ2wPeMwqbGf+9bTIRTZAq+tyfhYNR8iPhKP27+2ClINjWe8UdLtv+ITzLpaKjPdqUUhN0wLDSiPev1t63bwjw7DO5+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059632; c=relaxed/simple;
	bh=bGIBA6DPr0bJFT701J0z+3vINk9dWTIDvIiKasrikLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RZaDSEO/8qvL7TjbMSWoIccZyNtfDKu1Fb2U/TteloomJmGHFzHUWuuTNch1YX3bUyKw3hjN22V9A8BdxWYTlZb9b+MZLKS4dzx0Dgj+SFES3VmGcvrxMI+vZND/CJPthlyvsg9QFp6UQfc5ogKNHwKyX8HYsj3Dj6d9DzkcAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiGYOPlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC548C3277B;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059630;
	bh=bGIBA6DPr0bJFT701J0z+3vINk9dWTIDvIiKasrikLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uiGYOPlohvijFtjLNvRWpfmRaIeGzwkPccqaeDuTE7OQngrm5I9pZT2fcsBSV6aJg
	 j95LtJT/CkYKbK5ZT3Cfz8gQTtXc9ZU8UBaQIzIytkwayRIGVvPATeto4qtpsSxuNM
	 a2vX86aSirnCcz+Sq699X4Tez+20NTpF2QgJSVelPWcUQRR6/ocZr7jG67eeFGFCtG
	 iVY1ILgMnCN+EdeR2dld7NtBEpWpn4r2vWn1XCatkAn+gDnqwWYf29oXRXOoH6lC1A
	 exEhBQT4bRDLiX4GnXfSNhu3PqCu77i+TrNuBDJrIh5XTWGpql+reqq9eVp55wTr/y
	 qIqARoRpIogFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2AD6C595C5;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix false alarm on invalid block address
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171405963079.10966.9092542666312689265.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:40:30 +0000
References: <20240424173548.1515606-1-jaegeuk@kernel.org>
In-Reply-To: <20240424173548.1515606-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Apr 2024 17:35:48 +0000 you wrote:
> f2fs_ra_meta_pages can try to read ahead on invalid block address which is
> not the corruption case.
> 
> Cc: <stable@kernel.org> # v6.9+
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218770
> Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix false alarm on invalid block address
    https://git.kernel.org/jaegeuk/f2fs/c/b864ddb57eb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



