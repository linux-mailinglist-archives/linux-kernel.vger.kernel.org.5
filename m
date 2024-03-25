Return-Path: <linux-kernel+bounces-117679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4955388AE57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E593206AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7654D9ED;
	Mon, 25 Mar 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SEJz0t3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48B1CD1B;
	Mon, 25 Mar 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389954; cv=none; b=RYYPVl32kZLIHYNvXcEyLKjTXf15pA0F1fWSXRo9tZV580OwEKuqW93fEHGAR07xUai/OYd5/YN8HL4QJ6Et9e2Fa3bs2ad/8a4eIHj9Ljrp/YUn6OPtQord1xFk8afydNo6b9T/vHWnYdGHAWM/vK+BY+jY3ma70DqtDY0mo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389954; c=relaxed/simple;
	bh=2FhEEJT8hfmgltcOodweYD6ENZY3OnLC5d5B+MxhWik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiiOAtyy0tCwpjoYS34VA6imFtaFfsqNPVfuhnxCeaR+TcwKpImLdELbdtMHi8TD6dvXvf6TQm4Kj050kXk2IySSSIgRI4gYLzt2M6BB9Tc1rUoDx2qmdIFz5vEVgfEkJccyF+JOKvfIxO1Rmd/F003nZ4eM0mcys0WBKI+kHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SEJz0t3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A889C433C7;
	Mon, 25 Mar 2024 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711389953;
	bh=2FhEEJT8hfmgltcOodweYD6ENZY3OnLC5d5B+MxhWik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEJz0t3HLnleNzaVk0FvfdAesICgIzU4yaDpBGmLSZOvdIQM2mKGfCvkPSk7RvuW9
	 ymetZRYUB1fvWD1pshf7eHZ70WoRpvia/Lf+wvZ922Jw5+mkNjZW+hcykzZbj0NvcC
	 MZA8hca7wAhRYLErXwhvnCieIk/bigqERB59EQks=
Date: Mon, 25 Mar 2024 19:05:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shahar Avidar <ikobh7@gmail.com>, elder@linaro.org, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: pi433: Fix includes & macros.
Message-ID: <2024032520-implosion-living-d148@gregkh>
References: <20240324093201.793485-1-ikobh7@gmail.com>
 <ZgFBch_ccGnZBCmz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgFBch_ccGnZBCmz@smile.fi.intel.com>

On Mon, Mar 25, 2024 at 11:18:42AM +0200, Andy Shevchenko wrote:
> On Sun, Mar 24, 2024 at 11:31:58AM +0200, Shahar Avidar wrote:
> > 1. Untangle include hierarchy. 
> > 2. Update #minors the driver can accept.
> > 3. Make use of general macro instead of magic number.
> 
> > Shahar Avidar (3):
> >   staging: pi433: Use headers in appropriate files.
> >   staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
> >   staging: pi433: Make use of spi mode macro instead of magic number.
> 
> For patches 1 and 3
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

That's impossible for b4 to parse, it would have applied this to all of
the commits if I had taken them :(

thanks,

greg k-h

