Return-Path: <linux-kernel+bounces-162014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129BB8B54B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3707C1C21977
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9E2DF84;
	Mon, 29 Apr 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo0RNhTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E02942C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385068; cv=none; b=inn0KV622RnH1mo/BAyXJ1UJum3QUoBYXahD23Exq9JcVpW5t9wNB5GaNUv+gtdJdlhoy0URp+OarIUfkSPclVDdLJZdQdSWJ/dugrmMd5ttl/3bn9wDSlwErB7gQCIZC/jbicAPbzuW425JYItFuFd7AoHnMe10/gCK1c6lksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385068; c=relaxed/simple;
	bh=TMQs2ZThSKL7ZuJsmgK3ppCSu+w2q9rdEEkumpq08Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uv9oKVrnmCkXgojGvG8vYOWveao+T67r3cXet0CfzDlCW4mcRqqrEkbDnP+yBO7PAh07ycL+ZQPW8IEJar38rfWX48MGoF1wwnpk7U+1bWBBGJdswEzuCCkPiFZdFYpDtv2wqii0kfWLUpcC22Yfn9FhEA03qFP9uzy/qywS4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo0RNhTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1D9C113CD;
	Mon, 29 Apr 2024 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714385067;
	bh=TMQs2ZThSKL7ZuJsmgK3ppCSu+w2q9rdEEkumpq08Kk=;
	h=Date:From:To:Cc:Subject:From;
	b=Jo0RNhTax2WmFwOctSSt1zPguvty5QKlc+EsNN8ghhqlFc1IpV3nKEOL5QfmSJBkE
	 3XqnOakkbHXNOpod4aW0HZMchYWg7oC1qnO43EmKAu93k4JQTdJOOToiV3tFX3vLUU
	 hVdkeMz6z44Sv10RyKzVN0AhSdjDK4qFiF420YHsQEHlzBVqzvpBqUlTXBMwUobmUJ
	 LenNHvtmSxAIHa3BvmvJTPWy62yWcY0cjr2fMDRwyhSaBraMScD0PElUiRN8k9O+SB
	 hjqlNGO9ywaLa7XATdi7/m3SHwmjK2fQu8viH73USz8BfYpIBVysa8LQf84ZRqPXWh
	 mVjiOfzBvUbnA==
Date: Mon, 29 Apr 2024 18:04:22 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs fixes for 6.9-rc7
Message-ID: <Zi9wpiog2uo1wGBb@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linuxfoundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.9-rc7?

Here are three fixes related to EROFS fscache mode.  The most important
two patches fix calling kill_block_super() in bdev-based mode instead of
kill_anon_super() as mentioned in [1].  The rest patch is an informative
one.

All commits have been in -next and no potential merge conflict is
observed.

[1] https://lore.kernel.org/r/15ab9875-5123-7bc2-bb25-fc683129ad9e@huawei.com

Thanks,
Gao Xiang

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.9-rc7-fixes

for you to fetch changes up to 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606:

  erofs: reliably distinguish block based and fscache mode (2024-04-28 20:36:52 +0800)

----------------------------------------------------------------
Changes since last update:

 - Better error message when prepare_ondemand_read failed;

 - Fix unmount of bdev-based mode if CONFIG_EROFS_FS_ONDEMAND is on.

----------------------------------------------------------------
Baokun Li (1):
      erofs: get rid of erofs_fs_context

Christian Brauner (1):
      erofs: reliably distinguish block based and fscache mode

Hongbo Li (1):
      erofs: modify the error message when prepare_ondemand_read failed

 fs/erofs/fscache.c  |   2 +-
 fs/erofs/internal.h |   7 ---
 fs/erofs/super.c    | 124 +++++++++++++++++++++++-----------------------------
 3 files changed, 56 insertions(+), 77 deletions(-)

