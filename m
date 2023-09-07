Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3F797C08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbjIGSgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbjIGSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:36:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC695A1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:36:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41368601e92so8016441cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694111792; x=1694716592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QUcdjgXxrS+bTKkF3r2QRe+Cc9aRk/mkNDQCAPj22c=;
        b=IKG9MSh6fdMyKDa7aJOVhO1ntiHj0hMVkc5tX/GjQHIT5bxGq2psBd4X0ctecjhP6p
         M6Zptptl5zCfBzHjY+oWhGwTcflEb5TVXktOfEwQgKTc9jTUy/X8jwHQjWpjDMc+zR2n
         Yl8Gy3D3CrcN1D/K2ZQ07/IW5IPwrig58Eo5fEq3lE8S6QJsZEpDESD85fzHaPQYfPth
         Fj1fywTyx6ZpjFvLTpsyn3TARZ7v36Zk3Ch4WATg+xcqZAzbaTBAP1lmFPjaB5v4nJZv
         BoR6uIQUH6JgzT2w8UzbQfIGJEDS/0c7DSZTvP5TtAgyf7V4BuzPTyqso7ZD+4ek8ypK
         741w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694111792; x=1694716592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QUcdjgXxrS+bTKkF3r2QRe+Cc9aRk/mkNDQCAPj22c=;
        b=ZqRZDRyjH3hmhdKvF2Rcg4auO9d9JWek/kKZMICyR82q6cOy91gWQlUxI9WHASpO1o
         0Dc+xrj63MVTUs5kpy0nvQgSw3JRPA/9Bm3+jLY131PDPr0EA/d/13TRs42OSmGfLJvX
         5rHTVqWcMdSGPm3vidQY4zVZC4FBwq4VUtpsUJWidrnNW+97gwHOiuVT5mpuH/f95lvA
         fsIdDgQ5HYmCF0922RnxFmoxelykcEH8mCYzvipJIC8twJwx56gO8513YCRv8X661gUL
         aBj3zTdBk6HsdUxif+WntiZSiipUk5ooMg6VDK6HT1ve9rpbWjoPWvAwgOcgguQRnZVX
         TUIA==
X-Gm-Message-State: AOJu0YxI/Pew211E8uYTCzi1lvrOwbdqEj6L2SEhLYQt2ogn3+kHc2N7
        B+VRfzlSFddx+vJqmq7z9IcePNRHkc3aqfIA3jkvjgu7//MDd0DBdwI=
X-Google-Smtp-Source: AGHT+IG2TLQ2WqAfuGI+vTl02pQSFPJWDZVOY1MfvYV7hKobdzNo0vRGz8kywS9VyDIIMdmuzYR3qPmWC3h4lMZlj/s=
X-Received: by 2002:a25:dc81:0:b0:d7b:9a5d:37c with SMTP id
 y123-20020a25dc81000000b00d7b9a5d037cmr18599620ybe.49.1694071708542; Thu, 07
 Sep 2023 00:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-15-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-15-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:28:17 +0200
Message-ID: <CACRpkda9=VULj4Cy_sit-UpUQnVEbS-RJKAeULVCw8ZCRTq1sw@mail.gmail.com>
Subject: Re: [RFT PATCH 14/21] hte: tegra194: don't access struct gpio_chip
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Using struct gpio_chip is not safe as it will disappear if the
> underlying driver is unbound for any reason. Switch to using reference
> counted struct gpio_device and its dedicated accessors.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As Andy points out add <linux/cleanup.h>, with that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think this can be merged into the gpio tree after leaving some
slack for the HTE maintainer to look at it, things look so much
better after this.

Yours,
Linus Walleij
