Return-Path: <linux-kernel+bounces-126934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38728944A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81ABF282C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4444F1F9;
	Mon,  1 Apr 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSldP6+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C24CB4A;
	Mon,  1 Apr 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995038; cv=none; b=dcztpc9mPi0osRQ4/ExdpTOcNf++x0H3Pch6K2lfIjsLKpXlmZPuYhRvjqfNhNgi786XjE11yWiRm57Pc4mQm+WBEoEUw6QG6JvSXwZIYhDUdoOzo15sFOkPp992OyYMHkaYGOqTyuWnwdqYq5JCk1rPbG0pITgXJwN/jMpYLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995038; c=relaxed/simple;
	bh=78DLdqeSgM1RtaWGO2k/xw8JMdBQKvp0dSS14sJVHyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1tcPCwrJXNtdV1hvc7yQeG1SV4Hn5e6ZnZxivj37V7pn/R+yWQdbk/hso0IuGZ3W03BVT9M990BmE1lvJ1o6+IjP61ZnMprBruwVpK6lWNlyk/uY1/tJXYYdpHpWL9WUWOUerKQbPjAnC+XPNbOzrfZORy6cwafhkmBktyfH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSldP6+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8D3C433F1;
	Mon,  1 Apr 2024 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711995037;
	bh=78DLdqeSgM1RtaWGO2k/xw8JMdBQKvp0dSS14sJVHyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSldP6+vCnxMNePaiRrsF/zkYBTD1yw288UTedsSLs2BFyJNzcRCJDbb9uaksUULu
	 ydGHfWTxEqT7gkeT0DI1OkR3DZhSApqnnD/sJP8ieYF1JkrNmHvzbfMXpSB5jYKVzD
	 beCR0p7YIStpOBXHEwZ3bcJFqHIBW4Tp7CRAeUpl0Zhdaq0QE4zrdKloDh9vKUv7AP
	 DUsLro/gBcz3IQvy8pyj7ozf7xfxmn2p9C8HoprVmD8xl5biBsiP+6LWdtxvNZ9ryh
	 PpRoupUtrrnuI1q967+gK6VPMHAUvc6rqj6VsNLOgn8u+4iuArLuaxVZkyhOxFFH+u
	 RT+tgNc4fYODA==
Date: Mon, 1 Apr 2024 21:10:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240401181033.GB11187@unreal>
References: <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <20240401123003.GC73174@unreal>
 <20240401075003.70f5cb4b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075003.70f5cb4b@kernel.org>

On Mon, Apr 01, 2024 at 07:50:03AM -0700, Jakub Kicinski wrote:
> On Mon, 1 Apr 2024 15:30:03 +0300 Leon Romanovsky wrote:
> > > The proposal is an attempt at a common interface and common tooling to a
> > > degree but independent of any specific subsystem of which many are
> > > supported by the device.
> > > 
> > > Your responses continue to align with the notion that because the device
> > > can spit out ethernet frames, all diagnostics, debugging, configuration,
> > > etc. MUST go through networking APIs.
> > > 
> > > You seem unwilling to acknowledge that devices can work for various use
> > > cases without a netdev driver, and thus aspects of managing that device
> > > should be done outside of a netdev driver.  
> > 
> > HNS driver is a good example of such device. It has nothing to do with
> > netdev and needs common and reliable way to configure FW.
> 
> Sorry, I have a completely different reading of that thread.
> Thanks for bringing it up, tho.

Different people have different opinions, and it is fine.

> 
> As I said multiple times I agree that configuring custom parameters
> in RDMA is a necessity. Junxian's approach of putting such code in
> the RDMA driver / subsystem is more than reasonable. Even better,
> it looks like the API is fairly narrowly defined.

It was a tiny example, which emphasizes the need for a common way.

If we were listen to average RDMA driver author, we would find ourselves
with gazillion different sysfs knobs which do nothing except sending
raw data to FW. As a subsystem, we don't want to waste our time in
not-beneficial to the subsystem code.

Thanks

