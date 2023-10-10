Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F487C009C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjJJPqD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjJJPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:46:02 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7DAC;
        Tue, 10 Oct 2023 08:46:00 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f4f80d084so70026857b3.1;
        Tue, 10 Oct 2023 08:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696952759; x=1697557559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BrSS2BkzC0XIs/6Y8FHD371dmDXGrmpx/NKcppkKyM=;
        b=hJQCFbmzIUB2TymHhLKJFgDulUYL+LIDer4/85QrYydY9bIBZ7Q1SB5RrpIR+fiTNq
         674PR3xRVsqrwDFCpACIKWfIgTldBDAMDqNIRb5TXJR1n8+zf/bqZtufdLEKdF/Bl+IU
         fXFB3IhjOi1syX89oTDAmK9yUnKmz90S9HeCVF3xkZNQ3RV6SUPoHTuaLJiaV5eN2J+B
         sXLXC5wV8z1UXZGuvSFs7FBaAf10JcZtYDVNYEyP/dAFCahaTEcW9/nucB3Ezoz0r5i5
         vy6pMNN/RVWOcSeQuoV4ahFJQIv/z6piW6p/tl9BPzElqUgBigKhNijjU9D2Vz7/fCxc
         AsfQ==
X-Gm-Message-State: AOJu0YwuA+BsbIlfUbQslKj4i540lZF3uxTVbzt78xEDFO+OE31i49B+
        tM5x/TExnT5soUMDeuk/IDcvq3BAvherfw==
X-Google-Smtp-Source: AGHT+IFgWODP/RB9wHd1yRRczE16pgDaG2QhveMQUY4lcAuIsgPVvVU+LKi6Zm27A4LqEZbLbbipTA==
X-Received: by 2002:a0d:c787:0:b0:59f:7fb9:621a with SMTP id j129-20020a0dc787000000b0059f7fb9621amr18863206ywd.22.1696952759182;
        Tue, 10 Oct 2023 08:45:59 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id m13-20020a819e0d000000b005a42740fcd4sm4445857ywj.94.2023.10.10.08.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 08:45:58 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so1682147276.2;
        Tue, 10 Oct 2023 08:45:58 -0700 (PDT)
X-Received: by 2002:a25:f44:0:b0:d91:b8c7:b423 with SMTP id
 65-20020a250f44000000b00d91b8c7b423mr13449016ybp.65.1696952758581; Tue, 10
 Oct 2023 08:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx> <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87fs2jpznr.ffs@tglx> <TYCPR01MB11269C6BF3934F9AAC44F855186CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87bkd7pic3.ffs@tglx> <TYCPR01MB11269FF2DBFDC96B9C12D2E5E86CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87o7h6o6d1.ffs@tglx>
In-Reply-To: <87o7h6o6d1.ffs@tglx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Oct 2023 17:45:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJnqkF7xmjfOyoxE_Lq=AO85CDD85qu3O+xcSr-3BLTQ@mail.gmail.com>
Message-ID: <CAMuHMdVJnqkF7xmjfOyoxE_Lq=AO85CDD85qu3O+xcSr-3BLTQ@mail.gmail.com>
Subject: Re: [PATCH v2] alarmtimer: Fix rebind failure
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

Hi Thomas,

On Tue, Oct 10, 2023 at 5:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, Oct 10 2023 at 06:18, Biju Das wrote:
> > RTC driver is defined as a module, so I was testing
> > remove/unbind followed by install/bind on RTC driver to check
> > any resource leakage and found that device is not working properly.
> >
> > As you mentioned above, we should not remove RTC driver. So I would
> > like to drop this patch.
> >
> > Is there any place we can document this to avoid another person doing
> > same mistake?
>
> The point is that the removal should not happen in the first place.
>
> Though it seems that even a held refcount on the module is not
> preventing that, which is bad to begin with.

Indeed.  I had expected to find at least one RTC driver for a device
on a hot-pluggable bus like USB, but apparently we have none of these
(yet).  So currently RTC device removal can only be triggered by a
manual sysfs unbind or delete_device.

> That aside I'm not saying that supporting removal is completely
> impossible. The charger driver can probably be fixed, but as this is a
> user space visible change this needs a lot of thoughts and proper
> analysis why such a change would be correct under all circumstances.

The charger manager seems to be considered a legacy driver.
Devices are only instantiated from the drivers/mfd/88pm860x.c (as used
on Marvell PXA910 DKB boards), or directly from DT (no upstream
users). The DT bindings say:

    Binding for the legacy charger manager driver.
    Please do not use for new products.

The "if (alarmtimer_get_rtcdev()) { ... }" you pointed out in the
probe function  seems to be rather fragile, as it depends on probe
order. And both CHARGER_MANAGER and RTC_DRV_88PM860X can be modular.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
