Return-Path: <linux-kernel+bounces-17146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D258248E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3881C23F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186702C190;
	Thu,  4 Jan 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTG9Q+6t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6F2C197
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso91056766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704395961; x=1705000761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODG/WY+m1sczivh5xbMK5YbAXeuwMsG0RhioOZlpsCE=;
        b=qTG9Q+6tRoVAQWVQauMXHa6gml4USJMIJL4RmxlKVJUAtZDYQ2X8hneaNqscMPtRfh
         kEi+XiIGHsHscvY2ZEYsXlJE+PCePm895DuEUmIfhrwH/h9jerIrkaDDmL11/mmO0qEO
         RlZHhE11t++9ExPE2GAnTf0VH4HJjXBjQa9o+adtKujkJ2+xW5czMET1ZZzGOUjgty70
         t6MAH3EOPisLQquaieVRlfvtEHrx5p7vOWACFRBAlxKLqW4Pde2ByhO19jb4wxJZM7EZ
         BY0Tyksc7p81fbgr1No+D/PnhQxArqnYT11Jjb3smhL2a5FzgoZPhqe/3iiEUA2P22ZN
         8rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395961; x=1705000761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODG/WY+m1sczivh5xbMK5YbAXeuwMsG0RhioOZlpsCE=;
        b=peUSxqr/a2c164kzbFzEX3vmu4KXtTTMBiw6GeQnOmyHv7Q0L8Bb3Dq6K85bvVlIYO
         SC0hl8+fC3Vn93puWtOjs9b6nHnMMMB3+vL2+5uIVTOOqDXoLNqssCHA+0zahR1Z+4Ij
         MB6z6dAbo5HGFpcnwBiGHcgIuzynHXCmPyZ52q1rW/2P119kpduJBsQB7Y51vQfW5EOi
         URv+Ei5qjHOHlOCn6Z3FtiR54bFHHhtUtTB57IlX3mtaWRhG1ukwmzP/yC12jnaoTwM7
         xt8dkrNrU5GDeG6qTQa/op+28gJofOaOnli4p2xjIH057jlRkuu7jyCJk2YnfZBklZKa
         mtng==
X-Gm-Message-State: AOJu0YxQxoXgGegVb9w5OFXhmhtzR/dBijWuFbD9bIZhX690Rw35F8sL
	xuplAptzOqUqF/aAYP/MaGp6BuAzt6nUfA==
X-Google-Smtp-Source: AGHT+IHlBpIP232uteEqrO/gsyTlyLxbodxnzCp/OE3ddkYrQ4RChRkbBVMdNCM0xT34uDfZM4Nl1w==
X-Received: by 2002:a17:906:8464:b0:a28:dd23:df92 with SMTP id hx4-20020a170906846400b00a28dd23df92mr956515ejc.71.1704395961295;
        Thu, 04 Jan 2024 11:19:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i1-20020a170906444100b00a279fa8b3f0sm6124817ejp.124.2024.01.04.11.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:19:20 -0800 (PST)
Message-ID: <3e3455a1-c540-4323-9d9d-95289a395c3f@linaro.org>
Date: Thu, 4 Jan 2024 20:19:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: reset: mediatek: add MT7988 LVTS reset
 ID
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <linux@fw-web.de>
Cc: linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sam Shih <sam.shih@mediatek.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20240104173930.13907-1-linux@fw-web.de>
 <20240104173930.13907-2-linux@fw-web.de>
 <ZZb0-pFWxuQlEm7q@pidgin.makrotopia.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZZb0-pFWxuQlEm7q@pidgin.makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2024 19:12, Daniel Golle wrote:
> Hi Frank,
> 
> On Thu, Jan 04, 2024 at 06:39:29PM +0100, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> ---
>>  include/dt-bindings/reset/mediatek,mt7988-resets.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>> index 493301971367..3f1e4ec07ad5 100644
>> --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
>> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>> @@ -10,4 +10,8 @@
>>  /* ETHWARP resets */
>>  #define MT7988_ETHWARP_RST_SWITCH		0
>>  
>> +/* INFRA resets */
>> +#define MT7988_INFRA_RST0_THERM_CTRL_SWRST	9
> 
> I suppose this argument applies here as well:
> 
> "IDs should start from 0 or 1 and increment by 1. If these are not IDs,
> then you do not need them in the bindings."
> 
> https://lore.kernel.org/all/59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org/
> 
> As a consequence, as what you are describing there are hardware bits

If this is existing driver which already uses such pattern, then it is
fine. I usually comment this on new drivers which can be changed.

Best regards,
Krzysztof


