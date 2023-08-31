Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5178F1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346900AbjHaRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346902AbjHaRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:22:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED5CD6;
        Thu, 31 Aug 2023 10:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E17B3CE2029;
        Thu, 31 Aug 2023 17:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815BCC433C7;
        Thu, 31 Aug 2023 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693502543;
        bh=9QZWhRpHtmTV0U3uh7AIY6EM/VgorWxSrPGP3GaH8OA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6dhHsvxfBZdOrh3VnpluRK0lSG0ekQysNnLCg4ejHOvsj2DCJ8hk6xyELYX0LN3d
         SSryDDvpob1QCFMKSBF0k0t5IYPFy6rnxFPfN42IIUyrZHu8uR+J+65xHeqXkdKqAj
         VdAeLA1M7wNMe9T259WglI7c3JOBBrH9Fbp3ghAlj4RO9YJZv10SFxdhxdARC+FsXx
         YUIKVlQzd61pzjhYMI8Hf64kDbrKqaIS+VXyn3I23LfmyDCNAZx6TpGfGR1o5RU0Dl
         AcuNVrp7w/Td+9SASyRZk7b0xpuxbKh7xgnQn05z4Z5hhe6ow/+j6vOIqZwTMA7yVx
         Sv0P6DzTGQIQw==
Received: (nullmailer pid 2462698 invoked by uid 1000);
        Thu, 31 Aug 2023 17:22:20 -0000
Date:   Thu, 31 Aug 2023 12:22:20 -0500
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
Subject: Re: [PATCH v5 14/32] dt-bindings: usb: xhci: Add num-hc-interrupters
 definition
Message-ID: <20230831172220.GA2460067-robh@kernel.org>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
 <20230829210657.9904-15-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829210657.9904-15-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:06:39PM -0700, Wesley Cheng wrote:
> Add the definition for how many interrupts the XHCI host controller should
> allocate.  XHCI can potentially support up to 1024 interrupters, which
> implementations may want to limit.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> index 180a261c3e8f..2c05757cef01 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> @@ -29,6 +29,10 @@ properties:
>      description: Interrupt moderation interval
>      default: 5000
>  
> +  num-hc-interrupters:
> +    description: Maximum number of interrupters to allocate
> +    $ref: /schemas/types.yaml#/definitions/uint16

minimum: 1
maximum: 1024

> +
>  additionalProperties: true
>  
>  examples:
