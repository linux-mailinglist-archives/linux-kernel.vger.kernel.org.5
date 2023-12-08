Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895C80A8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574044AbjLHQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjLHQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:29:20 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDC10D8;
        Fri,  8 Dec 2023 08:29:25 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9e179b217so1035878a34.0;
        Fri, 08 Dec 2023 08:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052965; x=1702657765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SVaACwpVUhwblTaqNuJY3ebQdc5RZ9uip2w8qBKNsY=;
        b=AE0xyHN8I/jNKSwSuj9RPGsTTGgdWgA0O0+Ml7s/qRp3EDj6TRObirOjZ8TUY6fF0I
         elNv7W2EgWcFiGl1LTfgZaH7L69ZxWxS6queAKe0q0Tt9gOEdsPQQi681r0kqOY7aTDY
         EJ/wfLOi3HHJ1f6pide2CkAIrU7w93/e1qx3e2yUVLEk38Ks0sUIQKIGjZhl5VkBpSe8
         mz2FvJFlMmSyrDJVeK2NYMXUv1Eh8ZVm3N/lExYN5qNMAng6R3npIiRQwCpub5XUyMwd
         +3omK8Q+ks1TqJGLciIrQIO9z1/yglELwx4y4LLirvhEN016rYHAjDZ7cRrnWHWf9S32
         r2yA==
X-Gm-Message-State: AOJu0YxIRW4jHDCq9vZ6kC2pqnkuMmX/cm9kSw/XaDOkr/udJaoDrw45
        vygiUR3Yr2sd+BqjbVL36w==
X-Google-Smtp-Source: AGHT+IEx3i46ysZb4fgcLcBpy2/L8rEUX4oy8qg8EE25t4xhrjQY3YMwY/nqntUBcIThHBIaFp8+lw==
X-Received: by 2002:a05:6830:1be5:b0:6d9:76cd:d6b8 with SMTP id k5-20020a0568301be500b006d976cdd6b8mr292439otb.68.1702052965144;
        Fri, 08 Dec 2023 08:29:25 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s17-20020a9d7591000000b006d84b3aa650sm339298otk.73.2023.12.08.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:29:24 -0800 (PST)
Received: (nullmailer pid 1658626 invoked by uid 1000);
        Fri, 08 Dec 2023 16:29:23 -0000
Date:   Fri, 8 Dec 2023 10:29:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Message-ID: <20231208162923.GA1635292-robh@kernel.org>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
 <20231204100950.28712-2-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100950.28712-2-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:39:45PM +0530, Krishna Kurapati wrote:
> The high speed related interrupts present on QC targets are as follows:
> 
> dp/dm irq's
> These IRQ's directly reflect changes on the DP/DM pads of the SoC. These
> are used as wakeup interrupts only on SoCs with non-QUSB2 targets with
> exception of SDM670/SDM845/SM6350.
> 
> qusb2_phy irq
> SoCs with QUSB2 PHY do not have separate DP/DM IRQs and expose only a
> single IRQ whose behavior can be modified by the QUSB2PHY_INTR_CTRL
> register. The required DPSE/DMSE configuration is done in
> QUSB2PHY_INTR_CTRL register of phy address space.
> 
> hs_phy_irq
> This is completely different from the above two and is present on all
> targets with exception of a few IPQ ones. The interrupt is not enabled by
> default and its functionality is mutually exclusive of qusb2_phy on QUSB
> targets and DP/DM on femto phy targets.
> 
> The DTs of several QUSB2 PHY based SoCs incorrectly define "hs_phy_irq"
> when they should have been "qusb2_phy_irq". On Femto phy targets, the
> "hs_phy_irq" mentioned is either the actual "hs_phy_irq" or "pwr_event",
> neither of which would never be triggered directly are non-functional
> currently. The implementation tries to clean up this issue by addressing
> the discrepencies involved and fixing the hs_phy_irq's in respective DT's.
> 
> Classify interrupts based on whether qusb2_phy interrupt is used or
> {dp/dm}_hs_phy_irq is used and whether hs_phy_irq is present or not.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 147 +++++++-----------
>  1 file changed, 58 insertions(+), 89 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index 3ec62027f663..94deef765ec3 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -98,12 +98,30 @@ properties:
>        - const: apps-usb
>  
>    interrupts:
> -    minItems: 1
> -    maxItems: 4
> +    description: |
> +      Different types of interrupts are used based on HS phy used on target::

Why the double colon? This isn't rSt.

Rob
