Return-Path: <linux-kernel+bounces-94769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538B874503
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D071F26309
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB17FF;
	Thu,  7 Mar 2024 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ8WDkfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5407161;
	Thu,  7 Mar 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770123; cv=none; b=FHvneRnyVNGD5EHq4NkMOSSi5yBQY0SM6FP/QtkOTRDWiaaPhci5CC5tgIWAYDCTpom3SOMPL/U02X0sr3Ceir/jGnd2OsHPqiaF6gbTtlfUwQundgYbvvIh3aBu+1MuuDRVxtsWzarSnlyQQT1XkcXp1tmLWSeQg2kxhD7mbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770123; c=relaxed/simple;
	bh=qv/RvIDOoaBvAi3iapTajJTzXffCdSMqsvAFuItgvNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qelP1BDgioeHq0fNRw93b8MQLwfkH+yBc20ZRIkx9aflpC8ueCMSr7utzKGxY/B6b57YEVxWwpwPkE6Q8HQ7lsoNxMrMBSeYcuvaYjbe574vs3nQ/3N3+PfF6ZUa3DNXWr2HIOvl8PVoU73n0/s6ogFUiyUue6BDqymeUCyCUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ8WDkfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4F6C433F1;
	Thu,  7 Mar 2024 00:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709770123;
	bh=qv/RvIDOoaBvAi3iapTajJTzXffCdSMqsvAFuItgvNI=;
	h=Date:From:To:Cc:Subject:From;
	b=XQ8WDkfrxjzp+lAIWlOcm4CiUAgu1Z+1ok1oK+Pr+nFvKFzTrR596Of6LqU4QvC00
	 eZKui8+N8rkcUHQjEXVjBVQN41lLIhAa7R5f/Ij3nkr6jEpNOyNqyMsBqnLgdHt5dw
	 oR6Sia+5zeKan7ahswAUAtFgqjPRHcCYHdzSsFLfGzos1jmhOi0oa8tTXw+tvHM5vH
	 UrCMbHkTcdI6MkUDlLzClE/5zPTszgEKhONE8wP8SQFtzZRNaeAjPoN3gIJH8SSJO3
	 o3lxU80o8TmWhMoCI+/1lqhbA6ddMqfPtwdvowr/4rVgDv+I/8gnSGABFCULkSMgrg
	 4htrrnWOez0hw==
Date: Wed, 6 Mar 2024 17:08:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.0 uploaded
Message-ID: <20240307000841.GA3806611@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 18.1.0 to
https://mirrors.edge.kernel.org/pub/tools/llvm/. This is the first
stable release of the 18.x series, as LLVM has adopted a similar
versioning scheme to GCC where main/tip of tree is x.0.0 and that is
bumped to x.1.0 when the release branch is created for the final
release, with subsequent ABI compatible releases being x.1.1, x.1.2,
etc.

https://github.com/llvm/llvm-project/commit/4532617ae420056bf32f6403dde07fb99d276a49

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 18.x
series is no longer supported.

Cheers,
Nathan

