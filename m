Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68693756250
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjGQMEe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 08:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:04:32 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64062198A;
        Mon, 17 Jul 2023 05:03:57 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6b9af1826b6so3346984a34.1;
        Mon, 17 Jul 2023 05:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689595436; x=1692187436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADuWT1rcNNrO/uWcPjDAzbRerG5eAzFS7vB4EKljZX8=;
        b=G00Fu0JQ31YVu3rV0yiDipBy7PPC/LznMWQ5Fxarof8iC0FgnNFp6JrMUsclPQ1VMc
         uznD26GUrbIUkVOMWJ+wqpE1CHlY68uTO9+9Q3MfrBB3ovDUoslBklDYvLxgRNJPNH1w
         ecBvSmsHZzIYIPmWzpltMRYc9cn/8DUqaPfDhUH/ZDnNzPxHEq7Nnz3y+OvQsyxMmABQ
         9G/+6h7EbKJKQSfJyK2fphUnjGzdD6gK1rZ8LunI3EURRsj4HocVLqiGHgoLeOLzM3lO
         SArAWveU55Povmviqx5OwSWaEyVBRrxv+LvyoKaCj2KXGEzhX4xXpXvoWrLBnfq/LrZz
         5uMg==
X-Gm-Message-State: ABy/qLZ98MXbXqnKBGJ25jHLa19EP28EG7QjV4YrnFiRVbp3qKx1bim3
        yttIcU1DGHjSgBnlwVtfgR3E6E/frv+P/A==
X-Google-Smtp-Source: APBJJlGmLBAl1FsWz3txuIB3srVki43B9ZR5odw+WlYahEAragq7HLcdLO0pUO1k8Z4kWpkysGZm+Q==
X-Received: by 2002:a9d:4d85:0:b0:6b9:b67e:ea8a with SMTP id u5-20020a9d4d85000000b006b9b67eea8amr10050362otk.14.1689595436387;
        Mon, 17 Jul 2023 05:03:56 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id r8-20020a25d508000000b00bc68b767cf9sm2850031ybe.41.2023.07.17.05.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 05:03:55 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so4643535276.3;
        Mon, 17 Jul 2023 05:03:55 -0700 (PDT)
X-Received: by 2002:a25:d816:0:b0:cb0:3ce5:2bbb with SMTP id
 p22-20020a25d816000000b00cb03ce52bbbmr11477119ybg.34.1689595435729; Mon, 17
 Jul 2023 05:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230711142132.751672-1-ulf.hansson@linaro.org>
In-Reply-To: <20230711142132.751672-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 14:03:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRAFRBSS4T1VvdDkWCD3dPF3A3BKkUh+3NNPBX83pdmg@mail.gmail.com>
Message-ID: <CAMuHMdVRAFRBSS4T1VvdDkWCD3dPF3A3BKkUh+3NNPBX83pdmg@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] soc: renesas: Move power-domain drivers to the
 genpd dir
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 4:21 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To simplify with maintenance let's move the renesas power-domain drivers to
> the new genpd directory. Going forward, patches are intended to be managed
> through a separate git tree, according to MAINTAINERS.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: <linux-renesas-soc@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
