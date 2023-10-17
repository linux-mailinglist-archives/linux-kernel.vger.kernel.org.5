Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1137CCF78
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJQVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJQVnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:43:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B3A4;
        Tue, 17 Oct 2023 14:43:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c8a1541233so39817285ad.1;
        Tue, 17 Oct 2023 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697578985; x=1698183785; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8dHnHcRYCyxOwL9km7OBsoO20JO5i0CEOmfOPByDKD4=;
        b=FZVX8TgO+gFhqhyE31UL4Ln6ZtJK6hru3MDr1WyFUk/BektUohS5M5wK2pfkbWYI0A
         CeLiYjJlKOQVce/kcR0F2OPN+0db5h7rq6MMrVunbR/wRZM9O3rNndZEsse748VFaXLS
         Kmp6efMPowaTj32pXiMKSUKjOyh4FMqmgVJkkCRrF2eL5hWNVelvi2OGWaTKw2oW2CgK
         nCFowQQQeCGTKBU9MCjk0SbFzHz+ny/Z02S23O3Jp0fN9dTi/wJ1YCA4J9dgOI2G1Hob
         YrHnTBRVDgwb9FohSaNx050gC6r2cScfqAdEuaD1hr0ZTWk0V3Hij3qIFkLyPtM8+OHp
         Hqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578985; x=1698183785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dHnHcRYCyxOwL9km7OBsoO20JO5i0CEOmfOPByDKD4=;
        b=WROz8BBF/HAoz09BVHrYtqqk0EcB2dVqyz3YOIN6xqYKD1H5kTOmYiXP6WK5QP5BV9
         quOataX2L7iindHZCXkBj+NSo2/6Qaty+3fsjlPCrjqQASmjIHCD21AnuETqW2gd1h57
         SmNoV4zWur/HVIWnghK1eKydPMpzjmd6rG/PTaeneuSh3Y9aoh7z+c66gp9Xkb89Jm1e
         8iKnWyt2atYhd8XjM26ND6Ey9pKbw5ASfZc4R3L3kRlla37QAyOCW6zVtQheSbyFMfK7
         d0QIKQtSGk7yVOr5Ou/KWGGfLhMVS3IHSZDF+7q4KHQBQ+rpgMNiM92H2AQW5q9/ZIg9
         IYVQ==
X-Gm-Message-State: AOJu0Yx1nRjguAYgycqaci8VbDkjCLBTTKmxGaruBGEwaKO+Fp+GuFf7
        zXHdOLrOIOXOj68Ww+CguJk=
X-Google-Smtp-Source: AGHT+IG3MaueZJOcSd9/Qf9yVIw77h0m8YlthYHtTQm5ylSL2Cb8EOaxmwEteoKK1M643tGGfACZOw==
X-Received: by 2002:a17:902:d509:b0:1c9:b2c1:13a3 with SMTP id b9-20020a170902d50900b001c9b2c113a3mr3956209plg.49.1697578984492;
        Tue, 17 Oct 2023 14:43:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4b12:90d7:131f:fbd2])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001c7453fae33sm2040332plg.280.2023.10.17.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 14:43:04 -0700 (PDT)
Date:   Tue, 17 Oct 2023 14:43:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZS7_5VGvRnw99gzd@google.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS7kY/+80Be4geGM@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Oct 17, 2023 at 10:45:39PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 17, 2023 at 08:59:05PM +0200, Linus Walleij wrote:
> > On Tue, Oct 17, 2023 at 8:34 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Oct 17, 2023 at 08:18:23PM +0200, Linus Walleij wrote:
> > 
> > > > In the past some file system developers have told us (Ulf will know)
> > > > that we can't rely on the block device enumeration to identify
> > > > devices, and requires that we use things such as sysfs or the
> > > > UUID volume label in ext4 to identify storage.
> > >
> > > While I technically might agree with you, this was working for everybody
> > > since day 1 of support of Intel Merrifield added (circa v4.8), now _user
> > > space_ is broken.
> > 
> > Actually, I don't agree with that, just relaying it. I would prefer that we
> > solve exactly the problem that we are facing here: some random unrelated
> > code or similar affecting enumeration order of mmc devices.

Sorry, but the era of static configuration where one has a well defined
order in which things are probed and numbered has long gone. The right
answer is either device aliases that provides stable numbering on a
board that is not dependent on scheduler behavior, mutexes
implementation (how they deal with writer starvation, etc),
kernel/driver/subsystem linking order and myriad other things, or
mounting by UUID. The kernel does not provide any guarantees on the
stability of device probe and instantiation order.

If you think about it it is the same issue as legacy GPIO numbering.
It was convenient some time ago, but now it is no longer suitable or
sufficient and could change when kernel is uprevved.

> > 
> > It's not the first time it happens to me, I have several devices that change
> > this enumeration order depending on whether an SD card is plugged
> > in or not, and in a *BIG* way: the boot partition on the soldered eMMC
> > changes enumeration depending on whether an SD card is inserted
> > or not, and that has never been fixed (because above).
> 
> This is not the problem I have. I haven't added any SD card, hardware
> configuration is the same. The solely difference in the whole setup is
> this revert applied or not.

Yes, I guess there is a contention on this mutex and the fact that we
are now taking it once and not twice makes difference in which probes
happen. If you look at the logs, you will see that even before the patch
controllers did not enumerate on the order of PCI functions:

[   36.439057] mmc0: SDHCI controller on PCI [0000:00:01.0] using ADMA
[   36.450924] mmc2: SDHCI controller on PCI [0000:00:01.3] using ADMA
[   36.459355] mmc1: SDHCI controller on PCI [0000:00:01.2] using ADMA

So you have mmc2 instantiated before mmc1 even before the patch. This
happens because we now have

		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

in sdhci_driver structure in drivers/mmc/host/sdhci-pci-core.c. It just
happened that even with asynchronous probing your storage did end up on
mmc0 originally and you were happy.

I wonder, could you please post entire dmesg for your system?

> 
> > > > That said, device trees are full of stuff like this:
> > > >
> > > >         aliases {
> > > >                 serial0 = &uart_AO;
> > > >                 mmc0 = &sd_card_slot;
> > > >                 mmc1 = &sdhc;
> > > >         };
> > >
> > > And Rob, AFAIU, is against aliases.

Rob might not want them, but they are the reality and are present for
multiple classes of devices and I believe are here to stay.

> > >
> > > > Notice how this enumeration gets defined by the aliases.
> > > >
> > > > Can you do the same with device properties? (If anyone can
> > > > answer that question it's Dmitry!)
> > >
> > > No, and why should we?
> > 
> > Because device properties are not device tree, they are just some
> > Linux thing so we can do whatever we want. Just checking if
> > Dmitry has some idea that would solve this for good, he usually
> > replies quickly.
> 
> OK.

I think the right answer is "fix the userspace" really in this case. We
could also try extend of_alias_get_id() to see if we could pass some
preferred numbering on x86. But this will again be fragile if the
knowledge resides in the driver and is not tied to a particular board
(as it is in DT case): there could be multiple controllers, things will
be shifting board to board...

Thanks.

-- 
Dmitry
