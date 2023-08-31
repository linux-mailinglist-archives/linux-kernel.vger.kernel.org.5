Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29FF78F1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbjHaR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbjHaR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:29:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDFE5F;
        Thu, 31 Aug 2023 10:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EA767CE201B;
        Thu, 31 Aug 2023 17:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86588C433C7;
        Thu, 31 Aug 2023 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693502967;
        bh=m2mFHdLb5akULhutA+xwBEH6Sa4t3tjPRJFFhXFkIsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukG3XhOIQt4TGpxNwIxmrhlaWzF1CZZ7iz1KBcXUuA2SaM70aReb4BT2bjz/h6g6r
         awNF6cgNx/eAZc+7kWZUmZD01zUzvnsUH+dyewPa21iYPySKUNx96GmfQ5xuDEWNVx
         IRzlMTp3ux7LfwpXAcCXldy3Vfg6trqOZ54Y4huy2pEOW9IEEjadDpdPgeN2H9ekwd
         ACeBzYusXVsxb+Gcj4uS/sULcH4GSPKswpPe946uV8dlPXnKJCi9ZUFxWsfAZ101Pg
         4eUgPeU1eK2DOHKTFYGu0d523Uh3ViAJ3swl4KuF3PNbLwihcvsO8dnajpaRn7lPSy
         H3iREe5wC4K4A==
Received: (nullmailer pid 2472105 invoked by uid 1000);
        Thu, 31 Aug 2023 17:29:24 -0000
Date:   Thu, 31 Aug 2023 12:29:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [PATCH v5 23/32] ASoC: dt-bindings: Add Q6USB backend
Message-ID: <20230831172924.GA2465731-robh@kernel.org>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
 <20230829210657.9904-24-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829210657.9904-24-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:06:48PM -0700, Wesley Cheng wrote:
> Add a dt-binding to describe the definition of enabling the Q6 USB backend
> device for audio offloading.  The node carries information, which is passed
> along to the QC USB SND class driver counterpart.  These parameters will be
> utilized during QMI stream enable requests.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../bindings/sound/qcom,q6usb-dais.yaml       | 53 +++++++++++++++++++

filename should match the compatible.

>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
> new file mode 100644
> index 000000000000..72254d7e70d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6usb-dais.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,q6usb-dais.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm ASoC DPCM USB backend DAI
> +
> +maintainers:
> +  - Wesley Cheng <quic_wcheng@quicinc.com>
> +
> +description:
> +  The USB port is a supported AFE path on the Q6 DSP.  This ASoC DPCM
> +  backend DAI will communicate the required settings to initialize the
> +  XHCI host controller properly for enabling the offloaded audio stream.
> +  Parameters defined under this node will carry settings, which will be
> +  passed along during the QMI stream enable request and configuration of
> +  the XHCI host controller.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,q6usb
> +
> +  iommus:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 1
> +
> +  qcom,usb-audio-intr-num:
> +    description:
> +      Desired XHCI interrupter number to use.
> +    $ref: /schemas/types.yaml#/definitions/uint32

This is the range as num-hc-interrupters, right?

Perhaps this should also be uint16 and limited to 1024 (or 8).

But why does this need to be in DT? Can't the OS just pick one to 
assign? (the description should answer this)

> +
> +required:
> +  - compatible
> +  - "#sound-dai-cells"
> +  - qcom,usb-audio-intr-num
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dais {
> +      compatible = "qcom,q6usb";
> +      #sound-dai-cells = <1>;
> +      iommus = <&apps_smmu 0x180f 0x0>;
> +      qcom,usb-audio-intr-num = <2>;
> +    };
