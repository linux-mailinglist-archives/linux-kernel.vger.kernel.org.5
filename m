Return-Path: <linux-kernel+bounces-13764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528B820C3D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EDF1F21B06
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70D4944B;
	Sun, 31 Dec 2023 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sAEmguOe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E683944E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ebca94cf74so41999577b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704044494; x=1704649294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao4Br94AeB95BZ0uQIQjZIW3d0GZTrmEnybNbbCcSMQ=;
        b=sAEmguOeuQgZHpfB96kgLUMPzKQL8lvoxYvkCL/6Zo8j/6tDhftsuIyjsjggCe6+uo
         ac6etYS3+NIxdry8iATp9RF4ikOCEqlyGVZGdMc1xsTxioK+nVMSonAF3zBJ3h6dJewi
         Yw53L4rLX+6AN38T/hcfdY1KNLl/zU09gxNYOtCV3/RfLYsMnmngJX4X0r1YADs/J1EU
         J7adgnNygtSSXRAbhjHsVcqeuIPXHG6d0645dwFCJKB+xDXTgZgIQmYZjZWN/YKAZeWw
         s39mGCWhL7yRJn1apBpECCaIyLfSzaTl0YeW4ff9JjquwAvi+hXVCS6UfqkKhpEkiWMW
         C7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704044494; x=1704649294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ao4Br94AeB95BZ0uQIQjZIW3d0GZTrmEnybNbbCcSMQ=;
        b=NozBFuwznxUrtSmr5sd9Wzkzq4h1VN5+ZBuxsI38KfScuH6kNtuOFifQ0ssBl3IWEc
         lfhlr47zAe71gs2c+HoRITKpzccYQSB79wf2+emaTezkBky8WktE8RUcydKFKaWUEoVj
         cMTccPhKk5N3RiHIhs5d842n0YA3HF/zK2EfiBaX80ck318D2AiSBsHsH3Tr387xhvfr
         z4UqqROi2/Uc6f8NVBwGOdfuToRujygLhSK8x+6ResRjczgedP5AuJWpNuYp6u4trIPf
         bcPwv31GVEj7Nv/q21PYBU2AcPThz7ig+/ce5Ol5R8+/MdoNRAa8HSXh3icMP96frLx/
         dIoA==
X-Gm-Message-State: AOJu0YyLfNFP8mY/Y3VOybeOiQ6W47cY0hFNydhOZnLBJiti2nqbiX6Y
	ML3E5T1mox5yClABt3TLkCCgZJr3gvvig8jg2DkDG3JrPU+HYw==
X-Google-Smtp-Source: AGHT+IELodskFBsCKWBW+wtbAPXlVuNvQ4jxxeLzcVjCJDd/AEHC6uG41blhYtYnKq6RNWxWzKLOnkzxH/cn3Q9m0i0=
X-Received: by 2002:a81:8782:0:b0:5e7:c844:da74 with SMTP id
 x124-20020a818782000000b005e7c844da74mr9656115ywf.23.1704044494416; Sun, 31
 Dec 2023 09:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com> <20231231171237.3322376-3-quic_jprakash@quicinc.com>
In-Reply-To: <20231231171237.3322376-3-quic_jprakash@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Dec 2023 19:41:23 +0200
Message-ID: <CAA8EJprGSwa=MmpTYJ_U9BsdrjZaA2iTwFM7ZyMUraDHxHA6zQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	lee@kernel.org, andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org, 
	lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org, 
	agross@kernel.org, sboyd@kernel.org, rafael@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linus.walleij@linaro.org, quic_subbaram@quicinc.com, 
	quic_collinsd@quicinc.com, quic_amelende@quicinc.com, quic_kamalw@quicinc.com, 
	kernel@quicinc.com, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 Dec 2023 at 19:13, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS(Programmable Boot Sequence) firmware through a single
> register interface. This interface is implemented on an SDAM (Shared
> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
> than a dedicated ADC peripheral.
>
> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
> channels and virtual channels (combination of ADC channel number and
> PMIC SID number) per PMIC, to be used by clients of this device.
>
> Changes since v2:
> - Moved ADC5 Gen3 documentation into a separate new file.
>
> Changes since v1:
> - Updated properties separately for all compatibles to clarify usage
>   of new properties and updates in usage of old properties for ADC5 Gen3.
> - Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
>   mentioning this convention.
> - Used predefined channel IDs in individual PMIC channel definitions
>   instead of numeric IDs.
> - Addressed other comments from reviewers.
>
> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 212 ++++++++++++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |  50 +++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |  89 ++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |  22 ++
>  .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |  56 +++++
>  .../iio/adc/qcom,spmi-adc7-pmr735b.h          |   2 +-
>  .../iio/adc/qcom,spmi-adc7-smb139x.h          |   2 +-
>  include/dt-bindings/iio/adc/qcom,spmi-vadc.h  |  81 +++++++
>  8 files changed, 512 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> new file mode 100644
> index 000000000000..ed5bb53e7628
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> @@ -0,0 +1,212 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC ADC5 Gen3
> +
> +maintainers:
> +  - Jishnu Prakash <quic_jprakash@quicinc.com>
> +
> +description: |
> +  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to
> +  clients to read voltage. It is a 16-bit sigma-delta ADC.
> +  It also performs the same thermal monitoring function as
> +  the existing ADC_TM devices.
> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-adc5-gen3
> +
> +  reg:
> +    description: |
> +      - Each reg corresponds to an SDAM peripheral base address that is being used for ADC.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description:
> +      Number of cells required to uniquely identify the thermal sensors. Since
> +      we have multiple sensors this is set to 1. This property is required for
> +      ADC devices with channels used for TM (thermal monitoring) functionality.
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  interrupts:
> +    description: |
> +      End of conversion interrupt. Interrupts are defined for each SDAM being used.
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 10
> +    items:
> +      pattern: "^adc-sdam[0-9]+$"
> +    description: |
> +      Names should be defined as "adc-sdam<N>" where <N> represents the SDAM index.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#io-channel-cells'
> +  - interrupts
> +  - interrupt-names
> +
> +patternProperties:
> +  "^channel@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: |
> +          ADC channel number.
> +          See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> +          For PMIC5 Gen3 ADC, the channel numbers are specified separately
> +          per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
> +
> +      label:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: |
> +            ADC input of the platform as seen in the schematics.
> +            For thermistor inputs connected to generic AMUX or GPIO inputs
> +            these can vary across platform for the same pins. Hence select
> +            the platform schematics name for this channel.
> +
> +      qcom,decimation:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +            This parameter is used to decrease ADC sampling rate.
> +            Quicker measurements can be made by reducing decimation ratio.
> +        enum: [ 85, 340, 1360 ]
> +        default: 1360
> +
> +      qcom,pre-scaling:
> +        description: |
> +            Used for scaling the channel input signal before the signal is
> +            fed to VADC. The configuration for this node is to know the
> +            pre-determined ratio and use it for post scaling. It is a pair of
> +            integers, denoting the numerator and denominator of the fraction by which
> +            input signal is multiplied. For example, <1 3> indicates the signal is scaled
> +            down to 1/3 of its value before ADC measurement.
> +            If property is not found default value depending on chip will be used.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          - const: 1
> +          - enum: [ 1, 3, 6, 16 ]
> +
> +      qcom,ratiometric:
> +        description: |
> +            Channel calibration type.
> +            - If this property is specified VADC will use the VDD reference (1.875V)
> +              and GND for channel calibration. If property is not found, channel will be
> +              calibrated with 0V and 1.25V reference channels, also known as
> +              absolute calibration.
> +        type: boolean
> +
> +      qcom,hw-settle-time:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +            Time between AMUX getting configured and the ADC starting
> +            conversion. The 'hw_settle_time' is an index used from valid values
> +            and programmed in hardware to achieve the hardware settling delay.
> +        enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
> +                8000, 16000, 32000, 64000, 128000 ]
> +        default: 15
> +
> +      qcom,avg-samples:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +            Number of samples to be used for measurement.
> +            Averaging provides the option to obtain a single measurement
> +            from the ADC that is an average of multiple samples. The value
> +            selected is 2^(value).
> +        enum: [ 1, 2, 4, 8, 16 ]
> +        default: 1
> +
> +      qcom,adc-tm:
> +        description: |
> +            Indicates if ADC_TM monitoring is done on this channel.
> +            Defined for compatible property "qcom,spmi-adc5-gen3".
> +            This is the same functionality as in the existing QCOM ADC_TM
> +            device, documented at devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      /* VADC node */
> +      pmk8550_vadc: vadc@9000 {
> +        compatible = "qcom,spmi-adc5-gen3";
> +        reg = <0x9000>, <0x9100>;
> +        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
> +                <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "adc-sdam0", "adc-sdam1";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #io-channel-cells = <1>;
> +        #thermal-sensor-cells = <1>;
> +
> +        /* PMK8550 Channel nodes */
> +        channel@3 {
> +          reg = <PMK8550_ADC5_GEN3_DIE_TEMP>;
> +          label = "pmk8550_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +
> +        channel@44 {
> +          reg = <PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU>;
> +          label = "pmk8550_xo_therm";
> +          qcom,pre-scaling = <1 1>;
> +          qcom,ratiometric;
> +          qcom,hw-settle-time = <200>;
> +          qcom,adc-tm;
> +        };
> +
> +        /* PM8550 Channel nodes */
> +        channel@103 {
> +          reg = <PM8550_ADC5_GEN3_DIE_TEMP>;
> +          label = "pm8550_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +
> +        /* PM8550B Channel nodes */
> +        channel@78f {
> +          reg = <PM8550B_ADC5_GEN3_VBAT_SNS_QBG>;
> +          label = "pm8550b_vbat_sns_qbg";
> +          qcom,pre-scaling = <1 3>;
> +        };
> +
> +        /* PM8550VS_C Channel nodes */
> +        channel@203 {
> +          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
> +          label = "pm8550vs_c_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +      };
> +    };
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
> new file mode 100644
> index 000000000000..0f25ef87ed5c
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
> +
> +#ifndef PM8550_SID
> +#define PM8550_SID             1
> +#endif

Please drop these defaults.
We should drop them from the existing binding files too...

> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>

-- 
With best wishes
Dmitry

