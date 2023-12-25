Return-Path: <linux-kernel+bounces-11146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30381E20C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B04282314
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB2537F8;
	Mon, 25 Dec 2023 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECN7E9CP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BC52F77
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1915034144so465122166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 10:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703530586; x=1704135386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e0m2oYSxkojWokgkCEhU9gfgYOM8HLqvP29A/Xkklb8=;
        b=ECN7E9CPmaTopcdFTCZTw7e770xcQbW9xCc/bAA6nMuGy+Q6ZlQkEbV0WQhWv4K8yE
         Isi+HWbywGNtNLpp2TxUfrHYylSJ8ZTPg78UL3+DTxILZXiaR8nLaW5hKW8Hutq4OGTj
         mqxssX+zMupcB1+WWTVYUTtzcY75ebe12eX4LNkbxUZsQE95X3ENzv2Hp3lofa/Tcpzw
         44kpVvC3wk/jYuNHZM8cRk4pePRyTyv8xdTmS+gYzToK3zl/jKBgksEd36YadEEotk70
         UItUifu94Qx/E1dCVVlGpv4maGOPcUtOIxh9xjlz2l8yEj7ZYo0vAwJ2ybzQaTdBLqNq
         bktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703530586; x=1704135386;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0m2oYSxkojWokgkCEhU9gfgYOM8HLqvP29A/Xkklb8=;
        b=lMZqlBe/sw5bXXJDhWnLI+EKQmFVI0jWVj+AVAZK98Fu0EAgVZKztPCAemEMq1ZgxE
         RL0uvxIB7HCZMoiJhzFT2TDJFPDAwQFTHOOu4mfIoeTpJdYeALapdgP/Zp7X75QK1Nql
         KuSnp1qnfiV4HoVz6e7xWSHbJSdAPsAL5uu4peKJXQIhCxMqW5bnMvGYnleE1/oJMEgi
         cOm9L4UGfc8nWTPqrZNMRkzoeptn1IYFqBQVpr8SXMIwiy/FoGfRuzgb6g4GndzimL2/
         BpEGEWgfjQXHIVQ5tioVatzxjizGP52G1ZBxp/9DRsIwsP7rXusaReyuK8Oms+o1Y74e
         Lnww==
X-Gm-Message-State: AOJu0YzSbLb8vdpzQjEG8EsOvFfnXZ7Z95biPSR/GDNEoPGDlKXkyGrj
	UkzmTxoB7Xvl3hS8QgntgjDWrocuMJdFtg==
X-Google-Smtp-Source: AGHT+IFmnuMByLlheyTomN+Gnxg9Qg5gNXvmIwB1Sb9hT7HCxikp2uSTzvtRpm5hq9p+iuMHbFF8rQ==
X-Received: by 2002:a17:906:af90:b0:a26:884e:49f3 with SMTP id mj16-20020a170906af9000b00a26884e49f3mr2584418ejb.94.1703530586133;
        Mon, 25 Dec 2023 10:56:26 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id l1-20020a170907914100b00a26ac037ff3sm4471949ejs.132.2023.12.25.10.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 10:56:25 -0800 (PST)
Message-ID: <1b54a167-1c90-46b8-8a7b-a21f5d4655e7@linaro.org>
Date: Mon, 25 Dec 2023 19:56:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml add spi bus
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-4-petre.rodan@subdimension.ro>
 <b23a6b74-a568-4e11-8429-6344e10a9937@linaro.org> <ZYmcNySur-ZQryWc@sunspire>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZYmcNySur-ZQryWc@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/12/2023 16:13, Petre Rodan wrote:
> 
> hello,
> 
> On Mon, Dec 25, 2023 at 01:59:43PM +0100, Krzysztof Kozlowski wrote:
>> On 24/12/2023 15:34, Petre Rodan wrote:
>>> Add spi based example.
>>>    There are many models with different pressure ranges available. The vendor
>>>    calls them "mpr series". All of them have the identical programming model and
>>> @@ -88,6 +88,9 @@ properties:
>>>        Maximum pressure value the sensor can measure in pascal.
>>>        To be specified only if honeywell,pressure-triplet is not set.
>>>
>>> +  spi-max-frequency:
>>> +    maximum: 800000
>>
>> So you miss allOf: with $ref to spi props.
> 
> for simplicity's sake and for compatibility with the i2c devices already in use,
> this driver does not have distinct 'compatible' properties for the i2c and spi
> implementation.
> this is why I just defined spi-max-frequency, used it in the spi example, but
> not required it. just like in hsc030pa.yaml .
> 
> without a differentiation in the 'compatible' string I don't see how your request
> can be implemented.

You cannot have different compatibles. I did not propose it. I wrote
nothing about compatible. I wrote about missing $ref in top-level for
spi-peripheral-props. Where do you see anything about compatible?

Best regards,
Krzysztof


