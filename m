Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80CC7DD54A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376507AbjJaRtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376499AbjJaRtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:49:01 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54375A2;
        Tue, 31 Oct 2023 10:48:57 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1e58a522e41so3875187fac.2;
        Tue, 31 Oct 2023 10:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774536; x=1699379336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdaTPJsXqIHOucHzCdun/EqSJIRhPJOCqxmQb8M0g5Y=;
        b=Ajxryd5R/twR3FQrnIkrMuFLz+U8mxHXyteK9oTa3qaotkbc/I1MzAwQLPqkOtZDxf
         CvBkDj7jarf1UDMwkyfTQVKZSWIkPhw4yUqn0YCZFmLodxkTNxk/iLRFTV7SfZJK10rm
         xQ33Fo6tTlia85OAUQKQx703c6LA/BplDiDx7eV3GoIqTI+U3/5nYJuNSLk7aPIV4mgS
         0aj0Ni7IJyZrsYq6kC2nwmRGbjaDoM77Fb9R5ZbrYzge5UizkbcRCeLEQ4+1ENMtw/oC
         nUUz/4z1fYNd6e7wpLkMTt9ZTkJJGyKy1r6GcXm8o8kTKFcwXqSegbMLAcrv2SpGLky8
         IytQ==
X-Gm-Message-State: AOJu0YyK5LY/v71nPEPOETfDkO3x2bTbxIQjVGHFS0XXjZ0cq4Hg+5um
        IWNtjJTXqkZR4QqTrGLUFg==
X-Google-Smtp-Source: AGHT+IH2YG550XxnQH8UOhD4J94+Qb8MgDxM/DPKTXhCyhyz+ngBxbaoqHgxFHttqbv746aMi53eLg==
X-Received: by 2002:a05:6871:4e8a:b0:1ef:c637:2688 with SMTP id uk10-20020a0568714e8a00b001efc6372688mr9443433oab.8.1698774536460;
        Tue, 31 Oct 2023 10:48:56 -0700 (PDT)
Received: from herring.priv ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id 28-20020a056870135c00b001dd8c46ed49sm365802oac.8.2023.10.31.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:48:55 -0700 (PDT)
Received: (nullmailer pid 1800907 invoked by uid 1000);
        Tue, 31 Oct 2023 17:48:55 -0000
Date:   Tue, 31 Oct 2023 12:48:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH RFC 1/2] dt-bindings: arm: Document reboot mode magic
Message-ID: <20231031174855.GA1797181-robh@kernel.org>
References: <20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com>
 <20231030-arm-psci-system_reset2-vendor-reboots-v1-1-dcdd63352ad1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-arm-psci-system_reset2-vendor-reboots-v1-1-dcdd63352ad1@quicinc.com>
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

On Mon, Oct 30, 2023 at 02:31:33PM -0700, Elliot Berman wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 0c5381e081bd..dc23e901bd0a 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -122,6 +122,19 @@ patternProperties:
>        [3] Documentation/devicetree/bindings/power/power-domain.yaml
>        [4] Documentation/devicetree/bindings/power/domain-idle-state.yaml
>  
> +  "^reboot-mode-.*$":
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Describes a vendor-specific reset type. The string after "reboot-mode-"
> +      maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
> +
> +      Parameters are named reboot-mode-xxx = <type[, cookie]>, where xxx
> +      is the name of the magic reboot mode, type is the lower 31 bits
> +      of the reset_type, and, optionally, the cookie value. If the cookie
> +      is not provided, it is defaulted to zero.

Please use and possibly extend the existing reboot-mode binding.

> +
>  required:
>    - compatible
>    - method
> 
> -- 
> 2.41.0
> 
