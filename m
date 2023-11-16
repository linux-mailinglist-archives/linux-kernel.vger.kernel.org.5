Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9860C7EE683
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjKPSNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKPSNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:13:18 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20164195;
        Thu, 16 Nov 2023 10:13:15 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1ea98ad294cso498466fac.3;
        Thu, 16 Nov 2023 10:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158394; x=1700763194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMupz1Ersx7G8Y0V72zO2fVjriizbVlDybDUE6gNC5o=;
        b=bOBwP9vJ6sjSMj3/4B88zzAQEgGXV1BlRP9pJTjaqsHUfbyRB3Z61IinR56Q4O3ZmH
         Q0SMKFSrEpJg49IDJg7jCaGdGBcyWo3oShGilyMzsgiJTN8iUKgjQVAh3/4bEXj0lFc/
         sQjvQsc5hZFndEtJ5GxR1K1LwZLlLTKqvfuqHOsWIJLiML4LiSh8YzKXEdQiySuTzMTj
         +ORxIlNy/b6UQoKSvdjQy6y82OiRV+dA/Yns4IzA4zYw5l7AAVjyXY1z1jF5eAhyd2eh
         EYyeaeASd3dw75i2MDBXRi+wilpxW1L9Gh5h0LTKgJE7R/NakpUI1YWEpHg4QY3yjBYA
         pVVQ==
X-Gm-Message-State: AOJu0YwXTg+hQGqYOAd2V3j96mSsEMyOW4fpfm9d3DnDT+/N6Zpdil0l
        vTBCWkxzpKyLlfb5FHN9GA==
X-Google-Smtp-Source: AGHT+IE4qXE3fwLtFQUpSkyT2Q9sqt2XnsLJBMw8YKmQlxdpMl7Oyy3/SUQgOiKwtUToqHuLJZXSQg==
X-Received: by 2002:a05:6870:538f:b0:1d5:aed5:6579 with SMTP id h15-20020a056870538f00b001d5aed56579mr17940362oan.4.1700158394319;
        Thu, 16 Nov 2023 10:13:14 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gc12-20020a056870678c00b001f48e4537b9sm2302007oab.33.2023.11.16.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:13:13 -0800 (PST)
Received: (nullmailer pid 2655665 invoked by uid 1000);
        Thu, 16 Nov 2023 18:13:11 -0000
Date:   Thu, 16 Nov 2023 12:13:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 2/5] dt-bindings: soc: sophgo: Add Sophgo syscon module
Message-ID: <20231116181311.GA2624502-robh@kernel.org>
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <3c286171af30101b88f0aaf645fb0a7d5880ac0a.1699879741.git.unicorn_wang@outlook.com>
 <20231114-timid-habitat-a06e52e59c9c@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-timid-habitat-a06e52e59c9c@squawk>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 05:40:20PM +0000, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 09:19:02PM +0800, Chen Wang wrote:
> > From: Chen Wang <unicorn_wang@outlook.com>
> > 
> > Add documentation to describe Sophgo System Controller Registers for
> > SG2042.
> > 
> > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >  .../soc/sophgo/sophgo,sg2042-syscon.yaml      | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
> > new file mode 100644
> > index 000000000000..829abede4fd5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-syscon.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo SG2042 SoC system controller
> > +
> > +maintainers:
> > +  - Chen Wang <unicorn_wang@outlook.com>
> > +
> > +description:
> > +  The Sophgo SG2042 SoC system controller provides register information such
> > +  as offset, mask and shift to configure related modules.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - sophgo,sg2042-syscon
> > +          - const: syscon
> 
> THere's only one option here, so the oneOf should be removed. Similarly,
> since there's only one SoC, and it sounds like the next large sophgo
> system is going to be using an entirely different core provider, I think
> should just simplify this to a pair of "const:" entries.

For a simple syscon binding like this, you can just add the compatible 
to syscon.yaml.

Rob
