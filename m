Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01B3777331
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjHJImG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjHJIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:41:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA221BFA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:41:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58439daf39fso8253117b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691656913; x=1692261713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wiJG9NbPC7OGaF2OmU2biGegrdBZQOQEgLv/i/dH+c=;
        b=DmFqIVhQcTRoh+jTQqmhYhy16rhHsqRZ+NDqgZW5YAaVzPHOkW/BF5PQxtvRhvwSUB
         boI5gT8A4791Lxkg1+FLqopNuy/lZ/ZvhXsYo69Cnv57di+eFL/9oZ7/La8GdKy2qgRz
         7yAvyAgjeaO4qb7OO+8TaZE6FuAq5BIuQlnKwLFr+O+r/a9bGZg7AOXI7qoc7SAc8xGR
         dSwhr+yBMIdVed1wjeCx3Qby+DYHUnZUzlBZYcyN40wjEuVjnRaZ6stS1Iuc3HCJjru/
         33M8QbnsMn2Msf1TLjd/ounNYE/r7AFiiQMUpu4GKTshxYEMFiSzXwynhN5L85mKOt2s
         BQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656913; x=1692261713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wiJG9NbPC7OGaF2OmU2biGegrdBZQOQEgLv/i/dH+c=;
        b=BcYWCSEaBfkARtX2vgDj3FJKu5xTYkQes6lVFMf3r7Fm45As0wEp8RWZ7xPy3S4bYq
         VPPL4jhIabnPUh8BFgXoaaDFM9lSWniKFC0mfTAfHZxJiqbbuZdg+NxTshIcqvBuhpLL
         ohvyPwrEE9aWbnB82UHftZD3P4SJyJkr3gPDa0chhBJpP6HBImWXoezMJCn8y+3FgdZx
         rV5y3R/CfnEI90hIBQKUzGAFSa3teuVKmSTMRzNcVSnlAz46PnT8DE5q/Vrr9JNzs4OI
         vtZf6Kv64n2pUlwgkHHhwhpTIBXsqUq02QDUYL1v/et9BkZWhQ/aNgrtMUu18I4OHHEb
         baGg==
X-Gm-Message-State: AOJu0YwlURMtIhT0JuQysBA/duAzDN/RD24U3quvqI9L/uF5r7Gbz2Rg
        XH9Ht2uWVn0aacvrrlHQvNptPtCg3FO6vuX8/LakHh3UM4hB9KBr
X-Google-Smtp-Source: AGHT+IGkNARbuoPeiX84NxnZFSTSz1Es36FsyS+0adfGq4IvlUULrfCaP8gR5ZalFxdtCY1JxX1lefF6Tjjr4O1MPSY=
X-Received: by 2002:a81:5292:0:b0:577:257d:bf0e with SMTP id
 g140-20020a815292000000b00577257dbf0emr2000330ywb.22.1691656913198; Thu, 10
 Aug 2023 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230808180733.2081353-1-florian.fainelli@broadcom.com> <20230808180733.2081353-2-florian.fainelli@broadcom.com>
In-Reply-To: <20230808180733.2081353-2-florian.fainelli@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:41:42 +0200
Message-ID: <CACRpkdb7wCgJnCGmMd2AqPEhC5Qz_uVttd2S6suxf9yEPv53yA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] pinctrl: iproc-gpio: Silence probe deferral messages
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 8:07=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:

> We can have gpiochip_add_data() return -EPROBE_DEFER which will make us
> produce the "unable to add GPIO chip" message which is confusing. Use
> dev_err_probe() to silence probe deferral messages.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Patch applied.

Yours,
Linus Walleij
