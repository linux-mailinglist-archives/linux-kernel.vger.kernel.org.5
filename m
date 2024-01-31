Return-Path: <linux-kernel+bounces-45720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A248434A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B0128AD26
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174418E03;
	Wed, 31 Jan 2024 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+uWTVxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A865182C1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672710; cv=none; b=R3cxHsppRQwTJ3dsBgeix6QKT2rU9C3KeWmomT6z2N5yNfI4+6w/GfI5regimU1extDWbb6N7XBLB+Mv7FCcvUVYjXu53LTsebmEK7Lyb4KDQSRhDrOTlcbGq2yKIrXMvjNhTShUGuZgU3/MSHiCZZro1VC0EBO96ybar3DL000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672710; c=relaxed/simple;
	bh=ykzqhetelTYX6R6hoF5APKU0QC0aniQQjrvlRNHploA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aY5Q79vVW6bjGHJ7Ap5fKo6feE/0qoXOrgzfvCgCwUJliaPAqqQTcnYvBU2NLXmKl7S8tQXOWrSQl6ayyR8aLiZbR+eqk7wZy5KmxZOA0eOQXY4RXAcjc9lP71VoV8wMShJ+zOcR9fJKWLtW3JLGxnL26RuxBWh4QORH5RVjG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+uWTVxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80196C433C7;
	Wed, 31 Jan 2024 03:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706672709;
	bh=ykzqhetelTYX6R6hoF5APKU0QC0aniQQjrvlRNHploA=;
	h=Date:From:To:Cc:Subject:From;
	b=Z+uWTVxUFBV4vZNSVMsU/PcJ8BF57hPdbXtst1bZqQCPpb1GshZWb+wqtZJo/uYLu
	 pVg1FCJksnEoTljbkremtKukmDvO4X3uksQmupkkCh+Qokx9RMC5nHRCh1SGtHAHBG
	 rwpp5ZHkjwG0Gkx/7UBFcr4vNnTZveeVVpBNAAInQs+KAJZXghZZoKNK4pm+4zT6cx
	 WELIoR0NZaXTvC7ZMwaXMjr30EOPjTKi31khudsBNAnelipnDdChsZwlwljWKNw1vj
	 fzvuZk5R2JyTv4cp9fPrRi71x1QhWUzdPw6zFOQHIUmJxa9TrcoQLsJNmjZK7Gjgfm
	 LQUxmu0IevR/A==
Date: Wed, 31 Jan 2024 11:45:03 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.8-rc3
Message-ID: <ZbnCP71bgYBzzHA3@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider these fixes for 6.8-rc3?

One commit fixes an infinite loop issue of sub-page compressed data
support found with lengthy stress tests on a 64k-page arm64 VM.

Another one optimizes temporary buffer allocation for low-memory
scenarios, which can reduce 20.21% on average under a heavy multi-app
launch benchmark workload.

The remaining one gets rid of unnecessary GFP_NOFS.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc3-fixes

for you to fetch changes up to d9281660ff3ffb4a05302b485cc59a87e709aefc:

  erofs: relaxed temporary buffers allocation on readahead (2024-01-27 12:28:08 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix infinite loops due to filling compressed_bvecs non-atomically;

 - Remove unnecessary GFP_NOFS;

 - Relax temporary buffer allocation for low-memory scenarios.

----------------------------------------------------------------
Chunhai Guo (1):
      erofs: relaxed temporary buffers allocation on readahead

Gao Xiang (1):
      erofs: fix infinite loop due to a race of filling compressed_bvecs

Jingbo Xu (1):
      erofs: get rid of unneeded GFP_NOFS

 fs/erofs/compress.h             |  5 +--
 fs/erofs/decompressor.c         |  5 ++-
 fs/erofs/decompressor_deflate.c | 19 +++++---
 fs/erofs/decompressor_lzma.c    | 17 ++++---
 fs/erofs/fscache.c              |  2 +-
 fs/erofs/inode.c                |  2 +-
 fs/erofs/utils.c                |  2 +-
 fs/erofs/zdata.c                | 98 +++++++++++++++++++++++------------------
 8 files changed, 87 insertions(+), 63 deletions(-)

