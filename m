Return-Path: <linux-kernel+bounces-33465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F4836A00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA8282756
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8A130E59;
	Mon, 22 Jan 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+pPdXxF"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF040130E28
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936406; cv=none; b=lVIDD2hpJFEqZ38/fCXz9LgDGrucinYKFbireKd99tJE8cFxvWuuV2FJdpGzm2mfxODIoRcYqKN7K0BaMuoUR4pbyevTduF0OHzgbHukwANdaJWz9D4ul6M4ZrX6rgeebvC+17MB1kL9nhGuXOPLEzuUyZCzRxqtIpBb7pAmF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936406; c=relaxed/simple;
	bh=56AXuFbyDotBIe0zRySCPe31hcHy1morlPgUrVeQcq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDRsHXBsPtVYO7bRSFZg14L52aQc/YwVkII8WrrRPdooOKnFU80fdQsrXVIx3NKCSuK407yAsxzgz2dmM8calqxLk9WAzIplnFbrMb31rMINchWlVrpgrb8hG9Ig08BkwsOrdT+vi8HOfL3mF5L6VEFzsICjrWhKCpiGhi5/obY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m+pPdXxF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33921b8988fso2889005f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936403; x=1706541203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlxi8b8oDDKokQlPnmcikOTjVRP/PxK9QnUm6yUSqlc=;
        b=m+pPdXxFwEUWzYHp79xR17vD6km0z/jVH97JPLEH9eRR9QPn9TfaxfCIvzIBdjIWzM
         S8fwQlxKNMcOBvTeAELGjZ0lg6w2BqkjUwJI188NpriVVkVcNY7tfJSJ4Q9C0vIj9Bja
         hjNbQ3G8JnxmfBtFURC8UZqkICOs9gu3ATnqKLEQU/ePu4nIGsYVDa2X+oMOszBFou65
         p8ppKraCyeIaHuuNOSn6nDbkpjvv6c9iWSanXF+fdStA50/u2b7tWxzpxKCWh5LftEw7
         XNoSi34QjwdTuqhMm5Vh/Xs9uNo7QHPf+PXDW1FqwYMZd1SveCeDZC0UyCdlwFpKIFnE
         1UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936403; x=1706541203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlxi8b8oDDKokQlPnmcikOTjVRP/PxK9QnUm6yUSqlc=;
        b=LQH5O2ijWQaEL+dKV33R//ixsBLrTUrH22fOx7RVzx/pqlUwc7HOmQrKCqg1b6iWvt
         qostNEE03Eu0Ldxsdm2Sutlknwn3wQGes4KIhpXlvCyvfF3qNvwZ7S0sqG0ZLxSO2BR4
         gawlOw4ifsadFphbKeXvo/B7+95d9b7S6SNxTZhE1Qv1kMk8AMUITepGltD3TX2fZstC
         cDLHHdgrVO+/pYbldUzCSrO71/Z+jx1mBHJ1mcNcZtL0cBwMzBM3uszPJRlktCsPSSua
         jLBMlX3S862GSHNB68pT6IBCV2Q4zInG2ii/xVmJ75kdf1q0lqSACqsVV76UxMVaGSCz
         0Jjw==
X-Gm-Message-State: AOJu0YyAf2Lm2GsKnTcF7Uh4vVFLuVMXZ0eahyO/0NYdwmp7bYoUpoNu
	glr/VdcEpWj81017RSzYKY3idO9Z+8ZDzZBCZ6MjVRZGqeYLAhk8KeznM5zj/1E=
X-Google-Smtp-Source: AGHT+IEM9J0zPraq2oeR7eo9w3rrNO8V+Yb011gp82GAmVJDBG8jXmExKleS8/vEVAFlRW83rHWPig==
X-Received: by 2002:a5d:5886:0:b0:337:9b43:bb4e with SMTP id n6-20020a5d5886000000b003379b43bb4emr2846308wrf.74.1705936403055;
        Mon, 22 Jan 2024 07:13:23 -0800 (PST)
Received: from [192.168.100.48] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d5510000000b0033924c2fadfsm7216881wrv.17.2024.01.22.07.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:13:22 -0800 (PST)
Message-ID: <3f68ee9d-13fd-4818-b6b4-b3c26bf998ed@linaro.org>
Date: Mon, 22 Jan 2024 15:13:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] media: venus: core: Add SC8280XP resource struct
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-6-8c8bbe1983a5@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-6-8c8bbe1983a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/08/2023 21:09, Konrad Dybcio wrote:
> Add SC8280XP configuration data and related compatible.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.c | 45 ++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 5f285ae75e9d..32591b624a36 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c

Reviewing this series, I think my input here has not been helpful or 
correct.

1. Declaring encoders/decoders in dts or yaml is wrong, accepted.

2. We can make a platform choice to hard-code that here in the
    platform declarations.

3. Remove the requirement from yaml for sc8280xp to declare decoder
    encoder

3. Profit.

Existing dtb all, literally all do the same thing first block decoder, 
second block encoder.

Rather than perform extensive surgery to venus to remediate the original 
yaml sin - hard-code decoder/encoder into platform code and deprecate 
the legacy over time.

Yes that means fixing to block 0 as decoder and block 1 as encoder but 
that is the defacto situation we have now, we may as well make it dejure.

---
bod

