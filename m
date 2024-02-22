Return-Path: <linux-kernel+bounces-76163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA7985F3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE311C2322A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1002BB13;
	Thu, 22 Feb 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nopmczYq"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCB182CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592287; cv=none; b=BM3HOEUnY0lI6Pl26orF8ECcyx0QbqULG4G7SMN9sVDuCLz63CIfEgQE/Tc1qj7pfM8WU9R80pAyVVG3J6TcIeoP4g9IqSgyw8w6VojgwJnxAR733r4gWFXlWjDBMuCDW0jn3TivUmcBIoh2ZVp4gq6OBQ1S4P1f32+Jt7yPnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592287; c=relaxed/simple;
	bh=gml93mw2Qyh049HUHxbRDGJuQ3cOWnxq4uz8Qzoh5Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1eVrYNuWWi44T2BJpmtlFSLHIHhytudk1Iy4UTEG6ZOMF7nK4qs2kMwM45LddsfhyJyxtYUwh+veQqnVCl727mTIdD1iqYH6wmnTsNXwxueW2YDYkQjTfdpUeGLyowyikXKpvhAYptf5OjLIVcwxCa+IA9EzKXF5LEf84mi/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nopmczYq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512ab55fde6so6564237e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708592284; x=1709197084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InnA2fi+9OUiyjfIuMtov0BHHll7ueKTvAkfvELf4u4=;
        b=nopmczYqB8XoMvZfulG+vThYrgWiH0JQRhyOC6JYX2SyhUAdGWvlAi9uNvzWco89jH
         f9Ao1kE1o9ZNyRP8R9TlAcjaEyfhTxKW9+08ubSNeuO/bwjFuXNA1MISRNf1fFPiTsXN
         yRE2stcLDIvKnQs0pDeAm9STkiKQJRPV0d7WhUu7ZFsVLGrHMf88JcM+W2xSvdrfTopF
         KpR2EIncWkilGfoo4uhZ5bUey8/6Xh55Kn+WGJqQlEA0Nh+4+swAvhkQ49kIZrRjdVSG
         DGIlv7uk1dji0IYdd/JGt1a59pKrFOiCLPR5WO0I3QQyGERsf01QASzkqi1nJ1xWZTiF
         pl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592284; x=1709197084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InnA2fi+9OUiyjfIuMtov0BHHll7ueKTvAkfvELf4u4=;
        b=HfXy5+qtef7CxskbPn1guTmThBg+3yo+a+MObbkANd5TaZPTpInEUBQuHSoxVy//ed
         Z4UySEKKgNlYUM38L2ZnXYA/12byVvUShl/OhfRH9n87pviZ7wKJA+ysWF+Ex3ngfB7M
         7bBcN5xqINbB+upNj0hXGV9Ods9COuUURGE9k5aEkSZzJsqCpcWowKm4uRi0otLrEQi0
         BBXtdtMvqlar8CvXbosE/zZj9XkJTDUWTsgdlbohH0S9aS4YJf0O6yfIrfEvmSKdxA4k
         /0z9BA9kgGPXfnm/SQHXq38XnNUneEW4u9lirGsr7H0xUI1Tgwu+JlPGW2h7wUmAO0yh
         FDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA0WM5xmGqhd+PxKIi+R5YzE6imoSFQYe8fCM4V4AdWcbODtDnFiu9eMrS4FEqxZmW4CRqcmuMaGoDVWDeV87X1Jnf7pPGuqk2Z8l+
X-Gm-Message-State: AOJu0YzVRA9SMu0lGR5HT0qJ9yZOAZEI34EyBSPsf/9AYA0PL5v24QzA
	48uRDfldriBcR6UV3g/wo6WMS1tP9VMGloMfFihSmmw7KKke9wRG17IfPEqViZc=
X-Google-Smtp-Source: AGHT+IFYqsqFTXHNGYBEA/VbzHq9YMqt3pAFuZeURFayWiGEc6/8KE7KjhnMY7Lt6sjZKOb0joqMBQ==
X-Received: by 2002:a05:6512:2312:b0:512:cda1:9bab with SMTP id o18-20020a056512231200b00512cda19babmr4000278lfu.13.1708592284042;
        Thu, 22 Feb 2024 00:58:04 -0800 (PST)
Received: from [87.246.222.6] (netpanel-87-246-222-6.pol.akademiki.lublin.pl. [87.246.222.6])
        by smtp.gmail.com with ESMTPSA id b6-20020ac24106000000b0051176ff32c1sm1992022lfi.62.2024.02.22.00.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:58:03 -0800 (PST)
Message-ID: <12af5139-39a1-4b1a-a9d8-ac616f29e961@linaro.org>
Date: Thu, 22 Feb 2024 09:58:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB
 redriver
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-7-dc0964ef7d96@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-7-dc0964ef7d96@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/24 00:19, Bjorn Andersson wrote:
> The RB3gen2 has a USB redriver on APPS_I2C, enable the bus and introduce
> the redriver. The plumbing with other components is kept separate for
> clarity.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Any chance you could add an alias for this I2C bus?

Or all of them, in advance?

Konrad

