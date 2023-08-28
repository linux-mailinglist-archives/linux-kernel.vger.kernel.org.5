Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127078A795
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjH1IVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjH1IUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:20:34 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153AA9;
        Mon, 28 Aug 2023 01:20:12 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 77CCE100007;
        Mon, 28 Aug 2023 11:20:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 77CCE100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1693210811;
        bh=g1xOXZyE1LQxHzZ90C3yXoDtHH1l4bGH7bMSOEEE7I8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=Ei5DvdFJjuKn5GrMQhjuBgTt7CgZSyIUWWgoXnxuw8n+l5nY+AJC7Xu6YCOxfMN1p
         /Mn7vq3yh8CxH2wPQmgXE9k4Pmct4GW7MouzhcAHK0Hd9YpG42eRjN0eQyezUpBLBV
         6YWShzcxhCkSIeH5LR7MePn1/q8z4efYepRn9H01D/EvPHoq1hHehPArwp7R/wcD7S
         QSufhYRslJcqD+RG7T5W6EbHJ/jLXc4PSVXJYMfBg6GpBXDlu5WevsdIe9D5IdWioz
         kFl6WTZXMXNsDcEGpeR24S/TSvr+hxPUwsG08lB59YfhHlXTU81dnJ6S0+NQbM9XtL
         GhFC0KoZXBpNw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 28 Aug 2023 11:20:09 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 28 Aug
 2023 11:20:04 +0300
Date:   Mon, 28 Aug 2023 11:20:09 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Lucas Tanure <tanure@linux.com>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Message-ID: <20230828082009.kehgwi4fxtj3bfze@CAB-WSD-L081021>
References: <20230827082944.5100-1-tanure@linux.com>
 <7bf9e716-0ff2-56d5-07ab-db027901454e@linaro.org>
 <09735262-1bc0-40cf-b139-22cccf70bcab@linux.com>
 <e73260c9-04f8-eb1e-bb5b-c3bd2219625e@linaro.org>
 <8d2ba0d3-55eb-45cf-b88a-bafef35e96b9@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d2ba0d3-55eb-45cf-b88a-bafef35e96b9@linux.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179460 [Aug 28 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;lists.infradead.org:7.1.1;salutedevices.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/08/28 07:01:00
X-KSMG-LinksScanning: Clean, bases: 2023/08/28 07:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/28 07:05:00 #21755218
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 11:31:35AM +0100, Lucas Tanure wrote:
> On 27-08-2023 11:23, Neil Armstrong wrote:
> > Hi Lucas,
> > 
> > Le 27/08/2023 à 12:04, Lucas Tanure a écrit :
> > > On 27-08-2023 10:48, Neil Armstrong wrote:
> > > > Hi Lucas,
> > > > 
> > > > Le 27/08/2023 à 10:29, Lucas Tanure a écrit :
> > > > > This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> > > > > New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't
> > > > > need a OF_EARLYCON_DECLARE.
> > > > > 
> > > > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > > > ---
> > > > > Since V1:
> > > > > - add Signed-off-by:
> > > > > 
> > > > >   drivers/tty/serial/meson_uart.c | 2 --
> > > > >   1 file changed, 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/meson_uart.c
> > > > > b/drivers/tty/serial/meson_uart.c
> > > > > index c4f61d82fb727..790d910dafa5d 100644
> > > > > --- a/drivers/tty/serial/meson_uart.c
> > > > > +++ b/drivers/tty/serial/meson_uart.c
> > > > > @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct
> > > > > earlycon_device *device, const char *opt
> > > > >   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> > > > >               meson_serial_early_console_setup);
> > > > > -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> > > > > -            meson_serial_early_console_setup);
> > > > >   #define MESON_SERIAL_CONSOLE_PTR(_devname)
> > > > > (&meson_serial_console_##_devname)
> > > > >   #else
> > > > 
> > > > How do you use earlycon with this removed ?
> > > > 
> > > > Neil
> > > This is my kernel cmdline:
> > > console=ttyS0,921600 no_console_suspend earlycon=ttyS0,0xfe078000
> > > 
> > > And I can see my log:
> > > boot 64bit kernel
> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd092]
> > > [    0.000000] Linux version 6.5.0-rc7-next-20230825+
> > > (tanureal@ryzen) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the
> > > A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621,
> > > GNU ld (GNU Toolchain fo3
> > > [    0.000000] KASLR disabled due to lack of seed
> > > [    0.000000] Machine model: Khadas vim4
> > > [    0.000000] OF: reserved mem:
> > > 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable
> > > secmon@5000000
> > > [    0.000000] OF: reserved mem:
> > > 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap
> > > non-reusable secmon@5300000
> > > ...
> > > [    0.079368] io scheduler mq-deadline registered
> > > [    0.079374] io scheduler kyber registered
> > > [    0.079549] io scheduler bfq registered
> > > [    0.083373] fe078000.serial: ttyS0 at MMIO 0xfe078000 (irq = 14,
> > > base_baud = 1500000) is a meson_uart
> > > [    0.083403] printk: console [ttyS0] enabled
> > > 
> > > As the log is OK, and T7 for now is binding against S4 code we
> > > should drop this patch and add a S4 one if needed.
> > > 
> > > But just having this log is not enough for testing earlycon?
> > > I am assuming that by just having the log since 0.0000 is a good
> > > sign that earlycon is working.
> > > Could you give further guidance?
> > 
> > First the kernel argument is simply "earlycon" with no other options,
> > the earlycon code will fetch the first uart using the DT
> > /chosen/stdout-path property.
> > 
> > Then you should see something like right after "Machine model":
> > [    0.000000] earlycon: meson0 at MMIO 0x00000000ff803000 (options
> > '115200n8')
> > 
> > The boot log you share doesn't use earlycon, it waits until all
> > depedency of the UART
> > has been probed before probing the UART driver and prints the whole boot
> > log.
> > 
> > Earlycon is a mechanism to use the UART HW as configured by the
> > bootloader in
> > a minimal way very early in the boot in order to detect very early lockups.
> > 
> > Keeping OF_EARLYCON_DECLARE for t7 would enable this.
> > 
> > Neil
> > 
> > > 
> > > Lucas Tanure
> > > 
> > 
> But then we would need to add Earlycon for S4 too.
> How can we add one Earlycon for all future SoCs, like S4 and T7?
> 

Per my understanding, you just need to declare UART dts node with the
following compatible string: "amlogic,meson-ao-uart". It will enabled
earlycon. There is no neccessary to declare separate
OF_EARLYCON_DECLARE(). It's working okay for A1 dts:

meson-a1.dtsi uart declaration:
	uart_AO_B: serial@2000 {
		compatible = "amlogic,meson-a1-uart",
			     "amlogic,meson-ao-uart";
		reg = <0x0 0x2000 0x0 0x18>;
		interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
		clocks = <&xtal>, <&xtal>, <&xtal>;
		clock-names = "xtal", "pclk", "baud";
		status = "disabled";
	};

earlycon declaration from dts:
	aliases {
		serial0 = &uart_AO_B;
	};

	chosen {
		stdout-path = "serial0:115200n8";
	};

> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
