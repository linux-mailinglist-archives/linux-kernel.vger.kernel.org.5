Return-Path: <linux-kernel+bounces-126914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1ED894465
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2141C2159F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75F84D5A1;
	Mon,  1 Apr 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k86hrYDQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6362BA3F;
	Mon,  1 Apr 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993142; cv=none; b=hCl+VRJhbfVE7t9yxQJFxD45/qNX0iUgwtZrpcW0cATkyaLMSibB+upg9yFGoHInR03JN4d0KC9UANNe9r3ujdb8LMsDQq40rEYIUklOW65rdxoRM+9k72pFrgErBK1PIrcIdLU6iNHIA6GKCiYgBwWmxsW6I+PxI5mYIAb+87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993142; c=relaxed/simple;
	bh=eOCBxCgd9egu/uRfDGj1oTW5tW/gmoCdL+IfWczrtlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFiv7dXX8m9yy5dpB4SVYWIbXLKJPjpEs7GGXY9nq/Bh1RxnyijFH68sbjdM7vC1aTMcxtkrff5Y8SAL8fipdcSQkNti1aW65l12Xn5ZfG7ewCVaGLTlvzc7vkTP4p8ZCbKGZ75HH+yeVkjy/76W5VYgK7hXFqrSxyNrpNN3KPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k86hrYDQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0025ef1efso27980255ad.1;
        Mon, 01 Apr 2024 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711993140; x=1712597940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuHBdAm6bG+x3991K3l56+e/5a3asJZAEp2Z/vswAP0=;
        b=k86hrYDQcluogMYj+HaY2cZdHrq08clnYXgInPpnFCYIcuJHu7DY7ApyEj1QMI2I9+
         OZ5ldeE3iTplOWSiIGuacprvBl7rqIRCyqnJo3RL55v94Wm6TFpDb6svmkS7GCHrheat
         qfygh+0/9wrmdXskLLSd/V0WHW6KdItlWRSFjFcsyoFxn9uolc9BoKZVUHat+OCN7rd9
         OLXLeNe8ZSfkJF4qW34b7SKgP8JtyQjMohR+MtdUBmSHG5SUo933T9aR+Co8FDORxZ1z
         GXvGxtZi9wR/u1odEq/42oLZAtdTuj2F4vSNBzWmcQjwlyFi97UvX95j7hFug51a3TfY
         ruXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993140; x=1712597940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuHBdAm6bG+x3991K3l56+e/5a3asJZAEp2Z/vswAP0=;
        b=cs/se2IVoJ2D94942AlyZtS/j2M/6DOgF/TbOyacJWN/ecXy6BXu+Gt7KRXYP34TH+
         rQ0zaJZ7Ni0ts2qfk7rrcrPaAMY7TVGjYBrIHZyNsU3AssH8nSvANYnU7g/N63VAvS9p
         8KE/XE1rBjbkYwyFOYLbQlRA0LjZbmnBGgw0i5cilabxdhybZe/wbkKUGbEKj+ge3wNi
         l+rKtYdxlCFsNe7woyK+fjzyVa0k3EOvmKQVAST4HRgahS1cNidKxrSbdO6HwFyO8q9n
         AeteUIOlz5/UQ+mhD08VJvDhft8UTVZ96Vsu7h/x2y/i6sFL3RRWRbG05FZIcAbFAs+u
         /diw==
X-Forwarded-Encrypted: i=1; AJvYcCVLh+0NsSGsUhI2Y2GPCaySnBIuEsGVhoFKoaN6KZkTHkc1A16b6TWqhD75q1K51G7xxd2S2R9huynh9ZdedyW/hovRWzzu9TploQuKXEnGqBUu3bRMY1Op/ZsrZvJNBNQtmN8TxgeR3ksGa6O76ABAGW0Gmg9kJ/yPMW+pYTFmnx1C2qLG
X-Gm-Message-State: AOJu0YxsBHcSy7ozUgTwyD/Zw1Ia/J+MInKRsbaNoqxmwzorkFywXDI6
	6qLzy1tM1HHSPQSxUrJAu+bJFEgliUJSktjKP9CNZ0JcYZnIGaWQ
X-Google-Smtp-Source: AGHT+IEi7wdEb+LyhC3W/JvLP3/0ARCKgHKP7YsCRmImEvoAEcCSa/W7BQKezGxf6hMzkHv1zXdgMQ==
X-Received: by 2002:a17:902:ea8b:b0:1e0:c74c:dfcc with SMTP id x11-20020a170902ea8b00b001e0c74cdfccmr7136215plb.57.1711993139774;
        Mon, 01 Apr 2024 10:38:59 -0700 (PDT)
Received: from [10.5.5.43] ([117.239.226.201])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001e245d90d6fsm5224810plk.59.2024.04.01.10.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 10:38:59 -0700 (PDT)
Message-ID: <bfce7a40-f657-4e80-a607-d242d79e6b80@gmail.com>
Date: Mon, 1 Apr 2024 23:08:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
Content-Language: en-US, ar-LB
To: Rob Herring <robh@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240401043505.40972-1-agarwala.kartik@gmail.com>
 <20240401151414.GA706943-robh@kernel.org>
From: Kartik Agarwala <agarwala.kartik@gmail.com>
In-Reply-To: <20240401151414.GA706943-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 8:44 PM, Rob Herring wrote:
> On Mon, Apr 01, 2024 at 10:05:05AM +0530, Kartik Agarwala wrote:
>> +      A list of the connections between audio components. Each entry is a
>> +      pair of strings, the first being the connection's sink, the second
>> +      being the connection's source.
>> +
>> +  mediatek,audio-codec:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: The phandle of the WM8960 audio codec.
>> +  
>> +  pinctrl-names:
>> +    const: default
>> +
>> +  pinctrl-0: true
> 
> You can drop pinctrl properties. Those are implicitly supported.

Hi,
Thanks for the review!

Just to clarify, the removal of pinctrl properties should only apply
to this section and not to the required properties or the example,
is that correct?

Regards,
Kartik Agarwala



