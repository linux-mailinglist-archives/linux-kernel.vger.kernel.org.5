Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878A97FA940
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjK0Sur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjK0Suo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:50:44 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA15D53;
        Mon, 27 Nov 2023 10:50:50 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1f0f94943d9so2323955fac.2;
        Mon, 27 Nov 2023 10:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111050; x=1701715850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3bXET2IS76jIzfigzKYg8jJt8fngAdagUE+PXY9fpw=;
        b=tbk6JlRpQZDCG4ysF47qaV/ztuKW4SPaz6jjt1rLlosJVIt5D7SQa6Rwb61VTpp81p
         MLhR5mFxmkzuCke9bGl4bdY5ZJ2/TV21Rh1W1p6skd7rbHhKMrti6nXEU4jfWXzBTy81
         rZWj+x/wkrELrRPEleljsVTiT2qOAw3sSpkx2ZKZbllVglLq4S8FF0iGCXJlTZKZc98R
         ffCoyjKQcNAs5SCVuMVgiga11eDMG8e91kVjCf0o1/OmBuBaHmaOUvnYqr5UbYBVMcS2
         3S3z9EWSgmYieg8r2HEs2JJOd9UGq3egUFEV0SazrrCpZGVEmF4CwiRpM0TgpdTIbqNn
         lSaw==
X-Gm-Message-State: AOJu0Yz10ODXHSf7zkMe4AY1bV3X73i64mvHQ+AQZf5IdZ1olglZb8v5
        0YW8BcbCJnsDM8pheXcXYg==
X-Google-Smtp-Source: AGHT+IFu6MBtpvG30olCkRcT79pWOuBCeHq2F+wARXLqrblLRPuUmlli51A8gca9rI73GLBTtFURCQ==
X-Received: by 2002:a05:6870:3308:b0:1f9:efdb:966a with SMTP id x8-20020a056870330800b001f9efdb966amr13405063oae.44.1701111050091;
        Mon, 27 Nov 2023 10:50:50 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nz4-20020a056871758400b001fa2b18a175sm1288144oac.49.2023.11.27.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:50:49 -0800 (PST)
Received: (nullmailer pid 2390459 invoked by uid 1000);
        Mon, 27 Nov 2023 18:50:48 -0000
Date:   Mon, 27 Nov 2023 12:50:48 -0600
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
Subject: Re: [PATCH v3 1/3] dt-bindings: connector: usb: add altmodes
 description
Message-ID: <20231127185048.GA2291396-robh@kernel.org>
References: <20231120224919.2293730-1-dmitry.baryshkov@linaro.org>
 <20231120224919.2293730-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120224919.2293730-2-dmitry.baryshkov@linaro.org>
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

On Tue, Nov 21, 2023 at 12:00:18AM +0200, Dmitry Baryshkov wrote:
> Add description of the USB-C AltModes supported on the particular USB-C
> connector. This is required for devices like Qualcomm Robotics RB5,
> which have no other way to express alternative modes supported by the
> hardware platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/connector/usb-connector.yaml     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 7c8a3e8430d3..c1aaac861d9d 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -171,6 +171,28 @@ properties:
>        offer the power, Capability Mismatch is set. Required for power sink and
>        power dual role.
>  
> +  altmodes:
> +    type: object
> +    description: List of Alternative Modes supported by the schematics on the
> +      particular device. This is only necessary if there are no other means to
> +      discover supported alternative modes (e.g. through the UCSI firmware
> +      interface).

Move additionalProperties here.

> +
> +    patternProperties:
> +      "^(displayport)$":
> +        type: object
> +        description:
> +          A single USB-C Alternative Mode as supported by the USB-C connector logic.

Move additionalProperties here.

And a blank line

> +        properties:
> +          svid:
> +            $ref: /schemas/types.yaml#/definitions/uint16
> +            description: Unique value assigned by USB-IF to the Vendor / AltMode.

blank line

Since you've constrained the node name, then the only possible value 
here is 0xff01?

OTOH, I don't know that we want to enumerate all possible values here 
especially if there could be lots of vendor modes. But then again, maybe 
better to just wait and see if that becomes a problem.

With those nits fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
