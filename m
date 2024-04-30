Return-Path: <linux-kernel+bounces-163235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C7F8B6782
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABFF1C22482
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36A8F44;
	Tue, 30 Apr 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr5M7pOO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF096FB1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441004; cv=none; b=dZQN+qCJi3c7BBpCzMyhmh//4ATpRFIC0WnpF+CWJKkl9hVUNw4XDHaH+F+X2JK3KUaAzI7Q5D4qDBQonaYZJgSaXl8Z9OJhXyxPHNKsLab8NUpIE/Z/Vp//Y6qFetUy+he1G1f191bl2QAHrK2Qc9i6egCq2OQiCNaRL0dGl9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441004; c=relaxed/simple;
	bh=mVcmTJsMYMKlu2CEhxqvW8EbnV/xdv0h/ksE2lB6FMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFfO7KYlRJxJ9elXhOJga1at3OiaTXcoAmPVldQUB8aWt0r5tvfDiKqkn/s7Eaf7ZhSwUVMK+/fQZXa+QUviqy0qPx2H8B42kcI7eYKXblnv90StEb81De4GSCdh9UcU9gT9tU0P5sVhWLZbl0JMQWmgZBQgv/EfIdStePxe6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr5M7pOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4152C116B1;
	Tue, 30 Apr 2024 01:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714441003;
	bh=mVcmTJsMYMKlu2CEhxqvW8EbnV/xdv0h/ksE2lB6FMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kr5M7pOOWkoVTDDzlwWKOVAEjfXcZ4tVYMBkbW9coz/ZwEXRiLOA47IgPtf6T6AqO
	 zAQ4vRYpeaDa0hBkZIkxcGeVDW4AOIzuCMv+7Q43K1qP56upsW9U4+3SCWSNb6xfF0
	 xpf9V31d2Oy2ifvixZsgU685O73YdqDexri/M1YmTsUq+fonPylmIVeWhERtVXHmmi
	 GMtZQYJKyzV7vIGr8yjLizm3jex8bKlF7Z23nB+Kjy/SJfmHfOzlEyIb4fuybNf+8H
	 MhpKd01fxPV0vT9+Dx6uAGuq3YLHZtWMzRiYlg6OCfiI8yz9ByGPITIJdjMLwnN61I
	 jZVOcUObkx6ng==
Message-ID: <2d6b0455-4d82-4bed-93f1-40255641548e@kernel.org>
Date: Mon, 29 Apr 2024 19:36:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com> <20240304160237.GA2909161@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240304160237.GA2909161@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/4/24 9:02 AM, Jason Gunthorpe wrote:
> On Wed, Feb 14, 2024 at 01:57:35PM -0400, Jason Gunthorpe wrote:
> 
>> I also like this, I don't want the outcome of this discussion to be
>> that only mlx5ctl gets merged. I want all the HW that has this problem
>> to have support in the mainline kernel.
> 
> To this end here is my proposal to move forward with a new
> mini-subsystem to provide rules for this common approach. Get the
> existing tools out of hacky unstructured direct hardware access via
> /sys/XX and into a formalized lockdown compatible system. I've talked
> to enough people now to think we have a critical mass.
> 
> ===============
> fwctl subsystem
> ===============


The aux bus infrastructure was created specifically for multifunction
devices -- it allows a core PCI device driver with smaller, subsystem
focused drivers for vendor specific implementations of various S/W stack
APIs (IB, netdev, etc). One aspect not addressed in that design is where
to park the various drivers and extensions that are not solely tied to
any one subsystem.

Given, that how about moving the existing auxbus code into a new
directory, drivers/auxbus. From there, create a subdirectory for this
new fwctl subsystem which is most likely to be realized as a new auxbus
device and then subdirectories for vendor specific drivers for the aux
bus device. Then new drivers being developed in this auxbus world can
put the core PCI device handling code under drivers/auxbus/core.

In short:
- drivers/auxbus/auxiliary.c

- drivers/auxbus/core/<vendor>/  - per h/w device driver for managing
the PCI device which is shared across multiple auxbus devices

- drivers/auxbus/fwctl/fwctl.c   - this FW interface

- drivers/auxbus/fwctl/<vendor>/ - vendor specific driver for a fwctl
auxbus device


