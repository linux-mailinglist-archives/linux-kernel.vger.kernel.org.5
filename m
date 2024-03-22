Return-Path: <linux-kernel+bounces-112032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AE887463
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364721C21ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53D7FBC4;
	Fri, 22 Mar 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrIh/bq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DC53361;
	Fri, 22 Mar 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711142292; cv=none; b=U/SCQWblQ1imGATMhLE29BEZmhCQTIcK7Ffeny15hhNK/iQdhUd7y9pew+30LD7FgigHyfa0vmUMiOR9iAMaqGSd4Z4+40x01zcwzqNN/zpMck3ai3q5rLulVwmPbfq3pZ2vHVcs9ajtHoD6RLNg+yRX6EOhS8eAYuREos1J7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711142292; c=relaxed/simple;
	bh=kFZLK9T6F2BY5IXIbEnxbjCGdrCaNMrsl9MLKMql/Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFBvw63Ux9gFd7sj1t16J3Z71g70oQl0Qny/PS7fd1LMMNfUw2qvDnoFy6QgUHkf4ICyrg1W3Sjdx8DhFVnUoZ4XOoje8cAo5sdxs8mBqJ991oaQbH41MJq5R4bufj0/e3kOGzspXV31ykTpjtjCHnknKhaV2T4K25t9ppRSTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrIh/bq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24A2C433F1;
	Fri, 22 Mar 2024 21:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711142291;
	bh=kFZLK9T6F2BY5IXIbEnxbjCGdrCaNMrsl9MLKMql/Pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jrIh/bq3bsQCBPY2qcuv9fQA1zE7nXDJH5pfXFLXvYy2ozcqjNyItvc7mFOb8a3s+
	 KoRFKUrSjOwzzB91ZL/anhKPjhntxmGdmAxzaXiAXWZmLJORDBpbiZbmar5RXmEZB/
	 apMYPsfeCzUjYK+eHV/2qlGjgeLzW+MnKC4qsuVyzybYZPfbg+NsfGQNKh4hSJznBF
	 gPgcb4xc5ngZbfm7qS3MQr2+pdGyFHp/B74K38+ZfpZzG1JoSXJIsYOh+A/tnQpiw6
	 vyydRh5p5wPVI4vNb2tt3SSSHdgjFXezAFUCcZEEI3A5zzI4XJfpRsVagsBdjYK+yA
	 Pu4IOaDxyeWOg==
Message-ID: <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
Date: Fri, 22 Mar 2024 15:18:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com> <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240322135826.1c4655e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 2:58 PM, Jakub Kicinski wrote:
> The more I learn, the more I am convinced that the technical
> justifications here are just smoke and mirrors. The main motivation for
> nVidia, Broadcom, (and Enfabrica?) being to hide as much as possible of
> what you consider your proprietary advantage in the "AI gold rush". RDMA
> is what it is but I really hate how you're trying to pretend that it's
> is somehow an inherent need of advanced technology and we need to lower
> the openness standards for all of the kernel.

Kuba:

can you respond to Jason's email with the proposal for the new fwctl
subsystem and identify places you do not agree? That would provide more
concrete discussion points. Thanks,

