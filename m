Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CF7D8A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbjJZVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjJZVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:30:57 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2041B1B1;
        Thu, 26 Oct 2023 14:30:55 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1e9baf16a86so828192fac.1;
        Thu, 26 Oct 2023 14:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355854; x=1698960654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n4F/tIjxEVGIj5feCsisIXTCZ4rtI6GeUYlCuKBavU=;
        b=qr6FpBzGaq4C7Ax6os7czQKyOcIP3P+vRkvVE5D3UfrVg0zENAWMs5LVobPZvauw4y
         77icmyXONUx3w0psMeNyXZSZhxitCCLR3SpIMkW0Hkj3sMeTJjJDSywy3vXs+0cBxpIw
         KAuLV67cRd8XjWfvG41EBnqYTGypPYiAiJrNyhMUqEsCpqb1/mrpXP1ZuTJb+xUcQw2F
         p45SFGXfbj0zJQoyIMQEuwFZb7w/jyl1jvmCsKz1MDe4YX+gWo5I/1LubNut/2+lmqS7
         psEjzPaZ1ZINDq6E4YRAcipVu1AJjQQyr6LvDHSEbLg1Y1DSTgarqwzHwg5ACr7VelDg
         2ZZQ==
X-Gm-Message-State: AOJu0Yy2as7tpXYJxIoqueKkQn+mxDiDyNbkPs/1ITkhXpRtFRbTcDcy
        DoKm0idrbKRsYWUxOx5ODw==
X-Google-Smtp-Source: AGHT+IH/UTjSPvCsr2fgIuKSuYiroRDllOssl+ncCKZugW4bfxWuuPSnaZRxrb51ueuli2AdceEjHQ==
X-Received: by 2002:a05:6870:d88b:b0:1db:70ee:efed with SMTP id oe11-20020a056870d88b00b001db70eeefedmr926701oac.18.1698355854334;
        Thu, 26 Oct 2023 14:30:54 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id xv8-20020a05687121c800b001e9dabc3224sm22171oab.50.2023.10.26.14.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:30:53 -0700 (PDT)
Received: (nullmailer pid 432395 invoked by uid 1000);
        Thu, 26 Oct 2023 21:30:52 -0000
Date:   Thu, 26 Oct 2023 16:30:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu: document the SM8650 System
 MMU
Message-ID: <169835584978.432274.5480293102736245515.robh@kernel.org>
References: <20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-smmu-v1-1-bfa25faa061e@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 09:30:04 +0200, Neil Armstrong wrote:
> Document the System MMU on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

