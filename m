Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05C755FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGQJp1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGQJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:45:03 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7711136;
        Mon, 17 Jul 2023 02:45:01 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-57688a146ecso43678127b3.2;
        Mon, 17 Jul 2023 02:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587101; x=1692179101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afoh1NpmNoS6kq/+Qod+BULX3Nr8A6niOrBy8Pn51tg=;
        b=FiSi4r1vvv7Q2rrHzM0CF99xGhkfvTY9/hx4y3vbo5ZC5dKkmNLsLcSK6ii9MJdZOs
         zciGyxkXi9Pf/HzuV0YRT/TbwFs8nlvOTxUPlzglxWtDIJPX/9boHPZLbweULVc0HOEI
         YebKkDNzKmn/bO3BG3TuXPzcM86Hk8T57UHMHCV4ORpN0/BdEzfpKT1VTwzsraQmQHw7
         Kj/v271qC3DeVCMHW2Ruj0SAEAjTTYGOln3ZNz2Rk9zi4XqK+MNyIfsertypXhtDtFCN
         Pmq2Lf/Ba00dLDSoszT25qhYC5P8GmYSaELhFtX7QOjgGftoghgzKjbdOdNPCu8CNTHQ
         5Ntg==
X-Gm-Message-State: ABy/qLbZljWEuSI6331wuNeExFfF6FHc/Xs3JVQJNWJGNr59ZW2cKYMW
        eNoXstgPaaAqtBgqOtE2sAw6IaBvpDMuSQ==
X-Google-Smtp-Source: APBJJlHuufGe53dBf6IP/74kYXsNgHd6XPmLBZNXpOOjBDMkaElSZv4fWFKSAc2RftnbPTo5laWV4g==
X-Received: by 2002:a81:83d0:0:b0:577:21ff:4d47 with SMTP id t199-20020a8183d0000000b0057721ff4d47mr10817291ywf.7.1689587100841;
        Mon, 17 Jul 2023 02:45:00 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id k1-20020a0dfa01000000b005771bb5a25dsm3698955ywf.61.2023.07.17.02.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:45:00 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-cada5e4e3f6so4367535276.3;
        Mon, 17 Jul 2023 02:45:00 -0700 (PDT)
X-Received: by 2002:a25:3c9:0:b0:c4a:695:9fa3 with SMTP id 192-20020a2503c9000000b00c4a06959fa3mr10104144ybd.2.1689587100319;
 Mon, 17 Jul 2023 02:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-9-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-9-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:44:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXd5-+2F0yG70urKe5xdwa9K_dg5t_t+UzQ9pJ+eD8FSA@mail.gmail.com>
Message-ID: <CAMuHMdXd5-+2F0yG70urKe5xdwa9K_dg5t_t+UzQ9pJ+eD8FSA@mail.gmail.com>
Subject: Re: [PATCH 08/10] spi: rzv2m-csi: Improve data types and alignment
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

Hi Fabrizio,

Thanks for your patch!

On Sat, Jul 15, 2023 at 3:04 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> "unsigned int" is more appropriate than "int" for the members
> of "struct rzv2m_csi_priv".

Agreed.

> Also, members "bytes_per_word" and "errors" introduce gaps
> in the structure.

While enlarging the types does get rid of the gaps, that was not the
intent of my comment ;-)
You can reorder fields to avoid gaps, and reduce the size of the structure.

> Adjust "struct rzv2m_csi_priv" and its members usage accordingly.
> While at it, remove the unnecessary casting of "data" to
> "struct rzv2m_csi_priv*" in function "rzv2m_csi_irq_handler".
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

> --- a/drivers/spi/spi-rzv2m-csi.c
> +++ b/drivers/spi/spi-rzv2m-csi.c

> @@ -88,14 +88,14 @@ struct rzv2m_csi_priv {
>         struct spi_controller *controller;
>         const void *txbuf;
>         void *rxbuf;
> -       int buffer_len;
> -       int bytes_sent;
> -       int bytes_received;
> -       int bytes_to_transfer;
> -       int words_to_transfer;
> -       unsigned char bytes_per_word;
> +       unsigned int buffer_len;
> +       unsigned int bytes_sent;
> +       unsigned int bytes_received;
> +       unsigned int bytes_to_transfer;
> +       unsigned int words_to_transfer;
> +       unsigned int bytes_per_word;

bytes_per_word is calculated from spi_transfer.bits_per_word,
so u8 was fine.

>         wait_queue_head_t wait;
> -       u8 errors;
> +       u32 errors;

u8 was sufficiently large to hold all possible values.

>         u32 status;
>  };
>

Anyway, the code should work fine, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
