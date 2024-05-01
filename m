Return-Path: <linux-kernel+bounces-165815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C028B91F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F191A287206
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1324168AE0;
	Wed,  1 May 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylICOARt"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC22EB11
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604762; cv=none; b=QCZFUl2+d1xA5UaQVEA8DiNNKqGNQuINYgfP9mRKXYX0exXllqjEDiqJssoRhwDrku5BX4x6HM+zxQVT77sWNW+Id2kdXvd/SQB6izC04Y161oh8t/i1/q7IYX7NrJ1PkCxF2Ph7kNFI2qUzsCUd82bR16WviM27dSzxpCSjE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604762; c=relaxed/simple;
	bh=78qQK9go7IP/03w66HUm+Z1Gk8P66woRakqNYF7YA6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWWZkxsoZIXqMKW2itCC5lkUujEO5Qpneqoz+BjB59fg6nT9vtyWm0OSDzMONlwj1N3q7smv4XTR0VhmINOHo1JgaySB0pAWBdtYfbULsJ2AuXgOkgYJh8Kt/8lI5GQHjSCOrd/XKoYDNV9aoT35iPjtvdXTeo1Ktzc0/3Z6M0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ylICOARt; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so84979901fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714604759; x=1715209559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cRBEcA6g+erlLdoN9JCHOuy1WSfoHszt/1llYH033ko=;
        b=ylICOARtRD6F7efcJjNLHlE1gFOJ+Tj04Q4tHXvLfknEIVC4P6yITnM7y8/WjdJq8x
         /9lvHi6VR/ubzY1AvJf+eiL+0jcMkrKcXLhLkhnd4RnZe4DRNXhDv7B4iexCzU+ghjzs
         NND1OlDOizkJH+/VnscRNe+a2ZKi3kj+4yW6YKiUqqWJ6iz1Wj8ru957hwQ/bEXnSD2v
         4Cptpi8nImnKxbX8ek+p8ICQVoem4mGRGRzyJsVWQCatT7/dP5D7+YoBLehjbv6dJr4j
         sjT5SZFzlzN32ImeyGwj9Q20qpovNLovfvcU/gMW4KhVS1lBmikYS1L1MIsudeXU8CVK
         3hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714604759; x=1715209559;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRBEcA6g+erlLdoN9JCHOuy1WSfoHszt/1llYH033ko=;
        b=BNHyBcoSzYJAuO8wdfhSZgqAwK0t0klyCjA4F/TIyLT8GdiP9iMpwa28dD5NkLq5zt
         KbTVxmQ/xFuSKDMuPgmM3BjigKp+2iJvvt8280n3fnHGFKGqY5V9sxcaQHKCjLVfpjVE
         ZbLJ52gf5Ci7F9Pe9nBe9Bik5mRk6yWabMn2+fIKsrdxNtGzMhmNJw7hazyYu7gfa6uS
         p6KGb7t1MGEd+WzebMf/BYLj0mPdymsfyASshR3cPjtqVO8/7PwxsDy8xrD4je3HaKnp
         p+xjzmkPSqviUhcC6HE/iIxm+9TL8JfzsF6tPEE+xUS3bbzZZZtvV13L2JGKn0d9ALBR
         0NiA==
X-Forwarded-Encrypted: i=1; AJvYcCVZAtR9U1suRH3NxEt4zPKpwdXKUAfM0Cl+fnRD3fDIhRasW3B4PEQiob4R+og0yvHmMVVYEGnRH/+db/jyTQVF+BRWF9OJ5PdaGVMq
X-Gm-Message-State: AOJu0YxmES8rxbP5gmeSBx+DkluKOoV5+cM0kUNpCnXpyZ6ucIsL+X0M
	VM49bkeQhRIioCLxFDw3a/G2n6ae6Nck/4oRKQJxmkVajHDpQ2i1nR9KbQQGopk=
X-Google-Smtp-Source: AGHT+IF6OMGZZYenYi9Acf2TXo7ddbB6cUhYV16WhKLqosbbD+RcK8Qv6yX4zk8hdkhaC3hJMC0FLA==
X-Received: by 2002:a2e:9ad1:0:b0:2e0:e470:882f with SMTP id p17-20020a2e9ad1000000b002e0e470882fmr2385088ljj.28.1714604758948;
        Wed, 01 May 2024 16:05:58 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id p6-20020a05640243c600b005725d859e4esm6083491edc.73.2024.05.01.16.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 16:05:58 -0700 (PDT)
Message-ID: <f936d927-4d17-4928-a1a1-7bd4d3db6e54@linaro.org>
Date: Thu, 2 May 2024 01:05:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] arm64: dts: qcom: sm6350: add power-domain to UFS
 PHY
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>, David Wronek
 <davidwronek@gmail.com>, Andy Gross <andy.gross@linaro.org>,
 Evan Green <evgreen@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Iskren Chernev <me@iskren.info>, Luca Weiss <luca.weiss@fairphone.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20240501-qcom-phy-fixes-v1-0-f1fd15c33fb3@linaro.org>
 <20240501-qcom-phy-fixes-v1-8-f1fd15c33fb3@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240501-qcom-phy-fixes-v1-8-f1fd15c33fb3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.05.2024 6:19 PM, Dmitry Baryshkov wrote:
> The UFS PHY is powered on via the UFS_PHY_GDSC power domain. Add
> corresponding power-domain the the PHY node.
> 
> Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

(same comment as p5)

Konrad

