Return-Path: <linux-kernel+bounces-154174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C425E8AD8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94711C20F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A991BF6FE;
	Mon, 22 Apr 2024 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMaRmnZX"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2951BF6FA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826853; cv=none; b=PaqotqmDdvg+PWZ7tm4SoHG1ALZ1kdn0vSCU0WVlneb6oq+v9kw/qac4G/m6ADS2sAhokqKKspJlrKcuX5effh1ZllZiWblWj2EcUA71kgNkz1VGJHCMN9AEN/jLQ2o58NIcZ5tYeQ4xUS97A5NasCqSmnCnpX2E43+PjD0r1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826853; c=relaxed/simple;
	bh=/jci29mGzzIavqEL2qT00cRZYvwPd29ad4CaRDp8/n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gliTJMXRpXeXEtXo9UdAt8M3cyYUfvOWW7OGpEBHYDwTNE839UHIx67f9sU8A2eYMabRMIXUoeaxLhF0t0DhrVIcg5BuyI14UakuyDtCMHvq9jPvIWey1vENAALYTDstBoqAxhEzKRfHV3aJWw6oZyeeCrptJHivwxS8hu3/YiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMaRmnZX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so4811885e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713826850; x=1714431650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kk8RZ3kIPMume4l3zZttutOgAKIxylCidZY2eGmr83I=;
        b=QMaRmnZXt3PXtMtQbha0JxDPw5DCEdF7dazfdKvpRdh/098lw1OODIEPMIBqBkJgKI
         ViV6dNEPJ8i43Y8WXXhDGJN3yjMbdyljRD1HKpjmr/v/DS7cPL8pyTTYeDTonLN3dq2J
         iC0tmz8HApS4FJpvniTgH9UcfJ14wUc/9lnNRU4twe05eZeZdJEMCknmzmlTQzFiv1s2
         T5JNkR3SfZWjCM5QHA3Ndk9XOJGETWxDbFfN3rstOViq8Akbjr1o8khQyQyGHZtcYQEF
         ahNBoQ4eheCQt4qvTzkXov1vTil/ka0dDGquS09oOTzrdWcq4HNcrIEcmjEs5crjkNrU
         VzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826850; x=1714431650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk8RZ3kIPMume4l3zZttutOgAKIxylCidZY2eGmr83I=;
        b=jQE0Tfb0YUzNbCiv6pj6AU/Ggu8phAPF/z5fftvB6TvDyluDLx6CJ+G5nISStdgh1O
         mEQiux/kiVwM0kAGujw1vFdDC6bhEW1ahjXYiWMwUaeGdJcz2WUkjE1DVs1tKkrzgOas
         FQjKj9AULXa4DO/SIPsFJoT578pCF9hTDgcDdAPUgSELbKK8TQmt+h1MLboebncPQFs0
         yr/A9hbh8CI1MWv1hqFZ0CMkxPS3aoECVSxHeTaDUklS47z9UMAYaG5wiVvkTrAUxvaG
         HkoHCUxrFPqJwr1x6ieqv+C2sezlqdu7UhAqMDMo7gCrvur7V91/TO3mcDy0m6ybqdZW
         Z6zw==
X-Forwarded-Encrypted: i=1; AJvYcCUX2lnXnTcoW/i4/sl4ORCIR6ngi/1o0a9gn8GqY+TFo1USOIgcUiHWylAfpKRleaBHABz4USMa9jxPk/dNUD/OqVf74k31TxJi0sra
X-Gm-Message-State: AOJu0Yzshbyvw3IlUJhv4FmiRO2zdlQQbJDtq/IZXZq7SVxtrTShLIpG
	9+dIpsnG5ezB110MI5wbBWvD2PmVuAVl+wVMVKcI+bJpATpwFYU+dxqt3xiDjgI=
X-Google-Smtp-Source: AGHT+IEQ2a2C6x5MBOQkua4NvRFyZgVGrHQKhZtpBWTuE/jycfIwqTASlvwYmTONiFAlMbc33a9Fsw==
X-Received: by 2002:a05:6512:e83:b0:51b:64c3:8cfa with SMTP id bi3-20020a0565120e8300b0051b64c38cfamr2469243lfb.13.1713826849758;
        Mon, 22 Apr 2024 16:00:49 -0700 (PDT)
Received: from [172.30.204.103] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w11-20020a05651234cb00b00518c057e78csm1830167lfr.159.2024.04.22.16.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:00:49 -0700 (PDT)
Message-ID: <da8fc783-6b2b-495d-ab15-be297b0fa435@linaro.org>
Date: Tue, 23 Apr 2024 01:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/6] interconnect: icc-clk: Allow user to specify
 master/slave ids
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240418092305.2337429-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/24 11:23, Varadarajan Narayanan wrote:
> Presently, icc-clk driver autogenerates the master and slave ids.
> However, devices with multiple nodes on the interconnect could
> have other constraints and may not match with the auto generated
> node ids. Hence, allow the driver to provide the preferred master
> and slave ids.
> 
> Also, update clk-cbf-8996 accordingly.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v9: squash cbf-msm8996 change into this
> v8: Per review feedback, set master/slave ids explicitly. Dont autogenerate
>      https://lore.kernel.org/linux-arm-msm/f1b0d280-6986-4055-a611-2caceb15867d@linaro.org/
> ---
>   drivers/clk/qcom/clk-cbf-8996.c  | 7 ++++++-
>   drivers/interconnect/icc-clk.c   | 6 +++---
>   include/linux/interconnect-clk.h | 2 ++

How is this going to be merged? :/

icc-next? clk-next?

Konrad

