Return-Path: <linux-kernel+bounces-36219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16D839DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD46B21F75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D326ED8;
	Wed, 24 Jan 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EgLvktNb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0D622;
	Wed, 24 Jan 2024 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055880; cv=none; b=YdoDatErEnresBHlBBJHo0+UIV7X/U7UgO4duE2gOO7zy7PdhGbe9f1PZUA6W1sssj/j6JJ3HAFCa6iPqbH1hq7IaNRG5g7OFRMUVji+hh7LrAjYjdPRZPR64UW2eXbWSKojuzXQUQioV5K8Tc/O1KaoT6MNYrYdFRHJ0t7pDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055880; c=relaxed/simple;
	bh=1Ilef9mn2H+4EwNKZD3TwdLOWn1+suThiEC0pHeCWIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiDV7OPOKWIfRzjGLhLcUITepakwHBd2uUNI0SkFHVrZtYCZipo6S0KkiOtbkvsB0xc16yNz4vd5gCeSGOcNuSWLnZBAUfY5m5XPepix/icR7rPPnyXejL820bd6DRDhLfjFiGbBA6KpWcGGdISG/l3dYWcdDS2VdHEf8B9LX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EgLvktNb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706055876;
	bh=1Ilef9mn2H+4EwNKZD3TwdLOWn1+suThiEC0pHeCWIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EgLvktNb+xFV5neKx76QNUz8Z6PPviCRKinW7BzxHLZO1KWzI0qzXvuVuWr3naKRD
	 t7boXipAQId+6NrFpby105Ebs67n+knviJsu4/Xc6fXMVhJ4nSbJUZ+zQKyYq1hhpK
	 BGeeCn4z1XqWwBXo/DR3QlGnVEljBMqYSu9Wodipu9yWstwAWPEY1315bYR0I0a7Nl
	 zdsDTJzZXs56kUABSuzQUNzvZjSKxNh6uH7YufGKAI7mCJksKpTrooIRpZV2MoZZzo
	 cLAtdcb43RImuABmsrMTHbEIs52y0imxjhQanzf0k1OxWl6LAWGqL2oj0h5Klkh5LG
	 chz8vkBvwMabA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C780D3782066;
	Wed, 24 Jan 2024 00:24:35 +0000 (UTC)
Message-ID: <ba848de7-1a20-47ee-9013-10500eb3da00@collabora.com>
Date: Wed, 24 Jan 2024 02:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: rockchip: Add Samsung HDMI/DP Combo PHY driver
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
 <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
 <298b7a10-2acb-4297-92cd-2ee4d890bfb2@rock-chips.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <298b7a10-2acb-4297-92cd-2ee4d890bfb2@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 1/22/24 12:17, Andy Yan wrote:
> Hi Cristian:
> 
> On 1/20/24 03:38, Cristian Ciocaltea wrote:
>> Add driver for the Rockchip HDMI/eDP TX Combo PHY found on RK3588 SoC.

[...]

>> +static int rockchip_hdptx_phy_power_on(struct phy *phy)
>> +{
>> +    struct rockchip_hdptx_phy *hdptx = phy_get_drvdata(phy);
>> +    int bus_width = phy_get_bus_width(hdptx->phy);
>> +    int bit_rate = bus_width & DATA_RATE_MASK;
>> +    int ret;
>> +
>> +    dev_dbg(hdptx->dev, "%s bus_width=%x rate=%d\n",
>> +        __func__, bus_width, bit_rate);
>> +
>> +    ret = pm_runtime_resume_and_get(hdptx->dev);
>> +    if (ret) {
>> +        dev_err(hdptx->dev, "Failed to resume phy: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    if (bus_width & HDMI_EARC_MASK)
>> +        hdptx->earc_en = true;
>> +    else
>> +        hdptx->earc_en = false;
>> +
>> +    if (bus_width & HDMI_MODE_MASK) {
> 
> Here use phy->attrs.bus_width to indicate different work mode,
> we also use the same in our bsp, but not sure if it is the appropriate way.

Unfortunately the PHY API doesn't seem to provide a clean way to pass
arbitrary data.  Probably for the initial support we could simply drop
the 10-bit color depth, FRL and EARC features.

Thanks,
Cristian

