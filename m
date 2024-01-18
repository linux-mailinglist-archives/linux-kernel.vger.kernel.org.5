Return-Path: <linux-kernel+bounces-30289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBAD831CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15454282C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34F28DA1;
	Thu, 18 Jan 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKIroSt6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE92575C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591952; cv=none; b=E85aLseQ2pZPEQujQj1BTB1lNdTUwndeafMbBin2h00wxG7eaj2CO37ImnnaSWvK3XY/5sPP5qsxYgwoP0b1l2BaP/brJsdrk6/JW17NPIgUAsEqTZYGFnp4YRm9hR4mUpu+MQpnJG1JAmHiwlgOjIp0EiJ2qHsd/NfCeA+6pBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591952; c=relaxed/simple;
	bh=NH/52USESWX/025MLcTJ6cVm9KuDjzjd5hFj4uGgKqA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:MIME-Version:Content-Type:Content-Disposition; b=hi46o5Fho1EqeR3nz182EgP4xpn7QlB8YtxgZwcYNo/rnRWBH2iliwjc6fOZfCWhr4cCUn7AQX2z9NW/rwrIrKRRgZOKPt90NkcEVvLEyy2c4Iv5OB8RTEwk22nZLLg4pII8Qgo8/7p86Xig27At985fIcPqzwZZ2jwsbi5d++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKIroSt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7EAC433F1;
	Thu, 18 Jan 2024 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705591952;
	bh=NH/52USESWX/025MLcTJ6cVm9KuDjzjd5hFj4uGgKqA=;
	h=Date:From:To:Cc:Subject:From;
	b=MKIroSt6lXEKXaW8LCFPoSsCdjkVBNMdDh4OwkAUPMa+c4EeXxQZce1qojt4K+jRr
	 zRPxQP/bhxY8ALNlY6DLgb1CfD9zdGxGXJLOKfJOJJkA8DA7ImEr5tGrVu2aMyLysj
	 t0tuu2Eh/TOX4GmhS2m5JaWFUjVMLUbZKlxHNNBOPOd6LkTFG1zfMeC2C1o7Y5jIpT
	 zynEbInLm74oT4C73gymPTjFaVj29z+ffyW18ObgO7XN91QrTC+ePQg/qvOQpyWOtw
	 UhknVtn5vBVJAB5Z/WHPsKJsDvSV6krDZdqc9PEEUsuPwnkLuje+ZSXb7SGYichrxo
	 4W4dCQJSw/5rw==
Date: Thu, 18 Jan 2024 23:32:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yue Hu <huyue2@coolpad.com>, David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [GIT PULL] erofs fixes for 6.8-rc1
Message-ID: <ZalEiKJWhdH2D9JV@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Yue Hu <huyue2@coolpad.com>, David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for v6.8?

It simply contains a fixed commit of the previous problematic one
mentioned in [1] and a folio helper cleanup.

All commits have been in -next and no potential merge conflict is
observed.

[1] https://lore.kernel.org/r/ZZ6M8CCkunjfbt+%2F@debian

Thanks,
Gao Xiang

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc1-fixes

for you to fetch changes up to 2b872b0f466d2acb4491da845c66b49246d5cdf9:

  erofs: Don't use certain unnecessary folio_*() functions (2024-01-15 23:52:52 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a "BUG: kernel NULL pointer dereference" issue due to
   inconsistent on-disk indices of compressed inodes against
   per-sb `available_compr_algs` generated by Syzkaller;

 - Don't use certain unnecessary folio_*() helpers if the folio
   type (page cache) is known.

----------------------------------------------------------------
David Howells (1):
      erofs: Don't use certain unnecessary folio_*() functions

Gao Xiang (1):
      erofs: fix inconsistent per-file compression format

 fs/erofs/decompressor.c |  2 +-
 fs/erofs/fscache.c      |  6 +++---
 fs/erofs/zmap.c         | 23 +++++++++++++----------
 3 files changed, 17 insertions(+), 14 deletions(-)

