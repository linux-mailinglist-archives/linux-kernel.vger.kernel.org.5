Return-Path: <linux-kernel+bounces-46080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2923843A03
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C15B282232
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C3664CA;
	Wed, 31 Jan 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="es7soGMY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8160ECB;
	Wed, 31 Jan 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691120; cv=none; b=KwW4a481wJy48drO5yMU5CE4jclNldlWBX1SwCzvzw2JdWqnQZvG6GqB5xubXbFpGfrwv6pdp4bFaXG7uPhipvjmygf0ya20Z9KssFI5CQGbSNpReCLg5y8znltLoxGtQhHQU12Am5UkJc8rtZdcH4Fe8qmiXeWFqBsc3YlBxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691120; c=relaxed/simple;
	bh=mOtCKhhHIB3ZM5PotnN0PRvzmIAiHxDMRzCZ2IsNDCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz51kWSarFQCaP2Qfd9jdvpU+Lv1BkL1aVflaj9eVOwfUv/IKnylFBlHO32ksd6alvliMHdvBEEEuY7T17uJf8x8wr8nhbZ5VrZ3L2DvSZzdk6jLmScwW7kPr5Fk7x/wNExwUFTbOtRkxfsj2NdIJYjeWKLWLzChoV+f1WKnh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=es7soGMY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706691117;
	bh=mOtCKhhHIB3ZM5PotnN0PRvzmIAiHxDMRzCZ2IsNDCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=es7soGMY/oKsMroUJr9o7eQcx1CrEr7vxkbw0DXF0dCeGmd/FuvsVJP7pHOjZt4vM
	 cUbRRUmcF43q2xinkmJ+Q0dss23x3+RAFZbgs+Nkm7fnj98lrf0+p2JWFbjSnyYk9Y
	 hPPEWy8nUDad4sp+LCuillltJio3EW5zOiviWOwOzsY4vEpP6jHYNS90CvxNT4deSC
	 kzeXTtXMwf1eq7hJh5vTpHjOMeGuh2vhBjfKz4a3+Yi4rxZehyxImCcdDYVUfs53Rc
	 iemTjm0Bk//Vf6PMyPrrn9zg3vJuXzcySymWNTBcO6TcPOAD7wOPBnlMktCxWftscV
	 IlCp/JNjdgPHQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E3D837803EE;
	Wed, 31 Jan 2024 08:51:56 +0000 (UTC)
Message-ID: <0dd06636-7f24-4723-87bb-485b7a34498b@collabora.com>
Date: Wed, 31 Jan 2024 09:51:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: mediatek: Drop bogus slew rate register
 range for MT8192
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>, Sean Wang <sean.wang@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131071910.3950450-1-wenst@chromium.org>
 <20240131071910.3950450-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240131071910.3950450-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/01/24 08:19, Chen-Yu Tsai ha scritto:
> The MT8192 does not support configuring pin slew rate. This is evident
> from both the datasheet, and the fact that the driver points the slew
> rate register range at the GPIO direction register range.
> 
> Drop the bogus setting.
> 
> Fixes: d32f38f2a8fc ("pinctrl: mediatek: Add pinctrl driver for mt8192")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



