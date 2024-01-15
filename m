Return-Path: <linux-kernel+bounces-26394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE8982E005
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB89B21572
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247918657;
	Mon, 15 Jan 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7EoQMaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054418C01;
	Mon, 15 Jan 2024 18:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7CFC433C7;
	Mon, 15 Jan 2024 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705343711;
	bh=A/NUlrmkYC1Tdahi24UVZlzPpmQ3KRyTa0ARP/oeSNw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=d7EoQMaLtJzqBcczk12hENAP5xZuFi6rZJZ5i1dH6Y+LcK8ASjn4Y45PPpIIRR9px
	 EbbbH480qegzsHehZmpjBDsL1RybLAoWYEi0uIcEiDPnjebO3/6DnnyKElVzMXJjb2
	 pNS1kJ3WZPy9PhYDJunN2xkEBw4cSsILBNBiixbekH5xc3L/h89XYN/7i1avFH43dv
	 eq/LgxhJ2QITmcZ2Rc8bfgtNOvHNuJJAHxhMCbIUVYgcIf8xaneYENqApfKBY/Ct71
	 uQEY88damXIcjdfHDkHLlhLPcEWGaK9S/3KOSYaJVuMAiwmp8D22VoGYONNQO2326c
	 n1t/ULLQs+w3g==
Date: Mon, 15 Jan 2024 12:35:10 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-arm-msm@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 James Clark <james.clark@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 coresight@lists.linaro.org, linux-stm32@st-md-mailman.stormreply.com, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Leo Yan <leo.yan@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Mike Leach <mike.leach@linaro.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240115164252.26510-3-quic_jinlmao@quicinc.com>
References: <20240115164252.26510-1-quic_jinlmao@quicinc.com>
 <20240115164252.26510-3-quic_jinlmao@quicinc.com>
Message-Id: <170534370911.1098380.1193154530422251358.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: Add device-name in the
 coresight components


On Mon, 15 Jan 2024 08:42:48 -0800, Mao Jinlong wrote:
> device-name is used to provide a better description of the coresight
> device. It can provide the info like the system or HW it belongs to.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../devicetree/bindings/arm/arm,coresight-catu.yaml          | 5 +++++
>  .../devicetree/bindings/arm/arm,coresight-cpu-debug.yaml     | 5 +++++
>  Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml | 5 +++++
>  .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml    | 5 +++++
>  .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml  | 5 +++++
>  .../bindings/arm/arm,coresight-dynamic-funnel.yaml           | 5 +++++
>  .../bindings/arm/arm,coresight-dynamic-replicator.yaml       | 5 +++++
>  .../devicetree/bindings/arm/arm,coresight-etb10.yaml         | 5 +++++
>  Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml | 5 +++++
>  .../devicetree/bindings/arm/arm,coresight-static-funnel.yaml | 5 +++++
>  .../bindings/arm/arm,coresight-static-replicator.yaml        | 5 +++++
>  Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml | 5 +++++
>  Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml | 5 +++++
>  .../devicetree/bindings/arm/arm,coresight-tpiu.yaml          | 5 +++++
>  .../devicetree/bindings/arm/qcom,coresight-tpda.yaml         | 5 +++++
>  .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml         | 5 +++++
>  16 files changed, 80 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml: device-name: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240115164252.26510-3-quic_jinlmao@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


