Return-Path: <linux-kernel+bounces-117746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8795088B110
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2FFB427B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFE8836;
	Mon, 25 Mar 2024 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QINAPL/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F86AB6;
	Mon, 25 Mar 2024 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392680; cv=none; b=d41yexhOPgRQb/6nsaCnfQY2ojsuMYKFRt8OTJaSR4n6/FU1YO7kTL62Kk3kcHWjXzd+Po+6OVnbTGr4imDBugCCYRWJOcirWsqo8VO4xlc8mhuX5ycYuxHvrTSY5SSQTMMXptw1t8bfNJCs4jsmNWwYcyKPc2Cw5BFhouOHVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392680; c=relaxed/simple;
	bh=rcathOMKqwgL3fnIb19d5YUjlDdhV18RFBGuM7EUUOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa286L/GIURcStesd/cWkCkzox/qquvekMGweRaGWig+WiHsQOGmoQ6aRse4KeOopE7BlgwN1fHZDFWr+8500oG8aNh0OOYW9exxDhOTgrALNj7BQg719IBRiiU/kh2kJsM7DB0n0LtKIEbv5Y2gj/36FzY5sFxF6IbHWfBMovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QINAPL/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA8DC433F1;
	Mon, 25 Mar 2024 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711392679;
	bh=rcathOMKqwgL3fnIb19d5YUjlDdhV18RFBGuM7EUUOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QINAPL/+0VSwVi05mOvbkOKcZ2c8rYDuvAG/kR3pR/o+faOT8tEMKIFErHUwLMqWs
	 XPE/p/BKdMyutVN+HeytKCETd2Nkj1qB62WAWkwOmMQPYk5RQJLTgy1p4T2azqhauM
	 caUW2CGV8NlyFGf7rSOmbWoTsyD7lia/TTkjo/RA=
Date: Mon, 25 Mar 2024 19:51:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shahar Avidar <ikobh7@gmail.com>, elder@linaro.org, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: pi433: Fix includes & macros.
Message-ID: <2024032504-unruly-starship-3967@gregkh>
References: <20240324093201.793485-1-ikobh7@gmail.com>
 <ZgFBch_ccGnZBCmz@smile.fi.intel.com>
 <2024032520-implosion-living-d148@gregkh>
 <ZgHFbosacLDyhgaY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHFbosacLDyhgaY@smile.fi.intel.com>

On Mon, Mar 25, 2024 at 08:41:50PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2024 at 07:05:46PM +0100, Greg KH wrote:
> > On Mon, Mar 25, 2024 at 11:18:42AM +0200, Andy Shevchenko wrote:
> > > On Sun, Mar 24, 2024 at 11:31:58AM +0200, Shahar Avidar wrote:
> > > > 1. Untangle include hierarchy. 
> > > > 2. Update #minors the driver can accept.
> > > > 3. Make use of general macro instead of magic number.
> > > 
> > > > Shahar Avidar (3):
> > > >   staging: pi433: Use headers in appropriate files.
> > > >   staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
> > > >   staging: pi433: Make use of spi mode macro instead of magic number.
> > > 
> > > For patches 1 and 3
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > That's impossible for b4 to parse, it would have applied this to all of
> > the commits if I had taken them :(
> 
> You can apply only patches 1 and 3 as long as they are independent to patch 2.
> 
> 	b4 am -st -P 1,3 ...

I don't do that, it would not scale at all :)

