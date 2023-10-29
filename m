Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589F37DAA98
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 04:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJ2Df0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 23:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2DfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 23:35:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F8FCF;
        Sat, 28 Oct 2023 20:35:21 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b2ea7cc821so2385171b6e.1;
        Sat, 28 Oct 2023 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698550520; x=1699155320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjDo8XieKuMeFuZXOm0zzgIaw5X9UobfJiGgfoOcHjM=;
        b=cXyKUof1TRpySLccxkrcGfCBFfQ7PhYnz6I1VRxbV+53xIv61ihpQqUDd93jWNGH5Z
         ok8r8+ixr4X+Vy2S3zMy1OwR52iuxg20C04iUi5W5pb9a7f7DYoj1qRunSyigRz01xG4
         UWUgXy4eE3hgXB7gD5X6iEAzM29QVb+9edAa+FW88BnYK14R0pRpPCVz97FqM7mNoVSH
         r+o15Hab38gcd7s8Cd+pGYT6v4MkXdhzt9NFB0682iiHL/xPPJEv1xtvMcLRTsbhzhiu
         V7ZY2dJQMDf6UHRwNgkeywXfkBPiOcRVt7RUoKs5LWUeT/IELC5PckV/EhzBt27gm/Cu
         wm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698550520; x=1699155320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjDo8XieKuMeFuZXOm0zzgIaw5X9UobfJiGgfoOcHjM=;
        b=h+WooqlU4mo4Hwj8D9y3tdrIB2Uh9powZaMsmjmzhFxxYVMQgRJlPlTuFyeD2nxzaA
         KLT1BAzLSYDq/Zult29gOiei//DP2DfCSkATFMXFhNTLVTUnyH3cN6dKSmqw85T1ZJea
         BlhCT7Czgx0WEgzAr73u7QzdguXvdFl+DdUIwu8W2MATG4Gk7cLizeGguXi6lKYcL0ga
         2V3o15P/ss79S2RuHnIKvsQGgkx3hpnj8Ml5fs1KOHLJ6LS9YKabI2gSkQoHQC/NNkJc
         swvUO59pRSuNrL1amj+DHcTllflhyPmFOj11fa80lxm1acbUuc15XmW60jGJo6wJmYEY
         KNPQ==
X-Gm-Message-State: AOJu0YwP1qeREbt+w9GgBCF3lcOQGLbJH8gHRA6KWRCs1tHxQTOZ7l3d
        nUWQOJ3Qgs8wJRmjR4SR/lQ=
X-Google-Smtp-Source: AGHT+IHbi4c93mytucXIZVUYJrne6It6w4HgcLUPid9tvqrmA89EUUdgcv1uQWUviSg/UmWBaR6Crw==
X-Received: by 2002:aca:1909:0:b0:3b2:df82:812e with SMTP id l9-20020aca1909000000b003b2df82812emr7406778oii.32.1698550520181;
        Sat, 28 Oct 2023 20:35:20 -0700 (PDT)
Received: from google.com ([205.220.129.30])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b006b8ffc49ba5sm3604895pfo.38.2023.10.28.20.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 20:35:19 -0700 (PDT)
Date:   Sun, 29 Oct 2023 03:34:59 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: cyttsp5 - improve error handling and remove
 regmap
Message-ID: <ZT3S43_eMdwHWu2u@google.com>
References: <20231025013939.353553-1-james.hilliard1@gmail.com>
 <ZTwWmHC7Wcd5iwqS@google.com>
 <CADvTj4oH=3Q3EShC-FM9ob7EnvFe4t2LHyDEwr-e7=G8M=UzYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4oH=3Q3EShC-FM9ob7EnvFe4t2LHyDEwr-e7=G8M=UzYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 03:31:00AM -0600, James Hilliard wrote:
> On Fri, Oct 27, 2023 at 1:59 PM Dmitry Torokhov <dmitry.torokhov@gmail.com>
> wrote:
> 
> > Hi James,
> >
> > On Tue, Oct 24, 2023 at 07:39:38PM -0600, James Hilliard wrote:
> > > The vendor cyttsp5 driver does not use regmap for i2c support, it
> > > would appear this is due to regmap not providing sufficient levels
> > > of control to handle various error conditions that may be present
> > > under some configuration/firmware variants.
> > >
> > > To improve reliability lets refactor the cyttsp5 i2c interface to
> > > function more like the vendor driver and implement some of the error
> > > handling retry/recovery techniques present there.
> >
> > Sorry but you need to elaborate more on what is missing in regmap and
> > how vendor code is better. In my experience vendors rarely follow kernel
> > development and either are not aware of the latest kernel APIs, or they
> > simply have the driver written to what we had in 3.x kernels and have
> > not really updated it since then.
> >
> 
> I'm unaware of a way to do essentially raw reads when using regmap, for
> example I don't know of a way to implement the cyttsp5_deassert_read
> function using regmap, maybe there's a way I'm not aware of however?

What is wrong with current way of reading from the input register? It
should clear the interrupt line.

> 
> In general the issue with regmap seems to be that regmap always does
> operations against specific registers and prevents doing raw i2c operations
> needed to handle some hardware/firmware issues for some variants.

What are those issues and why do they need raw access.

> 
> Note that I'm not exactly doing things the same way the vendor driver does,
> I have simplified the error recovery/retry code paths in the startup
> function.
> 
> 
> >
> > >
> > > As part of this rather than assuming the device is in bootloader mode
> > > we should first check that the device is in bootloader and only
> > > attempt to launch the app if it actually is in the bootloader.
> >
> > I would prefer if this was split into a separate patch.
> >
> 
> I think this change is somewhat intertwined with the probe retry/recovery
> logic
> changes and is a bit tricky to split out without breaking the startup
> sequence
> from my testing at least.

I understand that it might be tricky but each logical change should
stand on its own.

Thanks.

-- 
Dmitry
