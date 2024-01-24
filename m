Return-Path: <linux-kernel+bounces-37794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6955A83B56F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5DF285F66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56702136656;
	Wed, 24 Jan 2024 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hPqE9lLG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76EA7E5;
	Wed, 24 Jan 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706137724; cv=none; b=BjpkVB0tLPR0HOrizFKqxniUsXYoPnylfCe1qugsTi8pu7Nk53N7xjaemBeWg3QNYBm3vK6CBaAZrsq+USeHEGyClnOV9ncHOpESGSPACgaDxzifT80UfauTeo6EFxqcpsNKBE7Bi4E6q70DZiOM1JVdrbLIw+z9pRKgf84mSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706137724; c=relaxed/simple;
	bh=r+BNyXa+tutNidaJAQ5GCFSdQ6jcMos2xdU30CYj2LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Snv2jbX7S7cGGq95Qfmd3y+qvjK487UWKef3+biZJG473hcV9745+bUdUx8qpuix0nVopQTcenb/AM/26zWkDsgx1eYeMKtebrFBS8XBE43IBv0VjPFZleFFE22ATO8vUuev8/KNl6cVuFd4Gk1gnsfK2k/RFzf05dqImenkBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hPqE9lLG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706137721;
	bh=r+BNyXa+tutNidaJAQ5GCFSdQ6jcMos2xdU30CYj2LI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hPqE9lLG10rs/jdZyuob5naR3pMI7RbD2QGXP+V7c2w+OP5fjdBNWNbPT4RLb7+ie
	 UHYfz7ZtBoO8rccFOzK7OZAWanuOBoCIizRGW7xgIrNvpxr2MoyzvnxDH40oIPUxkH
	 NJMWolIxBsIOu4yX3FTeu4gH5mcpjCWBV1wzuPbs61QoXfA0dD9gGQ1zC6XJ5gq30j
	 xUm6OFC+gGdHSybjMm5otttZJI04WG/rCQk+i+HGoND08/VRfco9g4+eSuP+S7gVSV
	 ZsSnxqGx9GWOmugGQrcfPPaf+dCRo4wMmG+8yEtScE0w8f2Ygwb5m1qzls+Yu7/Y+M
	 KlWo0/Dz1x3gw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A4A5537811F1;
	Wed, 24 Jan 2024 23:08:39 +0000 (UTC)
Message-ID: <7a3020f1-9819-4439-9f62-1a77c1eb9cdf@collabora.com>
Date: Thu, 25 Jan 2024 01:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: rockchip: Add Samsung HDMI/DP Combo PHY driver
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Andy Yan <andy.yan@rock-chips.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Algea Cao <algea.cao@rock-chips.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
 <20240122121409.GW4700@pengutronix.de>
 <00c749f7-3eb9-4bd1-a057-43a692b77d68@collabora.com>
 <e1c56975-6a55-4b75-a447-dd2d0eec62e2@rock-chips.com>
 <b0a3da6d-84e2-44c2-9adf-421e306a2acf@rock-chips.com>
 <ba598f02-5f74-4cb8-97e3-c9369e6db0d8@kwiboo.se>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ba598f02-5f74-4cb8-97e3-c9369e6db0d8@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 11:16, Jonas Karlman wrote:
> On 2024-01-24 08:30, Andy Yan wrote:
>> Hi Cristian:
>>
>> On 1/24/24 10:42, Andy Yan wrote:
>>> Hi Cristian:
>>>
>>> On 1/24/24 08:58, Cristian Ciocaltea wrote:
>>>> On 1/22/24 14:14, Sascha Hauer wrote:
>>>>> On Fri, Jan 19, 2024 at 09:38:03PM +0200, Cristian Ciocaltea wrote:
>>>>>> Add driver for the Rockchip HDMI/eDP TX Combo PHY found on RK3588 SoC.

[...]

>>
>> How about add a PHY_MODE_HDMI to enum phy_mode, and pass this custom data by extend phy_configure_opts
>> or the submode of phy_set_mode_ext ?
> 
> Please see the patch "phy: Add HDMI configuration options" [1] from
> Sandor Yu. Also the series "drm/connector: Create HDMI Connector
> infrastructure" [2] from Maxime Ripard may be of interest.

Oh, nice, thanks for the heads up!

Regards,
Cristian

> [1] https://lore.kernel.org/all/19070c125268cfe900021dea6e7e8379b89c630e.1704785836.git.Sandor.yu@nxp.com/
> [2] https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org/
> 
> Regards,
> Jonas

