Return-Path: <linux-kernel+bounces-133437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B789A3B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5185B1F25BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFD171E53;
	Fri,  5 Apr 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucnfn771"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5F17166A;
	Fri,  5 Apr 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339311; cv=none; b=XYQw9iPZyeshD5Ilqpf0c1G2n6jp6APpHKOwA35hxK+CeBA1E5cr3/4V0Hd/QklglTDZ0agBi0A5fS/b1e2VQ5xTrDFD3Y+S5Ej3wrGvamIuWwECkIvMRdtykfF33cpZ50QXnlzy8bf1NCMV8pcii0kveLGWGGXGB0ZSYi9Sfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339311; c=relaxed/simple;
	bh=A1NgwHDC10bWTRgwQyvwKCoHXIXCNqeJgjkafa3KT18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqkSZtZTKelLE1gS9V6Oyf4Wg/aOD/Mnw7Zbpc5nrICX7qEKxbbCRLFR08LwjY/U8IZRsa72WhvdfnGakIcRIU4cbICxUezK4Q73YmnhRS6mtQ3ND5albM57TIwiV++xxx8XGrCi/avbY64WqGp5ax2ZUWp3jWBwHvhH85LFmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucnfn771; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68F6C433C7;
	Fri,  5 Apr 2024 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712339311;
	bh=A1NgwHDC10bWTRgwQyvwKCoHXIXCNqeJgjkafa3KT18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucnfn771Ryd5ttTlvciywI7ENwjrqduaU3SeGiEkUwStAa5ctf3XgOxobH1baTLY4
	 aa96ZguC5LHPeBBGIQama4tYctpn3rhX32rPuX0llaiLmlSJggidop0RxcypM5P1yX
	 hTer+LQ4mzt3JlH7NPos/+zxmkNIvVRrjkPyYlb5vRIIjs7CIt8nDa6UIshLXjg7Z1
	 AB1yjzVPamX96NFCMY/9HoAiMTUotr4JRG7Plrx+7o3GpDWcRxUv0wW25dImB7R4Hk
	 1g0dsmQ5Eqw0pv9eHb4GcrhLxwx82uTi+140Y4C/vrlveUrEWaEQS+laNLwzhf4a3V
	 9z6cX2bN16Psg==
Date: Fri, 5 Apr 2024 10:48:29 -0700
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
Message-ID: <20240405104829.2ba1a3b1@kernel.org>
In-Reply-To: <20240405083827.78cc1b20@kernel.org>
References: <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
	<20240402184055.GP946323@nvidia.com>
	<83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
	<20240404183305.GM1723999@nvidia.com>
	<20240404125339.14695f27@kernel.org>
	<20240404204454.GO1723999@nvidia.com>
	<20240404143407.64b44a88@kernel.org>
	<20240405111306.GB5383@nvidia.com>
	<20240405083827.78cc1b20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 08:38:27 -0700 Jakub Kicinski wrote:
> > It is really strange to hear you act like "Meta doesn't need
> > provisioning or tuning" when the NIC Meta uses is *highly* customized
> > specifically for Meta to the point it is an entirely different
> > product. Of course you don't need provisioning, alot of other people
> > did alot of hard work to make it that way.  
> 
> :) When you say *highly* I think I know what you mean :)
> It'd be unprofessional for us to discuss here, and I really doubt 
> you actually want to air that laundry publicly :) :)

Maybe that's unnecessary air of mystery. Long time ago there was 
a concern about impact of the rapidly developing eswitch offload
market(?) on FW stability so a requirement was put forward to 
*compile out* major unused FW features. Such requirement is no 
longer in place (or fulfilled) largely due to my support.

I wish I could support that out by referring to the OCP NIC SW spec,
by it's stuck in "legal review" of one of the vendors for months.
I'd like to ask that vendor not to pull up the ladder and let everyone
else enjoy access to NIC requirements and recommendations from Meta
and Google.

