Return-Path: <linux-kernel+bounces-139153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA8589FF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C5A1C233A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608D1802A9;
	Wed, 10 Apr 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4CaqjC9"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EB16E865
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771618; cv=none; b=W8tNmJFQGZ3e3yfC4H7WbWxZHpSWeMmYeAvuN5mVE/RlWj5rl2fGKt80Ywj97EBhLW4whFUyi8i6uVD0htMDfBwEOOtKk7BXCcdDd+BxNq2loN/cakOUTb12FER9vt7+W7YJIOYGiI7bW88XySEgSw66o+xWBIqLzYJ0GWrOlcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771618; c=relaxed/simple;
	bh=D01O/kMLghZ4WNib3yt4DXPdssYvarXhrfDJMcCCeVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bznhaJkSD136QTkK1AUEMMP/2T3Y/AoelcPV1XUWgs+YSGy+cdFSVPA5VY8loZT63km86T1XIg8K35KK/u8mFGbGyKf8W4Qt/mGOYsznmyrLbdR3DOcxF3Ax+wNPyf0LJWhQObzEk71zM877OPbbyFs82RDf02YUIcHs+UHPh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b4CaqjC9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d886dd4f18so43731741fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712771614; x=1713376414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z112wHoDgZuxdMnK1c4wNW2q7ZQeAJ7TUS4neCdVGbE=;
        b=b4CaqjC9vXcy0+U9WwVzkxaPjYIeiM8lf4SQTumsVQpOH0S+TcAHCfbF0c3ORmzHB+
         N7kF6RbAKJX9mRhPIiwZvzyLorTHbkGKHk8pAFvaXKubC0fznqKIYzeaiBKyxPEqQRHt
         hZy7AMfUqpkwB5MqfdiQz2d4BzSjOfnjzqQLpJKjsU35wUWtq3LjnVDWkr55P4b3TJ6v
         eO8Q00uXrKWRnYMxJnNe5Tg7R0LTh2fXfkI4/uj4UmggUGG/E5qml2Hp8C5CPKKjYigP
         8wbR7++/CSPJCbjAVEoAeDLteun3pU0jLpW1VxfPkPp9VGPTFPDCOMAxtYnRZI7DsvZ9
         b7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771614; x=1713376414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z112wHoDgZuxdMnK1c4wNW2q7ZQeAJ7TUS4neCdVGbE=;
        b=tte22i478BmLYgUe2KHcz+pMN6EnYNwKhtuQZzyegfjpfoi+JvuqPwRJvveMmwoVXM
         5TSJxDMF6nHgKvwBnG+lrIxr2bd3KLYjdT01GjKojbmUfZLe+vHnyPc/jC+lHAbyzvZs
         Y2AmnHkcAAhsMaqNm7iR5Pwb9NZWGz/yLWQeZAvqiNiQTlr2zYymxaRX+IBBVdRjIiC9
         9k0vpJPSF20RaBa4lgFLDlybSrZxlQq2z4AqFvjpgYCxFwgRL4zLGA8dgLxepVUttOzS
         oV5icUsJK2aFQuLkNPzsjTDO+u8FDyshVNIHeyGoFvFzBnKOGMGUSLN4VqvFey0FD+lF
         9pwA==
X-Forwarded-Encrypted: i=1; AJvYcCWaeg/bTDKSh8REhjMz5QEE+yoUCK//fpGAEvLhS88t0Cyp29Dt/S8ZW/1b/LCD+R5hOhpK45lrHL6HIJSWVShRWUoQaPM5LMBIPLuU
X-Gm-Message-State: AOJu0YyHOkMwXfDF/5GCAMEXA92/AMFw9cecAYYS13S6Fw/38bEIQAFW
	qi6/9WsrHO8XmzWqEN7mGhsFEfRjIR2yUkmD56m+QIxq7+Awyx5Op6g0Gr5fyjg=
X-Google-Smtp-Source: AGHT+IFIReJaGr66yPHOIX7Zt3g4iDTOzZ9VE/6SbTe0ViyToWAWIbtaAo3ZsNCvLGo+1ZsQL9q5Fw==
X-Received: by 2002:a2e:9317:0:b0:2d6:d536:41ca with SMTP id e23-20020a2e9317000000b002d6d53641camr2473831ljh.4.1712771614307;
        Wed, 10 Apr 2024 10:53:34 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id l20-20020a2e99d4000000b002d69b9a6513sm1864693ljj.48.2024.04.10.10.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:53:34 -0700 (PDT)
Message-ID: <22f5eb76-8f81-46ea-b0a7-5f1d231e7833@linaro.org>
Date: Wed, 10 Apr 2024 19:53:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410164045.233198-1-krzk@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410164045.233198-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 18:40, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

These were omitted intentionally, as these are both debug drivers.

Perhaps we could mkdir drivers/soc/qcom/debug to make this clearer

Konrad

