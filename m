Return-Path: <linux-kernel+bounces-149860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5346B8A96ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60841F22107
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB415B555;
	Thu, 18 Apr 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TII5qJ5H"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413415B569
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434558; cv=none; b=YLaWN4KdnyCmzG6h0aGrSJdvLYcj1E6e+GZWu9nA5kSTayUvJ0Xq1fb7JA+eSeQzfJjx4uK598RdA9+bUUV421gna1y94qqf2nzijLHOHnfDWVnTPz/fr6x5bhZ7kr6D4aBUT0WdlxaOVhnV4RpQn8ETclBk/m03kSqW/uK0KxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434558; c=relaxed/simple;
	bh=Lu5cwnOqsWBHHVTw2AzuWbQX0zd3RFY4XyEn0Fx2c64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHM7T++MxYi4xGU/S52KPgUIV4U02lJAEDHneZDYnNbGJb8ljjRGdXvzR2uSMk9J7gf+xHqpWEQzZUmtiAB2DYk/GXWLpu2nJeUOqSR6kLPE+uqZw2Zeev+FHavkcpqU9uq1xCuTERAw8CyaAkbHLDzIH05D35tTge06oEqW+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TII5qJ5H; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso965282a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713434553; x=1714039353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FnxTEEEgXyOHv+t6SMhe1If5D3C2g5i/C1My33+brW0=;
        b=TII5qJ5HhDwLAlceFOt1dr30GyUTe/FGM1wpQJjI41FrDFWGq3b9asxj4gkCLLQXWu
         N+vhhMKJcV8OBB7e0yKXqIFw2hoGGHzZsuGZjVknYYBhaaLMQgm+19hCLFb2agHGNOb8
         0Lcby6F36xcOoFFJyhDrojyhEVH5DAV9XimOeX6n3Vo7MzxPTnpycsKx6U37r3frrR4U
         QJ4Sbsknwccd+S3sUbVlRoPHmWV6TyY3hV/03SVjrHCerpwELruC1DDfXolrsqGfh/kI
         JeJ9F+jDNkwKrjSKLtSprfWVU7ArpBHDFhoLZ+sDRQ0XdHYzbg4WTRQbQcFsolbfxpFa
         LK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713434553; x=1714039353;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnxTEEEgXyOHv+t6SMhe1If5D3C2g5i/C1My33+brW0=;
        b=Q1VFodG0VVHqMNML//+MNOdqEnmcpyGzVnDUow0S/OVp9b+pYq82E9GZBHEtvQjkIl
         j01tCihLJ9ysegUXiOTnYZaCwjnQYKnvEIFTonKVGzf+WsIzuA03z+tzdq69vtrSUMtS
         kOCAHGkEPyTmVh4P+kY6vgtnbfb+dUzK0f9qjtqtnZCgB8A8MH3NkvtCpCN8/DpbE3oW
         5yEGa3EuXfVbfF07E5g2g2gBSPl/nEfI/YSNwG+ATquYivurtw5hQm7uzhYLNiTc9zwN
         g8csRbGzgvto9VtoANjGb0xsMlYkLtcscy/l0aKlg1XjwfeGJKoKAqZZ7ptSM6Ci87gA
         yBcg==
X-Forwarded-Encrypted: i=1; AJvYcCWVWH4pfmNNacnOMY5oL/e6I/zeeCnTH//7PzrbDiur+s2ZR9gye4crEvX51/zU8YmV8GJ2INyOnqVv6imu9J/+MKk2oYLfJCKOctBZ
X-Gm-Message-State: AOJu0YwcdgMxhrkjIjlSDgpg21pWewdXtwPLD06Fi7JrFN5RGcxCO2dp
	rNU0EyCvAnz4TSzvf/TFZKvrQ/3EAFilO/zCtcyvfmWVSI1yu68NXg8sBID8lAU=
X-Google-Smtp-Source: AGHT+IFL8NYfQtVBhx816Vj50nQ4ww8c0vfWVZ4LsZ8eXsIFUIWQ1/25jS313ZZKpUMvHZQXnZ8Lxg==
X-Received: by 2002:a17:906:1be2:b0:a51:bca7:3a96 with SMTP id t2-20020a1709061be200b00a51bca73a96mr1503771ejg.72.1713434553296;
        Thu, 18 Apr 2024 03:02:33 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906131900b00a528064f438sm670072ejb.34.2024.04.18.03.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 03:02:32 -0700 (PDT)
Message-ID: <eac7ffe1-7490-4dc7-9d97-637ec31e855f@linaro.org>
Date: Thu, 18 Apr 2024 12:02:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: msm8996: add fastrpc nodes
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20240418-msm8996-remoteproc-v2-0-b9ae852bf6bc@linaro.org>
 <20240418-msm8996-remoteproc-v2-3-b9ae852bf6bc@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240418-msm8996-remoteproc-v2-3-b9ae852bf6bc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.04.2024 8:44 AM, Dmitry Baryshkov wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> The ADSP provides fastrpc/compute capabilities. Enable support for the
> fastrpc on this DSP.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

