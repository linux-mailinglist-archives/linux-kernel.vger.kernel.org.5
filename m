Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E47EB804
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjKNUz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:55:25 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAD8F7;
        Tue, 14 Nov 2023 12:55:21 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b3ec45d6e9so3762484b6e.0;
        Tue, 14 Nov 2023 12:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699995321; x=1700600121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIyZacgk6S1OCcTjtB2x/jGVvrFkkIc75HS1ohr9rw0=;
        b=Wec5m83lmYzxMsSiaMcZfqeJEvVZac2TspXV7Y0DN0CnWCZ4CftGGZqeFgc8m0rmIZ
         revnkdbNPPxebMlo05qRFMJYa8cEtu+4+Y6PA+ZuFOmKsNDt362eIJ2RLTSxxRJZIuF6
         cniuOV32r9UHlnoOxBTe/Lpk5Q5NNsenZxuLIaYZBQF11RpQtVD8iZHZGb1fGZIsWN9e
         LTXqzbkN4OKA5d5n4uXCtEDvQp24FWO2yLo0mOOjRLCAeS4pfaZQpmh5wbQuCWJeS/4v
         GL879TIfQGFCJA4cIL2gpLzRIWJ8W2bVqF6jUvKAUDuy3DhIPhfi9QiDBvJb4rbBQfqC
         LWMQ==
X-Gm-Message-State: AOJu0Yy5o4x8q0NY/BekTqtwND25PHaEW+2sZVbZOTf7aenpxKnMPP6h
        yq0dB+MeQiUd9kaQv8Ew1A==
X-Google-Smtp-Source: AGHT+IF9EMTXnsDP4dXbwjDX/QcXqA94zVtNWHFss6ofE8jc8Tax5KLxSNIdI2pqtqUMn7Pg3tau6w==
X-Received: by 2002:a05:6808:3193:b0:3af:6634:49b9 with SMTP id cd19-20020a056808319300b003af663449b9mr15358533oib.30.1699995321077;
        Tue, 14 Nov 2023 12:55:21 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y15-20020a056808060f00b003b3ec15d8ebsm1258644oih.5.2023.11.14.12.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:55:20 -0800 (PST)
Received: (nullmailer pid 496725 invoked by uid 1000);
        Tue, 14 Nov 2023 20:55:19 -0000
Date:   Tue, 14 Nov 2023 14:55:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: connector: Add child nodes for
 multiple PD capabilities
Message-ID: <20231114205519.GA472975-robh@kernel.org>
References: <20231030171348.600621-1-kyletso@google.com>
 <20231030171348.600621-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030171348.600621-2-kyletso@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 01:13:47AM +0800, Kyle Tso wrote:
> Commit 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB
> Type-C") allows userspace to configure the PD of a port by selecting
> different set of predefined PD capabilities. Define the PD capability
> sets in DT for better configurability in device modules.

What Linux userspace does is irrelevant to bindings. Explain this in 
terms of the h/w having multiple capabilities. I'm still not clear how 
this is tied to the h/w rather than just multiple configurations within 
the limits of what the h/w can support.

> 
> Define a child node "capabilities" to contain multiple USB Power
> Delivery capabilities.
> 
> Define a child node with pattern (e.g. caps-0, caps-1) under
> "capabilities". Each node contains PDO data of a selectable Power
> Delivery capability.
> 
> Also define common properties for source-pdos, sink-pdos, and
> op-sink-microwatt that can be referenced.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> v2 -> v3
> - Updated the commit message
> - Remain unchanged for the comments about the property/node refactor
> 
> .../bindings/connector/usb-connector.yaml     | 80 +++++++++++++------
>  1 file changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 7c8a3e8430d3..d7ece063cb2c 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -120,28 +120,10 @@ properties:
>    # The following are optional properties for "usb-c-connector" with power
>    # delivery support.
>    source-pdos:
> -    description: An array of u32 with each entry providing supported power
> -      source data object(PDO), the detailed bit definitions of PDO can be found
> -      in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
> -      Source_Capabilities Message, the order of each entry(PDO) should follow
> -      the PD spec chapter 6.4.1. Required for power source and power dual role.
> -      User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
> -      defined in dt-bindings/usb/pd.h.
> -    minItems: 1
> -    maxItems: 7
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    $ref: "#/$defs/source-pdos"
>  
>    sink-pdos:
> -    description: An array of u32 with each entry providing supported power sink
> -      data object(PDO), the detailed bit definitions of PDO can be found in
> -      "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> -      Sink Capabilities Message, the order of each entry(PDO) should follow the
> -      PD spec chapter 6.4.1. Required for power sink and power dual role. User
> -      can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
> -      in dt-bindings/usb/pd.h.
> -    minItems: 1
> -    maxItems: 7
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    $ref: "#/$defs/sink-pdos"
>  
>    sink-vdos:
>      description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
> @@ -167,9 +149,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>  
>    op-sink-microwatt:
> -    description: Sink required operating power in microwatt, if source can't
> -      offer the power, Capability Mismatch is set. Required for power sink and
> -      power dual role.
> +    $ref: "#/$defs/op-sink-microwatt"
>  
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
> @@ -231,6 +211,30 @@ properties:
>        SNK_READY for non-pd link.
>      type: boolean
>  
> +  capabilities:
> +    description: A child node to contain all the selectable USB Power Delivery capabilities.
> +    type: object
> +
> +    patternProperties:
> +      "^caps-[0-9]+$":
> +        description: Child nodes under "capabilities" node. Each node contains a selectable USB
> +          Power Delivery capability.
> +        type: object
> +
> +        properties:
> +          source-pdos:
> +            $ref: "#/$defs/source-pdos"
> +
> +          sink-pdos:
> +            $ref: "#/$defs/sink-pdos"
> +
> +          op-sink-microwatt:
> +            $ref: "#/$defs/op-sink-microwatt"
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
>  dependencies:
>    sink-vdos-v1: [ sink-vdos ]
>    sink-vdos: [ sink-vdos-v1 ]
> @@ -238,6 +242,36 @@ dependencies:
>  required:
>    - compatible
>  
> +$defs:
> +  source-pdos:

Rather than a bunch a $refs to per property definitions, define the 
collection of properties and then reference that collection:

$defs:
  capabilities:
    type: object

    properties:
      source-pdos: ...

And then at the node level, make the reference:

"^caps-[0-9]+$":
  $ref: "#/$defs/capabilities"
  unevaluatedProperties: false

Rob
