Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38DB7BD73C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjJIJjR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345928AbjJIJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:39:16 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4CF8E;
        Mon,  9 Oct 2023 02:39:14 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso4446662276.0;
        Mon, 09 Oct 2023 02:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844354; x=1697449154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3YmCgHn7tXgi9jtCY7MITJAzGPAZOtwu79OddVQcyc=;
        b=QSGUTKoAa/Yf3qZ1vevaCmfLQ9lK0VhQy/uUlqUCQxfS9/HjZcDyt6+tw52pmH/4Pr
         BkRho7Ody4tklARULl6gdK2cEAuD6hBOC+SLFlt1WT7joRsf+zFgRqzLohSrxQgUTWGd
         RgvtVHPsVlkqFd0lfugQapHXl6T2/uAd4Pb/TD1RBIAgXNugb2oV0YPCGC4Cz0AVDDwX
         3mgidFgcJ/m5OdDLLOdMJcVPbweojWp10RAJJIjT1Htdv+OjV47Ym3kmspF5FSVyz0OE
         YpLnuCwHgKfc/dHW/3sV1we5lCPlquvIaMIVgMGDK3FB5hS4hi9zT68vbUzHUHHslK28
         Zt0g==
X-Gm-Message-State: AOJu0Yxkd6mrzLHlJ66maCP7nqW2dENY16kRi/O+KlM74Bm6UTHbYLhI
        5T2f5ChS9cKhEDr8EnZXYntoKd6GsF9sdg==
X-Google-Smtp-Source: AGHT+IEO0++uBuATq1+H19O2iHom11TrpvJdyyVHj7vHfTccJKQU6QF6waSlQScMnAFw4Ex5htyeSw==
X-Received: by 2002:a25:684a:0:b0:d19:40c2:eb03 with SMTP id d71-20020a25684a000000b00d1940c2eb03mr14191237ybc.54.1696844353805;
        Mon, 09 Oct 2023 02:39:13 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id v138-20020a25c590000000b00d911680fd10sm3010680ybe.50.2023.10.09.02.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:39:13 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7a77e736dso1001577b3.1;
        Mon, 09 Oct 2023 02:39:13 -0700 (PDT)
X-Received: by 2002:a81:4314:0:b0:5a7:aa54:42b1 with SMTP id
 q20-20020a814314000000b005a7aa5442b1mr85835ywa.28.1696844353244; Mon, 09 Oct
 2023 02:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-20-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-20-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 11:39:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=pESX1PefCXBSHgu8wRMsEiNO02q1-sjsxqysKb1znA@mail.gmail.com>
Message-ID: <CAMuHMdX=pESX1PefCXBSHgu8wRMsEiNO02q1-sjsxqysKb1znA@mail.gmail.com>
Subject: Re: [PATCH 19/20] pinctrl: renesas: rzn1: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:22 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Linus: do you plan to take this whole series directly?
If yes:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Otherwise, I can queue it in renesas-pinctrl-for-v6.7 for my
second PR for v6.7 this Friday.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
