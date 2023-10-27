Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BC7D9A92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbjJ0N6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345998AbjJ0N6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:58:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A6CA;
        Fri, 27 Oct 2023 06:58:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A372BC433C8;
        Fri, 27 Oct 2023 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698415107;
        bh=/xWES3FSiUGIU7b9EqfsoVSFchIzdwwI2L/BP4yA53M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cYnx02ElsXJcWsi2wvNWWubBIRh6jWo7nXNyKUOqSwHpJzunKMTEK3gmXvkye0DKa
         7WkcyhnwMIXhEqoBtVX+87caTh3JB3+7g6mbQVQDEzybxU+9wAQMf2u3mHc2uhlcib
         Dza6oTrGi7AtuBTzAgFiHOP4qEPdny9LF1ZK/8LdYkGb+IWLBZ9JttwDquOep14ckF
         IWzId9DYSMkK0QKb8va4t675X5STFuUliJ+bxulouFrAfRdgu9raZGBUahfrmm7oFl
         9aYK4elZEjKmnBaIYV8l1N4WakhuIqBQ7Ny/HGodVxH6aQIURZNbwEDjp7JXsFieyc
         vZl2LlLOgN5zw==
Date:   Fri, 27 Oct 2023 14:57:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ramona Gradinariu <ramona.gradinariu@analog.com>,
        <nuno.sa@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: adis16460: Add
 'spi-cs-inactive-delay-ns' property
Message-ID: <20231027145753.528b6308@jic23-huawei>
In-Reply-To: <20231024132705.00003cf4@Huawei.com>
References: <20231023123542.582392-1-ramona.gradinariu@analog.com>
        <20231023123542.582392-4-ramona.gradinariu@analog.com>
        <b7011f02-a412-4642-862d-c2df88ae316b@linaro.org>
        <20231024132705.00003cf4@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 13:27:05 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 23 Oct 2023 15:22:30 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 23/10/2023 14:35, Ramona Gradinariu wrote:  
> > > Add 'spi-cs-inactive-delay-ns' property.    
> > 
> > This we see from the diff. Commit should explain: Why?
> >   
> > > 
> > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > index 4e43c80e5119..3691c0be4f9d 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > > @@ -25,6 +25,11 @@ properties:
> > >  
> > >    spi-cpol: true
> > >  
> > > +  spi-cs-inactive-delay-ns:
> > > +    minimum: 16000
> > > +    description:
> > > +      If not explicitly set in the device tree, the driver will set it to 16us.    
> > 
> > Why do you even need it here?  
> 
> Along side that, if you have a default
> default: xxxx
> rather than in the description.

ah. I didn't get Krzysztof's reply to patch 1 for some reason where he already
said this... 

Anyhow, I've nothing to add to comments on v2.  Will aim to pick up v3.

> 
> 
> > 
> > Best regards,
> > Krzysztof
> > 
> >   
> 

