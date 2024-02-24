Return-Path: <linux-kernel+bounces-79621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F538624CB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9CA1C21874
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED43BB46;
	Sat, 24 Feb 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fG1+bxo1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91312D600
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776142; cv=none; b=mxCenB1f+3N7RYQ3CwfztoQMZFgB3Ep/Xv2DWWRlX5VJyKptIWroz8qyBFSFJtXPJsjdRrHcNPZfsTK69rl71D31h5fmqsUCa0kIJwZxHqqnlnoPJTaco7aBVpbnxM7rTzDGGl3AmMtCYG+JG6Cxq+UFBarE4VZUAUjy7XuqW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776142; c=relaxed/simple;
	bh=OgpDP55CkE9CjC82dfNSeMZ9n1xDps3uo7YT25eA0u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlXnS9Y0Yq24khKYfd07GDKjUWuoHJfnCbJ0MM/tTtj80LX2KcaOh5DlPDbg1+udSLP4k+ZTNbWWzRumRLlKId5m/tikydrJRq/vtxFozr79j+L4RlKAp4MCOw7nxwbXuqiq3a8VAYK8juLU31YLv0qvvM37Qqj0NnOXGGKGcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fG1+bxo1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so2312512a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708776138; x=1709380938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAlJpoBTrI2xnlT9smumwLLuQKvcDympbSC8n1WAAKk=;
        b=fG1+bxo1cY8qe33EDMZjVYjK60qU/yTNfdGpJLD+9XqR4fbbI2yoO7aFcM19l+G+Li
         /ZOw6LOS5ZPr64wWVwurJRmyag08r0etZbiT+gUrsX/5CB77YkNT0ReXLiUQgeFFpmHA
         OE3nAOa/9CfQhldqAYGJZ7vFTB0ZQ50j29T6Vr+KJbfSUsMf9J8o5x0Si+FyaMrU4bf1
         OaDUksZxCh1LfsdgA82jjqT8zzviaSUt9FJ0mOWVMZtrDqG5Z8WQR/tlnYNBo0ALClFm
         6q45rujbC6aT2flUDM52AKWaZy4ms+uGH8hs7RWIeVvrB/8ILsGeGGvlz6gDNqmtShl4
         lZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708776138; x=1709380938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAlJpoBTrI2xnlT9smumwLLuQKvcDympbSC8n1WAAKk=;
        b=Ns5w8VyRto9Mwa4mUF2eCoGdnNZe1P1Th8Qh3C3latAv6zBF75IFk2YD1ONIUPdNnY
         Ozxd6f5t0lVlh1S8S3SC0QKeWuLua+A8CaoSsP4j/buTIo7ge/wgAnLVGfE7cc254yWc
         R184ckrmTq5ztOoRiNkXMbDXeKJY28JjyxIBm25gdm0JUs7p0tRPpq3kvgaBfM0SJUf7
         6RbZqB0GEF/JasDEJLBwgvHq3fxtGsW8lmSpW+aW63CveBD+FAATUKD2wQsMTK054lGt
         IVj7WjN4XWl9ekbfOdTE2cb3HOA+MLUb+qAJ0r31hCtrfD0suiYMXQd56HeXLleDRv4e
         WPZA==
X-Forwarded-Encrypted: i=1; AJvYcCUvql223Ms8gjSgiEYW7UoCKAJcGjKaFIfhs4g8rVJQXL7q5LpeXsNwbM6j2tVKIFq6E/Vt8Y9b0ksZmkKIBL+R7TvGvQaS+RSLUu+M
X-Gm-Message-State: AOJu0YxlLjOiI/X5QtLyzcSWYG6POj2w/gX49bw2Vu58LNLkhAUIDpdw
	BakEdwS5mA4FkE68jFFoWEeugwF4m7fxPkvi5j1pNh7ptDWZvjT0tFTA0wa8+xI=
X-Google-Smtp-Source: AGHT+IGTJ7kq8H6Yp3AfqbQD0b69GowAo5PcIDxnmZ3LctbW6/9T7WIgcPMZxd8yFxMm5yF8sUeGTw==
X-Received: by 2002:a05:6402:148d:b0:564:5764:a5d8 with SMTP id e13-20020a056402148d00b005645764a5d8mr1454170edv.25.1708776138020;
        Sat, 24 Feb 2024 04:02:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id g2-20020a50ee02000000b00560c6ff443esm475397eds.66.2024.02.24.04.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 04:02:17 -0800 (PST)
Message-ID: <6c5c0233-dab8-4bd1-9f08-0b609d01defd@linaro.org>
Date: Sat, 24 Feb 2024 13:02:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2
 Controller schema
Content-Language: en-US
To: Xu Yang <xu.yang_2@nxp.com>, Rob Herring <robh@kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "peter.chen@kernel.org" <peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
 <20240221145846.1611627-4-xu.yang_2@nxp.com>
 <20240223140256.GA1768266-robh@kernel.org>
 <DU2PR04MB882234D1A9D5718D8355928B8C552@DU2PR04MB8822.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU2PR04MB882234D1A9D5718D8355928B8C552@DU2PR04MB8822.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 15:56, Xu Yang wrote:
> Hi Rob,
> 
>>
>> On Wed, Feb 21, 2024 at 10:58:41PM +0800, Xu Yang wrote:
>>> As more and more NXP i.MX chips come out, it becomes harder to maintain
>>> ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
>>> this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
>>> a new schema for NXP ChipIdea USB2 Controller.
>>>
>>> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>>>
>>> ---
>>> Changes in v6:
>>>  - new patch
>>> ---
>>>  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 75 +++++++++++++++++++
>>>  1 file changed, 75 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-
>> hdrc-usb2-imx.yaml
>>> new file mode 100644
>>> index 000000000000..2ec62f564bf5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/usb/ci-hdrc-
>> usb2-
>> imx.yaml%23&data=05%7C02%7Cxu.yang_2%40nxp.com%7C4ac0c60cd4b4433f0f9f08dc34782572%7C686ea1d3bc2b4c6fa92c
>> d99c5c301635%7C0%7C0%7C638442937830606824%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
>> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=7p1DzvYmBsTgN44jypH7lc56z9hVBsFBYXUwsblk9z8%3D&reserv
>> ed=0
>>> +$schema: http://devicetree.org/meta-
>> schemas%2Fcore.yaml%23&data=05%7C02%7Cxu.yang_2%40nxp.com%7C4ac0c60cd4b4433f0f9f08dc34782572%7C686ea1d3
>> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638442937830615622%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
>> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=fWWy9enbGK5yeKiovday7go3Gss5L%2F%2Fe%2F
>> OZcANny0QA%3D&reserved=0
>>> +
>>> +title: NXP USB2 ChipIdea USB controller
>>> +
>>> +maintainers:
>>> +  - Xu Yang <xu.yang_2@nxp.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - fsl,imx27-usb
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx23-usb
>>> +              - fsl,imx25-usb
>>> +              - fsl,imx28-usb
>>> +              - fsl,imx35-usb
>>> +              - fsl,imx50-usb
>>> +              - fsl,imx51-usb
>>> +              - fsl,imx53-usb
>>> +              - fsl,imx6q-usb
>>> +              - fsl,imx6sl-usb
>>> +              - fsl,imx6sx-usb
>>> +              - fsl,imx6ul-usb
>>> +              - fsl,imx7d-usb
>>> +              - fsl,vf610-usb
>>> +          - const: fsl,imx27-usb
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx8dxl-usb
>>> +              - fsl,imx8ulp-usb
>>> +          - const: fsl,imx7ulp-usb
>>> +          - const: fsl,imx6ul-usb
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx8mm-usb
>>> +              - fsl,imx8mn-usb
>>> +          - const: fsl,imx7d-usb
>>> +          - const: fsl,imx27-usb
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx6sll-usb
>>> +              - fsl,imx7ulp-usb
>>> +          - const: fsl,imx6ul-usb
>>> +          - const: fsl,imx27-usb
>>
>> Now you just duplicated all the compatibles, and now any new compatibles
>> have to be added in 2 places. For this to work, you have to split
>> ci-hdrc-usb2.yaml into 2 files. One with all the common properties and
>> one with compatibles (minus imx). This is also needed if imx has any
>> extra properties the other don't.
>>
>> Didn't I say this already?
>>
> 
> Yes, I know.
> 
> But according to your words, I need to split ci-hdrc-usb2.yaml into 1 common
> file and more than 1 vendor specific files (imx, nvidia, qcom, nuvoton and
> others). In this patchset, I only focus on imx part and KK said he or someone
> will take over other parts, therefore I just duplicated all the imx compatibles.

Someone will take over their bits, but it does not mean you can
duplicate IMX. Why you cannot use the approach I asked - move IMX out of
that schema?

https://lore.kernel.org/all/a0134089-a283-488b-8d7f-3f59dd938b60@linaro.org/

Look:
"... and move IMX to own file."

Move is not "copy". Please run: `man mv`

> If I only create imx specific yaml file and remove all compatilbles from common

Why would you remove ALL of others? What is the point of this.

> file, nvidia, qcom, nuvoton and others compatible info will be lost, is this
> feasible? Or should I create mutiple vendor specific files at the same time?

You can take a look how it is done in my recent Qualcomm PCI dt-bindings
series.

Best regards,
Krzysztof


