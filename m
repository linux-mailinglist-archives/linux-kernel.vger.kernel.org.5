Return-Path: <linux-kernel+bounces-62955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63763852861
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C1428213E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12307125D7;
	Tue, 13 Feb 2024 05:54:33 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9711724
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803672; cv=none; b=fPmZckGeEbMUR4/+WGPjfYV9pDYHsRJrMQzFh/QhioCHdnGWngqBo6v59kpkRH+dh+66zY6/5KlnohaU7Pfc1fGViPBQEmhyF7TVBgzTIuVVvXA6/rdj2Mw3P0whXZsFCIl2PmZ1+3FD2PK6skul5q65hVvVbidS3At5ZIQTi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803672; c=relaxed/simple;
	bh=YEAhsWIB1r8/9ua/DG5w6tONOQzGQ2O+bj237UZN9sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyVNk7g3hM/+cB8+NReJtH0oYhh4Kw5u/DgmfnOfIORJq4R1Bieju7QLdkjeiiLz8r4Z9LRge1iUD3FTVK46ORqsELy1MqWb4WazVIq7MeNdFFyIQjmmPjecaiLvKEIthyfkQJ2ocWCp++gCyVAfbdHXJy3zKgu45cfcb/kEsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98A87227A87; Tue, 13 Feb 2024 06:54:26 +0100 (CET)
Date: Tue, 13 Feb 2024 06:54:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Howard Yen <howardyen@google.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems
 per dev
Message-ID: <20240213055426.GA22451@lst.de>
References: <20240208152808.3712149-1-howardyen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208152808.3712149-1-howardyen@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
> Add support for multiple coherent rmems per device.

Why?

