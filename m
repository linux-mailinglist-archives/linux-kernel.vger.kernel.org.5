Return-Path: <linux-kernel+bounces-92476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A48720F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDED28289B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8838662B;
	Tue,  5 Mar 2024 13:56:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA3762DF;
	Tue,  5 Mar 2024 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646960; cv=none; b=ryKY7NHJhsihPLeOnaFlmXbWutx+clYIIeT5GyM9ZQo2IDwPq5nsMb1SkKlpyHsiTanxhed6ODIJMFVM019lrTVs7LTAd2QdpvNcFFq9RhZSaWuWQRGqOWKZKy/7NGm7Zg4Fmxpc5X2QeyGlVsWP05zyVQdf3U7kiF3ZfS1hEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646960; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJiTTbHYp4gju1wquNy/UZzXKjJG5NtUX7DfR3PYuOpQqEgIYF9H24iLQpSAP5ThSmJOq7OV1YImCf2kdD1zt6dePUtXGw1EByIBM7hB8kXNmZucZojoA0ykAXSXDVkliWumezYEZd+WthJT75JwFulRHNBWR7XHk7jWdsoZPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 271DC68C7B; Tue,  5 Mar 2024 14:55:55 +0100 (CET)
Date: Tue, 5 Mar 2024 14:55:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: axboe@kernel.dk, min15.li@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlemoal@kernel.org, hch@lst.de,
	yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
	yi.zhang@huawei.com
Subject: Re: [PATCH] block: move capacity validation to blkpg_do_ioctl()
Message-ID: <20240305135554.GA2859@lst.de>
References: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

