Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594EA7AAAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjIVHzn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 03:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjIVHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:55:34 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793DD1B1;
        Fri, 22 Sep 2023 00:55:26 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59eb8ec5e20so21711397b3.3;
        Fri, 22 Sep 2023 00:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369326; x=1695974126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+e2g7pqpC0rmwBAVlO3Hxp7LIRMMsLktNC9p8BaoDvU=;
        b=fBfU+sT+aLBli9e0g3Aik1SwMsPmFftqxbSNFJjAfJN7mdlswzioaoSp9SJJI1eLiG
         1wIq1uG8ZY4ScWZxN6MRCGKR39d1NoXN9Y/yTQ5vkVrACNAgXFNSOdrDGlfU6ghMKLKm
         whfoQNl22Qpl5i6B16qdrb6tNI8uwq0hF7jJ6vi55dsUlbepvopb+UNMZvjeb+hs9W/P
         rNfYKJs+6K6CEmJLD5SHbkF97B79DhKEQstDgBGb2sQyjvrwLfkuN3kwFkcXsE7upWpl
         DjAs80cyBkDI+Fr6HsehKLfZTPjgHKrMelMnG3klvh78L60Pr8wLHf0wx0bmpVNFGUUt
         d9JA==
X-Gm-Message-State: AOJu0YwU5DOtjgAQHn0pzD5aCfLbWefyKWcOJjz0iqmAZqGyNMkmYqoK
        byd3xMUgE0nbhzCZ8p6LV9SV7xrBIilzEpMP
X-Google-Smtp-Source: AGHT+IGPSwXNZ7faDA/V9vv70BrI/oEazkCscQ0D0zT2C1CI1z6Fh+angTpjRW655ZdMsXFf0PKVAg==
X-Received: by 2002:a0d:d5d7:0:b0:58e:a9d3:bf98 with SMTP id x206-20020a0dd5d7000000b0058ea9d3bf98mr8490080ywd.27.1695369325857;
        Fri, 22 Sep 2023 00:55:25 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id x2-20020a818702000000b005869ca8da8esm756935ywf.146.2023.09.22.00.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:55:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59c0281d72dso21958937b3.0;
        Fri, 22 Sep 2023 00:55:25 -0700 (PDT)
X-Received: by 2002:a0d:cacf:0:b0:58d:70b4:233a with SMTP id
 m198-20020a0dcacf000000b0058d70b4233amr8405323ywd.37.1695369325518; Fri, 22
 Sep 2023 00:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <19958e63a2b793be5182640c4301ec5a77a507f6.1695369116.git.geert+renesas@glider.be>
In-Reply-To: <19958e63a2b793be5182640c4301ec5a77a507f6.1695369116.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Sep 2023 09:55:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSqMC4BY3Vxws+eBdci-wC2Homh79Q=wzbnneKoSDEtw@mail.gmail.com>
Message-ID: <CAMuHMdUSqMC4BY3Vxws+eBdci-wC2Homh79Q=wzbnneKoSDEtw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Rename rzg2l_gpio_configs[]
To:     Thomas Gleixner <tglx@linutronix.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-renesas-soc@vger.kernel.org,
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

On Fri, Sep 22, 2023 at 9:53 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The rzg2l_gpio_configs array is really related to the RZ/G2L (R9A07G044)
> Soc only.  Hence rename it to r9a07g044_gpio_configs[].
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be queued in renesas-pinctrl for v6.7.

Sorry, wrong recipient list. Please ignore.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
