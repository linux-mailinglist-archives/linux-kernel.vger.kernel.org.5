Return-Path: <linux-kernel+bounces-134835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCB89B7A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D72B22207
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91172F50;
	Mon,  8 Apr 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nk/1BbJL"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C6290E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557862; cv=none; b=nBQ62giVONg6Pbk16ekqEi6e7YrI/SNTBHWjYiJSnMc9hSonD4+Kqu//KPppo19snP5P5ESM0i1qZ6sb3JTUlvxjlP4tvEW6dUQ3lVFJxUv4COBIAQD6HqLQq2P3a4aNuqKbU2WQ4ssTou9Cwh7Smn3sFANJi4kw2uZytA6t/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557862; c=relaxed/simple;
	bh=2aF5IdS63H7ZpPhgVLEYroerFgje0Uc6d/1bs98I8sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6B82RiyG5O6+HaDc4z8cpuFVRKlufKegnYCEwQWW/V07S+Yx20/14OtK0ta4GoXK90YxZhG28x3sscrMqZGOxcOrzdylx1F+0nytE+VGwa9X3FqIbvXVeruyl8nmke9hD0kFgo8UTGj/fH40GzBWnqpQ176ahNda0bzpClP/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nk/1BbJL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51d83fafa8so48762766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557860; x=1713162660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0KYmvUDf80m88YMXP3fMqo8ScPsGcmUezr7P8QyyQFU=;
        b=nk/1BbJLINul7wgXm3nCzgoZljQCM1Knrb8JS65Xwh9A5KQuSBTpdn95gPbUZXnfdF
         12kynTOx2lSsSoZ3BLVVEjUAeZX2W1uVTp/v7vZrBrrZwlgDcy+S41NfC1kdcB/d9dPb
         LxcA4mAFVl8emlhyRb3FdwPSoKlOvGyxNpXyagDxzSB9qiHJyDDL8KlJ5nl8bEZGthFz
         iwoh4AiiDIDtDuzf74fiaV7RoDacNzHkePcjK2Vu4bZ+wWQeQzqQ2bFVm5uhKo4pTxUI
         R8LjlwXMtkd8SMzXTzZekgKiz9NY/im7HsCFuKCYzdCIF1MaWHzYgKm1Ca15O88FOHf3
         bdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557860; x=1713162660;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KYmvUDf80m88YMXP3fMqo8ScPsGcmUezr7P8QyyQFU=;
        b=IuJCAnUn+inxkRA4D93K3PQXs0aHRe3WU51z4S4Thy0AO5sbR04pir27xNLCp1A2bp
         ih/lKgA5qk6kTTzjGfdlGNw5IbFJXXIJggjkfHGW26TuhVdtxe8a87+sARP1i9oukmvQ
         yM/RX5D8ezfRPUrgb8dmfRpuIK/Uv2L9y8w55qC1kCJ01LOtyV5fHC9tsB7wSuQJRND+
         8oR1M43YrosESYxUwQ2HUW1AjcSeYYV0npzmHhpvGz6RzuAmPzq8/egZDshC05EFoPQP
         WqdiRLHpYefEuz2uS/5N0MvYnBa4Kls4+ofdEH8IMhwwGiynHUHimDDwMRU8kSn7Kyap
         sGHA==
X-Forwarded-Encrypted: i=1; AJvYcCW6bvVwOP11m/nEJAYZJblAPQqGga5GMpp9g/aICb2XOsdHued6idWpu0svDjCd7GBFcEakFxWeyHIvTbbtj2xd5G4iOeCOwFkDJkYi
X-Gm-Message-State: AOJu0Yx1dCON80B/eUAzZkb4EDtBkBg13o5vyLTmXWxTuaIrKybft+kQ
	oxANHol4yZUUO35ogLhb843l6x8AtXJR6MQmel8n7+nxdwF2UwSbLaDuLtr7gT0=
X-Google-Smtp-Source: AGHT+IHKpgS/7N+qNqT2rqk8qoAtIrascdVmfZ5A2k2DuidpJbl62vpUAnd5gY7MKQ+nqa8RxL9miw==
X-Received: by 2002:a17:906:a292:b0:a51:adf3:ac63 with SMTP id i18-20020a170906a29200b00a51adf3ac63mr4606050ejz.23.1712557859622;
        Sun, 07 Apr 2024 23:30:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id cw23-20020a170906c79700b00a51bf5932aesm2483896ejb.28.2024.04.07.23.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:30:59 -0700 (PDT)
Message-ID: <920d797f-0e1a-458a-9924-1f299a8752d3@linaro.org>
Date: Mon, 8 Apr 2024 08:30:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB
 schema
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
 <20240407-spmi-multi-master-support-v9-1-fa151c1391f3@linaro.org>
 <fkwugrnak3fhkg5ig47kmy3edm45ut4dprkabntnwemjt3w2mb@7cak5zxwzw4p>
 <ZhOJB8o9cRr7oQU8@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhOJB8o9cRr7oQU8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 08:04, Abel Vesa wrote:
> On 24-04-07 19:07:03, Bjorn Andersson wrote:
>> On Sun, Apr 07, 2024 at 07:23:21PM +0300, Abel Vesa wrote:
>>> Add dedicated schema for X1E80100 PMIC ARB (v7) as it allows multiple
>>> buses by declaring them as child nodes.
>>>
>>
>> But is this really a "dedicated schema for X1E80100"? Isn't it "the
>> schema for all multi-bus controllers"?
>>
>> I.e. isn't this a "dedicated schema for all platforms starting with
>> SM8450"?
> 
> Suggestion was from Krzysztof to add platform specific comaptible (and
> therefore schema). Since the first platform that will support in
> upstream proper multi bus is the x1e80100, the schema needs to bear the
> same name as the compatible. When support for multi bus will be added to
> the other platforms (including the SM8450), they will use the fallback
> compatible of the x1e80100 and will be documented in this newly added
> schema. We did the same thing with some PHYs drivers, IIRC.
> 
>>
>> Can you please use the commit message to document the actual reason why
>> you choose to create a dedicated schema for this? Is it simply to avoid
>> having to schema with either pmics or multiple buses as children?
> 
> I can re-send the patchset with such a phrase in commit message.
> 
> One of the early versions of this patchset was actually submitting a
> generic compatible for multi bus, but I remember that there was a
> request for following the platform dedicated approach.
> 
> Krzysztof, can you please provide here the argument for why that is
> preferred?

I could not find such suggestions from my side in the archives, except:
https://lore.kernel.org/all/dd86117e-0196-499b-b8b3-efe4013cbc07@linaro.org/

where I want SoC specific compatibles to be used, not versions.

Now about this binding, it is not a schema for all platforms starting
with sm8450, but only for x1e. I do not understand why this would be a
problem?

If you ask why this is not a schema for all platforms, then because:
1. maybe no one tested other SoCs?
2. maybe no one cares?
3. maybe other boards need some quirks, so this would be applicable but
not fully?

I don't know... since when do we add "generic schemas"?

However maybe the question is different: why other devices are not
described here, while they should? Then probably Abel can answer what he
wants and what he does not want to describe. There is no requirement to
model all possible hardware in a binding, but instead describe one
hardware, so x1e, fully.

Best regards,
Krzysztof


