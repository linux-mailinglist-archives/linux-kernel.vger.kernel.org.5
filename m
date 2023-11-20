Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3A7F173F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjKTP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKTP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:27:47 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3BBE;
        Mon, 20 Nov 2023 07:27:40 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3575287211bso13961605ab.1;
        Mon, 20 Nov 2023 07:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494060; x=1701098860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgW5SEQguH7SJ47xdmCLdbSDRQKiHAPQcIcWrlriANo=;
        b=uHoDOKubZF16oc2+IfygWw99wX1YMt8iVY2DjT4YZL0Km5BVI1FMl7HmlZM3yNjwNy
         0hkGu3XIfaEBCnMIMVuUISJxxXjxnaHPs/foSxIpK806cn+1QVRJTaqYZj/aPV9FXS2X
         AWSMcea1gvG/aHzLQEEudIqVxwT+XwBPbF4Rsxq2UdCTBRJN3tyfXDmxdr7fiVtTusFR
         xtBPMmd0RvI7GwZlKaCNDR2SWKA4SEtNlviymKq20CrQW8WRdrUh6lPx/lOggP6/EPr8
         V8uf84ihuC7PdRXDoLE48WAAkY6YBns4IFqKHa7RK/YUsrudNS2HUIAxu94p0pg+3htm
         ysaA==
X-Gm-Message-State: AOJu0Yyb3KkCWRV8oYzSt+Dj0WiyzF2PqSQGjA9n0UIiJAAjAuUocgv+
        2lEC8m0H+1kLDrkwf4ddSBWTXoMBpw==
X-Google-Smtp-Source: AGHT+IFBGjZpsv53gTkd10OuGcHTWcMkLDOJQ6232YyHYlHy2VRxBiMBYntlRcIwnf3DwcR58AGyCQ==
X-Received: by 2002:a05:6e02:b4d:b0:35a:b6ce:cedf with SMTP id f13-20020a056e020b4d00b0035ab6cecedfmr9531304ilu.13.1700494060141;
        Mon, 20 Nov 2023 07:27:40 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h18-20020a056638339200b00466601630f4sm408478jav.174.2023.11.20.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:27:39 -0800 (PST)
Received: (nullmailer pid 2044075 invoked by uid 1000);
        Mon, 20 Nov 2023 15:27:37 -0000
Date:   Mon, 20 Nov 2023 08:27:37 -0700
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
Subject: Re: [PATCH 1/3] dt-bindings: power: reset: Convert mode-.*
 properties to array
Message-ID: <20231120152737.GA283159-robh@kernel.org>
References: <20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com>
 <20231117-arm-psci-system_reset2-vendor-reboots-v1-1-03c4612153e2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117-arm-psci-system_reset2-vendor-reboots-v1-1-03c4612153e2@quicinc.com>
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

On Fri, Nov 17, 2023 at 01:18:46PM -0800, Elliot Berman wrote:
> PSCI reboot mode will map a mode name to multiple magic values instead
> of just one. Convert the mode-.* property to an array with default
> number of items limited to 1.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> index ad0a0b95cec1..2c786e783464 100644
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -28,13 +28,16 @@ description: |
>  
>  properties:
>    mode-normal:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: "#/patternProperties/^mode-.*$"
>      description:
>        Default value to set on a reboot if no command was provided.
>  
>  patternProperties:
>    "^mode-.*$":
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    # Default to one value. Bindings that reference this schema could override.
> +    minItems: 1
> +    maxItems: 1

There are no overrides in json-schema, so this won't work. 

It happens to work though. It has to do with how we process the schemas 
because every integer property is decoded into a 2 dimensional array. So 
we process the schemas to convert schemas for scalars and arrays into 
a matrix. This hit a corner case where we bail on doing any fixup when 
maxItems is 1, but really it should be transformed into:

maxItems: 1
items:
  maxItems: 1

Which would then fail on your case with 2 entries. You need 'maxItems: 
1' everywhere just 1 entry is expected (e.g. mode-normal) and no 
constraints here. 

Rob


>  
>  additionalProperties: true
>  
> 
> -- 
> 2.41.0
> 
