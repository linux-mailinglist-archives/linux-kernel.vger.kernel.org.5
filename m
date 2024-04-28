Return-Path: <linux-kernel+bounces-161241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA88B4961
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8FC2824BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC22907;
	Sun, 28 Apr 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5N24bS+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25BB15A4;
	Sun, 28 Apr 2024 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714274736; cv=none; b=sFQGO9A7fmtLWX5MYmTR5qjTl5wxt4B+NEnTshbH/piNY6ETVcc9vRclHin6R+CShy1N1EOFBNzLkrW5XlvHSs2PgZ/eY47M6vDh5RNuWgD7a5m8modRAK86eRkpaozAXYyA4RH9z+cNFNQWeihGPsTA09X9Ohs4j+OFELiWAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714274736; c=relaxed/simple;
	bh=OcskZBciLjsORKdfrVamfRMlfN8PTbCSuVeVFP5J418=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfGosJPoLoiSsdt+Fh2OYhV6uG8/0tmQwTR4MzrC+y/fWdvZoiLGkYlWtVUnv6OhsAxcYjGBapVP1rhsHd+lXOBl5UbqXW/jQsZUR02Kx9ty/0EW/tgMMOW8n5VAkRk9pCgSo6FysOUl6LmZaInCvXvmMQOeAaZ19ZKMNdn5KbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5N24bS+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2af800ff18dso2849564a91.1;
        Sat, 27 Apr 2024 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714274734; x=1714879534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLIp3eAfQD8CQMCKFDKg8uIvyN0SEXktzvJZCsva1y4=;
        b=S5N24bS+z4vparNBzBBtmLS5XzplBasU6yz4vWTU0j4s6KSeIpgDIo8lVtlTQy8EeZ
         2WBwyMlzwjH92j8BY8eAKbLMuogCKSINPrAHafDXIus+fBcboSdLvunlT4OgAnWpShZV
         rrIzBFbVZMjyl/zcvV2HIHzosCUCft6KwsD2WqWlhhzEryGgWiywukUeDwPEvl/BHMMx
         P1f7tc6F5TVN9zq4xsYSASQKYCW/sl+Ul6iRCTsk7m2Fayly59WtQDrUz9qV3NPURFmM
         nU7gPFKTgGSz535ihvRw+eYCvn3oC+V2z4ySUDmMBx8V5ozHzjFBQV3SIRDNBuMzhLOy
         D9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714274734; x=1714879534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLIp3eAfQD8CQMCKFDKg8uIvyN0SEXktzvJZCsva1y4=;
        b=gGCf7Zocg0McsvHP9SSmbfbu+tY9S6weW0OwSiOum6upYpeiZWEoO1ZpE7Kthf4OTJ
         8vY+vLJyV7p9GUYfnWQoDIdllPo80elHMVzWYdvexRl8xV5AOOkI6kY8uZvUqb1FEQNm
         yGc6KWcLQOA1nsDQQlxW0Hvk63GtwAc0AwQ1vAYow3Zma7lqxsVIxrfxWyKXTKkC+GjY
         aSQYLz4tXeFX3TxxrCiE0Tuq7l9EH6j3N5kZeI3Na7Ys0SMNRnboaQ4eKDJizSkplQdu
         pXRHka0jk+Y4OyJF4SVU4CvdL9oiMr2iR0lWz7X0qk7M+lS4ifZNvND8FxyQltecjUoX
         Uw9w==
X-Forwarded-Encrypted: i=1; AJvYcCUvHqglVh3Jgu36cwE+kouf9T2wA5v7qD4esqjtY0PN8yuYS3BRgLKJB7WYbSYpOkPSbVkqEm5vdshFbvGyySj+ZXH2FKpHXq75XiiNjRnc2JBHJuDURqjMgjEeSAgpVu9r3A8pK+xTM8i96jug9eD3+/AsRN2ZubqMFzwZFomaBMQ2EaEzrgbnPYlnB3GsZ9lSJiZrLPpA8iK5UGXW+KGb6qQ=
X-Gm-Message-State: AOJu0Yy8mpTBlJVhNNih8Jt/eVNtUKk+ZFYHkeFBq5Z5aIVA9YQaH5Ul
	IAy9JWP3xha/1TuCDni3fXPjUlhVjCl5Iyp6Dx5yRt3SW+/PEwVz
X-Google-Smtp-Source: AGHT+IHix91u6ZSVql6QvYGRpmSFoZAiVGl8I7Ra5uHUolRC1CoBqUEI9EePwejfhWQ0cSao0pGHag==
X-Received: by 2002:a17:90b:8d1:b0:2ae:78cd:59fe with SMTP id ds17-20020a17090b08d100b002ae78cd59femr6972814pjb.31.1714274734037;
        Sat, 27 Apr 2024 20:25:34 -0700 (PDT)
Received: from [0.0.0.0] (42-3-109-144.ptr.netvigator.com. [42.3.109.144])
        by smtp.gmail.com with ESMTPSA id pa5-20020a17090b264500b002b113ad5f10sm1189336pjb.12.2024.04.27.20.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 20:25:33 -0700 (PDT)
Message-ID: <cb1ac16b-3491-425d-95d0-91fba64d78e6@gmail.com>
Date: Sun, 28 Apr 2024 11:25:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] dt-bindings: display: panel: Add Synaptics TD4328
To: Rob Herring <robh@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-3-e0aa05c991fd@gmail.com>
 <20240425161134.GA2695912-robh@kernel.org>
Content-Language: en-US
From: Xilin Wu <wuxilin123@gmail.com>
In-Reply-To: <20240425161134.GA2695912-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/26 0:11, Rob Herring wrote:
> On Wed, Apr 24, 2024 at 11:29:08PM +0800, Xilin Wu wrote:
>> Synaptics TD4328 is a display driver IC used to drive LCD DSI panels.
>>
>> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
>> ---
>>   .../bindings/display/panel/synaptics,td4328.yaml   | 69 ++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml
>> new file mode 100644
>> index 000000000000..216f2fb22b88
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/synaptics,td4328.yaml
>> @@ -0,0 +1,69 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/synaptics,td4328.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synaptics TD4328-based DSI display panels
>> +
>> +maintainers:
>> +  - Xilin Wu <wuxilin123@gmail.com>
>> +
>> +description:
>> +  The Synaptics TD4328 is a generic DSI Panel IC used to control
>> +  LCD panels.
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>> +      const: syna,td4328
> 
> You need a compatible specific to a panel. This can be a fallback
> though.
> 

Unfortunately I have no idea what is the model name of the display 
assembly. I wonder how the compatible should be named in such case.

--
Thanks,
Xilin Wu

