Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBD78C7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbjH2Ogh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbjH2OgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14270CC;
        Tue, 29 Aug 2023 07:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9982C619C5;
        Tue, 29 Aug 2023 14:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77578C433C7;
        Tue, 29 Aug 2023 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693319765;
        bh=w9u5bEggXkS9KG+nPdn6lVdboqQvTRDuJDT33hsxW14=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hGisWl6Slymv6dgiTCgDzHgOvYHodsI0QFeD4m12l/dMCuaitcjXuKe5SowaJy57z
         +0XOMxrNSZeJAVQoP8VI1+wAN4ktaQqwgQpnvo02omAc4nrk3fCSZEUjG8QTzR5OMe
         XjSRb8FjT3HmHxKTKlpWD7WPK4lRT+O3Z9PzpD8lMHzFvc3WgxDmF4PEfclJADWl2Y
         gVhQp0npxNwiWUMpYKZLvQFLDMaqysBddi9SrcGL1vDebakrcAYCXlgWsSjxmP2M+q
         cBV8mu2N2yPQqXut2NbR9IsU8WxOBWhKZ5YKdR1K67+j1bPjl0NxgPRVkOb5UOCO9l
         cQnWyDZY/lYJg==
Received: (nullmailer pid 2142030 invoked by uid 1000);
        Tue, 29 Aug 2023 14:35:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@kernel.org, robert.marko@sartura.hr, robh+dt@kernel.org,
        geert+renesas@glider.be, peng.fan@nxp.com,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, will@kernel.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, vkoul@kernel.org, nfraprado@collabora.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, quic_wcheng@quicinc.com,
        rafal@milecki.pl, gregkh@linuxfoundation.org,
        luka.perkov@sartura.hr, andersson@kernel.org, arnd@arndb.de,
        linux-usb@vger.kernel.org, agross@kernel.org,
        catalin.marinas@arm.com
In-Reply-To: <20230829135818.2219438-5-quic_ipkumar@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-5-quic_ipkumar@quicinc.com>
Message-Id: <169331975886.2142011.7345682428392154402.robh@kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: phy: qcom,uniphy: Add ipq5332 USB3 SS
 UNIPHY
Date:   Tue, 29 Aug 2023 09:35:58 -0500
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Aug 2023 19:28:13 +0530, Praveenkumar I wrote:
> Add ipq5332 USB3 SS UNIPHY support.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,uniphy.yaml  | 117 +++++++++++++++++-
>  1 file changed, 114 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
In file included from Documentation/devicetree/bindings/phy/qcom,uniphy.example.dts:45:
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:19: warning: "GCC_BLSP1_AHB_CLK" redefined
   19 | #define GCC_BLSP1_AHB_CLK                               10
      | 
In file included from Documentation/devicetree/bindings/phy/qcom,uniphy.example.dts:18:
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:40: note: this is the location of the previous definition
   40 | #define GCC_BLSP1_AHB_CLK                               21
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:20: warning: "GCC_BLSP1_QUP1_I2C_APPS_CLK" redefined
   20 | #define GCC_BLSP1_QUP1_I2C_APPS_CLK                     11
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:41: note: this is the location of the previous definition
   41 | #define GCC_BLSP1_QUP1_I2C_APPS_CLK                     22
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:21: warning: "GCC_BLSP1_QUP1_SPI_APPS_CLK" redefined
   21 | #define GCC_BLSP1_QUP1_SPI_APPS_CLK                     12
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:42: note: this is the location of the previous definition
   42 | #define GCC_BLSP1_QUP1_SPI_APPS_CLK                     23
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:23: warning: "GCC_BLSP1_QUP2_I2C_APPS_CLK" redefined
   23 | #define GCC_BLSP1_QUP2_I2C_APPS_CLK                     14
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:43: note: this is the location of the previous definition
   43 | #define GCC_BLSP1_QUP2_I2C_APPS_CLK                     24
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:24: warning: "GCC_BLSP1_QUP2_SPI_APPS_CLK" redefined
   24 | #define GCC_BLSP1_QUP2_SPI_APPS_CLK                     15
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:44: note: this is the location of the previous definition
   44 | #define GCC_BLSP1_QUP2_SPI_APPS_CLK                     25
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:30: warning: "GCC_BLSP1_UART1_APPS_CLK" redefined
   30 | #define GCC_BLSP1_UART1_APPS_CLK                        21
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:45: note: this is the location of the previous definition
   45 | #define GCC_BLSP1_UART1_APPS_CLK                        26
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:32: warning: "GCC_BLSP1_UART2_APPS_CLK" redefined
   32 | #define GCC_BLSP1_UART2_APPS_CLK                        23
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:46: note: this is the location of the previous definition
   46 | #define GCC_BLSP1_UART2_APPS_CLK                        27
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:42: warning: "GCC_GP1_CLK" redefined
   42 | #define GCC_GP1_CLK                                     33
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:48: note: this is the location of the previous definition
   48 | #define GCC_GP1_CLK                                     29
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:44: warning: "GCC_GP2_CLK" redefined
   44 | #define GCC_GP2_CLK                                     35
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:49: note: this is the location of the previous definition
   49 | #define GCC_GP2_CLK                                     30
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:98: warning: "GCC_PRNG_AHB_CLK" redefined
   98 | #define GCC_PRNG_AHB_CLK                                89
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:62: note: this is the location of the previous definition
   62 | #define GCC_PRNG_AHB_CLK                                43
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:117: warning: "GCC_QPIC_AHB_CLK" redefined
  117 | #define GCC_QPIC_AHB_CLK                                108
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:63: note: this is the location of the previous definition
   63 | #define GCC_QPIC_AHB_CLK                                44
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:118: warning: "GCC_QPIC_CLK" redefined
  118 | #define GCC_QPIC_CLK                                    109
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:64: note: this is the location of the previous definition
   64 | #define GCC_QPIC_CLK                                    45
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:122: warning: "GCC_SDCC1_AHB_CLK" redefined
  122 | #define GCC_SDCC1_AHB_CLK                               113
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:65: note: this is the location of the previous definition
   65 | #define GCC_SDCC1_AHB_CLK                               46
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:123: warning: "GCC_SDCC1_APPS_CLK" redefined
  123 | #define GCC_SDCC1_APPS_CLK                              114
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:66: note: this is the location of the previous definition
   66 | #define GCC_SDCC1_APPS_CLK                              47
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:191: warning: "GCC_BLSP1_BCR" redefined
  191 | #define GCC_BLSP1_BCR                                   8
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:126: note: this is the location of the previous definition
  126 | #define GCC_BLSP1_BCR                                   30
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:192: warning: "GCC_BLSP1_QUP1_BCR" redefined
  192 | #define GCC_BLSP1_QUP1_BCR                              9
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:127: note: this is the location of the previous definition
  127 | #define GCC_BLSP1_QUP1_BCR                              31
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:195: warning: "GCC_BLSP1_QUP2_BCR" redefined
  195 | #define GCC_BLSP1_QUP2_BCR                              12
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:129: note: this is the location of the previous definition
  129 | #define GCC_BLSP1_QUP2_BCR                              33
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:203: warning: "GCC_BLSP1_UART1_BCR" redefined
  203 | #define GCC_BLSP1_UART1_BCR                             20
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:128: note: this is the location of the previous definition
  128 | #define GCC_BLSP1_UART1_BCR                             32
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:205: warning: "GCC_BLSP1_UART2_BCR" redefined
  205 | #define GCC_BLSP1_UART2_BCR                             22
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:130: note: this is the location of the previous definition
  130 | #define GCC_BLSP1_UART2_BCR                             34
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:260: warning: "GCC_PCNOC_BCR" redefined
  260 | #define GCC_PCNOC_BCR                                   77
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:148: note: this is the location of the previous definition
  148 | #define GCC_PCNOC_BCR                                   52
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:263: warning: "GCC_PRNG_BCR" redefined
  263 | #define GCC_PRNG_BCR                                    80
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:135: note: this is the location of the previous definition
  135 | #define GCC_PRNG_BCR                                    39
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:274: warning: "GCC_QDSS_BCR" redefined
  274 | #define GCC_QDSS_BCR                                    91
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:165: note: this is the location of the previous definition
  165 | #define GCC_QDSS_BCR                                    69
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:290: warning: "GCC_QPIC_BCR" redefined
  290 | #define GCC_QPIC_BCR                                    107
      | 
./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,gcc-ipq4019.h:141: note: this is the location of the previous definition
  141 | #define GCC_QPIC_BCR                                    45
      | 

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
MAINTAINERS: Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230829135818.2219438-5-quic_ipkumar@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

