Return-Path: <linux-kernel+bounces-38395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697C683BEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E3F294131
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB41CD03;
	Thu, 25 Jan 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBXsm0L+"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80801C6AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178747; cv=none; b=NYdBbRVBfYqGffsrWFs2y3uCb/XSv0w6/7qErDojNMedekFqEjYb1Dtu8Oeoi1rSxC9Xr6KT89di91G8ACf8JMNjUNoqaSXfVhSMlmONF5A9D5FJ5oNcURsE1rbSXcWkZzAaBIXzLXJJtITIZlvSaUdPtMRGgioS5OOzy0NWBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178747; c=relaxed/simple;
	bh=KcbqktA/NLFYyfShbKJxdK0mA/sY4nph7E0oxaWY4sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNGLPN6pvI+JQhqg3B/dItL3GYX5kiXgVpeMrca+5qzDEAGWgcPkxUwv8DY+GzXsknh17GztaCmjfURfcf11SLXAIVj5AoU9B/Ixb4+1dsukx4IipsyGbhwJ/5ZY6Ezkm5gmI45qgWfLPGcKpeyzndxGajMh861q/OzHpQnzq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBXsm0L+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3150c9568bso136054166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706178744; x=1706783544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1p6PsuJqyqTGuv5vnLtdjFz7HqpTiAo5pRXyQvLiI8Q=;
        b=CBXsm0L+Ttz93rHYV+uwRNgahBxHlbGa5oMp+Z3oM0KolS0wZq1al10reVgLjcJlg6
         EBs/n6vARK8JAy8Zh2e/OJiD/G6hCHdlCH4JZEaXQ9hqYtJdYYnvuTgHSn/Pe9PioeQE
         hCv3q0DuGd34dyGFr9B5DAOIrV9cJaynv5G5uYF+P2gUYqDIzQ/un9QCG03AEAybvtIz
         gs7wqhxNYPDCBWy3HpkB9R+/ubi7EfkjFHZ1qLhn3GwyDUvKXd3Okl0yQKAD/Q6sSD0P
         lntvP4CMMMvKZWqxC1Pm26ajwdKt4TZxkuiEuQV7ZkHcX+IWe+ZSpHN2WoC648I9p4yn
         JOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706178744; x=1706783544;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p6PsuJqyqTGuv5vnLtdjFz7HqpTiAo5pRXyQvLiI8Q=;
        b=G0pp67QHAYr17no9geSf547OStwwHMlfih131Zeo1eNpFUElC7uv6Y4FjxjyT9oD+n
         8SSPCHp3XHdlUGVx7zkqG2o0n/4vhRutxD/RAncKuJ+zp/ucZx3GSxbo6PTB0k97EDMf
         CBphLFPbBSVzFvVMV1rCn3K22fsmcs6NoEG3E+mHq5yNFzHCMxb7Hrtl6LBA0yElabW9
         Jeiiw0skwKWg/kAhG9nH3krzabwFSkfIcPqAtKwsMId2euLP5jh3uCbUsxTTAzAbnT2j
         XUKjwuPheHYdPC8pEVgj/As1BiTz4Ce9m9Up9j88Q2u1NvKn0+Nhc9Qdheq8AtZuvuCd
         tD3w==
X-Gm-Message-State: AOJu0YxP8+U+UNKRP36VaPh1DAuFmZaW04qLazmUX/Nqq+mb1g0UoeY/
	XXiRwArwjqPj9hm1As/MSqZ9Xb4m/3WsFumSoEaJOZH0K8bdALibO7PaeA7eo+g=
X-Google-Smtp-Source: AGHT+IHiwyuBltNWm8iCxD87eZxTyLo4GrWYdBbW9KRfkjS0jY0KD3lq5pOzfH+eBn1W3TIyzeRTIQ==
X-Received: by 2002:a17:906:29c7:b0:a31:433c:2128 with SMTP id y7-20020a17090629c700b00a31433c2128mr206355eje.167.1706178743939;
        Thu, 25 Jan 2024 02:32:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id vw16-20020a170907a71000b00a2fc36776a7sm891684ejc.19.2024.01.25.02.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 02:32:23 -0800 (PST)
Message-ID: <dc9773aa-690f-47b5-b60a-a79c1e2dbaf2@linaro.org>
Date: Thu, 25 Jan 2024 11:32:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, linux@roeck-us.net,
 heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
 <20240123-procurer-jumbo-ebbec485505d@spud>
 <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 09:48, AngeloGioacchino Del Regno wrote:
> Il 23/01/24 18:14, Conor Dooley ha scritto:
>> On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Regno wrote:
>>> Il 19/01/24 17:32, Conor Dooley ha scritto:
>>>> On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regno wrote:
>>>>> This IP has only one interrupt, hence interrupt-names is not necessary
>>>>> to have.
>>>>> Since there is no user yet, simply remove interrupt-names.
>>>>
>>>> I'm a bit confused chief. Patch 2 in this series removes a user of this
>>>> property from a driver, so can you explain how this statement is true?
>>>>
>>>> Maybe I need to drink a few cans of Monster and revisit this patchset?
>>>>
>>>
>>> What I mean with "there is no user" is that there's no device tree with any
>>> mt6360-tcpc node upstream yet, so there is no meaningful ABI breakage.
>>> Different story would be if there was a device tree using this already, in
>>> which case, you can make a required property optional but not remove it.
>>
>> Not every devicetree lives within the kernel.. If the driver is using
>> it, I'm not inclined to agree that it should be removed.
> 
> I get the point, but as far as I remember, it's not the first time that this
> kind of change is upstreamed.
> 
> I'm fine with keeping things as they are but, since my intention is to actually
> introduce an actual user of this binding upstream, and that actually depends on
> if this change is accepted or not (as I have to know whether I can omit adding
> the interrupt-names property or not)....
> 
> ....may I ask for more feedback/opinions from Rob and/or Krzk?

Driver is the user and this is an old binding (released!), thus there
can be out-of-kernel users already.

Minor cleanup is not really a reason to affect ABI. You could deprecate
it, though. Driver change is fine.

Best regards,
Krzysztof


