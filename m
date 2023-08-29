Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC578C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbjH2QWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbjH2QWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:22:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CDD7;
        Tue, 29 Aug 2023 09:22:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5009969be25so7229092e87.3;
        Tue, 29 Aug 2023 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693326133; x=1693930933;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YQYJMVOAoN/cmV35BwRIX6WZWCWVOOOQRhJuUzqcdZc=;
        b=eE0gtj2bviqSjRY3eOfotuFEoeYUeBWR+WithfMfEH+up0obuWo5eYpbaMXNcI/Ss9
         iVLUO9d94LLWdEe+gwHcOpKfpkfe4lc8DGyrC0qoL4tlPNfpRjZJ0oCeVe9lmjA23Udu
         a+XvHDqQPzuFMLchARizO9Pr7FERO6VSC7ZHQl0boJIRO+ss9XZAgyp2m1ui87YLc1iC
         mk4sIGbMEhvYBApB84Dw6Zq/Nvo4doxO5XD3LOMp4+wYIRe8CVQDV2ilLoSrT/K/wzTV
         Kaiyc/eWQk8AFpcYbJ+0sAs01gGvrEyTX1I2/4/4fr87V+V/s4jCILExUthRe2yzkWRf
         j/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693326133; x=1693930933;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQYJMVOAoN/cmV35BwRIX6WZWCWVOOOQRhJuUzqcdZc=;
        b=T95FO2BxK4fPTllZ6Gejsxl4EyELQjaEHRsBcZylqCStaZNy0amvfGd4YZuZLBTjxn
         BjhI/6XOP9C301BN93xGgj9wpJf0b4Fg37tGk/fVFv/RDObuJqoVkz+AFs59bpGu/ANM
         VMZqxS7nv+6YN1OBCIDFgN8bFzmkFJ1abFGka92i6iDGyG4c54Y6OLuaf4upuXoc1JLp
         ozm7ZQobSag/fzCvqliHIzQUWiCe+F/2jiDAlbKg8RKq4KYo403KvP1ORFJUzE9RZ+tc
         mziEn0p1Nd5wv3v1g23/FhsC5PmbD1CCr1T96r8lmM7JkGOA17NlX3MppxdwqebL23nY
         Xhqg==
X-Gm-Message-State: AOJu0YxCSHOMoZj8PNfIIHJlKRKDuBO6GZ85D+B85J1LBXuSBVTeBi5Q
        l6d8tFzvSb469iFVZlA4sEcvwMlSbUjLNA==
X-Google-Smtp-Source: AGHT+IFJ2dV73C0KglakfndNNFKBbVQ3q9cGA7p3XsNRcuMQfRwDNSroOBObUGRCMdger3CLM8W9Wg==
X-Received: by 2002:a05:6512:2524:b0:4fe:676:8c0b with SMTP id be36-20020a056512252400b004fe06768c0bmr21646261lfb.11.1693326132806;
        Tue, 29 Aug 2023 09:22:12 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id l16-20020ac24a90000000b004fbab80ecefsm2013094lfp.145.2023.08.29.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 09:22:11 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:22:11 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, icenowy@aosc.xyz, martijn@brixit.nl,
        megous@megous.com, kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, megi@xff.cz
Subject: Re: gc2145 camera driver (front camera on PinePhone)
Message-ID: <ZO4bM9UXgJVBG9hv@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, icenowy@aosc.xyz, martijn@brixit.nl,
        megous@megous.com, kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, megi@xff.cz
References: <Y6tGfxrq/Mh1JoA9@duo.ucw.cz>
 <ZOJPpBoiC92VsOV+@skv.local>
 <20230829144029.GB193536@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829144029.GB193536@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-08-29 16:40, Alain Volmat wrote:
> Hi Andrey,
> 
> sorry for the delay and huge thanks for the effort of adding parallel
> support into the driver.
> 
> Yeah pushing this driver is still in my todo and your effort for the
> parallel part helps me a lot.
That's good.

> Since you already have a commit which adds the parallel support, what
> about I prepare the driver with only CSI support for the time being
> (after cleanup as you also suggested) and then you can push additionnal
> patches on top of it to add parallel support ?

let's do that. I'll try find time for that, when you are ready. Until
that I've improved awb support on Megi's kernel based on your driver.

1. https://salsa.debian.org/Mobian-team/devices/kernels/sunxi64-linux/-/merge_requests/95

> Regards,
> Alain
> 
> On Sun, Aug 20, 2023 at 08:38:44PM +0300, Andrey Skvortsov wrote:
> > Hi Alain,
> > 
> > > we are also using the GC2145 sensor but in a CSI based environment.
> > > 
> > > We are in contact with GalaxyCore and following discussions we had with them
> > > and data they provided us with, we've made a driver for that, supporting for
> > > the time being 3 different resolutions via the CSI interface.
> > > 
> > > The driver is available on the STMicroelectronics STM32 github [1].
> > > 
> > > If you are ok with that, we could go further upstreaming it while testing/adding
> > > features necessary for the PinePhone.
> > > 
> > > [1] https://github.com/STMicroelectronics/linux/blob/v5.15-stm32mp/drivers/media/i2c/gc2145.c
> > 
> > I've implemented basic parallel bus support to check your driver [1] on
> > the PinePhone. My changes are here [2].
> > With your driver results are much better in compare to Megi's
> > driver (I'm still glad, that Megi has written one). See pictures for
> > comparison here [3]. Access to vendor support and (probably)
> > documentation gives great results.
> > 
> > I'd recommend to replace more of hard-coded parts of initialization
> > sequences with functions like in proposed Megi's driver. So this will
> > be clearer what different register values mean. Since you have access
> > to support channel/documentation it'd be easier for you to do.
> > 
> > It'd be nice to have at least some gc2145 driver in mainline. Do you
> > still have plans/time to mainline driver?
> > 
> > P.S.
> > Alain, I don't see your address in the list of recipients of last Pavel's
> > response. In case you have not received it, it's here [4].
> > 
> > 1. https://github.com/STMicroelectronics/linux/blob/v6.1-stm32mp/drivers/media/i2c/gc2145.c
> > 2. https://github.com/AndreySV/linux/commit/f06ff60eb7a664dcafa8d40901a1ab0f59071529
> > 3. https://github.com/AndreySV/linux/issues/1
> > 4. https://lwn.net/ml/linux-kernel/Y6tGfxrq/Mh1JoA9@duo.ucw.cz
> > -- 
> > Best regards,
> > Andrey Skvortsov

-- 
Best regards,
Andrey Skvortsov
