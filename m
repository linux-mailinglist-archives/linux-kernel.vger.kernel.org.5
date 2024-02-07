Return-Path: <linux-kernel+bounces-56423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C579D84C9FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046461C25FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98511D526;
	Wed,  7 Feb 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ey585n2O"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEA1D525
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306779; cv=none; b=H3C1xnZnrH6Y1PVp7UMarokhtiDaEihgKUfG98Sc2eBOTJDVIJWkBEuZIIKWLdIF7HMRVmzcy9zQyJ+xiUAz2cxA00nz6+0ruiha4eAf9oiuCM/w+PIwgJi7B++Gc3XcV3PN7oQzC6IcuNQD8V/Px1sNIPMIiOJzCXg2QzvRh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306779; c=relaxed/simple;
	bh=eV5wBqXyYWxm3GJYq17Dw7WMBVfXoMOnaHqJbXfRxOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=monyGUmUIsk9BeDGJmuiFuaDPbkvZgt9RPGsPbcj12gbAZK8hszMSs/Fid/yt+tlTTjs5sZ9uOdeZSKdVGGsNdnmdYsEKQKMGE3ODo4HJ9Jdf1Cn4WdPWhvg8b+Gk0rfgKzeZN32MDSiMr4ITMRAlSsMkncl/ZeiUPDtgCO7mFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ey585n2O; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a36126ee41eso73211266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707306776; x=1707911576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a15ZhCM0RHZkt7ueSuD9TDSzAwNNe3GnKdqdBGrHtl8=;
        b=ey585n2OOE9j0VYyD4xn0Qh01PSRjsJ5aaiZlwMDyTeYf/aNbhc0ON2xXXyhecOFh8
         CP1Levg7G89WTDZtBk2uHCBvsLQBwBhTTm2ts2aAOq16T/CZQyf38DSwMF6Gav5u3Bcf
         0XjeI6uANd4BkXakS9MppFJs5Elpc0sh9YRUaWcNt7Siteg6XXLP0jT5whyRFjHktXD+
         9N9o9IRyKv2JAXOTMqvvk0it5037UOwDwbrap86+U+d8DdeKqL+XMCIxAXPH46zsQWaR
         tgQJm5nuYBmalEQ8FZE4yz5EIG6oc2OsoDLXwhCg0YzDAkC2Gve7ioFyjrWnyBlJ9Twx
         OZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306776; x=1707911576;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a15ZhCM0RHZkt7ueSuD9TDSzAwNNe3GnKdqdBGrHtl8=;
        b=CxRsiCSymKeLCyf/lOAb1rKKY08cUtlc7TEVD7YCyiMq7YDrELI2hm4zSINBZsvkaA
         Gyv+UvjZu10L4Hz++HbkBpukJfeLGim1GCMq2kOMcdpwnApI+fhpLIcuwBv4GqDfHpWV
         1ZKj9qFJXo6qM31LO5n3OYsmiUgBakxdsMYPHAkddQxMr/0bdVTfY1F7kBlFx+wwQgmo
         DIPnzEuExvZUAf5bG7QOT1MYudJbkRj2AzzVuVDLJJFXbGSc93eHgtzhGWSelLVoOToM
         sVAryoRduzygfjfGUfaqPRaZ0GKFgqYtPKf5AM0IPqoK88pcSdPkUqZZR4nzq39wiUXM
         Vngg==
X-Gm-Message-State: AOJu0YwSsmnU8JF7xlJXXmRJcgJdK90pP69y2Uhlx52Cxu2h2JugJ0cU
	GWdHYbYBqmF7z3xtD3hRWP4ZGcsl56x6+fPzjR/91fSUI/5EWIX3DsIzthXEH4k=
X-Google-Smtp-Source: AGHT+IHD5LgBNqffuEGmyaup0AhvUur8sSstagtQoaWu6P9MEnV5Gf8YaH7zqiUNUZXvgFDyqZM4ig==
X-Received: by 2002:a17:906:5a49:b0:a37:78f1:1302 with SMTP id my9-20020a1709065a4900b00a3778f11302mr3558917ejc.70.1707306776051;
        Wed, 07 Feb 2024 03:52:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlD3zvNR+AyI+BiMqELJHPtrhlCMI006Y1oTK+iMGepbeLYiU1rQ1dQmEhOmnwqA+aLT+yzOQMN25NCuszemxePKLknkUjqc5RFlBenfLJ5FEA1G2oB45yDwAoUdXPTDvFl4HVEjLBcFvTc1hID4uhMdbpoxb+I98V07l6FH4N3eIC0KT90h/bXg4qc7ur4j0arl0QtICHgVyRE+WQW2mSebS+DSkQNFecHBgIxnSDwLun1HpRfFl95GrdOabCWH3SuehInhLyEV2HCSE9ktR127BSr7MF1xKD9tB1hcDwuCVFBPMCQ99Oyvv6e8Jue94ZhKWXuayDld9bM2DNRumTEuFmBWmnejlOFcDsEZMfpNuimtsKnrskgKZ/o2BWfoXEH3TjGyWgvK4GqsGsTdFt24VVAyHBbvYcgyvvqOIXPRSJvan0luNRETKR5mKRun3J3nyi7zw2huaNmF0=
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id ps6-20020a170906bf4600b00a35a11fd795sm670284ejb.129.2024.02.07.03.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 03:52:55 -0800 (PST)
Message-ID: <a5fba6b2-4bb1-4b9a-9fb6-466fa816c3d1@linaro.org>
Date: Wed, 7 Feb 2024 12:52:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] clk: qcom: reset: Ensure write completion on
 reset de/assertion
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
 <20240105-topic-venus_reset-v2-3-c37eba13b5ce@linaro.org>
 <ZcNIT-NxKSZ44NjZ@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZcNIT-NxKSZ44NjZ@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7.02.2024 10:07, Johan Hovold wrote:
> On Tue, Feb 06, 2024 at 07:43:36PM +0100, Konrad Dybcio wrote:
>> Trying to toggle the resets in a rapid fashion can lead to the changes
>> not actually arriving at the clock controller block when we expect them
>> to. This was observed at least on SM8250.
>>
>> Read back the value after regmap_update_bits to ensure write completion.
>>
>> Fixes: db1029814f1f ("clk: qcom: reset: Ensure write completion on reset de/assertion")
> 
> This commit does not exist in mainline or linux-next it seems.

Yeah, I managed to copy the last and not the first commit hash concerning
reset.c :/

Konrad

