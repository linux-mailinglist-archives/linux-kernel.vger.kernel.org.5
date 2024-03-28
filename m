Return-Path: <linux-kernel+bounces-122358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F9388F59D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA341F32E32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565B2C19D;
	Thu, 28 Mar 2024 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTRP69ge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABFA92E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594481; cv=none; b=QR0W6gF3ihPAJqXNf9KYRX4z9KVOg2QZOCviOQ0ix8jqkUMK9OkHWE/vQUhDjnKli1MuFe6D2TwF8KvlGR/hMjyUcIno5Blf0x/C/wD8usny+W5RagTVyXzKlmOZzT8lHIVdN+xaBeI7DuF8Vujh8G9UoSP4Tz/W4iWrrSe0kvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594481; c=relaxed/simple;
	bh=4cclLJ/anUOJByf0xhhSzb+lUbv2CQVypTSQzAyNo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vc795+3OjUtRg1eMGILtxJ4pBJN7n0YdgZcw52Id6AN1O+cpDHjrBnlYJ6WVq9Ze0ytYO3sTmCpONgnO6XZJ8ule0FEMkGHBEPHjBMLJnwCyjOPEi67ZKJ0Bjrw/BOpsNOtHTqF/cgdYNL8QTFq5KZQU84DDsiP01VdG1sROnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTRP69ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABDDC433F1;
	Thu, 28 Mar 2024 02:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711594480;
	bh=4cclLJ/anUOJByf0xhhSzb+lUbv2CQVypTSQzAyNo2g=;
	h=Date:From:To:Cc:Subject:From;
	b=VTRP69geAOzzq5ivUBxmniXFnR1Jj+qn2wu2RFsLWhkaURgZvca1fZxwOdFQi89MG
	 46aYQNqKcLssyoHFSJUghe0FNfD8xIuu+BsnLtLS8m7o086kiw16fpZFq23VTPMqt1
	 5tvmcImQiP9UjUhqKpdM22/Kg8C2Lip061zCq8vs8ivs30hCk+o1LOkRwQktLlWYLV
	 4LjHj4GBIpYrUjQNa9yNjkObNxdOXflu7coPnEO/9oQKdWrCe5rOZ8anxB4y3Q3A+1
	 JcoH8AAXZqE6IHRFpIO7gG8aE50EtHamnHtXEZwcSggJswzbKmXFree3pxU4h3wJ+W
	 WQ7cEliBo8x3g==
Date: Thu, 28 Mar 2024 10:54:35 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <zbestahu@gmail.com>
Subject: [GIT PULL] erofs fixes for 6.9-rc2
Message-ID: <ZgTb62/wsjacMpC8@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <zbestahu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Could you consider this pull request for 6.9-rc2?

Just two minor informative patches.  One adds Sandeep Dhavale as a new
reviewer who could help review some patches for EROFS filesystem
project, and we believe the project itself will become more diverse and
healthier as long as warm-hearted folks take a bit more time on this.

The other patch drops experimental warning for FSDAX since it's already
used for memory sharing between hosts and guests.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc2-fixes

for you to fetch changes up to 7557d296ad439f66a87cd34917af2a4172517826:

  MAINTAINERS: erofs: add myself as reviewer (2024-03-25 10:57:28 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add a new reviewer Sandeep Dhavale to build a healthier community;

 - Drop experimental warning for FSDAX.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: drop experimental warning for FSDAX

Sandeep Dhavale (1):
      MAINTAINERS: erofs: add myself as reviewer

 MAINTAINERS      | 1 +
 fs/erofs/super.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

