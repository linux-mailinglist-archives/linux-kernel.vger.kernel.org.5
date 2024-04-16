Return-Path: <linux-kernel+bounces-147085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E013B8A6F41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5581C21143
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D013119E;
	Tue, 16 Apr 2024 15:02:31 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD812FF80;
	Tue, 16 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279750; cv=none; b=KeYQgVnjOqLHtk/M6rLwvi+PZkPNl3QuAN6PZiHLmvj4jj0gdzIqMaVUcMCCoElW+B2qaQjQM1kViKuKdE1aQIDcWpGEIfl82ilrQabpNJYj/kjzziQgTl2Jr0S/YGS4DmqXNB1rSdWbLtVihQJDpcEXkW+Wcsc+y6q/98WvzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279750; c=relaxed/simple;
	bh=8O5iFBeUHGGx2cXDqPCK5LOMqOQxw0ZTW+kxgwZ7cWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDzNJpgK2iXLz5d7DFdU9Y2SSWuWoLa8juCMxlqw0aXKEd2opsfvVf+C9qVWtVpPxCBygb/bea5LL6v+kFuMDZIdL8oqkfIlPUDW5f8Fui6RlBN8x8FlKwsSqJZevIAJG9EN2EDDmjVNkuLPSBCPRUA7eEhrKwxHBh7H5srZ9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CA2068D09; Tue, 16 Apr 2024 17:02:16 +0200 (CEST)
Date: Tue, 16 Apr 2024 17:02:15 +0200
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>,
	Saranya Muruganandam <saranyamohan@google.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"tj@kernel.org" <tj@kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Message-ID: <20240416150215.GA27362@lst.de>
References: <tnqg4la2bhbhfbty3aa74uorkfhz76v5sntd3md44lfctjhjb7@7qbx5z2o7hzm> <20240410233932.256871-1-saranyamohan@google.com> <zvmwp3n3yx55ogzb5gtfe2xdmsg53y3umgnezcwd4weq5vloru@w6qi7lfvezls> <cbcf7378-e889-489a-92d2-1feb112cff58@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbcf7378-e889-489a-92d2-1feb112cff58@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 16, 2024 at 09:10:10AM +0000, Chaitanya Kulkarni wrote:
> which patch is the final one ? Is it this one or the one posted with
> title :-

The correct patch is still the one I sent on Marc 28th and not any
version that reattributes the changes and moves the flag into a totally
weird place.


