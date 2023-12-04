Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6454880405C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjLDUrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjLDUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:47:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F6AA;
        Mon,  4 Dec 2023 12:47:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so4429485a12.2;
        Mon, 04 Dec 2023 12:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701722837; x=1702327637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9dgQqvlMKuiJtv8lVyvdOrfo+LNM0OzRHmBV5GtdMQ=;
        b=S/p050Mq0VgD+QcbKrf4IKPPfFsTbQwEhEIwmvHMjiukFTe+vRjIVISLrmVP58MFtk
         ONW/TbVjifys6UKZXSza3QIcLi6308A8KuMpYQz00w8mc0FX4jUUEr/hO9X+cGVhnUyB
         bHC3DPDqmO4uJZKt2sIjlTIbmk+7JjChBe6oxtslqbNG+afnbEmsu04j2kcwESEBxs0x
         /7g7G2C2+8YrFAS6Q2e0oqj8D2uT+ARKScOdbO+HO4i3Ja7Hb1l8vMRsfeK7fU38aB+E
         T1AxnCN+Dhlst8yV2v40mBKEn65yPj+is3nUE6rUMtFQ1eAMX/usIr6u7LztxUQsDkPI
         7aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722837; x=1702327637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9dgQqvlMKuiJtv8lVyvdOrfo+LNM0OzRHmBV5GtdMQ=;
        b=fTBdSJ5qvEn4oAOSgyagmux6YYgtYIVphG/4yyyVyATJb/5nJP7Cr2aeLJOK7tSoWx
         kz+dkarlp25ZJqSQKCYuz9cuMk/mgWWhi1WIP2gcOaHxE94zoBUDb1D5l8xhQMElXb9W
         wNdh7cQi1AHhUCVDIrFvukWCTuArRw8hDkaY8c7B2L+WfF7p4cmfaG5D8QzmrVJ8joEj
         +nmTiqDSDZoRd19DSjtQhPZyn2bt33uLlHDht8ras+F5JuRfLmj/J3p0titHNXAWCU4Z
         Kq2/r+wlgvJxERNFXrvIUv+FCvaPsGjcFOf7H0T0cNDOiR0nP/0X6YsNO0TCmRJUXkff
         3qag==
X-Gm-Message-State: AOJu0YyBgE4LKAMB2v7Q0ZP12/Xp5uoIrb6VgluhpsFYzV50fT/TmGjm
        F7mAega41IwREylkW2+LG/A=
X-Google-Smtp-Source: AGHT+IHA3oXf22PTJdjaJrDf+ByuA8hO3q3Maum0iVbVsbMnBeNt2upvWh2RWQSoY50OYkXPYBti6g==
X-Received: by 2002:a17:906:7386:b0:a1a:4f2b:6c1b with SMTP id f6-20020a170906738600b00a1a4f2b6c1bmr1550810ejl.137.1701722837317;
        Mon, 04 Dec 2023 12:47:17 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t9-20020a170906178900b00a1b65249053sm2185176eje.128.2023.12.04.12.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 12:47:17 -0800 (PST)
Message-ID: <3331543a-73fb-3565-47c6-d3303c44ba21@gmail.com>
Date:   Mon, 4 Dec 2023 21:47:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/3] dt-bindings: drm: rockchip: convert
 inno_hdmi-rockchip.txt to yaml
Content-Language: en-US
To:     Alex Bee <knaerzche@gmail.com>, heiko@sntech.de, hjc@rock-chips.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
 <3f235189-da75-4e9d-ad68-8cbebca12f6d@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <3f235189-da75-4e9d-ad68-8cbebca12f6d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/23 19:56, Alex Bee wrote:
> Hi Johan,
> Am 04.12.23 um 18:39 schrieb Johan Jonker:
>> Convert inno_hdmi-rockchip.txt to yaml.
> Nice - I'm having something very similar on my queue :)
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Note for rob+dt:
>>    Used enum to "soon" be able to add "rockchip,rk3128-inno-hdmi"

> Yeah, actually I'm planning to submit it really soon (if timne allows).

;)

>>
>> Changed V1:
>>    Rename file to more common layout
>>    Add/fix hdmi_out port example
>> ---
>>   .../display/rockchip/inno_hdmi-rockchip.txt   |  49 ---------
>>   .../display/rockchip/rockchip,inno-hdmi.yaml  | 103 ++++++++++++++++++
>>   2 files changed, 103 insertions(+), 49 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
>>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
>> deleted file mode 100644
>> index cec21714f0e0..000000000000
>> --- a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
>> +++ /dev/null
>> @@ -1,49 +0,0 @@
>> -Rockchip specific extensions to the Innosilicon HDMI
>> -================================
>> -
>> -Required properties:
>> -- compatible:
>> -    "rockchip,rk3036-inno-hdmi";
>> -- reg:
>> -    Physical base address and length of the controller's registers.
>> -- clocks, clock-names:
>> -    Phandle to hdmi controller clock, name should be "pclk"
>> -- interrupts:
>> -    HDMI interrupt number
>> -- ports:
>> -    Contain one port node with endpoint definitions as defined in
>> -    Documentation/devicetree/bindings/graph.txt.
>> -- pinctrl-0, pinctrl-name:
>> -    Switch the iomux of HPD/CEC pins to HDMI function.
>> -
>> -Example:
>> -hdmi: hdmi@20034000 {
>> -    compatible = "rockchip,rk3036-inno-hdmi";
>> -    reg = <0x20034000 0x4000>;
>> -    interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>> -    clocks = <&cru  PCLK_HDMI>;
>> -    clock-names = "pclk";
>> -    pinctrl-names = "default";
>> -    pinctrl-0 = <&hdmi_ctl>;
>> -
>> -    hdmi_in: port {
>> -        #address-cells = <1>;
>> -        #size-cells = <0>;
>> -        hdmi_in_lcdc: endpoint@0 {
>> -            reg = <0>;
>> -            remote-endpoint = <&lcdc_out_hdmi>;
>> -        };
>> -    };
>> -};
>> -
>> -&pinctrl {
>> -    hdmi {
>> -        hdmi_ctl: hdmi-ctl {
>> -            rockchip,pins = <1 8  RK_FUNC_1 &pcfg_pull_none>,
>> -                    <1 9  RK_FUNC_1 &pcfg_pull_none>,
>> -                    <1 10 RK_FUNC_1 &pcfg_pull_none>,
>> -                    <1 11 RK_FUNC_1 &pcfg_pull_none>;
>> -        };
>> -    };
>> -
>> -};
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>> new file mode 100644
>> index 000000000000..96889c86849a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>> @@ -0,0 +1,103 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,inno-hdmi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip Innosilicon HDMI controller
>> +
>> +maintainers:
>> +  - Sandy Huang <hjc@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,rk3036-inno-hdmi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1

> The interrupts/clock description exists already in the txt-bindings - so how about:
> 
> +    items:
> +      - descrition: ....
>> +

It's not common to do so when there's only one clock and nothing special to mention.
Used this style for most of my conversions. 
Further rational might be given by Krzysztof and co.

>> +  clock-names:
>> +    const: pclk
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          Port node with one endpoint connected to a vop node.
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          Port node with one endpoint connected to a hdmi-connector node.
>> +
>> +    required:
>> +      - port@0
>> +      - port@1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - pinctrl-0
>> +  - pinctrl-names
>> +  - ports
>> +
>> +additionalProperties: false

> Did you check that with dtbs_check? RK3036's SoC dtsi also contains a
> 
>  rockchip,grf = <&grf>;
> 
> and I'm not seeing this removed in this series.
> 

I did check. Currently grf is not used in a mainline driver and only in the Rockchip tree.
Choose to keep it as it is for now.

> It would be great if that would added here to as requirement
> for RK3036 too  (and updated in the example)
> Even if it is beyond a pure txt to yaml conversion: RK3036 needs to set HDMI polarities in GRF.

It's a good habit to do one action per patch. In this case we convert an exciting document.
Everyone is free to add further properties if needed.

Johan


> 
> Regards,
> Alex
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3036-cru.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/pinctrl/rockchip.h>
>> +    hdmi: hdmi@20034000 {
>> +      compatible = "rockchip,rk3036-inno-hdmi";
>> +      reg = <0x20034000 0x4000>;
>> +      interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>> +      clocks = <&cru  PCLK_HDMI>;
>> +      clock-names = "pclk";
>> +      pinctrl-names = "default";
>> +      pinctrl-0 = <&hdmi_ctl>;
>> +
>> +      ports {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        hdmi_in: port@0 {
>> +          reg = <0>;
>> +          hdmi_in_vop: endpoint {
>> +            remote-endpoint = <&vop_out_hdmi>;
>> +          };
>> +        };
>> +
>> +        hdmi_out: port@1 {
>> +          reg = <1>;
>> +          hdmi_out_con: endpoint {
>> +            remote-endpoint = <&hdmi_con_in>;
>> +          };
>> +        };
>> +      };
>> +    };
>> +
>> +    pinctrl {
>> +      hdmi {
>> +        hdmi_ctl: hdmi-ctl {
>> +          rockchip,pins = <1 RK_PB0 1 &pcfg_pull_none>,
>> +                          <1 RK_PB1 1 &pcfg_pull_none>,
>> +                          <1 RK_PB2 1 &pcfg_pull_none>,
>> +                          <1 RK_PB3 1 &pcfg_pull_none>;
>> +        };
>> +      };
>> +    };
>> -- 
>> 2.39.2
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
