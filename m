Return-Path: <linux-kernel+bounces-31096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCDE8328CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158F8286B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8914C639;
	Fri, 19 Jan 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GswEcj7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F933CF1;
	Fri, 19 Jan 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663902; cv=none; b=n8PNMOQZ5s4hqlip39AeGeOjM/39EP9sPXyd95KyA9g1RlX4twwjxikTF427/4wk0oerzTrY96rVDTvJYNXleodeXhZFTDn1SiMRLi519Y7DYAMUTnJ+cbvbVQ3G9dUJRDxiocfpcGWQRjV1hClh2j3Tj/l2TA8UcahrqOkqNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663902; c=relaxed/simple;
	bh=ljf/Wx3ewcTU/D6T4Q/epfzVzKubQXgIdjGzDz6S1DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKbHA/7zlAYRR/vQzQH5yEGIuv5ju3JrsK3s90SAfhzzZ+y9wKHad2ZGAzuoooEN9FGF1ak8pgU6h11SWpjftLNPSwiVlnwkL0CH+y3yV4/hH5koLMqAzzrkjPGrBS/Gsme6U3L7wiepb3COf9WxpRq3x5mk1xYMwdOzA8smN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GswEcj7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9506EC433C7;
	Fri, 19 Jan 2024 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705663902;
	bh=ljf/Wx3ewcTU/D6T4Q/epfzVzKubQXgIdjGzDz6S1DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GswEcj7xH7uPblRC3ssUuN+JZ8yLzDxin2yqHQJsJHc31tS+KE+4w7mvkFoOhbVKE
	 t56Ef4Yno6p8CfNVXZw0bL54y+BGHLUdEdOkrEJPHy55QOULGgzPpLZz146dI6E+aK
	 4z3y4sRsbkONfaUKyh5fhU8OpEbWCiF/mX36jHO7ZSdI3/p8wV6DoL7qQg8glLvkRR
	 OMEOSSSSHX91SrVjkiUbsq95k0zpxLc5Cfhgc4RpP67ugUxifdur0ERH3UVuE07iEP
	 C+0sM6t+WU26OCuBuDGWu8nbPP5+w0YX1Vo/SdZSzNfd4AeIj1gdoCEgStXXGQtRoX
	 f4CsQCqZS6oLw==
Date: Fri, 19 Jan 2024 17:01:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [GIT PULL]: dmaengine updates for v6.8
Message-ID: <ZapdmU1vdA5BCulf@matsya>
References: <ZalezMgxAVyu5WEE@matsya>
 <20240118191148.GA3329935@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118191148.GA3329935@dev-arch.thelio-3990X>

Hi Nathan,

On 18-01-24, 12:11, Nathan Chancellor wrote:
> > Jan Kuliga (8):
> >       dmaengine: xilinx: xdma: Get rid of unused code
> >       dmaengine: xilinx: xdma: Add necessary macro definitions
> >       dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
> >       dmaengine: xilinx: xdma: Rework xdma_terminate_all()
> >       dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
> >       dmaengine: xilinx: xdma: Add transfer error reporting
> >       dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA transfers
> >       dmaengine: xilinx: xdma: Implement interleaved DMA transfers
> 
> This pull request appears to be missing some fixes for the clang
> warnings introduced by this series, which will break the build with
> CONFIG_WERROR=y:
> 
> https://lore.kernel.org/20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org/

Sorry my bad to have missed these fixes, picking them now...

-- 
~Vinod

