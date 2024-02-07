Return-Path: <linux-kernel+bounces-56490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF884CAC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288F0B21D81
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A246A005;
	Wed,  7 Feb 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S7oX9vLt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49B76032;
	Wed,  7 Feb 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309581; cv=none; b=lgqd+C8QRKvx2SzQuZ39Pj6KXVB5X4/5bpCAFpiJAuQ5WoDeB7mgcvYGHntcxTbEWg6XhR5x9Nc8/Tr+0ddmxoSVujnTeawdS5knaMZpDRxaUxZrI/bJBh8PFIfizvYiEqrDqewTD53YPpNTlTLqqVljpWo/1x738BAuBTeXb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309581; c=relaxed/simple;
	bh=JoE5es3b4RgJURPldxFLIyGMKvTDB86VVyi7w8h5Z4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jekHtozKUJD63XRnNKF7LlT2iuK2yKVmIANj4Xzy/PjpRLVWGECLy+eVQb0mPVi9qxvXYLbDJRNhDuoX545MK2yE+iQoSZiBCR3FiQ9YNizVwqt6NTvh0iliaH+jIJrWf1TVSiJP3KktmlREShTiC+AIQrfE1HQYzUvxuFDLWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S7oX9vLt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707309577;
	bh=JoE5es3b4RgJURPldxFLIyGMKvTDB86VVyi7w8h5Z4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S7oX9vLtw7KCJwVjftvxhJsO3DqyytyCAOHFvUvp5D/wyL5B6j8/sHOFpMKCucwO5
	 Ukrp4Zy6Zx2cbLquYkwoI1mSa/nuELGlAjebl1lam8IR3Oa93gJYn1ZHh1gMsT516u
	 CmBtZxiCXPa/LqAoPjmRhqO8i1LT9l+InGpN4JrBKIdJ6rrO5ctCxFvaHmmHICppfO
	 RMk7jNdltqF5QjpOohPnxoHyMdBJyo/LYXlYRxmGzj1QuYVBhZWGU0XdqWXi+f58O6
	 mziBsmvdJdFymrRXG1/52+r8rqKFU82aRCBS/D8VU7qchRCfn2MIhv6SR2qOU1jZL7
	 RYsR8cdECM9OQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AD19B37809D0;
	Wed,  7 Feb 2024 12:39:36 +0000 (UTC)
Message-ID: <374f5069-9f3d-4ad2-a6da-b38a143a0c99@collabora.com>
Date: Wed, 7 Feb 2024 14:39:36 +0200
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
To: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Algea Cao
 <algea.cao@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 kernel@collabora.com
References: <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
 <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
 <ZcNYlFgT0rXiCGbo@matsya>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ZcNYlFgT0rXiCGbo@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 12:16, Vinod Koul wrote:
> On 05-02-24, 13:24, Cristian Ciocaltea wrote:
>> Add driver for the HDMI/eDP TX Combo PHY found on Rockchip RK3588 SoC.

[...]

>> +static const struct reg_sequence hdtpx_common_cmn_init_seq[] = {
>> +	REG_SEQ0(CMN_REG(0009), 0x0c),
>> +	REG_SEQ0(CMN_REG(000A), 0x83),
>> +	REG_SEQ0(CMN_REG(000B), 0x06),
>> +	REG_SEQ0(CMN_REG(000C), 0x20),
>> +	REG_SEQ0(CMN_REG(000D), 0xb8),
>> +	REG_SEQ0(CMN_REG(000E), 0x0f),
>> +	REG_SEQ0(CMN_REG(000F), 0x0f),
> 
> Any reason for these to be mixed case, lets have lower case pls
> everywhere

These were initially part of the register name defines, as specified in
the RK3588 Technical Reference Manual, e.g. HDPTXPHY_CMN_REG000A.  But
consistency is more important, I assume, hence I will do a lower case
conversion.

[...]

>> +static int hdptx_write(struct rockchip_hdptx_phy *hdptx, u32 reg, u8 val)
>> +{
>> +	return regmap_write(hdptx->regmap, reg, val);
>> +}
>> +
>> +#define hdptx_multi_reg_write(hdptx, seq) \
>> +	regmap_multi_reg_write((hdptx)->regmap, seq, ARRAY_SIZE(seq))
>> +
>> +static int hdptx_update_bits(struct rockchip_hdptx_phy *hdptx, u32 reg,
>> +			     u8 mask, u8 val)
>> +{
>> +	return regmap_update_bits(hdptx->regmap, reg, mask, val);
>> +}
>> +
>> +static int hdptx_grf_write(struct rockchip_hdptx_phy *hdptx, u32 reg, u32 val)
>> +{
>> +	return regmap_write(hdptx->grf, reg, val);
>> +}
>> +
>> +static u8 hdptx_grf_read(struct rockchip_hdptx_phy *hdptx, u32 reg)
>> +{
>> +	u32 val;
>> +
>> +	regmap_read(hdptx->grf, reg, &val);
>> +
>> +	return val;
>> +}
> 
> why use wrappers, why not call regmap_ apis directly

Agree, no real benefit, will drop them, except probably
hdptx_multi_reg_write() for the extra savings.

So I'd keep using that one if there's no strong reason against.

[...]

>> +	hdptx_write(hdptx, CMN_REG(0059), (cfg->pms_pdiv << 4) | cfg->pms_refdiv);
>> +	hdptx_write(hdptx, CMN_REG(005A), cfg->pms_sdiv << 4);
> 
> small case here as well pls

Yes, will make sure to handle them all.

Thanks for the review,
Cristian

