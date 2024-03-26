Return-Path: <linux-kernel+bounces-119241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3F88C60C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027041C65C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125E13C819;
	Tue, 26 Mar 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEDTgszZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C62233A;
	Tue, 26 Mar 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465052; cv=none; b=oDcEc7KBZ/W9E9w/0KQE/HTuMrenwrUtUSwlt1/kBIh1UPSzxYD4Foo9wug0H7DTQwtYsV73mlVXneVMUDEjzyl1NvM4P4zYxjkvlLuq56J+voSvA6/DKpxiK+TwEle5eMt+fJLt0acl+IaCI2iIx0K3lQVEs39FMdtoiFYI/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465052; c=relaxed/simple;
	bh=s9XKDoLzIfdzIZPmSDkl+/c6CzgijIpyNlXPpUChh3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAFUGpgU6uKLd4xNYb1p42Hx69B9zSuNAkJ/AcjZRGQXRHA5rqBfLm5b9apU/o1N0+LXbY9ukAMG2vXKw82sDJaBnxheRBKnp/RSYrNFM16dpuY2NeAiwOWjtK2AxNbbt1KM009dbV3O7AKKWkI19zsw1Z+DPPrVnps2ifuv74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEDTgszZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11992C433F1;
	Tue, 26 Mar 2024 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465051;
	bh=s9XKDoLzIfdzIZPmSDkl+/c6CzgijIpyNlXPpUChh3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eEDTgszZMXm/jx48aBMxaHQ+11RDtWV+qKBDXof5dvQwi2s6xF2SZ4QDvZNkIqfrm
	 ot/Ypt72jUs2sLe5XnthJfX/pZ6RxiwU+wcrFl0nbmLotrPQeC5+HzuCGZP5YBnrEg
	 0W+Cmj9hOuGxaIpTmxeH/4TpDJU9kRhD3gfoi/4ixxukxOwqoiVWYbWT2QDT7HU6zI
	 CYiLw+U3G8+I/wOpgi6D64ZL9G292gTbct4I3ZVTeMhsXQDdCnPtgvAvjVI0n23F4/
	 8hUZp4j/Rb/nElraui+g3WDNzRGRU8Jb0Xt9BebsVl58qA/d8VFuBCjbjfVG2X7IdK
	 LG0mbny1UtSIA==
Message-ID: <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
Date: Tue, 26 Mar 2024 08:57:29 -0600
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
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240322154027.5555780a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 4:40 PM, Jakub Kicinski wrote:
> On Fri, 22 Mar 2024 15:18:09 -0600 David Ahern wrote:
>> can you respond to Jason's email with the proposal for the new fwctl
>> subsystem and identify places you do not agree? That would provide more
>> concrete discussion points. Thanks,
> 
> Respond in what way, David? Comment on technical aspects of whether 
> a common class device with a discovery mechanism and a sprinkling of
> semantically meaningless fields can be implemented? Some trivial object
> hierarchy?
> 
> On whether someone can actually enforce any of the 4 "don't"s, and
> whether this interface is basically encouraging and giving a leg up
> to those willing to be dishonest?
> 
> Or should we go for another loop of me talking about openness and
> building common abstractions, and vendors saying how their way of
> doing basic configuration is so very special, and this is just for
> debug and security and because others.
> 
> There's absolutely no willingness to try and build a common interface
> here.

The proposal is an attempt at a common interface and common tooling to a
degree but independent of any specific subsystem of which many are
supported by the device.

Your responses continue to align with the notion that because the device
can spit out ethernet frames, all diagnostics, debugging, configuration,
etc. MUST go through networking APIs.

You seem unwilling to acknowledge that devices can work for various use
cases without a netdev driver, and thus aspects of managing that device
should be done outside of a netdev driver.

