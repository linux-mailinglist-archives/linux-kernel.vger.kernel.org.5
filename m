Return-Path: <linux-kernel+bounces-98317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2648877856
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936CFB20EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF43A1BB;
	Sun, 10 Mar 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c7YNA2Y2"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DB3A8E3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710099825; cv=none; b=skhYeCVRkbkeZuWM00DAHiR0MR0E4UWTNsCq2ZL0Tigj9vxZrOTQdnAtY/G1wYZ8GzDWcyvuy8WaPmpmkfrk54KBU5704bWWACu60CLPo+9up/3gD8k+CI42T1+fdhepoit7xV5PMxzh9MyK7Tzd1lGI/wCSX4cKI4GF9hpkn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710099825; c=relaxed/simple;
	bh=/4xepVEwj5kBYcnjYzjf3rbsskaoO+unS0ty5fcobgY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LL2VfTYVQ+8fxgYDcRj/ye/66BQsjpgr3x64y9uEqFQ+7QlDYv0WDZp/vz9wqkZ88hrKuMrNWATcSlf2QbcdXQct6TMViFrdJM/RD3yA6ehyx2kiyGdkU7n/bFNtuEdFkjL3z/dDEcGnaMrusSqZKFommSPPZ8buRcgOESLQHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c7YNA2Y2; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 10 Mar 2024 15:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710099822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gv4kw/YOMo+RWvCcJBREth0vtJNopH+AnPVSqWG7pxU=;
	b=c7YNA2Y2J0CGKuDinZfsgs1uz5Ok0/x+6xaz11AzgeLaT1qzboTGz3zjD/SuulDqYjujPp
	T2f055+JDR+9mwPT6b0o0LPuatvPISLWM6zsXg6OCAbEFbSkx14R25RzhoQlyQx8YkMBoZ
	H8jVZDphnfwrhpvqjSFBpvKZnnSTneA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.7.y
Message-ID: <2zaqetj6wlxgpbxgex643dnudgwhcrz23xgfuai3t3hgavjb2d@vwhyha3hlg5y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 2e7cdd29fc42c410eab52fffe5710bf656619222:

  Linux 6.7.9 (2024-03-06 14:54:01 +0000)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240310

for you to fetch changes up to 560ceb6a4d9e3bea57c29f5f3a7a1d671dfc7983:

  bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree (2024-03-10 14:36:57 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.7 stable

"bcachefs: fix simulateously upgrading & downgrading" is the important
one here. This fixes a really nasty bug where in a rare situation we
wouldn't downgrade; we'd write a superblock where the version number is
higher than the currently supported version.

This caused total failure to mount multi device filesystems with the
splitbrain checking in 6.8, since now we wouldn't be updating the member
sequence numbers used for splitbrain checking, but the version number
said we would be - and newer versions would attempt to kick every device
out of the fs.

----------------------------------------------------------------
Helge Deller (1):
      bcachefs: Fix build on parisc by avoiding __multi3()

Kent Overstreet (3):
      bcachefs: check for failure to downgrade
      bcachefs: fix simulateously upgrading & downgrading
      bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree

Mathias Krause (1):
      bcachefs: install fd later to avoid race with close

 fs/bcachefs/btree_iter.c        |  4 +++-
 fs/bcachefs/chardev.c           |  3 +--
 fs/bcachefs/errcode.h           |  1 +
 fs/bcachefs/mean_and_variance.h |  2 +-
 fs/bcachefs/super-io.c          | 27 ++++++++++++++++++++++++---
 5 files changed, 30 insertions(+), 7 deletions(-)

