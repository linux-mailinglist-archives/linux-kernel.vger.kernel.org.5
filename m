Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5978A1B6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjH0VCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjH0VB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:01:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE74B5;
        Sun, 27 Aug 2023 14:01:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50078eba7afso4059410e87.0;
        Sun, 27 Aug 2023 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693170110; x=1693774910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulpChpcoy8VlUT/kLKfOHdPOjX+o2BAu8P/16CYMK0s=;
        b=RkZzDQPfUqj6F5fdvcMHzxoVR00+KYXLWxAOsSYAZNYJZ4ljhNN9I+wqLOGyDHiMnY
         CQphZse3aOylU/9IZPZ1aaFu4w1cdLx4xqh4wqfdONz9AYHykj2B3c992BX3DpNwD86i
         1xsabOhbm5HyLgNnv8N5fPdpUU31Bvxg4BXHP0pyfwkSx5akZzC5wn5gftVCN5gG74T3
         8TerNlPig64gtArmqucYjto90irA4FA6NpQGxYKoc5L6DCtQs0z8Qef1JAsaEW/+AvPM
         UjVu9IKuCoV64voI1Z6xIcfg3Ku2/KRbvx/VgSugSl15sUkV4G14Wd2itJzplGjsbeID
         +RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693170110; x=1693774910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulpChpcoy8VlUT/kLKfOHdPOjX+o2BAu8P/16CYMK0s=;
        b=XnssbF+OvYbAW5vIrTPsMfkx0C3Q3tPsaUjKfDOYIXqcibaIRUvUSQsWOk5o421HaP
         c1sF3fWdUIe8ULB88DbzJBaTrzDezEaPK9pkBJOYnSTqA7rVVEEtiD9ELSF+DLcTI8cW
         DqUWFF2bj7Oe14+jHo3Q4tJzyevhTZNhIEnUagUm8G4ngSmNk5ttLag1k3xUOBrCKk8U
         SVexIXM48UghKb6rJedPBBcJz2Kxs/FUzitmGBrvPFe4VvS3bNZF9a6BMREZbzgCvzG8
         BPutYiLmVWlB2SAYWrJSBTRdr+i7Z/mt0mwFDA7LG1PhXYaj9M2MTlRRq4l+khBGoEOV
         al5A==
X-Gm-Message-State: AOJu0YwaHDRrVEtP3GhGU+WH6IUybyPEL82jkxG6V2700QjAivcmtbiB
        MP8N08Z/2RgJ7A1P06zlSZY=
X-Google-Smtp-Source: AGHT+IH7O3PchMh/vNAPMm9q+TNABaGxipRSESTad+5nesBzrvn2XS6gxhHJZi8/rdjfw4c+YKBc3Q==
X-Received: by 2002:a05:6512:4012:b0:4fe:8ba9:4c4 with SMTP id br18-20020a056512401200b004fe8ba904c4mr21079937lfb.59.1693170109841;
        Sun, 27 Aug 2023 14:01:49 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004ff748f6f1fsm1280986lff.69.2023.08.27.14.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 14:01:49 -0700 (PDT)
Date:   Mon, 28 Aug 2023 00:01:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Message-ID: <q7o7wqodz5epyjdj7vlryaseugr2fjhef2cgsh65trw3r2jorm@5z5a5tyuyq4d>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com>
 <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
 <c32130ab-27dc-e991-10fd-db0fba25cc97@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32130ab-27dc-e991-10fd-db0fba25cc97@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Sun, Aug 27, 2023 at 09:56:06AM +0200, Krzysztof Kozlowski wrote:
> On 26/08/2023 23:04, Serge Semin wrote:
> >> +  clock-names:
> >> +    items:
> >> +      - const: stmmaceth
> > 
> >   clock-names:
> >     const: stmmaceth
> > ?
> 

> The existing syntax is correct. This is a string array.

Could you please clarify whether it's a requirement (always specify
items: property for an array) or just an acceptable option (another
one is suggested in my comment)? I am asking because:
1. In this case the "clock-names" array is supposed to have only one
item. Directly setting "const: stmmaceth" with no items: property
shall simplify it.
2. There are single-entry "clock-names" property in the DT-bindings
defined as I suggested.
3. There is a "compatible" property which is also a string array but
it can be defined as I suggested (omitting the items property).

so based on all of that using the "items:"-based constraint here seems
redundant. Am I wrong to think like that? If so in what aspect?

-Serge(y)

> 
> > 
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> > 
> >> +  interrupt-names:
> >> +    items:
> >> +      - const: macirq
> > 
> >   interrupt-names:
> >     const: macirq
> > ?
> 
> As well.
> 
> > 
> >> +
> >> +  loongson,ls1-syscon:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description:
> >> +      Phandle to the syscon containing some extra configurations
> >> +      including PHY interface mode.
> >> +
> > 
> >> +  phy-mode:
> >> +    items:
> >> +      - enum:
> >> +          - mii
> >> +          - rmii
> > 
> >   phy-mode:
> >     enum: ...
> > ?
> 
> Here indeed, this is a string, not a list, so items are wrong.
> 
> 
> 
> Best regards,
> Krzysztof
> 
