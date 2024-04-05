Return-Path: <linux-kernel+bounces-132517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069AA899622
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0332825DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04682C1AA;
	Fri,  5 Apr 2024 07:03:03 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC128DA5;
	Fri,  5 Apr 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300583; cv=none; b=pe1WbEtIr8rPSvdjU7hIULOKNZFwwgTFRgn57a2vWXCGSDbTTbxk/F/u9UmGvWEcqeSJ5NuFag4TN1/p88ae3dGfV+VROGHGsw58W8GB56lpSF45jcPcUILvBTsEra9EMwL8eFa7MowZ3vceCLbfNapoGWqo+2/oe9SudIngSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300583; c=relaxed/simple;
	bh=Pe1ZdIJ1Ge7p/hJMEcIDLelR1kOBCzsOlZoeXMsQ8Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQuxWMIBUKzxOJBXSSvOkvJ6HQkuaHmG9cC5aVbUiHsRZzhetkf+HoFqfxIoXoVEIuMVmthHAYX2VNVu23i7Xhw8X5lMhrGMVVrMV4JqlQ56CFvb3gD728jif7jxkVPQb1FLjt1ImhGnsiO3LV3+vwNRtPbR8hagd7Z2Pwp9Po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 162F868D07; Fri,  5 Apr 2024 09:02:59 +0200 (CEST)
Date: Fri, 5 Apr 2024 09:02:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Blake <eblake@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240405070258.GC4176@lst.de>
References: <20240328203910.2370087-1-stefanha@redhat.com> <20240402122617.GA30720@lst.de> <6yjbfcrsmdmibrfs2pcseehrcbjkn67qzanyhlrduocguqvoaq@jjwntpqtsmpc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6yjbfcrsmdmibrfs2pcseehrcbjkn67qzanyhlrduocguqvoaq@jjwntpqtsmpc>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 02, 2024 at 08:31:09AM -0500, Eric Blake wrote:
> As well as my question on whether the community would be open to
> introducing new SEEK_* constants to allow orthogonality between
> searching for zeroes (known to read as zero, whether or not it was
> allocated) vs. sparseness (known to be unallocated, whether or not it
> reads as zero), where the existing SEEK_HOLE seeks for both properties
> at once.

That seems like quite an effort.  Is is worth it?


