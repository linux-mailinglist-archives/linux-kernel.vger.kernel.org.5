Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11C878B358
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjH1Ok0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjH1OkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6F2DA;
        Mon, 28 Aug 2023 07:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9926E649F2;
        Mon, 28 Aug 2023 14:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD19EC433C8;
        Mon, 28 Aug 2023 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693233594;
        bh=ASOEp2hV69z9TFQg3oNaTZ50Uctb1JLBn55dQLoHgr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JlbOVlh+b8ZYy9QHAKvkbOVpm1Z2wKeu3HcBlFbwKiu51ei5Rq+Cn2vJuXfwHBx3O
         4Q/AybfrK0OtL2bB6onD4ov6QYRnFGZQOexrLour/bxnVLYpIE8B8vXqbAkEMo/MO7
         mIZl+laEvzlsHQNhZ/fgn7BIsrZqQPe4BDu2TC6zQdK3kTSYqpXKQmV7qCG4GIw6le
         qlb/R15xxkDA4f/rvQpxhYFOqpoiiP5mrJiOolfmFQQE6kjnSK0R2/dSrTItUlIgOs
         ahj8w+VHBi/fAXNQYg+j+6Fb9OwLOcTwMM/SpXjGFtXO+1LHt1wzKDOuHJ9rWA64pt
         Ma7+tJdQ9pMdA==
Date:   Mon, 28 Aug 2023 15:40:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Mingjin Yang <mingjin.yang@unisoc.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, magicyangmingjin@gmail.com,
        Ling_Ling.Xu@unisoc.com, Jinfeng.Lin1@unisoc.com,
        Yangbin.Li@unisoc.com, Jiansheng.Wu@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V0 1/2] dt-bindings: iio: adc: Add support for ump518
 pmic adc
Message-ID: <20230828153930.73d879ba@jic23-huawei>
In-Reply-To: <20230816-dastardly-escapade-75597e244088@spud>
References: <20230816080225.21482-1-mingjin.yang@unisoc.com>
        <20230816080225.21482-2-mingjin.yang@unisoc.com>
        <20230816-dastardly-escapade-75597e244088@spud>
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

On Wed, 16 Aug 2023 15:44:55 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Aug 16, 2023 at 04:02:24PM +0800, Mingjin Yang wrote:
> > Add ump518 pmic adc description and sample in dt-bindings.
ADC

Description?  I'm seeing the compatible only which doesn't seem like
a description to me.



> > 
> > Signed-off-by: Mingjin Yang <mingjin.yang@unisoc.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml | 2 ++  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > index 8181cf9a8e07..f28d188d83da 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > @@ -21,6 +21,7 @@ properties:
> >        - sprd,sc2730-adc
> >        - sprd,sc2731-adc
> >        - sprd,ump9620-adc
> > +      - sprd,ump518-adc

alpha-numeric ordering probably worth retaining.
So I'd move this and the case below up one line.

Thanks,

Jonathan

> >  
> >    reg:
> >      maxItems: 1
> > @@ -46,6 +47,7 @@ allOf:
> >              contains:
> >                enum:
> >                  - sprd,ump9620-adc
> > +                - sprd,ump518-adc
> >      then:
> >        properties:
> >          nvmem-cells:
> > -- 
> > 2.17.1
> >   

