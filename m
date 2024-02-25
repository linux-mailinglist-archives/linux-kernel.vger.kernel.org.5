Return-Path: <linux-kernel+bounces-80075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049E862A77
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9485B20FE7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C312E47;
	Sun, 25 Feb 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7TNzUul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173812B95
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708868810; cv=none; b=DfSXUzZp3wxFGUJow+b9Psg3DLCg0x8dI8WJlGYTpw2MQDw6nQzrsWw9K5/srxiMxzIYA1KFL/NdF+zWAjsGlVxommw930P4QfsPknjkQhnzdcN7s3et6mvWDMRx5bHIXyG22HaMcE3V+PskBAnf4tqx6LsvyaYx/NeuqJb22f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708868810; c=relaxed/simple;
	bh=EKsadki2iNG4Syzhlhtr+rJTqBhxRey8Twe4U6+4Wqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GHZwbAbrZD/8D3IriaPWzhmROt2rVfnKtTTBMK2XePSmTSPq7XXUil/tmDlnaugJ9f31NnV2HzkyVc0nfn/SNpLRAB9vbrPNXNmh4F6PuyVGauNcpFBKh0FfYlLdgWqMptvtNJNcaVg4jNvdBIYQwATpwsO7C2nVsh6sh1c91Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7TNzUul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB7C433F1;
	Sun, 25 Feb 2024 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708868810;
	bh=EKsadki2iNG4Syzhlhtr+rJTqBhxRey8Twe4U6+4Wqc=;
	h=Date:From:To:Cc:Subject:From;
	b=M7TNzUuldXkWTht6AigEB7Bks3NsIrFyL7SgpQThL7YVDn/k9mxq1OdvYQ2ANxULS
	 cdm5taY4N8xIgx1des8RCFoolZZrC4dR7HP7habnfU68ktNYUs48zb7GRpB3WUSDuV
	 h0alij2IGwr8aFIL0rH7/eHoKlFcgsxmqQMBg8/LUPQXODxTvKMFl/ifDmL0dqnBS5
	 MWkLLvAbzCXjBSeDFo08+7bBRHpkxRAENgs7FJLgyfXpQvoiz7HodjZHRcQ0erNPcq
	 CR2LmgAM/RJPRE5qEGogQ9dZlAUppVekOk8vl1+YrunDv+4VKjRQwgq/ImZTgMUtnv
	 Wk6AD6fQWgXvQ==
Date: Sun, 25 Feb 2024 21:46:42 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
Subject: [GIT PULL] erofs fix for 6.8-rc6
Message-ID: <ZdtEwtN2BsCYnCeY@debian>
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

Could you consider this fix for 6.8-rc6?

The detailed description is as below and I think it'd be
much better to be landed now than later.

It has been in -next and no potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.8-rc6-fixes

for you to fetch changes up to 56ee7db31187dc36d501622cb5f1415e88e01c2a:

  erofs: fix refcount on the metabuf used for inode lookup (2024-02-22 15:54:21 +0800)

----------------------------------------------------------------
Change since last update:

 - Fix page refcount leak when looking up specific inodes
   introduced by metabuf reworking.

----------------------------------------------------------------
Sandeep Dhavale (1):
      erofs: fix refcount on the metabuf used for inode lookup

 fs/erofs/namei.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

