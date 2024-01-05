Return-Path: <linux-kernel+bounces-17987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B19825677
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B5DB20AB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA412E623;
	Fri,  5 Jan 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6z9Lc/S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B42E626;
	Fri,  5 Jan 2024 15:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80019C433C8;
	Fri,  5 Jan 2024 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704468080;
	bh=BJfr/NAghFFnbqECv5pu8D17fzlRfxtXE9hL5DIHvkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6z9Lc/Sx4ZGd6NgiFpuCHyanDx953R/XlSXJSSQXeRQ+u/txq8EdHo37DOLj8ZPY
	 PM1tNQuwDALCwdRlPPNghBD7IdzrPx2qdUBoJDHVblOdJYDP5SuOLrDiLWNbec5c3y
	 na3YId1CgbpsjAJG2NQpbqhTAXphZ7YgGn2qnIrw=
Date: Fri, 5 Jan 2024 16:05:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: make spi_bus_type const
Message-ID: <2024010554-unreached-colony-96dd@gregkh>
References: <2024010549-erasure-swoop-1cc6@gregkh>
 <0fcee73a-bdcb-41d5-b6e5-21947ae9e3d7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fcee73a-bdcb-41d5-b6e5-21947ae9e3d7@sirena.org.uk>

On Fri, Jan 05, 2024 at 02:55:01PM +0000, Mark Brown wrote:
> On Fri, Jan 05, 2024 at 11:32:50AM +0100, Greg Kroah-Hartman wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the spi_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> 
> Whatever makes the driver core able to handle this doesn't seem to be in
> mainline yet - what's the story there?

Odd, what errors are you seeing when you build?  I have had to fix up a
few subsys_* calls for this type of thing, but I don't see spi_bus_type
being used in those that I saw in my local tree.  Did I miss something
else?

Maybe just wait for after 6.8-rc1, it builds properly here locally :)

thanks,

greg k-h

