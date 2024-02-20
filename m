Return-Path: <linux-kernel+bounces-73721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90D85C866
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52C41F224B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DD152DFD;
	Tue, 20 Feb 2024 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJ6oHUQB"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EAF151CEB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464073; cv=none; b=jZ4+8MhlcGwQEt8yevNkec58koQCd9AltUVAV6UMdihSj3Byx0fXJhhejytu9DvIzqrLaHsQw/7qWbmvQ3fTakQf96l504v8xqJZjMHRlupIGlIwJqfabjFt+FagdNXGsng56XhPZT+jTNfJzIFTSESG6sDi1n/f8vv1OW/21Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464073; c=relaxed/simple;
	bh=QIb79S8dEXh8LFbr/l1y4IqwiNhKYcYdvIOdGbZPR10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opaRIZuipo7cLgld8PB2Zjgyqyn/09uVdD1WxswUaaN0QJrBpKnXzu/Fp2Iq3/01aqpNrJ0qGBoA8o2khNbQQQKJeIV0bYBXz1zq4NIfbGVFLzLItmNs5/bwpM4qDUg2lccmvVvDzIGxJe/oRnOopk8Zcqx3jVftfwFqoVTs2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJ6oHUQB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so3094448e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708464069; x=1709068869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aewqZFQqAR8f8P67ZzKs5ZfSe1DqicHVEuGcz5XnehA=;
        b=kJ6oHUQBobYzdU7nmQFkM3o1PTzoD/1gWwOCvaCiuaShekcaWW64iGJ+G9nrY2rEXR
         ty/VqImKjaPAXIHGh2hBywNFMUNF37eHSug1XHzVLgjEuUPekwwFHi70nlxVG97wMkg/
         bq2pXuDPqDRpW+M4DRfa28qEVuwOVDtOvfgzl9ZKQAyxbnHpK0dxu2/pXFU1zwhFfArn
         IV/xkFys5PLZw2jigIjJCYO/DoTEXCkVImGCVNfGn7SAims0skOmVCLUvgVcn3LRdSxf
         kg/K6oybXpR6nWqv1J9MO5bZGveHi56Hr9fJ+/e0AVRuBXvjK+ot0MI1492XMKc69zwQ
         kEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708464069; x=1709068869;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aewqZFQqAR8f8P67ZzKs5ZfSe1DqicHVEuGcz5XnehA=;
        b=ZfgOpLykuVIRqPyLmjgX1FkCiNGP3t+jV6osM6lDZL1oYZbtrq8U1A0Ip/csOXuRyG
         eHhmJk9lDKf8z1zFG9MtJthU7HbHQceMCePEAj5s14hm8Wo07uL/vqyQOgG56OBCy4sD
         E7ByHofTKmkfJx8j1oR5Hk1SvbP3Dr7fAYUjrDjdH6l5LAcf12xn2gvunHnQhCcv/5o6
         eAb6Y3PHpAmvuucQpvJf19QvAlfT1urJ8YIPMiNTOYJrPs8NJIyImq/U/mIDF4qYbbIn
         iSmr4xyposCHmhAXpnam+XtMuAYKz6CwJKDIB9o6jlIUkISOda9wqaMWrTNoHL0z/H3e
         AmGA==
X-Forwarded-Encrypted: i=1; AJvYcCWoMJlYnIkotyNA75585rJ0evfRcL2+DlSanIjOYVUqvTmIad3ZNSkd5FFwLicbr6iKY37t0HjqBZs21QKQI1tM8L095lSvHSqj91CO
X-Gm-Message-State: AOJu0Yzo9dvgpnyqlNf6BpEuJR42pN9/RsZU0oMlJwpd9qvLPk8PrgVT
	Wqh3V+Zs0yXb6cOldIOZhn+clJyjF6kLb+lVz+/2tYer8rakuQh5oYt7dA+y1W8=
X-Google-Smtp-Source: AGHT+IE7oxGB2v2CxKN0KBUsYoVrLWeS67J9KHU2sgtn9zhSwTZSLaGf6S53k3pQEILvmz2pBWcsQg==
X-Received: by 2002:a05:6512:48b:b0:512:b85e:9831 with SMTP id v11-20020a056512048b00b00512b85e9831mr3472902lfq.36.1708464069273;
        Tue, 20 Feb 2024 13:21:09 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q23-20020ac24a77000000b00512b25729bdsm972840lfp.31.2024.02.20.13.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:21:08 -0800 (PST)
Message-ID: <17bbd9ae-0282-430e-947b-e6fb08c53af7@linaro.org>
Date: Tue, 20 Feb 2024 22:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/18] PCI/pwrctl: add a power control driver for
 WCN7850
To: Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-15-brgl@bgdev.pl>
 <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk>
 <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
 <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.02.2024 13:47, Mark Brown wrote:
> On Tue, Feb 20, 2024 at 12:22:42PM +0100, Bartosz Golaszewski wrote:
>> On Mon, Feb 19, 2024 at 6:50 PM Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Feb 16, 2024 at 09:32:11PM +0100, Bartosz Golaszewski wrote:
> 
>>>> +static struct pci_pwrctl_wcn7850_vreg pci_pwrctl_wcn7850_vregs[] = {
>>>> +     {
>>>> +             .name = "vdd",
>>>> +             .load_uA = 16000,
>>>> +     },
> 
>>> I know a bunch of the QC stuff includes these load numbers but are they
>>> actually doing anything constructive?  It keeps coming up that they're
>>> causing a bunch of work and it's not clear that they have any great
>>> effect on modern systems.
> 
>> Yes, we have what is called a high-power mode and a low-power mode in
>> regulators and these values are used to determine which one to use.
> 
> Are you *sure* this actually happens (and that the regulators don't
> figure it out by themselves), especially given that the consumers are
> just specifying the load once rather than varying it dynamically at
> runtime which is supposed to be the use case for this API?  This API is
> intended to be used dynamically, if the regulator always needs to be in
> a particular mode just configure that statically.

*AFAIU*

The regulators aggregate the requested current (there may be
multiple consumers) and then it's decided if it's high enough
to jump into HPM.

Konrad


