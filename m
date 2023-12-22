Return-Path: <linux-kernel+bounces-9740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E10081CA82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC921C21562
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE15199A1;
	Fri, 22 Dec 2023 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyZkjfOt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DBD18C20
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so10711305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703250527; x=1703855327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvw6tTnY8BhMF5IOV3JmRTPTPlqTLaF6hJkfSsjnKRM=;
        b=EyZkjfOtpIp53rr+ephw5qMvQOcpyeei62Zr4QEoLhH39W/DTzF4b8rTrzJAzWSaFO
         iNVCaJApARhkg+uFozzEdfH5A4akXGC8mBlvDeFLynvuucvUdpoBIKiqhr4XJiZlkPXr
         hDkE4DhJJNhEAPVT8U+19eX38oup2pmIB+iEnu1HD8XcL/WBeEga8mo/TBAYN+p6lt1L
         wWAKUONoPwPu+6cfrbEl5E+rGBKLvod4wsFpWb3s8NRdomcu1Of2lRrhiuh8FOCZlLQQ
         wSuKV5xrJ0N2mNgOQ9IUObd4uoz/cAaglXrdqjIjtgzjeQ932JCRxanOvJGoXF30yeRG
         Ya1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703250527; x=1703855327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvw6tTnY8BhMF5IOV3JmRTPTPlqTLaF6hJkfSsjnKRM=;
        b=Q3yEWUYMdJHhYK249aj/c530ZA0eiGh2YQnmswaonfjH8NSGpNmSQ2fgywOSlm7dfd
         HoQbPF2Oo9n9wqxQ/wRZMRUId81utondM8z2Uybw861zA8xdHNt8tx+PO0mE2Fn1GQbO
         HEcSaUPS4xsgQuovFc+zMpuGruoyaj1J6+2yGca/tZGNXqgHvL3zPcS1I1d9oNn5eekJ
         rGqLwtaoYebv5fLaNspH3gWX1JGgAETgVBOECKygOFdHiN5It0ceaQmL7rqpBxLkkxmD
         EoKoZ6pF3t03vFMDwLcAij/cM3cVT/5WdOoxCGTRINqiOhJNk0zQHbrqGTC4zhpUtbVV
         3b3g==
X-Gm-Message-State: AOJu0YwP7zJ9+IOAD2pNg+frj34IML50htuHdVGLcJ7hshvR+qVOAdmR
	fC7W3/asgW1a7vDD1Bnn8wL1QEFoQLKy2w==
X-Google-Smtp-Source: AGHT+IEtGUJ5s+Rjh44OTBSnJUh5SIZt9blfpsqR72lDhlBFtL8plaCCgc/sEjQRyjVlwp5BcRB0gA==
X-Received: by 2002:a05:600c:a44:b0:40d:2dd9:dac5 with SMTP id c4-20020a05600c0a4400b0040d2dd9dac5mr699601wmq.97.1703250526958;
        Fri, 22 Dec 2023 05:08:46 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b0040d3b0780d5sm7085780wms.30.2023.12.22.05.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 05:08:46 -0800 (PST)
Message-ID: <61998a14-2f9a-4b37-a6d0-77451332ae6f@linaro.org>
Date: Fri, 22 Dec 2023 13:08:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SC8280XP camera clock
 controller
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20231221-enable-sc8280xp-camcc-v1-1-2249581dd538@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231221-enable-sc8280xp-camcc-v1-1-2249581dd538@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/12/2023 04:47, Bjorn Andersson wrote:
> With the camera clock controller added to the DeviceTree of SC8280XP the
> interconnect providers no longer reaches sync_state, resulting in a
> noticeable reduction in battery life.
> 
> Enable the camera clock controller (as a module) to avoid this, and
> hopefully soon provide some level of camera support.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ef1061089548..e5ce6d08006e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1256,6 +1256,7 @@ CONFIG_QCM_GCC_2290=y
>   CONFIG_QCM_DISPCC_2290=m
>   CONFIG_QCS_GCC_404=y
>   CONFIG_SA_GCC_8775P=y
> +CONFIG_SC_CAMCC_8280XP=m
>   CONFIG_SC_DISPCC_8280XP=m
>   CONFIG_SA_GPUCC_8775P=m
>   CONFIG_SC_GCC_7180=y
> 
> ---
> base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
> change-id: 20231221-enable-sc8280xp-camcc-969b2cf2e4d7
> 
> Best regards,

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

