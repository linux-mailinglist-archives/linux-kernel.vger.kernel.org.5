Return-Path: <linux-kernel+bounces-78288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748C86116B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500F5B219A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6757BAE8;
	Fri, 23 Feb 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCTRbhSt"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9D63104
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691022; cv=none; b=Wr8UY17rHNB0VfYTygYUEB7Ti64bByP7mkesAgwNLPXI6W2zImmMfiu/nAjwT6OQhIjtAUyKq2mbb6vy4PVwThAmiAD0wLRloZPF7y5UfwdNEIlHtnNxdPgTQTdK7O8cgKZk2KBJ/vtybepZXI1eetIvRkxYjU4+1VypK1jOF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691022; c=relaxed/simple;
	bh=NKGn1r+5p3H5zKXUsYG99yRpWFlDz+56uQrt0ylyUNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4tGG0xxZh/dzW5Y2Vt2DoghT2pn+BNK0GDm+npb2GZBQYcwxH/5wciW6549MhHkbjiuGTpJXn29zPMwduUAMpfX9iBrr2IVUhTFaWVKtDTu1kelsVzeAQAVgUDuiFk3M9n9EMrNYGhl9K3gqtSH7T+gCJiV70pplBgHpTwrnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCTRbhSt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d2b354c72so215021f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708691019; x=1709295819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQOmmDAHNb8LHRbOSJZq+6Uxp8YDhnDGFn2+TQ7yf58=;
        b=iCTRbhSt91WP56cedhSbJWd2W7dAW6y5+yhhuXih2NQnK/twN8IqpBFzmxnjGPc8nr
         vYOCIiF01+RG0xZ/3k8vCvG4YbJ12y9Fs5uhqn6mWXfqx0/xuVwVYuLnLPW7Bqu+wq21
         8Croc1G3XycW1Q4Wb6G+9kV/WE8BXkgHNwOSj7bloH/84QOSbgNnL3M9eSkK1nYGUGUD
         0aIB6F5G43iM6TA+6aRQLglHhZefbr+ODQgYwV8g3/IVxX8eR5acooCBZUl64QQOP1zD
         F8rSVs4mroavWUQ/cEorC6kw4z7uneCSHJhyFuPzp/UtOI5YVLd7p2ttQl8/fNIDaEgD
         EkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691019; x=1709295819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQOmmDAHNb8LHRbOSJZq+6Uxp8YDhnDGFn2+TQ7yf58=;
        b=F+FWhsnRSmojSF4S6ojgFQulf4Tvr5wHOoEzNdhF391TvpX8DwIjFfnvO/4u4pbMsv
         D1OR7j7kJA0QiC7fDJmRVtg7IPZAY3FaiIkU5jUr/q4JP2mttQpL1PS8Y4YveOAU/DAj
         KrumW/MKA6fEZdRQp7Kl11TSbYteQRZqnp39l2n5aHyK8cvp4qz85FEbpD1geVvmLlZW
         aLgjLOh9N29OUR6o6V0OLvSMtsnIfv4k7mMQHp8wrGKJ02aqsu7lBFwtAWowwjjmezPz
         wLxoUjKjStipHJ43hG10qEphBTB5dIe6DKTy+yBKGVKDOJx6BFo0jJ3bbUwAngaX98LY
         E3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLqIaE3jSU9e07ZhNqToibSNUCG1Y1t9q+qlMzfbOQp0aoeQpb2x8CHlVKRgMkNXireeXco4paYoi2e+0MhPT8ngje7xZxbR3ISN2X
X-Gm-Message-State: AOJu0YyP1H+fPabFuVgD8uTHXkUK45lNtKsVNU1qUkeWYXA6wwkOFLeS
	TTFXuDXSQDzOhVAtd29ICJ/CUqY3okdJNX9QrL5jzTqlKpTUFYh3RIeIlORu+gE=
X-Google-Smtp-Source: AGHT+IEwKRwqNM4uowp13vp2rQI4u/M+PLn0ngC7EVXLHt1GfirC5r5MNLXGGhCi3JM125UVA6u4cQ==
X-Received: by 2002:a5d:6781:0:b0:33d:4f0d:7e75 with SMTP id v1-20020a5d6781000000b0033d4f0d7e75mr1195059wru.53.1708691019179;
        Fri, 23 Feb 2024 04:23:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k2-20020a5d6e82000000b0033d4c3b0beesm2674392wrz.19.2024.02.23.04.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 04:23:38 -0800 (PST)
Message-ID: <54605748-e737-46f0-ada5-0e3e79699262@linaro.org>
Date: Fri, 23 Feb 2024 13:23:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] dt-bindings: timer: add Ralink SoCs system tick
 counter
Content-Language: en-US
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 devicetree@vger.kernel.org
Cc: tglx@linutronix.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20231212093443.1898591-1-sergio.paracuellos@gmail.com>
 <CAMhs-H__b2dNQH+nsbc0+gTeQPmkZf5B95+3Y88iRZ5KZmu=yQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAMhs-H__b2dNQH+nsbc0+gTeQPmkZf5B95+3Y88iRZ5KZmu=yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Sergio,

On 23/02/2024 12:27, Sergio Paracuellos wrote:
> Hi,
> 
> On Tue, Dec 12, 2023 at 10:34 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
>>
>> Add YAML doc for the system tick counter which is present on Ralink SoCs.
>>
>> cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> ---
>> Changes in v2 RESEND:
>> - Add Daniel Lezcano to CC in the patch itself.
>> Changes in v2:
>> - Add Rob's Reviewed-by tag.

Applied, thanks

Sorry for missing this patch

> Gentle ping on this patch. It has been a while since it has been sent.
> 
> Thanks,
>       Sergio Paracuellos

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


