Return-Path: <linux-kernel+bounces-55533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15284BDC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4222B2281B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540EC199DC;
	Tue,  6 Feb 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqO/6S4r"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D218AF8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246199; cv=none; b=XpQCwijTrSrK06YXNcqz6w2rQgAhnPxh90kLGScj+JYmU1IctZO+P6bWY+w1ulon6IGIVjy61gkQdJW2ZFAG0wwhl0iLrGLTi92z4Pd9H/+y0HjsNEjIysa+2ISeuSoCpLsYwBj4vCU9G/uL2qMroEpsMd1NyXt91P+ZuJmtXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246199; c=relaxed/simple;
	bh=tDvmcC1XqmYlk3POBmSOvim37fc2ev/y133pBpqytMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3VZcC+ZwBLdTorVk8GQICNLmIg3rPR6fKhfik55uoOkmTqc/orUtcWOtgCODqbcWxm4i08xjelWHYgkbqlN3h7jVNCocQyC1tQFF1a9EmVZiSRqtTf7DvFk5MRF2pNnaosB+R3Pday9hOoJ/2BvuEmqZMgoPgnPNI4tqBosHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqO/6S4r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3832a61a79so104218666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707246196; x=1707850996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJQuKhpYgmCz8uFDkKBClqGKhdKVeotRI0CTyIAbsOo=;
        b=XqO/6S4rkNz3MPjy5uQu4rVViIifN1s5wx20BHHLRCjhV1YGomndDBwp56nBRQ8UKa
         1m877rVG8r4tRvGJdVSBPiIm1f8Ti+goJEM+4UmHQ9DjohZb8yywVNY7FU15cCaisOK0
         LR9Q0OoZgptG1o4NBDs8IjcKJ9e/0I/sh+Eg6XNVAhqHmEIbPrF4hutao756Y4CZO3jC
         MRS5qg2kYrmT13yfrWtEIHWj+/1ngcKbQ4pW2sj9BcL2hKqTPR780Cia9NUD5nbzjGdG
         TSEli0syYaG8fqON/lHTjwMVf9bm6/v83at3GeFDVqGk4FM2cGKy1A9OuSnsHzfkn4aj
         Dc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707246196; x=1707850996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJQuKhpYgmCz8uFDkKBClqGKhdKVeotRI0CTyIAbsOo=;
        b=lAuTyoZXS378szGNFTaNQrC2S7CSTOsrotodT/OxOD+wlSCbmj3cH/Ec3EXwReqoVq
         5DUdR85Oa0MnawHEFfsaih6fThLjP4oNyH38l6ZM7K29ArGuG18B7POUUh/aPYOIf5LA
         XbE7IwSaGqG8YrdwEMEg/fpmOZsjyuYXRZVEKH/U3ImLl24M93hSzLUherGZPo++1zlA
         ZN4j5HdcErJckg6wl7yf3sjSeLQJDAAe0Ku4uZ2+UosHoXgB8FFm6QG/h/GV0amI3JHa
         14EHmWvNJQsJgyrfF8UEPRnxPZ4Vpq6ymclcpsWVPEuQLIKl3rrKOI1x30jfJw8+ZDXj
         1XPg==
X-Gm-Message-State: AOJu0YytoB88/lnNy8zOtxs8Rz0XHkDaQ9sfd6IDKgJ/GfpCTKxk4+qP
	pgEOBnntrZLJ+HcsgLuX5/i010Np3wzPXY5KyuVtshF/6Fx1cK0DK+8P0N0FXMM=
X-Google-Smtp-Source: AGHT+IHrT+cq12J+05wj4WSmFPVlHw5YX4iwYI8HIph8SvWYgFT2S8x61SGUTMa3owcEV7CJAV+4Dg==
X-Received: by 2002:a17:906:374f:b0:a38:526e:8474 with SMTP id e15-20020a170906374f00b00a38526e8474mr738482ejc.53.1707246196181;
        Tue, 06 Feb 2024 11:03:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWs0HWuUqBlgV+KrpUzHzlsP21V0+qXJc41T5A+N9DtxQ42588M1LFGct8vDUwdM+rbTIStTzxDwgzx78dcvjxZuJcM9P6NalC9l9+50eTeF+dPhIMfQkBfrlxp6GsbjLPth3DaoqzWy3NMn8vTxNdkt6BkqOaW5zWUbncLOMDaiD+selb0cuMuoanQEJ1qwqyHU9Bn0Rv7D7RsiNo6OHcjCe1D9i0Qi2ytosmQVWU0LqvqiFiA5698LjjbdfEHCYvjtSt2AaRZoFzA6a1FjemdZK2xlKYoG3j2IRdd5vRbQsK3RDkvL/NTN6DWEvkkca+jVQXF70+Q18Ddu/NC6skdBm59nNlnqw9JJVkmXob05F+d7AegTprTTYAxkwHE84S0N2tV/9cCXQIWdjmrkZfcFXtJsbQ856It55sZ0GrlEM0Eg9kQvCdkAwXgPDVcB2W8vgPbPNt6tQp0/u9TekDyoLMgw0DyBgvZJ6K7z9QJy/tAaZg2lI095348H/0+aBFrLo6LW+jCV6IxEaqwvTGft/maxI5WYNC789xCbILm3mGT5aDHvbKZ0QJnDbsCLd83YZcZsIkbm1FadC+moN2UY6axyHtMIuCD
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090619d000b00a385535a02asm224018ejd.171.2024.02.06.11.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:03:15 -0800 (PST)
Message-ID: <b92fea72-c5c3-4938-bb2c-7c62904010dd@linaro.org>
Date: Tue, 6 Feb 2024 20:03:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] clk: qcom: Add camcc clock driver for x1e80100
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
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org>
 <20240129-x1e80100-clock-controllers-v3-10-d96dacfed104@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240129-x1e80100-clock-controllers-v3-10-d96dacfed104@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.01.2024 23:52, Abel Vesa wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add the camcc clock driver for x1e80100
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Modulo pm_clk

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

