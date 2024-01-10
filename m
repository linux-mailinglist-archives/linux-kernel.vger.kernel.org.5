Return-Path: <linux-kernel+bounces-22543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7C829F69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FCE1C22413
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3B4D103;
	Wed, 10 Jan 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqkkL4Rc"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DC38D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so51150431fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704908444; x=1705513244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hh6Goy7NRtSRzQyxaJrI0RtgCTicSCtruZk0IoQJBRY=;
        b=nqkkL4RcRCH5ufNXbHWGnxSoi46EXvz3Jq65MvlJ1rvX3fliG5y/SWj7ez4mPYLGfH
         DDzG8KohbBUkqdX2KH+KSVYUSWV8rPUbS6gISFAuul7d7fuzHWiQUwkMSJ/OrUUCJVc2
         yivCWneWJQM1jWYM+34g+ijczbZcn9u8S5mXShHS6pmuaVqXB3xFyWU/Lmva11LuhIn5
         Q8c2jbT60eSc31nQa1pwqzgERbFr7e+Q8MN35+3iL5jBdKmVln5dNuSQE35KXRN/u7p9
         u8Yfzr4moganbFSKFIIGwHzpJkzdzeNnoVGjL+1Pk4aLT2oLGpqKkS8E2aDsEN4sctzL
         V+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704908444; x=1705513244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh6Goy7NRtSRzQyxaJrI0RtgCTicSCtruZk0IoQJBRY=;
        b=cwNC4fvBZ1gnQHyfy/4z3bcq2cm+pVQzdJFSDn8AaexksQh/1KvnRHEMYzalJfxCxO
         oPu9S12qQxKXPNatLa0b6nEffpqY89Zb8ki5PqcjFMZkunQq6PHX6DSbK5gU01gM5VRk
         8cN5JvW3DbCdTqVPAtbe7HFinBpsSb3J//IYB2RcP+ZlW8ngsTLi0GHcCFxF3tCpuqK0
         L06jkauBCPT5e42gsea+ewfZR9RKalMtY0peJTwNmqGGaJHIzxvIgTRx6vsxT8UOhUSv
         /0EvK/Tc2YnUNU2l5/ii6V72YqpSO1SBHzscw4rxcU44VJaseW+W+z0Mq3qOsO2BUhQn
         IbXQ==
X-Gm-Message-State: AOJu0Yw7yjJ5LSoBqoHg519lzbqaNgfOilMEzYc+MrcBxxKaDrusLMQP
	2VIbylZ9nk2+SThf245Ssr5eQmzlrFATwQ==
X-Google-Smtp-Source: AGHT+IEYAF/qKxWaXqzKRy2E22Nw/2yDlQi3jF92SjU+pffbCOmE6KDgmi6npRBp4cYRZGyr+gEJkQ==
X-Received: by 2002:a05:6512:124b:b0:50e:7410:d5b0 with SMTP id fb11-20020a056512124b00b0050e7410d5b0mr731181lfb.28.1704908444428;
        Wed, 10 Jan 2024 09:40:44 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a27-20020a195f5b000000b0050e8cd014d7sm741726lfj.16.2024.01.10.09.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:40:44 -0800 (PST)
Message-ID: <dd06a04a-ba02-40a8-b5f5-0457085c202b@linaro.org>
Date: Wed, 10 Jan 2024 18:40:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm7225-fairphone-fp4: Switch firmware
 ext to .mbn
To: Luca Weiss <luca.weiss@fairphone.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240110-fp4-mbn-v1-1-45e7e33b1834@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240110-fp4-mbn-v1-1-45e7e33b1834@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/24 16:21, Luca Weiss wrote:
> Specify the file name for the squashed/non-split firmware with the .mbn
> extension instead of the split .mdt. The kernel can load both but the
> squashed version is preferred in dts nowadays.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

