Return-Path: <linux-kernel+bounces-1854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273C18154D6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0EC1C2324F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303B632;
	Sat, 16 Dec 2023 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf01fqHk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AC7E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1f8510883aso159306366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702685154; x=1703289954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+0qgXsOSRF6os3K6heh1DXYQRVdzBBp0d5i/r/g/Oo=;
        b=Bf01fqHkroBsxugOXZFf5bdTzP/gK5heM5b1HcW4oMahtQQqpsRTZIUKuQDBb9Z6ap
         KT3rKdFoBGAiqC6lO21as2UBOaMiUP++gsDmD3dxOZ90iDxA16/N2kcfXwMUlucllRRP
         fm67/9ABN2ih8QbV+m8QcTJ3t8HXmngsPI/799dkkx79L+3Ug2MTmeZs3yQcJenQHW6H
         dTH/MI9jyc3hfr79+x59niOlEG/ZzcwIbGvpjoc2bhBmJuyssFDoFPB5SdThYZtFCDpN
         W/D8v6M3vdZkA5hodfMnIpsuiVmemNJ5FRbtjMGvz8vzHoyOyaPsWbHiSvYXwUhC8+E6
         RFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685154; x=1703289954;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+0qgXsOSRF6os3K6heh1DXYQRVdzBBp0d5i/r/g/Oo=;
        b=p9gdKOzXJUpJql6jFLFEHAfftQFqLYLeMCEckQ6N97SzLnoVpiHwrE0HWJ0XWkT6UV
         qQQCuyP16PBxDbPsbp/mljKsk0YuL/4iiC+uNBwz9l9Jiwh393vEsbJbZi2eE9n25Fw2
         5rsdiLg/eTDZOwkxRIWaawc9eBu9n5u/vZQ16FIH4tNrxD9QZeMLlWCcEFndhQ7k47UT
         w004znmUbKXD7UsBB72UEBDwzM5+DNix7hIAGoMxakcqwQcd21P1/59FdCyz4Whsj0XX
         80xoJl6WgjvbFg4nmo9Wk3mXUVzSBvW+3NnDt+01/p/feL6zaF1m+fOLKDR40UbboAR/
         GdCg==
X-Gm-Message-State: AOJu0YzIXY6uk7xeFD8jzNIr3BdeGZ1boxzxiZAXiShQrYSML9HfjHg9
	eSD8R4On5tQdN3aNa4rSyyki/Q==
X-Google-Smtp-Source: AGHT+IH5bkWfHMGPYHZf5zO4mhFeJ4xd1iS4+2x2RVFbvlwSrbiineaoLuwyUlHOd0qb74qs/TKKEQ==
X-Received: by 2002:a17:906:287:b0:a1f:9bc9:84e with SMTP id 7-20020a170906028700b00a1f9bc9084emr2855374ejf.187.1702685154583;
        Fri, 15 Dec 2023 16:05:54 -0800 (PST)
Received: from [192.168.199.59] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id tp25-20020a170907c49900b00a1f7c502736sm10026831ejc.164.2023.12.15.16.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 16:05:54 -0800 (PST)
Message-ID: <4472fd8e-73a6-44b6-a1d0-c5ebc55d4211@linaro.org>
Date: Sat, 16 Dec 2023 01:05:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "soc: qcom: stats: Add DDR sleep stats"
Content-Language: en-US
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Doug Anderson <dianders@chromium.org>
References: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.12.2023 13:25, Konrad Dybcio wrote:
> After recent reports ([1], [2]) of older platforms (particularly 8150 and
> 7180) breaking after DDR sleep stats introduction, revert the following:
> 
> Commit 73380e2573c3 ("soc: qcom: stats: fix 64-bit division")
> Commit e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
> 
> The feature itself is rather useful for debugging DRAM power management,
> however it looks like the shared RPMh stats data structures differ on
> previous SoCs.
> 
> Revert its addition for now to un-break booting on these earlier SoCs,
> while I try to come up with a better way to enable it conditionally.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20231209215601.3543895-2-dmitry.baryshkov@linaro.org/
> [2] https://lore.kernel.org/linux-arm-msm/CAD=FV=XX4wLg1NNVL15RK4D4tLvuSzZyUv=k_tS4bSb3=7QJzQ@mail.gmail.com/
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Arnd, since Bjorn seems to be MIA, could you please pick this directly
so that it gets into the next RC? Un-breaking booting on some platforms
would be very welcome :D

Konrad

