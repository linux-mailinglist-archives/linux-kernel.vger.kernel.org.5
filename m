Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F17808FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443740AbjLGSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjLGSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:25:16 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB432E0;
        Thu,  7 Dec 2023 10:25:22 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a948922aaso6703396d6.3;
        Thu, 07 Dec 2023 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701973522; x=1702578322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JdtSkhV/uZ+qgTv5nm/tjN7XRjVnjCUJ7V0n44iPxI=;
        b=TGvZ7taiAXsoQ7SnBTc3PwpC7eY1mDVqhoFpJZX5Ev0IAic+4r0YZzytAemj5zG02m
         8ogr+N6YU0y/1rNN5yREzrYvZkZgEIQyN80+Y6lSAroCLxXFo44s7tzHVz+7nqC6GycU
         0QMiLMnQwpzbMgjQuL2wdOYzoQfXfJVd4eLX5/U7FKK+iUtkGRLYK4Mul/K8PgH836r6
         Zy08SIRENtqBYYszroaeIuxEdF+dSZk5f7r0Xv83iLRXrO9FfUeF9p29bo2ZfoTRbk3b
         UZ8KkWlxaYjRE/npllHi9Yl/hWVxikq2FE4jfDkbl633CTZ/R0FstFztOcDWNHXRMW6b
         kS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973522; x=1702578322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JdtSkhV/uZ+qgTv5nm/tjN7XRjVnjCUJ7V0n44iPxI=;
        b=jXfkOSJkRUUniTCX1dWlL9ChldJ4ZgyqqxtYdGYxlHuCbUJYi0Dxwfgb74f3BRCzwL
         NJV5EbW3vWeWaVJ2JwQiuLPu1h6d/3LdnpEZCp064TrgLeFClIqj3XeMVu3mQzbGy1IK
         khkomampIS6gi3Xpe3z6zqvNs8MQZ3cjFDFMEs/HkH1ntQvszwQyMg+du1j1x5Cr06bq
         /cXnsKCRcLDMq1wsmEPvce5byZMZSg1T7pMPCH2E+LWGZ/gRNI13mdCEB4SK8Rs/C7mu
         gVeWuuhMQLR1yF1t4JMs0Ycegmes5MhYCI/C8DyLVeAv+rV9Uo1EpPnkiCIKrIXmqzlO
         KJbg==
X-Gm-Message-State: AOJu0YyBpECXUsuHmRjr1qxFhnC1NTk4hO7PgUwgs3Gm/sl5QhJR7Sm+
        Jj1XPsXE+lFFee9xJXlf+r+/Ep/+n1xhqKTWBBo=
X-Google-Smtp-Source: AGHT+IHY+s/sc69Wv6rSKgC8GVl9b1PBrwAVNxIVr9rnmx1+q5QlZJy/UldZI2uZtz7PpgeFAYDI2UwljpPqDCLnd6Y=
X-Received: by 2002:ad4:4f11:0:b0:67a:a721:e140 with SMTP id
 fb17-20020ad44f11000000b0067aa721e140mr3126459qvb.109.1701973521839; Thu, 07
 Dec 2023 10:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20231130191050.3165862-2-hugo@hugovil.com> <202312061443.Cknef7Uq-lkp@intel.com>
 <20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com>
In-Reply-To: <20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Dec 2023 20:24:45 +0200
Message-ID: <CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com>
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in sc16is7xx_regmap_name()
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, hvilleneuve@dimonoff.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 7:52=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Wed, 6 Dec 2023 14:29:39 +0800
> kernel test robot <lkp@intel.com> wrote:

...

> >    drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_i2c_probe':
> > >> drivers/tty/serial/sc16is7xx.c:1703:41: warning: '%u' directive outp=
ut may be truncated writing between 1 and 10 bytes into a region of size 2 =
[-Wformat-truncation=3D]
> >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> >          |                                         ^~
> >    In function 'sc16is7xx_regmap_name',
> >        inlined from 'sc16is7xx_i2c_probe' at drivers/tty/serial/sc16is7=
xx.c:1805:17:
> >    drivers/tty/serial/sc16is7xx.c:1703:36: note: directive argument in =
the range [0, 4294967294]
> >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> >          |                                    ^~~~~~~~
> >    drivers/tty/serial/sc16is7xx.c:1703:9: note: 'snprintf' output betwe=
en 6 and 15 bytes into a destination of size 6
> >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Hi,
> the only solution I could find is to add this line just before snprintf:
>
>     BUG_ON(port_id > MAX310X_MAX_PORTS);
>
> it allows us to have the smallest buffer size possible.
>
> One other solution would be to change port_id from "unsigned int"
> to "u8", and increase the buffer by an additional 2 bytes to silence
> the warning, but then wasting 2 bytes for each channel, like so:

I didn't get this. It's a buffer that is rewritten on each port (why
is it even static?). Just make sure it's enough for any given number
and drop the static.

...

While at it, can you look at the following items to improve?
- sc16is7xx_alloc_line() can be updated to use IDA framework
- move return xxx; to the default cases in a few functions
- if (div > 0xffff) { --> if (div >=3D BIT(16)) { as it better shows why
the limit is that (we have only 16 bits for the divider)
- do {} while (0) in the sc16is7xx_port_irq, WTH?!
- while (1) { -- do { } while (keep_polling); in sc16is7xx_irq()
- use in_range() in sc16is7xx_setup_mctrl_ports() ? (maybe not, dunno)
- for (i--; i >=3D 0; i--) { --> while (i--) {
- use spi_get_device_match_data() and i2c_get_match_data()
- 15000000 --> 15 * HZ_PER_MHZ ?
- dropping MODULE_ALIAS (and fix the ID tables, _if_ needed)
- split the code to the core / main + SPI + I2C glue drivers

* These just come on the first glance at the code, perhaps there is
more room to improve.

--
With Best Regards,
Andy Shevchenko
