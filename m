Return-Path: <linux-kernel+bounces-22170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656BD829A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC21F23981
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C38482C9;
	Wed, 10 Jan 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR3zlrgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0847A55
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F79C433C7;
	Wed, 10 Jan 2024 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704889589;
	bh=XTnWr+9VNkl5OsNFjjoXhV8rPgRa0MXt2pzN1cgNXPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JR3zlrgYA7lOCjs4GVYtYGYyhC/vRXJev678JjNXRRr0XulTWG1KJ/mclm7iTh7DN
	 x3W1+kbs1qcwJ2O0R5ZOa7FadgSBgdaMd9Qk426qEXGAn0gGk+7C8j4j6E1x1iwRkv
	 YwaGpkPWs4EwUxk798bJk/MlEhMVs2cLIHrzgXSxn7plFnKKIVCo8ivr+aRLMeop1R
	 7gFJfyOH1M5IwGXmtWkDmdtNbAtOkI5Xr+aaSkRymagpnufZvqYBg0OEuKM4DLxvK5
	 B7DRVsnSaOT5MvV9JPpArda/lCFoK9AvJ3R1c6sKFzlHyDmY99EykW5e8XzN1Htpyp
	 I3g2Dm2XHa+Jw==
Date: Wed, 10 Jan 2024 20:26:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>
Subject: some update // Re: [GIT PULL] erofs updates for 6.8-rc1
Message-ID: <ZZ6M8CCkunjfbt+/@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>
References: <ZZq07DNl8EB/wlgK@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZq07DNl8EB/wlgK@debian>

Hi Linus,

Sorry, could you consider pull this tag "erofs-for-6.8-rc1-2" instead of
the previous email one since commit de9bced860d4 ("erofs: fix
inconsistent per-file compression format") was just found
problematically on some LZMA images.

Since the previous email hasn't been processed, it'd be better to drop
this problematic patch directly and submit a new fix later instead of
fixing a fix commit.

The description for this pull request is still as below:

In this cycle, we'd like to enable basic sub-page compressed data
support for Android ecosystem (for vendors to try out 16k page size
with 4k-block images in their compatibility mode) as well as container
images (so that 4k-block images can be parsed on arm64 cloud servers
using 64k page size.)

In addition, there are several bugfixes and cleanups as usual.  All
commits have been in -next for a while and no potential merge conflict
is observed.

Sorry again,
Gao Xiang

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1-2

for you to fetch changes up to aa12a790d31be14b289d5a2c6f41ca535fcc7841:

  erofs: make erofs_{err,info}() support NULL sb parameter (2024-01-10 19:59:39 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add basic sub-page compressed data support;

 - Fix a memory leak on MicroLZMA and DEFLATE compression;

 - Fix a rare LZ4 inplace decompression issue on recent x86 CPUs;

 - Fix a KASAN issue reported by syzbot around crafted images;

 - Some cleanups.

----------------------------------------------------------------
Chunhai Guo (1):
      erofs: make erofs_{err,info}() support NULL sb parameter

Gao Xiang (9):
      erofs: fix memory leak on short-lived bounced pages
      erofs: fix lz4 inplace decompression
      erofs: support I/O submission for sub-page compressed blocks
      erofs: record `pclustersize` in bytes instead of pages
      erofs: fix up compacted indexes for block size < 4096
      erofs: fix ztailpacking for subpage compressed blocks
      erofs: refine z_erofs_transform_plain() for sub-page block support
      erofs: enable sub-page compressed block support
      erofs: avoid debugging output for (de)compressed data

Yue Hu (1):
      erofs: allow partially filled compressed bvecs

 fs/erofs/decompressor.c         | 120 +++++++++---------
 fs/erofs/decompressor_deflate.c |   2 +-
 fs/erofs/inode.c                |   6 +-
 fs/erofs/super.c                |  10 +-
 fs/erofs/zdata.c                | 267 ++++++++++++++++++----------------------
 fs/erofs/zmap.c                 |  32 +++--
 6 files changed, 211 insertions(+), 226 deletions(-)


On Sun, Jan 07, 2024 at 10:27:56PM +0800, Gao Xiang wrote:
> Hi Linus,
> 
> Could you consider this pull request for 6.8-rc1?
> 
> In this cycle, we'd like to enable basic sub-page compressed data
> support for Android ecosystem (for vendors to try out 16k page size
> with 4k-block images in their compatibility mode) as well as container
> images (so that 4k-block images can be parsed on arm64 cloud servers
> using 64k page size.)
> 
> In addition, there are several bugfixes and cleanups as usual.  All
> commits have been in -next for a while and no potential merge conflict
> is observed.
> 
> Thanks,
> Gao Xiang
> 
> The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:
> 
>   Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1
> 
> for you to fetch changes up to 070aafcd2482dc31a12a3eda5d459c45496d6fb6:
> 
>   erofs: make erofs_{err,info}() support NULL sb parameter (2024-01-04 00:23:13 +0800)
> 
> ----------------------------------------------------------------
> Changes since last update:
> 
>  - Add basic sub-page compressed data support;
> 
>  - Fix a memory leak on MicroLZMA and DEFLATE compression;
> 
>  - Fix a rare LZ4 inplace decompression issue on recent x86 CPUs;
> 
>  - Two syzbot fixes around crafted images;
> 
>  - Some cleanups.
> 
> ----------------------------------------------------------------
> Chunhai Guo (1):
>       erofs: make erofs_{err,info}() support NULL sb parameter
> 
> Gao Xiang (10):
>       erofs: fix memory leak on short-lived bounced pages
>       erofs: fix lz4 inplace decompression
>       erofs: support I/O submission for sub-page compressed blocks
>       erofs: record `pclustersize` in bytes instead of pages
>       erofs: fix up compacted indexes for block size < 4096
>       erofs: fix ztailpacking for subpage compressed blocks
>       erofs: refine z_erofs_transform_plain() for sub-page block support
>       erofs: enable sub-page compressed block support
>       erofs: fix inconsistent per-file compression format
>       erofs: avoid debugging output for (de)compressed data
> 
> Yue Hu (1):
>       erofs: allow partially filled compressed bvecs
> 
>  fs/erofs/decompressor.c         | 122 +++++++++---------
>  fs/erofs/decompressor_deflate.c |   2 +-
>  fs/erofs/inode.c                |   6 +-
>  fs/erofs/super.c                |  10 +-
>  fs/erofs/zdata.c                | 267 ++++++++++++++++++----------------------
>  fs/erofs/zmap.c                 |  41 +++---
>  6 files changed, 218 insertions(+), 230 deletions(-)

