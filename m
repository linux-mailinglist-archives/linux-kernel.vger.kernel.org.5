Return-Path: <linux-kernel+bounces-83530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CB869AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CF3288E62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC260146007;
	Tue, 27 Feb 2024 15:44:49 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8D14691C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048689; cv=none; b=V9n6uHUeVGFcX/bqIFj3gcdQojOKoYLxATn6R0RzrnM4u/4na/2DXaCsrZHFzs7tNMQYsco4b3fZjLW88huApJ4HMfwn0MaMEEgfArcvLjwTglW8tnKjfG2OJGq07VdpqE9B4iSGPrl5PXsRDcFBtHS2GTLBQu4RzdlLGG8FFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048689; c=relaxed/simple;
	bh=xp1QTpfotzzuZ0ozNPNcLoEX9NOoIuP3P6xkVJWbeLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Thdoo8a/UX2+2ONsOW9DHobfzJI3fXw7Oo+40enR0d9LTwNssjz53haU1Ui7sL2gK1Lku4D7JU55tz9H5dAmF8WYjtG9Z4fVhm6J9NL0QRt+Z6dwmvbWyvtFyuHMjY49o/oLpc1uTj1voDnbfTKw/f9T46HU1z6TuVdRR0M9+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AB6568C4E; Tue, 27 Feb 2024 16:44:45 +0100 (CET)
Date: Tue, 27 Feb 2024 16:44:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
	elena.reshetova@intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH] dma: Leak pages on dma_set_decrypted() failure
Message-ID: <20240227154444.GC15319@lst.de>
References: <20240222001721.2269203-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222001721.2269203-1-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

added to the dma-mapping for-next branch.

