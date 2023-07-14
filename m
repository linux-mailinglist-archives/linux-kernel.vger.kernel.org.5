Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32485753FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjGNQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjGNQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:20:27 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E0E1FD4;
        Fri, 14 Jul 2023 09:20:26 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7835ffc53bfso47415139f.1;
        Fri, 14 Jul 2023 09:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351625; x=1691943625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks/N8qO3TGYZSSU8M3e1qV+E67ZahtCJLwxQg7T5z6Y=;
        b=YIqi9O9wm4/nvKpvj9jf2ux2OtM1qmW63jx0KZzRqpOPUSnRMofz9t8uZdW/VJdkU1
         JC48qAX+qAqX6SUvNIuO0GQDezG1M6aCTxKw/4PF9g3qSeOhy+wnxbFf9+XT47w3D+87
         jJbI03+lFQO8BxOUhZ9yX0NHL/On/SSGlZ7By8smE0kuVCkNklnBgey8vqzEbvkTl9RJ
         L8jXdE24/XVC+Lzcvn2WuAgs4FKetyJrYYnB4fRQ+LAaOvD7iFb/JTHzLiixGfliUn6b
         H2iWfsch4f7Xrz1T1z3k/M3v3GBpQq7/+VSQhJIsOwpt9Ek3W3hEZ8lf44afd2jpnP0v
         UC1A==
X-Gm-Message-State: ABy/qLa/BuoEb1Qsj6zhsFONpl4twKRFm6wgP5dWErQhoQVc2aFBBgMJ
        1Nu0zW2PYUy+t3rmwhJZ9g==
X-Google-Smtp-Source: APBJJlHfUJOPb77/ZakiHQ7/15o5r47CcF5ODwjLT23eGq28ZdiCY+FAsp/pZrrMo8lGwTb9HK1bew==
X-Received: by 2002:a5e:c602:0:b0:787:147b:b54f with SMTP id f2-20020a5ec602000000b00787147bb54fmr2243528iok.3.1689351625671;
        Fri, 14 Jul 2023 09:20:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h2-20020a6bfb02000000b0078680780694sm2744063iog.34.2023.07.14.09.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:20:25 -0700 (PDT)
Received: (nullmailer pid 3945795 invoked by uid 1000);
        Fri, 14 Jul 2023 16:20:23 -0000
Date:   Fri, 14 Jul 2023 10:20:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mtd: Add SEAMA partition bindings
Message-ID: <168935162277.3945742.14750868917438308947.robh@kernel.org>
References: <20230713-seama-partitions-v4-0-69e577453d40@linaro.org>
 <20230713-seama-partitions-v4-1-69e577453d40@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713-seama-partitions-v4-1-69e577453d40@linaro.org>
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


On Thu, 13 Jul 2023 00:16:41 +0200, Linus Walleij wrote:
> This types of NAND partitions appear in OpenWrt and
> U-Boot.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Drop false flagged cells etc.
> ChangeLog v2->v3:
> - Drop reference from partitions.yaml again
> - Drop select: false
> - Use unevaluatedProperties
> ChangeLog v1->v2:
> - Fix up the binding to be childless
> ---
>  .../devicetree/bindings/mtd/partitions/seama.yaml  | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

