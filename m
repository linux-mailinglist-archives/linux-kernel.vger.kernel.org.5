Return-Path: <linux-kernel+bounces-28632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09606830115
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC33287C55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9FFD26B;
	Wed, 17 Jan 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeRdTyE1"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7311CAE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479274; cv=none; b=subND8NFKQ5VIZPYpThqZMNdRTT7AnrvYUP61el/A4JTr0qptau/nJ4NhyAraUn6VxMQ8EArUFopAguxOJLE06sXdlNeKn1rzYKoXn7Bkqp+rpKwxOb2CzezN1rtbLlAS4MGSVFlelM0W1jKOStZ2scnyzzkYXum3dBCRUIMOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479274; c=relaxed/simple;
	bh=cwylxV3kqbnlcPOSuYtKVxfAJcIy43hyojt54L8ZiwI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=YkzjiRMoe1CjVK8ZD9ZpteYh0xl1JHs9jqdYBVWuDlsymtaOCWrSByBo5Tn6MC7Zlc33nvTgbKAyXWwvkryPOSG66tWf5xfNkoNUFbi/Z/r7vwuS7DBZSyvD1BzWubTqNHz8shFOJ3ueenBrA0SiR33edeVJNhmRjhQSgi4mAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XeRdTyE1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28fb463a28so1146675766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 00:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705479271; x=1706084071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDpy4FmysuOCLPwC25rzziBsH7dgfNI4N60cOk5J0hY=;
        b=XeRdTyE1HIsc8WTBIj1FJ12xN+nYcYzX2tqHnVLmJo8JcPyayRcBkF1lMVBV4iKZdN
         eNH18I/XrEBIbRD3weAu2Vz9JlqJ1K5k85QDb8oqQy3DleEkobn0FLGxkGJI5yTV4Smw
         1pUQEtnp5vvWSSu31vdKp5Hd2ygpKqncrxlpHaVLTBDtz+Wn/HzNWOuVqwz/BPoA+3UC
         h/723lHr8DL+ygowI8+eEVLCpyGDshmCrwcudIubuQ7ROAQwvOmkfkl5rCXDvVGW+b6c
         v2Gmie7YfW3na5Uazpdo6jXR7+F8ehiETO1NVVqpzVLo5Qy0vZmBX83/HZDITvopb9KU
         nsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705479271; x=1706084071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDpy4FmysuOCLPwC25rzziBsH7dgfNI4N60cOk5J0hY=;
        b=Tpkz8oakqeZ1jKmYclYjdGdk8R7mQox5FLd2nCKfKp7Rs121xRiyKTlBm/QtmhNwAV
         BEsCc5+NQOLYG7jjcTqfj2XmAyfr95GQu9MfHbZszBa5HJp6XNjDpkMKmY+Bon3IshZ6
         Vw5fUoiszbXBY+dK28WottvmlVdFKpOXCjB8AxFy14y+4M//BhXrD2eTLWVmkM9OuDpI
         AoNeFLEi/KXSxBLtUP2RADxomDudoVp/tywoxB7rJLTFmu3MWMzH+0qg3WD4oy7a/slr
         sWrJ7MYbcfoULAg1VShPC33RLEZ+Q00VXA13y+kjHQEA5+81s3A3AW4T5tC2v9V+h3RV
         BtmQ==
X-Gm-Message-State: AOJu0Yxp0Dfe/y2riRWXto4a/Pk3hhtP19BPTnG74mQHs3PA/sTylL4v
	hA5Z/+q3SpjsfUnhwAct9T+r1lvka3UXAg==
X-Google-Smtp-Source: AGHT+IHYGk0MY9r65dutpxCNcoZxTZ/UZTTQfaeNdWDK2+dt/mhrciGq1YV7HBqYNegW4K6nXF+bng==
X-Received: by 2002:a17:906:2b92:b0:a2b:c286:7057 with SMTP id m18-20020a1709062b9200b00a2bc2867057mr3985897ejg.117.1705479270947;
        Wed, 17 Jan 2024 00:14:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906668600b00a2327e826ccsm7446573ejo.201.2024.01.17.00.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 00:14:30 -0800 (PST)
Message-ID: <b2dd8bcd-1e23-4b68-b7b7-c01b034fc1fe@linaro.org>
Date: Wed, 17 Jan 2024 09:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: fpga: Convert fpga-region binding to yaml
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <2a48c720bf0efce77d68a0bef10b47671b35506b.1705413862.git.michal.simek@amd.com>
 <3aef2fc5-f213-42e0-9b72-619364ef6c76@linaro.org>
 <66fbb19e-72cc-4fb9-9069-abc351b1525a@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <66fbb19e-72cc-4fb9-9069-abc351b1525a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 09:07, Michal Simek wrote:
>>> +patternProperties:
>>> +  "@(0|[1-9a-f][0-9a-f]*)$":
>>> +    type: object
>>
>> You put (0|[...) to disallow @0001? I personally would not care, dtc
>> handles this, and the pattern is confusing. Just @[0-9a-z]+$
> 
> This is actually taken from dtschema/schemas/simple-bus.yaml to allow all nodes 
> with regs.
> 
>>
>>> +
>>> +  "^[^@]+$": true
>>
>> I dislike it. How is this binding supposed to be used? If in standalone
>> way, then you allow any property so what's the point of this schema? If
>> fpga-bridge.yaml is referenced by other device-specific binding, then
>> all properties will be evaluated here, so the same: you allow any property.
>>
>> Depending on the usage, this might be just like other generic, common
>> schemas, so end with "additionalPropeties: true".
> 
> ok. I am fine with it.

But please verify my idea. If it is used standalone, then you should
drop both above patterns + additionalProps:false. If it is used as
generic schema referenced by something, then you could keep one pattern
for object, but actually it is redundant, so I propose to drop them and
additionalProps:true.

Best regards,
Krzysztof


