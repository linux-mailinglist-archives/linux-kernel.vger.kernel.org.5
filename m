Return-Path: <linux-kernel+bounces-73317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D285C0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADF01C2337C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED08763F6;
	Tue, 20 Feb 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncMU7V5n"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAD76056
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445630; cv=none; b=YoQGk8aMCzvf+om1RSlXz8F3+k+vRbONaFqBmQvGJJo6hDJtF+mZbRTuJmqUysFocyhNOxbTmdU6FXtsVD1qYnjO0GPsQ1ISdi4MSjraYSzr/rsAt2n27IDOsef/twshuLPzW0REnmFoZl0GMSou82eI4QRNFLShEMuE+ObuDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445630; c=relaxed/simple;
	bh=Py4SHR0JRtNjuKnJIDJC/OkQJeCpeC7w+tzz5P4+1TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtA71QqWGIhmblhjsLQmU9M7sHsthJXI9ENfKcQdIvkuE4+68Cn7TCjA/+yLjoc1x/HH46fv/erAC2Lnieh3plNBYl1MF9VyC5s9ETDYJdbF34A5ENhHF8aNsCDPdEFaBlZisPvSzOUYLIdu1ltjB7fBo7qsqOEiCVMBJqVeZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncMU7V5n; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so3814253e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708445627; x=1709050427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bXG0XHTZiid+f46cKfZFqP+lrSSpkVyuCCK9YrvG0NQ=;
        b=ncMU7V5nLlrDyQlQscwWYjXlI+fJAKSMcejQndhRcKJzLbKskcJ3LGNF7A3cxA4SRW
         o+TcgnVEUQ24/t3160xKwuW3hKKYjkk7uK0G5JOX1YP5I+INS2qzK3ed4S8bI7/Z4Yd5
         8801Y2mTzVslS4Qpdg8n5+fDQrIU0CKQ/hxpjXpMb66iFI/99yMoHfn2l4lRjJw/3dOm
         3sFSgJ09WA79szkgSnclQRK/8yDifDzqUiYtoksww+lB5AwBuTRnGi1kK3zWfjJVsoS8
         re47h4JyB/gYV1DcsgLqUdUX8lXgcqv+lMsWrIzsZgtrbwc0L6PGcVE9A34HGTo+43hB
         9vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708445627; x=1709050427;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXG0XHTZiid+f46cKfZFqP+lrSSpkVyuCCK9YrvG0NQ=;
        b=PajG4jGv5UsGy63oDDpooRLHsqAhIqU6HRKUocupESfUIcHsAv+FDsz8BaFJNgv0nA
         QnxD/bM3uDutd473Hz06qUIdNq1eBj4hiA5cC3eN/0FOxdwS6VY/wtQyzaG7pBJ2hjnu
         DOf1TZ7958QXgMifzKfloeVKmEysGmvHed/QmmLNh5ihN/1ldhOtx4YilS/5qJhkLVEa
         1d/+0g/IDTjV8ofA3MjCOD5iHdeDouDbJauk3d3f1T3WAoj6me7iFE6cHgHE5P7CF5J1
         07aTcB+wn62y7N7HHWB2X4XQUIZZOtjBkS+g90ghtt/fukfotLgWwpfEx+uex0+kqbGl
         AsYg==
X-Forwarded-Encrypted: i=1; AJvYcCW8G+xwVRr0mc7tdHA/n/j0xZiSDW5GG+jtsFlyErupiJnXtJV4MplHLefkkx3D196zxi31STuPwD3GZBIeA8YwP36m0dE5w6VyIBTh
X-Gm-Message-State: AOJu0YxFvEtYmIwQMJNuF5/G+Cq0HU9skabb80VtOufnLqgCZa8MO+KN
	dnF3d3+FQiWGmbXUZp3sNI4meWorovP5niTFXKv07qt6MumyuI3mXL9zirSWhek=
X-Google-Smtp-Source: AGHT+IF/u8KL9TZyoyWWqkbwgkWIME7QC2uuZcdoq/jqS+c8Y2JL5Ry0BdQxgTi+tvYSwJRE0AoiIA==
X-Received: by 2002:a05:6512:ba1:b0:512:bda4:bf47 with SMTP id b33-20020a0565120ba100b00512bda4bf47mr3504129lfv.4.1708445626650;
        Tue, 20 Feb 2024 08:13:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ek23-20020a056402371700b0055edfb81384sm3700656edb.60.2024.02.20.08.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 08:13:46 -0800 (PST)
Message-ID: <90e0dc10-8514-4827-998f-15b4d45d874e@linaro.org>
Date: Tue, 20 Feb 2024 17:13:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: clock: histb-clock: Add missing
 common clock and Hi3798MV200 specific clock definition
To: Yang Xiwen <forbidden405@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-1-b782e4eb66f7@outlook.com>
 <875b706f-801a-4a4c-8806-411a67c5a5e7@linaro.org>
 <SEZPR06MB6959456E59D84C15F0C1B88396502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB6959456E59D84C15F0C1B88396502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 15:06, Yang Xiwen wrote:
> On 2/20/2024 6:10 PM, Krzysztof Kozlowski wrote:
>> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> According to the datasheet, some clocks are missing, add their
>>> definitions first.
>>>
>>> Some aliases for hi3798mv200 are also introduced.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
>>> index e64e5770ada6..68a53053586a 100644
>>> --- a/include/dt-bindings/clock/histb-clock.h
>>> +++ b/include/dt-bindings/clock/histb-clock.h
>>> @@ -58,6 +58,27 @@
>>>   #define HISTB_USB3_UTMI_CLK1		48
>>>   #define HISTB_USB3_PIPE_CLK1		49
>>>   #define HISTB_USB3_SUSPEND_CLK1		50
>>> +#define HISTB_SDIO1_BIU_CLK		51
>>> +#define HISTB_SDIO1_CIU_CLK		52
>>> +#define HISTB_SDIO1_DRV_CLK		53
>>> +#define HISTB_SDIO1_SAMPLE_CLK		54
>>> +#define HISTB_ETH0_PHY_CLK		55
>>> +#define HISTB_ETH1_PHY_CLK		56
>>> +#define HISTB_WDG0_CLK			57
>>> +#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK
>> Why? It's anyway placed oddly, the entries are ordered by number/value.
> 
> 
> So this is somewhat broken at the beginning. It named after 
> histb-clock.h but actually they are all clocks for Hi3798CV200 SoC. For 
> Hi3798MV200(also a HiSTB SoC), there is one additional UTMI clock.
> 
> 
> What solution do you prefer? rename UTMI_CLK to UTMI0_CLK, add UTMI1_CLK 
> after it and increment all the indexes after it? Then the diff would be 
> very ugly.

I still don't understand what is the problem you are trying to solve
here. Your commit msg says add missing ID, but that ID -
HISTB_USB2_UTMI_CLK - is already there.

I also do not get why there is a need to rename anything.



Best regards,
Krzysztof


