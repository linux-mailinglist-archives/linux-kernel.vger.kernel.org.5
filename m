Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6557BFE61
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjJJNsr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjJJNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:48:45 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7DAC;
        Tue, 10 Oct 2023 06:48:43 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a1ec43870cso70087097b3.0;
        Tue, 10 Oct 2023 06:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945722; x=1697550522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4RE3zX1nkr5k1ALXTAQSYqGBtL+qOQGbxBra5+ezTA=;
        b=YnZ7rQ5vCbXtzGoyI+SAXEdLdTIap61X0oaMsnIdsBaIWQQ3gulAbXJt+fHe12c7cB
         OfQxRzW0VfyOFEVn6zUEAUXBJYNmLxwlyGq+Bap7yFVW3rBGOOawm15zTC5uWxVR6lZw
         o6IePEyPDN0WMsJurr6mn3tYtEKGXw0MChpMaHCLWcH0rwuoQRCxmHv8aOI0pwfx2NCi
         JdKO8oELQtIMQnX3EWS6Ye2M8lexNgZ9YgcM37SbLIn75DLlOKQmfOzVCn3wn7zddlir
         A+vo2eZTYRy19VV3G7o8+cUAJKJVWocUfTe0JuFpHNDy0JbMGxTMu5muhw9SIHO7/7Tz
         CO5Q==
X-Gm-Message-State: AOJu0Yxz769j9F78baQj6zouiBML2zK0YXKpyCAuiU7+QhCGim7XPNha
        OSwCwpBNF6u5pIMFr9yqAV7PWjIradpkBQ==
X-Google-Smtp-Source: AGHT+IE4IxpnqT3awjxIJbYukaZ5668yaGzS2c3xjIpV5AnAE9LLsRsgvdyvYue1DeSJQCS+A43Gtg==
X-Received: by 2002:a81:ac20:0:b0:5a7:b900:a373 with SMTP id k32-20020a81ac20000000b005a7b900a373mr2819171ywh.0.1696945722130;
        Tue, 10 Oct 2023 06:48:42 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id w129-20020a817b87000000b00589c103d00asm4425863ywc.79.2023.10.10.06.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 06:48:41 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59f6441215dso69882367b3.2;
        Tue, 10 Oct 2023 06:48:41 -0700 (PDT)
X-Received: by 2002:a25:870e:0:b0:d78:2967:93ea with SMTP id
 a14-20020a25870e000000b00d78296793eamr16105733ybl.1.1696945721710; Tue, 10
 Oct 2023 06:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
 <20231009083856.222030-20-u.kleine-koenig@pengutronix.de> <CAMuHMdX=pESX1PefCXBSHgu8wRMsEiNO02q1-sjsxqysKb1znA@mail.gmail.com>
 <CACRpkdZ0xhgEA733XNOehBL0G5u1P=1FGVTf9tcToLhEj5vQCg@mail.gmail.com>
In-Reply-To: <CACRpkdZ0xhgEA733XNOehBL0G5u1P=1FGVTf9tcToLhEj5vQCg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Oct 2023 15:48:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURHdnFviekOmm1AVFKDWmabr_jUjVvU51b+-iHUgYNOg@mail.gmail.com>
Message-ID: <CAMuHMdURHdnFviekOmm1AVFKDWmabr_jUjVvU51b+-iHUgYNOg@mail.gmail.com>
Subject: Re: [PATCH 19/20] pinctrl: renesas: rzn1: Convert to platform remove
 callback returning void
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
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

Hi Linus,

On Tue, Oct 10, 2023 at 3:45 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Oct 9, 2023 at 11:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Linus: do you plan to take this whole series directly?
> > If yes:
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Otherwise, I can queue it in renesas-pinctrl-for-v6.7 for my
> > second PR for v6.7 this Friday.
>
> You pick it! Andy is already picking the Intel changes, so it
> is better to refer to submaintainers where we have them!

OK.

> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
