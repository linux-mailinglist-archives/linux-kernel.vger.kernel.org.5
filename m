Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BC78A814
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjH1Isa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjH1IsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:48:02 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8FE3;
        Mon, 28 Aug 2023 01:48:00 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5924093a9b2so34878567b3.2;
        Mon, 28 Aug 2023 01:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693212479; x=1693817279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ACD31EY/rxDEAChDoGR9W2f4aNhsarF9DV0zWxajQg=;
        b=CpS1VKDQ8K3aR819dVKfB6xLYXd6JMcrel3FQTKoHTNhmJsqKtYN37pjGJnDVt6cUb
         6BRb8TAGC90SBX7hpCaGQFBGJJI2huKn4aqjm9M1cXvVomk1KCWHbUVm7cRtiMBL6dpt
         CkGQe7FUaFGJ+wVC7afE5V6xunsOwMWHFlX8b9K9hCqw2hYUGl87f4BzSt9+XDpkRjml
         7rWM626A3wsbqbpno7jajD6mQjKFNPAGVwfSFBOPPBKEA8RBsff6klQupKG5Mh+4g349
         7WguGBPkUoZ/kA+epiUzwwqHLYRMtRb9600zAQrlxeU79hooZXkMOzCzIbL/6eOrO/9Z
         1Big==
X-Gm-Message-State: AOJu0YznjpDCnjFFWe4MX9NDkZ074dobg/RONeW1YXg76koERwoevC9O
        xra1Qf7XvL0w4dJ4QifNO6x/xEdTCQ2Yf66a
X-Google-Smtp-Source: AGHT+IHd7jlmkAewYM2+npOH3q13ShPElnPVyKB8CgOdKjAGyiSJBkh0/BWeeqi+KFUtAUDGpR/aeA==
X-Received: by 2002:a81:91c5:0:b0:573:30c8:6e1d with SMTP id i188-20020a8191c5000000b0057330c86e1dmr27840686ywg.44.1693212479168;
        Mon, 28 Aug 2023 01:47:59 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id c3-20020a81df03000000b005928d602f44sm2000691ywn.31.2023.08.28.01.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 01:47:58 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5925e580f12so34827937b3.3;
        Mon, 28 Aug 2023 01:47:58 -0700 (PDT)
X-Received: by 2002:a81:a014:0:b0:586:563:e61f with SMTP id
 x20-20020a81a014000000b005860563e61fmr27289825ywg.45.1693212478286; Mon, 28
 Aug 2023 01:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230827082944.5100-1-tanure@linux.com> <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
 <09735262-1bc0-40cf-b139-22cccf70bcab@linux.com> <e73260c9-04f8-eb1e-bb5b-c3bd2219625e@linaro.org>
 <8d2ba0d3-55eb-45cf-b88a-bafef35e96b9@linux.com> <20230828082009.kehgwi4fxtj3bfze@CAB-WSD-L081021>
 <e070f432-28bd-465f-ad66-53add8b61907@linaro.org> <20230828084632.sp73jppcrfvc7nv3@CAB-WSD-L081021>
In-Reply-To: <20230828084632.sp73jppcrfvc7nv3@CAB-WSD-L081021>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Mon, 28 Aug 2023 09:47:47 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3x0XtARZwf0_Dh-skAF9Qj3S3uUmLv2mFJO3ZWR2+3og@mail.gmail.com>
Message-ID: <CAJX_Q+3x0XtARZwf0_Dh-skAF9Qj3S3uUmLv2mFJO3ZWR2+3og@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7 SoC"
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
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

On Mon, Aug 28, 2023 at 9:46 AM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>
> On Mon, Aug 28, 2023 at 10:23:45AM +0200, Neil Armstrong wrote:
> > Hi,
> >
> > On 28/08/2023 10:20, Dmitry Rokosov wrote:
> > > On Sun, Aug 27, 2023 at 11:31:35AM +0100, Lucas Tanure wrote:
> > > > On 27-08-2023 11:23, Neil Armstrong wrote:
> > > > > Hi Lucas,
> > > > >
> > > > > Le 27/08/2023 à 12:04, Lucas Tanure a écrit :
> > > > > > On 27-08-2023 10:48, Neil Armstrong wrote:
> > > > > > > Hi Lucas,
> > > > > > >
> > > > > > > Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
> > > > > > > > This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> > > > > > > > New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't
> > > > > > > > need a OF_EARLYCON_DECLARE.
> > > > > > > >
> > > > > > > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > > > > > > ---
> > > > > > > > Since V1:
> > > > > > > > - add Signed-off-by:
> > > > > > > >
> > > > > > > >    drivers/tty/serial/meson_uart.c | 2 --
> > > > > > > >    1 file changed, 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/tty/serial/meson_uart.c
> > > > > > > > b/drivers/tty/serial/meson_uart.c
> > > > > > > > index c4f61d82fb727..790d910dafa5d 100644
> > > > > > > > --- a/drivers/tty/serial/meson_uart.c
> > > > > > > > +++ b/drivers/tty/serial/meson_uart.c
> > > > > > > > @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct
> > > > > > > > earlycon_device *device, const char *opt
> > > > > > > >    OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> > > > > > > >                meson_serial_early_console_setup);
> > > > > > > > -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> > > > > > > > -            meson_serial_early_console_setup);
> > > > > > > >    #define MESON_SERIAL_CONSOLE_PTR(_devname)
> > > > > > > > (&meson_serial_console_##_devname)
> > > > > > > >    #else
> > > > > > >
> > > > > > > How do you use earlycon with this removed ?
> > > > > > >
> > > > > > > Neil
> > > > > > This is my kernel cmdline:
> > > > > > console=ttyS0,921600 no_console_suspend earlycon=ttyS0,0xfe078000
> > > > > >
> > > > > > And I can see my log:
> > > > > > boot 64bit kernel
> > > > > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd092]
> > > > > > [    0.000000] Linux version 6.5.0-rc7-next-20230825+
> > > > > > (tanureal@ryzen) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the
> > > > > > A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621,
> > > > > > GNU ld (GNU Toolchain fo3
> > > > > > [    0.000000] KASLR disabled due to lack of seed
> > > > > > [    0.000000] Machine model: Khadas vim4
> > > > > > [    0.000000] OF: reserved mem:
> > > > > > 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable
> > > > > > secmon@5000000
> > > > > > [    0.000000] OF: reserved mem:
> > > > > > 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap
> > > > > > non-reusable secmon@5300000
> > > > > > ...
> > > > > > [    0.079368] io scheduler mq-deadline registered
> > > > > > [    0.079374] io scheduler kyber registered
> > > > > > [    0.079549] io scheduler bfq registered
> > > > > > [    0.083373] fe078000.serial: ttyS0 at MMIO 0xfe078000 (irq = 14,
> > > > > > base_baud = 1500000) is a meson_uart
> > > > > > [    0.083403] printk: console [ttyS0] enabled
> > > > > >
> > > > > > As the log is OK, and T7 for now is binding against S4 code we
> > > > > > should drop this patch and add a S4 one if needed.
> > > > > >
> > > > > > But just having this log is not enough for testing earlycon?
> > > > > > I am assuming that by just having the log since 0.0000 is a good
> > > > > > sign that earlycon is working.
> > > > > > Could you give further guidance?
> > > > >
> > > > > First the kernel argument is simply "earlycon" with no other options,
> > > > > the earlycon code will fetch the first uart using the DT
> > > > > /chosen/stdout-path property.
> > > > >
> > > > > Then you should see something like right after "Machine model":
> > > > > [    0.000000] earlycon: meson0 at MMIO 0x00000000ff803000 (options
> > > > > '115200n8')
> > > > >
> > > > > The boot log you share doesn't use earlycon, it waits until all
> > > > > depedency of the UART
> > > > > has been probed before probing the UART driver and prints the whole boot
> > > > > log.
> > > > >
> > > > > Earlycon is a mechanism to use the UART HW as configured by the
> > > > > bootloader in
> > > > > a minimal way very early in the boot in order to detect very early lockups.
> > > > >
> > > > > Keeping OF_EARLYCON_DECLARE for t7 would enable this.
> > > > >
> > > > > Neil
> > > > >
> > > > > >
> > > > > > Lucas Tanure
> > > > > >
> > > > >
> > > > But then we would need to add Earlycon for S4 too.
> > > > How can we add one Earlycon for all future SoCs, like S4 and T7?
> > > >
> > >
> > > Per my understanding, you just need to declare UART dts node with the
> > > following compatible string: "amlogic,meson-ao-uart". It will enabled
> > > earlycon. There is no neccessary to declare separate
> > > OF_EARLYCON_DECLARE(). It's working okay for A1 dts:
> >
> > This works on A1 because uart_AO_B is an Always-On UART, and using amlogic,meson-ao-uart
> > is corrent.
> > But for S4 & T7, Amlogic dropped the Always-On power domain, so there's no more AO uarts,
> > so using amlogic,meson-ao-uart on those is abusing the DT to enable a driver functionality.
> >
> > So the solution is to add those OF_EARLYCON_DECLARE and only use the correct
> > /chosen/stdout-path property.
>
> Oh, I didn't know about missing Always-On UART AO power domain. In this
> situation I'm fully agree with separate OF_EARLYCON_DECLARE(). Thank you
> for explanation!
>
> > >
> > > meson-a1.dtsi uart declaration:
> > >     uart_AO_B: serial@2000 {
> > >             compatible = "amlogic,meson-a1-uart",
> > >                          "amlogic,meson-ao-uart";
> > >             reg = <0x0 0x2000 0x0 0x18>;
> > >             interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> > >             clocks = <&xtal>, <&xtal>, <&xtal>;
> > >             clock-names = "xtal", "pclk", "baud";
> > >             status = "disabled";
> > >     };
> > >
> > > earlycon declaration from dts:
> > >     aliases {
> > >             serial0 = &uart_AO_B;
> > >     };
> > >
> > >     chosen {
> > >             stdout-path = "serial0:115200n8";
> > >     };
> > >
> > > >
> > > > _______________________________________________
> > > > linux-amlogic mailing list
> > > > linux-amlogic@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-amlogic
> > >
> >
>
> --
> Thank you,
> Dmitry
So let's add:

OF_EARLYCON_DECLARE(meson, "amlogic,meson-s4-uart",
meson_serial_early_console_setup);

ok?
