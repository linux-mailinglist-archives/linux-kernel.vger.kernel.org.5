Return-Path: <linux-kernel+bounces-136589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7A89D5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1621C23093
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A480603;
	Tue,  9 Apr 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkhzI1rB"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8F7E575
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655997; cv=none; b=soiQIr/51DTtHUTFoyKvpU84SqnhTnpYS92+dfZuzs20qa3St6fvBxdePEP83SLppC4EcW+Oh0rvaUUXUyfmFZBjCsNUpK0JyQRPmtGeNnj9ZEN3MOAj9bpKCEHeT7/VwuVuGPDEwr935XaujZrHJV0Ajl1WF3bmrtu6vHhwr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655997; c=relaxed/simple;
	bh=Lhll4Ya8gvkYKddGbyKns1zLoe9n7V+SCV6zEQrpnMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOqWl3b+U19O6S7GxJCzY1vWRdc3rjT67I2bcqbi6nddfaBpe+evpeBY7QLkyg+TSzUm0KtFb3EqVsjXCfusliN80HXcT+WIQ7G53PHtzCkrvxqlWNdiSXk1ShxSYfJEyxltXMyFcwlqgWm6lbkPqEKzNFyWTYm+zphhrKDq7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rkhzI1rB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d82713f473so92331311fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712655993; x=1713260793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Egh+t0F7kstd2Dcv/3ADKSuF91+/JiZpQiMUf3T+HAY=;
        b=rkhzI1rBSyFNMU4h9AVAM6+rmJ24uK/WvkOcZu8fRXo7xyJop6fduA+JmeFSr+D9MD
         GF2bK5QpMsi1dw2aKsOY9zL0kAqCu+FTkmD4eiQlusqAI1wMdOckgAJ2IF+vGPrwa2d9
         zg6YPL5xaVpsBEpSOx7Rf/R7JTrZNkkCZH1xRsC2TlOuXL6hFimfGjgIc8hdwqKoGErs
         BBmMZqVAxT8m/akVR0oh6/b+oTq5pnK7F71wl3APGevYH81DfeYU1QfZ3UIvwwjI6nl7
         75K27v9MlGjBfTB1MIlZAqEd8i82lbt4gEh0/mJfD+44viudugAoEYTc/TsaI8fV8J55
         pGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655993; x=1713260793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Egh+t0F7kstd2Dcv/3ADKSuF91+/JiZpQiMUf3T+HAY=;
        b=FUwubHs5FFKllLRz+wOZBcfbYaz5/EPeDcfa1A/Rj6gPQsKVUYwIqjVYGAn6qRSA+5
         u96h68XmO5YebCYkD7jvc9sCClW93rQWrTnvFvZSUhSxQYfIQrrM/Kw3Yp0wLjvqKWeg
         9WbuEY8dd71Ce/BFmJXJAXiYpcGZ492RvcbTfVcjHFLLbEJNaIZM7I1ZZFkAbKXrzXPo
         er625T10wzx2Et6C+EvLMTlWPvlHEKD0q5wnT/HO6Dz7lfBl8zNYMKkTRLK4qJVcq8ZG
         jIOYfN7Jsl2TAFrEkg7kFcZsCIahBxKqj/za7KTuEMfRbj6II6awfvNY8k2aKo3yGzNH
         /UvA==
X-Forwarded-Encrypted: i=1; AJvYcCUEfukGTwM+SgSJPZ0WdmRdUtraeUimm4URQcm9BPQmS5DdBIzHTMvsfWV1SrSQZkTqepOQdm22uaENFg+a6nzFkLQfGigF+7PFzh5t
X-Gm-Message-State: AOJu0YwU9G+BTA8P5mAf8rYT+zg5taScwwVXp27VgoL5ZNN5CabOrRNO
	xdpbyLyGJPahgJv4rZ7j8nkdbAIwP15cZouxw5Nh5kEO8yZVEs/lF6IqM3N0OCY=
X-Google-Smtp-Source: AGHT+IFlaEzNF5o0Ls/6Qgk/MBgGQ4kPQ8KXJ2uZuOCbPpeTHs++XApTTNl/QNR48dam9TbOlCOEIA==
X-Received: by 2002:a2e:9042:0:b0:2d6:a609:9a33 with SMTP id n2-20020a2e9042000000b002d6a6099a33mr8296135ljg.0.1712655992794;
        Tue, 09 Apr 2024 02:46:32 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d12-20020a2eb04c000000b002d70a040f21sm1444570ljl.91.2024.04.09.02.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:46:32 -0700 (PDT)
Message-ID: <13da735f-e109-4dc1-b246-cb8c7928f352@linaro.org>
Date: Tue, 9 Apr 2024 11:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add Motorola Moto E 2015 LTE
 (surnia)
To: Nikita Travkin <nikita@trvn.ru>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?V2lrdG9yIFN0cnrEmWJhxYJh?=
 <wiktorek140@gmail.com>, =?UTF-8?Q?Val=C3=A9rie_Roux?= <undev@unixgirl.xyz>,
 Stephan Gerhold <stephan@gerhold.net>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
 <20240405-msm8916-moto-init-v1-3-502b58176d34@trvn.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240405-msm8916-moto-init-v1-3-502b58176d34@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/5/24 16:06, Nikita Travkin wrote:
> From: Wiktor Strzębała <wiktorek140@gmail.com>
> 
> Motorola Moto E 2015 LTE is an msm8916 based smartphone.
> 
> Supported features:
> 
> - eMMC and SD;
> - Buttons;
> - Touchscreen;
> - USB;
> - Fuel Gauge;
> - Sound.
> 
> Signed-off-by: Wiktor Strzębała <wiktorek140@gmail.com>
> [Valérie: Sound and modem]
> Co-developed-by: Valérie Roux <undev@unixgirl.xyz>
> Signed-off-by: Valérie Roux <undev@unixgirl.xyz>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> [Nikita: Use common dtsi]
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

