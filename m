Return-Path: <linux-kernel+bounces-59608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F084F9AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17FA284CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846447B3CF;
	Fri,  9 Feb 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQI9qPXS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183316996B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496464; cv=none; b=QUlh46bxAvXWE20IlyGQfX/PlO5NyNSJHxdtYZmWGI2oG8vTL+yDy7JZgYuATETjfBgYhiuHjCC35LGXY0MMCf9LdTkBBjw/NZNajcX9dZ9RBGxJ4OGLzI0MqSv7gP6eduF3eQqIwIusqDzWZKEDPmUxDUVWk6YKKO3CUURST5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496464; c=relaxed/simple;
	bh=8WaqMyptWvhbjfJo2zTu2UQfOXF5jGn+OXnDraQT8yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0AjCnN5904KJ+U+6kl/RXujtjk6u+77j+m258SBYp0d6NlSr5YgtkHM+f5b+v1LRu6+V7cxZ08z7+O3Ru0YoZaWvBj5ciOqI3MLGi+Thof/WaCjw/vhHFR292r8qIBrc6krMy6sT3jbvl4DsQD0+3Qsfxq9SE6fLlC5XkboAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQI9qPXS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3864258438so204757266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707496461; x=1708101261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+HokFitcKdksackVoFNwEM96sXd0wCX1oPDfj5HZB3E=;
        b=UQI9qPXS622NnDfw30BrydMNej78Ce+pV90FLzQSWf2pqRh2SRgk4madqC2wQVeM3I
         lAgse2obvs7C4UR6sf3mlF7d/OMw27AKIcWK5oHqOIZFQa8pw8QxqucYcvAW77kB4k/E
         99108S5VY8Fgc1TLZQ+mulckfb/UWaOilCB+gvKEPM2Q1nv+j+GgfSrx0vtsNmAp91v2
         jhxwyE0qe0rOMKk/p9EdTISrUGSUVeGsGvs2xn7Qn01tmGvgRtmIJG40Ag6VtNnGSG1p
         jbnTIrVEQKh4VSoBXAdeCXFI0kNzqtJaORw2BWbgg+rqKZhcyGEtvSo8Y9t8hJTX1exn
         ZIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496461; x=1708101261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HokFitcKdksackVoFNwEM96sXd0wCX1oPDfj5HZB3E=;
        b=otED+BmlZG1JZnPT03tG+IpqZCytrbuz9AnItJ1M9cs5bnpiGsaGFn5pCMF2ssU14S
         nrMnh6YH0OcImO1hItypLboZe1YYTPh2sDHKb91hA//bfNalFav4aJ7iZvPZ40Df8A5u
         7+yPEF6xdhGsVMCrZXPvmlS6FKUIVfwJfeXFDyQMVtEIvlWmOUPl0EAu9n7Fed/YF8FA
         V7ovX02CMxHKlL01Gwt67dV+vk3r+cnaqjJN9e5EzuBPS2ThjQL20RoFX8WMX/xyCE9y
         OgxNgaXfHjUyiGiXgXBdRn6pnbH69RE4n9Hpr+Ela5zFe7RAEuTvvu6dXRfJeCt9Qwfb
         YOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8GtvFWRyKzlRzkbqr+O1KeMDxAIxmg1gG0ugP+qpggDfyj4WhAv+sWDwSTd16CBzUb4sB395QhNWka6GegFQEc1TC6uzIBlpKota0
X-Gm-Message-State: AOJu0Yxrp4aqQHGnwUkU+OFZj/IAn6j91qlniwqNGGL0Roes2EeO9ooT
	RIdftQK4co7tkW4xWO1wDEaH5q1RNpVV7/FseV9vRsqwObhCEKdsMhAQBMJeOzk=
X-Google-Smtp-Source: AGHT+IHJwu+01Hw+7iMFv71NjXpUXxYcSHPzcMndoYMDLGkOHd75UzrkVD3lpMOBLad/tfU3sQVn1A==
X-Received: by 2002:a17:907:9410:b0:a3b:ea21:e2 with SMTP id dk16-20020a170907941000b00a3bea2100e2mr1945769ejc.1.1707496461397;
        Fri, 09 Feb 2024 08:34:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmGwgIEyk12k7bm4d1JjYbd2FdGbsWyZjlyC11/t+fhDSSa7S6jI8wak5cI3jj56oeJGHgas8aCryRxkd9tTYFgcaFfdL3q9pFPS74sJEuUEVtNm+oJIh4uDLgu13vS4zIgm/ViQ9L3Gc7sSQN9Jn0hMF/zSy9J/SIy+gDFhY3IuEU99yKunKkW2kT+Ku3nNGjrZWkAXfrykjn9dfE9ZC+Z2EkkPirhbtOLNi6WIEJUaQviZYHu6xAxxEnDzJ+dBmLgfPEcTOJhAKQ+of7n82IXLFqHQ2mQwcJV6q3YAdr+lXyhrGvd1DJUZ1mVfkGkzxA94c6pqphetGGZwiO
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906195300b00a3bb8758a4csm896742eje.131.2024.02.09.08.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:34:21 -0800 (PST)
Message-ID: <9deaa4c5-02e7-42d7-896a-4bb2af2b01ba@linaro.org>
Date: Fri, 9 Feb 2024 17:34:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks
 protected
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.02.2024 17:21, Bjorn Andersson wrote:
> The SC7180 GCC binding describes clocks which, due to the difference in
> security model, are not accessible on the RB3gen2 - in the same way seen
> on QCM6490.
> 
> Mark these clocks as protected, to allow the board to boot.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad



