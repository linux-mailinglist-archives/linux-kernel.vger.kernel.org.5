Return-Path: <linux-kernel+bounces-99843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A94878E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223EA282E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD537111AC;
	Tue, 12 Mar 2024 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g50xcMcl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03151BA28
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710221413; cv=none; b=nUmCJ4L2LZ8yT9XuNCtmoTOPYMO6rwS5nEYgmeHSGG4oLSB/XoMGyYeKNu6sY3CZFTy7bEqjcloPHl0b8QH47rG5vK32U893pyngPRTCAd/K+PYVeJZfwOb3J8CCgx5pub8vDxWpOuuHMgFP15rRSQ2QQ6hr5HdYiELVJcUNV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710221413; c=relaxed/simple;
	bh=+5tJ6mr9tb2opb0sZ3KJ72ZbRYxwxwwtGK/uof+Odac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c4DcqEuGe3OF1DSb+/8/A5akBnEUWBraOS942pNc+fQ0+A+9OEnDqB1ASoOZpvRFCgEQJ/DMlVv6hyqjMey28v+ASX2Evap24+m/Cq+WvHJnG6irxNc9SCXbczr7mdKBh5TgoRpgQat2/sJ2Eo1Q/zHOnO9X0M+q0lbTjcYe4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g50xcMcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CCC433C7;
	Tue, 12 Mar 2024 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710221412;
	bh=+5tJ6mr9tb2opb0sZ3KJ72ZbRYxwxwwtGK/uof+Odac=;
	h=Date:From:To:Cc:Subject:From;
	b=g50xcMclHzBKkWk78XJ7i0kFHtqEM5x9dPd21nc+3/TGTWvaKkzJm/ocmaJmZ7hJU
	 Ghm2uvn4jVlBkC6ldqSJKOA3KD7BJBwNLi/gSiyYfa2f+Q6l4GpJmNPnsrt4igyCxt
	 mAd/DSMjub+0gran8cVEX3CQPh0yE+cUBcpGPOrIKQqfpuWUAVKbM0TqtrVbua6B9I
	 KR+FNxD5qXxDf6JUX/rJdBfmnOvQ/yQofQ7IrOlcCjzjSokbVLrwKhoDD6LaQEt/DH
	 oAwkdD3D/Zm7fxZWGZjelACW9xtvNj24K4gJjnYKvjFNd365YMqC2b1PKsS4h2szU/
	 OXMkXAJDZg0hQ==
Date: Tue, 12 Mar 2024 13:30:06 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs updates for 6.9-rc1
Message-ID: <Ze/oXlaiQfdspyNX@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.9-rc1?

In this cycle, we'd like to introduce compressed inode support over
fscache since a lot of native EROFS images are explicitly compressed
so that EROFS over fscache can be more widely used even without
Dragonfly Nydus [1].

Apart from that, there are some folio conversions for compressed
inodes available as well as a lockdep false positive fix.

All commits have been in -next and no potential merge conflict is
observed.

[1] https://nydus.dev

Thanks,
Gao Xiang

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc1

for you to fetch changes up to a1bafc3109d713ed83f73d61ba5cb1e6fd80fdbc:

  erofs: support compressed inodes over fscache (2024-03-10 18:41:32 +0800)

----------------------------------------------------------------
Changes since last update:

 - Some folio conversions for compressed inodes;

 - Add compressed inode support over fscache;

 - Fix lockdep false positives of erofs_pseudo_mnt.

----------------------------------------------------------------
Baokun Li (1):
      erofs: fix lockdep false positives on initializing erofs_pseudo_mnt

Gao Xiang (6):
      erofs: convert z_erofs_onlinepage_.* to folios
      erofs: convert z_erofs_do_read_page() to folios
      erofs: get rid of `justfound` debugging tag
      erofs: convert z_erofs_fill_bio_vec() to folios
      erofs: convert z_erofs_submissionqueue_endio() to folios
      erofs: refine managed cache operations to folios

Jingbo Xu (2):
      erofs: make iov_iter describe target buffers over fscache
      erofs: support compressed inodes over fscache

 fs/erofs/compress.h             |   7 -
 fs/erofs/decompressor_deflate.c |   3 -
 fs/erofs/decompressor_lzma.c    |   3 -
 fs/erofs/fscache.c              | 297 +++++++++++++++++++++++++---------------
 fs/erofs/inode.c                |  14 +-
 fs/erofs/internal.h             |   9 +-
 fs/erofs/super.c                |  30 +---
 fs/erofs/utils.c                |   2 +-
 fs/erofs/zdata.c                | 287 ++++++++++++++++++--------------------
 9 files changed, 335 insertions(+), 317 deletions(-)

