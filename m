Return-Path: <linux-kernel+bounces-22165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A3D829A59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C2F1C2221F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEE482E1;
	Wed, 10 Jan 2024 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyXo8YZc"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B085A482C1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd5c55d6b8so31164021fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 04:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704889365; x=1705494165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gv8ChbCx3nZ3IpTPDQn3bgHlvJDlDz1Uz1H3jLH3TfY=;
        b=qyXo8YZcfQiUCq1zp2vSHcCP5x4TaMawlghFxIMjMxVUeJ2c71KVOzBO1fyjc1cOOY
         mCiIjPpJcF5d2skMlgUh7BAJh4dyeKS00aa0T0MQo0Tg9UXntICJN8YequmsjpMXH4l9
         RwaziaguTc5pl+n/YvlC+RblFIcJ6e5y2ZrC9kl4pnegS65FjYTuXbjq51IRxCcLq89T
         n25nwtg7UdGgFG+ch6obL7iTjO1jQed1GbJtGSMkz3GGnt+xAaVw7Xfpby+Ken987uYc
         qq5n/g5TJBldzxGjhvS1z+FQKRIGRvtbJ66wtKHYZ0e2hxyJQCbbfDHylbLf9Oin4ywC
         ewjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704889365; x=1705494165;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv8ChbCx3nZ3IpTPDQn3bgHlvJDlDz1Uz1H3jLH3TfY=;
        b=RNwl6dwno8Z2yYLtFQU1N0zTsNWAconzOZmPMb+qe3U0QOilJsRqk+22ZUC9YSeKZs
         A7YtZ2q3e553HVQ1iV/pGhe0ObKf7XoFOxxdjUQED0zomiPOwZvLG/GNBMkucDsV8Iy0
         ee+y9BWsiUbD0qXJ9nZfOHZdR8ywOh5VKRU953jU/rj1Lv4X8U170IcUg4bEHyRKgh3x
         SBl6KACzOX6kzMABAGWIPF4LZMkqDhDiFHqNm6O+Uf7uJDqglYUlhrhoDhP0KfeND+5l
         KZPY2WO7q7UKq4efmqCD8FBw3/xSl3lOPGxRPBT4nfBGpRowGmCiIuGng+zQRVS2tdhn
         aQgQ==
X-Gm-Message-State: AOJu0Ywjs6WwsQJ54wDcNR1mc/YUgtBxm7RRhvjIJlN18pYDNSdtPwbP
	vqnZcBGe7E3XiV78IBmFruOAGHRwkcPspQ==
X-Google-Smtp-Source: AGHT+IFnHD3/qxD2lf/iPpepy6B+iOGMcSp2dTS/IauOHAT4aOELl4cpFXvF2XNb/Z6CjvKK8+fIeA==
X-Received: by 2002:a2e:964f:0:b0:2cd:6402:1f03 with SMTP id z15-20020a2e964f000000b002cd64021f03mr351906ljh.24.1704889364680;
        Wed, 10 Jan 2024 04:22:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id e1-20020a056000120100b00333404e9935sm4765719wrx.54.2024.01.10.04.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 04:22:44 -0800 (PST)
Message-ID: <1d1116da-9af3-49e4-a180-cff721df5df5@linaro.org>
Date: Wed, 10 Jan 2024 13:22:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/20] dt-bindings: net: qcom,ppe: Add bindings
 yaml file
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
 linux@armlinux.org.uk, shannon.nelson@amd.com, anthony.l.nguyen@intel.com,
 jasowang@redhat.com, brett.creeley@amd.com, rrameshbabu@nvidia.com,
 joshua.a.hay@intel.com, arnd@arndb.de, geert+renesas@glider.be,
 neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
 nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
 jacob.e.keller@intel.com, andrew@lunn.ch
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ryazanov.s.a@gmail.com, ansuelsmth@gmail.com, quic_kkumarcs@quicinc.com,
 quic_suruchia@quicinc.com, quic_soni@quicinc.com, quic_pavir@quicinc.com,
 quic_souravp@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-3-quic_luoj@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240110114033.32575-3-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 12:40, Luo Jie wrote:
> Qualcomm PPE(packet process engine) is supported on
> IPQ SOC platform.
> 

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Basically your subject has only prefix and nothing else useful.

Limited review follows, I am not wasting my time much on this.

> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../devicetree/bindings/net/qcom,ppe.yaml     | 1330 +++++++++++++++++
>  1 file changed, 1330 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ppe.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ppe.yaml
> new file mode 100644
> index 000000000000..6afb2ad62707
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,ppe.yaml
> @@ -0,0 +1,1330 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qcom,ppe.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Packet Process Engine Ethernet controller

Where is the ref to ethernet controllers schema?

> +
> +maintainers:
> +  - Luo Jie <quic_luoj@quicinc.com>
> +
> +description:
> +  The PPE(packet process engine) is comprised of three componets, Ethernet
> +  DMA, Switch core and Port wrapper, Ethernet DMA is used to transmit and
> +  receive packets between Ethernet subsytem and host. The Switch core has
> +  maximum 8 ports(maximum 6 front panel ports and two FIFO interfaces),
> +  among which there are GMAC/XGMACs used as external interfaces and FIFO
> +  interfaces connected the EDMA/EIP, The port wrapper provides connections
> +  from the GMAC/XGMACS to SGMII/QSGMII/PSGMII/USXGMII/10G-BASER etc, there
> +  are maximu 3 UNIPHY(PCS) instances supported by PPE.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5332-ppe
> +      - qcom,ipq9574-ppe
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +  clocks: true

These cannot be true, we expect here widest constraints.

> +
> +  clock-names: true
> +
> +  resets: true
> +
> +  reset-names: true
> +
> +  tdm-config:
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      PPE TDM(time-division multiplexing) config includes buffer management
> +      and port scheduler.
> +
> +    properties:
> +      qcom,tdm-bm-config:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          The TDM buffer scheduler configs of PPE, there are multiple
> +          entries supported, each entry includes valid, direction
> +          (ingress or egress), port, second port valid, second port.
> +
> +      qcom,tdm-port-scheduler-config:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          The TDM port scheduler management configs of PPE, there
> +          are multiple entries supported each entry includes ingress
> +          scheduler port bitmap, ingress scheduler port, egress
> +          scheduler port, second egress scheduler port valid and
> +          second egress scheduler port.
> +
> +    required:
> +      - qcom,tdm-bm-config
> +      - qcom,tdm-port-scheduler-config
> +
> +  buffer-management-config:
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      PPE buffer management config, which supports configuring group
> +      buffer and per port buffer, which decides the threshold of the
> +      flow control frame generated.
> +

I don't understand this sentence. Rephrase it to proper sentence and
proper hardware, not driver, description.

> +    properties:
> +      qcom,group-config:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          The PPE buffer support 4 groups, the entry includes
> +          the group ID and group buffer numbers, each buffer
> +          has 256 bytes.

Missing constraints, like min/max and number of items.

> +
> +      qcom,port-config:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          The PPE buffer number is also assigned per BM port ID,
> +          there are 10 BM ports supported on ipq5332, and 15 BM
> +          ports supported on ipq9574. Each entry includs group
> +          ID, BM port ID, dedicated buffer, the buffer numbers
> +          for receiving packet after pause frame sent, the
> +          threshold for pause frame, weight, restore ceil and
> +          dynamic buffer or static buffer management.
> +
> +    required:
> +      - qcom,group-config
> +      - qcom,port-config
> +
> +  queue-management-config:
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      PPE queue management config, which supports configuring group
> +      and per queue buffer limitation, which decides the threshold
> +      to drop the packet on the egress port.
> +
> +    properties:
> +      qcom,group-config:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          The PPE queue management support 4 groups, the entry
> +          includes the group ID, group buffer number, dedicated
> +          buffer number, threshold to drop packet and restore
> +          ceil.
> +
> +      qcom,queue-config:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          PPE has 256 unicast queues and 44 multicast queues, the
> +          entry includes queue base, queue number, group ID,
> +          dedicated buffer, the threshold to drop packet, weight,
> +          restore ceil and dynamic or static queue management.
> +
> +    required:
> +      - qcom,group-config
> +      - qcom,queue-config
> +
> +  port-scheduler-resource:
> +    type: object
> +    additionalProperties: false
> +    description: The scheduler resource available in PPE.
> +    patternProperties:
> +      "^port[0-7]$":

port-

> +        description: Each subnode represents the scheduler resource per port.
> +        type: object
> +        properties:
> +          port-id:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: |

Do not need '|' unless you need to preserve formatting. This applies
everywhere.

> +              The PPE port ID, there are maximum 6 physical port,
> +              EIP port and CPU port.

Your node  name suffix says 8 ports. Anyway, missing min/max.

All these nodes (before, here and further) looks like dump of vendor code.

I expect some good explanation why we should accept this. Commit msg you
wrote is meaningless. It literally brings zero information about hardware.

You have been asked to provide accurate hardware description yet you
keep ignoring people's feedback.
..

> +
> +patternProperties:


phy@

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +  "^qcom-uniphy@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +    description: uniphy configuration and clock provider
> +    properties:
> +      reg:
> +        minItems: 2
> +        items:
> +          - description: The first uniphy register range
> +          - description: The second uniphy register range
> +          - description: The third uniphy register range

first, second and third are really useless descriptions. We expect
something useful.

> +
> +      "#clock-cells":
> +        const: 1
> +
> +      clock-output-names:
> +        minItems: 4
> +        maxItems: 6
> +
> +    required:
> +      - reg
> +      - "#clock-cells"
> +      - clock-output-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,ipq5332-ppe
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Display common AHB clock from gcc
> +            - description: Display common system clock from gcc
> +            - description: Display uniphy0 AHB clock from gcc
> +            - description: Display uniphy1 AHB clock from gcc
> +            - description: Display uniphy0 system clock from gcc
> +            - description: Display uniphy1 system clock from gcc
> +            - description: Display nss clock from gcc
> +            - description: Display nss noc snoc clock from gcc
> +            - description: Display nss noc snoc_1 clock from gcc
> +            - description: Display sleep clock from gcc
> +            - description: Display PPE clock from nsscc
> +            - description: Display PPE config clock from nsscc
> +            - description: Display NSSNOC PPE clock from nsscc
> +            - description: Display NSSNOC PPE config clock from nsscc
> +            - description: Display EDMA clock from nsscc
> +            - description: Display EDMA config clock from nsscc
> +            - description: Display PPE IPE clock from nsscc
> +            - description: Display PPE BTQ clock from nsscc
> +            - description: Display port1 MAC clock from nsscc
> +            - description: Display port2 MAC clock from nsscc
> +            - description: Display port1 RX clock from nsscc
> +            - description: Display port1 TX clock from nsscc
> +            - description: Display port2 RX clock from nsscc
> +            - description: Display port2 TX clock from nsscc
> +            - description: Display UNIPHY port1 RX clock from nsscc
> +            - description: Display UNIPHY port1 TX clock from nsscc
> +            - description: Display UNIPHY port2 RX clock from nsscc
> +            - description: Display UNIPHY port2 TX clock from nsscc
> +        clock-names:
> +          items:
> +            - const: cmn_ahb
> +            - const: cmn_sys
> +            - const: uniphy0_ahb
> +            - const: uniphy1_ahb
> +            - const: uniphy0_sys
> +            - const: uniphy1_sys
> +            - const: gcc_nsscc
> +            - const: gcc_nssnoc_snoc
> +            - const: gcc_nssnoc_snoc_1
> +            - const: gcc_im_sleep
> +            - const: nss_ppe
> +            - const: nss_ppe_cfg
> +            - const: nssnoc_ppe
> +            - const: nssnoc_ppe_cfg
> +            - const: nss_edma
> +            - const: nss_edma_cfg
> +            - const: nss_ppe_ipe
> +            - const: nss_ppe_btq
> +            - const: port1_mac
> +            - const: port2_mac
> +            - const: nss_port1_rx
> +            - const: nss_port1_tx
> +            - const: nss_port2_rx
> +            - const: nss_port2_tx
> +            - const: uniphy_port1_rx
> +            - const: uniphy_port1_tx
> +            - const: uniphy_port2_rx
> +            - const: uniphy_port2_tx
> +
> +        resets:
> +          items:
> +            - description: Reset PPE
> +            - description: Reset uniphy0 software config
> +            - description: Reset uniphy1 software config
> +            - description: Reset uniphy0 AHB
> +            - description: Reset uniphy1 AHB
> +            - description: Reset uniphy0 system
> +            - description: Reset uniphy1 system
> +            - description: Reset uniphy0 XPCS
> +            - description: Reset uniphy1 SPCS
> +            - description: Reset uniphy port1 RX
> +            - description: Reset uniphy port1 TX
> +            - description: Reset uniphy port2 RX
> +            - description: Reset uniphy port2 TX
> +            - description: Reset PPE port1 RX
> +            - description: Reset PPE port1 TX
> +            - description: Reset PPE port2 RX
> +            - description: Reset PPE port2 TX
> +            - description: Reset PPE port1 MAC
> +            - description: Reset PPE port2 MAC
> +
> +        reset-names:
> +          items:
> +            - const: ppe
> +            - const: uniphy0_soft
> +            - const: uniphy1_soft
> +            - const: uniphy0_ahb
> +            - const: uniphy1_ahb
> +            - const: uniphy0_sys
> +            - const: uniphy1_sys
> +            - const: uniphy0_xpcs
> +            - const: uniphy1_xpcs
> +            - const: uniphy_port1_rx
> +            - const: uniphy_port1_tx
> +            - const: uniphy_port2_rx
> +            - const: uniphy_port2_tx
> +            - const: nss_port1_rx
> +            - const: nss_port1_tx
> +            - const: nss_port2_rx
> +            - const: nss_port2_tx
> +            - const: nss_port1_mac
> +            - const: nss_port2_mac
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,ipq9574-ppe
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Display common AHB clock from gcc
> +            - description: Display common system clock from gcc
> +            - description: Display uniphy0 AHB clock from gcc
> +            - description: Display uniphy1 AHB clock from gcc
> +            - description: Display uniphy2 AHB clock from gcc
> +            - description: Display uniphy0 system clock from gcc
> +            - description: Display uniphy1 system clock from gcc
> +            - description: Display uniphy2 system clock from gcc
> +            - description: Display nss clock from gcc
> +            - description: Display nss noc clock from gcc
> +            - description: Display nss noc snoc clock from gcc
> +            - description: Display nss noc snoc_1 clock from gcc
> +            - description: Display PPE clock from nsscc
> +            - description: Display PPE config clock from nsscc
> +            - description: Display NSSNOC PPE clock from nsscc
> +            - description: Display NSSNOC PPE config clock from nsscc
> +            - description: Display EDMA clock from nsscc
> +            - description: Display EDMA config clock from nsscc
> +            - description: Display PPE IPE clock from nsscc
> +            - description: Display PPE BTQ clock from nsscc
> +            - description: Display port1 MAC clock from nsscc
> +            - description: Display port2 MAC clock from nsscc
> +            - description: Display port3 MAC clock from nsscc
> +            - description: Display port4 MAC clock from nsscc
> +            - description: Display port5 MAC clock from nsscc
> +            - description: Display port6 MAC clock from nsscc
> +            - description: Display port1 RX clock from nsscc
> +            - description: Display port1 TX clock from nsscc
> +            - description: Display port2 RX clock from nsscc
> +            - description: Display port2 TX clock from nsscc
> +            - description: Display port3 RX clock from nsscc
> +            - description: Display port3 TX clock from nsscc
> +            - description: Display port4 RX clock from nsscc
> +            - description: Display port4 TX clock from nsscc
> +            - description: Display port5 RX clock from nsscc
> +            - description: Display port5 TX clock from nsscc
> +            - description: Display port6 RX clock from nsscc
> +            - description: Display port6 TX clock from nsscc
> +            - description: Display UNIPHY port1 RX clock from nsscc
> +            - description: Display UNIPHY port1 TX clock from nsscc
> +            - description: Display UNIPHY port2 RX clock from nsscc
> +            - description: Display UNIPHY port2 TX clock from nsscc
> +            - description: Display UNIPHY port3 RX clock from nsscc
> +            - description: Display UNIPHY port3 TX clock from nsscc
> +            - description: Display UNIPHY port4 RX clock from nsscc
> +            - description: Display UNIPHY port4 TX clock from nsscc
> +            - description: Display UNIPHY port5 RX clock from nsscc
> +            - description: Display UNIPHY port5 TX clock from nsscc
> +            - description: Display UNIPHY port6 RX clock from nsscc
> +            - description: Display UNIPHY port6 TX clock from nsscc
> +            - description: Display port5 RX clock source from nsscc
> +            - description: Display port5 TX clock source from nsscc
> +        clock-names:
> +          items:
> +            - const: cmn_ahb
> +            - const: cmn_sys
> +            - const: uniphy0_ahb
> +            - const: uniphy1_ahb
> +            - const: uniphy2_ahb
> +            - const: uniphy0_sys
> +            - const: uniphy1_sys
> +            - const: uniphy2_sys
> +            - const: gcc_nsscc
> +            - const: gcc_nssnoc_nsscc
> +            - const: gcc_nssnoc_snoc
> +            - const: gcc_nssnoc_snoc_1
> +            - const: nss_ppe
> +            - const: nss_ppe_cfg
> +            - const: nssnoc_ppe
> +            - const: nssnoc_ppe_cfg
> +            - const: nss_edma
> +            - const: nss_edma_cfg
> +            - const: nss_ppe_ipe
> +            - const: nss_ppe_btq
> +            - const: port1_mac
> +            - const: port2_mac
> +            - const: port3_mac
> +            - const: port4_mac
> +            - const: port5_mac
> +            - const: port6_mac
> +            - const: nss_port1_rx
> +            - const: nss_port1_tx
> +            - const: nss_port2_rx
> +            - const: nss_port2_tx
> +            - const: nss_port3_rx
> +            - const: nss_port3_tx
> +            - const: nss_port4_rx
> +            - const: nss_port4_tx
> +            - const: nss_port5_rx
> +            - const: nss_port5_tx
> +            - const: nss_port6_rx
> +            - const: nss_port6_tx
> +            - const: uniphy_port1_rx
> +            - const: uniphy_port1_tx
> +            - const: uniphy_port2_rx
> +            - const: uniphy_port2_tx
> +            - const: uniphy_port3_rx
> +            - const: uniphy_port3_tx
> +            - const: uniphy_port4_rx
> +            - const: uniphy_port4_tx
> +            - const: uniphy_port5_rx
> +            - const: uniphy_port5_tx
> +            - const: uniphy_port6_rx
> +            - const: uniphy_port6_tx
> +            - const: nss_port5_rx_clk_src
> +            - const: nss_port5_tx_clk_src
> +
> +        resets:
> +          items:
> +            - description: Reset PPE
> +            - description: Reset uniphy0 software config
> +            - description: Reset uniphy1 software config
> +            - description: Reset uniphy2 software config
> +            - description: Reset uniphy0 AHB
> +            - description: Reset uniphy1 AHB
> +            - description: Reset uniphy2 AHB
> +            - description: Reset uniphy0 system
> +            - description: Reset uniphy1 system
> +            - description: Reset uniphy2 system
> +            - description: Reset uniphy0 XPCS
> +            - description: Reset uniphy1 XPCS
> +            - description: Reset uniphy2 XPCS
> +            - description: Assert uniphy port1
> +            - description: Assert uniphy port2
> +            - description: Assert uniphy port3
> +            - description: Assert uniphy port4
> +            - description: Reset PPE port1
> +            - description: Reset PPE port2
> +            - description: Reset PPE port3
> +            - description: Reset PPE port4
> +            - description: Reset PPE port5
> +            - description: Reset PPE port6
> +            - description: Reset PPE port1 MAC
> +            - description: Reset PPE port2 MAC
> +            - description: Reset PPE port3 MAC
> +            - description: Reset PPE port4 MAC
> +            - description: Reset PPE port5 MAC
> +            - description: Reset PPE port6 MAC
> +
> +        reset-names:
> +          items:
> +            - const: ppe
> +            - const: uniphy0_soft
> +            - const: uniphy1_soft
> +            - const: uniphy2_soft
> +            - const: uniphy0_ahb
> +            - const: uniphy1_ahb
> +            - const: uniphy2_ahb
> +            - const: uniphy0_sys
> +            - const: uniphy1_sys
> +            - const: uniphy2_sys
> +            - const: uniphy0_xpcs
> +            - const: uniphy1_xpcs
> +            - const: uniphy2_xpcs
> +            - const: uniphy0_port1_dis
> +            - const: uniphy0_port2_dis
> +            - const: uniphy0_port3_dis
> +            - const: uniphy0_port4_dis
> +            - const: nss_port1
> +            - const: nss_port2
> +            - const: nss_port3
> +            - const: nss_port4
> +            - const: nss_port5
> +            - const: nss_port6
> +            - const: nss_port1_mac
> +            - const: nss_port2_mac
> +            - const: nss_port3_mac
> +            - const: nss_port4_mac
> +            - const: nss_port5_mac
> +            - const: nss_port6_mac
> +
> +required:

allOf: goes after required:

> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - tdm-config
> +  - buffer-management-config
> +  - queue-management-config
> +  - port-scheduler-resource
> +  - port-scheduler-config
> +
> +additionalProperties: false


> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +    #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +    #include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> +    #include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
> +
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      qcom_ppe: qcom-ppe@3a000000 {

Drop label, Generic node names.

> +              compatible = "qcom,ipq9574-ppe";

Entire indentation of example is broken. Use one described in the
bindings coding style.

Best regards,
Krzysztof


