Return-Path: <linux-kernel+bounces-822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799218146AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87EA1C22276
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD224A1B;
	Fri, 15 Dec 2023 11:19:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E40F1C2A9;
	Fri, 15 Dec 2023 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D56AC15;
	Fri, 15 Dec 2023 03:20:17 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BBA53F738;
	Fri, 15 Dec 2023 03:19:29 -0800 (PST)
Message-ID: <09447d69-e0ce-13e9-95ea-0db475b8bb6e@arm.com>
Date: Fri, 15 Dec 2023 11:19:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: Add support for CMB element size
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-2-git-send-email-quic_taozha@quicinc.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <1700533494-19276-2-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/11/2023 02:24, Tao Zhang wrote:
> Add property "qcom,cmb-elem-size" to support CMB(Continuous
> Multi-Bit) element for TPDM. The associated aggregator will read
> this size before it is enabled. CMB element size currently only
> supports 32-bit and 64-bit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tpdm.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> index 61ddc3b5b247..0d9fe01a8b15 100644
> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> @@ -52,6 +52,15 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint8
>      enum: [32, 64]
>  
> +  qcom,cmb-element-size:
> +    description:
> +      Specifies the CMB(Continuous Multi-Bit) element size supported by
> +      the monitor. The associated aggregator will read this size before it
> +      is enabled. CMB element size currently only supports 8-bit, 32-bit
> +      and 64-bit.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [8, 32, 64]
> +
>    qcom,dsb-msrs-num:
>      description:
>        Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
> @@ -110,4 +119,23 @@ examples:
>        };
>      };
>  
> +    tpdm@6c29000 {
> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
> +      reg = <0x06c29000 0x1000>;
> +      reg-names = "tpdm-base";

I think this one gives this error:

 $ make dt_binding_check DT_SCHEMA_FILES=arm/qcom,coresight

 DTC_CHK Documentation/devicetree/bindings/arm/qcom,coresight-
  tpdm.example.dtb
 qcom,coresight-tpdm.example.dtb: tpdm@6c29000: 'reg-names' does not
  match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas
        /arm/qcom,coresight-tpdm.yaml#

> +
> +      qcom,cmb-element-size = /bits/ 8 <64>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      out-ports {
> +        port {
> +          tpdm_ipcc_out_funnel_center: endpoint {
> +            remote-endpoint =
> +              <&funnel_center_in_tpdm_ipcc>;
> +          };
> +        };
> +      };
> +    };
>  ...

