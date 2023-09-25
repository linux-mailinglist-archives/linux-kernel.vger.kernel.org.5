Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CAF7AD697
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIYLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:02:54 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F214D3;
        Mon, 25 Sep 2023 04:02:46 -0700 (PDT)
Received: from pd9e2f713.dip0.t-ipconnect.de ([217.226.247.19] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qkjMB-004AHQ-OP; Mon, 25 Sep 2023 13:02:27 +0200
Date:   Mon, 25 Sep 2023 13:02:25 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bcousson@baylibre.com>, <tony@atomide.com>,
        <jean-baptiste.maneyrol@tdk.com>, <chenhuiz@axis.com>,
        <andy.shevchenko@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Message-ID: <20230925130225.55fe6fd4@aktux>
In-Reply-To: <20230925112852.00007d34@Huawei.com>
References: <20230924222559.2038721-1-andreas@kemnade.info>
        <20230924222559.2038721-2-andreas@kemnade.info>
        <6db5b758-2ae6-46fb-a699-d73a2b98b4c2@linaro.org>
        <20230925112852.00007d34@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 11:28:52 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 25 Sep 2023 08:54:08 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 25/09/2023 00:25, Andreas Kemnade wrote:  
> > > Found in ancient platform data struct:
> > > level_shifter: 0: VLogic, 1: VDD
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml         | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> > > index 1db6952ddca5e..6aae2272fa15c 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> > > @@ -48,6 +48,8 @@ properties:
> > >  
> > >    mount-matrix: true
> > >  
> > > +  invensense,level-shifter: true    
> > 
> > It does not look like you tested the bindings, at least after quick
> > look. Please run `make dt_binding_check` (see
> > Documentation/devicetree/bindings/writing-schema.rst for instructions).
> > Maybe you need to update your dtschema and yamllint.
> > 
> > Best regards,
> > Krzysztof
> > 
> >   
> 
> Also this one isn't obvious - give it a description in the binding doc.
> 
> I'm not sure of the arguement for calling it level shift in general.
> 
I have no more descrption than the old source (see the citation from there)
https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-9150-Register-Map.pdf

does not list it. But that bit is needed to get things to work what also does the
vendor kernel do.

What could be a better descrption?

Regards,
Andreas
