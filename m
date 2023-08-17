Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3177F135
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbjHQHbg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348478AbjHQHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:31:24 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C821FC8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:31:22 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so5714048276.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257481; x=1692862281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOaqzuTKKoZ2nsOmaiM8FLeS8uIMuj6AgXRnSyVBWl0=;
        b=iIWcO3P8wX3hFvOrES2x9o5oeXreXM1Hl20ZccOvO41Zj3nhDaGYvHyQS2iyipTIys
         fV5V9C08Cv2vcfZT97jATTHya4G7Xl9RACnUrPIpbUxfr1rvlcKiOeKbEC1No5D57EAZ
         YzZZZ4qAwLC0Ffg37KoVDGotfzxp0yRJ93r6DgMkdvsdOAy1yKrcwWx65l7K5ZRayK+F
         9MSo9VLWVYw4RUP1tAOSj2t05BspAk/rqphi1nW/0XTlXVrQA3Vpzyn5RC3Unh/GCFTd
         zEcJu1PF+G5zANg19xhBK/o2hmH8yFZzCQYrVzn7TDQt4DzcH2ZUV4BpEFl99puvIeMv
         hRKQ==
X-Gm-Message-State: AOJu0YzCcbHG+0/7ABQywkt82/yQ2qQqHikCN11zN1X+0CNt8vQo+/Ij
        CnoZ614QRVgFjzngfhKp4CihIIzuFAxxLg==
X-Google-Smtp-Source: AGHT+IETi9FMxRY/KYQNtwhwss7K/h6jKUu936eHm9Kfl06JtAtWplcd1qbjLkN0xjF02kKjkCPq1Q==
X-Received: by 2002:a25:d78c:0:b0:d15:f337:938b with SMTP id o134-20020a25d78c000000b00d15f337938bmr4064641ybg.8.1692257481228;
        Thu, 17 Aug 2023 00:31:21 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 78-20020a250d51000000b00d1b86efc0ffsm3875788ybn.6.2023.08.17.00.31.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 00:31:20 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d72cf9156easo670133276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:31:20 -0700 (PDT)
X-Received: by 2002:a25:ae58:0:b0:d4f:7f64:df19 with SMTP id
 g24-20020a25ae58000000b00d4f7f64df19mr3834941ybe.14.1692257480593; Thu, 17
 Aug 2023 00:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <202308161422.37GEMlZkA018197@rtits1.realtek.com.tw>
 <6c02765f89eb4455806b895a6e0cb763@realtek.com> <ZN3CQ1Y3yC9p/01Y@matsya>
In-Reply-To: <ZN3CQ1Y3yC9p/01Y@matsya>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 09:31:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF2nts19vEuPeaRGWJBgGyS591aWizspbiLgmuCvphbQ@mail.gmail.com>
Message-ID: <CAMuHMdWF2nts19vEuPeaRGWJBgGyS591aWizspbiLgmuCvphbQ@mail.gmail.com>
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

Indeed.

The only caveat is future non-on-SoC Realtek PHY drivers: they
should be added outside the if/endif block.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
