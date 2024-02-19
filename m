Return-Path: <linux-kernel+bounces-70762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7F0859BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C6C1F20FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C38208C4;
	Mon, 19 Feb 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqEi6bsc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89072032E;
	Mon, 19 Feb 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323234; cv=none; b=RUO94PvLLN3WJAUqQJMqNGI4Jxs0eNoco7lgXdpG7PPEDYFjroPXXTSXsRP4PV0V6MaGaWQCFHbsxuus9OutstfCULB7Iy7GKOo0gA2kaxrtIIqf8eB2WojWN1LYOBjgsQ+5f0Tfzw2znX7os7SomwDrLcUu33gSG0Ni7K6vU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323234; c=relaxed/simple;
	bh=nwz+T+tPUvTDkHYJYlpLL/2DO2LTDQ53pHK5efARrr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHEUvJd86Xe1X8CPsH124gb39HHWgadmcHNtSHWaujjfqvJk7c4aE4Hf8uBKh/CS+R+jYSyftRCqcwKcJ2N4PEMEocXjsdzWppYOAfMcV/h3anqubgLpryXtBTcX6sOmGpQ7WZYMLNV3dGfThTOWdXTN1PkzF1NXKP1dkV+dIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqEi6bsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A28C433C7;
	Mon, 19 Feb 2024 06:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708323233;
	bh=nwz+T+tPUvTDkHYJYlpLL/2DO2LTDQ53pHK5efARrr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqEi6bscGK90CL6t2fVX0D+Vr3N0vBx6075oOw44YJyZfQgWyTDyxPgVxQqQ4YwEo
	 OG2ZhaDN2whte+SeYEHhHU3mEQzS+V6hXbXvYvMlp47h5d4NNsmoRQ16cMqHptTNW3
	 Yls7yN7L+Wxz5AQeVscHKjs05jVaItnnrGUiDIpun6jrXIqbzYL/jhXeTY6YOjwWzn
	 cqYESI48p37xxkEATtWELWuOELX3l6yx5QgK+u95hs1PdqKEXlqCYa4NJiKABeQOka
	 yvDxk5T91fmtnjCYW7UIQIXvNnqs3UhNMXICOK44/cEvhlsmucuh+5IwLmZBwiO9J9
	 fcB9a+cB5ka/A==
Date: Mon, 19 Feb 2024 11:43:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <ZdLxnXkxTQSW5pOV@matsya>
References: <20240219144423.16a76202@canb.auug.org.au>
 <20240219150629.7d45ae60@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219150629.7d45ae60@canb.auug.org.au>

On 19-02-24, 15:06, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 19 Feb 2024 14:44:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Today's linux-next merge of the phy-next tree got a conflict in:
> > 
> >   drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> > 
> > between commit:
> > 
> >   d4c08d8b23b2 ("phy: qcom-qmp-usb: fix v3 offsets data")
> > 
> > from the phy tree and commit:
> > 
> >   52cfdc9c6c33 ("phy: qcom: qmp-usb: drop dual-lane handling")

Thanks, this lgtm

BR
-- 
~Vinod

