Return-Path: <linux-kernel+bounces-86683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1D686C8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D07B22CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A47D090;
	Thu, 29 Feb 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4tYd70x"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D77D096
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209014; cv=none; b=EguoZsxwntYseCr6GogxPR0WShtl4Q2KEQjcx3OiNzMdwwPcA1VAI5xJROYvkWldUEutm7Y1d1twCT8c1fG+7Vbi2CL1kv5IBCPxJHW6o/jDdvNlMcYddFzyHhlHCgUvtFbZHVnapyQadOIUGRwGTtJr+Js4q7cwuwS1RQ1D+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209014; c=relaxed/simple;
	bh=Subnlbq9ukBTdcDxZGekPE3doKjkOdUyd/6oTnlz53U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaf/QITnavGXWoNUOZOKfa8hYtLENkzegREf6SJtspmLzntTnsIlLKyJN48FLcAkCWqWSx+Ch1wv3v6eWi9j1Ehklq8GKu5Mj/pOYkLYteHx72x0UzsrCOFNH6pSZmuasrMKK5voJoa++ycrfcnG9o+X6ZI3Sp4rZpxi6fS/sp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W4tYd70x; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a441882f276so118128566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709209004; x=1709813804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLX7C6230jQYiDbyGpCWMxcnBUELrjpD93ih7q+7c8Q=;
        b=W4tYd70xt4AJvh8085w4fLxlLNNdsXXdYH3xYFgvKG8BwEvIP9jq+Btem++R9NQPmu
         aFNeK30f/0IVS7i2G0dCg8WkdIMwoa6a0qw8InRMCLBa718QyqLHxccoWpHkqXjpWlGR
         HuSoQCVaBW32+1fkO12SnRfPq+KbNLLKD8OF0Fs8SdcE8sMQf+vtyqjozUkMUDnNV0dJ
         f2djVUbQQ+8r1hGZDW085+cMjSCjb7Cz1QIlig0dGgHSeoJuHkfowAiAbjR+qpQmm1CE
         Wc4ucH6FYZ1tjWsyehs+4Q7tNFIhneH9fW4xJ3SSwr6AXc958Buma247OViGM2lPPNsa
         xyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209004; x=1709813804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLX7C6230jQYiDbyGpCWMxcnBUELrjpD93ih7q+7c8Q=;
        b=Eo887YrOsnNsw/ffyq8PolqZFy2SMJRl3+hsGMZ1A+/iLGx3aEEU5y5/d+Y0ZfpjAS
         X+JW2UiSpLhf41gZ8qh08UMdvkcWsWMRMTQMAqdiLidt7isZNZdLw+mOJtRBQKnS/4FV
         c0ZKoCw6kwuMrTOhInwXWcEfsLwrJ9GaRdEyyUT3MDC1f3cLlcuSdNsHjZoJn4j6AArY
         q/8ebmKWnIA+5KzTCeTS+7ap/pqJ8mHlwXAbqFSlxe3r1JmG8TuUczc7mWPr3jM9kqVi
         S9It0odywPOZj6p6o+VT6mYvWF5JzdaWAbhAlfTQlpXcd6qINlSoL/b2eeJbNcy/rJEF
         fpMw==
X-Forwarded-Encrypted: i=1; AJvYcCVNZS4AJRbl7gJKVOl3OepeW8g/B2upssjz4QT8Ryg9/R6ZewOwYqFgxYSM7BwTx1tqxfpFWP55oQSjqKQCJnTbtZ7c/HI90lC6Yr0a
X-Gm-Message-State: AOJu0YzwvrVio5xCkJ3rLnulANsH3jMN7RdlEjEBOorvQ2RzuteNESU+
	ZufIjXr9GS/yWHXoRWXA6yEdJUuJwcYi445A+OOiiKXe+GyRCt+1f6S96jPL3FY=
X-Google-Smtp-Source: AGHT+IFp5mf2iupLd8cVbWGJCRW3+HVMaHq7WUBwASaF4SUyl4vBjnsWV2FVhH0TjY8HIZOSVyXgww==
X-Received: by 2002:a17:906:d0d9:b0:a3e:dfce:daf0 with SMTP id bq25-20020a170906d0d900b00a3edfcedaf0mr1332820ejb.39.1709209004238;
        Thu, 29 Feb 2024 04:16:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dx7-20020a170906a84700b00a3f45b80563sm630715ejb.77.2024.02.29.04.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 04:16:43 -0800 (PST)
Message-ID: <0a7a8e83-8724-4bec-8b3d-a58cc0a70395@linaro.org>
Date: Thu, 29 Feb 2024 13:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] media: dt-bindings: Add Imagination E5010 JPEG
 Encoder
Content-Language: en-US
To: Sebastian Fricke <sebastian.fricke@collabora.com>,
 Devarsh Thakkar <devarsht@ti.com>
Cc: mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.gaignard@collabora.com, laurent.pinchart@ideasonboard.com,
 praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
 j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com, p-mantena@ti.com,
 vijayp@ti.com, andrzej.p@collabora.com, nicolas@ndufresne.ca, afd@ti.com,
 milkfafa@gmail.com
References: <20240228141140.3530612-1-devarsht@ti.com>
 <20240228141140.3530612-2-devarsht@ti.com>
 <20240229102623.ihwhbba4qwzvxzzq@basti-XPS-13-9310>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240229102623.ihwhbba4qwzvxzzq@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 11:26, Sebastian Fricke wrote:
> Hey Devarsh,
> 
> On 28.02.2024 19:41, Devarsh Thakkar wrote:
>> Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is implemented
>> as stateful V4L2 M2M driver.
>>
>> The device supports baseline encoding with two different quantization
>> tables and compression ratio as demanded.
>>
>> Minimum resolution supported is 64x64 and Maximum resolution supported is
>> 8192x8192.
>>
>> [1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
>> Link: https://www.ti.com/lit/pdf/spruj16
>>
>> Co-developed-by: David Huang <d-huang@ti.com>
>> Signed-off-by: David Huang <d-huang@ti.com>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> hmmm when did Rob give his reviewed by on this patch? (As this is not a
> DT binding I find that odd)

This is a DT binding, which is clearly expressed in subject prefix
(proper one) and the patch contents.

Best regards,
Krzysztof


