Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B7B7A5EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjISKAS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjISKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:00:07 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F06116;
        Tue, 19 Sep 2023 03:00:01 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d81afd5273eso4588983276.3;
        Tue, 19 Sep 2023 03:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695117600; x=1695722400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zMHG044FTVANVnoQdJ4LD9/VHGzg4/UWZAvEgOkZUc=;
        b=TcSLOZ4lIE/DlZAR1Ek0NtaaN8j1APSvHf0eTWFXRJ2UF7Z3WntA2Y5d2VnRkXYsIQ
         uPpcD8R2DGIg0xppNjZLo56c10yHGjJKVjsJvLl+8d0EhYjl0hT2WIQm2KTkWEJOxbvG
         79xux/ILL+ZO9ykpPDQgVL+RxEjn3CPz8TNlXakYZw1RuHCtOLO6HNF8AfFpZSgt/+kG
         0eRVjupsTCZ9lUrquG4a+bsJuETarwpRVYwt7zSloShBdldspnqvGjeJqJ4JK85WJP0D
         hYC+2v6ywe3WdVovzvNSQryNCjxJsG9DuyoJqzJc4rRdwGJeACu/svyZTJZ2SAdAahex
         jB5A==
X-Gm-Message-State: AOJu0YxfVJ//sAgPkT7KFuy3M/gcJueiRD30YWjdcWSqErc8nyu4CAJU
        uSzuPo3uK6rsa41WSHj/i9D8eqNsv/tlTQ==
X-Google-Smtp-Source: AGHT+IE6hl4CdL3rsaez4L+9O1cpTPN3s9cBTS1snVescMzXx+i0DV0Jw5zdli9jHNesPmuT2Dnycw==
X-Received: by 2002:a05:6902:527:b0:d7e:9eeb:998e with SMTP id y7-20020a056902052700b00d7e9eeb998emr9341280ybs.4.1695117600113;
        Tue, 19 Sep 2023 03:00:00 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id m5-20020a817105000000b0058038e6609csm3108692ywc.74.2023.09.19.02.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 02:59:59 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d81b9f0487eso4364594276.2;
        Tue, 19 Sep 2023 02:59:59 -0700 (PDT)
X-Received: by 2002:a25:dbcb:0:b0:d0a:da40:638e with SMTP id
 g194-20020a25dbcb000000b00d0ada40638emr11358808ybf.12.1695117599736; Tue, 19
 Sep 2023 02:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230816173116.1176-1-wsa+renesas@sang-engineering.com> <20230816173116.1176-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230816173116.1176-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 11:59:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpD-NOrH=X-G8sOp1uG3-XsSghJfyutmO+xdArfCXFAA@mail.gmail.com>
Message-ID: <CAMuHMdWpD-NOrH=X-G8sOp1uG3-XsSghJfyutmO+xdArfCXFAA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gnss: ubx: add support for the reset gpio
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
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

On Sat, Aug 19, 2023 at 10:56 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Tested with a Renesas KingFisher board. Because my GNSS device is hooked
> up via UART and I2C simultaneously, I could verify functionality by
> opening/closing the GNSS device using UART and see if the corresponding
> I2C device was visible on the bus.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since v1:
> * proper reverse order in ubx_set_standby (Thanks, Geert!)
> * simplified the comment when initiall asserting the GPIO (Thanks, Geert!)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
