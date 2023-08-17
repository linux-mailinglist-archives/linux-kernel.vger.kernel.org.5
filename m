Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7981677F5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350535AbjHQLwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350667AbjHQLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F26E4F;
        Thu, 17 Aug 2023 04:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB87261259;
        Thu, 17 Aug 2023 11:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8071FC433C8;
        Thu, 17 Aug 2023 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692273159;
        bh=aS1R/jCtUKchJK+GEF+wtWti/s/BvEvP1gcYy7Hq5zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyYLj4zKtJ2uDTHu3+MbkTcTTRdw6me/+W0vzq/FVkPqDHzN0ImGDHOcR+hGDPRiN
         8AySu3/TeEMRiuTRAWWOd7T16XAa+FqrF/aEQkpSzcXQn1D4MT+f8zRgXrFv5iqFip
         1r/HPtNAyXM3GyxePeoFtPV65ipAv4+2ORXabXpOJMAiO4owPxHy4223pTean9wJwv
         qB8DEYVZC8l9UY1wt9QeWtGM4MqPcmXKq2Qqperuu6KsZ15imuib4ha6l+cKn14Z5k
         RDIAf8gjlTvr/EthXeB32UuwCYnOSbunRJGZeFlYasnc55I/ZXMJe+6OnT2TAL4zA/
         peGilOVKWWP2A==
Date:   Thu, 17 Aug 2023 12:52:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: st,stpmic1: Add missing
 unevaluatedProperties for each regulator
Message-ID: <20230817115234.GC986605@google.com>
References: <20230725123740.149559-1-krzysztof.kozlowski@linaro.org>
 <11b08764-87bd-1d9b-a1d2-603193231f40@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11b08764-87bd-1d9b-a1d2-603193231f40@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023, Krzysztof Kozlowski wrote:

> On 25/07/2023 14:37, Krzysztof Kozlowski wrote:
> > Each regulator node, which references common regulator.yaml schema,
> > should disallow additional or unevaluated properties.  Otherwise
> > mistakes in properties will go unnoticed.  unevaluatedProperties:false
> > requires listing existing properties (present in example and in other
> > regulators of this device).
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> > index 97c61097f9e2..1a1ced489ef7 100644
> > --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> > @@ -189,6 +189,16 @@ properties:
> >  
> >        "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
> >          $ref: ../regulator/regulator.yaml
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          interrupts:
> > +            maxItems: 1
> > +
> > +          st,mask-reset:
> > +            description: mask reset for this regulator, the regulator configuration
> > +              is maintained during pmic reset.
> > +            $ref: /schemas/types.yaml#/definitions/flag
> 
> After further testing I see this patch is wrong. There are already
> buck[1-4] entries, so this is duplicating things. I will send v2.

Are you still planning on resending this set?

-- 
Lee Jones [李琼斯]
