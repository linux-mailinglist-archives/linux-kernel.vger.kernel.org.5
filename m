Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA86476606E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjG0X7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG0X7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:59:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A01BF4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:59:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so12087335ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690502379; x=1691107179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOKiUxDPKvRLa/kPi76r2pwEo1sFcVBEnyuTNjKRcD0=;
        b=YESZl38UaRZ05Obt17gN/zrCA22IzUrY4yM0wvLjlSkPxTNrR0gjFfgvLX48MAv2vH
         NETGf2BXTaccmfT43k6Jfr0QubkNMBZntPyuDxA5eG4FLAxDEDwTuzlTkVxuipg5XC/T
         +P3hZZmlsveCgC664VMh5Y22YmwJdm09CWdUlmG2JKWddTl0Kt9wtU2QkKtRmdAXJZiC
         O1Hosbtg5vF2J2V3Jjn3nM8FKG0fBygvanqLwAaDMPm/9knYAxOlWq+yekhZ7vEHXRTR
         CfgPUDI0jvghpou5vwA07o5qHsB27o3rPLm35svKAqnBK6bnBP4tbd+PQMKRkL7ObyVC
         f0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690502379; x=1691107179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOKiUxDPKvRLa/kPi76r2pwEo1sFcVBEnyuTNjKRcD0=;
        b=hVr6i3Z95duCmcbcHoWDlJfNsF0LqpWV33tb9panGWfocExasC9oHVK/vnXYDxb+Vp
         Ke89ykodWmHq3/pHkGqeUMbsUSveTNJNIgvCIuqWA1zf3Or3/69zMw2gCNA0X1ockYqY
         YFyse2XqUNLhb0JmBwKFbz+FT7GI9tXk5UzFZUqwyoos2OqHY9PaDZhnfrFwVtFwJiBA
         Gp08iaU4O8X47x1+aPjiQfzhBIU1fr61+tDdVK5YXZBz9blHgSyRpCRlBoRGZY7bx3yS
         TGuR5+5wcnZRLd3gdmzGkqZ+prP46HX89iZhUo7pRvDc/F0Z5+WOgtIv7THf7viUFmYP
         lC+w==
X-Gm-Message-State: ABy/qLam8HAU1ICIt+mGTnm92jBP7V7gxvVxQcuCet4KIcTf7THYPDKf
        7Z11KWT0zq+1xxwVT/HqhXEesQ==
X-Google-Smtp-Source: APBJJlGMw2cf+CJchqdgDNVLwOuXKaGnK5e4Us9yFYLovgmZPrtW19QVwG5gqf8OYeTtOv1aSbOsHQ==
X-Received: by 2002:a17:902:bd4b:b0:1b8:8af0:416f with SMTP id b11-20020a170902bd4b00b001b88af0416fmr117522plx.1.1690502379302;
        Thu, 27 Jul 2023 16:59:39 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:dacb:3a1a:fcaf:c0fc])
        by smtp.gmail.com with ESMTPSA id je12-20020a170903264c00b001bbb598b8bbsm2220874plb.41.2023.07.27.16.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 16:59:38 -0700 (PDT)
Date:   Thu, 27 Jul 2023 16:59:37 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Kwanghoon Son <k.son@samsung.com>
Cc:     'Jisheng Zhang' <jszhang@kernel.org>,
        'Conor Dooley' <conor@kernel.org>,
        'Guo Ren' <guoren@kernel.org>, 'Fu Wei' <wefu@redhat.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        'Conor Dooley' <conor+dt@kernel.org>,
        'Paul Walmsley' <paul.walmsley@sifive.com>,
        'Palmer Dabbelt' <palmer@dabbelt.com>,
        'Albert Ou' <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'Robert Nelson' <robertcnelson@beagleboard.org>,
        'Jason Kridner' <jkridner@beagleboard.org>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device
 tree
Message-ID: <ZMME6cHQzHMLUCq+@x1>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
 <20230723-savor-trolling-e35ed4a7a751@spud>
 <ZL1jlacHj7sgNg8M@x1>
 <CGME20230724003542epcas1p4c6c8dbd042af792bc168e10c6e81e45d@epcas1p4.samsung.com>
 <ZL3Eenj4lGZDhZTM@xhacker>
 <000001d9c070$82638290$872a87b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d9c070$82638290$872a87b0$@samsung.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:55:37PM +0900, Kwanghoon Son wrote:
> > On Sun, Jul 23, 2023 at 10:29:57AM -0700, Drew Fustini wrote:
> > > On Sun, Jul 23, 2023 at 11:32:17AM +0100, Conor Dooley wrote:
> > > > On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:
> > > >
> > > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > @@ -0,0 +1,61 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > >
> > > > Hmm, should this not be dual licensed?
> > > > I notice the other th1520 stuff isn't either..
> > >
> > > Good point, I'll resubmit with a dual license.
> > >
> > > Jisheng: are you okay with the other arch/riscv/boot/dts/thead files
> > > changing to a dual license?
> > 
> > When cooking the initial patch, I wrote the lpi4a dts files from
> > scratch based on sipeed opened sch file, and currently only I made
> > contributions to them, so it's easy to make the lpi4a dts files
> > dual license.
> 
> Thanks for your work.
> Is there any datasheet or user manual can get on public?
> I'm going to contribute drivers in my spare time,
> but it's hard to know the register file and dma information.
 
We (the BeagleBoard.org Foundation) have asked T-Head to publish public
documentation for the TH1520. It is our understanduing that this should
happen soon but we do not know exactly when. I'll followup in the this
thread once that happens.

Thanks,
Drew
