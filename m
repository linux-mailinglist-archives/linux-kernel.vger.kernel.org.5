Return-Path: <linux-kernel+bounces-142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA92813CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160581F22600
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66FA6E2A8;
	Thu, 14 Dec 2023 21:40:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348C6A35A;
	Thu, 14 Dec 2023 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba2dd905f9so12069b6e.2;
        Thu, 14 Dec 2023 13:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702590037; x=1703194837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoMi10EsI7AdPIMIPL2rYDGdxQ1imor6ld54Oa0P67k=;
        b=D42MgCTAATdu8wi6xXcUAP3UVS/Qd5ga7lyxOGdfQ4XihJicO2FcwpnpFYrIH1LEbj
         6bAiOCEAZI1IuXx/kJxgsUNh8Ll2xt8j8oBr6LPIQCBtS0H3DxiAekksKNP7Zr+4A+l8
         m/HOL+Ic2c866cfp1Z/Z1H50jG7W4BMP9kIfkIvBE367nWO5MQpMbgMLiiPO9EPKqQnM
         tAMRObC/QsRVFXDfCuCP3DN+ZgDNmvC+BEqwzYRoBa1NefOL5yB+SrYQiebioUuRV2GD
         meRkgSSvQww037i4Ks/GwW1E5/V0jfvgBsbGImNvCEtlf+J5u7sRx8uHSzHekpdocZXJ
         o+gQ==
X-Gm-Message-State: AOJu0YzMcEmEFO3E/l2SHQyiQVFyHh/zdwJoi7G8/JJ21/WXjtHqRXni
	NF9hiP926ic4xrg4EsRoNb/vytq2Ug==
X-Google-Smtp-Source: AGHT+IH4QWBn3NVXVsD6ijDhmXJyQhKGHWdCRuCd2LDg16ILt9pC7L5vxJaRgZSGfkQeqKFEAUbVxg==
X-Received: by 2002:a05:6870:d0c6:b0:203:4dfc:7eea with SMTP id k6-20020a056870d0c600b002034dfc7eeamr1569496oaa.83.1702590037524;
        Thu, 14 Dec 2023 13:40:37 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id iv7-20020a056870b9c700b001fb3240116bsm4737303oab.7.2023.12.14.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:40:36 -0800 (PST)
Received: (nullmailer pid 983852 invoked by uid 1000);
	Thu, 14 Dec 2023 21:40:35 -0000
Date: Thu, 14 Dec 2023 15:40:35 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Thara Gopinath <thara.gopinath@gmail.com>, devicetree@vger.kernel.org, linux-crypto@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Anusha Rao <quic_anusha@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] dt-bindings: crypto: qcom-qce: constrain clocks for
 SM8150-compatible QCE
Message-ID: <170259003524.983799.16606120308067871581.robh@kernel.org>
References: <20231212100044.26466-1-krzysztof.kozlowski@linaro.org>
 <20231212100044.26466-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212100044.26466-2-krzysztof.kozlowski@linaro.org>


On Tue, 12 Dec 2023 11:00:44 +0100, Krzysztof Kozlowski wrote:
> All devices compatible with SM8150 QCE (so SM8250 and newer) do not have
> clock inputs (clocks are handled by secure firmware), so explicitly
> disallow the clocks in the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/crypto/qcom-qce.yaml          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


