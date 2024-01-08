Return-Path: <linux-kernel+bounces-19702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2552982712C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D6A1F23012
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6944C81;
	Mon,  8 Jan 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xJJewCu+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348B405C7;
	Mon,  8 Jan 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704723851;
	bh=mc5HOamFYriYeumJK9D1W6NJdUvkZnUeuFa4C5EjT4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xJJewCu+KvPzQrBNi+2a5MFjUmLSwERs67kGfo1ETpOrHxyqcC/pvQ1aC81P+0ueT
	 QzBhhgaJOZuK1Jxt4/Hs32Lvf7xkh8rwihSifMjxAOFoRc38cvnj4CBOcP9dhtAiuz
	 x2Wwov8BJSQ7tupXjNr4FiQQ5jaaZ2TzxMk4u05yo9DJ3Y2nPH9nI1jq05DRXJ9Rhh
	 B33nCnK2BY9X+2QtZ9sdje4H3hZmWwpZja7F/bMLT68WeXyZUprXTaRFGL0DKX+yJv
	 leYmMEsERtm04zjCvL5LNDTUx983NBAvkT/xSe22QqS+LuRUdMyoEIKO6plMBUJ/4S
	 XR5gaOweUb/FQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64BFF378003D;
	Mon,  8 Jan 2024 14:24:10 +0000 (UTC)
Message-ID: <19f5ef6e-ecc1-4f6c-b6f1-8a729d170ef6@collabora.com>
Date: Mon, 8 Jan 2024 15:24:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clk: mediatek: add infracfg reset controller for
 mt7988
Content-Language: en-US
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240105162056.43266-1-linux@fw-web.de>
 <20240105162056.43266-3-linux@fw-web.de>
 <717a21bb-de39-4f7d-913c-f2a20d8b02bd@collabora.com>
 <D0CA0019-A61D-4843-B502-7F40DA619FB3@public-files.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <D0CA0019-A61D-4843-B502-7F40DA619FB3@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/01/24 14:46, Frank Wunderlich ha scritto:
> Am 8. Januar 2024 11:12:26 MEZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 05/01/24 17:20, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Infracfg can also operate as reset controller, add support for it.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>>    drivers/clk/mediatek/clk-mt7988-infracfg.c | 20 ++++++++++++++++++++
>>>    1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
>>> index 8011ef278bea..1660a45349ff 100644
>>> --- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
>>> +++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
>>> @@ -14,6 +14,9 @@
>>>    #include "clk-gate.h"
>>>    #include "clk-mux.h"
>>>    #include <dt-bindings/clock/mediatek,mt7988-clk.h>
>>> +#include <dt-bindings/reset/mediatek,mt7988-resets.h>
>>> +
>>> +#define	INFRA_RST_SET_OFFSET	0x80
>>>      static DEFINE_SPINLOCK(mt7988_clk_lock);
>>>    @@ -249,12 +252,29 @@ static const struct mtk_gate infra_clks[] = {
>>>    	GATE_INFRA3(CLK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3", "sysaxi_sel", 31),
>>>    };
>>>    +static u16 infra_rst_ofs[] = {
>>> +	INFRA_RST_SET_OFFSET,
>>> +};
>>> +
>>> +static u16 infra_idx_map[] = {
>>> +	[MT7988_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 9,
>>
>> The MT7988A datasheet says that INFRA_RST0 bit 9 is CONN2EMI_M0_GALS_SLV_SWRST, so
>> this is wrong: THERM_CTRL_SWRST is in the RST1 register, bit 9.
>>
>> Also, I'm sure that you really want to add the PCIe MAC reset bit as well, to be
>> used with the PCIe driver...
>>
>> [MT7988_INFRA_RST0_PEXTP_MAC_SWRST] = 0 * RST_NR_PER_BANK + 6,
>> [MT7988_INFRA_RST1_THERM_CTRL_SWRST] = 1 * RST_NR_PER_BANK + 9,
> 
> Yes you are right...i have only rst1 as screenshot,need to get the full datasheet or can you tell me base address for rst0? Need to change value of INFRA_RST_SET_OFFSET then to rst0 and check RST_NR_PER_BANK to be correct.

The datasheet is public ... [1] has it in the Resources paragraph :-)

Anyway, since I already have it here in front of me...

10001070 INFRA_GLOBALCON_RST0_SET
10001080 INFRA_GLOBALCON_RST1_SET

[1]: https://wiki.banana-pi.org/Banana_Pi_BPI-R4

Cheers,
Angelo


