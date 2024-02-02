Return-Path: <linux-kernel+bounces-49746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F6846EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E792B1F24D89
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC8B13DB81;
	Fri,  2 Feb 2024 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2Vb1Ogy"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6913DB9B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873408; cv=none; b=MDnwEHXuY28Dlqip3dSWAvr380GPkj3i+OCfXTMYyiSqOgCBHvpF6ZrxVUubgwp86gHeM5Ydz3RVj7IeOjt6T0BFSmfEAFqb7+K9X9dofelYLuuRMAShrJg2IYlSJ2JCniSValqWNo+rLstHvwtv8YpkmjkPJLBlkeVkU3B3frc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873408; c=relaxed/simple;
	bh=V0OKoMdvZrV+RBdBue2YTnk4bGLNdmAzUA2aWpHPnIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb+ZoVlJX7nfti8T+6wcRvExKQw9Nh/JYttmJz3+qXysXEhbAVyG3E7JzWQrSn8o94+v9lvR1RwanqL8XEP9dZT8dkQQrfWdrUKhXuECgYtHblG7s+WBLs+r5wjE4AzkCgsBOFz4TmeoKftjCJc2UfnXDKUI8eO5K0E8iT/wE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z2Vb1Ogy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3566c0309fso265560266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706873405; x=1707478205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GiwgOBtuCAx/IZNAogUYBrsI5jiXrwqvdjzRzsKTUV4=;
        b=Z2Vb1OgytDxzSPADfljl+McT+IZR0MDt+L9frfyrF+GL3CpTMvFhXPaBWfrhA6z+FU
         naEgOyHCVEhq0uxBqoOWXKX/1EPuZWyQ7q5NJCcvnz1X3NZOUQ7drNDE8AyenLMddaTC
         +BGR9K9ueNY85SMJNnaibLu9Eb8TnraybEsV6OImbc7/VYLcmDiTkRvhm9Sie20IwFAv
         p2lcPBxwt+dE3qWZhR4F9MzIuq4HyKjQW8VnRYGUI2WghrgNAiWeDHq18U0ElsA2f3xS
         xxSIcrW7BBa0IILu+W3D4zLpcl0SMT5iLgoeyaEv4SzeA4IsEXCv186CUcKziV3l7nCf
         66Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873405; x=1707478205;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiwgOBtuCAx/IZNAogUYBrsI5jiXrwqvdjzRzsKTUV4=;
        b=Gcx8/ckC4429nbkUeDO4mr0WfLx+fUYtPEyO2EM4KtiUE3SwZSweZm+AmnlikYdOdn
         B/B70kYPYOouZ9jjtsL9Ygeodo9GdN/gj0MYtcQ6dMmjxt9A4yWzcaBiNXCKT5ChWbbK
         26CUBt2gqyhjSMSG3C4bVbID3Ch5jV22jgkbIhIWfOQU8Rw8T6qVNVJN3oI5KE6+QIj1
         /yPALTkGXhurApcDd6gASniqLft2bvLMicyB4okl+H6R/+hutcxJpWLq6IOYfb4l+TvJ
         AvUuaWysO923F5nZOag0V7YQU4yDTRD7ujkqSFAwcLhDKpZ8l7ZiUq0H/Ukkt9aYNmXp
         wRrA==
X-Gm-Message-State: AOJu0Yw3ARihpSxl4k+TSeOOqQZr2KsXsZoxQ+nJgZhrM3bbiILMrLvq
	/YMbjiGqVYIuvb+xtk2nxFr7y4J0pD9e/PGicVe8aZxycWorfgTfVbe9K9JwFp0=
X-Google-Smtp-Source: AGHT+IGLwHpEII18ogQ/FcuuxEZAxQDrR5y7fb3Uxtwj/9dr3IzLj8aY1tlnOvuPgbu5gD8D/ea62g==
X-Received: by 2002:a17:906:3019:b0:a37:2a73:9730 with SMTP id 25-20020a170906301900b00a372a739730mr22139ejz.57.1706873405510;
        Fri, 02 Feb 2024 03:30:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBo8G0Jn+zdEmLW23YXTCN/xiRHIWn61WqM6lcJvJJxOUEOF4P3Jzb9dL2dyc5J9q103WyzsGplEM7mwNy7Gri70ibMXW2FJXESZ0Rzs470lPWJI/Xqm0agyJlQJtv2DnTCiaFTuwoEeS4kgkmGb2ImtBCryLDA4aGmuJtqX3uriu3CW25W8L8qPeapLy9n/WawVtPPzcwhixCKh2EnLsVlaRhyTBndf5z8H7MBTSoD4FBF57cAlq3dBw+Ps2H7VBHQ/lWBKpeh3SuwM+6fqlW39bBcP1+6QRXSUD5tz5JLQLSG1Z46WPZ+zlyd2lyNw33oEthXGc=
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a35d7b6cb63sm780317ejm.28.2024.02.02.03.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:30:05 -0800 (PST)
Message-ID: <9c048fd9-d328-4446-8e86-a3757f7446ae@linaro.org>
Date: Fri, 2 Feb 2024 12:30:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: x1e80100: Add missing ACV
 enable_mask
Content-Language: en-US
To: Mike Tipton <quic_mdtipton@quicinc.com>, andersson@kernel.org,
 djakov@kernel.org
Cc: neil.armstrong@linaro.org, quic_rjendra@quicinc.com,
 quic_sibis@quicinc.com, abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240202014806.7876-1-quic_mdtipton@quicinc.com>
 <20240202014806.7876-3-quic_mdtipton@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240202014806.7876-3-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.02.2024 02:48, Mike Tipton wrote:
> The ACV BCM is voted using bitmasks. Add the proper mask for this
> target.
> 
> Fixes: 9f196772841e ("interconnect: qcom: Add X1E80100 interconnect provider driver")
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

