Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9A479C600
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjILE6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjILE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:58:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AF4ECF;
        Mon, 11 Sep 2023 21:54:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fdd5c1bbbso712450b3a.1;
        Mon, 11 Sep 2023 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694494488; x=1695099288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zwpOpIh4oXz95LntC63YJlhaKyBb/bVMEz2LsKNzrA=;
        b=jt3o8o5JrSYRQ2I1wxUh+c3uT8iBUMP50psqWb4lDImGa0eUQnXUKGm3SUvsIywcJA
         9q+X021jNaf6FSeboSDowtOjgHEAA5AFbeuVRJKMXKsTGOuRlrNSAmqPEdWemTVsoGI+
         9e+jtRexMuekQbFldUmCRMsVmaQQ4wWsEVQVsiWJmEGU5YI3Cw+0ERFks23g7folHF3b
         Un005ffcQbJqawYY8tlnctPjAVu9K8fgxfyxUlSTioEWBHw6yM9RgE8lqkmUmK/kCiJP
         Ykh6muragvU0PqkoEH3ImiB7YQK7Y5Fw6RlMOZcLjj6TloG4rIDkA6w2Sc6V+2rDJW7D
         Os0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494488; x=1695099288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zwpOpIh4oXz95LntC63YJlhaKyBb/bVMEz2LsKNzrA=;
        b=sDpkY7Pu9uH5O7iOSpdItdBa0NP/25BrNtr+2xnWwxs/Y4fiHPvOx4fZVfGGqiiazO
         QMNjZlXoKU8InSos26/b5T4fzkPDrU98CVwksGu8S8jBmsH06ddIDKLMY4H3Nbh6mtI1
         AGVlbzheBf5spju/AZAKwNZLM7IlUHOeYmnvSH6SE6ijO4ySHZXpViDfNyCZwO3DKDwg
         6ylOtARArCXuKISdPUah6dvHA2CvKOXOLSlmdAs/ay4pmpDOmI6c0IjDktTuMPr2d1AZ
         aTV2OdZAD1ZLC7CVUSY3GpXPOxXH2qhNAwAm4BHzwuKKhjfwvk8OVaFIsT7JfvJomdy3
         m8dw==
X-Gm-Message-State: AOJu0Yx0AqaoEtCo5vI+RDEk728VAQFmU5nvXQvZZKKrQSW/BfstxCv0
        VHp8bwwYssLsg82yDRbSNM0=
X-Google-Smtp-Source: AGHT+IFT19YBlkHb1EJZ4O3rYMSCK9DGz7rd8m4B3cjYTCG/MUXs6xFhpRfTURVkGdMKlFV54vjtxA==
X-Received: by 2002:a05:6a21:6d9f:b0:151:35ad:f331 with SMTP id wl31-20020a056a216d9f00b0015135adf331mr2062786pzb.14.1694494488100;
        Mon, 11 Sep 2023 21:54:48 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-232.hinet-ip.hinet.net. [220.133.92.232])
        by smtp.googlemail.com with ESMTPSA id cw22-20020a056a00451600b0068fc6570874sm2671543pfb.9.2023.09.11.21.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:54:47 -0700 (PDT)
From:   Zenm Chen <zenmchen@gmail.com>
To:     zenmchen@gmail.com
Cc:     Jes.Sorensen@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, rtl8821cerfe2@gmail.com
Subject: RE: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Date:   Tue, 12 Sep 2023 12:54:39 +0800
Message-ID: <20230912045443.9821-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230910002038.56362-1-zenmchen@gmail.com>
References: <20230910002038.56362-1-zenmchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote：
>
>
>
> > -----Original Message-----
> > From: Zenm Chen <zenmchen@gmail.com>
> > Sent: Sunday, September 10, 2023 8:21 AM
> > To: Jes.Sorensen@gmail.com
> > Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > rtl8821cerfe2@gmail.com; Ping-Ke Shih <pkshih@realtek.com>; Zenm Chen <zenmchen@gmail.com>
> > Subject: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
> >
> > ASUS USB-N13 C1 is a wifi adapter based on a RTL8192FU chip and its LED
> > doesn't blink with the rtl8xxxu driver. This patch fix this via writing
> > the correct value to the register "REG_LEDCFG0".
> >
> > This was tested with these two wifi adapters:
> > ASUS USB-N13 C1 (vid=0x0b05, pid=0x18f1, rfe_type=0x1)
> > MERCURY MW310UH (vid=0x0bda, pid=0xf192, rfe_type=0x5)
>
> Did you ever try Linux vendor driver for software and hardware LED?
> Seemingly, the vendor driver is different from yours, but I'm pretty
> sure which one is correct because I don't have a RTL8192FU stick.
>
> >
> > Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> > ---
> >  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 24 ++++++++-----------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> > b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> > index 28e93835e05a..ab6d4e4e228e 100644
> > --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> > +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> > @@ -2014,26 +2014,22 @@ static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
> >         struct rtl8xxxu_priv *priv = container_of(led_cdev,
> >                                                   struct rtl8xxxu_priv,
> >                                                   led_cdev);
> > -       u16 ledcfg;
> > +       u32 ledcfg;
> >
> >         /* Values obtained by observing the USB traffic from the Windows driver. */
> >         rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_0, 0x20080);
> >         rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x1b0000);
> >
> > -       ledcfg = rtl8xxxu_read16(priv, REG_LEDCFG0);
> > -
> > -       if (brightness == LED_OFF) {
> > -               /* Value obtained like above. */
> > -               ledcfg = BIT(1) | BIT(7);
> > -       } else if (brightness == LED_ON) {
> > -               /* Value obtained like above. */
> > -               ledcfg = BIT(1) | BIT(7) | BIT(11);
> > -       } else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
> > -               /* Value obtained by brute force. */
> > -               ledcfg = BIT(8) | BIT(9);
> > -       }
>
> The definitions are used by this driver:
>
> #define BIT_LED2EN BIT(21)
> #define BIT_LED1SV BIT(11) // the same definition with BIT_LED0SV
> #define BIT_LED1CM GENMASK(10, 8) // use the same value of BIT_LED0CM
> #define BIT_LED0SV BIT(3)
> #define BIT_LED0CM GENMASK(2, 0)
> #define LED_MODE_TX_OR_RX_EVENTS 3
> #define LED_MODE_SW_CTRL 0
>
>
> > +       /* Enable LED0 GPIO and turn LED0/LED1 off. */
> > +       ledcfg = (rtl8xxxu_read32(priv, REG_LEDCFG0) | BIT(21)) & ~0xffff;
>
> Split this statement into multiple lines and use definitions I provide above.
>
> > +
> > +       /* Values obtained by brute force. */
> > +       if (brightness == LED_ON)
> > +               ledcfg |= BIT(3) | BIT(11);
> > +       else if (brightness == RTL8XXXU_HW_LED_CONTROL)
> > +               ledcfg |= BIT(0) | BIT(1) | BIT(8) | BIT(9);
> >
> > -       rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
> > +       rtl8xxxu_write32(priv, REG_LEDCFG0, ledcfg);
> >
> >         return 0;
> >  }
> > --
> > 2.42.0
>

Thanks for the help and suggestions, I will make these changes. :)
