Return-Path: <linux-kernel+bounces-36254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D391839DED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB01EB29665
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C241106;
	Wed, 24 Jan 2024 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IBtheqpv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D583C00;
	Wed, 24 Jan 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058240; cv=none; b=XYS6LBcKzGdmp4zzreMUY6z7QpgNp0mKo/CnpV3eCgPVCzxNrbm2fAqydihHZQx9zIdCM+bXPefLAKVTqzJSOYEIYJnruMt6xYUTIgDJOfvELp+udtPBcLtDt/kRQVfwF8li2RiRyxd02KDhL+ZTqDKyxfJlxHPAIkVSpEqIGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058240; c=relaxed/simple;
	bh=ehveRBNnG2mx2K0XMQwz5dn4O/JDiS3/LjXos/xx6I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0hGvmkodnKRmRkaHx7s0e3McJJymuvV2q6AyfptHo6fFzlB/am3N6A0h+HjH4mL1YHc9qZsaz+5FcQ4UBzEhBtUoWmnhBPYNU+TYjxJ8qYe1icQ4OAXPZRkKVmOV5qO5WT8yPWX/D+Nt9AYGdMAnDLCr1C4J3Qt0RlUDNwx6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IBtheqpv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706058236;
	bh=ehveRBNnG2mx2K0XMQwz5dn4O/JDiS3/LjXos/xx6I0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IBtheqpvdmfu+c2cwYXyujjJjpot42tc5/ys79dH33xGT4MF32SvIMJHCy1VmBhIP
	 1iW/HY5gVrfSNZMb0rh9/mJLyRHx+gqSc3NoUpvMnuxVo2CfVFjy2vIC2ZiDAUK+wn
	 EpLqrOlIJcg4V56Ewdh2JAoKOF1xnfCXVdNzdufuZePLVwxD3Sl6e4nClFYrZMLFhr
	 rDRcTmMSWlV3qc/1a9vo3vFifDpFj8fjiDMj4K58hACXlTC1v3nNTbfm209jUInH6A
	 GzSnSbgFIM6US3giJsKhTpWDl8WEDwCLZy7u+kV0UalL1FUx+coUAt61ucyxnBWb0o
	 p3JtHoK5+KMVA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D06E33782074;
	Wed, 24 Jan 2024 01:03:55 +0000 (UTC)
Message-ID: <724284f0-b387-4b81-9043-f73df6c9f697@collabora.com>
Date: Wed, 24 Jan 2024 03:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for RK3588 HDMI/DP Combo PHY
Content-Language: en-US
To: Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <417281cd-23b1-4948-8c5a-b9820dff65aa@collabora.com>
 <a7e5304a-1cfd-4f38-8708-bfca30f0ef7f@rock-chips.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <a7e5304a-1cfd-4f38-8708-bfca30f0ef7f@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/22/24 12:10, Andy Yan wrote:
> Hi Cristian:
> 
> On 1/20/24 07:41, Cristian Ciocaltea wrote:
>> On 1/19/24 21:38, Cristian Ciocaltea wrote:
>>> Add driver and bindings to support the Rockchip HDMI/eDP TX Combo PHY
>>> found on RK3588 SoC.
>>>
>>> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
>>> and eDP links.
>>>
>>> The HDMI link has been tested on Rock 5B and EVB1 boards.
>>
>> I missed to highlight there is no eDP support provided by the current
>> implementation.  Downstream kernel has a separate driver for that and at
>> the moment I don't have the hardware to wire this up.
>>
>> Will include this statement in v2.
> 
> The PHY is used for HDMI and eDP on rk3588, and should used be exclusively.
> so I think should s/DP/eDP/ in  all description.

Right, will make this consistent.

Thanks,
Cristian

