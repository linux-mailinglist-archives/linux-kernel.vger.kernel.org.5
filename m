Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9FA78DE71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbjH3TCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbjH3RnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:43:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30771107;
        Wed, 30 Aug 2023 10:43:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso36481975e9.0;
        Wed, 30 Aug 2023 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693417385; x=1694022185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JSXWasOYO+IgsYBMXFWCY2VQ2JeAF0ezZhUsdBIZOU=;
        b=VxvboSVngPIpuHNXkFJjZE2g8K1qwlGOtrG/y5i4laJsjKGTMOE9C14jybMmI3Cpke
         D3YpzLUaPV4pcIpIFU7/JbijWCxUc+BPl2f1IOJ8TyRrhrVxU9agxWJqvQz/qDOTbznC
         HNLtXcOEb1x762GfH17WQ9dwxvnBDawFye2QTanSJkVa2aAkKV8zuIryuIbTFzEeOY6f
         qYXHwhSJRVdF3y2neXpKrv95dE3ewOOctDhgwVS5JMg2Ye2opIOIqyjv01cIN22eXqPt
         TJ3AkVkHm7R1b5v8U+ac13IZtVhChX79OdVb65i1P4POB0lP9MtdiRa3pPDbAFmuwuU3
         bBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693417385; x=1694022185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JSXWasOYO+IgsYBMXFWCY2VQ2JeAF0ezZhUsdBIZOU=;
        b=NhT/uQepDv5TU6ezX5hc1qG2TeLQtXEFuPi6udrkOSyWFFQI2p+kwbTnEgD0i3PRsG
         ZtFIwq+p3P8gb+qZvJIEeKlEmpY36dczEq7WO0URD5PVeicXleIhk4SkUoqwXcuEon2C
         8G8NpevrTu2rVCGnOwhW2XIWu+4qOzwDfxllWyKsGA7dskoqJJnxYnfib+QbC4VVARG4
         vrWVbekksmlXluwg4zQm0LIy3SnFKpLtN0j0r96Icuy1nBJDGMj0U5kfziuFU/eGxtLe
         rpqIzYC/c8Ma0p+0kryqxAQ5xrTCXs2xwR9vQsxgliW9kS8aZjKC9AhmIYVt6Xcd8HIF
         /mYA==
X-Gm-Message-State: AOJu0Yx4rtbjuP7NQB3FO1mKiGHh5Ud8PRtaICMKnDP53bsoeshi9P8e
        vynq8kT0o/At163/idZRRVw=
X-Google-Smtp-Source: AGHT+IGGn543ToY4d/XKjEsPa+tBnkoKxtYRQQQgLpPrRGf7ypUN2BHLOr9JUzJFAvm4rOwksQgWTw==
X-Received: by 2002:a7b:ca47:0:b0:401:b6f6:d8fd with SMTP id m7-20020a7bca47000000b00401b6f6d8fdmr2578193wml.6.1693417385402;
        Wed, 30 Aug 2023 10:43:05 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003fbe791a0e8sm3043822wms.0.2023.08.30.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 10:43:04 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        david@ixit.cz, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v6 0/2] usb: serial: add support for CH348
Date:   Wed, 30 Aug 2023 19:43:03 +0200
Message-ID: <2595072.9XhBIDAVAK@archbook>
In-Reply-To: <20230628133834.1527941-1-clabbe@baylibre.com>
References: <20230628133834.1527941-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 28. Juni 2023 15:38:32 CEST Corentin Labbe wrote:
> Hello
> 
> The CH348 is an octo serial to USB adapter.
> The following patch adds a driver for supporting it.
> Since there is no public datasheet, unfortunatly it remains some magic values.
> 
> It was tested with a large range of baud from 1200 to 1500000 and used with
> success in one of our kernel CI testlab.
> 
> Regards
> 
> [...]

Hello,

thank you for your work on this. I recently made myself a CH348
board and used this patchset with a small test application[1]
to see how it performs. Specifically, I ran this on an RK3566
single board computer, connecting one serial adapter to the
other, with the test as follows:

 ./serialtest /dev/ttyUSB0 9600 # UART0 of 1st CH348 board
 ./serialtest /dev/ttyUSB8 9600 # UART0 of 2nd CH348 board

One problem I've noticed is that writes to the tty fd never
seem to block. On two CH340 adapters I have, they do seem to
block, whereas here, you can see from the statistics at the
end that magnitudes more bytes were written than read, with
seemingly most of them being discarded. From my reading of
the termios parameters I set, this shouldn't be the case,
right?

You can see from the error percentage that it gets less
bad as you increase the serial baudrate; I've tested up
to 6 mbaud like this. I assume that's because less written
bytes get discarded.

Any ideas on whether I'm relying on weird driver behaviour
with the blocking here or if this driver actually has a
defect whereby it never signals to userspace that less
bytes were written than have been submitted?

Kind regards,
Nicolas Frattaroli

[1]: https://github.com/CounterPillow/serialtest


