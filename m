Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1B7EB7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjKNU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:27:04 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E520101
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:26:59 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a8ee23f043so69326557b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699993618; x=1700598418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyPk7mTIFyi1Mq925aGtOcHWpJE/D4tGT9IM+H+4QvI=;
        b=uJ2OT6ciz6X/ApxgTMO76zMj+GuMIfsRtiGwZ5Ibk3KF3C0tKgXY7pzJ6R20zc7aB+
         x/7IPkpa7+//A7ODvD2ZPSXsHZcbtm/gE8IEIl3MdlvDXxbvAghzQmJItS7spY8X9mvp
         pTV7HSHs90cHmzdgYChQNqnIqhSRD8JqMocfP/Ldtpi1YV29uk+sSh+X9n+P4WcT6kfI
         CBrKZHWVI5mv2PAlGp/xHTbo4bcASaJgMVkvRE1JWHOR0bva03oijfRb8Sr6ChYMVIE0
         yX7LC2zLOPz60uqDLOsW+kImrgrk3gCSjIOrGwNpgTuo3ov0v9dNNWvtSkgNnIaTFYaT
         SvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993618; x=1700598418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyPk7mTIFyi1Mq925aGtOcHWpJE/D4tGT9IM+H+4QvI=;
        b=WYdjJWbP5qB2yj8+e69I/yySms8Q4uzNSWBs1GNEkixhoSNeKtcvEd9C8Lg4bxn4w3
         H+upFMn5ErpHrq9et28dCKGYoBhQW5BdgTEHObHMyw/Uz9Li0cfJXEEE7kjz4okQA1CA
         kH6B+BZw8t2VHZpaLlFsoEQHf31qo5aLN7hHkPg7CMk8Q8EbQAL99lgGIIBcl7dHZfdx
         xgVJBeUD699OXxkBwgomfPrW/ly35AmJVeZYBg0Oh4eQgHAmm08nlQ1m5feLVHEdrix2
         pZ1tPjMef8zku5QGQ7i5sCdQjRTky9lcxryNjK9HCoqfpkc03Ft5QFBQxvShR8ov/5jr
         sCng==
X-Gm-Message-State: AOJu0Ywcn4qFJqIxiPtfO8Ene/BbNBWTQSol1NEKT1iTVk8U1D2Qvqqo
        TlOcyBRUx1dTPfXyPFcvlGt7aixXwHiTbxZ6p3fWcg==
X-Google-Smtp-Source: AGHT+IGDUNGrEe7ZqE1i4ZUafpug/38LIAsEh0uh+kGvuV6geQFAaf2I4fmavw+uhHRw1Ik7dYOSYdmK8vql4edD5mA=
X-Received: by 2002:a81:b289:0:b0:5a8:6286:bee with SMTP id
 q131-20020a81b289000000b005a862860beemr11437100ywh.4.1699993618748; Tue, 14
 Nov 2023 12:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com> <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 21:26:47 +0100
Message-ID: <CACRpkdYXqQg2Ph5R7dphQPXe03onCid-4=+V2Z-9h+F-8ak9nA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in gpiod_find_and_request()
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 7:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been broken and hence lost a bit of sense. Restore debug
> messaging in gpiod_find_and_request() when configuring the GPIO
> line via gpiod_configure_flags().
>
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Please copy the example dmesg outputs you sent in reply to
Dmitry and with that:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
