Return-Path: <linux-kernel+bounces-54588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238A84B140
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23C728571D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDE12D15A;
	Tue,  6 Feb 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZuUd+Fue"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155C745E0;
	Tue,  6 Feb 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211692; cv=none; b=VBnA6vU6bEjYHI1MaiRxLq7JDFT9RGHquWEAgmiOlS1uDJtBFoiPRraFqaSGrK5APsoO4gcXOTXcM0URAubgNqdDAQL8bI04+914Pp+QamX1alVJQ+In8r58EyPiohgwa+ZIMmqBRGhdbms7OyZuOKNdOR9pn1S89qQk8mxnHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211692; c=relaxed/simple;
	bh=A4GC26ZvMOKhodYJDqUeGvS/fHc7oz32Zo3RglFVqy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMEvRoAckQDJCQplFX8jlxQ03fJT0TS7KPwQnc7Ooc1sxVSqJtvJm0y24u53mfZTYA/I8/aG8BcIOGZCg8jf2Fz7FZ6Z6TJOU5GMenMzc2BIFYJWRUEs+zP+TeEonn8NOpb/yrvMyKngnnNU+oyUlHTSq589e3I7oqik8+SXDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZuUd+Fue; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707211689;
	bh=A4GC26ZvMOKhodYJDqUeGvS/fHc7oz32Zo3RglFVqy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZuUd+Fue2DTUYn81nMSnY9HrH+nWCVRoR4LnDIm5HmZK4+fsBHcspBXbsP9JyW0u/
	 X2Efdk2AC/zoERqxDDw5O3wVfjcBXpBOyfYUYLQgGtRxD5X1WRXpUbkNtTmPtRYaBA
	 buGg7spyDambfAq4WTT+4YZUx/a/OkPxNxlN/bGL8Fzs2FUURqOY8eJU1q/NkYalNu
	 z/O6E5UD7zU1Vyu265Ve/LHqNtwtUdOo26k53cX8HMf1D8hqTh06YsKdm67l1/uFsG
	 m1jst4zG6jgS+GLeuApS2U6zjEHcSH79aNtN665AEmLZItO1Ko0Jaglu6/9PrLQJvP
	 ghtVaIqIAA2kw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D2D7F3782039;
	Tue,  6 Feb 2024 09:28:07 +0000 (UTC)
Message-ID: <02f4d6ee-e9f6-4184-a125-091f45bae54a@collabora.com>
Date: Tue, 6 Feb 2024 10:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: add driver for MediaTek XFI T-PHY
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
 Steven Liu <steven.liu@mediatek.com>, John Crispin <john@phrozen.org>
References: <3251ac3db1a739e0c18ded0a824edae981c1e2df.1707153425.git.daniel@makrotopia.org>
 <2972dfd0b9ca48174fbf49b9d162bac1a12b2331.1707153425.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2972dfd0b9ca48174fbf49b9d162bac1a12b2331.1707153425.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/02/24 18:29, Daniel Golle ha scritto:
> Add driver for MediaTek's XFI T-PHY which can be found in the MT7988
> SoC. The XFI T-PHY is a 10 Gigabit/s Ethernet SerDes PHY with muxes on
> the internal side to be used with either USXGMII PCS or LynxI PCS,
> depending on the selected PHY interface mode.
> 
> The PHY can operates only in PHY_MODE_ETHERNET, the submode is one of
> PHY_INTERFACE_MODE_* corresponding to the supported modes:
> 
>   * USXGMII                 \
>   * 10GBase-R                }- USXGMII PCS - XGDM  \
>   * 5GBase-R                /                        \
>                                                       }- Ethernet MAC
>   * 2500Base-X              \                        /
>   * 1000Base-X               }- LynxI PCS - GDM     /
>   * Cisco SGMII (MAC side)  /
> 
> In order to work-around a performance issue present on the first of
> two XFI T-PHYs present in MT7988, special tuning is applied which can be
> selected by adding the 'mediatek,usxgmii-performance-errata' property to
> the device tree node.
> 
> There is no documentation for most registers used for the
> analog/tuning part, however, most of the registers have been partially
> reverse-engineered from MediaTek's SDK implementation (an opaque
> sequence of 32-bit register writes) and descriptions for all relevant
> digital registers and bits such as resets and muxes have been supplied
> by MediaTek.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



