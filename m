Return-Path: <linux-kernel+bounces-100498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CF8798A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A41B23D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F017E0FC;
	Tue, 12 Mar 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkaKbl3O"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5D7C08A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259945; cv=none; b=seZ9UoqkamYYou9TwOPOX3f4uEgGZaEtq/eLwUP4OUsRG8fP4eDoFOxtapEJrgF7ZqtF96nhfh+ADORsmVSBzM0TVNeQlraRj5gsHq+iuoBj+g/G4rLKrljWm8RTBhZQFlGUyKtk+FKURryislP68J6P1h9sn/oo2YNMFjmp1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259945; c=relaxed/simple;
	bh=rXaL0LJcdegT3oLCAhYYQ90a8sQqF6H95AJnSTlrKSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPCaFunRrnum9P2EKSMRvqwVQnZ9RuPoXD9GvwII4wapNY/RPC8X/sfCxKG9vbcbo1yHc+ziRvDxtNEhgDsNO0YzkRt9WhNSyHl5lUhqK9ogwnUKchArzmeshHZaAhljVXc400WxHHyOVzO+RVy9VJve/2RW1hPBUMnsK73mXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkaKbl3O; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131bec457eso118484e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710259942; x=1710864742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLG0VkRk9T+MqlwYSwMr85lswH7UeBe9EKEDGZIjNWM=;
        b=VkaKbl3OsvXrFmg4E80Ozyosy3q8c7v0SYE5ZgaVP8kkVtVxnhBaXrSltAxKs7fieN
         4iFYDNM/aKYLsliKygdYE5llmP5alF0YBHRVzAsn5ZbgF8yXkW33szIXxRN9aUt2I85W
         FQty0IIldS6e+jyPuZ60jzeplo6g55x+Du6oD4BLrUSLC9+gha++YwMRPdChAdB88dLd
         tq8F47vH1P+TDYQ7pkVKdLd633GU9BlVjfbuoUfZGpMJlqJFwW36Ty7s/nbqsankpES6
         9XNqGezrepJHGBPwfAhbY1+eks1ZQ8vWvKT9pZUyGDIgENzEQ8p9TXV0Lo6q5edCDu4a
         k51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259942; x=1710864742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLG0VkRk9T+MqlwYSwMr85lswH7UeBe9EKEDGZIjNWM=;
        b=k2xImF527pYQ0ONNseIJs/oEff3PwdTGBNSfM7doCRWjVetnRLNb+5caYD1hlHxnke
         7foKsCCNPjqpyrHU8nHYZvfdqj7vmnvn9KWOv2cyLoN1T/RHl+fn8IZ1F6KrsqzGZddU
         bysK2fNNHW7cBI8ox3PetNkhLIT01kjIbTXS1R7FiKqxaldGy2qv7lHSDQG9j+qqJLex
         j81vf7iVeW8ZO+vQ4bP1OjQVSW1ao5vE0CBaFyppsTVd9TZ2FboeZmqLNj2bQfbCeMKW
         rBGh1wbRYP8sLMX9q7PsRPDpmPPcksfFuPGYmVjbXG3xv4NVhhPbRYIjGICnSG/1aY+r
         bKog==
X-Forwarded-Encrypted: i=1; AJvYcCXcSpJzilgPcUkFs1rKYZgajEuNUoW4oHjD0C1HeOlGxd+Zr14amxS+cVBkkxTSMArNdtceE2YRAfE/VhgW2+poGkuLiZEhcKLBdId/
X-Gm-Message-State: AOJu0YxhNBm6JNB5pkdh7TaUQDUtm1wqp4cdPUMYrfOcPUfV/WBqqjsd
	knsZlteMpNEmq1fiQmT1gbKZJCGSjPFYTM0DdemWhIr0MJBgFY21Lub1SA7mYsI=
X-Google-Smtp-Source: AGHT+IHFOEHl33gs0on8qTVXiyJ+aHRxksDiQ505Q8fof/YGiXciDjx8sbsbVrPzSuDgBdzksPF1+g==
X-Received: by 2002:ac2:4d0f:0:b0:513:488a:95af with SMTP id r15-20020ac24d0f000000b00513488a95afmr1774lfi.15.1710259942295;
        Tue, 12 Mar 2024 09:12:22 -0700 (PDT)
Received: from [87.246.221.205] (netpanel-87-246-221-205.pol.akademiki.lublin.pl. [87.246.221.205])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24945000000b0051321db6a0dsm1634984lfi.139.2024.03.12.09.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:12:21 -0700 (PDT)
Message-ID: <83734790-85c5-446f-b353-f3765cb10d41@linaro.org>
Date: Tue, 12 Mar 2024 17:12:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
Content-Language: en-US
To: Trilok Soni <quic_tsoni@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
 <20240219-topic-rb1_gpu-v2-2-2d3d6a0db040@linaro.org>
 <605d9e50-d61b-b0ce-1664-00554ba70b41@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <605d9e50-d61b-b0ce-1664-00554ba70b41@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 23:48, Trilok Soni wrote:
> On 2/23/2024 1:21 PM, Konrad Dybcio wrote:
>> +	/* Wait 50us for PLL_LOCK_DET bit to go high */
>> +	usleep_range(50, 55);
>> +
>> +	/* Enable PLL output */
>> +	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
>> +}
>> +EXPORT_SYMBOL(clk_huayra_2290_pll_configure);
> 
> Please use EXPORT_SYMBOL_GPL.

Sure, I glanced over this!

I've also noticed that it's a very common oversight.. would you be
interested in extending scripts/checkpatch.pl to suggest the _GPL
variant?

Konrad

