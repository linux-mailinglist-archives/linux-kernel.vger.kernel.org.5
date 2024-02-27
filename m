Return-Path: <linux-kernel+bounces-83526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D57869AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783571F26226
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6A14690E;
	Tue, 27 Feb 2024 15:44:06 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6704145B20
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048646; cv=none; b=H3sOo9V4ze1cBhhMrp96vg5SCJsYpscYumRiNOCgv/Gd3DjQR6Qnh0UUlNGvAf+ZvdlbEukFm6+LiNxwcSiwruJ+PtJ1w3ABfWH+fH2LPs4KnBIovw9Vt3HPzh9yq89a5EIQ5lA+FOhb051Iky5Jo3E4IwZW5VQ/5aZ/hVvvyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048646; c=relaxed/simple;
	bh=xnLdic9t8k8BwZ4uxqQ5LDWcx+ZN0YmCWA3CC6rDgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHS2qvAyD8/73ZH6HLRy6E3WAuLsuyBhFKAoeIlub4tSJ5Jrpxvlu1ByxZaa0sGF55ddHQydAAuryS4E8td1qa4HStA6ZlJ2Vs97QJ1Qw+0rpfnLyxfTnUmcZtLvUEL7QQECOETPSjpM9ZgArfBCSEu1HYvldHIG5bNC/s7wveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4F4A68C4E; Tue, 27 Feb 2024 16:43:59 +0100 (CET)
Date: Tue, 27 Feb 2024 16:43:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petr.tesarik1@huawei-partners.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com
Subject: Re: [PATCH] swiotlb: add debugfs to track swiotlb transient pool
 usage
Message-ID: <20240227154359.GA15319@lst.de>
References: <20240109070456.3999739-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109070456.3999739-1-zhangpeng362@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

added to the dma-mapping for-next tree.

