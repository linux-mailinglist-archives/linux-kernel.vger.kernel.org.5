Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7F87EE6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjKPSiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjKPSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:38:08 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C61A7;
        Thu, 16 Nov 2023 10:38:05 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b52360cdf0so651420b6e.2;
        Thu, 16 Nov 2023 10:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700159884; x=1700764684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeho3h+HAVBDv9G/PSHYV2/zarFxMGTF3N0k4i66FJg=;
        b=c4BVwWFg8o4R8EwD8RU6uwf56L5lIDCUgu2tC2VHvC82wgyLrFJgLETdEoKQvadplH
         sD0FHmSINrMoUPxCTL4bheQnNcjYJtOMPcnQ01JsBgtbhW8hXyAsO+nnmUgoAWHNH/7t
         IipC3q0R9x3ZvGi1eeWGJgtcF+Bgqmpav0o///itYx+B4WDtOYxCVETc//mUhP1T5rv8
         vabSvh24m8yMFi2WWx+o7acRd/ad4dWxUA4y4Es3GTz5ruNlJALM07Hylh8G4ghh+JZB
         5f3XrXFUHuSZ+DAQl90rZOpVWAw90dNxMySVnLENZMutd8jXLR4Ig8OeKXirH6zJVfqE
         lRLQ==
X-Gm-Message-State: AOJu0Yz0MaqTrmoSxLCDMOJonqSgd1m9UI0t/yi5MLRz5lnnADI/IM9l
        R0MVpi39oRAo9elE1ECBzA==
X-Google-Smtp-Source: AGHT+IFixWKD6eA44iq3pJ68KHhYiVVqCXKE3HIsaW5USb5QYRL930s1NmETTIDeBzkVl65jrL8GGw==
X-Received: by 2002:a05:6808:2a66:b0:3b2:dfa0:aea3 with SMTP id fu6-20020a0568082a6600b003b2dfa0aea3mr16712816oib.3.1700159884517;
        Thu, 16 Nov 2023 10:38:04 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a0568080a0700b003ae540759a0sm1905305oij.40.2023.11.16.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:38:03 -0800 (PST)
Received: (nullmailer pid 2816950 invoked by uid 1000);
        Thu, 16 Nov 2023 18:38:02 -0000
Date:   Thu, 16 Nov 2023 12:38:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: connector: usb: add altmodes
 description
Message-ID: <20231116183802.GB2742530-robh@kernel.org>
References: <20231113221528.749481-1-dmitry.baryshkov@linaro.org>
 <20231113221528.749481-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113221528.749481-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:13:27AM +0200, Dmitry Baryshkov wrote:
> Add description of the USB-C AltModes supported on the particular USB-C
> connector. This is required for devices like Qualcomm Robotics RB5,
> which have no other way to express alternative modes supported by the
> hardware platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/connector/usb-connector.yaml     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 7c8a3e8430d3..1bd51b86906f 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -14,6 +14,31 @@ description:
>    of a USB interface controller or a separate node when it is attached to both
>    MUX and USB interface controller.
>  
> +$defs:

I fail to see why we need to use $defs here.

> +  altmode-desc:
> +    type: object
> +    description:
> +      A single USB-C Alternative Mode as supported by the USB-C connector logic.
> +    properties:
> +      svid:
> +        $ref: /schemas/types.yaml#/definitions/uint16
> +        description: Unique value assigned by USB-IF to the Vendor / AltMode.
> +      vdo:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: VDO returned by Discover Modes USB PD command.

What's VDO?

These names are a bit short. Types for property names are global 
(mostly). Though this patch doesn't make it clear these were already in 
use.

> +
> +  altmodes-list:
> +    type: object
> +    description: List of Alternative Modes supported by the schematics on the
> +      particular device. This is only necessary if there are no other means to
> +      discover supported alternative modes (e.g. through the UCSI firmware
> +      interface).
> +
> +    patternProperties:
> +      "^[a-z][a-z0-9]*$":

Are there standard id's and names? Should we define some so we don't get 
'dp', 'displayport', etc.


> +        $ref: "#/$defs/altmode-desc"
> +        unevaluatedProperties: false
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -171,6 +196,10 @@ properties:
>        offer the power, Capability Mismatch is set. Required for power sink and
>        power dual role.
>  
> +  altmodes:
> +    $ref: "#/$defs/altmodes-list"
> +    unevaluatedProperties: false
> +
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
>      description: OF graph bindings modeling a data bus to the connector, e.g.
> @@ -289,6 +318,13 @@ examples:
>              compatible = "usb-c-connector";
>              label = "USB-C";
>  
> +            altmodes {
> +                displayport {
> +                    svid = /bits/ 16 <0xff01>;
> +                    vdo = <0x00001c46>;
> +                };
> +            };
> +
>              ports {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
> -- 
> 2.42.0
> 
