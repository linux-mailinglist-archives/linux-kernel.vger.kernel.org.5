Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B617EB7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjKNUaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNUaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:30:01 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28339F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:29:58 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5bf5d6eaf60so64199707b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699993797; x=1700598597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Iw6Kyx0GVgux1oiybqWj7rSb9AKtITiomftgoakzH8=;
        b=ah68fmbYciy+owSf6/BZShEy4P1mSTTTQAxSn98wY8VVsmli+lOk06sFgebb+WHUnc
         a4kGwOXfaYdkbVWUIIWXJRtrNeurV7S0h1N4mGupNZ2hG+FYK94bPvzyrVXGL62UmtLJ
         7n0+sLwUHDAn1v/NjN6nxueyPMxuK1i22oBNirycHskG4XEel5Il1yNjnrOXar+d+ZCG
         nGpggFmN7ULQTmmTzxTLjxKA083x+U8972ARqO68IYIV2QIZobBltW1iPvlh1+Tip95Q
         alDD+PkRb33I9BO1v4ZEfH6e0TlVcoBshZZPFZakGLwCqeZdFmvnwrJbcj+gXY/P333F
         B1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993797; x=1700598597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Iw6Kyx0GVgux1oiybqWj7rSb9AKtITiomftgoakzH8=;
        b=A4zdlf85U0p3ovm9yqrqCIT9iBBkeTOkLk/EIHlDCiczYeT4xbQ/pC8arnfx9jXArl
         B3sw7RXIYkRwCUkHDbY5BKIGbwBzqcO+m6TAhI5HrKzfgXPOWt2FIcTITGp+TUpSLmY7
         +qjBnoBsXHoxaAY3vDM124ploMLE87PnxPV4qH+EIDKF+EqSO5SLpsFc3upq2mP59BYJ
         nNxs+QB3LH7p8YQrA8g1zBNMRviYiRzcRenZ7IwFfGn788owQf11bTTLaeFlF4Sx/9v9
         AM3UUGKsuDYIdei0Y6rwsoS3y0DBoQaWNq+6Gp9drf9ZQ2BA2kbLA1bLiv+WPFdZu/jN
         i9mA==
X-Gm-Message-State: AOJu0Yy3T/BUnEzoTYCzfSTwIX1eMylHKcM36E6Z5AtIqlXuWkc96ECf
        RLI9xBjHaLiltQLXiDm/qF+hUfpZDamj2HFOjWgnFw==
X-Google-Smtp-Source: AGHT+IGnAgAwcOZtyNdt38wKmR89NdxYVqBL/NyJdBSb/IUoAh35W7Vxx6weYxpj7OFNH8OHTEcuYhKPPlSw3alHaoA=
X-Received: by 2002:a0d:dd0c:0:b0:59f:72a6:da0e with SMTP id
 g12-20020a0ddd0c000000b0059f72a6da0emr12058473ywe.41.1699993797361; Tue, 14
 Nov 2023 12:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com> <20231019173457.2445119-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231019173457.2445119-4-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 21:29:46 +0100
Message-ID: <CACRpkdb+m1y85SG0N63zRqjZGSoiSO8zNNHCQUr4gpmnD8uX9g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: Make debug messages in
 gpiod_find_by_fwnode() less confusing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 7:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Currently the extended debug messages have added confusion,
> but value when con_id is NULL, which is the case for, e.g.,
> GPIO LEDs.
>
> Improve the messaging by using GPIO function name rather than con_id.
> This requires to split and move the second part after the respective
> calls.
>
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It sounds nice and looks reasonable so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

A dmesg example before/after here would be nice as
well, if possible.

Yours,
Linus Walleij
