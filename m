Return-Path: <linux-kernel+bounces-168514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2D8BB979
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F41C22ACB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244FAE574;
	Sat,  4 May 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHNArNvF"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AD4C81;
	Sat,  4 May 2024 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714797015; cv=none; b=IcSY7KcElAf0i8wufbFPqj4paW8lKFHATM7gBBIBnmTVlHjGg51+U6PuFKAU5S54H1AdcPgSUv68Zsb54HTD5FhU+a2rZZK+v7HKfLsbZtBS15UtQGsNDjmD4OtNk3DIsLqK4Nh6aZWv0V53cYstl20tBwmCZSMYUhtCh4aDyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714797015; c=relaxed/simple;
	bh=jYNsz6OVqjTGoptCZiC9/xNU+xvZbLRRi5o/NDi8IqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qgQZ4bXHvLigw3JvTqHVESvp2NyLmshOFAdLeWYdEi+N7Qhg32OfanbERsvd6rsI3SqwkneQEJ+9f+WnWvvQmizig3v21UOGBMGzAkqRiDBjdNxwFYFhtzerw1Xl8U5OlfCaxtw2b0sLWJddYFmqhT566prtB2J6p1gwigqwJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bHNArNvF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=fnDdNrTJhZMeuBRj3dTfFT3upHV1RLKoSbXh6YT8YtY=; b=bHNArNvF/BUjcrnSqlbAM/hSiP
	9kEgqllAmqqrbEz5JO+TW9eTY/BgRcPt8XpCEmMrD0iL3yzOarNoB8mepp61ZmUKSYPRUHGGbsMsT
	RVzfiS3DHy3wUJhtCLO8r01GH7JC6RbclH+L5HBgLragXn9ZdWmgTDKPxoWaQraVuyIb3XBh2Rd7q
	e03rwn47DLASxY9q/XZN+SXfxgoo7V6m/w7Gl3GvdSUrkUUaFvpzagl4UKQO6k9fi16oLcSnWxjny
	qi9LhiXMGr24IIh+3+aEsAgqn5CW8Vhuc3fz6QcZ6X9WKEvXFngfS1MdeH/cxpMV6TnWQdMnFfnHS
	z5eyj5Jg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s372L-00000001F3e-0qFZ;
	Sat, 04 May 2024 04:30:13 +0000
Date: Sat, 4 May 2024 06:30:09 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.9
Message-ID: <ZjW50TUK_CvTAXrj@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-05-04

for you to fetch changes up to 75961ffb5cb3e5196f19cae7683f35cc88b50800:

  swiotlb: initialise restricted pool list_head when SWIOTLB_DYNAMIC=y (2024-05-02 14:57:04 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.9

 - fix the combination of restricted pools and dynamic swiotlb
   (Will Deacon)

----------------------------------------------------------------
Will Deacon (1):
      swiotlb: initialise restricted pool list_head when SWIOTLB_DYNAMIC=y

 kernel/dma/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

