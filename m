Return-Path: <linux-kernel+bounces-9557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C981C77E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02C51F260C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289EFFBE8;
	Fri, 22 Dec 2023 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbauCZsW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2BF9D6;
	Fri, 22 Dec 2023 09:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C1BC433C7;
	Fri, 22 Dec 2023 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703238307;
	bh=xZfg4L5TU7fI1+1+F6mSp16buS2mVlhYp0S//OYZt+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbauCZsW3Gu1ZFsRvqmf+PIh0wkQoPpdwzr3/LbX5jf9pNO/yIKlnLV32thjaOzOg
	 qWFKljJZdvRQTfmmFjcJSfWO7do9VSO6pb8fZ0rUjCEgrZWOgMKpFblV6X2LXHwlHp
	 JGXDEbvN2K6/YfzmlfBdJSC/Tp6aeaUBrpBWF/+f2mUKXLPnejHAmPRkuQwzt29gDj
	 O9rBwMmfqewY/Rr8SJF6mL2mW1p1TnqwpLf/bFkf7aacQT4N4LVAeXYOP3e1A8fd/n
	 WKKt3hs516tKemejFCvds27UXUq6mRkIgTAQwJuCobJa300ZBDZHdH7w0CmXNRr5D0
	 qeuUG/kg+23sw==
Date: Fri, 22 Dec 2023 15:15:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jan Kuliga <jankul@alatek.krakow.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the dmaengine tree
Message-ID: <ZYVanXOKpWQLLyES@matsya>
References: <20231222142956.3ee9749f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222142956.3ee9749f@canb.auug.org.au>

On 22-12-23, 14:29, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the dmaengine tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/dma/xilinx/xdma.c:729:1: warning: no previous prototype for 'xdma_prep_interleaved_dma' [-Wmissing-prototypes]
>   729 | xdma_prep_interleaved_dma(struct dma_chan *chan,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   01e6d9076561 ("dmaengine: xilinx: xdma: Implement interleaved DMA transfers")
> 
> It should probably be static.

Right, fixed and sent the patch

https://lore.kernel.org/all/20231222094001.731889-1-vkoul@kernel.org/

Thanks for the report

-- 
~Vinod

