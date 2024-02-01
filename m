Return-Path: <linux-kernel+bounces-48747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9798460B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5881D28F6F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D88562A;
	Thu,  1 Feb 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dh9YAkSe"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE985296
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814822; cv=none; b=k6zqWwoeALeAM4Tg4F/miVexebfNY1EdD3K/I7vMW3oOqs9V6oR2iVtjis/oBwInT9WNYXR6XE+iA5+3azstopf6rIiLd2HD3c9NPJY8xLlVe0/JuTq9cM6w0X2FKe/N0SXSnSrt/lQN8J96xtCJg5NEvuhck0rjb9QiUuwKPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814822; c=relaxed/simple;
	bh=YH86kbr1cgKMKWPB4N2wbtOfMeUg2Y/vh+5jGXYIw4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiYG3zHz0vNLfrn97rEwkoOTbv4eNxxjsG6un6cn4b//9WxrWj/b5skP38OpfpqGEfrQLUPEulqurW73/AHjJo3WEICcDXOaXpBEIE/nvQXsRCe/zlaXWNhFmQAc+K86G6PPaxqKkEhFkYURDe36ZLcPA4URVXoRj3NAHNwisgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dh9YAkSe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55efbaca48bso1802278a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706814818; x=1707419618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rs8bFhf5my2YnmgPHwdbtk4kh1nvJgyASEQNZng+sZE=;
        b=Dh9YAkSeQjVT10nAo0DsykBzYY1OqFnwRm75BqTqJlk98XPnFy5krR686l7ydBaSCV
         BRPPoNvZ+bPgKXYuMieoyBxoQC4iKuIB+oE2zYDlPGE9M+l3fhCYq6UtUqWPkzXrUotD
         /QTEQwTudaDPaws0sYsvbAkY8RL1QsR8HlZJWtvNOqVmh4JCjom0o71LU3ZZ+IKoZLqg
         8QTzR1keIXmKEfsYD5ZtLvzKxEIIjQwEpI1w04J+eTS+2esT3gNBPpdnh1/IRxwN+033
         6S8TFDQy6tFbZxcMaUdWrIV3ezTeADqUoe1HJWkHez1dU4rSuyBTTiTGocdlPAjCa/Ll
         Yi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814818; x=1707419618;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs8bFhf5my2YnmgPHwdbtk4kh1nvJgyASEQNZng+sZE=;
        b=gFbBTGSTk1EKayX5KPOicLUEyWvfj7AM6JfSdmzC77oV1BBD8IuJgsBWEKVdZf9kJM
         gthfkk0P6XuEtufTJIIBQi63CgGVIPBELHLelzRPtDQEDj9566y71YeQ9Lzzuanf825j
         sKtAkpadAS+63ouIoX+ujRdSJt36hiyawLeYuIE/ISCu9WtpUveGBzFjcV3X8h/w/88J
         Eocy3ftKjqOuiUv/VlZufhxObgh6sDutSao6M/BEViIkUHtzAqBXl4JxNQoyiXuhkpmw
         w35lE1UFxhvo22I4Lt8Sol26e2QQ9yuWZiq/4zFGdBcA6bivlzIOAzfp8ieORR1tAK8P
         kjhQ==
X-Gm-Message-State: AOJu0Yw2VKu4CEk4mRAd4ST0N7nwC1GQqMWfi4CwubIdFE+uQznTGG2d
	Ivuf52DPfMgZPZJHnAKr0chVQ3aAKafFMkJTyU/CPyNjIZtqMFtZVCdP135+pmI=
X-Google-Smtp-Source: AGHT+IFH37wg9fTFzpFHD98Tr4CkdHn+eHxTd3BlVsEIFmM2D+8wwhDRim+spoFYFjlvzfGNZAEHJQ==
X-Received: by 2002:a05:6402:696:b0:55d:35dd:4a48 with SMTP id f22-20020a056402069600b0055d35dd4a48mr4059760edy.36.1706814818106;
        Thu, 01 Feb 2024 11:13:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUImBA09Zc6s7ffIyKKncBLxUwit5T9HTfNJeTQiZ2dx4xCRlddL4PfRoyp0/4FXbeBhWX5AXfj5JyvnCaapDgt5/HYeMQ7DxXf5wNce4HPBG8yLt7j6y9E/T3myfYjzt5rAx4N8DCoxvKZoJ/ZbwZ7zoI+H+TPHwVRBKPJqTDMjN7xLXGfGcmmfB1u2GGoKy64zOWDYxK3u/XSft3HYaN3lgC8ec66KTXzCWd+x2wE/Rd/+6GEUor9EcJpwIR3Tv9JmjTN6CoS1MTysAGcauhYm0lsimtekx9MnskIUBHjf8V2Cy0OMwTr778k3ZLotQHBx0dm91qUxHhEOsSsxi9UgF/hYdfwP+ROIjI84Vuxf4/skLtCkowF/yosQfVlNj7LpRsLfS8/hIScv+gtbLhUf+TyZTip/i3fKBoDyMF3WCxEyeOSzUDzBaHulxXoNuezeA6ytocx103SYDJpeC+Mh95m0vWHh6eivpWsOyb9mrOyfIrUpdqy0XEPOA1MYXqtpoSHXYqbktSUHhohrHBLjAqNNPDrZ41qj5BCaepOUvkpxBcKxxxjrSmV2A7Dqc95c5V0ouIxTs5cybCeo1ASl5ZuufR/pCAuMluII5NfOrDxDwETtqKTn31aoWUQSLmBkSxuUZORPyD58VvB01VKUwoos6L1VhQ7crsKiYfBvobWsINJ4t1Ztpys+FUfbAPLaxukEGfirjEmhy7Kn2F2ZmvS87W87sVPS/L+023Rji+JeIHxJk0xuXnVRKfE9e+JQYjn3tzJ+O4DMKScGFhIBgYhXt1kF9IJaeni
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id z17-20020aa7d411000000b0055c97f940fcsm92944edq.81.2024.02.01.11.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:13:37 -0800 (PST)
Message-ID: <dd219c40-33d5-43ff-b0da-16ccf0198bb9@linaro.org>
Date: Thu, 1 Feb 2024 20:13:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] dt-bindings: crypto: ice: document the hwkm
 property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, andersson@kernel.org, ebiggers@google.com,
 neil.armstrong@linaro.org, srinivas.kandagatla@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 kernel@quicinc.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, quic_omprsing@quicinc.com,
 quic_nguyenb@quicinc.com, bartosz.golaszewski@linaro.org,
 ulf.hansson@linaro.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mani@kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-14-quic_gaurkash@quicinc.com>
 <301be6d8-b105-4bba-a154-9caebc8013e3@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <301be6d8-b105-4bba-a154-9caebc8013e3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.01.2024 09:18, Krzysztof Kozlowski wrote:
> On 28/01/2024 00:14, Gaurav Kashyap wrote:
>> When Qualcomm's Inline Crypto Engine (ICE) contains Hardware
>> Key Manager (HWKM), and the 'HWKM' mode is enabled, it
>> supports wrapped keys. However, this also requires firmware
>> support in Trustzone to work correctly, which may not be available
>> on all chipsets. In the above scenario, ICE needs to support standard
>> keys even though HWKM is integrated from a hardware perspective.
>>
>> Introducing this property so that Hardware wrapped key support
>> can be enabled/disabled from software based on chipset firmware,
>> and not just based on hardware version.
>>
>> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>  .../bindings/crypto/qcom,inline-crypto-engine.yaml     | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
>> index 09e43157cc71..6415d7be9b73 100644
>> --- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
>> +++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
>> @@ -25,6 +25,16 @@ properties:
>>    clocks:
>>      maxItems: 1
>>  
>> +  qcom,ice-use-hwkm:
>> +    type: boolean
>> +    description:
>> +      Use the supported Hardware Key Manager (HWKM) in Qualcomm ICE
>> +      to support wrapped keys. Having this entry helps scenarios where
>> +      the ICE hardware supports HWKM, but the Trustzone firmware does
>> +      not have the full capability to use this HWKM and support wrapped
> 
> How does it help in this scenario? You enable this property, Trustzone
> does not support it, so what happens?
> 
> Also, which SoCs have incomplete Trustzone support? I expect this to be
> a quirk, thus limited to specific SoCs with issues.

Can we simply evaluate the return value of the secure calls?

Konrad

