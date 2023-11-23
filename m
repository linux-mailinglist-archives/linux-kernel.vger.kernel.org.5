Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E07F6213
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjKWOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbjKWOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:53:08 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65819D71
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:53:14 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5cc5adfa464so9124477b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700751193; x=1701355993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceo2cl5GUrT1DdR/i+vAheLeBxDK4vsJ52Urs/B2oaA=;
        b=lCFmi2JyAzfLQJrsTQ8r0bqzFjkaKXiYSL94PXjgaeAUjlvXjBmJW0qRW0MFopG4K7
         s1AG5yhwx5uIeqKJcFu2PfbiPcibo2fhwYDf53Mlgj+x9VJecNqwc9RUs47wI7Umf6o0
         LZvaqSWztEoXUopoJRQfXOyPlupVSKEKoLTidd3LIyJ9LmbP36aLT7J2BQs11sRrEimD
         xkn5DAm7orzI4wS/+lF/PA/j25DAOIBC1jQSZqIEaeKphKgjXjNA08217sVlhwInawam
         k1CzaHNs4Xvq61+c9Ckdb7M1KlFPvPy7aZuIQNRLOlwQgyFlfcYCFOL11rd2tOTfEm88
         eHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751193; x=1701355993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceo2cl5GUrT1DdR/i+vAheLeBxDK4vsJ52Urs/B2oaA=;
        b=a8oKqhe1VhsyYyf2KHtTymOJdGirxOKKTFKsJcCOqNcREq0dSu7tsQNRtptgcIBXEP
         2Ht7qYo7sRsIRw4YDSj45LhRoxXwL6LkH48hc1sGm2tzrA5i9pnvihDX1QMzWMtKorwL
         hi0UYSMKIOHE8TIwjwTSyjgZuAEGPqu5WFS6+YdeYuayZxA8rF4bm9ThSYkPlifOhrKM
         +VY4SzGR5LRNjGhFis32QmzPkRd1xPfIONCrCmjcunv+G6Y8/QfYwNZmHTfAAJnEqpyh
         l0LPHSLECQ7IrhMM3so9aVy8+4g6Ljye726P8yatdtTKavRffD0DraQ7s/XLClMgMY1q
         sn4w==
X-Gm-Message-State: AOJu0YwByN0YJDsi6DyR6sCQUYRDwhdEzD29bn9wnHQYShpzccYp1Lgo
        BtI7AiFYug72sgflqZXo7M7o/wNe80e5HSdwRuytyHha22JjCBZA
X-Google-Smtp-Source: AGHT+IHlbt3Gav3a2shSJGciFVu/l8CjG3rfcS70wZGTyD89Is9hFwjeBwrxIZTVX0BvtJZ/yiGQM1++SucNYx/w5BQ=
X-Received: by 2002:a0d:d657:0:b0:5cb:249b:4482 with SMTP id
 y84-20020a0dd657000000b005cb249b4482mr5697795ywd.17.1700751193464; Thu, 23
 Nov 2023 06:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20231122175444.2316719-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231122175444.2316719-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 15:53:01 +0100
Message-ID: <CACRpkdbXCYB3NCqOdWC9x2HTEAVb2=PNGEUADqSC5N+1iYLfWw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: lynxpoint: Simplify code with cleanup helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 6:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is really nice.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
