Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3867D7B1571
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjI1H4e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1H4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:56:33 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCE92
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:56:31 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59f6e6b206fso105937477b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695887790; x=1696492590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=///6BZDQGo/3wRvsKomS4kW8ql3SPch+OsrNejAumIA=;
        b=GZVKuLLX/KflbPLdVKRDA5rN0lCj3vzpidGR4YhBSCjSF2I6X4oeXZzFTR4Tkz3Uf3
         PJYfTNspdOQL8/aHqa9FQ9krfawn+zcPmR6MUMSOD3qceaImtYW+H5ZhjXrfzmfXKx3U
         rYRG3egzECGRW5w4aOk2hCAq5Y1IF8HdMfVdMUZqoAo+ipRFU81XB+UBZHgZGYATUsIb
         L5IPXtteGZqc3z/WWs0T8nAhlAHnjfzIOypaQTn8HOr0DJpdnwXqumVkgsJSajHhR1iS
         kPmCkm3kQ9FXAiEMhlutj+hK2YU3dD+aOVAh4ykZsCl8WE3UbZ4zh4u5rgAbVu3ChPFH
         Yvfw==
X-Gm-Message-State: AOJu0Yyr7RrfS0QJ3qBH17T4R3UmONfLWq+6vnOj8B4YWb0Y0vyepK6q
        /bOU/YKtSRhXfLwaBbvc9pn7YZy25RJXpw==
X-Google-Smtp-Source: AGHT+IGK73Px8u7XEgpOJnaf4ntQxP5oTkr+DjzDxg2Iecemo9cICt8XW5bLbublL670CRAI64D1VQ==
X-Received: by 2002:a81:5286:0:b0:59f:519e:3e98 with SMTP id g128-20020a815286000000b0059f519e3e98mr537972ywb.7.1695887790686;
        Thu, 28 Sep 2023 00:56:30 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id h67-20020a0dc546000000b00583b144fe51sm4380435ywd.118.2023.09.28.00.56.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:56:30 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59f6041395dso117361477b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:56:30 -0700 (PDT)
X-Received: by 2002:a0d:ebd6:0:b0:592:9035:8356 with SMTP id
 u205-20020a0debd6000000b0059290358356mr542647ywe.26.1695887790180; Thu, 28
 Sep 2023 00:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <202308161422.37GEMlZkA018197@rtits1.realtek.com.tw>
 <6c02765f89eb4455806b895a6e0cb763@realtek.com> <ZN3CQ1Y3yC9p/01Y@matsya>
In-Reply-To: <ZN3CQ1Y3yC9p/01Y@matsya>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Sep 2023 09:56:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWor=u72E_ZfERyH3dUw3r0dsd43VsVTkx2w+DiJvyLGA@mail.gmail.com>
Message-ID: <CAMuHMdWor=u72E_ZfERyH3dUw3r0dsd43VsVTkx2w+DiJvyLGA@mail.gmail.com>
Subject: Re: [PATCH] phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
To:     Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Thu, Aug 17, 2023 at 8:46 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 17-08-23, 02:06, Stanley Chang[昌育德] wrote:
> > > diff --git a/drivers/phy/realtek/Kconfig b/drivers/phy/realtek/Kconfig index
> > > 650e20ed69af41d2..75ac7e7c31aec6f2 100644
> > > --- a/drivers/phy/realtek/Kconfig
> > > +++ b/drivers/phy/realtek/Kconfig
> > > @@ -2,6 +2,9 @@
> > >  #
> > >  # Phy drivers for Realtek platforms
> > >  #
> > > +
> > > +if ARCH_REALTEK || COMPILE_TEST
> > > +
> > >  config PHY_RTK_RTD_USB2PHY
> > >         tristate "Realtek RTD USB2 PHY Transceiver Driver"
> > >         depends on USB_SUPPORT
> > > @@ -25,3 +28,5 @@ config PHY_RTK_RTD_USB3PHY
> > >           The DHC (digital home center) RTD series SoCs used the Synopsys
> > >           DWC3 USB IP. This driver will do the PHY initialization
> > >           of the parameters.
> > > +
> > > +endif # ARCH_REALTEK || COMPILE_TEST
> >
> > Thanks for your patch.
> > Why not use "depends on"?
> > depends on ARCH_MEDIATEK || COMPILE_TEST
>
> I think this patch is better, this way all future rtek drivers will be
> fixed as well, no need to add for each driver

Is there anything still blocking this patch?
Do you want me to resend?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
