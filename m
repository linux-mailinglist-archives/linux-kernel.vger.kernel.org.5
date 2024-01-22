Return-Path: <linux-kernel+bounces-32775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B0835FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7730FB21486
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449B13A27B;
	Mon, 22 Jan 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2Ddwpgk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0B3A1D5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920276; cv=none; b=tM4agU+cB1t3+wl/YS5B/FdnTvrvnFW9RjowZBD2kybZxPZl4w5UwMt9uKax+rrDS+cc8pxLzSMgj4TlEoiKumJWb4H+hRO51yftTUfyOP+LpyZFhKpOizugzO/Z4h57mLHtZHSub6dZXIj2u8jqFRfrALTbGUn02sfR6iJeiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920276; c=relaxed/simple;
	bh=Q5IhBYcwPvBhNH3wzEDza+AtOhG3qLK6wZ3eA1Q+J0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYu25lZG8v7uh2vUgFi8BvwLV+f6eqpBaEY0R0hdJlmhITuXSNeGPNw86//3u5L5r4Axa2rpsmwMLPnAqePR+q7rHEIjFYe7JaEnF6Yd/jr3tJzqzwLnwX+qUrjnNaPUlxZDwkl1eRQUoZbtlzrXAlzyN3+6BSRhTHO2Cgh/NpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r2Ddwpgk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so38507975e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705920273; x=1706525073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nuar+kAkkGz47qh6RYxwSNi1tRVlEN4ihxC/V1hL4ts=;
        b=r2DdwpgktGpOWrn481jG+/zK4vw8xZ8CFcLqz/E3fp+fQ+bCKeWNkuZJGE/bixmalu
         TWK19wR1LT0S1zXsAXjnpjwbYgDh0nkdzWe8dYLvMPIGoJ8iMF4y6zyMR7X6QgMtbNWO
         FWHjxWKi3db6ZRRBh6NP33QvYolT7mJ9viYMrtlERt4FOMezNacVtKL4xVnzh1om00Ri
         HfePh2kf+LBHq4WLarr+3Re0xeFA5DKURPeCp+zahsPLX4zi7/h9q3o12jkbd7iFzNX2
         vLgTXGg7+VGza3hwd7bD9yyBODj+dLnPi6yl996WAydbKb3uKE0Ye/vakkL4lYBMrxC4
         DIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920273; x=1706525073;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nuar+kAkkGz47qh6RYxwSNi1tRVlEN4ihxC/V1hL4ts=;
        b=ly+eNYErE+MlMixmVq/6OLpd972VrjoQ36zvXoInj/0kc23ghJIiG8o4GTB7iPoUNJ
         pRA1jgKcNaxSjXpgLATxxtU3PUMgwSbQ+tdGswDL67zQkL8Reb5/blf7w1NZqPkd3nq2
         7sol625CuCrN1QhLyR2FdZtpIFhjstwNXJQIlIzrOgjVVAQN9Hkl/0JtVLJOVCee9yz0
         PWRxQGwHa2fLwt5Y0zGB3JFSlj7XOiFkEb+FgCmcyTRf2Iww7qejydumnJmPRvB2Idwk
         /MUQHLDIKZhNzxwiEOLlP1IVBjjb1ktZXUEWQPOqd0WfDekCNlgAgprAVcAWz+z0e6tN
         Txiw==
X-Gm-Message-State: AOJu0YxrIcNNw9/b2GYl+Aiq45kkeBhx/iMC6RCukPV/uMZJeGfaGX3p
	E7y56HKUlx9CKpJdJvybYOrcmc+RkmXL1dg+1bc8R5/xFHEz+Wwr/yJV47e0DVc=
X-Google-Smtp-Source: AGHT+IEoMM5Ktzeju5vnLOedttGHTyUOKSHdeFm390nnjOvc8Iy4TZZi3+ql+iXa08jO7ZTNiVsJnQ==
X-Received: by 2002:a05:600c:298:b0:40e:7b48:a38d with SMTP id 24-20020a05600c029800b0040e7b48a38dmr2411352wmk.139.1705920273157;
        Mon, 22 Jan 2024 02:44:33 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id lz3-20020a170906fb0300b00a26a061eef8sm13254236ejb.69.2024.01.22.02.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:44:32 -0800 (PST)
Message-ID: <2b43e7f9-9394-4ed2-b6d7-46fdc1e515c5@linaro.org>
Date: Mon, 22 Jan 2024 11:44:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: qcom: aoss: Add debugfs interface for sending
 messages
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Stephen Hemminger <stephen@networkplumber.org>
References: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.01.2024 03:31, Bjorn Andersson wrote:
> In addition to the normal runtime commands, the Always On Processor
> (AOP) provides a number of debug commands which can be used during
> system debugging for things such as preventing power collapse or placing
> floor votes for certain resources. Some of these are documented in the
> Robotics RB5 "Debug AOP ADB" linked below.
> 
> Provide a debugfs interface for the developer/tester to send some of
> these commands to the AOP, which allow the user to override the DDR
> frequency, preventing power collapse of cx and ddr, and prevent AOSS
> from going to sleep.
> 
> Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

[...]

>  
> +struct qmp_debugfs_entry {
> +	const char *name;
> +	const char *fmt;
> +	bool is_bool;

This can also be const

> +	const char *true_val;
> +	const char *false_val;

All of these strings can be const ptrs to const data

Konrad

