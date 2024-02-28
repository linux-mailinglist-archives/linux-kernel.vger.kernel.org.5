Return-Path: <linux-kernel+bounces-85804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00D86BAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04185285041
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73DE7290F;
	Wed, 28 Feb 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtgZ12Lc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A931361D0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160632; cv=none; b=UxFUmxJd8FFUMZju0wLUmZBmyzf1iAdvBWjK/bWb9t8dbn+iAJOMj69k6vaM4UiGv068zxnWJBECFWF3C2DeADiDNgar/nuuokdoylcoHPY0XNC587Vu5dq8SE2d9cdM+7CIP0E/7eRn9+N+VFtSXdbMrQ5rEHwRLAGP01GssMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160632; c=relaxed/simple;
	bh=3Fd60MS/Vmnzo7x8IrSs/bDLfdZm3IDdQANbO/8Z0Lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WvrTfYpm+7/FjtY7k93hjUerv0aZeisJKURUKNrSwRVTVJkvKNtLmFNfy1F9cKRUrPTaQ7Fndv5ZRS1ctp06NjU31dFuNhJijT6xFwAB7vg/8Cg76LhCnCMAHTQA+8jzo6hVt8lCdiUrSAtbPr0F1QZbwg6gdUoj+5G3MzmcE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtgZ12Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7DEFC433F1;
	Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709160631;
	bh=3Fd60MS/Vmnzo7x8IrSs/bDLfdZm3IDdQANbO/8Z0Lk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CtgZ12LccI/s+ShYcVRT3viuEpG/gy0XmcIlCDJG3TpnTHXXObh/Snre3FhGlhxiL
	 SRFHCIE4vSRcGzyyw2agfXIurbMxVXXb9Hsfe6BaS1fZe/EWa44l7goiOFmjZsqO4j
	 h0uVK0xQQheqr4x0DIqBuSAkucUwbb2RTKNgBogwjIrRAUcgzAenv4eqY0rdYnb5R3
	 DsSM+vEh/0/6GPvzGCJFjy/umVgF3qHq5xkQP6cNh8rgqFC+9Xe8IhWpX1Y8yTKI6x
	 LhVu8dOQnSTryLiF2IjR5cbUAACMjxcKZJZDf8HMkHO+Zm14YcNMdRIO08bkqcZSCf
	 iaHRCcTyFf02w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81E8ED990A7;
	Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to check compress flag w/
 .i_sem lock
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170916063152.28690.2631252489299295101.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 22:50:31 +0000
References: <20240219022844.3461390-1-chao@kernel.org>
In-Reply-To: <20240219022844.3461390-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 19 Feb 2024 10:28:44 +0800 you wrote:
> It needs to check compress flag w/ .i_sem lock, otherwise, compressed
> inode may be disabled after the check condition, it's not needed to
> set compress option on non-compress inode.
> 
> Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: compress: fix to check compress flag w/ .i_sem lock
    https://git.kernel.org/jaegeuk/f2fs/c/7493c07e31d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



