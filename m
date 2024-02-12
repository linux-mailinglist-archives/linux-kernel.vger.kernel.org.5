Return-Path: <linux-kernel+bounces-62195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F29851CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F5F28177B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C43FE2B;
	Mon, 12 Feb 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ViEM1ASS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB33FB01;
	Mon, 12 Feb 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762968; cv=none; b=LJWwkWxtK7nD8He/yTPjtCIeYcCIUVuoXIi0O2p399SGH8w2okLcxnwHfY+WNw0kuQrsbI2D5A9EZ7a9Lu99iJELP87fdsCCjgnPnzS3Vk3TEGBFENMjfTv/HRxUOHSb32EoDSD1EyuTbdxR0zNrRK/Usq29lUlYrZ0znI/0I4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762968; c=relaxed/simple;
	bh=T6klo5znd49M931UrjN16DNw3T/R1nxaLTG4aDB8gV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLmRP2raQq/9OUW9YaYJEdZfxCElJ/qiiZtgcJuyYFMM0rkjWm0GxKPlBAkDSFvMyYS0Sy+CZuGM+uD1Omwp4YXXLl7bVCvZEAs13s+w57Ym+qqJsvpqb+9SQqYssKhzhxl4XzleX68YpvMy2Y3uyKZyFIn2eb4RtdbMuhgb8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ViEM1ASS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707762965;
	bh=T6klo5znd49M931UrjN16DNw3T/R1nxaLTG4aDB8gV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ViEM1ASSooz6/5l6YhYrLglA/e9pS7yzXmNL899kVcI6WvbWsO2YTMBU5RHhM6vHo
	 sDSDiOBEF+9A1U24pV7d6Nv30985UXdCSXoUx5+H/Yla0qVzWC/OPoMd1/J1WEo8Yx
	 jmUOfgyRlk/a6nLF26s8jpyQzl1e1G/x28X307zQFTPvDVV34WxMGM13V+fWNLfVSb
	 0TeJqUoxnUjURSy+5zYdcIr/3bnPOBiV5ScgmQBFcZuWX41VxhhfIaNk92UNZOqwtW
	 WDWgb3nhFoZGfvSMXy3nOcP+/xfI3vNm+zh1oG6gDiy3gbuLeXCLjdmy6iCdPmJ6nv
	 FtcJtDTDDWgYQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 277193781FCE;
	Mon, 12 Feb 2024 18:36:04 +0000 (UTC)
Message-ID: <4efca2ec-b078-4421-8956-e3add15d8f62@collabora.com>
Date: Mon, 12 Feb 2024 20:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY
 driver
Content-Language: en-US
To: Luis de Arquer <ldearquer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, kernel@collabora.com
References: <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
 <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
 <61af7b121b23fe8ed06df5348692f862b9b125bf.camel@gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <61af7b121b23fe8ed06df5348692f862b9b125bf.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luis,

On 2/12/24 18:44, Luis de Arquer wrote:
> Hi Cristian,
> 
> On Mon, 2024-02-05 at 13:24 +0200, Cristian Ciocaltea wrote:
>> +
>> +static bool hdptx_phy_clk_pll_calc(unsigned int data_rate,
>> +				   struct ropll_config *cfg)
>> +{
>> +	const unsigned int fout = data_rate / 2, fref = 24000;
>> +	unsigned long k = 0, lc, k_sub, lc_sub;
>> +	unsigned int fvco, sdc;
>> +	u32 mdiv, sdiv, n = 8;
>> +
>> +	for (sdiv = 16; sdiv >= 1; sdiv--) {
>> +		if (sdiv % 2 && sdiv != 1)
>> +			continue;
>> +
>> +		fvco = fout * sdiv;
>> +
>> +		if (fvco < 2000000 || fvco > 4000000)
>> +			continue;
>> +
> 
> What about adding a check to data_rate, maybe like
> 
> if (fout > 0x0FFFFFFF)
> 	return false;
> 
> or similar, before the for loop, to keep the multiplication safe?
> 
> Right now it would be redundant, given that data_rate was, at some
> point, encoded in 28 bits within bus_width. But can prevent future pain,
> especially after changing to phy_configure_opts_hdmi.

Indeed, it makes sense to do the check, thanks for the heads up!
I was almost ready to submit v3, so this arrived just in time. :-)

Regards,
Cristian

