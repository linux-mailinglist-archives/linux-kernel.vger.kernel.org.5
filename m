Return-Path: <linux-kernel+bounces-118493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0D88BBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CD21F3AC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C613440D;
	Tue, 26 Mar 2024 07:56:12 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347B4CB2E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439771; cv=none; b=QJerXt4IBhFAS/AZQ59FZeZnJaKNK0tCjg+w9W/IFmsHDyOY29g8Vk8c9ozcX36J+4D5ABLOl80Q5bTPRSeJ4g9prEtGVpOl0xOW/oKJCRQu6H4cOIDynJaBik0oJmOoBBTliXqYdhlHiKpdXbVwtY05CjfmIKHtjCh1sEZZ+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439771; c=relaxed/simple;
	bh=3YTzaVmBJ0ehsjB5/GHgxAjlefKz0c3u6he9e73Froo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJNzHPW68rGyRLH52EjQCRummFcp5GxPfBSdDnD+MTAHhOM37NJQhN16hEm75A9ufl/a1Dfynt9CyvqO3NFqILukqAcjntBncnkEjvUJO30Z3liwiLpHG9LVS/u72un5uQxYsmPiT4ra4pYnDT5CKIxnYJ5BHU07nuHur1D2GfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72D5768D37; Tue, 26 Mar 2024 08:56:06 +0100 (CET)
Date: Tue, 26 Mar 2024 08:56:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Will Deacon <will@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: Re: [PATCH v4 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Message-ID: <20240326075606.GA10489@lst.de>
References: <20240325083105.658-1-petrtesarik@huaweicloud.com> <20240325083105.658-3-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325083105.658-3-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 25, 2024 at 09:31:05AM +0100, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Introduce an ASSERT_VAR_CAN_HOLD() macro to check at build time that a
> variable can hold the given value.

This really should be run past whoever maintains build_bug.h and
also cc linux-kernel.  Please also split the addition and the user
in swiotlb into separate patches.

I plan to pick up patch 1 for now, and wait for the discussion on
this addition.

