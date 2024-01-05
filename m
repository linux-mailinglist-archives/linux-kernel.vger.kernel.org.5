Return-Path: <linux-kernel+bounces-18037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69952825798
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED579B24BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA32E84F;
	Fri,  5 Jan 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GpoXbipc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B42E822;
	Fri,  5 Jan 2024 16:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E77C433C8;
	Fri,  5 Jan 2024 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704470537;
	bh=I00YE3KJX69lMrj7D2K+3mu4psPeup+MwSZMNe3Ij90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpoXbipcMcRM8V/QqRqtFKo1OLm43rlP2f8//MS5FHRp/N1UdEkfQw1QooamUIiGn
	 oua6gZPTH/hCAzevxOBNLoTv7DKtVguBm+xISdXaKTnl7IpA4+r70lprfZNjyZs8G2
	 lP1yCpl/AsZy2r1FnXWZa4Uvmjtg6Gx3TaebZIAg=
Date: Fri, 5 Jan 2024 17:02:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: make spi_bus_type const
Message-ID: <2024010504-smoked-fondly-e38d@gregkh>
References: <2024010549-erasure-swoop-1cc6@gregkh>
 <0fcee73a-bdcb-41d5-b6e5-21947ae9e3d7@sirena.org.uk>
 <2024010554-unreached-colony-96dd@gregkh>
 <50ecc7bb-50ac-4846-8a6e-fad9148c948f@sirena.org.uk>
 <2024010511-wrongness-ashes-f540@gregkh>
 <a58e56bf-22e6-48b6-a70a-2acd3e6a482d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58e56bf-22e6-48b6-a70a-2acd3e6a482d@sirena.org.uk>

On Fri, Jan 05, 2024 at 03:59:04PM +0000, Mark Brown wrote:
> On Fri, Jan 05, 2024 at 04:51:04PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Jan 05, 2024 at 03:45:37PM +0000, Mark Brown wrote:
> 
> > > so not actually a core thing, I have to confess I didn't notice where
> > > the assignment was when I glanced at the errors.
> 
> > Ah, missed that, as it was handled by this commit for the i2c tree:
> > 	https://lore.kernel.org/all/2023121942-jumble-unethical-3163@gregkh/
> 
> > So just hold off on this until after 6.8-rc1 is out, or I can wait until
> > then as well if you ack it and take it through my tree.
> 
> It's OK - I can just drop it in my queue for applying after -rc1.

Wonderful, many thanks.

greg k-h

