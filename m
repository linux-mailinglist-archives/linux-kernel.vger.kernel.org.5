Return-Path: <linux-kernel+bounces-141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791E813CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D91C21B53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373A6D1DD;
	Thu, 14 Dec 2023 21:40:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A620FD;
	Thu, 14 Dec 2023 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f0f94943d9so8847fac.2;
        Thu, 14 Dec 2023 13:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702590023; x=1703194823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmDO734McYh1MUhV4LxcVBjPolXw2vYcOw8gG6Bk1YM=;
        b=N54pBU+3t++LCd1054cju8qAeswMW2hBvPzV9q4hnhwfPCc91dgCoLkeF8+F1Bkujj
         8uuDchx0hPTRhfEon2YanGdgxY7h5yBAkoqLTmrx2UPPT0i+3bHHo+kWLETuctEtEiu1
         rvsnGmAeDObqL+HKZHfmZvZoXWxbcV7IA0Mt87IAvh+Z6Zu71VbryfBkzGzX2vjwuIjM
         fchVkWP4XGdeSxixp9EOqZxGFKzIbXvGENBeHLt2u0KriLOKfxUAqYdW6DR434sRq4h0
         1xAhDtjpNnW3YDousc2Se0X/RBza/4fnjoR9ZXMnLgdhTUSPbyoJIlDzvNWpDf3Q4q3b
         ZhJw==
X-Gm-Message-State: AOJu0Yyikn5RHte1/HdhSwQT36EQ5jG6SnLuJHV5/Ch+gK2RfzE9efw/
	cPUBkXpV2E5QY0T+DAA5iQ==
X-Google-Smtp-Source: AGHT+IGprqQBv3Uslq5N0Z+o7ckwVx58gfdr+6ETztZ8QLCk00/0fKEGNHFd3LqUSB9mft69WOBrPg==
X-Received: by 2002:a05:6870:b48c:b0:203:226b:6b24 with SMTP id y12-20020a056870b48c00b00203226b6b24mr2512795oap.35.1702590022956;
        Thu, 14 Dec 2023 13:40:22 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id pb11-20020a0568701e8b00b001fad96b0264sm4700606oab.10.2023.12.14.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:40:22 -0800 (PST)
Received: (nullmailer pid 983475 invoked by uid 1000);
	Thu, 14 Dec 2023 21:40:21 -0000
Date: Thu, 14 Dec 2023 15:40:21 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "David S. Miller" <davem@davemloft.net>, Thara Gopinath <thara.gopinath@gmail.com>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Anusha Rao <quic_anusha@quicinc.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, linux-crypto@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: crypto: qcom-qce: constrain clocks for
 IPQ9574 QCE
Message-ID: <170259002032.983406.16305616572656643410.robh@kernel.org>
References: <20231212100044.26466-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212100044.26466-1-krzysztof.kozlowski@linaro.org>


On Tue, 12 Dec 2023 11:00:43 +0100, Krzysztof Kozlowski wrote:
> Binding marks several devices as compatible with IPQ4019 QCE.  They have
> different number of clocks, thus the fallback does not define the
> clock constraints per variant and each specific compatible should have
> its clocks in if:then: section.
> 
> Add missing clocks description for IPQ9574 QCE.
> 
> Fixes: 1f5ce01d5d71 ("dt-bindings: crypto: qcom-qce: add SoC compatible string for ipq9574")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


