Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0194F78447E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjHVOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjHVOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:37:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B91893;
        Tue, 22 Aug 2023 07:37:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76da0ed3b7aso189632885a.1;
        Tue, 22 Aug 2023 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692715045; x=1693319845;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKQJqyGcN8Lo2MYEZwcKxEkINUBsIgrPIyjjFMwtEaI=;
        b=Q4Y4dVadarttYTLCJ+8ecuU0c4WmnmjenYLNUsjQXvU+uZH+3P2KuTyAW+xUSssCeV
         RAvbb80BBXX0i8PPZR2F2OOzvp9LymqPsCso6R/rEvR1pm/tY7h7bSRoL0X5YaJyNF6n
         JELXpAo5IokmJtAP32iZ1E+KHZvpC30MrW7HIuX6zFxqE5J7WHYXhdTVPTePl23KgAe3
         Crm9VsNpN+gXbD6Yp7zYiQZNE4gZ+dI563JlB3XB5UKGADU6tdRxjSLenyUEDXTq0yen
         ScVdG+udxi/HgsHcV293B1Ivd0fThS5JiVzicFcjPqVAqYLGelS59NHphJRUukx6HC4H
         jfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692715045; x=1693319845;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKQJqyGcN8Lo2MYEZwcKxEkINUBsIgrPIyjjFMwtEaI=;
        b=NE2lzeHAVxMqYsfNsNKTLAK0FMAk6XVsgCeCFtDwHMQji8D2ZkAvqbUBteAdzgtEFE
         CCnZWXmR7PABFX10wxPbAXxuVRNmI1QYSjfWvdANWymPyFWmCuHLoBkWEFTHjN/IEGoq
         g/pXlh/5wbVADUIpA0slwFZGy8UjztqrAXiCmM88cG9r8JOmyQYpXSHg/1pjn5DVwKOj
         9CBbxggerW5loNvXqWc0F49dav7Kq6plTBAWY703RhyAzHQ8HJrhKj0SPSnrGFh6CAG/
         Bo6s/7f/4Zwtg1WoVpyFEI2yp25n2qR/W+JdpptADGXdkK6L2vaSPIEY92ENwCEtbqcJ
         zXog==
X-Gm-Message-State: AOJu0Yy5ivCQi0+ANnOjhX7VQS//te0/LQsWQz5UDgtAfxaSKqVnDqB/
        9uFQs9icdXlz1Xhvxi97V6A=
X-Google-Smtp-Source: AGHT+IE4k7+T6WmJ2AOK6vXARLiTaLdoPiWhi8d2ttba0zexCnG5pfiocWqun+qLrVgBJ89vgnXcbQ==
X-Received: by 2002:a05:620a:29cf:b0:76c:d5ac:66d7 with SMTP id s15-20020a05620a29cf00b0076cd5ac66d7mr15266118qkp.43.1692715045125;
        Tue, 22 Aug 2023 07:37:25 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id o13-20020ae9f50d000000b00767da10efb6sm3230415qkg.97.2023.08.22.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:37:24 -0700 (PDT)
Date:   Tue, 22 Aug 2023 10:37:21 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Robert Nelson <robertcnelson@gmail.com>
Cc:     drew@beagleboard.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ARM: dts: am335x-pocketbeagle: update LED
 information
Message-ID: <20230822143721.GA8051@localhost>
References: <20230818151039.40566-1-twoerner@gmail.com>
 <20230818151039.40566-2-twoerner@gmail.com>
 <CAOCHtYgdxeoOvTcFjwB=iqLD5K4JzeoRF8zeQPzM_1nLh5ReYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCHtYgdxeoOvTcFjwB=iqLD5K4JzeoRF8zeQPzM_1nLh5ReYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-21 @ 10:36:34 AM, Robert Nelson wrote:
> On Sun, Aug 20, 2023 at 5:24 AM Trevor Woerner <twoerner@gmail.com> wrote:
> >
> > The "label" property is deprecated. Replace the "label" property with
> > "color" and "description" properties.
> >
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
> > index 5dfe4d4bab93..1c11245f6864 100644
> > --- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
> > +++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
> > @@ -8,6 +8,7 @@
> >
> >  #include "am33xx.dtsi"
> >  #include "am335x-osd335x-common.dtsi"
> > +#include <dt-bindings/leds/common.h>
> >
> >  / {
> >         model = "TI AM335x PocketBeagle";
> > @@ -24,28 +25,32 @@ leds {
> >                 compatible = "gpio-leds";
> >
> >                 led-usr0 {
> > -                       label = "beaglebone:green:usr0";
> > +                       color = <LED_COLOR_ID_BLUE>;
> > +                       function = LED_FUNCTION_HEARTBEAT;
> 
> So some background, while the LED are not Green, and this is not the BeagleBone.
> 
> We used these specific labels to keep all user documents going back to
> the original BeagleBone (white) (with 3.8.x kernel), the same so users
> could easily blink an led from user-space even on newer boards.
> 
> So it became our un-official abi for new users for the BeagleBoard
> family of devices..
> 
> It's even what we do on the BeaglePlay..
> 
> https://git.beagleboard.org/beagleboard/BeagleBoard-DeviceTrees/-/blob/v5.10.x-ti-unified/src/arm64/k3-am625-beagleplay.dts#L179-217

Thanks for the background. I've sent a v3 which simply adds the "color" and
"function" properties but leaves the "label" property intact.
