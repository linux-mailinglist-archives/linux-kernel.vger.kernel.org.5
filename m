Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0587EE004
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbjKPLnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:43:30 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C8CCE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:43:27 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so330685fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700135006; x=1700739806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu99ZgJ4o++Kc5jXeErXKR/5BDUaWqse/nPXLryIj8o=;
        b=y+sPBUq+mwlp0VuGsDOHKis090t9QwhmMjT7jeF0z1093yct26nffcP/gNavnP0zTg
         IsF/4HL6+FHqNZKfqgOeejdDGuUe98LheAu6nCM/txMwMLT+mEjQ4Z182SXx7VSXGCU9
         iiXPwgAUeJ7PAwrTSU5893fIMWIVCFqnXctlpcyO5LgmFIce6dpn0eEZtO4T1KFpI+YZ
         KJjplpz3RTHbLfU+PsbEyLEiJQKtrYoPj2Aj5g+k98WGe07J2BBsOH8y0kCWcpyQgncf
         R+dcmYXu48vY7XErq3RtPwzmDmJJ/CrhvqUPTS0RtnMr97iOXi5XIE4w/aZWSpAdtmFw
         sqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135006; x=1700739806;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu99ZgJ4o++Kc5jXeErXKR/5BDUaWqse/nPXLryIj8o=;
        b=NZPu0PEDdehgNR7lLdBuAXLtWCV3jgjIdzzVlDbLKkpyQU0PyvrL7kMJe/Q+PW5BYh
         9SPObPXT0kuym/MG2YN5hbTNYkbqc7pjvbgNR7Xxvbr+uv0CrdsLP9SFW3fiGPmXCIA2
         7ftf6j6u7FjeRRZFA2vYdUUtmzb8gfv/Bf1iMKcOSn/TBKzpJy3E01dNTF5nwbH13iSS
         JmPAinVH6uq309b2wB6Ic0ZqjnntDvalOiJldAHR0mbz35/fn36/uPHqMUI+QNTngANP
         A1H3yXAmAwn7DigP8y3TzvQyaibTNpV4SVSV7jKo2GUVfNYc+huTj4SSvz68eI1JMjvw
         u+Cw==
X-Gm-Message-State: AOJu0Yxz4mFelSuo3i3k2LJTJuCMsKM8L7wN4PPa4MBuVMC/xgIawQci
        HY/o8Qddrhx4yD7iIiz1y2LPuw==
X-Google-Smtp-Source: AGHT+IF1ny3sIjc3/bXjl6wUoDUuuue5gwzzHoBI3VTRCp1HhQk6S8ORtfEEtpMM6J+lbhMwV8Rjdw==
X-Received: by 2002:a05:6870:3c09:b0:1ea:406:4dff with SMTP id gk9-20020a0568703c0900b001ea04064dffmr19861258oab.50.1700135006354;
        Thu, 16 Nov 2023 03:43:26 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id az36-20020a05620a172400b0077580becd52sm4193397qkb.103.2023.11.16.03.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:43:25 -0800 (PST)
Message-ID: <832053f4-bd5d-4e58-81bb-1a8188e7f364@linaro.org>
Date:   Thu, 16 Nov 2023 12:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: iio: adc: Add QCOM PMIC5 Gen3 ADC
 bindings
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, daniel.lezcano@linaro.org,
        dmitry.baryshkov@linaro.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org
Cc:     lars@metafoo.de, luca@z3ntu.xyz, linux-iio@vger.kernel.org,
        lee@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, cros-qcom-dts-watchers@chromium.org,
        sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, kernel@quicinc.com
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
 <20231116032530.753192-2-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231116032530.753192-2-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 04:25, Jishnu Prakash wrote:
> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> 

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.

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
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 181 ++++++++++++++++--
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |  50 +++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |  89 +++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |  22 +++
>  .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |  56 ++++++
>  include/dt-bindings/iio/qcom,spmi-vadc.h      |  81 ++++++++
>  6 files changed, 464 insertions(+), 15 deletions(-)
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index ad7d6fc49de5..c988bd74a247 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -13,8 +13,10 @@ maintainers:
>  description: |
>    SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>    voltage. The VADC is a 15-bit sigma-delta ADC.
> -  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
> -  voltage. The VADC is a 16-bit sigma-delta ADC.
> +  SPMI PMIC5/PMIC7/PMIC5 Gen3 voltage ADC (ADC) provides interface to
> +  clients to read voltage. The VADC is a 16-bit sigma-delta ADC.
> +  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
> +  it can be considered like PMIC5 Gen2.
>  
>  properties:
>    compatible:
> @@ -23,14 +25,18 @@ properties:
>            - const: qcom,pms405-adc
>            - const: qcom,spmi-adc-rev2
>        - enum:
> -          - qcom,spmi-vadc
> -          - qcom,spmi-adc5
>            - qcom,spmi-adc-rev2
> +          - qcom,spmi-adc5
> +          - qcom,spmi-adc5-gen3
>            - qcom,spmi-adc7
> +          - qcom,spmi-vadc
>  
>    reg:
> -    description: VADC base address in the SPMI PMIC register map
> -    maxItems: 1

NAK.

I wrote it multiple times. You canno remove the widest constraints from
top-level property.

> +    description: |
> +      - For compatible properties "qcom,spmi-vadc", "qcom,spmi-adc5", "qcom,spmi-adc-rev2"
> +        and "qcom,spmi-adc7", reg is the VADC base address in the SPMI PMIC register map.
> +      - For compatible property "qcom,spmi-adc5-gen3", each reg corresponds
> +        to an SDAM peripheral base address that is being used for ADC.
>  
>    '#address-cells':
>      const: 1
> @@ -38,13 +44,26 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description:
> +      Number of cells required to uniquely identify the thermal sensors. Since
> +      we have multiple sensors this is set to 1. For compatible property
> +      "qcom,spmi-adc5-gen3", this property is required for ADC_TM device.
> +
>    '#io-channel-cells':
>      const: 1
>  
>    interrupts:
> -    maxItems: 1

No, srsly. We went through it.


> -    description:
> +    description: |
>        End of conversion interrupt.
> +      - For compatible property "qcom,spmi-adc5-gen3", interrupts are defined
> +        for each SDAM being used.
> +
> +  interrupt-names:
> +    description: |

You must describe the names which also provides constraints.

I am not going to review the rest of the file.

Best regards,
Krzysztof

