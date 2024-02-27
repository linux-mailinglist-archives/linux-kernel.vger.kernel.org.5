Return-Path: <linux-kernel+bounces-83286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E444586914A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200061C234A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E18513AA2A;
	Tue, 27 Feb 2024 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sUUKc/rQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427AB13A895;
	Tue, 27 Feb 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039112; cv=none; b=hchUZhFcDcu7xv9X4JUdP0SlilaL1dw6QHXlOb/TWOFo5Uc9zbj3IU1/tjMz2B3FgutO7J9bt/08YkGy/Vgq8te/u2b9pJcpawuMXzyFmVr5nFttr+zIYnpGzo7Gip36zXw1Ge3hi2CuxWZlR2nwNw++TIjYRYIPqrsG5eERStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039112; c=relaxed/simple;
	bh=4+xxXJpIxETTFxPp8LblvziN3QS7LhnD/JQ2E4D5Zqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajkWNckAHoaLkK9/Cl4fRDK8fs3F7JiXdjLYlX17Iy2KuIS3Sn2XNJx3dIvqAHQL6/yCxaOt1CgRz76X9qSk3J1SfpNnz9mDRj3HCmKt1FH+Ia2y25qAujgkK3KsbnsfuMl0LEQQBAFIRNd5jztrEhLady8S0gXRYND2vnuAy7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sUUKc/rQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709039109;
	bh=4+xxXJpIxETTFxPp8LblvziN3QS7LhnD/JQ2E4D5Zqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sUUKc/rQ0hMdw8Aa8wMkhPSpJ+yWBRrgN/MMLgfJdSTKdfEWllF6QGgmfxFM3pGX6
	 ptDx7Aiog9e7OJk4qYHvgThWqZ21TxZlxPMkeWUQcn8eQ59G/c8oFi3/vmnnwAuet6
	 0m9yPQ/ggGEBhRZMAN/09vD2rds3tvQOlbjeeJ4UhrOEWcwaDcPynKI076Wu9M1cjI
	 ceqa7YA5gEZcS5ixc9+/0mEJxWVfF0cGQqZ4p5LsTArsFc5UWTKv1GLfpdzHo+cpc1
	 CHUP+eVEYfqPafqj5jsY/8a3YNn4YITTveVnLxu7VuVRKmD0ood+mTKtMHzne2WmLZ
	 FRBzMAOW/S5Kg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 27C4F37820CC;
	Tue, 27 Feb 2024 13:05:08 +0000 (UTC)
Message-ID: <6ea5e5b5-13d9-4c3d-b8fd-4948824e5051@collabora.com>
Date: Tue, 27 Feb 2024 14:05:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: misc: onboard_usb_hub: Add support for TI
 TUSB8020B
Content-Language: en-US
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Yow-shin Liou <yow-shin.liou@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240227090228.22156-1-macpaul.lin@mediatek.com>
 <20240227090228.22156-2-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240227090228.22156-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/02/24 10:02, Macpaul Lin ha scritto:
> The TI TUSB8020B is a 2-port USB 3.0 hub. Add support for
> this hub in the driver in order to bring up reset, and supply
> dependencies.
> 
> Power-up: Issue a GPIO reset (GRSTz) 3ms after VDD and VDD33 stabilize.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



