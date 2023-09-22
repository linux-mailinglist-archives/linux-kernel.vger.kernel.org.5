Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B237ABAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjIVVMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjIVVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:12:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C6CA;
        Fri, 22 Sep 2023 14:12:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593D7C433C8;
        Fri, 22 Sep 2023 21:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695417123;
        bh=PklVl2hK9R9Q6EgrD2sgcoUGkMduL6hc3uwF7Wh8zfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pr343hPZKuXyRCteT9bzGAl17KD+LyM0KpclJcQIjazwXH305R+Ontaa+XERY+n/7
         yjC44OSdyWFHwfWX0V0/b38fGqv4mIo/0cuyYT31J8ukHXICdMytTpwlHXBNZwQsnZ
         8DAV779ofqaIKwvGU2N4b+Xz05ccxFPM4ZicVziQfmb1+j1gjqllQs2fKi6KwDymHP
         XcJGsO4pruV8hU1pvS3DPK5fnri2Q0vEyeUJJCV8PpfS9GJuYkKEJVn0zOQfQA2bJn
         qok/D9hbDd8jleq5iEKSgjZhqoPd83GGHD4+DSVRazwdmlNM2NEtKIp2ymEQctezIg
         //fZwZOsaX9Tg==
Received: (nullmailer pid 3627011 invoked by uid 1000);
        Fri, 22 Sep 2023 21:12:01 -0000
Date:   Fri, 22 Sep 2023 16:12:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: max31827: use supply pin name
Message-ID: <20230922211201.GA3600661-robh@kernel.org>
References: <20230921142005.102263-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921142005.102263-1-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 05:20:03PM +0300, Antoniu Miclaus wrote:
> The actual hardware pin name for the supply of max31827 is vdd.
> Update the dt-binding to reflect the hardware properties accordingly.

Changing this breaks the ABI. I see the old one wasn't used by the 
driver, but that's just one driver potentially. You need some 
justification here why it's okay to break the ABI.

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/devicetree/bindings/hwmon/adi,max31827.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> index 2dc8b07b4d3b..21f2d350373b 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> @@ -27,7 +27,7 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  vref-supply:
> +  vdd-supply:
>      description:
>        Must have values in the interval (1.6V; 3.6V) in order for the device to
>        function correctly.
> @@ -35,7 +35,7 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - vref-supply
> +  - vdd-supply
>  
>  additionalProperties: false
>  
> @@ -48,7 +48,7 @@ examples:
>          temperature-sensor@42 {
>              compatible = "adi,max31827";
>              reg = <0x42>;
> -            vref-supply = <&reg_vdd>;
> +            vdd-supply = <&reg_vdd>;
>          };
>      };
>  ...
> -- 
> 2.42.0
> 
