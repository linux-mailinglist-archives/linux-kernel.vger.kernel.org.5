Return-Path: <linux-kernel+bounces-132061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A2898F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAFAB263B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB213473D;
	Thu,  4 Apr 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWYsq6cd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3412EBD0;
	Thu,  4 Apr 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260421; cv=none; b=fft4hJC/Y5YkBjjaS0EW5uXH0+77rPB8X5AJEJmgy1/h3n11LzBJDtWx3W48Wmv7zXI1TfvfLB1iSc9sz3NUKU01Z2sWT5yqzdRpIFaKBP1yDVDgyglkOw60X0VNeHNqudXa4B07pzzQWfDOEJCrZleU/yrxIkd6OzJvAlatL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260421; c=relaxed/simple;
	bh=0dykGMEIzzbTlo2r7m+D7cx0I5fgw0FXn+BBmF6bBqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5Q4O0QJzXz09noioYCw6Y2O6xt647rjydkI2jxKxpatHMat7z149NjSwBeuCxQz6eSptu2bktD3humaXZKv1aTxF2kh+ri1vsv5ENT6/zGOQbWzdv7fCg2vlsUp/jsp2xg5pWreF5nKPQ2xX9zMN7U6XHMsEtaG+61ozUsOtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWYsq6cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C218C433C7;
	Thu,  4 Apr 2024 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712260421;
	bh=0dykGMEIzzbTlo2r7m+D7cx0I5fgw0FXn+BBmF6bBqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWYsq6cdE8XB4cOK3AWiv8n3QZ7i+7Ni1D2SBgpPsoYmtOFo/K4li1lmayQOYqU6q
	 yjJTyvuJ5jQ+QyIfywyVFnIBRMS+2hpTwxhuyw2AAJ/3mpZNLqL2kUWAup5M/JCwmW
	 GfkQukIkoYzg/l4zheIQqzIDwvb4q8PN7bQqJN88/bfgTmNecNNjN7SXZhCyMnFJ33
	 yjOhjoRGqEACQJOfyDf19bxVqjG5HrBw/1ueT4Q3dgELG190YplzvA5VKJsQtEAcA4
	 10wMY21RPYKmLtjkHEZFB0RYx8AS3+FbXAtKQ+bhfIt/25Rh6alrkzNUvICWuTt81A
	 Yr2fUEFzJTWug==
Date: Thu, 4 Apr 2024 12:53:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240404125339.14695f27@kernel.org>
In-Reply-To: <20240404183305.GM1723999@nvidia.com>
References: <2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
	<20240402184055.GP946323@nvidia.com>
	<83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
	<20240404183305.GM1723999@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 15:33:05 -0300 Jason Gunthorpe wrote:
> Uh no, mlx5 already has an excellent in-tree driver, thank you very
> much. The configuration is not changing the driver, it is changing the
> device.
> 
> Consider, I can ship unique devices pre-configured for each site's
> special needs. They still work with the same inbox driver.
> 
> In fact that happens already for certain large customers. It is why
> Jakub recently pointed out that Meta doesn't need any
> provisioning/mlx5ctl/misc driver. They just buy different devices than
> everyone else.

> Further it is really rude and inappropriate to say that some customers
> should not be able to enjoy intree drivers because of your aesthetic
> opinion of hacks in a device's design.

To my knowledge the "customizations" are mostly around fitting into OCP
servers. Those unfamiliar with how hyperscalers operate can mentally
replace $hyperscaler with HP or Dell in your message. Minus all the
proprietary OOB management stuff those guys also provide.

> Overreach. The job of the kernel maintainer is to review the driver
> software, not the device design.

Agreed. I rarely if ever comment on what I think about device design.

Discussion is about mlx5ctrl not "the device" as much as you'd like
to equate the two.

