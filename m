Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4575E40A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGWRaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 13:30:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81121B7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:30:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6682909acadso1956678b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690133400; x=1690738200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anD/aZSlr+vLjZWLNxtxT0F5flAWAxjs67Wwhw6u0QM=;
        b=E+ArsCyWXwauL0di3emQhq+Fmc/7kBA6oessKwzGOTGr4kxRa5UnXYIUloBVNs+ZKr
         vDWe5CeL4XVcghejAaiQh3imZha3QAH4TVK1+GJopZIWFYvcuRALPiYmvSNU0m21Sjw4
         mVVULeIdyuDTF05PGfRAe1xMhSQ+PXcdmc93bY7QEF2YeBfnOnwQMjPJMLGeFLu6qVOp
         rANcYkbU6ZNvd3ef9xGVGK+W/hs5zOaQkBpJdt3zkbqUAW489Q/sbs97BJXw3sWJjlGO
         HOkVEtQK3sZJZXzeXPOzzeXVCAuv1E4zHLc1i25OFc1QloXYwnyV0ITpoM7Mib5K5eJG
         m97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690133400; x=1690738200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anD/aZSlr+vLjZWLNxtxT0F5flAWAxjs67Wwhw6u0QM=;
        b=Qmpd4pxfDu8ecQJkYAl1BwxU5noIsSxWEv2OYie+CSJOa6djMYOivN7FMD1qJBTiPQ
         0TekmghMcLLvzY/0qgR1X0959520FB4AycBSEN/WzbPqPBVJFTwrAEeZloeuGqlb/t2M
         85OlGf8Ym2rloBxtbC1BEgzo/ivWRPivJUTl/ZhQoFz5WscHqIVVAK40Dmc5LamPFLfu
         ItXOIYu8JPZb023SqjF704gweq0LahBAVPcS+pIm20jbk6g7arGRDm3V4crEAZ8nC9QS
         Z9wdytYopqkpmTHOzay/HJcAJ1eSSb1z34y5HCMHZiE+BTnbq7zVUIt/svbZZ1aRykWa
         TpDA==
X-Gm-Message-State: ABy/qLbK9vEczhtfw0wPJ9OptHwePQb6Wiy2kwbKu7RgfHflZSwua1pa
        woqGRA23FWvwMyEMnHe4k5VGXl/HQ4Mf+frsjpWDCw==
X-Google-Smtp-Source: APBJJlGzn18xvFg4hiXQsp73KgOF0fT+h4xDUJN4Wco5VrV/ebEtcvNWM2uHS2/B+5arR7FXdrOezA==
X-Received: by 2002:a05:6a00:1307:b0:674:8fe0:1262 with SMTP id j7-20020a056a00130700b006748fe01262mr4911219pfu.18.1690133400075;
        Sun, 23 Jul 2023 10:30:00 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:2a8c:966f:392d:7230])
        by smtp.gmail.com with ESMTPSA id s123-20020a637781000000b005635bf2f09bsm6806460pgc.42.2023.07.23.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 10:29:59 -0700 (PDT)
Date:   Sun, 23 Jul 2023 10:29:57 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device
 tree
Message-ID: <ZL1jlacHj7sgNg8M@x1>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
 <20230723-savor-trolling-e35ed4a7a751@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723-savor-trolling-e35ed4a7a751@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 11:32:17AM +0100, Conor Dooley wrote:
> On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:
> 
> > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > @@ -0,0 +1,61 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Hmm, should this not be dual licensed?
> I notice the other th1520 stuff isn't either..

Good point, I'll resubmit with a dual license.

Jisheng: are you okay with the other arch/riscv/boot/dts/thead files
changing to a dual license?

> 
> 
> > +	memory@0 {
> > +		device_type = "memory";
> > +		reg = <0x0  0x00000000  0x1 0x00000000>;
> 
> There's some extra spaces in here for some reason.

Thanks for spotting that. I'll fix when I resubmit with dual licnese.

Drew
