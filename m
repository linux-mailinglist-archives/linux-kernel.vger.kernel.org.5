Return-Path: <linux-kernel+bounces-132841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90042899B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DC3B22816
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3C1607A2;
	Fri,  5 Apr 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRqjR1oO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525F18E02;
	Fri,  5 Apr 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313704; cv=none; b=sOMnvFYo/JU/62jzGfdpeZzAVuURg5skDb0X3FsOSM299iGLO3PrXZsplUWH19QwDZeKLGSXB0zYb+kae0rAbZ6hT31zzClAE8PJmMo8oRV1dxGV1i4UcPjziQfCa2i074nhcJRBbEX3qzddNcwyRiL/LqDfZYQAPDHIv0dHfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313704; c=relaxed/simple;
	bh=xCpACVpsGefQ3cwv4WVd0LUAr0cjofRtcGcTdFBplJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsq20I072eQLtObhMuI/w1yq3+wviSoc9s2MLsBj4ZCBA9/XBhAMnynazPcN2mn7aGCdYIHV0rvIA7jY75hRkZickPOGkPCm0qxXe+0CD7E9NHfUq/1JB0pK3e/Pf1UODWExBsyzO6RbNMkH9+dac+2LtOXPGEoOWQIt59fB+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRqjR1oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA7FC433F1;
	Fri,  5 Apr 2024 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712313704;
	bh=xCpACVpsGefQ3cwv4WVd0LUAr0cjofRtcGcTdFBplJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRqjR1oONHUB4q7mfpbgRTfbMmEvVf4fg1nV0IqVgzhYMDxI5qko2nQrRdZZeTv12
	 aAenfA8kOH6JBJcwZBfszwVjlLNgrC3SILomY+P8TwXkQp1a/oBJ0/JYt7yPpiwztL
	 VRhcE0UZdYY3w+08QyCcOpwtapyFkfvAfGX+iYeG441uvMNFFy+coplKUJj7G7hh7Q
	 +FAYOQtJ4iSSIkyfFc6VTQbu8UhrJOMSSUEmKqoWMJUWs4OwuSSo8uAkfskj9qrS9L
	 xaf31PPBfhOiGosrZdvr8gqIKGKwirMSXVz+zHUGfe8rIEz2PcvNJaD5iv9zeqCnfv
	 yeMwewkshuCvQ==
Date: Fri, 5 Apr 2024 13:41:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240405104140.GZ11187@unreal>
References: <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org>
 <20240404122338.GI1723999@nvidia.com>
 <20240404074850.19ecd52e@kernel.org>
 <20240404174728.GL1723999@nvidia.com>
 <d0b11055-1804-515b-7916-cb83a6274955@gmail.com>
 <20240404183540.GX11187@unreal>
 <d09cc7f0-3e2c-f22d-51ce-43a36412425b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09cc7f0-3e2c-f22d-51ce-43a36412425b@gmail.com>

On Thu, Apr 04, 2024 at 08:46:41PM +0100, Edward Cree wrote:
> On 04/04/2024 19:35, Leon Romanovsky wrote:
> > On Thu, Apr 04, 2024 at 07:06:53PM +0100, Edward Cree wrote:
> >> Why?  What does the kernel get out of it?
> >>
> >> Maybe *you* need them to be supported, but maybe you should have
> >>  thought of that earlier in the design process.  ("A failure on
> >>  your part to foresee the eminently foreseeable does not
> >>  constitute an emergency on mine.")
> >> If we let folks bypass our standards with a _fait accompli_, we
> >>  don't really have standards in the first place.
> > 
> > Sorry, who are "we" and what are "our standards"?
> 
> As should be obvious from context, "we" in that sentence referred to
>  the mainline kernel.  And while participants in this thread currently
>  disagree on what "our standards" are, I hope it is not contentious
>  that the kernel community *does* have standards as to what code and
>  design is acceptable for inclusion.

You didn't answer my question. What are "our standards"?

Thanks

