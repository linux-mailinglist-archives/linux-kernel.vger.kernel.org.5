Return-Path: <linux-kernel+bounces-127336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB618949F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5751C23217
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0617548;
	Tue,  2 Apr 2024 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLmgLhra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E616415;
	Tue,  2 Apr 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028554; cv=none; b=lmxUX2Hu1bm2U54SGdl01Dr5+Z/DV6iq8GP0elEHTxVhM6nqmXwLxJ0dwRhbfVo6pPGG+J33hIzXGonkBRR2a+zhWlbGM+rSSHKMYTrmE0FY0D5blSJLp2BUrj8+/eyZlA/XsjcauqrQTtWFxbHF/e0M2mR665bdCjxp4hvi4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028554; c=relaxed/simple;
	bh=y6RYKuOQsgSxbPHP3Ik43Hn/qaEJ4mSoNkkT+W333oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzeZxCESZGXCWHInDnb5mJ6MOzx3oI1OI5ZE0qzbRiUHH4vr2s0li9z6L7AEtpA/wTDwisQy5EGGFKFj8flEDkw0qjn32mO6inXnU/tGx/X/XQMdKoGDHret6/jef22AHOi8Asbqhyt/mLlk/KjHqNr5i5bYOli/pyjdf6sE9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLmgLhra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E307C433F1;
	Tue,  2 Apr 2024 03:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712028554;
	bh=y6RYKuOQsgSxbPHP3Ik43Hn/qaEJ4mSoNkkT+W333oE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YLmgLhraq5I3uEJEtbnWPBq3NDfVPbIDoyovNUtPb8KG23IzTJmGk8CC40XmPpzN8
	 LXD8yRQ+9oSBXpXsIvg+4Irq0zq0cS/FUYahKzrs763gTbLSt201gJZQLcjf3x7s0j
	 16N9flHliBV6pqeY6SDWY3BGuiFO1rVX0CA2ozXbYyc5X1JvENl65qQbzdu9ZksuLl
	 2MnLUi3oNHxlgZuELOB8TiNuDbd1anL5i791iQ2E1TtwcwXRLHJZn6xuxTaq8Js/wO
	 5XJQrFrO1mUCOeaR5EU39K2AYA/a9ZO7DfguQzIgCYPV9c6oX/nt2r5MgOWw7k3DLj
	 gGJ1ApEEoBQrw==
Message-ID: <b786c895-692f-4485-affd-97d78b786546@kernel.org>
Date: Tue, 2 Apr 2024 12:29:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_st: Remove an unused field in struct
 st_ahci_drv_data
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
References: <f1804954a746e93382429cf38e4f1f9fb46bb578.1711975449.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f1804954a746e93382429cf38e4f1f9fb46bb578.1711975449.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 21:44, Christophe JAILLET wrote:
> In "struct st_ahci_drv_data", the 'ahci' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to for-6.9-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research


