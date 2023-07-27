Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553F765BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjG0TEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjG0TEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:04:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D462D73;
        Thu, 27 Jul 2023 12:04:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31771bb4869so1347786f8f.0;
        Thu, 27 Jul 2023 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690484677; x=1691089477;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vIR3OXuVm3Pq3TR1D69ejglqsYbJzkoflFBb4YzmpBw=;
        b=i4z71jYTw+lt+Z8IKn7l2rgL1WKbtGYzhnfVtK9fnZwnIum5Mny8d7UcC0mIbtTLjM
         PMP3mvSJXoc4bySvThSDfJy16efQ5b9sBidMH/1BYid8na+bNYZVYeWDkRf78K90+hpx
         DWZVbUq54S0n6ZsyWy5L0nfYBRcamk4ptYhmFSwicqzsGi5OMGzp8iV1gPnwOpEBiNuo
         f5tT5C6AxNsSqTiD8TGvSGOSDyauXU1Dm+x9pnKw6kPHktmGHNZMsynHxAde1cHdiO+n
         NJjYwbH/rCcFFo1Pje27a9Dvxi4UPsEykv299Iuhav5ZsjlucDcXB5Tnwbrlxi93a4T4
         CiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484677; x=1691089477;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIR3OXuVm3Pq3TR1D69ejglqsYbJzkoflFBb4YzmpBw=;
        b=BaD9BRf3Tj2B659F6LzvtA1LwTnNiuz8TtGJowRejkWnub64WnYHFwB3sKD3CGgFdK
         jw6WBcuPN75ew9sJIcttOiDIoR0qkjU9HhA0q5qwTD/yDIB7cHlw2sTXGsH1i7K0G9tE
         ce1po8pVroVWvjdmkNrdJt/6zik/F3uL8iN+uxGYutV6QDjGcHla2btlh8qwC1Py+GKJ
         7AYLhSyo0ZGPU5+aOieLgRLuFg4m2HJOoXPDBgm549NhkHFQs7vg3KiB5ekpLDqdruTk
         jaLs807e8mJma3KTzrXVCZSWhGYZ7a4Xcs1w77RdLWsKKDeJ+gdS2+3QlEe0OPrkI+7q
         beYg==
X-Gm-Message-State: ABy/qLbwzTsJxHAp0bOEc6D6j7ueTffAjZnAJUwKM0UAI+8DAEepC384
        ZVPBLCKpJED0f3pgefRnsqM=
X-Google-Smtp-Source: APBJJlGcy3Z6y7DpwyYrFj+jkdXLyq8qRYBx9g/jB0616jkDr6GdONdW3cuHkUNmiQBVX0/fUmhHqg==
X-Received: by 2002:a5d:5042:0:b0:317:5b3b:89a1 with SMTP id h2-20020a5d5042000000b003175b3b89a1mr55956wrt.10.1690484677068;
        Thu, 27 Jul 2023 12:04:37 -0700 (PDT)
Received: from Ansuel-xps. (host-87-19-253-131.retail.telecomitalia.it. [87.19.253.131])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c229800b003fbcdba1a52sm5313985wmf.3.2023.07.27.12.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:04:35 -0700 (PDT)
Message-ID: <64c2bfc3.050a0220.afe65.965e@mx.google.com>
X-Google-Original-Message-ID: <ZMK/wajle4PO4zLb@Ansuel-xps.>
Date:   Thu, 27 Jul 2023 21:04:33 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: u-boot,env: Add support for
 u-boot,env-size
References: <20230724082632.21133-1-ansuelsmth@gmail.com>
 <20230726163600.GA1549714-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726163600.GA1549714-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:36:00AM -0600, Rob Herring wrote:
> On Mon, Jul 24, 2023 at 10:26:30AM +0200, Christian Marangi wrote:
> > Add support for u-boot,env-size new property.
> > 
> > Permit to declare a custom size of the U-Boot env that differs than the
> > partition size where the U-Boot env is located.
> > 
> > U-Boot env is validated by calculating the CRC32 on the entire env
> > and in some specific case, the env size might differ from the partition
> > size resulting in wrong CRC32 calculation than the expected one saved at
> > the start of the partition.
> 
> Why can't you just change the partition size? There is no size really 
> because it is just defined in DT.

Hi,
partition may also come by parser at runtime and are not only provided
by DT. One example is cmdlinepart where partition comes from cmd line or
smem-part from qcom smem.

We support this case by declaring these partition in DT and NVMEM
connects the dynamic partition to OF in DT (to reference and use the
NVMEM cell in other nodes)

> > 
> > This happens when U-Boot is compiled by hardcoding a specific env size
> > but the env is actually placed in a bigger partition, resulting in needing
> > to provide a custom value.
> 
> If u-boot is compiled that way, then shouldn't it have that size 
> contained within it? What happens when the DT doesn't match?
> 

When DT doesn't match the expected compiled size, the CRC32 validation
fail.
U-Boot store the env size crc32 in the first few bytes of the uboot env
partition. And we walidate that the saved crc32 actually match the
calculated one to make sure we have a not corrupted env size. If crc32
validation fail the uboot env nvmem module fails to probe.

> > 
> > Declaring this property, this value will be used for NVMEM size instead of
> > the mtd partition.
> > 
> > Add also an example to make it clear the scenario of mismatched
> > partition size and actual U-Boot env.
> 
> If we do have this, then perhaps there is a generic need for a data 
> size property.
> 

Can you give some example of this? I'm more than happy to follow
standard property instead of use custom ones.

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/nvmem/u-boot,env.yaml | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > index 36d97fb87865..3970725a2c57 100644
> > --- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > @@ -44,6 +44,24 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  u-boot,env-size:
> > +    description: |
> > +      Permit to declare a custom size of the U-Boot env that differs than the
> > +      partition size where the U-Boot env is located.
> > +
> > +      U-Boot env is validated by calculating the CRC32 on the entire env
> > +      and in some specific case, the env size might differ from the partition
> > +      size resulting in wrong CRC32 calculation than the expected one saved at
> > +      the start of the partition.
> > +
> > +      This happens when U-Boot is compiled by hardcoding a specific env size
> > +      but the env is actually placed in a bigger partition, resulting in needing
> > +      to provide a custom value.
> > +
> > +      Declaring this property, this value will be used for NVMEM size instead of
> > +      the mtd partition.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >    bootcmd:
> >      type: object
> >      description: Command to use for automatic booting
> > @@ -99,3 +117,32 @@ examples:
> >              };
> >          };
> >      };
> > +  - |
> > +    partitions {
> > +        compatible = "fixed-partitions";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@0 {
> > +            reg = <0x0 0xc80000>;
> > +            label = "qcadata";
> > +            read-only;
> > +        };
> > +
> > +        partition@c80000 {
> > +            label = "APPSBL";
> > +            reg = <0xc80000 0x500000>;
> > +            read-only;
> > +        };
> > +
> > +        partition@1180000 {
> > +            compatible = "u-boot,env";
> > +            reg = <0x1180000 0x80000>;
> > +
> > +            u-boot,env-size = <0x40000>;
> > +
> > +            mac1: ethaddr {
> > +                #nvmem-cell-cells = <1>;
> > +            };
> > +        };
> > +    };
> > -- 
> > 2.40.1
> > 

-- 
	Ansuel
