Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E825877138D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 06:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHFEDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 00:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFEDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 00:03:33 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34B1FD9;
        Sat,  5 Aug 2023 21:03:30 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56d263da4f2so2471281eaf.0;
        Sat, 05 Aug 2023 21:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691294610; x=1691899410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3j2Il2f+kymqampd6+H1xMyg5wmaHaMj6WUzsK3M24=;
        b=JeHD3rbz6Oa3vJtggpCJGbPAUaa5WPbgNJSNa2QzindNcq3yrWxpqyTiFq0lrKKjHk
         JXGqv4+k8OonkhPy7wV2/W84fNNEQELf5ISsQW+EayWrJcXT2ePvGNz/HQw/ZuaxeVxB
         0hWD8Ml4fP5fBKGU2N1iBd3qB21YnvPHg1KVFFhyjNfeefReRb5UmnUMQOLxxY9i38iK
         kl11E7pd6HUdF5dvgNxSi0mCIW54KFjzw2vnu5niD6kXyXNnMZs4M4q/9arrdMyp1uYP
         6fCg2DHeHUJM65sIWR2bGOlWReVlIPCeAnCAeAZkYie9NzNLFlnOPyTuExsMqZS+NtvC
         8kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691294610; x=1691899410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3j2Il2f+kymqampd6+H1xMyg5wmaHaMj6WUzsK3M24=;
        b=iaR+yLcm/pb3NK2WaHzPR4gV+xuIjGcErbCYWfFCPGm3eB//1BDbmuvF6WB4B79cV1
         vwKy9RdJxPZjKKQPftBV+WQfUaiVaF8vjNX/cY4iC9GfgREMC9KdITBC8XAJ5tgw2Gsc
         X9HMZoQIsHrcaf2pUoBBydsuc9LPAlytdR15t3Aoq8mOHsQO/QdY6O6QXciN0V9omHkP
         i3gtJFD3pp0fPO2rn1WPGm+v3q9xz/cVTwGmec9Q4g5pvVRMSrSCaxNw1G9vDHJYxjlJ
         Gbd2EHFxF+h6zv6vfJQiaBnkLAvVvKWOddzYqi4igvqovbP5E7oiBwjfhtiK2MA6ziYi
         ntsg==
X-Gm-Message-State: AOJu0Yz1gcDoWMrvQiYzeoOJFyuGwgEZPTMBP0qpTGhwkxPeKuPn2Tg8
        pvMFtNwureAOC7z18wLk0/SllHsGF23mEiACfrY=
X-Google-Smtp-Source: AGHT+IGiHomALBXL4paQosZXpHIeqNpPWBixXgzTFr0eejKLBQRLuS2hAHGiVGp8UJuxnua+vIQV/H+JkQIcbIgmp28=
X-Received: by 2002:a4a:2557:0:b0:565:9e41:85d8 with SMTP id
 v23-20020a4a2557000000b005659e4185d8mr5539528ooe.6.1691294609752; Sat, 05 Aug
 2023 21:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230121175639.12818-1-linux.amoon@gmail.com> <20230121175639.12818-4-linux.amoon@gmail.com>
 <ZMrFb7H1ynwwBSCA@Dell-Inspiron-15> <45d25fd5-465f-347b-448b-ce171626f34e@linaro.org>
 <ZM7jtD2rniWAexVZ@Dell-Inspiron-15>
In-Reply-To: <ZM7jtD2rniWAexVZ@Dell-Inspiron-15>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 6 Aug 2023 09:33:14 +0530
Message-ID: <CANAwSgTBmLKknkWDUyZ2Byr15Oy6jbNxEYYjKGNr=2cOn5Wowg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid c2
To:     Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Sun, 6 Aug 2023 at 05:35, Ben Wolsieffer <benwolsieffer@gmail.com> wrote:
>
> On Sat, Aug 05, 2023 at 11:30:21PM +0200, Krzysztof Kozlowski wrote:
> > On 02/08/2023 23:06, Ben Wolsieffer wrote:
> > >
> > > Hello,
> > >
> > > This patch breaks USB support on the ODROID-C2. As soon as the
> > > onboard_usb_hub module is loaded, all USB devices disconnect.
> > > Blacklisting onboard_usb_hub makes USB work as expected.
> > >
> > > I tried to reproduce the problem by manually toggling the reset line,
> > > but the problem seems to be specific to this driver. When reset is
> > > asserted manually, the devices disconnect, but they all enumerate again
> > > as soon as reset is released.
> > >
> > > Also, I have been unable to make USB work again (until the next reboot)
> > > even after unloading onboard_usb_hub.
> >
> > Wasn't this patch made exactly to fix USB support, not break it? I might
> > be missing something but maybe this was not tested at all?
> >
> > Best regards,
> > Krzysztof
> >
>
> I have been using USB on the ODROID-C2 for several years without issues.
> It looks to me that this patch was designed to make reset control for
> the hub more elegant, rather than fix a specific issue. The same change
> was applied to several devices, so it seems plausible that it was not
> tested on all of them.
>

We tried to fix quite a few issues in the past but still, we could not
resolve core issues.
Will try to resolve these issues in the future.
I have tested these changes at my end on Odroid C1+, Odroid C2, and Odroid C4,

> Thanks, Ben

Thanks
-Anand
