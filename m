Return-Path: <linux-kernel+bounces-146928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468908A6D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07681F2212C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355112D773;
	Tue, 16 Apr 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nM/FuKIa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18212D771
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275770; cv=none; b=Z7am/niymTg5zo4vdaE1JDKM9zg3xkVlN1cou9yZ2EeV4mf/jeDa8ixfFeKhNfTN9V0AZtYN0dbj7U8SC17W9mQaBusANRjVvZgI8YoOI6W45IXMG0skWDox5Hr6Jb4fsJrozw0HfZn8MF685ZItaot9Ih6LUnRhc3P07q2QRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275770; c=relaxed/simple;
	bh=+4LDQwbWUnQ/u6d9IMbWLH0F0s+2LEHatpx9y5lrd3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i42R4CSWpQRw5cCiyKat+mFuC1MnXLU6VgL0XASne6lpcCg9zuMGUU4852Y0NVweP/EVMjTQAGmtNzIPFNNYR86CihrtOGUX0qG23y1VB38UykNWlK1iFMU+PqpS+YnEy8xYpXdIOoh6x5gqSwXoRN3N2a764PvHh19onlgMPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nM/FuKIa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2da01cb187cso79414791fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713275767; x=1713880567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=go38N7jjGrvQlCPvOb3B+Q4rvfjpWKNjxgnorhqbV90=;
        b=nM/FuKIaKl0MzV1QXGmTrr6iok/ydYgEGSg4rVbXO0JKpIcDmOBHVsrsxkk3FoKOyR
         6wMFyAVjblqmh/sZxq0Q3F6MzJM3lYDFIuzpG+cZiWI+bj2iEGB35urzrK7+GJQT2p4L
         a87MZK7sn4WyMtd8cXyp8K1cPqzI2MEkXE+WXu/6G2L/ZcfaH3qZcuiT7+AjjoYHyKI7
         To4oXjBO7s4bmEbeQVFxxoUdDav0LaSYcsb4zUtlkKtpQohHTMgE7oNvCZwawr3mSk7y
         15yrewbkcXB1yHjiy9VhdL9NMYzG/kf/eyDVYNx7S1CQ8Lvk8bWzK4paF4AQBc8Id7vN
         tW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713275767; x=1713880567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=go38N7jjGrvQlCPvOb3B+Q4rvfjpWKNjxgnorhqbV90=;
        b=vSrziV8ziPbkFKVc9hBeW2cGHrGr/RUK3Ew6XGChFNIq4o4oUXWyos2/gW7i0LBHlm
         +3L7ZHNWh+AoM2Hu7LPPix9jYr+EMXQHCdQgm3QH25OasE7qiRccLzSmCzCmRO+0yQnk
         Iv94eh8AvhL4ivn0sBLJRzfH/YUHjVygI3UOW6ZzeAa3MwZthNOhS2tL9mdErMli5Axz
         SEerxuMiAjwIyEcTpqcceV9iUKQY2F9ewKoMiBugyM5iQqbJCI+J3vqqPKUtp1ziI/2Y
         ZKr7/Q7puzVf4za4HC0k/nh20uV/Hg3axKops175rr8w+CszK5uNIImipDjvpez2KpR4
         jl7w==
X-Forwarded-Encrypted: i=1; AJvYcCUx26d01MQuMKxdzfzVBT9daSjxszklC/toSg2q8u32/qYiLAH7ezHgfE8v2T42hYnXy0zAJmxjK9Z0KmfWzvJaXmE6kBW4/urCAoAT
X-Gm-Message-State: AOJu0YwYcTvQPzOZjF4KxId3LyumXx/yY74ZYyG4TFZU0hF3l4lpthD6
	//z/eYK04p+VsrHpUbKw5idzGSP1rja5MJz8rz3kXsV2Xkxol5+Zf5FKOkcgMEs=
X-Google-Smtp-Source: AGHT+IGBoOH/dF2Qf/A4OxGdVP2d0F0wbeBPrw2HCrMwWOY4foTr5XgGAAw952VOVUq95qHni+KiDg==
X-Received: by 2002:a2e:3307:0:b0:2d8:5a4b:17b1 with SMTP id d7-20020a2e3307000000b002d85a4b17b1mr9907557ljc.15.1713275766843;
        Tue, 16 Apr 2024 06:56:06 -0700 (PDT)
Received: from [172.30.205.49] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e9c4c000000b002d9fb88a7cfsm1282899ljj.102.2024.04.16.06.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 06:56:06 -0700 (PDT)
Message-ID: <3c2355de-e79f-4c95-96d9-d835cd91394a@linaro.org>
Date: Tue, 16 Apr 2024 15:56:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
To: quic_fenglinw@quicinc.com, kernel@quicinc.com,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
 <20240416-pm8xxx-vibrator-new-design-v11-1-7b1c951e1515@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240416-pm8xxx-vibrator-new-design-v11-1-7b1c951e1515@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/24 04:44, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Currently, vibrator control register addresses are hard coded,
> including the base address and offsets, it's not flexible to
> support new SPMI vibrator module which is usually included in
> different PMICs with different base address. Refactor it by using
> the base address defined in devicetree.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

