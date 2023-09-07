Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5B7976AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbjIGQOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjIGQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:14:01 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA050BE63
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:48:45 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d7f1bc4ece3so1015562276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101346; x=1694706146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZM5LCrIIZq6Cza2RJhNNmn9rDXfdqmiDRo4rHF5ssg=;
        b=ylT9J2cQoBanYyecJKWZIPfaduZzYBREMS4H7ra2qKLNuE2jRAru1/ReJqCRN7h2nj
         4rAOyPGT5MBPJ+tVAs/u3+0ZWgVtY2qXl8FdNj8jbrRX/sOO7vAFxRX+52OwCfZlDKDk
         ZSKaJ+hK0KT7p4b3j7XNTEQkcac3qnaJgXKv12HDdmaI2iLg+z+sWBaczRXIEyer8uyM
         5dpx4FJIMxIiKguqLBD9e8SE2IhtKG6o19tnRyLLbEyf2SVkCpEiIDk3t0EcrTWk8YRl
         DsyNIg2AsqPu4tU/KmlDqxKHLQwtAkGpd4tSZ6r1q1F5P7zNo7pAYWTT4ch1I/ETYrwG
         ctmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101346; x=1694706146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZM5LCrIIZq6Cza2RJhNNmn9rDXfdqmiDRo4rHF5ssg=;
        b=IgG5FialjJTJPqwnipqBdJrIeLouuW5orI0hdsKgnbHgJgtIyaqTgPZ7De5OVc260I
         X8Lb2JL9sET/Agf1hul0O5uasXl/NHhaohEadkVxANCzXGAX6dUC/cog0/jELHwODgfl
         bhNKE4sWfKUhKwO4jKuuCEooUjBnde+0wraup7aJuaAPrPUsJ4IZJ6DoMdNZo2x9K6hs
         zRYg+E1GQ+EvREagsyswUZGjrHZBfZp/m7ilINzcuF0rUXw1PntUG1fDThg6o6IhixmR
         JSIK0QK8N/lLVopwzd7u3y+hQhZVyFle9vOgyYrQiZGmW8zlLLF0PYF2OS65p9IrmDlt
         mpWA==
X-Gm-Message-State: AOJu0YzzrkkKwzhdMh0hSvlNUL8WJ1QZ7aBOWkAVDE/yWeCM497p7O2p
        REv1oOSvKjeDQsQ/vhUUkQb9kRGGoCiqjZp/g0ZYmNwR4FA1NTrkpSQ=
X-Google-Smtp-Source: AGHT+IHhj18itEgT7Zkm6inaHN3nE+QPEGLPicrIzqqx/vXBzW0adJyqRztqORI4Xy/4ylPWC4tCJ9Ht9cCQq18uOlw=
X-Received: by 2002:a25:aae3:0:b0:d1a:955f:304d with SMTP id
 t90-20020a25aae3000000b00d1a955f304dmr18305004ybi.64.1694070633444; Thu, 07
 Sep 2023 00:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-7-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-7-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:10:22 +0200
Message-ID: <CACRpkdadcw=E38o=cNWT4fQ_PK0UPifJZdVjuXTw0cjxPAEaKw@mail.gmail.com>
Subject: Re: [PATCH 06/21] gpiolib: provide gpiod_to_device()
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_desc is opaque so provide a way for users to retrieve the
> underlying GPIO device.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
