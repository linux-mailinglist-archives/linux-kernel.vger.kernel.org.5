Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48877ACBF8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjIXVEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjIXVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:04:31 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458FDFB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:04:24 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4e30a3604so830649a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695589463; x=1696194263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0+IXnh6MdnWPnySyYwtUtqhST9oEZJulxHM6uyxvQ4=;
        b=FqfnGr8QQVjY3RXWX8rjtQu4CxjR3CkQY4oXDfwm7ETGhoedIRFfq6uXCAcTjFVdrQ
         16QVR9ZPQveB9EIV4N3Yc1g5p/jFvVfV2HO+0A7T7e8t4xwi9qiSaz11BT4vfDJmAr4H
         ze5Y0U1x2hD7knjJYGyrObpCJUQ+K2AFZ3+iEnU8X461hno1Q3oBsPO1eLDAkDGT6k3H
         Ql9ndAdckL8kTlkf352PTKb3yjquK9MA0g8+g2ZhfOJX0d8CpZ/t5J/b7kqEYBhzI58B
         BNrjP3uHtxHW645RSTISDCDeoYYPGaAOIoSO6zrojVjo7Qm/8txFvhjn4SiGvHixTrIc
         wfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695589463; x=1696194263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0+IXnh6MdnWPnySyYwtUtqhST9oEZJulxHM6uyxvQ4=;
        b=OLRhuPUpeBdV3PDzJL+1lJGEkd7Xy/N98DjhOUBK1Kumj6i1U7NnCvJSMAYsgnhaaZ
         wytaZo/TyxBZgoainvJpPRXOwVrOa0jiEtAPZM/D6oi82YIktvKTMA5nDXwCZ4kkJ6xC
         NJr5xnT4Y7TLSGD4iNTWJMwaoFfX/Ra2IZerWGokOorFawKVXTrd3oNOV0yvi4eNIGhQ
         CNFaf1V1yOvh9sKJtK9skLxEVd3JP99Zu/MpmJK0Y7FmKth1QhvnLCVSKjxLBeue24Es
         0o+sJXlcp3zuKdpOmOU8u9U75zZDGFgsHXasIWvWz3t2wFW+OsXNdj9A3ke90FDdmHRZ
         Yvew==
X-Gm-Message-State: AOJu0YyqxumDJL/OCyCNHIEMEk096LR2TfITJgidq19HAqhLxJehFVKG
        +sQrSSZzXhdRaroSnEfwCtRCZQ==
X-Google-Smtp-Source: AGHT+IGbiJk4Y9+XU8Ptt4Wl1I2OUjbjVI4QJKzGmg6mUgquLLndTEW5kkDKj1Tuej9OjSc13PljIw==
X-Received: by 2002:a05:6358:6f12:b0:13c:eea2:d021 with SMTP id r18-20020a0563586f1200b0013ceea2d021mr4834597rwn.9.1695589463417;
        Sun, 24 Sep 2023 14:04:23 -0700 (PDT)
Received: from x1 ([191.96.37.211])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78251000000b0068feb378b89sm6879991pfn.171.2023.09.24.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 14:04:22 -0700 (PDT)
Date:   Sun, 24 Sep 2023 23:04:14 +0200
From:   Drew Fustini <dfustini@baylibre.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
Message-ID: <ZRCkTqV2qV/tMb4O@x1>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-1-49f76c274fb3@baylibre.com>
 <20230922-parish-ice-a22e93dc3027@spud>
 <ZQ2tP48Z19C5xRug@x1>
 <CAJF2gTSeKnB=Zc6o1wJAOyax7d=RmDJ0o8PSOfkVo5BYVc=sAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTSeKnB=Zc6o1wJAOyax7d=RmDJ0o8PSOfkVo5BYVc=sAw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 04:10:11PM +0800, Guo Ren wrote:
> On Fri, Sep 22, 2023 at 11:18 PM Drew Fustini <dfustini@baylibre.com> wrote:
> >
> > On Fri, Sep 22, 2023 at 10:57:36AM +0100, Conor Dooley wrote:
> > > Hey Drew,
> > >
> > > On Thu, Sep 21, 2023 at 06:49:48PM -0700, Drew Fustini wrote:
> > > > Add compatible value for the T-Head TH1520 dwcmshc controller and add
> > > > thead,phy-pull-up property.
> > > >
> > > > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > index a43eb837f8da..46b768d46712 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > > @@ -19,6 +19,7 @@ properties:
> > > >        - rockchip,rk3568-dwcmshc
> > > >        - rockchip,rk3588-dwcmshc
> > > >        - snps,dwcmshc-sdhci
> > > > +      - thead,th1520-dwcmshc
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -60,6 +61,9 @@ properties:
> > > >      description: Specify the number of delay for tx sampling.
> > > >      $ref: /schemas/types.yaml#/definitions/uint8
> > > >
> > > > +  thead,phy-pull-up:
> > > > +    description: Enable weak pull-up on PHY pads
> > > > +    type: boolean
> > >
> > > Why is the weak pull-up required? How would the dts author know if they
> > > need to use this property?
> >
> > This is a good question, and I don't have a good reason beyond it is
> > what the vendor SDK was doing.
> >
> > There are only two boards right now using the TH1520 that I know of.
> > Both the LPi4a [1] and the Ahead [2] have the pull-up property set on
> > all the mmc controller nodes their downstream device trees.
> >
> > Rob suggested on #devicetree that it would be simpler to just enable it
> > in the driver and disable support when needed. I like this idea as it
> > will simplify this binding patch and the code in the driver patch.
> It's for the PHY debug. You could directly remove them, or keep it
> with no-pull-up flag, then no pull-up flag in the dts for default..

Thank you for explaining that the purpose of the pull-up DT property
was for PHY debug.

I will plan to remove the pull-up DT property in the next version of
this patch series and remove sdhci_phy_1_8v_init_no_pull() and
sdhci_phy_3_3v_init_no_pull() from my sdhci-of-dwcmshc.c patch.

I will make th1520_phy_1_8v_init() and th1520_phy_3_3v_init() always
set WEAKPULL_EN = 1 (PULLUP) for CMDPAD_CNFG, DATAPAD_CNFG, RSTNPAD_CNFG
and set WEAKPULL_EN = 2 (PULLDOWN) for STBPAD_CNFG.

Thanks,
Drew
