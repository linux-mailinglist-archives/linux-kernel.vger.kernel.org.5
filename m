Return-Path: <linux-kernel+bounces-98884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE28780A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3841C20F90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE33D57A;
	Mon, 11 Mar 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PfGfgQet"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5573E491;
	Mon, 11 Mar 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163756; cv=none; b=ap/6tITEmt42osGNQ/qGDikKYWghQQMVRCVgprJB0qsSHJh9saHaV33Z1b3jkqqJwmSMVkKzRY81TmzG87IK1olPqtVrQM7jSONBJnQxkPDrudnom3Uh4FRzXsOfBaHWA8Coskv5kTrtyRSVi6i2EGCgmC9MDYWaMdINmkFDIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163756; c=relaxed/simple;
	bh=qtskDbr0GRmzH7Abac91cv2vivMGRxnKLQdxYEF6sIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aubucTW4XxZOVU8pPftef5WA+dFZ2hrSjpiZy+b+oN2BvXRLQbmcg4X25OdzEJUPtFnb3h28P0Q3fWsdYxX89bn7IoV1M1H93Pklw39p1AQBVXeLyGMXMGa8qKDkc+za2Dy9xTZipf9kTLZTmmT2Q6uidc/IT5dfOZlopjEa+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PfGfgQet; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Zt+0PhFTJi/O7n8lmrcYH3hrlQAEKRRv5KT+zMKiFEw=; b=PfGfgQet4DsFdrtZgkMcBQXIQ7
	Qonw8N8tdt+YCPYDqx3m4YVmCxlqpZCtRRFzYggPiMPdzD+DDTConV9Op48pb6jNLtLlIjyJHTvbQ
	0713usiNdpmcoDjlohqUJQx/gOoELeXieqmqO69rghMT05TxW6iHbz0YRyNwJFn5Gxhwe4gTHK/OW
	eyWx8SX69mMVwm/QO9UfnVa2hKQ20oUSTcjhC0zsay3/qd3FSpL+1P7GQjRmtb6DtFvrMYRqA4MDc
	jHU0I6lRUrEonz0+q6Yr469T19B0zbxHVn72EmFp/wfLOVgtmb5dVQX0zd+JvJ0ygw8OSs9Gk15FE
	cyMiJfgQ==;
Received: from [50.226.187.238] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjfiJ-00000001cYG-1p21;
	Mon, 11 Mar 2024 13:29:11 +0000
Date: Mon, 11 Mar 2024 07:29:09 -0600
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.9
Message-ID: <Ze8HJco2qTcDcxDn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pretty light load for now, but a big swiotlb bug fix has been brewing
for a while and will follow soon.

The following changes since commit cf1182944c7cc9f1c21a8a44e0d29abe12527412:

  Merge tag 'lsm-pr-20240227' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm (2024-02-27 17:00:10 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-03-11

for you to fetch changes up to b9fa16949d18e06bdf728a560f5c8af56d2bdcaf:

  dma-direct: Leak pages on dma_set_decrypted() failure (2024-02-28 05:31:38 -0800)

----------------------------------------------------------------
dma-mapping updates for Linux 6.9

 - leak pages on dma_set_decrypted() failure (Rick Edgecombe)
 - add a new swiotlb debugfs file (ZhangPeng)

----------------------------------------------------------------
Rick Edgecombe (1):
      dma-direct: Leak pages on dma_set_decrypted() failure

ZhangPeng (1):
      swiotlb: add debugfs to track swiotlb transient pool usage

 include/linux/swiotlb.h |  3 +++
 kernel/dma/direct.c     |  9 +++++----
 kernel/dma/swiotlb.c    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 4 deletions(-)

