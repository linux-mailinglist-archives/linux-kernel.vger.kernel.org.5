Return-Path: <linux-kernel+bounces-10673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E581D888
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 10:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D4C282163
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E21C31;
	Sun, 24 Dec 2023 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKSPhBpV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA315CA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso3736759a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 01:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703408990; x=1704013790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ahUPKt92hONYigUcgDHyggf6b+R+BYkSbn9Gja+1+U=;
        b=OKSPhBpVdr7FrVF1cZq1AW+kO/wqQwDVNyZhIIzkmWlpPWYFbr07mV8sNEmLlK60+1
         REvpiFkpldT0iB1SQdi/9jQq1yd7zx1F04gwzQ5xsz68Dyce8Nzb9lOOunZ1n7NeiTbm
         2WneqR4vMQ+uG+329TM0Ui7Hy5s9kCuhtK4G/7dofzT1aQ22rJp8fvhRrdZjAFbfxdBM
         CuCB4k2ikRjGPAVKylkQrdil/8wWEBnc3I8iRSbzt/ZDfH872NB2eNyYsKMFL4l6cV1q
         Am5WLfvePibtLqSSjMGEXgyNNJBf2waPyLqbrjxlZjTlJ6xR0j8nZ17R/hcIdU7KGT+L
         DIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703408990; x=1704013790;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ahUPKt92hONYigUcgDHyggf6b+R+BYkSbn9Gja+1+U=;
        b=W6mejnk3Xe/SuJKhC6AnC2GQ/wht+4KLQLkhu2w7/2XX7GKnGbYwOoJ0NxJUySg6MC
         unCLN0Njt18SlUjroVr78m6XoMf3gu2JwOx4z9hWAMeY4XmrARCu0Eoz1z1w/5Qs9f2J
         WWFe1PTa4FYAC82NDaPxtOs2J8oTArZpYbCR6I8/hwsrIZaoIvcMpGv/Fh93RpZjbrbw
         yKc/AaZj2FATxpi3PY8GbxJvKlGisveflKe6weuX+zQ3h61wlaxPJB9boe+eXyWGIzIA
         uS6Mpu+NaJ5U7x+JmRbiKU6libWKJV5/5XqwYbBO8Fuv71hHg1z+jkeK4I6BiNaFfilD
         DoSQ==
X-Gm-Message-State: AOJu0YysLF63R9TC66kWN0HdARCiVhO3krmJXJE/DjnXpeNizbKq2xs3
	H8xGWi+TiylDbyvLj5J4K1r9hgtFolQL4A==
X-Google-Smtp-Source: AGHT+IFet/WmYMfv0IiYS+M4ysfiZApvLfjMgkeLl/ZfzaAdQW1ngYenxiwU3fQGv7gG5P8CIgxt2g==
X-Received: by 2002:a17:906:217:b0:a23:309b:e0cb with SMTP id 23-20020a170906021700b00a23309be0cbmr1830456ejd.155.1703408990725;
        Sun, 24 Dec 2023 01:09:50 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id kx26-20020a170907775a00b00a1f65433d08sm3858248ejc.172.2023.12.24.01.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Dec 2023 01:09:50 -0800 (PST)
Message-ID: <5676cb8d-c1fb-4b01-b0e0-beb76f2b6ca5@linaro.org>
Date: Sun, 24 Dec 2023 10:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint
 compatible string
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
 kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
 l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
 <20231220213615.1561528-16-Frank.Li@nxp.com>
 <8fb359da-2d35-4cea-8a62-199fde1d9a29@linaro.org>
 <ZYe30jb7dxRxQ3hr@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZYe30jb7dxRxQ3hr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/12/2023 05:47, Frank Li wrote:
> On Sat, Dec 23, 2023 at 07:44:30PM +0100, Krzysztof Kozlowski wrote:
>> On 20/12/2023 22:36, Frank Li wrote:
>>> Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
>>> Add reg-name: "atu", "dbi2", "dma" and "serdes".
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>
>>> Notes:
>>>     Change from v1 to v3
>>>     - new patches at v3
>>>
>>>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 52 ++++++++++++++++---
>>>  1 file changed, 44 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>>> index ee155ed5f1811..be9ea77ce8548 100644
>>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>>> @@ -22,14 +22,7 @@ properties:
>>>        - fsl,imx8mm-pcie-ep
>>>        - fsl,imx8mq-pcie-ep
>>>        - fsl,imx8mp-pcie-ep
>>> -
>>> -  reg:
>>> -    minItems: 2
>>> -
>>> -  reg-names:
>>> -    items:
>>> -      - const: dbi
>>> -      - const: addr_space
>>
>> No, why? Entries should be defined top-level. If you remove them here,
>> where are they defined (in which schema)?
> 
> See: pci/snps,dw-pcie.yaml

OK



Best regards,
Krzysztof


