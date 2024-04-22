Return-Path: <linux-kernel+bounces-152693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B468AC2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82587B20D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CDEAEB;
	Mon, 22 Apr 2024 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4abCtbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85161078B;
	Mon, 22 Apr 2024 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756371; cv=none; b=OQNuGdnl0IY6Od2EvL8K7L0rXLTT8+dPVmY/Tu/ATw/dGWQhUtAz10pSSQOej2KdqpG9OBnuhzAB8YysjmZzz03662JdfYDwLU4wdL3drcgdh3sVDf90sql/v/1Ce+4ec2DVeNAtRTf50TPo4ugN+X3VzdvCmKflIr23NlbU4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756371; c=relaxed/simple;
	bh=n8OeoVzXBkCF7d/h9/+hrU0DlS4s1TrGHvMrJDN7uxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ac3v/3q/kmZwDNZq7kKR+cIEHVlEFUxqdeXCR6J++6Y0Bbia/mQasyoyE57wrgfR0sVs8Kp2BUTolxiTfO/nMFpnFp0FwJZnwLUFLkNOH/6+mfrtEHnpYANQU6DV2zzPQhX/xf2nU7T2DHNrGeGWtVH0Yt9mrE0W7ehGORWjMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4abCtbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84757C3277B;
	Mon, 22 Apr 2024 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713756371;
	bh=n8OeoVzXBkCF7d/h9/+hrU0DlS4s1TrGHvMrJDN7uxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q4abCtbDz68wMU7XVvgNs7tYVtJdvzJLNQBrqKlNyAgncuvftXKBj+EN5U4Nyakhh
	 2ypUgtZUTJJQ3AaOP66h5QXQLrFYNtT1KbwJaCez/tCrh41kF0ruKkBOPz7igZmnzN
	 G00/nOm1uW59OMYelc5B/ZvzTv+eMX7C4HqY6dMysRwH7/qMnlY1p3ULg+8G5ZWjJ5
	 ogOpMSMYG8yQsl0mdMg/8a5wqVbc6v/OBIdyttEoL/5gGhuEGc0xEZ6nq/nchaLT2a
	 xGIZTgjMdDtbXgUxdIDlqcSh5lRCwLF0YVjfdUWvo3521bPqorv40hIxeZADmHfZ54
	 DzlSC3b/sYUmg==
Message-ID: <ce03bc0c-b113-44c3-8243-0fa22b8a95bf@kernel.org>
Date: Mon, 22 Apr 2024 05:26:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
To: Zhi Mao <zhi.mao@mediatek.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Heiko Stuebner <heiko@sntech.de>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Hans de Goede <hdegoede@redhat.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Paul Elder <paul.elder@ideasonboard.com>,
 Mehdi Djait <mehdi.djait@bootlin.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 shengnan.wang@mediatek.com, yaya.chang@mediatek.com, yunkec@chromium.org,
 10572168@qq.com
References: <20240420011840.23148-1-zhi.mao@mediatek.com>
 <20240420011840.23148-2-zhi.mao@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240420011840.23148-2-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/04/2024 03:18, Zhi Mao wrote:
> Add YAML device tree binding for GT9768 & GT8769 VCM,
> and the relevant MAINTAINERS entries.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If there is going to be any new version, then:

>  .../bindings/media/i2c/giantec,gt9769.yaml    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)

> +title: Giantec Semiconductor, Crop. GT9768 & GT9769 Voice Coil Motor (VCM)
> +
> +maintainers:
> +  - Zhi Mao <zhi.mao@mediatek.com>
> +
> +description: |-

Drop |-

> +  The Giantec GT9768 & GT9768 is a 10-bit DAC with current sink capability.
> +  The DAC is controlled via I2C bus that operates at clock rates up to 1MHz.
> +  This chip integrates Advanced Actuator Control (AAC) technology
> +  and is intended for driving voice coil lens in camera modules.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - giantec,gt9768
> +      - giantec,gt9769
> +
> +  reg:
> +    maxItems: 1
> +
> +  vin-supply: true
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vin-supply
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Drop blank line

> +    i2c {



Best regards,
Krzysztof


