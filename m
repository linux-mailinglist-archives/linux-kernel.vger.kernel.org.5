Return-Path: <linux-kernel+bounces-139218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B128A0001
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F561F22244
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421115920B;
	Wed, 10 Apr 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="by4VcRYc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD9175A4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774808; cv=none; b=m4KGah7QxbluZKLs8X5ac9ZQukSdMCDW1m/XymP4wjO92UKQ5wdMH8iaLnVCYY1opThayv5sCH5plEF8VpySMOt47r4GdJ/50CPQ7cnhAIObU1nwnVWtYcfIuBHmOG8164HdIZZGh++xoNUxTn93l0Dw9eTdE6uaoo3Nb8xJ19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774808; c=relaxed/simple;
	bh=yyomj+5gyVAB6ukI767aM4UFJKS30CPHFZBJcWgbwA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nk0AoNtbDplR+qbaoe0KHS3HbowzmHpW1u+s/1O90V7bkz16LgUNbsX2ExJ9jKPB/ZVjGMM6b9Dk/X4eri5hunRFDZ+j7odKR+pNGp79rGji9x1/1eQCtQoJJZq1xKDKbVcB+azmLh8U7qybTpq0Ly6CKn4SeAwVVWajejTqhFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=by4VcRYc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516c403c2e4so137266e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712774803; x=1713379603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbDxWqylVcKb+Nlm2Jh9dcFKq/DXBpmqk7xdN+p8D68=;
        b=by4VcRYceD64aWLLq/kz1zlhz0FTLBzX9xj5kkYkZM+m/cq7HiW62Pq1RuELbzlaAQ
         B/Sol8JGl+3fmSUH0t5XW5rLb4ipJYlU0lZf2kJQ9LUX0b7105Evs3E0/V7wyyRQKJrB
         aKADhqk4ubQ0JajAC9lS/vEIJzDsCkqATevN1fPzbbuAeCWvMby2Ec9HmLNW73KGb2PP
         W0L67pufhE2V3sFJ9P/rXcv1aHZwg7r6XPfEBmW9qDZ+xabHxZWnkz+v/+BWgQl0bvsN
         wpSw+NPKBlPbnxcAAa6Zs3kugoJaEAjzCsaTatfb8vJJM43cVLF66b3Amzo9Y/BwkEA1
         VEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712774803; x=1713379603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbDxWqylVcKb+Nlm2Jh9dcFKq/DXBpmqk7xdN+p8D68=;
        b=RGqaj2+A+d02Q80m9El8dpw35ePBoHbtWAX3EOXQQAkCKnyihVii2xfqTS13Ejz7fW
         xsZS1e3zMnqi3otRJVQkbbM3ILj+77HC98UUZF8TPYU0HKLOU/1F27FINAOqJBXdNQ3d
         U0s7u/38glX43sr9dMRlI5/UxhkGhA4jx9P+CLxgYD+RiULWgwfUOiWYMgDyOMxjwmrt
         rLHaDTCmvBsL6bsa8LN1YlnaNxQ82IpgdhU4G/tU2NvIiZT7Ywm/trnocuNe8oQ2JLya
         A3agSGNdW+/husG76buI6F3YV4DeabgE+S+B5u5oIoNt1xVuxjvY6cVksXDvCxFDmdS/
         PrdA==
X-Forwarded-Encrypted: i=1; AJvYcCUTWJ26y2dGxkBAcFe8wjGw4JuH1UCOJK/AIl4jGfBfP6qOTRppobSeciPVFbkml5QJ3ln8w5SVsqGR91gqqBwlWxRCco5F+fVAMcA2
X-Gm-Message-State: AOJu0Yz4lUC8YpTf8zJTrhFyq7NQ0B0iTLH5/L9jq1HrXA9nedGT54ow
	qG9G1vVcz1rPQwGkrvNplsd1x8CvhNaQgebOCMPiB6XV1Iy7lkeJVCk8EyOaGpQ=
X-Google-Smtp-Source: AGHT+IE4CkAmfxE9uQ52rkXlfmGsE+D/QsAF3GttB2Lu7gBut9KYS4JWZbMjp6GR4ySz7tht/yLckA==
X-Received: by 2002:ac2:4256:0:b0:515:d3e4:4581 with SMTP id m22-20020ac24256000000b00515d3e44581mr133749lfl.30.1712774803201;
        Wed, 10 Apr 2024 11:46:43 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q22-20020a194316000000b00517626d22dcsm334073lfa.29.2024.04.10.11.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:46:42 -0700 (PDT)
Message-ID: <ffe6393d-622a-4b1a-ad02-7a79bf6ee74e@linaro.org>
Date: Wed, 10 Apr 2024 20:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: qcom: dispcc: fix DisplayPort link clocks
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/24 13:47, Dmitry Baryshkov wrote:
> On several Qualcomm platforms DisplayPort link clocks used incorrect
> frequency tables. Drop frequency tables and use clk_byte2_ops instead of
> clk_rcg2_ops.
> 
> Note, this was tested on SM8450 only and then extended to other
> platforms.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

