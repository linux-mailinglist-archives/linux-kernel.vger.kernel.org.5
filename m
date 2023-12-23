Return-Path: <linux-kernel+bounces-10552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EF81D61C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66F21C215B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BA14A80;
	Sat, 23 Dec 2023 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwJcPA0P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097912E5D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5534abbc637so3105027a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 10:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703356983; x=1703961783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+gco8BLqAjcPdkrZdCffxU9a4mlAf+P/uZCUnr+h8c=;
        b=ZwJcPA0PAXjWeQkreV0XnGWRludNXBC0WxAtIC82ZxbC51xH+1DQYfvTv7BymyiBLE
         SY3mkcrMIU/zkfjZKZVIcLDNYuxqnO+IKV4jht1q1GT9IJPtFjOBofNicPI4IuVZU/aM
         7VQu2sbpujvi/J9PNbHZuLetrSSExSl6gFCFJpBBnm3lj+vTiNBx1nx74bOjTOSIDyZA
         AxkXHKCpjLBI6U/n+RF8OXCZtSC9On7GIBwuM9d+q6GskTARrU6FjybClnUyO5w8dD57
         OFx1zoXsijORFl9WMSfeLkO7zoWto+VNXN8ZdHIi57eGqh9dsgDSsRiCKODVowGtOuLY
         Azdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703356983; x=1703961783;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+gco8BLqAjcPdkrZdCffxU9a4mlAf+P/uZCUnr+h8c=;
        b=RUaB7c+vtBslDq44WmPSxS5ZbX4CN12ed+/BFKZavDb6IS5nMQQx3QRcAgtbFiSleC
         gn9bbCBuFejWemNp8izNVNHg0fWffC7tpvB6Sm3MqdAud9mEkmZeLmvaOs/uQpRs9yJh
         PwFU5LsYjiByTivbzownDJDvQzIv1tZrlSh7TTjXdLou4J+Kqyy7yCXPqMhzRk8aIdI8
         iaRLwypg1hYwSfsvenMK70+vT5LPX1+KudZqh4m8Iyb+u1hcRJuhtLkItLNCvJA2h+uB
         kjOZ4zBab406wRKtKLfKwmPDtCsQZeHkbVjClCt9IgTi/NTGO6695r61faTUTBQKGWQA
         PlxQ==
X-Gm-Message-State: AOJu0YwnimSTkClmY9z8pablH3mPVOCeJMuVXePHhYnvjiY8XPpugaNh
	yvXUN3X9C5yyghxDjwWT0eTaGc7tnXYtWQ==
X-Google-Smtp-Source: AGHT+IH1RiLXz8KYuAkcsiOD+30BiDaipZUpG48Ja6HREcXMHcgv4XmU6K31QzIKR74j9wAUxJoFkQ==
X-Received: by 2002:a50:a416:0:b0:553:34d3:2ba6 with SMTP id u22-20020a50a416000000b0055334d32ba6mr1964111edb.78.1703356983635;
        Sat, 23 Dec 2023 10:43:03 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id p13-20020a05640210cd00b0055298b38768sm4197774edu.80.2023.12.23.10.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 10:43:02 -0800 (PST)
Message-ID: <524646e6-17d4-4a72-be96-74347be36482@linaro.org>
Date: Sat, 23 Dec 2023 19:43:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/16] dt-bindings: imx6q-pcie: remove reg and reg-name
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
 kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
 l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-11-Frank.Li@nxp.com>
 <20231221225033.GA228866-robh@kernel.org>
 <ZYZYFYBr23OtTtrd@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZYZYFYBr23OtTtrd@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2023 04:46, Frank Li wrote:
> On Thu, Dec 21, 2023 at 04:50:33PM -0600, Rob Herring wrote:
>> On Wed, Dec 20, 2023 at 04:36:09PM -0500, Frank Li wrote:
>>> snps,dw-pcie.yaml already have reg and reg-name information. Needn't
>>> duplciate here.
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>
>>> Notes:
>>>     Change from v4 to v5
>>>     - add Rob's Acked
>>
>> Err, that was intended for patch 9, not this one. This patch should be 
>> dropped.
> 
> Sorry, will correct it.
> 
> Actually I want to move it under Allof
> 
> if compatiable string (A, B, C...)
> then
> 	reg-names:
> 		-const: dbi
> 		-const: config
> 
> Differece SOC have difference reg-names required list. If split it, it
> will be easy when add new SOC. Needn't change two place.
> 
> Let me update at next version.
> 

This patch should be dropped. Why do you remove entries from top-level?
Are they defined in other schema?

Best regards,
Krzysztof


