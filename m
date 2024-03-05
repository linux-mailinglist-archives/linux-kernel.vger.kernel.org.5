Return-Path: <linux-kernel+bounces-93002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDC87293B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737FC1F2358C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D912B16B;
	Tue,  5 Mar 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tf2xOb1E"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C61B81D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673419; cv=none; b=QFyrSCFgH3T7KEoR7wIvSchL3auH2NjueqQeperle0CQlM4q8pdzYiW9yiuJ9E9s60QGiaPpww/hpzsMWI/ZO64nZwfqqPT0OwlgPwGM9U+txslAmJWefghfiEyLmTkVTIZ8BR7TmXKY/9URYBRTzGmLr6qDSl/v+/To93R2eD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673419; c=relaxed/simple;
	bh=k3lbq9SSH8UrBjWLea184EF/re2YnLcUGUKOBhCs/kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2TFE5mFnGnmmEBaLkYBHzt0f52cJj38IWvU0W9UNix6W9H5x8QzEjzpIj1JAytOHnniSCZQjGkCcapcxsX/y7y6kCNk7dIUd9DAefktQyFbPpZFP2Q9TvMYHKVbJsVI3VAMcj/7JjOaxmmT5J+dn18F5eYYbfG7p1OnMnsOLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tf2xOb1E; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513298d6859so1418720e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709673415; x=1710278215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVdcNBcoAiJYRV+66geixgS685+t5mEWuPqbixAd63s=;
        b=tf2xOb1EBY+vO9hm8WGSLQMrHT+iHTO2M80nGItdZ6xIcS5pijid4PlhT9FoOBVsnG
         lG1C3avrWGJJnU8WTuWrhas8TRtCUx8WYfTY5/S8I7thHhFDeOLiukHoRh/FFkHfSLU3
         nV7Ik4tkfQoqOZZ/UHyhTbMv5EdJl53zvSHinS6rzRM9FmVVUbb6fljkA3uvBFzW6BRc
         J8X4bB9z2ubZirvkCTwkZi3CK5LqA4AhsMfIMO6Cf8CadoHd37uBJXHARJ1oXC3EhAT8
         5IP7ENZrbMjy76FPRjQeaEe+4J3yx0iae1iMk8U+nQCUnfYc9L5whTwcEZemB23ZLJCs
         +/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673415; x=1710278215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVdcNBcoAiJYRV+66geixgS685+t5mEWuPqbixAd63s=;
        b=q7zRFwtHInppWBOvadAkh1TyLwpD1pqn4AN2b6buSNr6ci+ez7VXPYhU8j6+r6gKuh
         vi2ut6VJKJdDJkX86HYfB5sJm2QOsS+OZ81S/7oa4+LDNgzJIPD/NxzjsPePwgC2DD8g
         QvhqH5Od+kBK7NTObinreYs37udsy+FyeQoo707yzRxO+FFj77P8+ZRZ79q5/RIOHtwj
         uwtuK3GQ4U5I3/duKiNZvoII0VrqgImmsj1BGFzvQ3ukeuohivdo8m6tVQneV8ABaQYY
         9EUrBP3Z/kJ9ytZmigPfko5z4/719YzdWCevfWMaytB5AmCbZ0L/xhrMCVF1qY4eOsQN
         thAA==
X-Forwarded-Encrypted: i=1; AJvYcCUMHhgzpDjMpHAM99292YNf72GNHvYxF4PPJahT1AjX5QtZig0hj7snma13sO8ncXmyev7I55DSRri1rfvdDffHwkWwhg+69yf9j/5j
X-Gm-Message-State: AOJu0YzJXzLxMQ8gQltj5hPw+F0c/vM1pjKEQ67Tlw3C2/2sK7ptqraS
	/PPIdpPIZk/MChAQQEHoHsF6mtiIlDZtwHgGg4+kuQd9yDfJ7PGbmpetf/l7oSM=
X-Google-Smtp-Source: AGHT+IH3Hd0YBY5DKLui7FOvR0mfzUmy4ygWjHSTygOgSbAzcr4xkbf3ukYBlk9XCz0pNxVe8jB4HQ==
X-Received: by 2002:a05:6512:3055:b0:513:2ead:4f86 with SMTP id b21-20020a056512305500b005132ead4f86mr2610715lfb.12.1709673415066;
        Tue, 05 Mar 2024 13:16:55 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i10-20020a198c4a000000b0051330fe710dsm1994042lfj.169.2024.03.05.13.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:16:54 -0800 (PST)
Message-ID: <d784e46d-974d-4bf3-a2d3-491e7ad19701@linaro.org>
Date: Tue, 5 Mar 2024 22:16:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
Content-Language: en-US
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
 quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com
References: <20240304135000.21432-1-quic_vdadhani@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240304135000.21432-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 14:50, Viken Dadhaniya wrote:
> Currently we have auto suspend delay of 1s which is
> very high and it takes long time to driver for runtime
> suspend after use case is done.
> 
> Hence to optimize runtime PM ops, reduce auto suspend
> delay to 100ms.
> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---

What determines 1s to be high and 100ms to be low enough? Could
you share some more reasoning?

>   drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index efeba8275a66..5de45a0e3da5 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -81,7 +81,7 @@
>   #define SLIM_USR_MC_DISCONNECT_PORT	0x2E
>   #define SLIM_USR_MC_REPEAT_CHANGE_VALUE	0x0
>   
> -#define QCOM_SLIM_NGD_AUTOSUSPEND	MSEC_PER_SEC
> +#define QCOM_SLIM_NGD_AUTOSUSPEND	(MSEC_PER_SEC / 10)

This could be a good opportunity to inline this value..

Konrad

