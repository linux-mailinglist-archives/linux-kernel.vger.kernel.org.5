Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2FC7EE4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjKPQOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKPQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:14:30 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9586193;
        Thu, 16 Nov 2023 08:14:26 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce29d1db6eso1002218a34.1;
        Thu, 16 Nov 2023 08:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700151266; x=1700756066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPOuAU8vMYFh38SnQyp7EHt1Qwf+rn56I3qW71141fs=;
        b=PXRaeHWz8/nJo78qDYd+5PAM+a+QX9zTS9NXbwjVZTb11S1YXxxDO4a72uYzjqO9/+
         ldXSYNJqgyVeHDYgveY9+OTj2wYTquZuu1cUkgbZzyh42pxgj1cr0/uXtslTe4Fh6M7f
         2HHh6Js/LQJcvhQWJG5FxGhXPUkQ8xqcTi2zNwsMSiXhG4qV9Yzg7mIgKDJjUY5dhEi9
         ymw4X5wUXxh/UbHN1YG/iGNIXAQfKfPk/OG5FAn7gIL2LkUsyJcmtDW1Pc1ncKWZvXJ/
         WTO/zfJ+WYEb9Z3jZiPt2nMFFY9sJbGVsHUSI00TIra+XLd21THnLweHEFVculRFYBAd
         ZhdQ==
X-Gm-Message-State: AOJu0Yz0hgGXYwYSY1Vm87ezXfH3f+f8TPNcVG2lYNa+aWHmRnjMcze0
        iGirf3lwUfS3OVIbCTFeJA==
X-Google-Smtp-Source: AGHT+IHagwFA/Ipg+5SXMbyxN/5DDa33QMtCNElCnTRYpdPtJEU3ZSt1nVnaxpEMdf9BOCBTXSJDYw==
X-Received: by 2002:a05:6830:2b20:b0:6c2:1ff0:b2e1 with SMTP id l32-20020a0568302b2000b006c21ff0b2e1mr1062290otv.4.1700151266031;
        Thu, 16 Nov 2023 08:14:26 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s30-20020a056830439e00b006ce2e464a45sm952501otv.29.2023.11.16.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:14:25 -0800 (PST)
Received: (nullmailer pid 2422343 invoked by uid 1000);
        Thu, 16 Nov 2023 16:14:24 -0000
Date:   Thu, 16 Nov 2023 10:14:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linu Cherian <lcherian@marvell.com>
Cc:     devicetree@vger.kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, suzuki.poulose@arm.com,
        james.clark@arm.com, gcherian@marvell.com, leo.yan@linaro.org
Subject: Re: [PATCH v5 1/7] dt-bindings: arm: coresight-tmc: Add
 "memory-region" property
Message-ID: <170015126381.2422288.18051157836489485044.robh@kernel.org>
References: <20231110112533.2499437-1-lcherian@marvell.com>
 <20231110112533.2499437-2-lcherian@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110112533.2499437-2-lcherian@marvell.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Nov 2023 16:55:27 +0530, Linu Cherian wrote:
> memory-region 0: Reserved trace buffer memory
> 
>   TMC ETR: When available, use this reserved memory region for
>   trace data capture. Same region is used for trace data
>   retention after a panic or watchdog reset.
> 
>   TMC ETF: When available, use this reserved memory region for
>   trace data retention synced from internal SRAM after a panic or
>   watchdog reset.
> 
> memory-region 1: Reserved meta data memory
> 
>   TMC ETR, ETF: When available, use this memory for register
>   snapshot retention synced from hardware registers after a panic
>   or watchdog reset.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v4:
> * Description is more explicit on the usage of reserved trace buffer
>   regions
> * Removed "mem" suffix from the memory region names
> 
>  .../bindings/arm/arm,coresight-tmc.yaml       | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

