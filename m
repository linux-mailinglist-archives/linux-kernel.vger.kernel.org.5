Return-Path: <linux-kernel+bounces-120320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD588D5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2872429DE96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7972736F;
	Wed, 27 Mar 2024 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaA8PbZZ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A061C11
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515749; cv=none; b=OQtvRlD93W6PLheJnVLqQi9yPFVtN2nJA8FRYRdybkEN1dWs0biki5B7O2gAAr95zLY5bfwPJ2xtX1YSxQFKJX0qWiCG1KAFiYjqhyTvBpYORMCOj76lROlJY6rYrsnTNXaa3Ri8armSydTyjGreT3JYFNMsv17K4kE3SkMpbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515749; c=relaxed/simple;
	bh=us7GSpZRag7HPatHH7mlBYKRW/n4m5FcLgyFeM//xcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfbWiO8QFBCVDGxL5jwrvRxhYSAuhok7OPzkUcw8QSFtL20WArUBjPytlGpQ4I/cg5y1v37hbSeOFlAk+e3aM89pFifk7SCCuWhmafzBWaJ0G1be2+SkG/mJAoaRSyYITKbu/fM3/BxPv3+0opZIff9A5B2LPH0Hy6Z1iiA+WQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PaA8PbZZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c4030a6easo52469a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711515746; x=1712120546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DMad7CnWZ4A3PC8/xrn6eiPzDrFYjb8dvu+52V2VtsE=;
        b=PaA8PbZZyv+FR9z+b4VNorizsr254ETpxmwobW/f7NwWMfnkjkJHEHuuk9aPOVLibu
         +apIcZ2xjFK5L16Ta2e+NWakE9p43c8rkRw464tBocBjwoSNkgzq5qQA3f6HgyMBA/GM
         GrN6ppGbVDMJEQ9iPKCswdFVkpYdgqzrYplr7+v6e0fUd6wXOTf9X0kYrKRl229pqD2U
         G2AS/UmN0tGpfwkvwhfPD3Bk4ykvYWs8EFFoQFp1CBWREGKqgK8wMY5/jDLx9DRORVOz
         bRaNL2u2rl+Ik+KUndOfe1yMPwiUX423tM2qaU4mcdPLxBB6mOuvA6U2sJxMXngjPtr9
         Hctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515746; x=1712120546;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMad7CnWZ4A3PC8/xrn6eiPzDrFYjb8dvu+52V2VtsE=;
        b=MVGzEdf4LY6J8qOTjUWHs51zxEr0vixwTRstLfIblmg5jVrOVpCwXN/YAAflDVc1dt
         AbBw4xsvdP/YC2pxzdd0hXWRIgwxDwuIjxP+ggePk/DjcC7sfApKEjHnCidDAlxuFwYS
         eyaEjJmp868wXbYDjPFtokUvJqAaZoyI/ZjTXq7kopxgcmPkJ5Yin524jXE4jAV0dyK7
         rIzUeYv3EoXwH8KM6sdXFrd79dHHfQMYJvSkcuF/d4RIQfcmjQ482zys0vs37YGQAyRG
         N+AJ1kfjH22o6xeeQ50Wx/+kUxd2A7jxoKOMV+uv+KaYLZhwo1UgWfhTaraMVocVqGky
         qSHw==
X-Forwarded-Encrypted: i=1; AJvYcCUjXLcoH6UvcexC7wG4RnAE3EZ8ugxBy4RTXB3RAUNTIFd7WqUsndAhK34U2/MioFRXN50oEzsrgrqDjftsYzlUcR4PH/CIubHXUlcX
X-Gm-Message-State: AOJu0YxBqU+Wwy/DICxF57xDBxgUENd/kkVOThH5oiExoTOrCln2jxIp
	9sjQZDoMnSaGVvNwEebeo9yFtmdv4YYcoX3uBJBpL7NADOpDgiVB6OtL7axjNlQ=
X-Google-Smtp-Source: AGHT+IELsDojqhItkb5A3lwC9RMISJNx3etx74WAKmGHdx36zSFqVjPod3fr23jA118RrCJiOwXxDg==
X-Received: by 2002:a17:906:f0c4:b0:a46:8c03:b659 with SMTP id dk4-20020a170906f0c400b00a468c03b659mr987686ejb.42.1711515746400;
        Tue, 26 Mar 2024 22:02:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a462e166b9bsm4954104ejz.112.2024.03.26.22.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 22:02:25 -0700 (PDT)
Message-ID: <a675f3f1-23cf-4b7c-ac93-437f57e9b48b@linaro.org>
Date: Wed, 27 Mar 2024 06:02:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
References: <20240325153356.46112-1-l.rubusch@gmail.com>
 <20240325153356.46112-5-l.rubusch@gmail.com>
 <f74a01bd-46a3-46cd-a47a-fcfccd7e4dc6@linaro.org>
 <CAFXKEHbJ_5unY24aZeutvM-xrjevQ=z7ngDcgwJR=NXzXONx5A@mail.gmail.com>
 <334970e7-2edd-43c8-9f18-b7b3ec5f4d17@linaro.org>
 <CAFXKEHaEVwiAW9co0+=kZ5w5a8eWg3QL0dmg38bvrmLdnBEA7w@mail.gmail.com>
 <b13ca51c-db57-4a09-b689-cf27265d348f@linaro.org>
 <CAFXKEHYMiARxrN7=jqnJtEVREseZ-zmZmVeY1uNXZV6viwHbmw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFXKEHYMiARxrN7=jqnJtEVREseZ-zmZmVeY1uNXZV6viwHbmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 21:17, Lothar Rubusch wrote:
>>>
>>> V1: The first version of the 3wire patch. I have split the single
>>> patch upon some feedback (yours?!) - V2... So, my current
>>> interpretation is, that every feedback I need to mention as
>>> Reviewed-by tag, no?
>>
>> What? Feedback is not review. It's clearly explained in submitting
>> patches. Please read it.
>>
> 
> Exactly. My missunderstanding here is this:  Why did you send me a
> reminder that I forgot to add "Reviewed-by" tag in your last mail?
> Could you please clarify your last mail? You wrote:
> "(...)
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, (...)"
> 
> AFAIK noone literally had told me: "please add a Reviewed-by me tag",
> or did I miss something? I'm a bit lost here, sorry.
> 

What was this then:

https://lore.kernel.org/all/9700cc88-bddb-480d-9417-04b2ff539a2f@linaro.org/

Best regards,
Krzysztof


