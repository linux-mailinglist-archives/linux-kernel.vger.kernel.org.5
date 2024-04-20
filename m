Return-Path: <linux-kernel+bounces-152234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB28ABB2C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B6D1F21163
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D812941E;
	Sat, 20 Apr 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owxG409S"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8561B809
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713610669; cv=none; b=FwTkoL3mF3h19B05RMyHniBTcGt7wET1MaPh/R7lXmLMB07JOMJTSI8i6Th3X+2pYEVhykmy/sB26Zr/KLD22rL6WFRfjbEU9OZlLFqymaaxGIEYxXHtymSEFddC4GEu7Fctl4dS1tibS5JVkSi7YhkeoKP2mtaQ8PiJxEzBu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713610669; c=relaxed/simple;
	bh=23hWeEr+W84WKW10MFW2wGv1mxXeR0jauqdsZvPF0GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0TwPBcjLLLcDTJGcfq/oTHLLB1ozSj/vnvsqX5moIrmchRmkkvugotjXjsFDjbAcCWp7M8gIQ2ONvZQpsXGuH4+fSfAQohP+zZwANq/fQi4CmlyRQY2JcDrQQl9SpcnCAtvSivq2r+d0TpK1wl3y3teGzuiPsdEKHtxpPY2ZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owxG409S; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34a00533d08so1808752f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713610666; x=1714215466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipeqzc6ZZ02TREHla/6ToLuSgvq7MVUYfKOCJgBT6bM=;
        b=owxG409SfEpU5cOFtgZcJEhFPcw5NUntZLZBL4vQs9lTeeDnpX62Bc7d4YGtoIdjBJ
         Eu4ha6pi+t9LwujS2virBMeoVM05N+76ryd4eFqtWigv3cFXof2vmk2HTG7imdl8AcFr
         TK5lgdcYMtJpiLa/obgpULqJqF9kQxd5nO0sXEGm/9JcVHRjVEiIseBvOfjctV3boKfg
         fRubbjbs3cvZeyQBqZcPYXlCrytsAYHLv5PRcb2eLwxMDDwDp57ifaTVKIKZDdXAStLU
         6b3ynl6ikthICRhfwC0IlIwH5c/mKHWsawyh7VPnxDJr206mqw148gF+q66XkcFR/BTg
         +3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713610666; x=1714215466;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipeqzc6ZZ02TREHla/6ToLuSgvq7MVUYfKOCJgBT6bM=;
        b=S3CuvjkzFF3kTuoJLXib1T5UuBShiKSc8+QxgfTFMVkKwkUp5kuZeB/0MfZWc5Rjng
         4FbKh2MP087Wlq25M7q8/koc0KO7fETr/IUWQtFkJEPSnRxYHPO0nZJxMgBLy0OEEtx6
         VjWu0vF9Gj09p0G7XmHyigI4zh653hNsdogye3BvrwoIhGNkSh8OjqfoYVz0muk+d9ql
         hKq3PPSnx7k7bO2fwle9b8YA0qIg59vPwZJ22C/sOKNpQx4nvTQye4zkUoCAHd9e5kSy
         P2ui6kgfY0ppQWbTY6JpJNwKaBml7KVTGhaSkeR88mSKsBbGQ2TzUmenyTrohxPWZe8j
         dzxA==
X-Forwarded-Encrypted: i=1; AJvYcCXdjRuF4HJCNsFJ0PP9QmIL1Vgf71FoyQVQFTR26rcAnbhsSGupbf/KCytJppHs3dPYy5dPO20ifzNynO5c75Yfwrzjl+LirstL9V6x
X-Gm-Message-State: AOJu0YwS3juwd/98OlFQikvscxexIBpwioGaqhIYptjB8aEjWnPIlllA
	qC4elRW8aniAERN257Irsztuv/xWNcvkJe3EJdlniLays9a+nizhnBlBBz6HCN8=
X-Google-Smtp-Source: AGHT+IFkA8Y7ennaLjq8bZ4n1JCaFKc7IdLrpPRWj5rTDXNWayaiI2eIh0FoCthPJ/SBJ9VRtl2pYg==
X-Received: by 2002:a5d:49c9:0:b0:343:44d2:3828 with SMTP id t9-20020a5d49c9000000b0034344d23828mr3230642wrs.16.1713610666016;
        Sat, 20 Apr 2024 03:57:46 -0700 (PDT)
Received: from [10.236.36.88] ([88.128.88.151])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c501100b00419e078677csm2258995wmr.16.2024.04.20.03.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 03:57:45 -0700 (PDT)
Message-ID: <19bee3e2-ea14-4fe9-ba10-497166ab791e@linaro.org>
Date: Sat, 20 Apr 2024 02:50:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
To: Elliot Berman <quic_eberman@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
 Melody Olvera <quic_molvera@quicinc.com>,
 Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-1-da9a055a648f@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-1-da9a055a648f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 21:30, Elliot Berman wrote:
> PSCI reboot mode will map a mode name to multiple magic values instead
> of just one. Convert the mode-.* property to an array. Users of the
> reboot-mode schema will need to specify the maxItems of the mode-.*
> properties. Existing users will all be 1.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml   |  4 ++++
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml  |  4 ++++
>  .../devicetree/bindings/power/reset/reboot-mode.yaml         | 12 ++++++++++--
>  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml  |  4 ++++
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> index 627f8a6078c2..03b3b9be36de 100644
> --- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> @@ -30,6 +30,10 @@ properties:
>  
>  allOf:
>    - $ref: reboot-mode.yaml#
> +  - patternProperties:
> +      "^mode-.*$":
> +        items:
> +          maxItems: 1

You still need to limit total number of items. This only defines how
many items you have in each inner cell of the matrix. What about the
other cell?

I understood that you want something more or less equivalent, but the
code does not look like.



Best regards,
Krzysztof


