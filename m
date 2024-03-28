Return-Path: <linux-kernel+bounces-122593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1795B88FA37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958CA294F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C65339B;
	Thu, 28 Mar 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRxcCeyL"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F61381BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615485; cv=none; b=DRYolRaw7HeR2WrqKEgfEg9I+E46AmZeyb5RPMp1G7yuCOQGpAwkSLDPQkwNnqO2VaprfYYb7EejT3IOXJGPMWaXnSDsM5pdBLE+RDaJq9uDbdKxQYvvEPoSiPimNiA1YSxPWqdUF2adX8xqP90ERPuFHlh7JC7/hKyIbsUJxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615485; c=relaxed/simple;
	bh=2bipewHiWc20IPVmt/h+G6sEVSbPUHGeRr02tRHiUS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmKDzMNme30Nfl0zqlEcc57KacoIZ4CbpDh3ykJ55H33phRtQQmQgz9x+hKpSpPYGteM4taJeVxyowXBFICgrXvCOByS2l1X7Oap5KKAQJKR1izj9kvEtPs/+HtfGsgjwsboDwJYbk00wbGqj4jJKobmlZSZBrwziQdpP49YdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kRxcCeyL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so6819871fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711615482; x=1712220282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm8neqGmCcwB+1XXAd9zMCmUPIcIdZmM13yfXwpV3mY=;
        b=kRxcCeyLN1QK3yYV9aDHj4pGRIl0YC+pIHYLxP9LKAxwghXy2ZL2G4j9V9TEs7BQUy
         PF3EzaGr6VNa+Nr8fPde/8eGb9GvKJ4791Skw8HiQqjtacRABq/tXMg05Zm/3ZKOyy86
         3y1W530VkJLfXKy8DqDjPvnbhp3fJCMvOEqIE4KX9qCg3ESXaotOA9rKSnO9zZrPONy1
         0xzvI2D95nGE49KLvFWc4G0nBEhzNWBzuwv9DnFtYrHcoY7Mp8eZ0U9Gu3ma+lXUhoiM
         nlgZ+dcmade/m4N7Mlo+wNJE3LqMqgbK8srGxGPUDqp7ROSIm806YKuQ6EJJQfFvndFQ
         cWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615482; x=1712220282;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm8neqGmCcwB+1XXAd9zMCmUPIcIdZmM13yfXwpV3mY=;
        b=nuPnMPRCYoKutXOr8rjH0KebHybQVOy5ldFYOKbyYXVAH90xxQsdYqQ+6GjJpMJLMI
         9Xu1pcWlEcNi2MdiM76tI0/aTID/adrLhZ3nw56GkiHDjNveZgKnhUj+BU64hi2oaqb2
         THSuIdqIizxQgEgFnVMvpcN2A+VdwV/WeFSBpUb0rAA1rIb6ft2XnpwQii4O49X/UpeK
         /OuxF2Qd0ScwjKdhpdtHMxf2fYGW7y1RvKgr9l2ry1p+qsiKmXnBIy+xf/66zm02yeEl
         tcuPbIO9O+NBPILR2CpOTKlS8IbnAY9GDrzrL9ORZ506le9aRJdEpKyqY91QolkVSxXW
         yBEw==
X-Forwarded-Encrypted: i=1; AJvYcCVHTX2/ZwDJ68u14BnnOknfW7O/w4OYV32XIV+6Pigbos8h/ROeXKKDzznJ7rxJqCDjMi6L5XPOAR6fSK+ZFtB4WMTOHDnFXc2gU4l3
X-Gm-Message-State: AOJu0YyoA5DHseBYmaiiKt0MHYQZpaVI/MDX4faES9qJaXfm9s4nCAU4
	V8AQa+aGup0hDFw3CM2ezBy8Y8a0SDVhQaxsTf3snZFCvl48UjoVNkR7dACCdxE=
X-Google-Smtp-Source: AGHT+IF3v72Lsejp74D9eHW05mq25ZXi+byMrEtB0ZgKT2QsyLHkbdos75fog2sbl9TVdTwjfx7xYQ==
X-Received: by 2002:ac2:5b4c:0:b0:513:d49a:7a0d with SMTP id i12-20020ac25b4c000000b00513d49a7a0dmr1170137lfp.42.1711615482135;
        Thu, 28 Mar 2024 01:44:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00414896b61e4sm4712117wmb.16.2024.03.28.01.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:44:41 -0700 (PDT)
Message-ID: <12b911fb-ba8e-4fbc-bc7c-4de3a45d4581@linaro.org>
Date: Thu, 28 Mar 2024 09:44:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
To: =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
 "amergnat@baylibre.com" <amergnat@baylibre.com>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 =?UTF-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
 <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
 <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org>
 <b957b072d5d88ed315982e914a7f700e0ccafb83.camel@mediatek.com>
 <038ccb20-71cb-40d2-9720-ce1a0d3eac8c@linaro.org>
 <7f24ca2806a7199e4de6fad17b8dc1f127c82180.camel@mediatek.com>
 <c59f2f33-ad6b-469d-96be-9345920370b4@linaro.org>
 <CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=wXpobDWU1CnvkA@mail.gmail.com>
 <3b04c5344435cdb941b5d132e8f5fbfdf9188d67.camel@mediatek.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3b04c5344435cdb941b5d132e8f5fbfdf9188d67.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2024 07:06, Yu-chang Lee (李禹璋) wrote:
> On Wed, 2024-03-27 at 12:55 +0100, Alexandre Mergnat wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  Hello Yu-chang Lee,
>>
>> SMI LARB must have a power domain, according to "mediatek,smi-
>> larb.yaml"
>> Now you try to create a link from power domain to larb.
>>
>> Here is my understanding: when you enable/disable power domain, the
>> larb linked to this power domain may have an issue. Then you want to
>> retrieve de LARB linked to the power domain though the dts to manage
>> the LARB. 
> 
> Yes, this is what I am trying to do.
> 
>> IMHO, using the dts to have this information into the power
>> driver isn't necessary and may introduce some bugs if the LARB node
>> and power node in the DTS aren't aligned.
>>
>> It seems not implemented today but during the LARB probe, it should
>> "subscribe" to the linked power domain. Then, when the power domain
>> status is changing, it is able to "notify" (callback) the LARB, then
>> implement the good stuff to handle this power domain status change
>> into LARB driver.
>>
> 
> The problem with this method and why "smi clamp" is in power domain
> driver is that our HW designer gave us a programming guide strictly
> states the sequence of what we need to do to power on/off power domain.
> Using callback, this sequence is no longer guaranteed and the side
> effect is unknown... 
> 
> So I would like to stick with adding larbs just like smi into powe

You want your power domain driver to poke, asynchronously, without
locking into registers of another device. And how does this not cause
issues?

No, work with your hardware engineers or Linux engineers on sane behavior.

Best regards,
Krzysztof


