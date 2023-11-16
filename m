Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD47EE78D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjKPTe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKPTe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:34:58 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E9192;
        Thu, 16 Nov 2023 11:34:55 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5872b8323faso586788eaf.1;
        Thu, 16 Nov 2023 11:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163294; x=1700768094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcjcJ6yC84qjYRKDtkrCm3IWQlELi8MIdlcWyAso3aI=;
        b=cAlVbRtE79xHkDw7Vl+DT1laY1A55fNWfU8LeB5lGZz1TiE+lcoq9wmM6abcxsmj7S
         nkMkqQ4l2y8QCucszlyd1cWJLlGLkRqvNKoDRebM7ImK7+3cl5uKCcEo1gK2jYHO5ASe
         s0lPN/KgWIyGjg1jmzlsfq3TRBKdLDPlumg2jIyUxbiQ/ztQcMjZEuPSgRsrWaWWi23G
         t95Voryoub9fx0vC3FgisyAZzVDN5y6MOSPu6ocLMcx12s5ANLplxz5HMHEb7xXA7IYY
         qdn7TQSH6Rr6rdO+5kqqJ4CVOuHZm4zL8RNe4XzHY3F7mytdAkWbGnj4XvPqWR59A5/Y
         0vcw==
X-Gm-Message-State: AOJu0YwatwSQtab2k+pylvypTTj7UGXtCIrbQp3o7pRzml8ULDPK0UwK
        JFv/SqMJkGawaZN8lyXFXg==
X-Google-Smtp-Source: AGHT+IE1k/pE704kJjj6JvCaj4cD+f1bZp3wmmUcVUY+DPlLnohekIjBe9RsbsFf9GrFOEXaMBLK/A==
X-Received: by 2002:a4a:ea0f:0:b0:587:2b3c:e11f with SMTP id x15-20020a4aea0f000000b005872b3ce11fmr19037504ood.0.1700163294242;
        Thu, 16 Nov 2023 11:34:54 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y7-20020a4aaa47000000b0058a193dbc7fsm14879oom.15.2023.11.16.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:34:53 -0800 (PST)
Received: (nullmailer pid 3084507 invoked by uid 1000);
        Thu, 16 Nov 2023 19:34:50 -0000
Date:   Thu, 16 Nov 2023 13:34:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: keystone: Convert keystone.txt
 to YAML
Message-ID: <170016329016.3084373.13644981441783739420.robh@kernel.org>
References: <20231114212911.429951-1-afd@ti.com>
 <20231114212911.429951-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114212911.429951-3-afd@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 15:29:10 -0600, Andrew Davis wrote:
> Convert keystone.txt to ti,keystone.yaml.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  Documentation/arch/arm/keystone/overview.rst  |  2 +-
>  .../bindings/arm/keystone/keystone.txt        | 42 ---------------
>  .../bindings/arm/keystone/ti,keystone.yaml    | 53 +++++++++++++++++++
>  3 files changed, 54 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,keystone.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

