Return-Path: <linux-kernel+bounces-139151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082B89FF28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A62B253FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657EF17F387;
	Wed, 10 Apr 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NChVpYqB"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087515B0E4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771567; cv=none; b=k27or5ryuOoPasLyZx8XLq7FNtFp4wiFvyVBnFcNWuRlSkx2w1fUIFuYWTGerzFb/Tu7PZSOcIl3sA6jud0DFF4T8L5uX/oLbxNpP0kSUp60FqhZd2fi5F3o/9kOg3zIRxyVDKr9+sURAbhte7NNr8KoKEsE88y7rnZuBbUUep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771567; c=relaxed/simple;
	bh=767o7xvkZkE5AQMsnF/zYn8G1hq61jQzSHPrrqakIms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tBBu9qWLCw5FTM8yrq2r66jv9W2OjZbxP8MvP9UlgfDE5S8YvxAN79/JMNhB1enekWSFpRohaK8w+l4+hyjqW0yJXjpo5Rrg35deetXETWqohklKOtjj/izDs5EpvBhd/s/7ox+SFTDr40I4SmTgqLTAl96qvWxBzDccDdRKzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NChVpYqB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so83736161fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712771564; x=1713376364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOVHA2xlzK7je7ttjy1nhrPlXlPuAp2xezIP2Gu8nIM=;
        b=NChVpYqBHbSAiaCkhnBtbML0SQ3clrOE0QexSV+3o7bhupaWXmVtZcmUxuQuI2ibsV
         jWlcCOpQGZb5xBOuTu/4dwjReDfdML1jxYoY+sP0X1OtLiNetersEMznvDTubuyzFU3M
         zHA4An29eKS46OJdg4uV0bX/1Cub5ghDNTJMHBUd4ewA8+RNl9QyYnI7FjxyVZuciyGX
         B2tKKOeeNbXVPzgsp5yuJBMpDipGZ7C5IMMC3E3Nq9D3B6ndz9PoWM89Q3jCWbfkokqB
         wjGuTpmdIQGk06bWSRNeIWjgWSblJzCy9U4sFmBFH6RatuBqYrUELC7F7UBlU0HokwTt
         YDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771564; x=1713376364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOVHA2xlzK7je7ttjy1nhrPlXlPuAp2xezIP2Gu8nIM=;
        b=aA7ygtSNZykzrnh0O8LyaznehWewJfua3yqBUHXBc6fvwmSeRqsl1EL0pa4c45hWBg
         t8nOB2Gl5fwzzYrIq9KGlLoblGiCHKOkGjx3dQAZJx5E2H/hKGpXygzi/ntsdq0ZNn+8
         4nJ092m5jEi9+QGLA5yfGXkcQB+MQRkbYRKycUUxAk5EdWbPYTTB7fiF8/3ukNPbptV9
         EpzzDahDA5awGPMVY5PhurvK+IXOesUFjJCrse6s0zWtTkifXSeDrmDNfZHTAl9txfPQ
         Q8Dyb1r+QwteFFzAvWJMRiGrTScZY7zwAsiWDMY3tOleRoqu5Gsl0gBi/sJ0MQ63um+c
         jkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7PqpxTwmFbzwVisJJW0p86QJHMCh1tJfJ1t+xkYfogd3dH7YaKWybXLiCCtJqxyYe+XDDeFRU3wnLQZavwBXWK1FaOQsxhyQ3NTME
X-Gm-Message-State: AOJu0Yz21ksZz7vviXT1ACphr6t/9pIgqsXxv0vB2KkZw0MKJWHADGVw
	NL8kAlQPqcJd2dEV+bXYGtq9avWgaFT3RG+KDFGy9fGOWGYnd19YVy/rJa4hmKg=
X-Google-Smtp-Source: AGHT+IEOlj4YMG9ismhRXJyrEXTIOfXs991+9TpCiZiqMR8fC8jAZzGSCXGqag0xPmiMZ4gXU+5/0g==
X-Received: by 2002:a2e:300b:0:b0:2d8:71a3:aafd with SMTP id w11-20020a2e300b000000b002d871a3aafdmr2448469ljw.27.1712771563497;
        Wed, 10 Apr 2024 10:52:43 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c20-20020a2e6814000000b002d82f0f14c3sm1844665lja.130.2024.04.10.10.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:52:43 -0700 (PDT)
Message-ID: <148157a4-7f78-4d03-8a12-44658ca6ab51@linaro.org>
Date: Wed, 10 Apr 2024 19:52:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpmsg: qcom_glink_ssr: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410164058.233280-1-krzk@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410164058.233280-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 18:40, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

