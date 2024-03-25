Return-Path: <linux-kernel+bounces-116905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9688A4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533A21C3AAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA2E14D298;
	Mon, 25 Mar 2024 11:44:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3B61B7F6C;
	Mon, 25 Mar 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364827; cv=none; b=YWbFiC2oqB3ZkbsJCdV1w6ODbk69jyu3P/CsppTqDTVUz5Qj1xHI+/0nZM+/2TBMljead5J6FTYx5bjQF8MaVevRgr8CBzAx4K9Kic8nIuoiAcsuczcYmH1qOcHPXPYiNgnjLiCZITOQH5OExDCpbi90777sZM8XV0DMfcXXAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364827; c=relaxed/simple;
	bh=CZzaEGr7+ippkmG7UO/ZJeYSrGVNTB6Im466Vs/2dlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TP4LGEfOPtt0MN+lblZ1CwvLaoeBgJHAMaEirLdT/cfKoO/O7gG6ZqjE/ly2izMp2mnyb2EQVtKX/9LAldwhs9pa/DKyFsBdLeUgG2XSdTbS7F87INwHDX0+i4Bhxt9xJwLq0JpyjshOP/4KlG+l1h27rLBS9bHY8eeretdLLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72CDD1FB;
	Mon, 25 Mar 2024 04:07:38 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D452C3F67D;
	Mon, 25 Mar 2024 04:07:02 -0700 (PDT)
Message-ID: <f3a1325b-4126-42d7-b777-9b511279251f@arm.com>
Date: Mon, 25 Mar 2024 11:07:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] dt-bindings: arm: qcom,coresight-tpda: drop
 redundant type from ports
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mao Jinlong <quic_jinlmao@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, linux-arm-msm@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325104007.30723-1-krzysztof.kozlowski@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240325104007.30723-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof

On 25/03/2024 10:40, Krzysztof Kozlowski wrote:
> "in-ports" and "out-ports" are defined by graph schema, so defining its
> type is redundant.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Both patches look good to me. How would you like to pull this ? I could
queue them for v6.10 via coresight tree.

If you would like to take them,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki

> 

> ---
> 
> No changes, but patches were split from previous set. First patch in
> previouis series was being discussed, so let's just make these accepted.
> 
> v1: https://lore.kernel.org/all/20231206115332.22712-1-krzysztof.kozlowski@linaro.org/
> ---
>   Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> index ea3c5db6b52d..7fbd855a66a0 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> @@ -66,13 +66,11 @@ properties:
>         - const: apb_pclk
>   
>     in-ports:
> -    type: object
>       description: |
>         Input connections from TPDM to TPDA
>       $ref: /schemas/graph.yaml#/properties/ports
>   
>     out-ports:
> -    type: object
>       description: |
>         Output connections from the TPDA to legacy CoreSight trace bus.
>       $ref: /schemas/graph.yaml#/properties/ports


