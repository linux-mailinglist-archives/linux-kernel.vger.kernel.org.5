Return-Path: <linux-kernel+bounces-161867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B24EA8B5274
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3FAB20EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475014A99;
	Mon, 29 Apr 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf/5IF91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A5134BF;
	Mon, 29 Apr 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376244; cv=none; b=ugU0tGAkoAbQlmwUFxVBhtSS/bmg42i/9G7tBJpsCGCg5a0F/7dcXTRWP+xa01SFGnd4w7Wnhks5Wq2duzItcqNuVqfrYnahrG+57MAVZ9Ms7FFO0+UGTtumFkcPt2MFqbp6f894l57kbFSv34pDicMl78W40IIgEn6m2L+muCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376244; c=relaxed/simple;
	bh=l+T/E2tQ3axFNDQgfnua1J/2iie2FeWPG6aCz6i7QcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JM7EhlQvk4rR5pQfyyNaT2Qa1QFFxGUIgGU+DVBLaQukFhlsbx5yd5SS3GNH1iQz9kTm21DbewsdUwBxEMbF3EmEQk/lq80ioYs+Xv6mtXfxj169jBkKyHxqlDAJpTe6FhKMAH2NqGv4AIdcSEPZHrqNX7dJXwbIUYbkja7PGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf/5IF91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CD1C113CD;
	Mon, 29 Apr 2024 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714376243;
	bh=l+T/E2tQ3axFNDQgfnua1J/2iie2FeWPG6aCz6i7QcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bf/5IF91QRSbkL40chu0AW/0Ay8+RjFzhNh74SEkRJCqgbpY34scficMIqEMPoq4y
	 YEr6jiGgULNPm4a2xqxMaMJrpY4/quIj0zP7bk+f846slgOnRF7xyt2gnV1Pokt6ZX
	 fhKSeeZD0U1eCqwhDWuY7eedSbCoyNEr33GA93NvS29ck2UOdN6Og3at5+QYVJa2+1
	 cjUcniosoWg6ulhWzPdEcLhCDSV1IpJrPokIGZ9o3g2EL8cXyNAv4vbbI4Bxs7QvP8
	 JzjL4C9bkRprEMGkhBiKvcG8VfcKoC9+rPeT7Q9aarviQQKX0oT5BF8y4WSSRNyz52
	 uhGvoUy1WvynA==
Message-ID: <029e1abf-5d88-4e87-b899-e0843ed170a0@kernel.org>
Date: Mon, 29 Apr 2024 09:37:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the mediatek tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240429073240.76ee0e8a@canb.auug.org.au>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Content-Language: en-US
In-Reply-To: <20240429073240.76ee0e8a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/04/24 23:32, Stephen Rothwell ha scritto:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>    244490a729c6 ("soc: mediatek: mtk-svs: Append "-thermal" to thermal zone names")
>    a452af6b1e66 ("soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS")
> 
> These are commits
> 
>    7ca803b48945 ("soc: mediatek: mtk-svs: Append "-thermal" to thermal zone names")
>    ab6cd6bb33cc ("soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS")
> 
> in Linus' tree.
> 

Checking immediately. Thanks for letting me notice.

Cheers,
Angelo

