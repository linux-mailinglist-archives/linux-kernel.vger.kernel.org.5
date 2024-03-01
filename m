Return-Path: <linux-kernel+bounces-88603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F486E40B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E5D285CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D78C43AD8;
	Fri,  1 Mar 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="deeXjQUm"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045E63987B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305646; cv=none; b=JkeUbm89H4KhTovP72lbqszhb8WOcekd/+cu4GJj9pzABYquk+R/uQcSVewYo6XamT8slUQhDDuGtdUWfL9R6T0+h8g34wW67XlZebU3WSWF0eRtWU8FXPx7e7T6OdBKCfNWmDmQhxfaNsq6Ue0O3K+zfogrZn3XmAhgyD/9xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305646; c=relaxed/simple;
	bh=CL83DanGD/AEOLUdlbiy1Wyke3nJGd0ty89cOTE7sPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ir5ke0i/imHVPyhZMc3wPT+xVfdSuu0+179iXOURhCUBOPMBLZXXoZUgB6h+D7xSX9viDjBN8VidoG74UucGeg7ZT2uzHnmuET+xkBf7/gcB8JcFqvC5HenlQ4FdVhqpM8pXWjMN0wY1Pklp6edTGrag8CF2YrPIlAqiwYTsmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=deeXjQUm; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5E1F41C3C63;
	Fri,  1 Mar 2024 16:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709305638;
	bh=CL83DanGD/AEOLUdlbiy1Wyke3nJGd0ty89cOTE7sPM=;
	h=Date:From:To:Cc:Subject:From;
	b=deeXjQUmW1NHChIgsoRdjT6Uqy8m+SLiX5bHGgumYGWz+QxN7ahmr8Rclup1THrfX
	 L8ZbFnu0ySlQwG1X/B+RvinSvfEENB9Mapup4tawzxCrfz6G+H4qiIaIgeh3gi8T5y
	 M5AxuqWDIA+V726leT/bRyltOX6YmogYi9MdMI5JLDBIByfn5zPMTwaNh/pd5wASta
	 LtRZGr4kaq7qm1ffsTdTkQ0QZoNNDmrnUy5oqi1fQxXr0B7yxfjD+CwF5nXWP9FPla
	 4vxiyUfmFY+WNrXX+rVzT3gEAojZmPrSZM2tTaxIcootdkFliq1/OHzL/1FhsvIIjG
	 mMXK3I0DLupcA==
Date: Fri, 1 Mar 2024 16:07:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fix for Linux v6.8-rc6
Message-ID: <ZeHvJSZR_XoebLF8@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Another fix on-top of last weeks fixes, sorry for the inconveniences.

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.8-rc6

for you to fetch changes up to 6384c56c99d98c84afea5b9ec7029a6e153ae431:

  iommu/sva: Fix SVA handle sharing in multi device case (2024-03-01 13:53:58 +0100)

----------------------------------------------------------------
IOMMU fix for Linux v6.8-rc6:

	- Fix SVA handle sharing in multi device case

----------------------------------------------------------------
Zhangfei Gao (1):
      iommu/sva: Fix SVA handle sharing in multi device case

 drivers/iommu/iommu-sva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg

