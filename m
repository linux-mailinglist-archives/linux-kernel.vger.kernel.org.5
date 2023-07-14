Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D13753F88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjGNQJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjGNQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:09:16 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B1630F4;
        Fri, 14 Jul 2023 09:09:15 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-78374596182so84065139f.0;
        Fri, 14 Jul 2023 09:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350955; x=1691942955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwfN0AjJiCW6P2GxSV3v/bOqQB8wMErVeNdQNrLkhjY=;
        b=EuZU2lHh06H2deH6cjyvesoaqDI6fxVzSOeF3It1eWiAPyWti74IGr0t7NtLUVIIfs
         w3lIB9ZYyKW0VYejEc+uTkmMuzB7oENlWxDj1xcChqmkOZu1m279jZXEFsdRBNRXj3Pg
         vbe1QQm0HRzyiq17zeEwBSxX7RwFGO+kibgd29hQpVaRy/g3ANXvTpXKLTa93S3Doj61
         bjVl1dFdM8FN7H0BXFdLTQaGyiC/hKW4j7V3wi3WC3gk679aNyIRJZBhoh+3gJ7l6t1h
         lxUqvzHNCZ6OBmLOwhWbz1//D2owmK2SHuj+zU+Dl+af/YreFFiq53D1j/kS4hhWRiCO
         AC6g==
X-Gm-Message-State: ABy/qLZfUFkZZCw909+YXXDkPNq0jKogTkxezpYdJ7N3jJQ5OHIi4TWK
        1kfE9rGeWZ1sn0sCIdzwpoMctPPOlA==
X-Google-Smtp-Source: APBJJlHy30Aj8mI9J3Q4ry+hIBPJNXFvDCtic8YvzqUB9GkTBi83GV3C1ObysRCXM79iRuwMEJ9PJA==
X-Received: by 2002:a6b:f21a:0:b0:77a:e86a:c24b with SMTP id q26-20020a6bf21a000000b0077ae86ac24bmr5412087ioh.6.1689350954857;
        Fri, 14 Jul 2023 09:09:14 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k1-20020a02a701000000b0042b2df337ccsm2504326jam.76.2023.07.14.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:09:14 -0700 (PDT)
Received: (nullmailer pid 3933554 invoked by uid 1000);
        Fri, 14 Jul 2023 16:09:12 -0000
Date:   Fri, 14 Jul 2023 10:09:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: connector: Add child nodes for multiple
 PD capabilities
Message-ID: <20230714160912.GA3920890-robh@kernel.org>
References: <20230712072853.1755559-1-kyletso@google.com>
 <20230712072853.1755559-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712072853.1755559-2-kyletso@google.com>
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

On Wed, Jul 12, 2023 at 03:28:52PM +0800, Kyle Tso wrote:
> Define a new optional property "capabilities" which is a child node
> under connector to contain multiple USB Power Delivery capabilities.

Is multiple capabilities a USB spec thing or some Linux feature? I think 
DT should only define the limits of the h/w capabilities and if the OS 
wants to define multiple profiles within those limits that's its 
problem.

> 
> Define a new property with pattern (e.g. caps0, caps1) which is a child
> node under "capabilities". Each node contains PDO data of a selectable
> Power Delivery capability.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  .../bindings/connector/usb-connector.yaml     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 1c4d3eb87763..b8c96d0a127a 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -228,6 +228,50 @@ properties:
>        SNK_READY for non-pd link.
>      type: boolean
>  
> +  capabilities:
> +    description: A child node to contain all the selectable USB Power Delivery capabilities.
> +    type: object
> +
> +    patternProperties:
> +      "^caps[0-9]+$":

caps-[0-9] is more the convention.

> +        description: Child nodes under "capabilities" node. Each node contains a selectable USB
> +          Power Delivery capability.
> +        type: object
> +
> +        properties:
> +          source-pdos:

You are now defining the same property twice. You can use '$defs' to 
define common properties and then reference them. Or put all the PD 
properties into its own schema file and reference it.

> +            description: An array of u32 with each entry providing supported power
> +              source data object(PDO), the detailed bit definitions of PDO can be found
> +              in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
> +              Source_Capabilities Message, the order of each entry(PDO) should follow
> +              the PD spec chapter 6.4.1. Required for power source and power dual role.
> +              User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
> +              defined in dt-bindings/usb/pd.h.
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            minItems: 1
> +            maxItems: 7
> +
> +          sink-pdos:
> +            description: An array of u32 with each entry providing supported power sink
> +              data object(PDO), the detailed bit definitions of PDO can be found in
> +              "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
> +              Sink Capabilities Message, the order of each entry(PDO) should follow the
> +              PD spec chapter 6.4.1. Required for power sink and power dual role. User
> +              can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
> +              in dt-bindings/usb/pd.h.
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            minItems: 1
> +            maxItems: 7
> +
> +          op-sink-microwatt:
> +            description: Sink required operating power in microwatt, if source can't
> +              offer the power, Capability Mismatch is set. Required for power sink and
> +              power dual role.
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
>  dependencies:
>    sink-vdos-v1: [ 'sink-vdos' ]
>    sink-vdos: [ 'sink-vdos-v1' ]
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
