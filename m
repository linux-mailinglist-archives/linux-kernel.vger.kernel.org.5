Return-Path: <linux-kernel+bounces-143984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60588A4063
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACC41C20A7D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F71B7E9;
	Sun, 14 Apr 2024 05:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="caLozgfT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33014A85;
	Sun, 14 Apr 2024 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713071393; cv=none; b=ZO8nrZL04IUS1jbMWMfIq/kru38CY6pd1ovVTGV/Yf5/X0Mab6yZSLIIYqU8a3kuXuj151KXxWtE0BVHpTAWgNtPxYBXehNhCpHqcvTk3CMuk+p8VBhOVPcmpojMcdDbgavSlE7rNmZk7l6iW5J9B4fb4eGKRF7nh10PrlB8KBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713071393; c=relaxed/simple;
	bh=cp9Z1qR58iSvTkoZpjiZAkmT8LhFNxcV8cZqWOs6jPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d4UuRh64mOSV0wGlzXcwfSyB8Ra7mO47EXZEegqU5B/89WouG9VTnqeU5u4TUGZhQyGAzcpAomqPkC1W+mBjJ11Z2foFnJvAklcK5Mu3tGE2yATOnGAvKnm5gsenwNL3MjU6anjmZ0QdfEOzYVm7OkQGS5SxNjFx++DsTXxdBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=caLozgfT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=tErCRvopM69cM8+J/nOOFMlKG6xN/+5DXfi5u+uW5zI=; b=caLozgfTUjlBTQOR+CDW/rSgic
	+yPerSAZs327jDZgH62n+4AT5ZeZh4sTK8x6Zh5qxUyhTMznpzI3XoZidhrKyRO+nXgI3rtfkQzEc
	Pw6Y3AwTTXF5/HEXVJGE38T1/DjTVP5XMOvy3wAEtbF6+wBYjZPTZL8HP2FVU1DlTeWawCLNkC/hy
	8ye31+qMFDvSUW/zatE7tOI6xRHN3eYpHiz/wf+Qroi8VZCb6GpasG1irnSzgVIIyfQSon5K02CqM
	Bp2RTKUGIC1t/zclOiEHC0l+0uf0DWTa1LAFJk6zlk4weYTTyq6t7T26oNvhl3AjMM+fxucdnBp50
	dUnl5G+Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvs7h-00000004dwl-0AZ9;
	Sun, 14 Apr 2024 05:09:49 +0000
Date: Sun, 14 Apr 2024 07:09:44 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping =?utf-8?B?ZtGWeGU=?= =?utf-8?Q?s?= for Linux
 6.9
Message-ID: <ZhtlGONZlLq-U0B9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 026e680b0a08a62b1d948e5a8ca78700bfac0e6e:

  Merge tag 'pwm/for-6.9-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux (2024-04-01 14:38:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-maping-6.9-2024-04-14

for you to fetch changes up to a1255ccab8ecee89905ddb12161139b0d878a7f2:

  swiotlb: do not set total_used to 0 in swiotlb_create_debugfs_files() (2024-04-02 17:08:09 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.9

 - fix up swiotlb buffer padding even more (Petr Tesarik)
 - fix for partial dma_sync on swiotlb (Michael Kelley)
 - swiotlb debugfs fix (Dexuan Cui)

----------------------------------------------------------------
Dexuan Cui (1):
      swiotlb: do not set total_used to 0 in swiotlb_create_debugfs_files()

Michael Kelley (1):
      swiotlb: fix swiotlb_bounce() to do partial sync's correctly

Petr Tesarik (1):
      swiotlb: extend buffer pre-padding to alloc_align_mask if necessary

 kernel/dma/swiotlb.c | 91 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 33 deletions(-)

