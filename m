Return-Path: <linux-kernel+bounces-92469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5698720D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12343B24A48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397D8612C;
	Tue,  5 Mar 2024 13:51:31 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91096762DF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646691; cv=none; b=EJ7I8JsUkud1uICA2w/z9sK0jDPX8Fqmuuqdx/AeVZh94fJQyjcsMF0dtGmK8hk/FfnemJBilYFaC5SpVEv+0n/MunfKG5SDtQiXXgKu5o9+ynYTCM7G0sph68VhhTZJlrQdM++yTXI1pJa86JtjdNRGlOrG65c+Xvuj9dPeV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646691; c=relaxed/simple;
	bh=IkTIfnCuUdfzkCQIu83TZMurI22TqEIsThsv/B2BQHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPD1kjysq1+dbyLltlRWDOSI7OU9v4CyxQCb3E40UAaUFynp6i4iuRENzXCL5V0xjp730qB5gLDgIXfICs0HypQHza3TcEplUu0KeHNsIxQiDAyZau1oiV1JITitv58aqbkiovleWuUb2TOe2N+6zxAvykSg0SWuvs5vDXQHEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81B6068C7B; Tue,  5 Mar 2024 14:51:25 +0100 (CET)
Date: Tue, 5 Mar 2024 14:51:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Message-ID: <20240305135125.GA2802@lst.de>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

The whole series looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

