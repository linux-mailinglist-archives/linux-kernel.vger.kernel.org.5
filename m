Return-Path: <linux-kernel+bounces-97332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE88768E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B01F2395B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A8F200BD;
	Fri,  8 Mar 2024 16:50:30 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106718E03
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916630; cv=none; b=YZ8f3phPv9mi54Cgco7IhYqLpOIBn4QucpAcs4TVf5x79bn5ahCIa5EJTw49zwua/OQqi4JJ8oXWAFpRdjD9h3lwYMGNahtf/Mkx5xMEWGBvPLurJcXNb3BBy+QTHph1V5V2hc8r5dMR+jHaXKUyq5kppn1sWM4bgxVmszqVKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916630; c=relaxed/simple;
	bh=i1Ee+3NTxTAHNdgHBDCqKa6qILKMpt+tuFxakbTmL34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmbkPfdBE5jLk7O1C5+0mbcrNeGpnAnO9Drb8peY4h2ChOym/QBv+91tUL206auok6VTAX3GCjqN4xy2arPQwZRijM6edSKwTgyttL8VIN4BtLoR5eMjaGNDENYyqnCi7FkK4SwYg4o7a3JKac7iPdeS2icHIH5RGPNPX1j+hAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8661468BEB; Fri,  8 Mar 2024 17:50:25 +0100 (CET)
Date: Fri, 8 Mar 2024 17:50:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings
 >= PAGE_SIZE
Message-ID: <20240308165025.GA18550@lst.de>
References: <20240308152829.25754-1-will@kernel.org> <20240308152829.25754-7-will@kernel.org> <5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com> <20240308173816.5351ea58@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308173816.5351ea58@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 08, 2024 at 05:38:16PM +0100, Petr Tesařík wrote:
> I thought we agreed that this stricter alignment is unnecessary:
> 
>   https://lore.kernel.org/linux-iommu/20240305140833.GC3659@lst.de/
> 
> But if everybody else wants to have it...

Let's get the fixes in with the existing documented alignment, and
then lift it in the next merge window with enough soaking time in
linux-next.

