Return-Path: <linux-kernel+bounces-27176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF482EB94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517BDB22CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6412B8D;
	Tue, 16 Jan 2024 09:33:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85754134A0;
	Tue, 16 Jan 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4303A2F4;
	Tue, 16 Jan 2024 01:34:20 -0800 (PST)
Received: from [10.57.46.197] (unknown [10.57.46.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636543F6C4;
	Tue, 16 Jan 2024 01:33:29 -0800 (PST)
Message-ID: <f616989b-2d84-483d-80c4-d3c6eb97b137@arm.com>
Date: Tue, 16 Jan 2024 09:33:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: coresight: Remove pattern match
 of ETE node name
Content-Language: en-GB
To: Mao Jinlong <quic_jinlmao@quicinc.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>
References: <20240116064505.487-1-quic_jinlmao@quicinc.com>
 <20240116064505.487-2-quic_jinlmao@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240116064505.487-2-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/01/2024 06:45, Mao Jinlong wrote:
> Remove pattern match of ETE node name. Use ete with the number as the
> name for ete nodes.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   .../bindings/arm/arm,embedded-trace-extension.yaml          | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> index f725e6940993..ed78cc7ae94a 100644
> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> @@ -22,8 +22,6 @@ description: |
>     with any optional connection graph as per the coresight bindings.
>   
>   properties:
> -  $nodename:
> -    pattern: "^ete([0-9a-f]+)$"
>     compatible:
>       items:
>         - const: arm,embedded-trace-extension
> @@ -55,13 +53,13 @@ examples:
>   
>   # An ETE node without legacy CoreSight connections
>     - |
> -    ete0 {
> +    ete-0 {

Why do we need the number ? why not simply "ete" as Krzysztof suggested ?

Suzuki



