Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335FF7F4B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbjKVPpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjKVPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:41 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72F19B9;
        Wed, 22 Nov 2023 07:44:14 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7a6907e9aa8so241885739f.1;
        Wed, 22 Nov 2023 07:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667853; x=1701272653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4dpS05p/mJ7BidAcig/071dpPmGFzFkosRDxb1BEXI=;
        b=cmvAVTBaCabTtpTvTqLBgX6mlD08OCIZyZdOT6lfHc0bBvy89GI8ennHWNok9N46rw
         WLOtNNTZD+0ATSCbZdJOW1GpnZpQcBFDMpTIj4tUMi0/DizokhwuU3ZnkP1xZj88ma42
         cLHUeOJ8ppW8MFLM5xLOOyGOwoOcD+d4t+9Aq1+VbyqjzW/y7SaJjs5cxRo8lEL+6LkD
         pfGOV9aKBAX8y2EMThec7BlcKXrmnq2yCMlOloeLJVf86sOpU6www4M8sB39ItG3zNOB
         /ZQY5ptpRB47UCkvRHzrj8kCjtdFhiMr8DkHqD6n7NbRfz/gD/GU5QlX/rcWITEgetDJ
         tSTg==
X-Gm-Message-State: AOJu0YyhdVBbJP7C64YVHMwnvzn6iG2ElLEjQwbOkDD2p0OKkkinwLlz
        Xljjl7gH0sJrwbCqkXoCdA==
X-Google-Smtp-Source: AGHT+IFdvsmjGjiZbPH6hIOUd4lxrv5HA2eflYLz9TZQB1KYCeHxxAAixdP1WRqZ/Jf3MhCvgDT6JQ==
X-Received: by 2002:a6b:7402:0:b0:792:9a1a:228b with SMTP id s2-20020a6b7402000000b007929a1a228bmr2457321iog.2.1700667853692;
        Wed, 22 Nov 2023 07:44:13 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056638451200b0043167542398sm1925471jab.141.2023.11.22.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:44:13 -0800 (PST)
Received: (nullmailer pid 1179989 invoked by uid 1000);
        Wed, 22 Nov 2023 15:44:11 -0000
Date:   Wed, 22 Nov 2023 08:44:11 -0700
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        dmaengine@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 08/39] dt-bindings: dma: Add Cirrus EP93xx
Message-ID: <20231122154411.GA1155942-robh@kernel.org>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-8-d59a76d5df29@maquefel.me>
 <170065093445.115883.17187140881548762663.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170065093445.115883.17187140881548762663.robh@kernel.org>
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

On Wed, Nov 22, 2023 at 04:02:29AM -0700, Rob Herring wrote:
> 
> On Wed, 22 Nov 2023 11:59:46 +0300, Nikita Shubin wrote:
> > Add YAML bindings for ep93xx SoC DMA.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >  .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |  84 ++++++++++++
> >  .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        | 144 +++++++++++++++++++++
> >  2 files changed, 228 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.example.dts:24:18: fatal error: dt-bindings/soc/cirrus,ep9301-syscon.h: No such file or directory
>    24 |         #include <dt-bindings/soc/cirrus,ep9301-syscon.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

These can be ignored. Looks like patch 6 got delayed or something and 
didn't get applied with the series.

Rob
