Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0446879261D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbjIEQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353636AbjIEG7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:59:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D11ECC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:59:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so3044384a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693897181; x=1694501981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrNPDmoDml6ewedsTVmufnMzTpEiM1aVD/7pamw5cy0=;
        b=CiTImDm8bxsB0BLttDcrTGg4O0Klu1frvTzKlWCWwZ0ITft2L5RRbKpWf4pxKZ0tcE
         Nq1PLic4fW+fPYbHlfKheFUzc4nUygsmvu17EgMzxQDX3wrZMUCduXHGC5nXRlO/tHT3
         kkj3H7c1PkeBSybgRyoBE9Ogwf8iz+CtRR/ur9t/fEQS77t2c9CMjbbpnAbmyxuVs2OV
         60K969ou9ukHni8tLa7vwBHIfzlefihpwEysQR5cfOO2U5/5qrXfXJNf3nTESXCbG66z
         Wb5NDlB7hnudwuabpwgDmUg8xKEWw8lceki4TkRDVU0VykAeZtPRbLLFMdambVYWMnb9
         Akow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897181; x=1694501981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrNPDmoDml6ewedsTVmufnMzTpEiM1aVD/7pamw5cy0=;
        b=BkR5rCu+RkRcB7lSWE2CyEit5MadSVf0R+AgpB+e1xae4SNkJq7PC9G64TWUOhBrtA
         DhhVtXsd7pOxe9nMAqTc9+v3SCC4Qjj2e5pgbqCoSW6kAjSv1YvVpZt78oXGmSEECrb8
         iWPTGk1YKLiUR9RD9yoiv7BHi4us5EvYszomDEqxtB59yuprFtbZ/FrbQ7ZBqIneLFTx
         I1CBSQj1ARpPQc1wkjvZ7iPtpwzpf7m9UOqc6UZXckMqSWaSM0eElpElwMMB0IJezPCE
         wCEzpLbb1p1+kbk8aiA0octJ20hDKYfoBzYnD9KZcepYDgUntVROggTNk2si1empSmev
         Unow==
X-Gm-Message-State: AOJu0YweXNPULN6kmmdGzZf7SCll203kLbmAeMDVPt43t+zApYyVl/uq
        4uLPaXEwkjxdNhtIUCZ/tUzCdQ==
X-Google-Smtp-Source: AGHT+IGesTQJgs+z4nRuVPWyMq2OEnKeRGOp/g7gWt/KdczzMAHmZ5xYUUJhLYCqvpdwwZVeh/f2KQ==
X-Received: by 2002:a50:ee92:0:b0:52a:3ee9:a78a with SMTP id f18-20020a50ee92000000b0052a3ee9a78amr9260429edr.26.1693897181567;
        Mon, 04 Sep 2023 23:59:41 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id m21-20020aa7c495000000b005233deb30aesm6719419edq.10.2023.09.04.23.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 23:59:40 -0700 (PDT)
Message-ID: <c19e0ecf-7e8c-b9c3-0741-40c7aa3cb200@linaro.org>
Date:   Tue, 5 Sep 2023 08:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add compatibles for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
References: <1693889975-19122-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889975-19122-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693889975-19122-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 06:59, Rohit Agarwal wrote:
> Add dt-bindings compatibles and interconnect IDs for
> Qualcomm SDX75 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  .../bindings/interconnect/qcom,sdx75-rpmh.yaml     | 100 ++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,sdx75.h      | 102 +++++++++++++++++++++
>  2 files changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
> new file mode 100644
> index 0000000..f2dc87c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sdx75-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SDX75
> +
> +maintainers:
> +  - Georgi Djakov <djakov@kernel.org>

I don't think Georgi maintains this device. It's maintainer of device,
not the subsystem.

> +
> +description:
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
> +  associated with each execution environment. Provider nodes must point to at
> +  least one RPMh device child node pertaining to their RSC and each provider
> +  can map to multiple RPMh resources.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sdx75-clk-virt
> +      - qcom,sdx75-dc-noc
> +      - qcom,sdx75-gem-noc
> +      - qcom,sdx75-mc-virt
> +      - qcom,sdx75-pcie-anoc
> +      - qcom,sdx75-system-noc
> +
> +  '#interconnect-cells': true'
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdx75-clk-virt
> +              - qcom,sdx75-mc-virt
> +    then:
> +      properties:
> +        reg: false
> +    else:
> +      required:
> +        - reg
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdx75-clk-virt
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RPMH CC QPIC Clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdx75-clk-virt

This if: clause should be merged with the one earlier.

> +    then:
> +      required:
> +        - clocks
> +    else:
> +      properties:
> +        clocks: false
> +
> +required:
> +  - compatible

Please keep the order like in example-schema, so required: goes before
allOf.

> +
> +unevaluatedProperties: false

Best regards,
Krzysztof

