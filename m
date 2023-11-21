Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F97F29CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjKUKJd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 05:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjKUKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:09:31 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FAFC1;
        Tue, 21 Nov 2023 02:09:28 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5cb4b4889e5so10541687b3.2;
        Tue, 21 Nov 2023 02:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700561367; x=1701166167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNaxkZBaWmccZAzqMSFguEo4K2kougAUJZmthS0K7dI=;
        b=UM2CJzSucme0Ekw5B6QGHLHIufP6zNx9dXreBHpZUvwgTiEMWXob3M7CPKU+IR2H94
         mRDsRumf4Iapyid5D2kjptwW7vtuuc6HE4ePLEoVOJVI2F7d4cBwT06u9dUsg0ktsoUr
         rvmi/xMr6nh0fla0w/cilbZXQDpyMAzaqSTctYHe9hBQakWlmQQqDB1otrmB1D2OK5pc
         2hl7C30fd9o4bn1K2cJA9T0JvooVh78hyRC2JY1IcSSXwJi45eRZz++Z/7yjL0h+JX1Y
         7Cfel8rZ8+9DDjQMZvN2tPHLW+tSb6+dRCcT9Ht27OrFW0LHZ8hKTAl6oktug4/Tu6Gf
         sKJw==
X-Gm-Message-State: AOJu0YxoJB5xlzkSwVYgdgvKa5EYN3b6Vx3f8tzNxIli4/m5Um9BxLFa
        4sYkurrAPCMUBEpv3jjfOy9a+I+gbJ98IRsH
X-Google-Smtp-Source: AGHT+IGnAGQqfO2RA1OaiWDNI2nh6iHKWbBvsGmYZMy7XGfaygkUe9AdbhT26FGEZZmaOmKTvxoq/Q==
X-Received: by 2002:a05:690c:b0e:b0:5ca:700e:5bb4 with SMTP id cj14-20020a05690c0b0e00b005ca700e5bb4mr5959550ywb.7.1700561367263;
        Tue, 21 Nov 2023 02:09:27 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id i8-20020a81c748000000b005ca99793930sm1069195ywl.20.2023.11.21.02.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 02:09:25 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5cb4b4889e5so10541117b3.2;
        Tue, 21 Nov 2023 02:09:24 -0800 (PST)
X-Received: by 2002:a0d:dc43:0:b0:59b:ec85:54ee with SMTP id
 f64-20020a0ddc43000000b0059bec8554eemr12036988ywe.39.1700561364361; Tue, 21
 Nov 2023 02:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com> <20231120111820.87398-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120111820.87398-4-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Nov 2023 11:09:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULDGDW-yfokn+3HKk-G8mr2NgUNKJEN_73ne=7MAbEEA@mail.gmail.com>
Message-ID: <CAMuHMdULDGDW-yfokn+3HKk-G8mr2NgUNKJEN_73ne=7MAbEEA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] irqchip/renesas-rzg2l: Align struct member names
 to tabs
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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

On Mon, Nov 20, 2023 at 1:00 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Align struct member names to tabs to follow the requirements from
> maintainer-tip file. 3 tabs were used at the moment as the next commits
> will add a new member which requires 3 tabs for a better view.
>
> Link: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
