Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D592755F40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGQJay convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:30:52 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1EA9;
        Mon, 17 Jul 2023 02:30:51 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so4516502276.3;
        Mon, 17 Jul 2023 02:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586250; x=1692178250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDX7xI1zE8heEghyCyWZYGmyCSYEoKKY/UxIPGZHu/o=;
        b=Rcm2VP6Javz1POklPkkNZ2IRl6GN/muGnRixfynzNB+ucoPXiIKgjKZLmn0P39DoL4
         wOfyX5tsA5uE3jXBabioIM6nJnoa8isuddP3IeNV+q2mxeHpN7tnEvw02BD3BQI7ZuPS
         +0WEmblkxdVKURqIuqp5pf5qp5Ve+c4jpXNU5K7QigHk/UytyG6UdoJriR1eDApDITuQ
         McVo+Kz6v3Rwo/2TzIbu4uKLgCbZlS/YLTC/mPA9qcQajxJYWMZTKawlV8Sd4B1wpWoJ
         WSpSYXc72rGSLSw21i3J6cPT3vXRw4975sDEooxOook+h9fzIcxBv23+Pc0gY5QUam03
         00TQ==
X-Gm-Message-State: ABy/qLbEhZI/A9XRCdWaqRT4fVOQveXJnm4pCWSsnHC8JvBnDS/fQIcC
        JQeKZqG1nZwLWknzSsMQf0IPU1TprMMR8w==
X-Google-Smtp-Source: APBJJlEJFUa8e134DKQf+g6HOg6py98/jtmWBljjVXAcnGQIAGYrkBcnNyc0qTWkBgdIco/B3uePuA==
X-Received: by 2002:a81:a081:0:b0:570:3b:a545 with SMTP id x123-20020a81a081000000b00570003ba545mr12336064ywg.51.1689586250170;
        Mon, 17 Jul 2023 02:30:50 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id d141-20020a814f93000000b005772fc5912dsm3738531ywb.91.2023.07.17.02.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:30:49 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-cada5e4e40cso4530363276.1;
        Mon, 17 Jul 2023 02:30:49 -0700 (PDT)
X-Received: by 2002:a25:d24e:0:b0:c69:54aa:d441 with SMTP id
 j75-20020a25d24e000000b00c6954aad441mr11701249ybg.34.1689586249666; Mon, 17
 Jul 2023 02:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-6-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:30:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1ZnarmGUfYBRpC78TrYxOsKnQd0CT2p2+jw0E521Mrg@mail.gmail.com>
Message-ID: <CAMuHMdW1ZnarmGUfYBRpC78TrYxOsKnQd0CT2p2+jw0E521Mrg@mail.gmail.com>
Subject: Re: [PATCH 05/10] spi: rzv2m-csi: Replace unnecessary ternary operators
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 3:04 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The ternary operators used to initialize tx_completed and rx_completed
> are not necessary, replace them with a better implementation.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
