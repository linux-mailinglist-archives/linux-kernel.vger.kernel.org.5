Return-Path: <linux-kernel+bounces-65161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC38548C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46931B20300
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31731AACE;
	Wed, 14 Feb 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kQRzdMSi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEA1A58B;
	Wed, 14 Feb 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911424; cv=none; b=osxAApOVXTi2ZdxTNoKFW79St5zMi2AScGmZdOlcMDJiBm9Oj1BQGC2GAmTKEMZ24uZPE6QEju+AUnbo3CHDzOiv5wjzT5H7ZI6uLAl59sXFwyExrp/l9VfrQeA5R2KBw5ZhTarcDFGHyWAldhBfKknMuYYRNVOvc1mT7dYfsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911424; c=relaxed/simple;
	bh=UV55yHN/roTnMfLmzppeeG3H21jw4yoeweDk3pCOXIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9ZqFVL/34FyXaFSiEvaCAL+5WpsY85bH53FlmZ9PNKFyuS58ex+grSCH8Y3BZK6/fEIh6TJgmHkkx7Vf7Zt3S/UVSh2KHDtScpKvrlzRjNQTJx78SYeuJz7hzCgKyXTAfcEywba57xCfKqQl1FtchqqCEcgoVFnXDKasR9+FBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kQRzdMSi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707911420;
	bh=UV55yHN/roTnMfLmzppeeG3H21jw4yoeweDk3pCOXIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kQRzdMSiaLwXvu/OdGfdW+nZXbQkTl8hppD2CGCn1aGIKvqa3Ss8QrGbvDBJzGuG5
	 rkRMs66mdImOpcpMPQynDnIKTKKoRMXObBcRa7kwFIQpcjexM1wswBG0uFBLAE5LJL
	 GZ5uDW0z23zCQj5SwN6uKeXb/IRlAqwtmSXhfVdpydyMuQ1+zBM5lcW6z0IsAwuHna
	 dhxxk15TchX7OOwWEkhIZB8uXuAZJLgC0+75NjlfhzE41kSlTBWhl5adwZB5TbCbbd
	 e/vsBwwboqGM8nuKQgeVbBSOzSaNKd6k0p894PdmCpjeerW4LhLlDuz/Rs7jhseukD
	 Wf+A7E632SsRA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B1BDB378045F;
	Wed, 14 Feb 2024 11:50:19 +0000 (UTC)
Message-ID: <87fe0e42-d4b9-43d4-87e2-0d054283c7b7@collabora.com>
Date: Wed, 14 Feb 2024 13:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY
 driver
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, kernel@collabora.com
References: <20240212-phy-hdptx-v3-0-2cde680cd024@collabora.com>
 <20240212-phy-hdptx-v3-2-2cde680cd024@collabora.com>
 <b89552bf-cb04-42b1-94ac-5529205b3be1@gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <b89552bf-cb04-42b1-94ac-5529205b3be1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 01:29, Johan Jonker wrote:
> 
> On 2/12/24 19:52, Cristian Ciocaltea wrote:
>> Add driver for the HDMI/eDP TX Combo PHY found on Rockchip RK3588 SoC.

[...]

> For Linux FTRACE filters it is needed that all functions in a driver start with the same function prefix.
> Currently there's a mix of hdtpx_* and rockchip_*
> Maybe use rk_hdtpx_* ??? similar to for example rk_nfc_* in rockchip-nand-controller.c

Done in v4:

https://lore.kernel.org/all/20240214-phy-hdptx-v4-0-e7974f46c1a7@collabora.com/

Thanks,
Cristian

