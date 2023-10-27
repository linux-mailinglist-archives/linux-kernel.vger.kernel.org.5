Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF6E7DA268
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjJ0VYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0VYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:24:44 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963A1AA;
        Fri, 27 Oct 2023 14:24:42 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57ad95c555eso1591012eaf.3;
        Fri, 27 Oct 2023 14:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441882; x=1699046682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vDjxeIztMYV+RXt8l5Ypmao9jXTVq+yUzzQl5hZC+s=;
        b=w8Sy377gb7+UhTnS97xxEHaBiHKASB2eEIlpToq5ot+vkKlkdVHKj8k7biEZVrkksU
         BZcrngyEBKkxKKghXSnAv1lFF0bXRDWmJSJLvKRg5z9Nk/8ELTVCYh9O7DEyrhdoCcIJ
         txeeB1zoZYzqRiV5JOG7kak9YQwGRRAARLl4R0mo9LzL2togdmCZLNEAHVddG/P5bmRr
         mXvYgBG7trieMsZNDIcZthLPPWl6M+ot6eo4JemfG5xCSuuvDcLGRMq3gFopfp07d4TU
         XVhYZPO5OXUjkiGY/Vbo1DJUjlEU/P1lQGyyJ6Qj8A70s91ydQNx8ky895LVH6yeEW5L
         brPA==
X-Gm-Message-State: AOJu0YzzjrnF5j476e6i9wwC+jVEJfoE4V2ufdLbxGjEd5+nxpgokCRf
        /38eIE2GfuflJ5ptAzSeD877MHIe7g==
X-Google-Smtp-Source: AGHT+IGGC9TsMVGuIaNtb+Rfr48y+2I0v+/38N6hSjofz8ifBeICH1sxB6MZPwbjZV4IZj+H/tJQuA==
X-Received: by 2002:a4a:da4f:0:b0:582:3c4a:923a with SMTP id f15-20020a4ada4f000000b005823c4a923amr3919973oou.9.1698441881891;
        Fri, 27 Oct 2023 14:24:41 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j9-20020a9d7f09000000b006b8b55297b5sm431607otq.42.2023.10.27.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:24:40 -0700 (PDT)
Received: (nullmailer pid 3397284 invoked by uid 1000);
        Fri, 27 Oct 2023 21:24:40 -0000
Date:   Fri, 27 Oct 2023 16:24:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] regulator: dt-bindings: Allow system-critical
 marking for fixed-regulator
Message-ID: <20231027212440.GA3392484-robh@kernel.org>
References: <20231026144824.4065145-1-o.rempel@pengutronix.de>
 <20231026144824.4065145-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026144824.4065145-4-o.rempel@pengutronix.de>
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

On Thu, Oct 26, 2023 at 04:48:22PM +0200, Oleksij Rempel wrote:
> In certain projects, the main system regulator, composed of simple
> components including an under-voltage detector and capacitors, can be
> aptly described as a fixed regulator in the device tree. To cater to
> such use cases, this patch extends the fixed regulator binding to
> support the 'system-critical-regulator' property. This property
> signifies that the fixed-regulator is vital for system stability.

There is no programming interface for fixed-regulators, so how do you 
know an under/over voltage condition?

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/regulator/fixed-regulator.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index ce7751b9129c..9ff9abf2691a 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> @@ -105,6 +105,8 @@ properties:
>      description:
>        Interrupt signaling a critical under-voltage event.
>  
> +  system-critical-regulator: true
> +
>  required:
>    - compatible
>    - regulator-name
> -- 
> 2.39.2
> 
