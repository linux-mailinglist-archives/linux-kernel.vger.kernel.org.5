Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC875FB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGXQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjGXQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9619A;
        Mon, 24 Jul 2023 09:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF296123A;
        Mon, 24 Jul 2023 16:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14399C433C9;
        Mon, 24 Jul 2023 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690214500;
        bh=obEOVXewu49VHgFG99DmRcFBdBiVyJBWFXsPB3r31fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OojbEwQeuKb6QLqK6xMwGZ+fLq0y6ggK/tEkfAkegcfDu+8CKzOPOnuFdZePmmFWT
         8hMsA2mSyXl2bzJd6bKTm1ew8RsSgBYz8qt/EaxqgFvdvS8dvRfiesUvQvRMQBF7FO
         9GhbXLzIVKH4iDo8A3E5Erf9xLofT70hZzRtH9Hh0J9bSwiZ0wPOsgoE4Amd27eEKA
         FMD5phjLHByS4SRc8y82CK1So8dFE4GD5i2KhNZQWL+4t/G1E5dF3nQAUGwsO5dKPR
         SXSyeiVAQveObzPk/v/94s43da2MCi0JzEgEvGDRtCGL2D1o3hUn8jyOrpZM3L8WJF
         bX5xpTCFzPFMw==
Received: (nullmailer pid 3620992 invoked by uid 1000);
        Mon, 24 Jul 2023 16:01:36 -0000
Date:   Mon, 24 Jul 2023 10:01:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Message-ID: <20230724160136.GA3619408-robh@kernel.org>
References: <cover.1689913334.git.quic_varada@quicinc.com>
 <131eb1694229436919ac88bb9920fb54d6808388.1689913334.git.quic_varada@quicinc.com>
 <ymbcafqqhc6hgrfhpef4byehvfyjzovs5zeprmj343erdv5ti5@tj2iunu6whvi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ymbcafqqhc6hgrfhpef4byehvfyjzovs5zeprmj343erdv5ti5@tj2iunu6whvi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:10:57PM -0700, Bjorn Andersson wrote:
> On Fri, Jul 21, 2023 at 10:05:27AM +0530, Varadarajan Narayanan wrote:
> > Document the M31 USB2 phy present in IPQ5332.
> > 
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> As Sricharan is the first one to certify the patch's origin, it seems
> likely that he's the author. Please add a Co-developed-by: Sricharan.
> 
> [..]
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> > new file mode 100644
> > index 0000000..e0b282b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-hsphy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: M31 USB PHY
> > +
> > +maintainers:
> > +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > +  - Varadarajan Narayanan <quic_varada@quicinc.com>
> > +
> > +description:
> > +  USB M31 PHY (https://www.m31tech.com) found in Qualcomm
> > +  IPQ5018, IPQ5332 SoCs.
> > +
> > +properties:
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    enum:
> 
> const?
> 
> > +      - qcom,ipq5332-usb-hsphy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: cfg_ahb
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > +    usbphy0: usb-phy@7b000 {
> 
> usb@

You mean phy@? But 'usb2-phy' is accepted too.

> 
> And you don't need to give the node a label in the example.
> 
> > +        compatible = "qcom,ipq5332-usb-hsphy";
> > +        reg = <0x0007b000 0x12c>;
> > +
> > +        clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> > +        clock-names = "cfg_ahb";
> > +
> 
> No #phy-cells?
> 
> Regards,
> Bjorn
> 
> > +        resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> > +    };
> > -- 
> > 2.7.4
> > 
