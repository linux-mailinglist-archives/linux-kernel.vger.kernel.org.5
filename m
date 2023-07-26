Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634C2763D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjGZRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjGZRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E2212A;
        Wed, 26 Jul 2023 10:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5DDC61C00;
        Wed, 26 Jul 2023 17:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F78C433C8;
        Wed, 26 Jul 2023 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690391978;
        bh=efegVLS2xrCv7gYTENHX0ser7GsusM7cYHZ9iIN3WP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFMC/66vrykLxmuvfSwz5durhy5zwQjCCF/Q8MicmwmbzBD9vgxyOyFJgXlHtyLyd
         KVzSJgJWm6WOc7yByCR7iylIiKi5ErzAYd0TqVZ95Fb4WWzWOA6J74hj9enuUA84Qh
         2h2gLZVq5pFC2G6Y7wNjndQnL7psbNmFaFd2A03ThpvSS3GfnyXZL8F0rAgKx+d0s/
         kezOuuTjSd4LJczr8KQJDXItyGidwx45qZC7wBA+CVlBvHK1AEI/2nJZlCLNrAKhF4
         k8oOfOthqlO0H+eybNglKRkwjKwfiFmYgGZLs9gmH9bZam8E2xkBsE2cMh5EJ9gI1R
         rNnH/WuOT9vqw==
Received: (nullmailer pid 1675716 invoked by uid 1000);
        Wed, 26 Jul 2023 17:19:34 -0000
Date:   Wed, 26 Jul 2023 11:19:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, quic_jackp@quicinc.com,
        pierre-louis.bossart@linux.intel.com, oneukum@suse.com,
        albertccwang@google.com, o-takashi@sakamocchi.jp
Subject: Re: [PATCH v4 13/32] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Message-ID: <20230726171934.GA1654540-robh@kernel.org>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-14-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725023416.11205-14-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:33:57PM -0700, Wesley Cheng wrote:
> Add a new definition for specifying how many XHCI secondary interrupters
> can be allocated.  XHCI in general can potentially support up to 1024
> interrupters, which some uses may want to limit depending on how many
> users utilize the interrupters.

Why does this belong in DT? What 'uses' determines the value? Who wants 
to change this and when?

> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 50edc4da780e..cc6012e922e0 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -376,6 +376,19 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>  
> +  snps,num-hc-interrupters:
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
