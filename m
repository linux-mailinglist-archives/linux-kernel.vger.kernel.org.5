Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB47F5C32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbjKWKW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:22:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC560AD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:22:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978A8C433C7;
        Thu, 23 Nov 2023 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700734952;
        bh=B3lJUcJOAeEyU+0uadD5Y6vycGo2MonX772pkrNBMhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWgM3o978Z2d8Fvrq3XzxmKsEBSddvnLFIJTpAxyrbO57l2sDNfLqIPafenrV1OcJ
         2e0OjXfSzlvn0Y5/igAXXbIt6ib1uKcEYz4OOdR4wUD8Yag/id0Zd7j5Faom4iKFB9
         QEtDeVQqr5r+ulNJksvE69BNw6NC73I08rmQv+iGaEew52tHCj5rveFgY+J5C9hKpm
         vunuhcfUMVVgybsHEwBgF77CvWrTscu/8uet8IuSDaGRHtQb5zvEE5f+0buDufcIgp
         fCbgRLFwNB9kxe4RkXIpd29/Zxb9Tn5+nE9dQ6Zw9nP195TWmw3Go5OAzaNdgP9sDY
         F7umz9pi8OyuA==
Date:   Thu, 23 Nov 2023 10:22:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     Santhosh Kumar K <s-k6@ti.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,am3359-adc: Allow dmas
 property to be optional
Message-ID: <20231123102227.GC1184245@google.com>
References: <20231122083608.136071-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122083608.136071-1-s-k6@ti.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, Santhosh Kumar K wrote:

> ADC module can function without DMA, so there may not be dma channel
> always associated with device. Hence, remove "dmas", "dma-names" from list
> of required properties.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> index 23a63265be3c..70b5dfce07d2 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml

This is not an IIO patch.  Please collect the tags you've received and
resubmit it with the correct subject line.

> @@ -61,8 +61,6 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> -  - dmas
> -  - dma-names
>  
>  additionalProperties: false
>  
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
