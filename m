Return-Path: <linux-kernel+bounces-55512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962784BD94
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B444AB23B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182513FE4;
	Tue,  6 Feb 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnf1RTss"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8C14AA0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245880; cv=none; b=EEY5FjfUB6eAHKXcC3UjXC5SmIgDCRLJ6QGc2hs+uFhQ74y9XWDFzAi8X8GdcSOkz8H5rXxYKSCI78W1aD8iiaYnm6sXvzjT4p3okzHvsn0H2QQOFZVX9CPt8nh9cu9IcxqBTT4Rk2ePSF9DO7sFZDVM50xwHBujGx3Th/usMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245880; c=relaxed/simple;
	bh=811TtQ+u7lVkK0DFvD7XxzbN/eKD39v1rQxALwhDaOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH73sOBTL6LqKng8OsipNSnkK+0lxVLHvto1oXMUNhgHXxghekZZdovJFWmD50B3HaWXtJfVHcii11dixapqG2CJNksa2xFLtuX6AL7XkfvHA9huZmQIxCQFX8Z0fHC83ovX7hyo+rOkemo1ZH+zkmG6YCX2i0WMyuNcuUBRZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cnf1RTss; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3856588ba8so31925766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245877; x=1707850677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vixop/hbyXnCNa7TQeaAEHJb2bqnpeq800yiSE0X/Pk=;
        b=cnf1RTsslszJ4schJ4cNngvJR6MMEaX8w5P0zWRhWYmT0m7I8UkYVoTvTgQQB0SAx2
         KF7QDI87t+Q53ynVFwuCR5eNwxWjuzI2KSYiVeAPznxu47KShwY+VpeUQgVFC1l9lhR/
         ASf9csptToD38Ytx0k8066jFA4ibZMHu7v+l8uwE2GDDXE9XL++Qgx4FOmfkatzMmJfB
         7eNtdTDFEZGzMi6c9rNQKVIFnb+x64uf4rtS7ANaft7B8dCJjLXPbESDubYTjx1lEnoL
         6TxK7g4o5/QYfgJhWKlPyQ1jux0WKwAS8yvX0y49JXTfHzq+7+8Pj1swpuw1oyoYvwvl
         p8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245877; x=1707850677;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vixop/hbyXnCNa7TQeaAEHJb2bqnpeq800yiSE0X/Pk=;
        b=wc/uhKUkLalbsZAdQ7pY6Snl1/72HhKjsVuGDOdwgcJWAS/b5h7YrhDEFvRRDkd5fG
         Rjp3IjSKg62eXRhJvX1Gpe4w+5UbHS7ujFBbD25jR7KEKNXo6hjpwtHYFES6FA/zS6hN
         Xd3dCiWkrZBEt5boqXaNC098n82hTY2d5YtpBFYqO8ZSdDbPq4KoFujdRLGXuMtdRTCd
         Zvh54B9f/FHrnELygfCwWm/utgpN6WnklGJ9X/RTKktKKBLdgYq4z11+aUnymM/G1aTs
         4wYxPSaDNjew3d+yToI0p5Dx0Yw9lUAaZKKJnUrhhNdHAf27gef7SGqxGDJ0l7VibSgL
         20cA==
X-Gm-Message-State: AOJu0YxHAY3MYafr51riLt0JA3dxdP4cHwYVc/ngv5U0BpGo05E5wVPO
	tY4RSW7ADTVXi0bcgjCNPrRINsgGf+3gCXTbBzE8SjOF24vdAIY6rIo3Og1Dr/g=
X-Google-Smtp-Source: AGHT+IEvcTOcw3XZZ2sXTIoiIQ+uxuF8HNW113vbCA1U2OAVcXkOUXxhonx22HNefZoUYmdv+dkOug==
X-Received: by 2002:a17:907:7673:b0:a36:3345:be88 with SMTP id kk19-20020a170907767300b00a363345be88mr2787197ejc.30.1707245876909;
        Tue, 06 Feb 2024 10:57:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUIFCh9PHZuEUexAjyDgcBWwztla682CM8RVE4eHVTSOxlUxipKg/87DT/meLoDOFvXrF99DcOU74GXTle8jhXpNNdkjgigQF6fIi32Ge67I4C+IF8voyPp1QRljgI61qa6nO2BLpDTwcFxEbj5yn8+NrnHbuzfQLwDGYEHgV63UBIupyF74Qqb8yERdobWlDAtS9lbbbdPVymu22Acpz5g/75ZzNhre1AFkc0ZnHYzi38/aOZ4r7Gp4fV0yxFmgfceUyagwsHZ6+GrrF0eQFdaqsYk55e5sWm35JbfHNOfGmipbHYiuxfySVWqalnikfp+XWgyvWEWDbt8X4n3tU5fMD1F0stSdAftOariSjbcfgPB4LDgydPwPbW9zSLCRDcWgtgZWydFFY+YtmDZqfE26nld56mm+PeRfXggXXVtpRhWbmMjZ9iNn1WZaLYEFuUWd03kPgjCh6KSB7+BtXAc5slUrZssuIvmALoiz/lG2jPGf6qCVr8sTu//zKRIcUQVTnhgg44/liGT47ju+QJnX4wow0Eapt4vRg==
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906071000b00a371eced193sm1465555ejb.49.2024.02.06.10.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 10:57:56 -0800 (PST)
Message-ID: <3222c2c0-542d-4584-8283-c679a18315dd@linaro.org>
Date: Tue, 6 Feb 2024 19:57:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: msm8956-loire: Add usb vbus and
 id extcons to ci-hdrc
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
 <20240121-msm8976-dt-v2-2-7b186a02dc72@somainline.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240121-msm8976-dt-v2-2-7b186a02dc72@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.01.2024 23:33, Marijn Suijten wrote:
> ci-hdrc does not have the ability to detect voltage presence (5V vbus)
> on the USB connector nor the role (via an ID sensing pin), and relies on
> the PMIC-side charger to provide such information through an extcon
> driver.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

