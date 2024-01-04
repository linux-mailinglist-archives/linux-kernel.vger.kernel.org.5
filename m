Return-Path: <linux-kernel+bounces-16359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634FB823D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D436282112
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552DF20312;
	Thu,  4 Jan 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s79CD9AI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A52200CA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55559e26ccfso304142a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704356298; x=1704961098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dB7KlwPu8jFEnkEUgQ3E4kmYgKubPfVf4FWbv50f30E=;
        b=s79CD9AIFkXHX4KPpUOrXo9EkrrPkmluTi7Lmal6xYP/76UJ/VbqTU2/bl70Ha8H0R
         3T9wdRP6ekm+n5G7Swh459BNGj8bb1kXv7eJK51LpUDFhYWtCcpyCDjNeqOr6dS6ea7p
         2tVqqN2RD0jReCv7VTRafVKnpYGNWlYhMslc5ilIt96B0KrSWD1V8uL0ifl/OQaBdXcK
         tE7/WT2EXraT2sNND6Wkn+qeg8DJdjsd0ffYZ6gjsMc8jzhr175oP+nGDTFor2kpDU13
         MIesr66TPXgmPsNTKA7mqWXhiDS8Xku0LH3u6ctCg2664Gt04mNv50kEUNxnPk+nwyU5
         O9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704356298; x=1704961098;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dB7KlwPu8jFEnkEUgQ3E4kmYgKubPfVf4FWbv50f30E=;
        b=MwE2JdJ5XpHviquCt46UfBU98/jZh17M9/3bvSxDJ/sAHMp7uqHSOKsQCrKUTQGOze
         fMPsMe66jo0M+HxmHHS2nyLG4Hf3j8dk7aAXorqdL7BsrEGtNOhTX1SUUnV/wiHAgiO9
         9VUrW0RF4hsaPejeVCdyCCDcbilwF/Kj0oRNahIBD0P5ax+D5e7i6zfRPhtZG3KVdyz3
         il/JCzaFUemO+y6asihQP0AY2uu7FoXnJjwbibZDp03aOzpKRPdkeCludijO1iENS+OW
         YiZlZ/cdCbHcTtRqBF2noA4Qfr2Ntmf8/P6XPsq2MT9ByKGt93FF/4oSlbK1Rx8DZhL9
         2ntQ==
X-Gm-Message-State: AOJu0YzCBMXacAgtc17nUiQ16g0V4ywhoRvfgjhiqra/W47Kqv/978h2
	Zx6S2VkmbMMQWasP2IdVvvi9KpgcF/eHgw==
X-Google-Smtp-Source: AGHT+IGWca1NaFiW8xveKmlGf79gPIaG2GaxJ31bGT9PN23hq7lmhBvkJqFkg8GuyyfBN5zhL96DZg==
X-Received: by 2002:a17:906:2215:b0:a26:d9ad:3106 with SMTP id s21-20020a170906221500b00a26d9ad3106mr96627ejs.9.1704356298406;
        Thu, 04 Jan 2024 00:18:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id pv8-20020a170907208800b00a281f3024bdsm3040698ejb.144.2024.01.04.00.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:18:18 -0800 (PST)
Message-ID: <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
Date: Thu, 4 Jan 2024 09:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Content-Language: en-US
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org,
 dmitry.baryshkov@linaro.org
Cc: lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org,
 agross@kernel.org, sboyd@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linus.walleij@linaro.org, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
 quic_kamalw@quicinc.com, kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231231171237.3322376-3-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/2023 18:12, Jishnu Prakash wrote:
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

Changelog goes under ---.

Why did you do this? What is the rationale? Sorry, this patchset goes
nowhere.

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

Do not need '|' unless you need to preserve formatting.

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

Missing constraints, weird formatting and not wrapped according to
coding style (read Linux coding style).

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

Same problemns.

You already got comments on this in v2.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 10
> +    items:
> +      pattern: "^adc-sdam[0-9]+$"
> +    description: |
> +      Names should be defined as "adc-sdam<N>" where <N> represents the SDAM index.

Don't repeat constraints in free form text.

> +
> +required:

required: goes after all properties.

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

Do not need '|' unless you need to preserve formatting.

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

Why do you need it in the first place? Don't you miss some $ref?

> +        description: |

Do not need '|' unless you need to preserve formatting. Applies everywhere.



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

Why do you duplicate entire vadc file? Why it cannot be part of that
file? Oh wait, it was in v2.

You now duplicated a lot of property definitions without clear reason.
If this is intention, then you need to put them in common schema.


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

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Really, duplicating entire file and adding mistakes? Just open the
original file which you changed in v2 and look how it is done there.

> +        compatible = "qcom,spmi-adc5-gen3";
> +        reg = <0x9000>, <0x9100>;
> +        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
> +                <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;

wrong alignment.

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
> +#define PM8550_SID		1
> +#endif

Drop

> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
> +#define PM8550_ADC5_GEN3_REF_GND			(PM8550_SID << 8 | ADC5_GEN3_REF_GND)
> +#define PM8550_ADC5_GEN3_1P25VREF			(PM8550_SID << 8 | ADC5_GEN3_1P25VREF)
> +#define PM8550_ADC5_GEN3_VREF_VADC			(PM8550_SID << 8 | ADC5_GEN3_VREF_VADC)
> +#define PM8550_ADC5_GEN3_DIE_TEMP			(PM8550_SID << 8 | ADC5_GEN3_DIE_TEMP)
> +
> +#define PM8550_ADC5_GEN3_AMUX_THM1			(PM8550_SID << 8 | ADC5_GEN3_AMUX1_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM2			(PM8550_SID << 8 | ADC5_GEN3_AMUX2_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM3			(PM8550_SID << 8 | ADC5_GEN3_AMUX3_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM4			(PM8550_SID << 8 | ADC5_GEN3_AMUX4_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM5			(PM8550_SID << 8 | ADC5_GEN3_AMUX5_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2		(PM8550_SID << 8 | ADC5_GEN3_AMUX6_THM)
> +#define PM8550_ADC5_GEN3_AMUX1_GPIO3			(PM8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO)
> +#define PM8550_ADC5_GEN3_AMUX2_GPIO4			(PM8550_SID << 8 | ADC5_GEN3_AMUX2_GPIO)
> +#define PM8550_ADC5_GEN3_AMUX3_GPIO7			(PM8550_SID << 8 | ADC5_GEN3_AMUX3_GPIO)
> +#define PM8550_ADC5_GEN3_AMUX4_GPIO12			(PM8550_SID << 8 | ADC5_GEN3_AMUX4_GPIO)
> +
> +/* 100k pull-up */
> +#define PM8550_ADC5_GEN3_AMUX_THM1_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM2_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM3_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM4_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM5_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2_100K_PU	(PM8550_SID << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX1_GPIO3_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX2_GPIO4_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX3_GPIO7_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX4_GPIO12_100K_PU		(PM8550_SID << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
> +
> +/* 1/3 Divider */
> +#define PM8550_ADC5_GEN3_AMUX3_GPIO7_DIV3		(PM8550_SID << 8 | ADC5_GEN3_AMUX3_GPIO_DIV3)
> +#define PM8550_ADC5_GEN3_AMUX4_GPIO12_DIV3		(PM8550_SID << 8 | ADC5_GEN3_AMUX4_GPIO_DIV3)
> +
> +#define PM8550_ADC5_GEN3_VPH_PWR			(PM8550_SID << 8 | ADC5_GEN3_VPH_PWR)
> +
> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H */
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
> new file mode 100644
> index 000000000000..47116bbe45de
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
> +
> +#ifndef PM8550B_SID
> +#define PM8550B_SID		7

Drop

> +#endif
> +

...

> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H */
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
> new file mode 100644
> index 000000000000..3fc829ebdf6d
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
> +
> +#ifndef PMK8550_SID
> +#define PMK8550_SID		0
> +#endif

Drop

>  
>  /* ADC channels for PMR735B_ADC for PMIC7 */
>  #define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | ADC7_REF_GND)
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
> index c0680d1285cf..750a526af2c1 100644
> --- a/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
> @@ -6,7 +6,7 @@
>  #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
>  #define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>

? How is it related?

>  
>  #define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
>  #define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> index ef07ecd4d585..cfe653d945a4 100644
> --- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> @@ -1,6 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
> + *

Drop stray blank line

Best regards,
Krzysztof


