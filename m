Return-Path: <linux-kernel+bounces-96743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548BC8760E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866FD1C21C87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38FC535A2;
	Fri,  8 Mar 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OXGX5psa"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2932263E;
	Fri,  8 Mar 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890042; cv=none; b=TvIXxUUisgHqxGe7e3gLz4EpDOAuj5Yb2zELGq3s2rGCZeJqtLnw8Jp5txFkemoOr436XDEacbk/xjyoZQqQlWmYSCCMU8GBxPrCLg2EAjP4ZPPWDRUk2gDragKPEG3qpdtEqyBBLWgf7kPBzHxfy5oHve7EmvwIAEzbAhNGDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890042; c=relaxed/simple;
	bh=Hk0oseGNqngUA5Ryai/7LoOmEnDwbx2brLZDTUEwJYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHX8HGJcJqsXioJaKyJpxS4V5aXU4l+ZewHy6D2EQhrMxIFXvVZbrdC4ngM6zUXOwZ0x2snfuE3SJNAB+O1yZO1EHyGWoWiWuTwn5roHRyycvbfB8C8BZrsCarI9BC6ttlTCPtpsS/wyWeGcf+dy+cYikPxfltS1irPao+a5aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OXGX5psa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709890039;
	bh=Hk0oseGNqngUA5Ryai/7LoOmEnDwbx2brLZDTUEwJYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OXGX5psaWoyzTVVTM+4gWxnnOSt4DGK16dDRK5oYsBYEkjClepJ9RsVV0Fmf6sX0a
	 2g1NaWC56V3D8HPX25CvEF9xHnmc6G0cxKIUdJUuGaGQ/LfJsTP2yzDXeYqUheds5l
	 pL6ITAub1TTK3guyroG6BUEI5vZLsGvgT1lQFAHETc1zYXj37NJMgeRoH+jqz7Xbvr
	 Yj8wKwlGdDgk0bW7bXySo6J+VQ9s72TSmITRNPsej0rScKG7/GM/ZhCdaTs2cKwO2h
	 /sI8DR2nSShstbb9nt9IGWgG2GjA+76AJWFyq/JhTqNXB4DseZ8pFeHxJnRr0vDojE
	 0Pr5n8ppiYi3Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B9A653780480;
	Fri,  8 Mar 2024 09:27:18 +0000 (UTC)
Message-ID: <86ec5896-8498-49fe-9d1b-546f5ed26006@collabora.com>
Date: Fri, 8 Mar 2024 10:27:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: mtk-sd: Remove unused of_gpio.h
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Axe Yang <axe.yang@mediatek.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20240307114348.3643034-1-andriy.shevchenko@linux.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307114348.3643034-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 12:43, Andy Shevchenko ha scritto:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



