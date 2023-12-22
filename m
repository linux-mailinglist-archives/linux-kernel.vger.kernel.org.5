Return-Path: <linux-kernel+bounces-9423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6789D81C548
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F0A287667
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AB88F61;
	Fri, 22 Dec 2023 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJkDZOgM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15C8C00;
	Fri, 22 Dec 2023 06:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92245C433C8;
	Fri, 22 Dec 2023 06:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703228062;
	bh=2aKIwQq/umEDuenM8m7dUne3jjX3uKKKelEsWjvNUKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJkDZOgM439J1KnAItflO+9+ac+4n9IpxtqbJ4AepiUkWeL9cm5cR8L3wmvt17sSY
	 29KE1yN+vVi44qV+wZM7SbYXF2sjfiredpWJij3sOv/DXYjbwoMfJLK2qgV5lyBxN+
	 6DMhK/JYKqK+JoszWZCDRGtAIed64+G1NyG8NWSDsPPSTz2XY3vRLfjKCe8SrJNh22
	 jMtsUCbXbUiXnYWr1iA5hVnkQLMBBlhmQI1zWrRIttCD/nw5uPxI9RK9wLJyrVeR6G
	 EXsHn49cT62oi1Bc6dncWoVqne0uzxR0uvyaHTctx2OmhBIbSVaK/S1FoAvo8YYPgS
	 Tlf0sZSxLkzSg==
Date: Fri, 22 Dec 2023 12:24:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Peter Rosin <peda@axentia.se>, Jan Kuliga <jankul@alatek.krakow.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mux tree
Message-ID: <ZYUyme40n-DRVZWR@matsya>
References: <20231222084746.3d9dcb90@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222084746.3d9dcb90@canb.auug.org.au>

On 22-12-23, 08:47, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   2e142cebb164 ("dmaengine: xilinx: xdma: Rework xdma_terminate_all()")
> 
> Fixes tag
> 
>   Fixes: 49a701d8dc1e ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 5c392d106e7 ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")

It should be Fixes: f5c392d106e7 ("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")

I have fixed that

> Also, please keep all the commit message tags together at the end of
> the commit message.

Yes this one too and pushed out

-- 
~Vinod

