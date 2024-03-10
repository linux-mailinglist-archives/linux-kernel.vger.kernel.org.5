Return-Path: <linux-kernel+bounces-98247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D90F87775A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD71F21E34
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1BB37160;
	Sun, 10 Mar 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRtWTvcs"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD72B9B9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710081256; cv=none; b=DGGZKWg/EZ7a6zLX4I1oZpfitXCxTjgsjVIQ4kyrQnomptPf7UdoAiV2AXITla6wFlCAXLps1SlNcVjq7GXL6JT5rOC2akMQInflNxxG5VB40qrIJ63I89c/6kXZ+7MNZ7321A5vAKTCUHgcMSVmLHphj+gPj7+eyt02D9nPN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710081256; c=relaxed/simple;
	bh=3pCYoj0Xo+mY1ZJs3a1PwScqciz4Fnq23XZcuDVyuFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXy5tE9otUnbh3E6DLM9kMDvHzzetD2LXh2O03v9QAZ8GFF7CQSIe0Rs5zo4ISmKBBek5wCnf4HUeKH4IrKjs8w7AgfNRgb127t76PKt2jK7NFpWC5D2j+pleFs1rSMZXn4xaxISOEye2IB+BworymgaSz45DwoQo63vJjBBMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRtWTvcs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e8e9a4edaso858084f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710081253; x=1710686053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4YM8nn+gwNhKNb13sGum9VdDxUI/DDISGOTUbgSJ+c=;
        b=dRtWTvcscz44yr6dPGKqEu5B9eVqpswF9QMfiCU523T3F3KzOaHcn5qdi7uDBV9d+6
         BM2L0deG0/x0SzgnIuFhZOCQ2MElRipQonLn4Jwlcmr7aqt7oXe7tL5DS+4GeADFGQWQ
         79epOTWc0/qDZlPNUqNYE5bSxSvdnRxPq6ve2FEYnNzWzVtv1553Y94RFUouaxyO5xKY
         n9RH8T9bVOKgYrJrxeGptwaCnvTDbBCXCr9JISEyt1Q+Ofdz9JJjn7CH/gmUbJS5z2sW
         wjgNmmzIYK6GXg+xVTTlMwdDe03SJrVwEXQK95F3VpdpbC5SGOHd/2nZUOxsDt/6jVem
         iKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710081253; x=1710686053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4YM8nn+gwNhKNb13sGum9VdDxUI/DDISGOTUbgSJ+c=;
        b=QYOBlH+kVcdxRTfzn9ipsF/8VjV7L7ZjzRjElpYZ8+yzIOYdLDcbiChEjYBNCrf4ND
         FDTW3mUyT7x/GB5F9m4l+3MEDAmTOy+yZ/zoBvCBHbePcWP/RJqbOHc5FL3IMmG6nNU3
         u41Za8HjV/Xd3R6Wl9XhjynapNAsOmmHDChrV74hULPGGlQJtQ/WRFcVfiysH81M0qzO
         zPd4QJDPcb5jDBgUHLFBVUz5OEt6KxS8rLdzA45k1rQiFFsTLzHRKfPjc+c/K6t6DsZG
         5OyIzeH+Q23lf9+lI/+yoxpFatltgNyp8PnPNjjwGLe0lFTDTcSdhh8svaJZIggSSck4
         pMmw==
X-Forwarded-Encrypted: i=1; AJvYcCXIf6PlnPeQ/OR2gJG1pHk/MJd7IXWabAaGzHnVmtzlv7xn6RJUQpKwuOsuzhIsCIFHYHIoNZT1JiMhJwsSFUOZkO7RRB9kLdaxKzMK
X-Gm-Message-State: AOJu0Yx6G66mGgCE2sMTrAHpLJ+aDk5iR0XxSuxonc/Ue+ZJhWuBM5XZ
	immiVB5M+/fVp2B2a3tJLEElvQRraUyEFMWyUdrYU7leKbBw3phzcKvDDA5RavA=
X-Google-Smtp-Source: AGHT+IE1ACpa17cb3bHbmnb1y9+NlMwOwJZLo414I/MyKOVC3lDj59agmNDg6uxe72YQEuSUnanUtw==
X-Received: by 2002:adf:cd8b:0:b0:33e:7cdd:b559 with SMTP id q11-20020adfcd8b000000b0033e7cddb559mr2979995wrj.56.1710081253018;
        Sun, 10 Mar 2024 07:34:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id by19-20020a056000099300b0033e8c50fc3fsm1940293wrb.90.2024.03.10.07.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 07:34:12 -0700 (PDT)
Message-ID: <f7d94072-eb4e-4d67-98d6-8090362a01e2@linaro.org>
Date: Sun, 10 Mar 2024 15:34:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: imx-pata: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240309160741.54096-1-animeshagarwal28@gmail.com>
 <a26689a4-1c8c-4458-bb82-137cd1ac21d0@linaro.org>
 <CAE3Oz80TByuu6=U4PTOHO6k1=KjjRKtPPf7ayhSMZareXP8vdw@mail.gmail.com>
 <6b065dce-5271-4ea0-b291-a7aae8e71d20@linaro.org>
 <CAE3Oz83uiCyxV3u1C-5=vmBt6RxnTM+LJCw4KWyJDB2OLn-dRw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAE3Oz83uiCyxV3u1C-5=vmBt6RxnTM+LJCw4KWyJDB2OLn-dRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2024 14:36, Animesh Agarwal wrote:
> On 10/03/2024 at 18:37 Krzysztof Kozlowski wrote:
>> Please respond inline, instead of top-posting, because it makes your
>> emails hard to follow.
>>
> https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/process/submitting-patches.rst#L340
> <https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/process/submitting-patches.rst#L340>
> 
> Already taken a note of it, will follow inline here onwards.
> 
>>> On Sat, Mar 9, 2024 at 11:38 PM Krzysztof Kozlowski <
>>> krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 09/03/2024 17:07, Animesh Agarwal wrote:
>>>>> Convert the imx-pata bindings to DT schema.
>>>>>
>>>>> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - added fsl,imx51-pata in compatible property
>>>>
>>>> Please explain the differences done during conversion in the commit msg.
>> How did you solve this?
> 
> Added proper explanation for fsl,imx51-pata addition in the compatible
> property in commit message of v4.

I don't see anything about this in commit msg. Commit msg is exactly the
same as before. Try yourself - use b4 shazam to apply your patch and see
if commit msg contains that information.

> 
>>>> This allows only imx51 and disallows imx27 alone, which is not what old
>> ------------------------------^^^^^^^^^^^^^^^^^^^^^
>> How did you solve this?
> 
> I will resubmit patch v4 with more explanation.

You mean v5? You need oneOf allowing usage of imx27 alone.

Best regards,
Krzysztof


