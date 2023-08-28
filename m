Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B37978B01E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjH1M1l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjH1M1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:27:15 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B9EA;
        Mon, 28 Aug 2023 05:27:12 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-579de633419so36896727b3.3;
        Mon, 28 Aug 2023 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225631; x=1693830431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vd2oaz8O6yC6TQP51Ippcp5WPCtEkFpwR0Ae/q8Ui2E=;
        b=e8u0V2TvO0uHANUl0Rhz/MfCy384V/wqM6SG4UYYm1mqFSR8rHVA8nCAuwC0ig6vk8
         WfY52LhayCxQF//+DB0/+fgS10rm1yf6ZyEpPZLH//iGv8TUHkjbQHtlzl6i2FA0TBZt
         /dDX++0A836i+Qy66GJ0iy3SHP7BUybLC8QOR5v8jNjzWATbUySAFW2nm4EplLevSdQj
         qwITqqARYpgDv7hJdZZNaeUPPjaQ2NQuFlyxCm9xZiGFGoTBMlzESNj60IQDNBEFIrV4
         lJShDN7p7usqgGbYW1+aVXPicHYdSWM7tIzpQU1XhwKGiUEs/W3YRvcEVdClmmxKISeH
         r7dA==
X-Gm-Message-State: AOJu0YykHPyp3+7N3KDUOBwbf/dytdE4gnd7A2vSV1U7gu3lti0kyxXy
        +KbCLUTWzq/4Q5WGJl9dcPfBt5i/N63zYBQ5
X-Google-Smtp-Source: AGHT+IGY/qPqe4wmcsLiZQBSQrlUTsYSufUql98rrNPUTxGjDu2BjNZMenr0NspjuMTmlMPUfc+YfA==
X-Received: by 2002:a0d:d8ca:0:b0:583:e958:39c6 with SMTP id a193-20020a0dd8ca000000b00583e95839c6mr26368950ywe.34.1693225631058;
        Mon, 28 Aug 2023 05:27:11 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id o3-20020a817303000000b00583f8f41cb8sm2076182ywc.63.2023.08.28.05.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 05:27:10 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-579de633419so36896447b3.3;
        Mon, 28 Aug 2023 05:27:10 -0700 (PDT)
X-Received: by 2002:a0d:ddc8:0:b0:592:7a6c:65a8 with SMTP id
 g191-20020a0dddc8000000b005927a6c65a8mr13008456ywe.26.1693225630384; Mon, 28
 Aug 2023 05:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230828121053.60838-1-tanure@linux.com> <7720b990-c9cf-4c3d-8bb2-928b3b17f089@linaro.org>
In-Reply-To: <7720b990-c9cf-4c3d-8bb2-928b3b17f089@linaro.org>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Mon, 28 Aug 2023 13:26:59 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+0AWcY7SySsdtVn=7xE8H0YtLBfN2XrKSOZMGB-60NRhg@mail.gmail.com>
Message-ID: <CAJX_Q+0AWcY7SySsdtVn=7xE8H0YtLBfN2XrKSOZMGB-60NRhg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: meson: Add a earlycon for the S4 SoC
To:     neil.armstrong@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 1:16 PM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 28/08/2023 14:10, Lucas Tanure wrote:
> > The new Amlogic S4 SoC does not have a always-on uart, so add
> > OF_EARLYCON_DECLARE for it.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >   drivers/tty/serial/meson_uart.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > index 790d910dafa5..8dfaa260e545 100644
> > --- a/drivers/tty/serial/meson_uart.c
> > +++ b/drivers/tty/serial/meson_uart.c
> > @@ -646,8 +646,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
> >       return 0;
> >   }
> >
> > -OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> > -                 meson_serial_early_console_setup);
> > +OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart", meson_serial_early_console_setup);
> > +OF_EARLYCON_DECLARE(meson, "amlogic,meson-s4-uart", meson_serial_early_console_setup);
>
> Not sure why you would change both lines, and where's the t7 entry ?
ok, but we don't need t7, right? T7 will use S4 compatible line.
>
> Neil
>
> >
> >   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
> >   #else
>
