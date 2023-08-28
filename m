Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC86778A6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjH1Hwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjH1Hwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:52:34 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979E0114;
        Mon, 28 Aug 2023 00:52:30 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7EC73100005;
        Mon, 28 Aug 2023 10:52:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7EC73100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1693209147;
        bh=DOwX809/ogQGzA8mZC+5WxQTjKKBn0wSzPJ9NZf7I9E=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=XYzXyhcunW72M55pCdfZwWh55Awr6ugL/i///zDIZg0JT6rlBderBvALsalqnFEdQ
         6mzj3VN9L2axhSMfWr4fXSg0qZAaQTNV2CbH5s0n4vOJa08NRXBKSW6YZc3Pxuc/Co
         ABnKii/JjY8mjhlg0bDpgglpAwIEYBHGUFlp/e0cBBvRs8UeXG19eaOTFtSFycG6Lo
         GfOgatwK+V69RXCRDoHtrJzqZBEh3Ftp9DZCH9+cn+ZTQnQuEHLel/TwCrAA0hrytG
         qdi0RZZYJnDT31O9qRQ77YCv0frhCQnV8EWyq2UfUXpFCx/Wd7Blp2ZDFKmjHZGynh
         QSYIZEInZJhdA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 28 Aug 2023 10:52:27 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 28 Aug
 2023 10:52:22 +0300
Date:   Mon, 28 Aug 2023 10:52:26 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Lucas Tanure <tanure@linux.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Message-ID: <20230828075226.io27piavthiyfxea@CAB-WSD-L081021>
References: <20230827080113.2790-1-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230827080113.2790-1-tanure@linux.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;lists.infradead.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/08/28 07:01:00
X-KSMG-LinksScanning: Clean, bases: 2023/08/28 07:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/28 05:20:00 #21753632
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

On Sun, Aug 27, 2023 at 09:01:13AM +0100, Lucas Tanure wrote:
> This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.
> 

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> ---
>  drivers/tty/serial/meson_uart.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index c4f61d82fb727..790d910dafa5d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>  
>  OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
>  		    meson_serial_early_console_setup);
> -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> -		    meson_serial_early_console_setup);
>  
>  #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>  #else
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
