Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210F18069A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377186AbjLFI3G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 03:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjLFI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:29:04 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B6AB;
        Wed,  6 Dec 2023 00:29:11 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5d34f8f211fso69924727b3.0;
        Wed, 06 Dec 2023 00:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851350; x=1702456150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSTEGLqyRD15bhDdDT/pKQ6YzOXQHX8vZxpxtwEw3ng=;
        b=Im9xdehDYC2ieoOPmyEIkeFSMm0vS+qPi+wndQZm0HZm+Pu5uIepcQFP+Pj8izKYyz
         e0hzysARAv4pzlbGtpr8ba/zFMZRhx4asdsWxmM0chwr+wsw0ykjnT1b/oQ64Fqq/TQa
         13JYL/gdZWZUptIYcdJPpEImq3x9GRGcgXvbqnP7m548rzNvPOPfkRziYpHAE2OgQ+Ft
         VBhKfp2ORKAllrD+45v8CVmqDpVM+xo+C+nNjffo+XjkISQr6anqQaeYSsJs8DOSE8Io
         pvV/A+4NvCynLka/Lp5TiAM65gfluqCQUkUBkC00kgPpesA+hOxqFUb0Q9pocGjpV8oI
         4kHw==
X-Gm-Message-State: AOJu0YzG4C3GF6Skd1fb7U5JWQxVmCRz1E1Wf1PqADAGV72Znl2d7DuC
        r1s33wg3DpuKSdp9SCRuZtc4yq3IXP7uVA==
X-Google-Smtp-Source: AGHT+IF+CWhBF7IYQQshhdsRjuCXoK3e3vGq1P2gLL75NMz9RxGuCABZ6ahow4BsdAy7P1weiE7mLA==
X-Received: by 2002:a81:c909:0:b0:59f:4bc3:3e9 with SMTP id o9-20020a81c909000000b0059f4bc303e9mr399627ywi.46.1701851350291;
        Wed, 06 Dec 2023 00:29:10 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id l6-20020a0dc906000000b005add997ae53sm3868842ywd.81.2023.12.06.00.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 00:29:09 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-da819902678so4625090276.1;
        Wed, 06 Dec 2023 00:29:09 -0800 (PST)
X-Received: by 2002:a25:a383:0:b0:db6:1cb0:7754 with SMTP id
 e3-20020a25a383000000b00db61cb07754mr421927ybi.59.1701851349599; Wed, 06 Dec
 2023 00:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20231206073712.17776-1-jirislaby@kernel.org> <20231206073712.17776-7-jirislaby@kernel.org>
In-Reply-To: <20231206073712.17776-7-jirislaby@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Dec 2023 09:28:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcCpDJcBzf_g21AWfHON7=HtT+yBs--uL34UJpVRAW_Q@mail.gmail.com>
Message-ID: <CAMuHMdVcCpDJcBzf_g21AWfHON7=HtT+yBs--uL34UJpVRAW_Q@mail.gmail.com>
Subject: Re: [PATCH 06/27] tty: ami: use u8 for characters and flag
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Dec 6, 2023 at 8:37 AM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> Switch character types to u8. To conform to characters in the rest of
> the tty layer.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -81,7 +81,7 @@ struct serial_state {
>         int                     quot;
>         int                     IER;    /* Interrupt Enable Register */
>         int                     MCR;    /* Modem control register */
> -       int                     x_char; /* xon/xoff character */
> +       u8                      x_char; /* xon/xoff character */
>  };
>
>  static struct tty_driver *serial_driver;
> @@ -178,7 +178,7 @@ static void receive_chars(struct serial_state *info)
>  {
>          int status;
>         int serdatr;
> -       unsigned char ch, flag;
> +       u8 ch, flag;
>         struct  async_icount *icount;
>         bool overrun = false;
>

I think it would make sense to fold this into "[PATCH 04/27] tty:
make tty_operations::send_xchar accept u8 char".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
