Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C30776FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjHJF6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHJF6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:58:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF53510FE;
        Wed,  9 Aug 2023 22:58:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so383020b3a.2;
        Wed, 09 Aug 2023 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691647119; x=1692251919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPFtNvyvLCrgV2MxecvIBM/JYmJP7ZKguh4I0qUa+pI=;
        b=qkSqzV7YtqTTnf5pWK4aEUCnGrWCjx9BqYyxmChB6Vhg0ecnJ9pPWGPvoA9NTKH/yL
         GpuhIY6h09S0eRJtnBo38uctwFNUVtzHSNieMz1mWEnYjO4jnOOv5gbeS/WPCbqhfsoW
         tURptAMUN080JtwnXhoqZ7qtOtRKy4HS2gLi8mUBuXOHqukH6bBImO48vS2eI0II5bpi
         gDKTZes17bOsfDDSswLvQ0sJUdAydE2qwk9PIVRjlx6uAIAXQbglDTZI+B0tRUKRJwI4
         /dTOl2GCtJ7J2aHinf1dK5E8qf/9Uty5pksqlMSrHdDPNYpp0sgKDJL9YmarqGCvttFe
         0mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691647119; x=1692251919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPFtNvyvLCrgV2MxecvIBM/JYmJP7ZKguh4I0qUa+pI=;
        b=fbieHVCz3qP98jjL6jYLv5BTEW4dsUZAhpqkF28e17mw7fajuIMgfIPUpYxr42lObL
         QroAWp7b+Ggxd+iku9t2/Fo7OUuqRHos95hG90YCCVHoqmfPlU9ToeW2SnCYTl93oDLo
         q4BhRkRwCglZsj4FamlguCbyJatSP30gZAiviOMtbSpgl9uZjSVSmjNkshOtdlnXHe7s
         Sf6Alvyq/F1L9eMZJOP6LPIrBrUYDyINwqlKIUyiaKbk+/cmuwk0pmRBs8r9ui1qhC8W
         4MXatyEE2qG/P9sDI+i/L8ozN6B0n4x2JAlwuxziqhn8XnoIKZxpAvWTmFInEHHczDTh
         vg+Q==
X-Gm-Message-State: AOJu0YzcSg6ThbpNegUnoPtfrojYiYyAJwGjLSSDBqECCrZoEEOsrqvU
        pXj35Zt+AHt3FCA/W3F0bxU=
X-Google-Smtp-Source: AGHT+IFtlIS9rOUoW0nRYv/rU5x45L1e4xM0I6tfde6WoFCs/6kXCWXJvJdatNuwNCUYkr+ONZgkNQ==
X-Received: by 2002:a05:6a00:3a10:b0:686:ec1d:18e5 with SMTP id fj16-20020a056a003a1000b00686ec1d18e5mr1376222pfb.28.1691647119137;
        Wed, 09 Aug 2023 22:58:39 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4 ([76.132.59.39])
        by smtp.gmail.com with ESMTPSA id k19-20020aa790d3000000b00682bec0b680sm613056pfk.89.2023.08.09.22.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 22:58:38 -0700 (PDT)
Date:   Wed, 9 Aug 2023 22:58:35 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
Message-ID: <ZNR8i5DCNSthmgTZ@taoren-fedora-PC23YAB4>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
 <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com>
 <ZNR21UVdfxlvpZAt@taoren-fedora-PC23YAB4>
 <CACPK8Xd7LpMuVC63PSfcLmXf4wRThMNRYr9vRxZh246+-DUFFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xd7LpMuVC63PSfcLmXf4wRThMNRYr9vRxZh246+-DUFFA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:37:41AM +0000, Joel Stanley wrote:
> On Thu, 10 Aug 2023 at 05:34, Tao Ren <rentao.bupt@gmail.com> wrote:
> >
> > Hi Joel,
> >
> > On Wed, Aug 09, 2023 at 08:08:12AM +0000, Joel Stanley wrote:
> > > On Thu, 3 Aug 2023 at 23:03, <rentao.bupt@gmail.com> wrote:
> > > >
> > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > >
> > > > The patch series fixes a few entries in wedge400 device tree.
> > > >
> > > > Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
> > > > by wedge400 dts) to make sure spi bus is consistent with flash labels in
> > > > flash layout.
> > > >
> > > > Patch #2 enables more ADC channels in wedge400 dts.
> > > >
> > > > Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.
> > > >
> > > > Tao Ren (3):
> > > >   ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
> > >
> > > I wondered if we should do this in the aspeed-g5.dtsi.
> >
> > I also hesitated if I should do it in aspeed-g5.dtsi, but I didn't do it
> > because I was not sure if others care about the spi aliases.. Should I
> > send out v2 to move the alias to aspeed-g5.dtsi?
> 
> I wasn't sure either. Lets leave it as-is, but if we see other systems
> wanting similar numbering then we can put it in the common dtsi.
> 
> I've applied this to the aspeed tree now.
> 
> Cheers,
> 
> Joel

Got it. Thanks Joel.


Cheers,

Tao
