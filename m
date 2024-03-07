Return-Path: <linux-kernel+bounces-95862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C9875439
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6BCB22425
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE012FB3E;
	Thu,  7 Mar 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HueRRVog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8AD12FB12
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829295; cv=none; b=l1zk9ypbjwjr1x/3mUggrmwY+P+9U1VkB6PwTf5eJE9vRq2xQMh6fEclC/TB1OtsrkHHflg8DQdCKzOKs40Wl8ODQhxHvstYeIQC8D3mngDknoK7F3OcQntWkbsQR2PdE99LBTXeOjTWiN5DKLviVSI+EOUknX2aVWNYR3yxWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829295; c=relaxed/simple;
	bh=ySbGTSB9I9fG9R/a3i18Zv97SxzmylETa0cRNS5mA7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=merhuysVwTvoTJw4+wCSHfqBBJ0p17E9HXA7CABlMo0YKfwJOk+5XfY7gkS7oaGhHqWvFV8rK+0GD0Nb/0/STKDpWQuuRl6hlxMrSwWBsPKFrb2IBMmw7lxZTHgAjNpMeYMM/RCkyz0HOFFcEn+qcaPeGmOETtQjtKaXpde7e3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HueRRVog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AF4C433F1;
	Thu,  7 Mar 2024 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709829295;
	bh=ySbGTSB9I9fG9R/a3i18Zv97SxzmylETa0cRNS5mA7w=;
	h=Date:From:To:Cc:Subject:From;
	b=HueRRVogxP9lY8mdHcBw2/cuFe3o0qkDMci6WxrJU9Twszu23HCnq7cD/XFCqOuOo
	 q8fPngYEUI1u6zrR9UI5pTWnQntIiwv0wBdov3OP8WT3IN3qY6OfOTS/uGPbNX5iyX
	 nAP5HITvj9eTnOvwMsQMOuTKLoOSM9kAArCqH31DtZAaRXhduaiS3o8inuidKUMCU0
	 RSB6kQu6UFPzrUCIDU0pPNioPx2IO7F1lknPmQYT8zNLcNLKKKSc6VrrG+nmk7aPwP
	 XUAFzYY+9BrAj9wNhMXEuc9ap/KN6oJyYx4lrqxXLELwNG9o0jNLOROkUqz8rNTT70
	 uz04nnmXh6cpQ==
Date: Fri, 8 Mar 2024 00:34:49 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
Subject: [GIT PULL] erofs fixes for 6.8-final
Message-ID: <ZensqX1/c0L/hZJf@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this last-minute pull request for 6.8?

The main one is a KMSAN fix which addresses an issue introduced
in this cycle so it'd be much better to fix before releasing, and
the remaining one fixes VMA alignment for THP.

All commits have been in -next (with rvb tags added today) and
no potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-fixes

for you to fetch changes up to 4127caee89612a84adedd78c9453089138cd5afe:

  erofs: apply proper VMA alignment for memory mapped files on THP (2024-03-07 10:21:10 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a KMSAN uninit-value issue triggered by a crafted image;

 - Fix VMA alignment for memory mapped files on THP.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix uninitialized page cache reported by KMSAN
      erofs: apply proper VMA alignment for memory mapped files on THP

 fs/erofs/data.c         | 1 +
 fs/erofs/decompressor.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

