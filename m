Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3678F7CAB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjJPOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjJPOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:23:00 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930209B;
        Mon, 16 Oct 2023 07:22:58 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c63117a659so2758371a34.0;
        Mon, 16 Oct 2023 07:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697466178; x=1698070978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q24oMIepkEQYDflYYzSU9nnBh24OKjrQkkccReE3wAU=;
        b=DXjajUMHoZWwF0C+qWF5oA/N8elWgHF37Ct4haK7L/qfFWFMdZE90XPFHcGEWJadjb
         Zk18oFv8XGeEQ6Kp/ObTxSBIOCPbZqYLX+MI0RJYVqRv2/cQXKTRjl7G/X1q2DFc1Xk1
         nU1lWNqm4XwecOJmnLLrpExHxULHLtFOE15BbPoZxOSv09pBUDORxH9bDkhyix1Uh1BQ
         QA3AA3uwefEbF8UMUXls914FGOZXf5GMRIV+7cZI2g+R4UkJEf1NyGjGZtS/cAug8pVb
         PvUxI039a/4hDCa6Pr2B61rNh1DJ7xuHWtjO490i8psg0sk1yd7fwSkgIBBsqsQSEc4S
         aGEg==
X-Gm-Message-State: AOJu0YwCpigipwrHPPrxNeUwyaNGQFom53yaJT0wsZgp/ye/QbXBGOk0
        yyVeZ9jyuPMLTb9XhqPOgNCIHR9XJA==
X-Google-Smtp-Source: AGHT+IHDatH7iMrTU8/OQz9KXoChk5Xj9BDaKzNXuXVEEK0FA+cnAD8A1PfPH7soW8ENHm0VrAy/fA==
X-Received: by 2002:a05:6830:3:b0:6b8:7d12:423d with SMTP id c3-20020a056830000300b006b87d12423dmr32663851otp.18.1697466177828;
        Mon, 16 Oct 2023 07:22:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a8-20020a9d74c8000000b006b753685cc5sm1704647otl.79.2023.10.16.07.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:22:57 -0700 (PDT)
Received: (nullmailer pid 2766873 invoked by uid 1000);
        Mon, 16 Oct 2023 14:22:56 -0000
Date:   Mon, 16 Oct 2023 09:22:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: usb: fsa4480: Add data-lanes property
 to endpoint
Message-ID: <20231016142256.GA2754674-robh@kernel.org>
References: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
 <20231013-fsa4480-swap-v1-1-b877f62046cc@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-fsa4480-swap-v1-1-b877f62046cc@fairphone.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:38:05PM +0200, Luca Weiss wrote:
> Allow specifying data-lanes to reverse the SBU muxing orientation where
> necessary by the hardware design.

What situation in the hardware design makes this necessary. Please 
describe the problem.

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../devicetree/bindings/usb/fcs,fsa4480.yaml       | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> index f6e7a5c1ff0b..86f6d633c2fb 100644
> --- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> +++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> @@ -32,10 +32,37 @@ properties:
>      type: boolean
>  
>    port:
> -    $ref: /schemas/graph.yaml#/properties/port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
>      description:
>        A port node to link the FSA4480 to a TypeC controller for the purpose of
>        handling altmode muxing and orientation switching.
> +    unevaluatedProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            description:
> +              Specifies how the AUX+/- lines are connected to SBU1/2.

Doesn't this depend on the connector orientation? Or it is both that and 
the lines can be swapped on the PCB?

Seems like an abuse of data-lanes which already has a definition which 
is not about swapping + and - differential lanes.

Rob
