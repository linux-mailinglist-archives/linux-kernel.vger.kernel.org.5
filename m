Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58319781F11
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHTRlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 13:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjHTRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 13:41:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FD422D;
        Sun, 20 Aug 2023 10:38:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa248263cso3860045e87.2;
        Sun, 20 Aug 2023 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692553125; x=1693157925;
        h=in-reply-to:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIr7RBh4/ml00M/dYodkytiKu3g9NjluUKtt0N6VKJM=;
        b=Fo0k1/S6GFD849p84Y8bd3daQpb0QyUebtOE3cSC5EOtxd6K6jxH6kQk4jme0XpceI
         lmQJGh0SZobwKQzqfJmuiozO+UQIi4ytjbfJYUDsz3g0p1hWBbKMZwGVHVRY+9NzQ6l6
         WJM19T6vAOr0bs1GhZQkpnMOZlt0j9A1UZlkVcORpk1UijBW4rXhD5rV0g+peA13NLKt
         qvHqVYpZnKzNPBr2s+K6RTk8C89rQQu7P3rErQ8Mj1xE42qQQP9OZQhtLxCjcx8Yyu8r
         lNr9/WbQsDH6oJZnoL0ecHeL4EdriaYDa8R32RrWQfs9enamqtKUok/YzPUdiIw+pnVo
         zJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692553125; x=1693157925;
        h=in-reply-to:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIr7RBh4/ml00M/dYodkytiKu3g9NjluUKtt0N6VKJM=;
        b=YWb8k/dO5Z7eBsNnKEcLhMEwElB0MzMZo+O89XtXHBVFv/85qGUoOlRIhB4vwM3bUj
         lvPaXOqRRMBSw21hK2PttS4NUHvXEmjDBPJC90QeCPCsneI9XIE+DOOiPaPgT4YnU0qs
         tWODYqTeT2elu5xghTpvEwEK5cJ5W646G92p+jhNVK7023d5NkL6m04zw/fRDKHheErt
         1BpY7YP7fhGyav7d7fxAe79mrSeDJ8sUKLKvjVJ97Q0bc2hoDRx9r95gGSqr77MK+EKF
         US9xYfvjqDtldTz2NsLZxFUeXMXyEkfwPKSFXhjUhQ5Jv24bMe+562CIYVbKOy2EgHnR
         hTSg==
X-Gm-Message-State: AOJu0YyzHBaXN0DvjNRFrVy52wIaF/REN9hTlZWTmcm0vImpS5pEXzpb
        1FcrmEPxHCYkiA94hp6vWk0=
X-Google-Smtp-Source: AGHT+IEY+jK9VXQeo68jFfmbeLhhcDVJjqoZoQ6pD+nmHMqQhVZcjPtHV+pjhmzyE/uM0tTzSYGkEQ==
X-Received: by 2002:ac2:5dc9:0:b0:4fb:7b4c:d38c with SMTP id x9-20020ac25dc9000000b004fb7b4cd38cmr2367546lfq.60.1692553125261;
        Sun, 20 Aug 2023 10:38:45 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id a11-20020a056512020b00b004fdbb36a677sm1326832lfo.288.2023.08.20.10.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 10:38:44 -0700 (PDT)
Date:   Sun, 20 Aug 2023 20:38:44 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Pavel Machek <pavel@ucw.cz>, icenowy@aosc.xyz, martijn@brixit.nl,
        megous@megous.com, kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, megi@xff.cz
Subject: Re: gc2145 camera driver (front camera on PinePhone)
Message-ID: <ZOJPpBoiC92VsOV+@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Pavel Machek <pavel@ucw.cz>, icenowy@aosc.xyz, martijn@brixit.nl,
        megous@megous.com, kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, megi@xff.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6tGfxrq/Mh1JoA9@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

> we are also using the GC2145 sensor but in a CSI based environment.
> 
> We are in contact with GalaxyCore and following discussions we had with them
> and data they provided us with, we've made a driver for that, supporting for
> the time being 3 different resolutions via the CSI interface.
> 
> The driver is available on the STMicroelectronics STM32 github [1].
> 
> If you are ok with that, we could go further upstreaming it while testing/adding
> features necessary for the PinePhone.
> 
> [1] https://github.com/STMicroelectronics/linux/blob/v5.15-stm32mp/drivers/media/i2c/gc2145.c

I've implemented basic parallel bus support to check your driver [1] on
the PinePhone. My changes are here [2].
With your driver results are much better in compare to Megi's
driver (I'm still glad, that Megi has written one). See pictures for
comparison here [3]. Access to vendor support and (probably)
documentation gives great results.

I'd recommend to replace more of hard-coded parts of initialization
sequences with functions like in proposed Megi's driver. So this will
be clearer what different register values mean. Since you have access
to support channel/documentation it'd be easier for you to do.

It'd be nice to have at least some gc2145 driver in mainline. Do you
still have plans/time to mainline driver?

P.S.
Alain, I don't see your address in the list of recipients of last Pavel's
response. In case you have not received it, it's here [4].

1. https://github.com/STMicroelectronics/linux/blob/v6.1-stm32mp/drivers/media/i2c/gc2145.c
2. https://github.com/AndreySV/linux/commit/f06ff60eb7a664dcafa8d40901a1ab0f59071529
3. https://github.com/AndreySV/linux/issues/1
4. https://lwn.net/ml/linux-kernel/Y6tGfxrq/Mh1JoA9@duo.ucw.cz
-- 
Best regards,
Andrey Skvortsov
