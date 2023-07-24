Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BC760314
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGXXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E69E78;
        Mon, 24 Jul 2023 16:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E84961464;
        Mon, 24 Jul 2023 23:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73206C433C8;
        Mon, 24 Jul 2023 23:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690241010;
        bh=w+olyalJrA2gi25MoSVwqGzWtB2JIt1pQxhluX5W+Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJc8ruOzyTk4j/2MU65pdXVSBNePXOjfJn1GAqDAjq5sbiE0IyPpKKA3joaKxm8xw
         2QFh18yk2eZA+SFagsz/5dbmVRZ5AfxNblF+eoSnRn99ayhJXlMQ8AsP/TBySyIcHH
         +iNTF+ypyENR1dXI2Zs1M206yEQx7xVapAbVznq5kMlLO+TGmjF2clTs9i5rcnCYn6
         OLvNuo0hu/aJ5gz1BKme3Hfs48jBnDrPKgMrxAjdh0uVLgPDqIvuwUxZVWU0XFe+a/
         diMktUHpPOPOs9ixdVT4QdRqHhqO+A8bHogIooFxoWDuOThVVPM5DzmJ90G+xpC7I+
         AyjzLXxz7ikZA==
Received: (nullmailer pid 1109815 invoked by uid 1000);
        Mon, 24 Jul 2023 23:23:28 -0000
Date:   Mon, 24 Jul 2023 17:23:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: Re: [RFC PATCH 3/4] dt-bindings: power: reset: Document
 arm,psci-vendor-reset
Message-ID: <20230724232328.GA1101352-robh@kernel.org>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724223057.1208122-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:30:53PM -0700, Elliot Berman wrote:
> Add devicetree bindings for using PSCI SYSTEM_RESET2 with vendor reset  types.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../power/reset/arm,psci-vendor-reset.yaml    | 35 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml b/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
> new file mode 100644
> index 000000000000..18b0b8c167a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/arm,psci-vendor-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PSCI SYSTEM_RESET2 Vendor Resets
> +
> +maintainers:
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |
> +  PSCI SYSTEM_RESET2 supports vendor-defined reset types. This describes
> +  the conversion of reboot modes to the reset types.
> +
> +properties:
> +  compatible:
> +    const: arm,psci-vendor-reset
> +
> +allOf:
> +  - $ref: reboot-mode.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      psci-vendor-resets {
> +        compatible = "arm,psci-vendor-reset";

We already have a node for PSCI, we don't need a second one. You can 
have a separate driver without a separate node. 

> +        reboot-normal = <0x100>;

Wouldn't 'normal' be the normal PSCI reset?

> +        reboot-bootloader = <0x101>;
> +        reboot-fastboot = <0x102>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d516295978a4..2da4c5f1917b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16982,6 +16982,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
>  F:	drivers/firmware/psci/
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h
> -- 
> 2.41.0
> 
