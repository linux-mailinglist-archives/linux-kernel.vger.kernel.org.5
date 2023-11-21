Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACB7F278E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjKUIeI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 03:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKUIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:34:06 -0500
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B0F9;
        Tue, 21 Nov 2023 00:34:03 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5cb9407e697so3705217b3.3;
        Tue, 21 Nov 2023 00:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700555642; x=1701160442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvU52/Ubi+bAinyzeHT0A3LXlb5oIMheUWuwfdkOyZY=;
        b=C/on8yQX7kZPtIc5OpWv6TzAu/ruGEaOq9+yblp2NcZRaG8zuJUVcUB6M23iDGNbF3
         7sMtrUjpNec54dNHlqReXuNOoXHhqZQPlNvAr9dgM14yCfFhSVEbfhHBMBzEoxtRoDqM
         L5dZggtqoVmxRFwp8EFoHe/rYI+YvS44WMhGmbcDpne/2f96kgkL+Y1FcM2c2Dpq9R3X
         0X2BYK8HUbmcdDF/tzNsUohqwkMwjPXfY85DPuSE/U5c4kKsGzzzi1xY6Ugfq+ram7PD
         dfBpSe54J+L3fw5pzdd/wrUSLSso9QPNbPvKIVdI9F/vUHIH78DpgBiDW8tF00Pj4fp1
         fCZg==
X-Gm-Message-State: AOJu0YxFauLejfNB8/wbEUhnqKDYjaHnT35J6Ukb0E1HZe8uema7X05p
        JeycguuSS0oZ8jTZhoEgkrO5qFB/s3fKqqvp
X-Google-Smtp-Source: AGHT+IHLjYFUuhPifhgp6Y9NCeDp99nZPXeZZfv3+u5PRuIuMoywYGK9jtbOBY9xXCUOyODzuFFTAg==
X-Received: by 2002:a81:d512:0:b0:5a7:d461:a2b7 with SMTP id i18-20020a81d512000000b005a7d461a2b7mr4551069ywj.43.1700555642235;
        Tue, 21 Nov 2023 00:34:02 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id k186-20020a0dfac3000000b00559f1cb8444sm2926023ywf.70.2023.11.21.00.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 00:34:01 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so5134789276.0;
        Tue, 21 Nov 2023 00:34:01 -0800 (PST)
X-Received: by 2002:a25:16c5:0:b0:d9a:6831:ec1c with SMTP id
 188-20020a2516c5000000b00d9a6831ec1cmr8151483ybw.53.1700555641181; Tue, 21
 Nov 2023 00:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20231011195923.67404-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231011195923.67404-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Nov 2023 09:33:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7558Acdi5jQp2JpHwatVtJGKOLq+VhQz5u6MYyhktaA@mail.gmail.com>
Message-ID: <CAMuHMdU7558Acdi5jQp2JpHwatVtJGKOLq+VhQz5u6MYyhktaA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Enhance driver to support
 interrupt affinity setting
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Oct 11, 2023 at 10:00 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Implement irq_set_affinity callback so that we can set affinity
> for GPIO IRQs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
