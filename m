Return-Path: <linux-kernel+bounces-128223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8CE8957DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B55F1C22D87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4269212C52C;
	Tue,  2 Apr 2024 15:10:24 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63812BF35
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070623; cv=none; b=mHbFX5WgPm6UuoWcWKTUhJnxd51UVwJuicxOJ79jGy49VdgOBg2H339rp++FqG+ZhbD58eJbW6AgHDnOolbsJqhOiyOaBeaI+naJuqyl1Wm5sFGmWaTIA3zGorWXZPVakPttNh8EJJOgBt+MFrFc1H/hbl1YtwXbjLxOa8UqJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070623; c=relaxed/simple;
	bh=sRajvdrV7rqeXiMmpuswBdvcbYNZJGIC389pFfFEwCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGfNhKubjh5zZ3U0258rkeEYN+smcgz5qjxvnzq7UeQ33GhNDmmg9f0PLpwAvpFM2/eh+GS1nsLQ2JyOM9NxjGSFjgGQek1gByJnb3ecU9Y32AeSd3ohDaxekYnw/9kUennyROrwR41TroKlfpM5aIxVXZASyFzJmeoIrY0Lsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86F6368C4E; Tue,  2 Apr 2024 17:10:18 +0200 (CEST)
Date: Tue, 2 Apr 2024 17:10:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petrtesarik@huaweicloud.com, konrad.wilk@oracle.com,
	chanho61.park@samsung.com, bumyong.lee@samsung.com,
	dominique.martinet@atmark-techno.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, will@kernel.org, petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: Re: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Message-ID: <20240402151018.GB2117@lst.de>
References: <20240327034548.1959-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327034548.1959-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for Linux 6.9-rc.


