Return-Path: <linux-kernel+bounces-56690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D500584CDA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF91F240EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572CA7F7D5;
	Wed,  7 Feb 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGkjgbRt"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19C7E784
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318435; cv=none; b=RYcdnl9SdgQn55UlC0/CKjqnvYgb9oLH8Z1pnPznse7zOciJHsXI1n5QaBBp7C1ssnNzr2pRNHCNoTKiiOsTgFJKZAsBnAMTkQk3GgUln1LTHB99AGMMMJtoQvS2ar4LUnOr2FA9tzXwRA3LvKs+IrCnzjL0kWR1UXOonHqgXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318435; c=relaxed/simple;
	bh=pZASOWSqteaB9GHlyiNAZwHfAOdXqGD/8tdZr624+BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbM872paClEYfBRHi45yNaK6ieTdQ1xJn9UnSyWaV0S0vY7iKzXI3lnRfQ93vsobsAgh0kkZJnDCAnvEdZtG38LUxNO4gor0eyiYkzAa/3QGrHxkD7q1Ov+KZIKpPvPgYMLiLV24/NH0iTFrc17xehRiLigmZUfswd5BsLjxWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XGkjgbRt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b4e5ed890so545969f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707318432; x=1707923232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSJxjfpzcsJVrC2izEOwtk03xqek2kTE6Ox1RH2MDNY=;
        b=XGkjgbRtF57kO8jZgMqTY0olOo+qiqrcOWoM9bo/W1IcPhKtjUQcnaXLNJxRDTcNrg
         y7PQNaPq2RKlh9Ky3YOuh0RN0DmVSwnrSAIXLXrwPYaUXRS3RP5welRaONyi4XJdzwUC
         nzWgeZoPMgSomKWJLIsc3RGHyZC5kHcQviLn+wW7jNGmiomg52QHmpWa3NJqKiqAPDgy
         NEsUDMidwXSiurKajl64JRfyGY5UZPyK4PBm6/uqXLnWhJB1yKKixxKWNvI6cd27SW06
         pZyKu1Za3C9AeSs5VSc/2t8oyjT1A4zwupO2kyMg634XLi5ClOl6PXP1mgA7xerLghyG
         JpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318432; x=1707923232;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSJxjfpzcsJVrC2izEOwtk03xqek2kTE6Ox1RH2MDNY=;
        b=urwvb6VD0EGiT8S2/LHw7W80yFcD/kmWs8Ex4KMZOiJlaa4ZUJSJT28Wns812EfCXG
         NZqzWu41WJpRaQppgK4+JuJuHM+Xyq3dPxM6GKxfG0fzU+19rVZbdk34lVGO8SQMRrXU
         8WeLCZ9546MkBQ7vztGjZ3nLdKoniBi0MrQDuxi8DK1qc5ljF9AAvnduRlY4/MRa4V2B
         EEeeOCzYJqzfNyhlt0Bn2clpnpMuHG7R1ODPFXcCnOBfZV3OxdLuiVTFi1ft1gsEWJe9
         nXNXmvRidMW2JAvF9Ij0iY9q5KVv9/zejFpl0EdXXtlkSfx8hzoiiC5S7npI9SvfJvUo
         NiCQ==
X-Gm-Message-State: AOJu0YxsS6HN5FoL8iJO9zoZUKnB0EibxSoiUCf/FIFfANJFp8UNyYht
	gw0WPQagpJ6VUo0PGNZbzvnqW12BfJzabrkSn8rtgeQMOhRO2trwCkIYkscBnfU=
X-Google-Smtp-Source: AGHT+IE3qctr+V4zYpCKmnDiY7t0ND8Q4GMD/+1dBqhfAZvk5RfgcBGRYhkyW/tGnCYgbk77Yuysdw==
X-Received: by 2002:adf:e447:0:b0:33a:efe0:5a37 with SMTP id t7-20020adfe447000000b0033aefe05a37mr3714813wrm.6.1707318431771;
        Wed, 07 Feb 2024 07:07:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU//d2vEHnrwEebi4L7cfGxsiLliqxndVikholAvE9HkD8C0m0RHFVpWt3eLokHOaXfEwk+d7WEUy9QQvGAE/uKDrIYfXSPzX5JHZgOM6iTS2EbQy8UVscnqZx9w98HRXXTVEB8AzmT1R6Pje18734414KscTu1h0Ao2uLFNiScXmbJuKLIRVBjRo1IhYKKMYYj4fdP7AZKKu/j3h01WBcKhnfCP4al1EUOlcBg3U04/y20L+yx0dXRGCmgeIr0W0aIp8NI3G5KASJYkNT83kojwxMdbvhIVB5fDQWMReYoQX6FJjz8YP513GJ8pbx0UqbvjT0eyVkAXDA0Xe+ju7jcBChOYd406XPnZRcd0D2wSq6pBqrdvWR2yfJQX1py1NOAcx90Hcbw9oOfmLvoQ2neCRfgftcyt31YDtFAFcn7qP5yblVdKfUeiJ+13kS1J8uFzMIrDU7iDQKkMeQMOv2Xx3IGLWMcflIm5bevmIrSY5hBsuYTLO0smEM46HRB/UVvD7lWZW2h08kf2wVFQpcFl1KvcVYvEovmnn1UUDuu63oC4uUIO81tU0czz+IuFkzNJDV/1806o6RXCGCzqLOJCdgCT0iQQbF6POU1OHT4M79NF7kqHONmv6lYsMYPp4MWLs4Gtm0MqIvUn7n717UKkd6pegviRZTD
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c161500b0040fde0ec31esm5439647wmn.31.2024.02.07.07.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:07:11 -0800 (PST)
Message-ID: <f0921985-db06-4a66-aa85-69337665d2a9@linaro.org>
Date: Wed, 7 Feb 2024 16:07:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Qingfang Deng <dqfext@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <3251ac3db1a739e0c18ded0a824edae981c1e2df.1707153425.git.daniel@makrotopia.org>
 <31d2c56a-5108-4265-a267-6733e1ba328e@linaro.org>
 <ZcJQyaTotW_bCWGU@makrotopia.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZcJQyaTotW_bCWGU@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 16:31, Daniel Golle wrote:
> Hi Krzysztof,
> 
> On Tue, Feb 06, 2024 at 11:53:55AM +0100, Krzysztof Kozlowski wrote:
>> On 05/02/2024 18:28, Daniel Golle wrote:
>>> Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
>>> MediaTek MT7988 SoC which can operate at various interfaces modes:
>>>
>>> via USXGMII PCS:
>>>  * USXGMII
>>>  * 10GBase-R
>>>  * 5GBase-R
>>>
>>> via LynxI SGMII PCS:
>>>  * 2500Base-X
>>>  * 1000Base-X
>>>  * Cisco SGMII (MAC side)
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>> v2: unify filename and compatible as requested
>>
>> Several comments, from me and Rob, were ignored. Please respond to them.
> 
> I'm sorry if I have missed something. I just checked again on
> patchwork, just in case I would have missed an email reply to this or
> any of the preceding posts of this patch as part of the old series
> going to netdev.
> 
> Comments you have made which I have addressed:
>  - removed $nodename
>  - use compatible as filename
> 
> And the only thing I found that I didn't either fix or reply to is this:
>> Can you explain what is this issue and errata about (except performance)?
> 
> Not overwriting that (undocumented) value in that (undocumented)
> register results in 10GBase-R having performance issues according to a
> commit in MediaTek's SDK, see here:
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/a500d94cd%5E%21/#F0
> 
> Maybe Bc or SkyLake of MediaTek (added to Cc) can explain this in more
> detail?
> 
> 
> What I did miss was Rob's comment at the very bottom of this reply:
>> What is PEXTP?
> 
> I can again only answer by referencing to MediaTek's SDK sources:
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/21.02/files/target/linux/mediatek/files-5.4/drivers/net/ethernet/mediatek/mtk_sgmii.c#96
> 
> Here this reset is called XFI_PEXTP0_GRST.
> 
> I personally find that name confusing (as this PHY has nothing to do with
> _P_ci _EX_press) and have tried to get rid of it where it isn't either part
> of official documentation or already merged drivers (like Sam's clock driver).
> 
> If there have been any other issues with this patch which I'm not aware
> of, please point them out to me.

These both cases should be explained in the binding somehow.

Best regards,
Krzysztof


