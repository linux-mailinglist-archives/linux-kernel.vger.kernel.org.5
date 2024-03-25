Return-Path: <linux-kernel+bounces-116519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9588A0BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55808B62070
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D713E6A8;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyW3I9qa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8413E6CC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341755; cv=none; b=agXZzeP6VA0Y8PwR4l6r4kCgACtzbB7dFda11vQhep3Chh/rv80dYafGpKo567k3sI1XrB0oew93FCWNIyKzHrFXGGQL19aZWPQzEOcFbTLw02nmPhNa5q8ZB8rT3V0DgKIemmGA2Bcci6Lg00f/P1wxykH58nkKe2V+MYgK8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341755; c=relaxed/simple;
	bh=YdL2mOIr3NlfgP6sy3cQZt2wKvb73NuUct/fQ8gw+wo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JDEANK0emFs8sXBxDNq+m7MScfVjcpShdpY2W+nYK++O5BelzNrQMlwYc4b9McszErAVMo0XXEsx+GNQuTV0MrIAr8uf5UFmpRYOuXJL2d4RoGOv8G71h8zShYYYwoVVARQQ6KZDRXXj8mBB8uFLGTIjl02wyIdd1f9G1dJmXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyW3I9qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A81F4C433F1;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=YdL2mOIr3NlfgP6sy3cQZt2wKvb73NuUct/fQ8gw+wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyW3I9qaDGbspbhpix74t7gfdEo1sveTew3DjnMt0ZAq3sY/coVNVi6/3u55HLXNK
	 vzByJhq3ut4mAzLPPWqIk24QB0wfqD1HnBCIH5lCGVkWJ7aJWYTwwPC31Kab+vkenA
	 SEBh3Iu5z4JRfGHgpDEq51ruoTZ+llxyXps4ld4DBTWqp1s5v51z48Vmlv3m/ILTFp
	 xikKVbaAsWz03cvxujv1VNVjWDf6zQYQzQfSPV/KocEjuHmR00tmZHCNjzR8deIi63
	 1Dx+FsMSafpFQZvqqg7MUbkSKlRROuQfZDvHV4SjINKFWq6x5BCLXm9BtnhIZmPl80
	 qwz+3RUCSNIKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F525D8BD1C;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.9 Merge Window
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175458.18749.15620721210284247678.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <mhng-105d6a21-7483-4a20-a9e7-8e72770737d8@palmer-ri-x1c9>
In-Reply-To: <mhng-105d6a21-7483-4a20-a9e7-8e72770737d8@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 22 Mar 2024 07:22:06 -0700 (PDT) you wrote:
> The following changes since commit e0fe5ab4192c171c111976dbe90bbd37d3976be0:
> 
>   riscv: Fix pte_leaf_size() for NAPOT (2024-02-29 10:21:23 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-mw2
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.9 Merge Window
    https://git.kernel.org/riscv/c/c150b809f7de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



