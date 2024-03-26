Return-Path: <linux-kernel+bounces-118476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642CB88BB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB5F29CE16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE1131BB9;
	Tue, 26 Mar 2024 07:40:36 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B2130AC7;
	Tue, 26 Mar 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438835; cv=none; b=kWVZNeQklGz229/NmY8Il5XcuHn5AZCftXjvW3FyHCEFb+sRKhnHFdociwOwwiAY0kFBQGj8fmWcJJuTtiml4LweyzQ6vWrvakMuzIXdRKdVZB+d7cvNfpjdHP+8JOgzTZKM4L3fzbQVaKMy1IziwMA3BRHxU5LttLpoirWLd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438835; c=relaxed/simple;
	bh=E5yuhkWmq8erSJRAyHrn+s0w4HGcT3MSHJtu41phF5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8FwyHpfyHot+XFK823hxE4smsyx1ZcnVZbAQeYUV2lZKym9/8Jwj9IHuD1kO5xH8qYiCsCyppCIGbi/lk0OBGK8WVcuSwzrwemcWf9EjIWKtMvhyMfahhKloNbbEm1uc3KLrhPpceo+xymoMFr0nyja10oPccIo6/rIVjXgexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 94C7E68D37; Tue, 26 Mar 2024 08:40:29 +0100 (CET)
Date: Tue, 26 Mar 2024 08:40:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Song Liu <song@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.10 033/238] md: implement ->set_read_only to hook
 into BLKROSET processing
Message-ID: <20240326074029.GB9773@lst.de>
References: <20240324234027.1354210-1-sashal@kernel.org> <20240324234027.1354210-34-sashal@kernel.org> <20240325010435.GA23652@lst.de> <ZgFfc2b6VsX_QSu4@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgFfc2b6VsX_QSu4@sashalap>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 25, 2024 at 07:26:43AM -0400, Sasha Levin wrote:
> On Mon, Mar 25, 2024 at 02:04:35AM +0100, Christoph Hellwig wrote:
>> How did we end up backporting all these block layer API changes?
>
> They were brought in as a dependency for 9674f54e41ff ("md: Don't clear
> MD_CLOSING when the raid is about to stop").
>
> It's possible to work around bringing them during backport, but I
> preferred to bring the dependencies instead.

I really don't see what these giant backports bring us.  If people
want all the changes they'd just be better off on a modern kernel
rather than these frankenkernels.  The automatic backporting is
gettind way out of hand.  If the MD maintainers want
9674f54e41ff, maybe they can send a tailor made backport?


