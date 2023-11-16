Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8D7EE793
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbjKPThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:37:13 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE89518D;
        Thu, 16 Nov 2023 11:37:10 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b6d80daae8so748752b6e.2;
        Thu, 16 Nov 2023 11:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163430; x=1700768230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTiM3Vx2Z00v7vELLs+yZh7frKPcveszM1p35EHmL2Q=;
        b=OrVEvX/XicCaUBf4QXLDpyC2X9tiy+lPEYDpgQHXEem3yQ5v4grJjZjjckH5lH86BO
         gp5dXNRFXarpFXr/6Y6C7hkjcPU4x967z7LUlDsHPkK1SBDuZwBkNnFO9HoVhI+tbDvQ
         RofGAElqaIC6h5UtMH7kygqRnF87iztAzXWlR+wrp41rydtqf5j9myYV8Oyop0PA7rPA
         FNGehH4sTG77Cy9I5qtHxrpg0Lsqe0x89hRW+BzJ7vjan8h6FVeQkvRyd/kOds2Wmqml
         MYHOdk3lteSO5RVJzu0pJ9PeTzmpUCiaU0Cy3t41ZxAofUMgUC3RY0fccxEL18eaShgo
         lLTg==
X-Gm-Message-State: AOJu0YyLW1EnLtgYPd3wBzGxUsrN4ZmTfLjR9LcOXV7mRoTaQsASZEE9
        7fQ5wN0mb78hqlgafW6aLw==
X-Google-Smtp-Source: AGHT+IE8ys7SU1YVHJlaGTBNcoWJAmWvenF90K1yeznAbtaB99iNH2W33EFr2hgMmUinNOH8K+TzEg==
X-Received: by 2002:a05:6808:2a42:b0:3ae:a6e:6ccc with SMTP id fa2-20020a0568082a4200b003ae0a6e6cccmr16496835oib.49.1700163429877;
        Thu, 16 Nov 2023 11:37:09 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r26-20020a0568080aba00b003ae5cb55513sm8343oij.38.2023.11.16.11.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:37:09 -0800 (PST)
Received: (nullmailer pid 3087009 invoked by uid 1000);
        Thu, 16 Nov 2023 19:37:07 -0000
Date:   Thu, 16 Nov 2023 13:37:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: dma: Convert ti-edma.txt to YAML
Message-ID: <170016342740.3086953.3986420759413989547.robh@kernel.org>
References: <20231114212911.429951-1-afd@ti.com>
 <20231114212911.429951-4-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114212911.429951-4-afd@ti.com>
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


On Tue, 14 Nov 2023 15:29:11 -0600, Andrew Davis wrote:
> Convert ti-edma.txt to ti/ti,edma3-tpcc.yaml and
> ti/ti,edma3-tptc.yaml.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes for v2:
>  - Fix dt_binding_check warning
> 
>  .../devicetree/bindings/dma/ti-edma.txt       | 238 ------------------
>  .../bindings/dma/ti/ti,edma3-tpcc.yaml        | 128 ++++++++++
>  .../bindings/dma/ti/ti,edma3-tptc.yaml        |  63 +++++
>  MAINTAINERS                                   |   1 -
>  4 files changed, 191 insertions(+), 239 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,edma3-tptc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

