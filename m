Return-Path: <linux-kernel+bounces-8029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716D81B0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E816D1F226D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E054208AE;
	Thu, 21 Dec 2023 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVBtASz3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751220322
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2330a92ae6so64748866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703149030; x=1703753830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEpTLEBwYtzfdtfV17OSlaS7IaFDu0jr1ITxf4EdUzE=;
        b=TVBtASz3BiVrp7v0ytOWgdzRV75zr7yVkacHAV90cEofpe0oJIv2v4gfwKCKdXP592
         OdaIOJ0tpDp6dxmkifduVTN8AGLG0c0IRlLjgr+5SVLNm/7u0rO0K+fIZY7wkkm0nR0a
         49PPDIYjCHZFhaKl1YjJ22c2QzcUFKhubiX6pDzeSxLpgidWaUnuY1VjtRVigJ1LsayH
         ht4J3NNaMYShkxnBVNzoNWyRkl62kLKY/jPiS0Piw8heVmFi6bWflFjtO0zP/IF0ZQhT
         lu7EAHg0CWMqpMYdwtOyqcV+byBimVJoZ894Hti3FfErCdYEBgQZj7aBis7yK1GCVhqI
         x4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703149030; x=1703753830;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEpTLEBwYtzfdtfV17OSlaS7IaFDu0jr1ITxf4EdUzE=;
        b=pTf15PE7UkPYGsmtUJRPpj2HxVpVoZtO0gAf8UMP3wk2fQj4edvdIi2Fsw/Os4l6of
         OAdN5jsEu32X66vVNurHcW1x5RIHvAekCsSB7VxnJmzJJbr5k8H1UiTkt1xGIvY7m1MP
         DTPwE/v+KGqqZBrvShJw8k891gOeovVFrvoXoDAAOGY0z1lSRm9BwyxxLC7KXM5x4h7G
         2f2fXXqBo7l483nqtmUZRezIVL6WRdxgouSOWuZHG20Mj7BZ3vIJhSF53xCgCB5NlrqR
         KE6WYrJQnd3a0sWqOWOL4oB+27gZ14dUlp1tEvuamCaFbvPlGjEhOWBFF3ThRB74qRHq
         8svg==
X-Gm-Message-State: AOJu0YzOtCUaNbzn+Qe1HR81ZlRdshJKs+Lj9GnRARKSmEIIaDM0ZZke
	YyNJhGD/OrV8fOxHLADhjoSxYw==
X-Google-Smtp-Source: AGHT+IF59nod0rEmvvoLcd9kzd0V0yAuprza+iVkp/g2KJp1mAQw/MrCWeIJDv4wTmkvlm9hpgsonw==
X-Received: by 2002:a17:906:1bb2:b0:a23:7467:7a82 with SMTP id r18-20020a1709061bb200b00a2374677a82mr2057573ejg.22.1703149030164;
        Thu, 21 Dec 2023 00:57:10 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090632d000b00a2357c16fd0sm718773ejk.171.2023.12.21.00.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:57:09 -0800 (PST)
Message-ID: <6a4356e2-e201-4b87-bac0-056b29a07fc8@linaro.org>
Date: Thu, 21 Dec 2023 09:57:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
Content-Language: en-US
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com>
 <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com>
 <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com>
 <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
 <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
 <CAA8EJppwsezPV21Uw8xTn=ra8L2jfnkHoRghDPN96O5tJsOD7A@mail.gmail.com>
 <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com>
 <A45746C4-54C9-48D2-9DB7-52B4B56854E6@linaro.org>
 <4e328cd8-9ef7-42ce-b592-7f2216c00c0b@quicinc.com>
 <CAA8EJprE8v3bhHfyZJM9SJT=ShJ-LQvk5mR=gpdAWXF2yANWbQ@mail.gmail.com>
 <e88787dc-ed03-42d2-a6e7-fb88bbc89357@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e88787dc-ed03-42d2-a6e7-fb88bbc89357@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 09:49, Aiqun Yu (Maria) wrote:
> For example:
> 
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
> 
> @@ -55,14 +50,7 @@ patternProperties:
>             - const: qcom,sm8350-dp
> 
>     "^dsi@[0-9a-f]+$":
> -    type: object
> -    additionalProperties: true
> -
> -    properties:
> -      compatible:
> -        items:
> -          - const: qcom,sm8550-dsi-ctrl
> -          - const: qcom,mdss-dsi-ctrl
> +    $ref: ../dsi-controller-main.yaml#
> 
> With above unified reference change, it will be easier for other 
> developers to reference bindings files next time.
> Also dsi@[0-9a-f] node in mdss node will be correctly fully described.

No, this does not make sense and allows anything as dsi. It is opposite
of what we want in bindings, so NAK.

>>
>>> In my opinion if the example have "#address-cells" "#size-cells", then
>>> it's better to also include "panel@0" with "reg = <0>" to not confuse.
>>
>> It is already there, see dsi-controller.yaml.
>>
>>>>> 3. Too many bindings files for driver "qcom,mdss-dsi-ctrl", shall we align them into 1 binding files.
>>>>
>>>> There is just one.
>>> Currently I mentioned bindings files was searched the compatible
>>> "qcom,mdss-dsi-ctrl", and find binding docs like "qcom,sm8550-mdss.yaml"
>>> "qcom,sm8450-mdss.yaml" etc.
>>> There is duplicate information on "qcom,sm8550-mdss.yaml" etc, while
>>> "qcom,mdss-common.yaml" is not common enough for my understanding.
>>
>> If you had compared the qcom,SOC-mdss.yaml, you would have seen that
>> they provide tight binding between compatible strings used for all the
>> subblocks. The `mdss-common.yaml` describes MDSS common properties. It
>> describes everything except the platform specifics. It can not be made
>> more common. And there is no duplication.
>>
>> If you think you can improve the bindings, please send the patches.
> I am thinking of a unified qcom,mdss.yaml instead of "qcom,*each 
> SOC*-mdss.yaml". I will try to have a patch.

I asked first of you to read previous discussions. If you still insist
on sending patch for this, it means you did not read them.

How you wrote this idea, sounds like exactly opposite of what we were
doing and what I was recommending few times on the list, so it is very
likely I will NAK it.

>> They must pass the `make dt_binding_check` check.
> Thx for the remind.

And follow bindings guidelines.

>>
>>>>> 4. enhance the dtc warning check if we still want to have "#address-cells" "#size-cells" even if there is no "panel@0" attached.
>>>>
>>>> In my opinion this is a way to go, if any. Did you include devicetree@ ML and the corresponding maintainers into the discussion?
>>> Already included devicetree@ ML at the very beginning.
>>
>> Good, thanks for the confirmation.
>>
>>> If the required properties part in each yaml is marked good enough, I
>>> think it can be an input for avoid unnecessary dtc warnings.
>>
>> Patches are welcome.
> Improving developer efficiency with unnecessary warnings is one of my 
> interest as well.
> First of all, I'd better to make sure "Required properties" attribute in 
> current bindings are good enough. Let me try to get back on this in a 

I don't understand why do you keep mentioning the "required properties".
They have nothing to do with any of this here.



Best regards,
Krzysztof


