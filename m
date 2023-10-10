Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26297C019D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjJJQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjJJQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:28:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694F9D;
        Tue, 10 Oct 2023 09:28:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5BDC433C8;
        Tue, 10 Oct 2023 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696955330;
        bh=dZZKpZb7/IrHqlUDIL57KB0JnLLJTBKUAfjmfWFKd3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IUrtf2ZnIH79dMMyNf+Ugws9XsYhHqEF5n1FQKToIOY7tDeeesubk3zQ4pwrpJcLP
         PQOp96npG8t6fluGUNlfcLCFdnMKSuznJEiULqz7zZpKgInNR4GSKiE03TB/0u4JKk
         tjNOUVEHWHVWhdKVtZvHkWPChZn+F/OqoccYYKL1yVLQDn9aoPNmAHQO4dauUuJ+UE
         OWB0Y8z6nWKopSrSvJCO+EIAaBIDdzZGsUC5Y3AIyBiv94vjkZ3VLg+VUUQfIUUbwu
         U+N1/UyOlxGI230H5ZNafLr8RZYHHmidVOvgStxEnLKzlyTDFsxg4BbnyjfNh2zdG5
         oMSs5VDrcxPPQ==
Date:   Tue, 10 Oct 2023 17:28:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: add missing reset-gpios constrain
Message-ID: <20231010172859.45efe481@jic23-huawei>
In-Reply-To: <20231005-thrift-backer-d2f58a1bd441@spud>
References: <20231005083650.92222-1-krzysztof.kozlowski@linaro.org>
        <20231005-thrift-backer-d2f58a1bd441@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 11:41:07 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Oct 05, 2023 at 10:36:50AM +0200, Krzysztof Kozlowski wrote:
> > The Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> > schema does not enforce number of reset GPIOs, thus each device binding
> > must do it.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> Thanks,
> Conor.
> 
> > ---
> >  Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 3 ++-
> >  Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml    | 3 ++-
> >  Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml | 3 ++-
> >  Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml | 3 ++-
> >  4 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > index 2594fa192f93..2a04906531fb 100644
> > --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > @@ -32,7 +32,8 @@ properties:
> >  
> >    spi-cpol: true
> >  
> > -  reset-gpios: true
> > +  reset-gpios:
> > +    maxItems: 1
> >  
> >    interrupts:
> >      minItems: 1
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> > index 4e508bfcc9d8..5121685337b5 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
> > @@ -78,7 +78,8 @@ properties:
> >            - const: -1000
> >            - const: 22000
> >  
> > -  reset-gpios: true
> > +  reset-gpios:
> > +    maxItems: 1
> >  
> >    adi,dc-dc-ilim-microamp:
> >      enum: [150000, 200000, 250000, 300000, 350000, 400000]
> > diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> > index b9b5beac33b2..5b6cde86b5a5 100644
> > --- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> > +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> > @@ -23,7 +23,8 @@ properties:
> >      maxItems: 1
> >      description: Connected to ADC_RDY pin.
> >  
> > -  reset-gpios: true
> > +  reset-gpios:
> > +    maxItems: 1
> >  
> >  required:
> >    - compatible
> > diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> > index 2958c4ca75b4..167d10bd60af 100644
> > --- a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> > +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> > @@ -23,7 +23,8 @@ properties:
> >      maxItems: 1
> >      description: Connected to ADC_RDY pin.
> >  
> > -  reset-gpios: true
> > +  reset-gpios:
> > +    maxItems: 1
> >  
> >  additionalProperties: false
> >  
> > -- 
> > 2.34.1
> >   

