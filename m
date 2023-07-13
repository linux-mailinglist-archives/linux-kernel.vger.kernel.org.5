Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6B751EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjGMKS3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 06:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjGMKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:18:25 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB4199E;
        Thu, 13 Jul 2023 03:18:24 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-576a9507a9bso26457087b3.1;
        Thu, 13 Jul 2023 03:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689243503; x=1691835503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7ompwo27wvX6iXxPl/OxJSZvzIlPxinCpjcU02EQOQ=;
        b=HouBKH/6aA4mEWHcCTeSVFfv4mp+9RzQB7SI+tdpMqQP7siFcCCpWoNh6oj2wwJBdY
         NYphx5GLJnVrMBp5yG8bDdG62ZB1yR1Xr5rIfiOxdYD4Hti296xmg869YwWFlwegpO5v
         2ajHkWmBoVBQAoo5ckWqT+A9MUXMNWr2Dz6T4dbhUNN4kO7rf+6ueo3ntg5NtT03XqNn
         Anz4ZF2r/bWtIDBXkxVZYj0gI88LPRmmcpUI6bcOiHAkoNGY9n397c0KUspLCRUdzREJ
         HFT2gXxYW+JxwSiRKxvxbpKcevsaQGK/yxKb6xSy3nx5KeznwbmtezBfer4ubZjpaV74
         IsOA==
X-Gm-Message-State: ABy/qLYywPbCt3rWSgca0hJ7E+0NJybmq04BT5cGUQ1MyNoCm6KAKxk1
        BrzOWhL3d5OiR3uShQBhVE4tyCrW8OL6ZERc
X-Google-Smtp-Source: APBJJlGOwAR8SN2x497ExdswxUjVJHzlKEzSmkKubf16yJnmhKrx9C2A1RlZ5BAAiB5A8WUPurScNw==
X-Received: by 2002:a0d:db48:0:b0:56d:2d82:63de with SMTP id d69-20020a0ddb48000000b0056d2d8263demr4543653ywe.3.1689243503398;
        Thu, 13 Jul 2023 03:18:23 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t7-20020a815f07000000b005773ca61111sm1697656ywb.42.2023.07.13.03.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:18:23 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ca9804dc6e4so746881276.0;
        Thu, 13 Jul 2023 03:18:23 -0700 (PDT)
X-Received: by 2002:a25:c541:0:b0:c75:593f:d4ab with SMTP id
 v62-20020a25c541000000b00c75593fd4abmr5261509ybe.22.1689243503062; Thu, 13
 Jul 2023 03:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230713080807.69999-1-frank.li@vivo.com> <20230713080807.69999-57-frank.li@vivo.com>
In-Reply-To: <20230713080807.69999-57-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jul 2023 12:18:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVz5Ufrj87jLK3hYysqWHSGE_EfFzh0UCBP573dCV7MWA@mail.gmail.com>
Message-ID: <CAMuHMdVz5Ufrj87jLK3hYysqWHSGE_EfFzh0UCBP573dCV7MWA@mail.gmail.com>
Subject: Re: [PATCH 57/58] mmc: renesas_sdhi: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 13, 2023 at 10:32 AM Yangtao Li <frank.li@vivo.com> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
