Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0C7D8805
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjJZSHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJZSHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:07:30 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBE91B1;
        Thu, 26 Oct 2023 11:07:26 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6cd1918afb2so658527a34.0;
        Thu, 26 Oct 2023 11:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698343646; x=1698948446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENEollqMGRKDMhbkSMkHaoD54thLMovQWmP1n7sRCUc=;
        b=GmE/V+sI1/WQXUB++djPnINZ9rRjRwXRsmMKn+t72afl1UvkxufzdVr4AQOif0mXYj
         LT65o0au8ksgYEo+VquGLluGdiK2N+kR+O6RF1Bd7GF1KcO15bQmOA93bJK4ME0E6DjD
         JXFf9uYeyXC19EhfrQMXhz7Poi1V0y88LAue7FLDV4zaHiB0hqJAyTeZIGPtNVkV3ts+
         FoSNqGZMCsEnh3wSrm+BZcUZUOnAXjZIx5sAf0+rp6yC1hVYL0EQJhE2qbWeSJAa29mK
         uS570XXwozahuRGEVfU30zzlStzA8czJA+w94p3EeIB3e3NJuMBs31wdlmkIAxJs6mXX
         vr9A==
X-Gm-Message-State: AOJu0Yz6t0gUEpXxv8qLXFHdzzH5u26qgVTTZAU183w54bRRGI/tu50E
        1RdHdQgM6vayvL2UF9s6ew==
X-Google-Smtp-Source: AGHT+IET1KctVP9taJ0RgRpXEMx9LPCq13Vxv2nxhaSHIPgh/LGOf33ATDy4SqI5QHe0tIaxDHaL5w==
X-Received: by 2002:a05:6830:3110:b0:6b9:3f64:4e8c with SMTP id b16-20020a056830311000b006b93f644e8cmr232430ots.9.1698343645780;
        Thu, 26 Oct 2023 11:07:25 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m6-20020a05683026c600b006c4d38e12b9sm2746216otu.65.2023.10.26.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 11:07:25 -0700 (PDT)
Received: (nullmailer pid 4121876 invoked by uid 1000);
        Thu, 26 Oct 2023 18:07:24 -0000
Date:   Thu, 26 Oct 2023 13:07:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     git@amd.com, michal.simek@amd.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org, radhey.shyam.pandey@amd.com,
        srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
        manion05gk@gmail.com
Subject: Re: [PATCH V3 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
Message-ID: <20231026180724.GA4108223-robh@kernel.org>
References: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
 <20231024144847.2316941-2-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024144847.2316941-2-manikanta.guntupalli@amd.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:18:46PM +0530, Manikanta Guntupalli wrote:
> Add optional gpio property to uartps node and reference to rs485.yaml
> 
> On Xilinx/AMD Kria SOM KD240 board rs485 connects via TI ISOW1432
> Transceiver device, where one GPIO is used for driving DE/RE signals.
> With rs485 half duplex configuration, DE and RE are shorted to each other,
> and at a time, any node acts as either a driver or a receiver.
> 
> Here,
> DE - Driver enable. If pin is floating, driver is disabled.
> RE - Receiver enable. If pin is floating, receiver buffer is disabled.

What happens when pin is not floating? Is floating (i.e. open drain) for 
RTS a requirement? And floating doesn't define high or low because it 
could be pulled either way.

> 
> For more deatils, please find below link which contains Transceiver
> device(ISOW1432) datasheet
> https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=1682607122706&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-everything%2526usecase%253DOPN
> 
> rts-gpios is optional property, because it is not required
> for uart console node.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Modify optional gpio name to xlnx,phy-ctrl-gpios.
> Update commit description.
> Changes for V3:
> Modify optional gpio name to rts-gpios.
> Update commit description.
> ---
>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index e35ad1109efc..7ee305f9a45f 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -46,6 +46,11 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  rts-gpios:
> +    description: Optional GPIO to control transmit/receive on RS485 phy
> +      in halfduplex mode.

You need to define what 'active' means here because -gpios all have an 
active flag. Is it always active low (or high) or depends on the board?


> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -55,6 +60,7 @@ required:
>  
>  allOf:
>    - $ref: serial.yaml#
> +  - $ref: rs485.yaml#
>    - if:
>        properties:
>          compatible:
> -- 
> 2.25.1
> 
