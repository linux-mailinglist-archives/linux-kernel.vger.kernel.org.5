Return-Path: <linux-kernel+bounces-137037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB5689DB73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7EC1C22CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A212FB2F;
	Tue,  9 Apr 2024 13:59:09 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248897BAF3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671149; cv=none; b=ldZeltvm18X3/K62KdVcy/RwGYR2WSvn6LSJ8kKNb0xW5AEgVKdCfJ8jhTh/ZNLempKVmkLdeo9hoaqz+b+WjAhT0efYUP8lhI4k58bIGK/AAqLztpVzBHLV1JzJwIjeybRq6zyV6CJkxxj98PnGiLxeTmARQgBw5Jcudiiu/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671149; c=relaxed/simple;
	bh=HhVZ25bmFK6NaOk9VYredBVKj1M6DjxkjjEd4lA97Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2ESKQIUBaKrVni4tB+vfJHmvSa08m56TmiVnWdk3xO2+HCLtsF68GsDRMFu1nwSJxZHlPtA3cWbnsahQVtD1M/S4UenOXf0d2DCmBxOOZBXBFScOZ+x1wty7HoHqwMgr5ImlsmtTIY80x9pGJkii5NBxF3t6wJ6G/aOBUIvVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6AEA68B05; Tue,  9 Apr 2024 15:59:04 +0200 (CEST)
Date: Tue, 9 Apr 2024 15:59:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
Message-ID: <20240409135904.GA20883@lst.de>
References: <20240409093510.12321-1-dwagner@suse.de> <20240409093510.12321-2-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 09, 2024 at 11:35:05AM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Any authentication errors which are generated internally are always
> non-retryable, so use negative error codes to ensure they are not
> retried.

Thanks, this looks much better now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

