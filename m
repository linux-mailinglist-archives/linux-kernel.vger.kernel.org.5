Return-Path: <linux-kernel+bounces-109821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF38885619
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576D01C2115A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CD73065B;
	Thu, 21 Mar 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tVbF/K+m"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3D3FBBA;
	Thu, 21 Mar 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011527; cv=none; b=MaXgA22mMDBVCblFEJAw4qwijwsCfmRli3PkKUEcHuwc+FKt+sKfKi1ekJXAdF7WGnu3ezePGVANjxDzWXQyYc/Cawj2JowXQIpqNWEHyNoG7PJh7JCXvE/NuEJB5MKyy8FC8i3njaRMjZYDROIkmaCeCvkccfiOhzwdZWq4Wjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011527; c=relaxed/simple;
	bh=yYFcM1R+CKcYP2mcOiIsJdEoLpQ7IPORWmvpAQ9na44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PINPLiOHVrF6i9QD9rt0nncJbYAAwaKXYgvmFxeL1moF+ipuWuNxUITq+rEsSPkynPLz+zNa0HihLEg9zUqe7J3/0595nO8abKdUAYw8+guIL0t6WywYBbLgyGE4EZyGixjFNfB0RgyGeyp4vLQcijk24AGaBAhsNbVe4NqS9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tVbF/K+m; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711011524;
	bh=yYFcM1R+CKcYP2mcOiIsJdEoLpQ7IPORWmvpAQ9na44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tVbF/K+mb0Eu9ZjnRPYA8P1LauoTkbQ7m9y5xhBYKwiY0MbG5D7d5wdnQI6thThvo
	 crN6ldRQKBhwzWu/jpmfz7YoEFn4JHzcYEEdADVTgKjh5Bm0cGR01k/U5uuyqyq6qh
	 SkxuBNNF6nD7v623YTLH6oAA4BhDd/5KVZm51AfO8wnkonnpre4Z1hXJV2srwGdp2S
	 O+YMzApCQWLjCjubGFoxxdKuXQTK5jwOhtlVLtCj/di2ko4uXORA8EqA1lI1/PfEDD
	 O5VnDPajTEPa3PBQdCwUDfcgtj2eZh4xv5XaedKn00CGd05wFpisD60LJX4izDxKm6
	 wiT0PR4ROcPSw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 001D037813E1;
	Thu, 21 Mar 2024 08:58:43 +0000 (UTC)
Message-ID: <bf15d64c-79b4-4414-afdc-56a3050b93ae@collabora.com>
Date: Thu, 21 Mar 2024 09:58:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: spi-mt65xx: Fix NULL pointer access in
 interrupt handler
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
References: <20240321070942.1587146-1-fshao@chromium.org>
 <20240321070942.1587146-2-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240321070942.1587146-2-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/03/24 08:08, Fei Shao ha scritto:
> The TX buffer in spi_transfer can be a NULL pointer, so the interrupt
> handler may end up writing to the invalid memory and cause crashes.
> 
> Add a check to trans->tx_buf before using it.
> 
> Fixes: 1ce24864bff4 ("spi: mediatek: Only do dma for 4-byte aligned buffers")
> Signed-off-by: Fei Shao <fshao@chromium.org>

Honestly, the code in the !host->can_dma conditional is probably a good candidate
for just going into its own function, as it is effectively an alternative flow for
the ISR (fifo vs dma xceiv) but whatever, as long as it doesn't get any "longer",
it's still fine I guess.... so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


