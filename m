Return-Path: <linux-kernel+bounces-118580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936D88BCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752CC1F3931A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826F182AE;
	Tue, 26 Mar 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbE/HX7R"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35A125B9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443196; cv=none; b=t1XzTGXY+v5lZcH7WRRLR3OYxf+ujltUG0te7cG3QU8iQdzSta80nYEwaBWgNI/8L3kWL9U6A7lNvPaBKN48M7tLU2lrUvTzdECTUpvudlu4s7GAEcCX+gOoUDqyZcDUE7O5TQH/jTzBmjOk57UIFgGOr2Mz4LXxBtJ5gIZtcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443196; c=relaxed/simple;
	bh=/1xJubbp8El0/+Ldwbi471L/TFLWboOUCibvDvftlxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN0XAi6AjEKgQqopsOjQDWS7BcEt2svmt0eOvwpm97yFfAEcLSayZXvCdiGlvSm//OkfH84LAvr3xuvgwOE+E6Afo6ISUxSVCShGNTfNSqy6C3ysxYp005syYEqLo5Jqyln1xN9JVoXt6aGPgaKVb50vYr5NFfJ31swcVFZZMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbE/HX7R; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso2548502a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711443192; x=1712047992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A72GqcohDI7Dvn2lSRVPpUnirl+ZJXgMHX/nxLWx5GU=;
        b=lbE/HX7RtwiHbTXc3k6HwjpE7ZJQyrd8s3lKHTpo+IlQCZLyQRPWaTiYtMsWzPEDxb
         uWJEb7h3ulaROHCag0tu3dXtflreeBI9mx5jSUuaS1BlT7VdsIitvG4xRxw8tA4ETI+5
         Z/qeeFGcVRdqgPL8jKNM2GwYMFYm+b2KMLHRnI+O56qRib24SPBeZpQnST/DF0YgVN/3
         yOhH4T75ZCsJ7eACApNAw3i22O+AdFTCRRZaosVVIrjauUnsUyUbCyOU/R1nU3qP/H5c
         xzp14O5VKQHjfGbrvaQPAO6KKSeKga2Os5PUecW7rNXYUvOC5umtExd1KzbipcYHJ9og
         KsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443192; x=1712047992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A72GqcohDI7Dvn2lSRVPpUnirl+ZJXgMHX/nxLWx5GU=;
        b=uvn3B2nTZgIX873B8R8BVtsXQha40VFdz1F9lfhTF2JVKWHE/fu88jkze+5HHS+m8B
         OYIDYqPQxgMCgAwBUbrEJEui+s07YslUbV7x0NKLt9kxAx/d9POD7MRQPoe+iCwj9G+S
         Qxsp15pDLecZKqfkFRWEFeC8WevsN9uNOtkG2G8sWYZCjLfhB1rQLM2dER8qg76XJtPy
         RS8kPk45sU32sthnUoVxLmx/ruD375Gymf4OqUNzZ1C9Tqtf8hG9MbFdMw/BlVzZrx0Z
         2ab8D3dGhqwtCXBVwAcY61Gm/HCFSw1sw0NQVzQMgSAQHdHTCz6MMOZL+HxXWf+wCx/P
         zEsw==
X-Forwarded-Encrypted: i=1; AJvYcCU1mRbjPTuDJPyAsF009DbxW6G8PdnkPBoMsC5ibMR5jGmWrqpvOLtCad2f647ro8Y1lx6V30bquXg+vTxkJ580Dudf5BUqo1ITJd+N
X-Gm-Message-State: AOJu0YyTYpzLqnpI9mkpSl7taaaMF/UMJlCCu9oMNj7uGw7Zb4+abHcJ
	iq3FLJJ6tM+lC6qT92g70ejZehGlaf7mW2unrMfusSy5m7Wl/FhqUSfwSfyqwvA=
X-Google-Smtp-Source: AGHT+IE3GYQsAD0T4ft0yc5Tkehkoxt5puQRArsnAY9e3ACvMoNJJdvAtKPZu6xylnDBmUENUl4fLQ==
X-Received: by 2002:a50:d697:0:b0:56b:b5d6:1efc with SMTP id r23-20020a50d697000000b0056bb5d61efcmr5823637edi.18.1711443192518;
        Tue, 26 Mar 2024 01:53:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7cd93000000b00568c613570dsm3925247edv.79.2024.03.26.01.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:53:12 -0700 (PDT)
Message-ID: <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
Date: Tue, 26 Mar 2024 09:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 08:35, Inochi Amaoto wrote:
>>> +
>>> +required:
>>> +  - '#dma-cells'
>>> +  - dma-masters
>>> +
>>
>>
>> I don't understand what happened here. Previously you had a child and I
>> proposed to properly describe it with $ref.
>>
>> Now, all children are gone. Binding is supposed to be complete. Based on
>> your cover letter, this is not complete, but why? What is missing and
>> why it cannot be added?
>>
> 
> The binding of syscon is removed due to a usb phy subdevices, which needs 
> sometime to figure out the actual property. This is why the syscon binding 
> is removed.
> 
> I think it is better to use the origianl syscon series to evolve after
> the usb phy binding is submitted. The subdevices of syscon may need
> much reverse engineering to know its parameters. So at least for now,
> the syscon binding is hard to be complete.

Some explanation why dma-router is gone would be useful, but fine.

> 
>>
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    dma-router {
>>> +      compatible = "sophgo,cv1800-dmamux";
>>> +      #dma-cells = <2>;
>>> +      dma-masters = <&dmac>;
>>> +      dma-requests = <8>;
>>> +    };
>>> diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
>>> new file mode 100644
>>> index 000000000000..3ce9dac25259
>>> --- /dev/null
>>> +++ b/include/dt-bindings/dma/cv1800-dma.h
>>
>> Filename should match bindings filename.
>>
> 
> Thanks.
> 
>>
>> Anyway, the problem is that it is a dead header. I don't see it being
>> used, so it is not a binding.
>>
> 
> This header is not used because the dmamux node is not defined at now.

In the driver? The binding header is supposed to be used in the driver,
otherwise it is not a binding.

> And considering the limitation of this dmamux, maybe only devices that 
> require dma as a must can have the dma assigned. 
> Due to the fact, I think it may be a long time to wait for this header
> to be used as the binding header.

I don't understand. You did not provide a single reason why this is a
binding. Reason is: mapping IDs between DTS and driver. Where is this
reason?

Best regards,
Krzysztof


