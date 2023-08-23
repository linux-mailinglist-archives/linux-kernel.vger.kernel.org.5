Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23BF7852C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjHWIfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjHWIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:32:37 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3081992;
        Wed, 23 Aug 2023 01:29:43 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D0305120006;
        Wed, 23 Aug 2023 11:29:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D0305120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692779380;
        bh=QzMjBvzlospPk5KHrhQ+GvuZ1CxBAXmoqO/NqK6Dr6A=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=R/QmyVav+oIHLcxNKn+ZeY7hfNPhpz0kmYG1UGXvMNG9JpSxaCbwQ0EyVWEEuh3x/
         0Uon3mIXAMg3erIoJHfR2YkgLkSJYZdyZ3bunaslnQad+s6KlWWml4xHM7rENtPM88
         QiTjD7/m6QvZ2aVRxMuAZ2n405bMAw1gyM8emIXD3vG+8MVcqvjzHuxYqhp61KP5uO
         0QSH7zxuGSSvTVfyZTbRKycgVufwsAWlGC5Zul8IaUC3bLSy6vQc90miJuU4Xl+R94
         cTAtTSTVuWhRfYp3pKWpE9DWcMB5sG49z1v7jI8NK8M8A5w4OWsUg6pUJrL7a/3OCK
         NZDt1if4VvMpQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 23 Aug 2023 11:29:40 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 11:29:34 +0300
Date:   Wed, 23 Aug 2023 11:29:40 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Lucas Tanure <tanure@linux.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Nick <nick@khadas.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] tty: serial: meson: Add a earlycon for the T7 SoC
Message-ID: <20230823082940.t4xjgfzwpt2hsfst@CAB-WSD-L081021>
References: <20230814080128.143613-1-tanure@linux.com>
 <20230814080128.143613-2-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230814080128.143613-2-tanure@linux.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179393 [Aug 23 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, libera.irclog.whitequark.org:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/08/23 05:56:00
X-KSMG-LinksScanning: Clean, bases: 2023/08/23 05:55:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/23 04:58:00 #21681850
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lucas,

Thank you for the patch! Please find my small comment below.

On Mon, Aug 14, 2023 at 09:01:28AM +0100, Lucas Tanure wrote:
> The new Amlogic T7 SoC does not have a always-on uart,
> so add OF_EARLYCON_DECLARE for it.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Since v8:
>  - Fix issues with git send-mail command line
> Since v7:
>  - Send to the correct maintainers
> 
>  drivers/tty/serial/meson_uart.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 790d910dafa5..c4f61d82fb72 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -648,6 +648,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>  
>  OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>  		    meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> +		    meson_serial_early_console_setup);
>  
>  #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>  #else

I suppose you need to add a separate meson_t7_uart_data to switch the T7
UART to a regular TTY devname 'ttyS'. For the new Amlogic SoCs, we have
agreed to use 'ttyS' instead of 'ttyAML'. Please refer to the already
applied patch series at [1] and the IRC discussion at [2].

Links:
    [1] https://lore.kernel.org/all/20230705181833.16137-1-ddrokosov@sberdevices.ru/
    [2] https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03

-- 
Thank you,
Dmitry
