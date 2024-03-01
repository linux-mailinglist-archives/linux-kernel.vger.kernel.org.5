Return-Path: <linux-kernel+bounces-88419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92C886E153
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796C31F22F7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1C4086B;
	Fri,  1 Mar 2024 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wttwjfL8"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59A3FBBE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297534; cv=none; b=se16FQd4E5lynKL2LmT4/Os/bZkv0odoIdXFDL59vxf1IDjqzbYqPGDsITsow3AEZTaQaAdLq8fS4CNbj5Njg04tZsHowg5HlYsOQ0Xk10hNmC1aLOQVwuV8SLsjqD29ztMXR/LluBjXDEtdzhC3BuP6vlZl1SEhmqb2Te0wdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297534; c=relaxed/simple;
	bh=lNMKwH9kfeIeAtz9gbPDS0KIyL8hy2deaf0JVFtvNSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN8/nc0n8pzRyLe9f/XN8gTRFkC3L/Mp4GFxRCVHoAe55jTqQgOYyiSK9YbwVGJMFi4RjMyi4K5rwBm+Ln1aLTy9YQrBGbC7xTM6KifF4qJBfLXl+dsZiVeAraePMkMWPMVXcugJP93o4zsdbp2EhdqdcutOVJqKIwdC2n5MfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wttwjfL8; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 417621C303C;
	Fri,  1 Mar 2024 13:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709297531;
	bh=lNMKwH9kfeIeAtz9gbPDS0KIyL8hy2deaf0JVFtvNSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wttwjfL81Pk0FZW1MXub9vFYAMrhmcPYny+VaZPomwFQqL+1zh5AVg6er6hG1VjtU
	 eLfUUrFUn+VeJazUyEQZYmEZ0mIgVYlhaL3HclgJ2nXcvapTRXmVmY4SzuSQtl9G9q
	 o3cFxEBUZ6TwxhN904sDRz4BjmFvASp4nhBD2kh1MdAbx0S9GJw2oZY5pN63hK4IeW
	 Y5G/L+QVlkS9GFPtBNA/cMfopNfmLK2hFq2X8cbsXmNOWkVMRzkitv5d801SKHb9tn
	 b/SCgdqEC5S+A9Lp4Fns2oarpv+ImBXWFxJ38eEoXqrHT91QBf0Vp5YKfwACPs38Za
	 PNJb5HJyITH4Q==
Date: Fri, 1 Mar 2024 13:52:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] [PULL REQUEST] Intel IOMMU updates for Linux v6.9
Message-ID: <ZeHPejP-_0DTWwIu@8bytes.org>
References: <20240227021441.50434-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227021441.50434-1-baolu.lu@linux.intel.com>

On Tue, Feb 27, 2024 at 10:14:33AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following changes have been queued for v6.9:
> 
>  - Add rbtree to track iommu probed devices
>  - Add Intel IOMMU debugfs document
>  - Cleanup and refactoring

Applied, thanks Baolu.


