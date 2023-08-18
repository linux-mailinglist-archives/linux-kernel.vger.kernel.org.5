Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD5780F59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378189AbjHRPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378299AbjHRPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B12D59;
        Fri, 18 Aug 2023 08:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC9865B75;
        Fri, 18 Aug 2023 15:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04772C433C7;
        Fri, 18 Aug 2023 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692373029;
        bh=fqELCtZ9RBHDqbr1cRywF4AY5uEuEdzLOaouQLACSyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irhzxcWrf/DtvMoA4/Rhtjvz2A4BAFJu+ilvJMrimEVDkcFtLY+NpiX6Rf8R3EuB2
         nuXo5b/9JIywFQvl0drCiQYWXrL1drGyyyL5uLdcf8tu1xnJoAX7hpI6KKFmhXVPMu
         AqdPNnwe1cQS5Z4A6J+mVYL13qeE6GLSP7OHg5K7f+j9qY+K1ofA32js1AuOQ6xErk
         FjRl+Hu3ncvdJmSB0L00G74aSmoo63bL4MVbs4MX9aX4d8puAETVaIkOSaQp0jR4dr
         tAow2i5jPPRzR/NgcFAwVAeZ0N+tJWocKMGLszXWAU5CuP4/l7Aqg6GU9aMIlW2AMs
         Bkt+P/E7GHPsg==
Date:   Fri, 18 Aug 2023 16:37:04 +0100
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
Message-ID: <20230818153704.GW986605@google.com>
References: <20230725123740.149559-1-krzysztof.kozlowski@linaro.org>
 <11b08764-87bd-1d9b-a1d2-603193231f40@linaro.org>
 <20230817115234.GC986605@google.com>
 <fa75415c-89fa-451b-2418-9f2fd6fab93f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa75415c-89fa-451b-2418-9f2fd6fab93f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023, Krzysztof Kozlowski wrote:

> On 17/08/2023 13:52, Lee Jones wrote:
> > On Tue, 25 Jul 2023, Krzysztof Kozlowski wrote:
> > 
> >> On 25/07/2023 14:37, Krzysztof Kozlowski wrote:
> >>> Each regulator node, which references common regulator.yaml schema,
> >>> should disallow additional or unevaluated properties.  Otherwise
> >>> mistakes in properties will go unnoticed.  unevaluatedProperties:false
> >>> requires listing existing properties (present in example and in other
> >>> regulators of this device).
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>> index 97c61097f9e2..1a1ced489ef7 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> >>> @@ -189,6 +189,16 @@ properties:
> >>>  
> >>>        "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
> >>>          $ref: ../regulator/regulator.yaml
> >>> +        unevaluatedProperties: false
> >>> +
> >>> +        properties:
> >>> +          interrupts:
> >>> +            maxItems: 1
> >>> +
> >>> +          st,mask-reset:
> >>> +            description: mask reset for this regulator, the regulator configuration
> >>> +              is maintained during pmic reset.
> >>> +            $ref: /schemas/types.yaml#/definitions/flag
> >>
> >> After further testing I see this patch is wrong. There are already
> >> buck[1-4] entries, so this is duplicating things. I will send v2.
> > 
> > Are you still planning on resending this set?
> > 
> 
> I already did and you took it. Email subject was different, though:

Understood, thanks for the clarification.

> https://lore.kernel.org/all/20230726065633.74924-1-krzysztof.kozlowski@linaro.org/
> Best regards,
> Krzysztof
> 

-- 
Lee Jones [李琼斯]
