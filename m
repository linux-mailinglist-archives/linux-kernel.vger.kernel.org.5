Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A7B78F1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346919AbjHaRYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbjHaRYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:24:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E1F193;
        Thu, 31 Aug 2023 10:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F474B82344;
        Thu, 31 Aug 2023 17:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEB2C433C8;
        Thu, 31 Aug 2023 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693502656;
        bh=f6VrVQDrfPeeAwksl3Zn8beCh18icrc5Wwa0RFVNjYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h58iLyRfOxWnKlyFhKIgNrATw8bsjcvcfR24Rxegb/5Lg2uUjRGZpzj8FNdGUdoPe
         u4ZZSmMk6W7xb7pLZOw88BAyUl7+fZwbRxaJjaQFZe3kLQ2Hc0qQQfoVfOxoqgAmOA
         Qs+yM75jYN8JXyWuyaU4oQFwK/FrOXOfnKvAcr8k/h6aAvcTtuE+/FsGgPb8t2BPZQ
         f2/+re0t/M2dsh44t3+Ai0cgGulKlbfLWGuHVz6EIKwnmHDa9o0iA9//LXuKVcxiIM
         GFbQ7s+mNJeLGWIFEKZf5i5ZTF9pQlJH53FXjxlUS2XwIxUEdTMm6aMzuyOrKvjSzu
         3EeIRp1latDbQ==
Received: (nullmailer pid 2465302 invoked by uid 1000);
        Thu, 31 Aug 2023 17:24:13 -0000
Date:   Thu, 31 Aug 2023 12:24:13 -0500
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
Subject: Re: [PATCH v5 13/32] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Message-ID: <20230831172413.GB2460067-robh@kernel.org>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
 <20230829210657.9904-14-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829210657.9904-14-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:06:38PM -0700, Wesley Cheng wrote:
> Add a new definition for specifying how many XHCI secondary interrupters
> can be allocated.  XHCI in general can potentially support up to 1024
> interrupters, which some uses may want to limit depending on how many
> users utilize the interrupters.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index a696f23730d3..596762ef9b9f 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -376,6 +376,19 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>  
> +  snps,num-hc-interrupters:

Why do you still have this when you defined a common property?

If you want to limit it here, just do: 

num-hc-interrupters:
  maximum: 8


> +    description:
> +      Defines the maximum number of XHCI host controller interrupters that can
> +      be supported.  The XHCI host controller has support to allocate multiple
> +      event rings, which can be assigned to different clients/users.  The DWC3
> +      controller has a maximum of 8 interrupters.  If this is not defined then
> +      the value will be defaulted to 1.  This parameter is used only when
> +      operating in host mode.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    minimum: 1
> +    maximum: 8
> +    default: 1
> +
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
>      description:
