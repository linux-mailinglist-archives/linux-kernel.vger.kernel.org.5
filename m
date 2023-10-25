Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BA47D77C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJYWXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYWXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:23:33 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69406E5;
        Wed, 25 Oct 2023 15:23:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 672EBFF809;
        Wed, 25 Oct 2023 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698272607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcV849E/eIhK4TvCJqadj3oQo0m8lh0wsmlqHmLSGNc=;
        b=DZj2JfZPA3ox2juxLyrlHb50+XKNMziUVvrNFT+BX21YLtmmZqYoDm11F70jSy5jZej1A5
        fgen08OtZoBSYEQo4blO74aI44uo37e3gUo/ZRggPPSpXnd9xxX9tKqjC7KEie2fLtyodI
        gLfr/AWEWxelYz9jcrSUXBhf4UXFbGcOL81WiHdwTreEldedDdfrK0HCZoActamgzVweuX
        kVhWVV5XZteqD8ZWz8dvJsJlHx/elJ9Kfc1QriYVhqPWlS8TnN+6Cwqx1QRTWXXZmf6nMX
        HCfo40I3r4B4Zz1RnU4yyv9N8FArEq98vbfZBFhWoTckhXW+9WNZb6W6+t70nQ==
Date:   Thu, 26 Oct 2023 00:23:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
Message-ID: <20231025222327c0b5d460@mail.local>
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm sorry I never replied to your previous thread...

On 25/10/2023 18:21:55+0200, Javier Carrasco wrote:
> The "hiz-output" property models the RTC output as a high-impedance
> (hi-Z) output.
> 
> This property is optional and if it is not defined, the output will
> either act as an output clock (default mode) or as an interrupt
> depending on the configuration set by other properties.
> 
> Two modes are defined in case the high-impedance is used: "enabled" and
> "sleep". The former disables the RTC output completely while the latter
> keeps the RTC output disabled until the system enters in sleep mode.
> This option is especially relevant if the output clock is used to feed a
> PMU, a PMIC or any other device required to run when the rest of the
> system is down. For the sake of completeness, a "disabled" mode has been
> added, which acts as if the property was not defined.
> 
> Document "hiz-output" as a non-required property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
> index 52aa3e2091e9..4b27a9154191 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
> @@ -36,6 +36,19 @@ properties:
>      enum: [6000, 7000, 12500]
>      default: 7000
>  
> +  hiz-output:
> +    description:
> +      Use enabled if the output should stay in high-impedance. This
> +      mode will mask the output as an interrupt source.
> +      Use sleep if the otuput should be only active in sleep mode.
> +      This mode is compatible with any other output configuration.
> +      The disabled value acts as if the property was not defined.
> +    enum:
> +      - enabled
> +      - sleep
> +      - disabled
> +    default: disabled
> +

If instead of using a custom property, you consider this as what it
actually is: pinmuxing, then everything else comes for free. With
pinctrl, you can define different states for runtime and sleep and they
will get applied automatically instead of open coding in the driver.

Also, how you define this property means that everyone currently using
this RTC is going to have a new warning that they should just ignore.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
