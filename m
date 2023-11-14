Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3C7EB0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjKNNcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjKNNcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:32:10 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B23D44
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:32:05 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b4145e887bso3136153b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699968725; x=1700573525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vUZuk20r1+GVjNsC7jKBkz3TTC8HOm2KVh27bZ33Zk=;
        b=UO5mQh5CGMAhgCvyRD0Ap4M0j4qJWCWUExA/SuRLcjRK21bq1cwjtSp5jBE3S6tIMX
         qqjXXzOUa+AFgLqhijn79VlbD1zFHKjqhsI4zn6V9dDNNEX0E/vznBe26lvA2gX9/QNY
         9KMlrYGTpCKEyEOsYtBh3cax9BEM5Q9Ahe6hUHQG0y+fn7Mn40TXhNkl1x9RWg3HgmzV
         kmyCq+QLGDLfvDc1jaazgmQK0MQHe/+QQJ7H/8JG2d210GBvBgBQb6DFYDuPKeyfVPai
         2BtsOpJNn3vm7H1WDgi/kYe41D+pVqGXY/sNL4lG6joOYD131e4l9PyOaI8cxTQd8/gA
         DgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699968725; x=1700573525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vUZuk20r1+GVjNsC7jKBkz3TTC8HOm2KVh27bZ33Zk=;
        b=Ld2aYs6ghf8XebQWMbfqusvQ78al8ypQxfvkzDwI2aYC5KQCgdjJObZD9OwWPAVqsz
         c3mTwnGAVIz+eiaQ1/LvfWaqTQT8D/+QDk/WoZqu5Nabt1PkZzRxeAE8pR4d/ogpApQW
         +8FUqq5CdsmZEZ9HJ6GYmzEYM+Zg73QmD9fQiq7PLO1YiQgRcf1DPeD3BJ/qXo8VcIqY
         NDRoMY2CNEyjuc2R2FxX235l+kxnIeNCyKqZq+KI6DwW99fJ7PqF4u7jNHxLP7UERS1V
         ThshCDV8iZduwyGj421cnGZ+OmXVXP1c2HpwqmlwAhnKJwD8vcZkBHFBo6UbYuAb608r
         wv6Q==
X-Gm-Message-State: AOJu0YzUI6D46b0yZwjHkuPoZOhTOIb6+ydnEdMcgjfOoVt+ASSjcWOZ
        bbFJprdKOZ8G3TjSC30sgXkJKdcwTQVAVWXumd088A==
X-Google-Smtp-Source: AGHT+IHqZdOXQdDV9VPmnwCxEgK4aPNOxm97uGZ843OsMAtoaqKZPV9nM/Tai7R80zUmpCVAX2nvML2llytyNxML3fA=
X-Received: by 2002:a05:6808:21a0:b0:3b2:f192:5a6b with SMTP id
 be32-20020a05680821a000b003b2f1925a6bmr13688708oib.16.1699968724871; Tue, 14
 Nov 2023 05:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20231102101357.977886-1-eblanc@baylibre.com> <202311031233.sJVCIk08-lkp@intel.com>
In-Reply-To: <202311031233.sJVCIk08-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:31:53 +0100
Message-ID: <CACRpkdZuXk5F_C1id3rRpfA=WF=+VtUtRH_BTkQd5P9pQMGFhw@mail.gmail.com>
Subject: Re: [PATCH v8] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
To:     kernel test robot <lkp@intel.com>
Cc:     Esteban Blanc <eblanc@baylibre.com>, oe-kbuild-all@lists.linux.dev,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, u-kumar1@ti.com
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

On Fri, Nov 3, 2023 at 5:44=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:

>    ld: drivers/pinctrl/pinctrl-tps6594.o: in function `pinconf_generic_dt=
_node_to_map_group':
> >> pinctrl-tps6594.c:(.text+0x139): undefined reference to `pinconf_gener=
ic_dt_node_to_map'
>    ld: drivers/pinctrl/pinctrl-tps6594.o:(.rodata+0x14): undefined refere=
nce to `pinconf_generic_dt_free_map'

You Kconfig needs:

depends on OF

Yours,
Linus Walleij
