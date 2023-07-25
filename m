Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8C760B20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGYHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjGYHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:05:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C819A2;
        Tue, 25 Jul 2023 00:05:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so12970664a12.0;
        Tue, 25 Jul 2023 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690268700; x=1690873500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rywQXgpO5u1DqjN9adyjvwJjSzTGessRPrLO7F1AaE=;
        b=ULJE+D89TTUVUUaP/IV1jDtGzFhTHxd3L2rCo5moFvzGPfdJWn8qj9gVJ5/8ROoSAY
         Y1uUA7kCezicqsqNgUJRCZ1X34+FvkYxU7vFy/mRT8EbhU3Swa6T/bVyspBnXJXAfzLK
         dMAljKWUsJA9utFvN81GcHWPxiRKj9xjCm+mCwSiVGEecL38ojOF2UtwMfo7ij+fnsjy
         JMJMkrOEDlYsX0Svgn4Ajf5qgGE9Ao2zQqmgUZ36WNxrkKUEi3ysVgpI03jMAZniNRte
         gdFYsQm0+r5oO4+4dRMJ+87H2B4C3bbel467x1GBaAPcZzc8hpwaaGbqheDFmdBrwkYa
         3c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690268700; x=1690873500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rywQXgpO5u1DqjN9adyjvwJjSzTGessRPrLO7F1AaE=;
        b=W0A3Yuyqp3Vdvr8rOS9C9sf6iDG5kkTrLrc2RQ5LaT2xJkLiuYjIRXFWvW5ytGNt56
         GJIKrYrExphW9qOrgWN9NFHai9ZUnN73VYzbx+1K6KM9INfB5xb4kBcNCLv1iMl9eXyZ
         ueJzjvYdWNuUawOqegBqtPmH260/3NYH4HqxhK0e4pWsOHjelY+z4JJ/veHlJO0t8mP9
         gHPJhtgL8JJIbdq1Q0fs4u+7jEZSAUOmRN1z1NqRDDmk+KBx+BXKO30P5iNDu1oMUASE
         /0cwQpOCd4gvrvxqdBidDQRR63N7IMYF/JDuXiWSR3GN5XZ0xwqE42hgPVLEhyzjTmLk
         77SA==
X-Gm-Message-State: ABy/qLZ1hzuvqsDtdO2pFYs6T7SclEpMigXe0tITjB32rkz9x6Bv43X6
        wCX/1MM9ilpci0LZa6INDkR3tM1EhVncmY9oItk=
X-Google-Smtp-Source: APBJJlEwr7S33twyOTE3LTF9R7r+4PcAikCXfdNapTZNDBhbNtanpC9v0bta0ngKhzUbGrvaADJi7TYq+dhgQNlWrrc=
X-Received: by 2002:a17:907:a089:b0:98d:f2c9:a1eb with SMTP id
 hu9-20020a170907a08900b0098df2c9a1ebmr1800076ejc.24.1690268700144; Tue, 25
 Jul 2023 00:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230725004043.381573-1-samuel.holland@sifive.com>
In-Reply-To: <20230725004043.381573-1-samuel.holland@sifive.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Jul 2023 10:04:23 +0300
Message-ID: <CAHp75Vf5FvoshtHj+3MWFCr6-6MioCydSF8c5=tZueZHPZj=XA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] gpio: sifive: Module support
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 3:40=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> With the call to of_irq_count() removed, the SiFive GPIO driver can be
> built as a module. This helps to minimize the size of a multiplatform
> kernel, and is required by some downstream distributions (Android GKI).
>
> This series removes the rest of the of_* API usage in the process.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for unreviewed (by me) patches.

Thank you!

> Changes in v3:
>  - Use dev_fwnode() instead of member access
>  - Mention the SIFIVE_GPIO_MAX check in the commit message
>  - Keep the variable for the parent IRQ domain
>  - Add a comment explaining why the IRQ data lookup will succeed
>
> Changes in v2:
>  - Add 3 new patches removing of_* API usage
>  - Add MODULE_AUTHOR and MODULE_DESCRIPTION
>
> Samuel Holland (4):
>   gpio: sifive: Directly use the device's fwnode
>   gpio: sifive: Look up IRQs only once during probe
>   gpio: sifive: Get the parent IRQ's domain from its irq_data
>   gpio: sifive: Allow building the driver as a module
>
>  drivers/gpio/Kconfig       |  2 +-
>  drivers/gpio/gpio-sifive.c | 47 ++++++++++++++++----------------------
>  2 files changed, 21 insertions(+), 28 deletions(-)
>
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
