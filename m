Return-Path: <linux-kernel+bounces-83015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D2868D16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733192824A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D311137C39;
	Tue, 27 Feb 2024 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kB89Gxti"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4949137C21
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028766; cv=none; b=Kj3DAkTiy9eR1siyWgQYNWlPFT5Do8TxCQswRtnHnu1X+ALaWJ+Tnhnv9+ZlE52uduHUQOmbh6v8exbj2eDOoSe7xIPlii+UhXFGg15TFKkdEIm9GEW/ByONLTK8OIEzL7ix6tPNQ5AklqOvz2rGRmqc7BP5bfexVWJjCaeExUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028766; c=relaxed/simple;
	bh=RPCuL5Zw1DFBhHuejMGcZGxtCQR3v1sWQkrzuFlOItw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQD5+qM1Lj3D//0Za64tf5ZlhlksBZht0YH+zbDP5bWk4RL9MNs3N4aPGTxjof/m9JBxc0FwKZpcabe9xCfcjMzqMRysMIZkBEcWfnxHOBVdwIpAUgwW2lbNJTaADfEHFxBQhqN2cpC2vCX0I6dSFQOxXr+pZ205Br0c9P6CclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kB89Gxti; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513031cff23so757345e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709028763; x=1709633563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdcTuKOvy0EUhMzr/avSzwKVXZwTIOQgOR4V6+G/+Rk=;
        b=kB89Gxtic681XuWzwVRiaaSR5JV8/Qh2YIUtDwLeVvGUBCgYgCZ//l9iHV28/FaGyK
         wlLB61x0NGBDbnOaDyRd486jCLFfRX4cxHpsgt6qzC+MttknQMEUbY91AFLtbikTOrYI
         EXXldOwRk67Jj4PTBp7vd1VMNrmqmGyy6BwGdWxqDaLogzQXlDyFvKlbQ8HqVL9Xg6N+
         5QUesUgq7ycp6M3gKV5CrKzNuTmNXc40J8AGdjBd3KgY4RuVVk/J2HlRIolpPLpu/a9/
         OWvAZRdEn6lP/7M8C4syQV9AJ7a/dS/PJW3tC4MYfV6EXK2x/O7zktC2EQCA7hNIQbYO
         86xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028763; x=1709633563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdcTuKOvy0EUhMzr/avSzwKVXZwTIOQgOR4V6+G/+Rk=;
        b=wZ4QbRC6WUAJjbfQbqSMJm0tTP4aO9VPdEmmHG4GYo6HPpsSO/YP8XRA3+pKSNGK+Y
         P3c2h118J8tw3XK5Y83lFzE3GT7l/WpM/RqbwJTdBQenUWZbtFcRi8wcaUxjje0R6ee8
         5miqpmlOo6st+ndSz3D48KttuZ4CNZ0it5ZhYs2VvwT2fTAL6b0WR6jz9qgfzSy1NleY
         4ONf9imPLhbaESIKonf683SsvQsKPpa2CepSCeNMjlVX6IkSBSiK1cS2ubaKurGKmdTv
         B8ttX9eX860yooAz9ToMhPC4uzi4cykUtlgNvq5YSSPPTCgbY0zW3n6K4nMr7Dobx9LR
         dQCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQj9eCdKSbs8JEX8mGc07TxR7YVMEE4JJHtEAHu25uFnx7UdjrXpjJl6YFZkBm1ZRST84qaHBYcE3zoGH93nP2SDGuoMHVj1gNUk5N
X-Gm-Message-State: AOJu0YxT2XLvtHvkVAL30UaKvovuvqSNvI+ZZCasO960yHJv3ZodYEjM
	koCiiiO9W/LOlC2QB2zVvPOF6gy3s49XVaXMM3YGTtFOOCQ3rQRTIiXoiFRCcRs=
X-Google-Smtp-Source: AGHT+IEuX+LAvgGR0dujrY6Se1xlvX+40UrwavICTj8b1/cNQL1xPoiOn1bdI5jJdrL4sEXbMeapyQ==
X-Received: by 2002:a05:6512:11cf:b0:512:f389:d6e0 with SMTP id h15-20020a05651211cf00b00512f389d6e0mr2702097lfr.4.1709028763072;
        Tue, 27 Feb 2024 02:12:43 -0800 (PST)
Received: from [172.30.204.241] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x18-20020ac24892000000b005128d0e2a07sm1136919lfc.308.2024.02.27.02.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:12:42 -0800 (PST)
Message-ID: <f5b373cf-79fb-4d62-9d3f-9a9ffbfb5d8a@linaro.org>
Date: Tue, 27 Feb 2024 11:12:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] A702 support
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
 <20240227101055.GA13753@willie-the-truck>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240227101055.GA13753@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 11:10, Will Deacon wrote:
> On Fri, Feb 23, 2024 at 10:21:36PM +0100, Konrad Dybcio wrote:
>> Bit of a megaseries, bunched together for your testing convenience..
>> Needs mesa!27665 [1] on the userland part, kmscube happily spins.
>>
>> I'm feeling quite lukewarm about the memory barriers in patch 3..
>>
>> Patch 1 for Will/smmu, 5-6 for drm/msm, rest for qcom
> 
> I'm guessing you don't really expect me to take the clock bindings?!

Sorry, I didn't remove this hunk from v1 (where it was smmu changes
that you already took)!

Konrad

