Return-Path: <linux-kernel+bounces-112073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF338874E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4DB22488
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658F8288A;
	Fri, 22 Mar 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AswFhRNY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546F1CD00;
	Fri, 22 Mar 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147229; cv=none; b=TfvyFE/DDTxmG60UkMUoAh9XER0kmE8uh2txlMAWyZJFg83FfHUHfGQcFYrqGxsN0auRpgDYeq3cw8ZiSYYBqZ8jymNzBlb9lgzNf5JKeBwH+bTSaX/8XARP5DKzRAW+nGFN7QskZ3g7LFoig1hPN8pca9uHpyQpI8hjQJH61A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147229; c=relaxed/simple;
	bh=HE4o6Ei+IAibzVmwUO2PTyjRZtSjmEv+wCxxrI6+tGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCEaV1ADSrgCOebHqHbtR6R215FaGqzC01Y28vCQa9iF3vV0aNzodoelHhWCwtenW/EQPf21MjHk9va4H5k7yq/eUas3mEIHZMjXNKXi6XcBdYssbiKgAyaRaNkXAihOlxgwG7JvgpXUkie/Trja7qvPd86xEoroDP6DyQpKsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AswFhRNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2945C433F1;
	Fri, 22 Mar 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711147229;
	bh=HE4o6Ei+IAibzVmwUO2PTyjRZtSjmEv+wCxxrI6+tGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AswFhRNYr0sQGvqmIWUxR0Fxj3Oi1eB4Pr7c3dHAVzm6X/Npi4pd1rTJbIWpcyzRC
	 TXX5RN0bcSKAQUWdwXGx0VMTqzCQYFDdqQvd65MFEhpBBgAT2l7IM/RbAl868tMJ+m
	 mhBZRfDgjnRALFv5b2alSOVS6vFRcoGMOAHOe5wQKTQ9biylxghalY2JIQIC+8ZKR4
	 d+VrZJwXLHMccxIpQCe1J6oFLy4ho3SSeklWF9ySaxU9EeLRXtDTlj0Y+7WhRoVSFh
	 pJfVHfijRAwfoS4Nu51qiVEuMbHtHMj/g0oTomcCo88HgIYlRpJZBWxSpt6n24gU86
	 BS+0Nn1Ci2swg==
Date: Fri, 22 Mar 2024 15:40:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Saeed Mahameed
 <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>,
 linux-kernel@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240322154027.5555780a@kernel.org>
In-Reply-To: <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
	<ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
	<20240214175735.GG1088888@nvidia.com>
	<20240304160237.GA2909161@nvidia.com>
	<9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
	<2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 15:18:09 -0600 David Ahern wrote:
> can you respond to Jason's email with the proposal for the new fwctl
> subsystem and identify places you do not agree? That would provide more
> concrete discussion points. Thanks,

Respond in what way, David? Comment on technical aspects of whether 
a common class device with a discovery mechanism and a sprinkling of
semantically meaningless fields can be implemented? Some trivial object
hierarchy?

On whether someone can actually enforce any of the 4 "don't"s, and
whether this interface is basically encouraging and giving a leg up
to those willing to be dishonest?

Or should we go for another loop of me talking about openness and
building common abstractions, and vendors saying how their way of
doing basic configuration is so very special, and this is just for
debug and security and because others.

There's absolutely no willingness to try and build a common interface
here.

