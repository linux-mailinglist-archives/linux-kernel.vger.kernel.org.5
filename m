Return-Path: <linux-kernel+bounces-55528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5084BDAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE5D1F213AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0513FF0;
	Tue,  6 Feb 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfsIyxfD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597E13FE7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246094; cv=none; b=ahYv/StEh4NRWDfIoJZYTXW7KB6a3RF0K9jYuBc0XfAxjnH8nQneMvG1DO6TXaf+54hZoTDvfkJvfa19ZlEboucF90b1OHiUPhyzxF80sdWsuzZgwYm5hBAPi8ANCIdAUeUyo9KsgsmMlaCfSnCOVuFcWOapHElSQsuDiWMZ40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246094; c=relaxed/simple;
	bh=XTEtrwonVFdb1H3jhfeCIiTfAL6BTQPhVSKuBlryH5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPdCWcWSOTp+Vdcysn3vYOIc39kmmZbdAH3POh1PVlsoe5k6M9pLo4v/kVjbGwVTosFzyvxSaC7VpNviznnYyxPqhD7FIZvMfEijWVKZfTnK6EODOguBE9xOuGn/dVRuZQsHfH9zBAIqwmcX5cS0sPTO5HDdFCtDru3iWRULhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfsIyxfD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a380a1fa56fso174137766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707246091; x=1707850891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3GI4bKE6bs53DbBOkStu1FGlukGbwRLTbMhBb1AZ40=;
        b=QfsIyxfDZZjjHQhljUnI7itRdSgKpGbFnTy5oTPDG1Hf4C6ZsR5mff7f4kWuXTLGdM
         SVILJivg0r3xjj9tjh7lcGL2ReaR9T1c2rYok1uznVqvq9O5yCCHHHvr73kAqoJQvu9T
         Q9Up7dxuQx5s94oVkiHrA/hN7mB8raxNeVcvOWlv5FcRF9PBBHiF8esTcg3i13jkDRcF
         kUv8kgYalzKxQdl5L3y1b4lQgRB2C/eaup7FjCJgTXvORLPa0YWI8CHeY8OUaRsCEvlO
         dlgR+xRz6qzoz2OrDmgDy2PLSzfVx5iCEXZ6d4ZsxeUJrLHiorYWQ7Vi1IEqR7Uo1nmf
         kD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707246091; x=1707850891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3GI4bKE6bs53DbBOkStu1FGlukGbwRLTbMhBb1AZ40=;
        b=kIEsV0Nwwhcq3SuOPi6xhSps5dW/kHIckAehf4MFiGG1ZUI/4UJzJ8AcUlS9u3VevS
         UHSAdVcUVBgoc5PZasVimCqMSZmwKuhdQhq7HSql6SUdGGfCpHpQQfYjF6gSsr4QlVWl
         UB391s/0fSFxGSUJeXx5xsnHRd+IgsSUAj9oZaM8/wpmVvzxd6O5AF38KSW7ij2cJ7Or
         E5aQjaHxs70iw2BN2G1ZANYV6xUusZYjvDRUiPjDmanIev+bajIWdox0d+vK9M2Jxdok
         gU3SeuPRIzmOsUIqcAuH2JCXYedpOLoDjT/HuvKoqI1X8yCv+vOm/BKtGz7kmRVUvQ+E
         zGlA==
X-Gm-Message-State: AOJu0YxMNHkCIhKshEznsI249w/e4WlpvjurGFpUjIT6n8UHWvG7AFDL
	uQwLjwPRUL4g21awyQ62Q3rHdJaPygpdj0ciVppq5cnECE3GefYTuzPkIvXr+0s=
X-Google-Smtp-Source: AGHT+IFfdw7W/qLiKDfFLunsD6TBLQr+hAQh9lbxsLQp/sdsL9MGz2sdEqHrGMZY70LHo/QABL/pxg==
X-Received: by 2002:a17:906:3297:b0:a35:b59c:fc04 with SMTP id 23-20020a170906329700b00a35b59cfc04mr3598921ejw.25.1707246091258;
        Tue, 06 Feb 2024 11:01:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFE9g/drya5pnocHgJ7T/DdX1hKKHDn9zZ74JngHrMbHwxYgGiLDpMhXLfKCAGyzafC5o+8sACxipy6qYYhFii1fJWCapTbftJDe0Q1CFmPSx8Yx20rD0j6O7LG4vYXhIgFNGZaTHuQgy8GEjwoh9fnRjVllh2yPjfJn+rgNbshdAJBy/nH2rVV15Q9Iz73Cn0cquUqTsRUXAQBBWPWwC+rtqZWeLJm3XbLgRMuIhuCNikDwqErbgOoVAebHMwhr0TYJT0ygrJ+PZeHeijPKHczpf3gvN3sVf8QEWmpcvIPzro9M+DSVZNq7MZ2ji7FyhTAY6hpGSSML9yaRkJmZc/k99qQFIYGiruFE3Kf7MeMmUmt9LUs5ioBi4dU6Twz9ZxZgm9qc8pHS1+71TysrrSNytEvidrfInSjpO4LTCRPa4TjbL2ulPtyWsWRZ0603Zr5t0CjsE4R78zjwzj2tzHV+14D+f6N0zrz3btALmgojSQreAoGVkVMQTUWvTsxdn4zHKZJlw60mZnVyGa1t/imHTCkvOodwXAPBb2gGFZ4FnmNRgYQUyo8473XW4=
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090619d000b00a385535a02asm224018ejd.171.2024.02.06.11.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:01:30 -0800 (PST)
Message-ID: <f8b7ee9c-0f7d-4589-a593-429887e41575@linaro.org>
Date: Tue, 6 Feb 2024 20:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] clk: qcom: Add dispcc clock driver for x1e80100
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
 <20240129-x1e80100-clock-controllers-v3-7-d96dacfed104@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240129-x1e80100-clock-controllers-v3-7-d96dacfed104@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.01.2024 23:52, Abel Vesa wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add the dispcc clock driver for x1e80100.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

module_platform_driver + whatever happened to pm_clk, I got lost between
our discussions.. But the latter is a 'me' problem, had some stuff going
on..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

