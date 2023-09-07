Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FC8797C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbjIGTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjIGTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:02:52 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D7892
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:02:48 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c504386370so914555fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694113368; x=1694718168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuYVBuRk1qSk/vysKkYAGZLoaF4hP5KwSrbdU9HLCHc=;
        b=XUnlXd1gN+uyVzruWfserU6uGWm3Y2DuAedOLjXiEwATRQibUQq28nB2YMUwDiFATz
         572OJ1dq2bQ6xFtq5l4lKdoynnKyUQOSiwFR+XtajvbgrggBg0wJDDak5dSjtaZCvEQV
         MaxK7cJGyLe0zVtB1wkEd8weCcMPJ56AqE8XKvy8s1udrSAyfBSen1pn1wIqZogL6lPI
         tQLbeG/nsTwjlIkCbx7yp0RZJ5kUwmKWGrexjNuml6aZHMEVgzN63zc6ZvRF/uGOKNc8
         gkjXWzekznU3JFA0YkWfLb3bxYsNCoZbzMFitIhZVn+16vkQ2MJf+DY+eT/2WnOT/Oro
         aSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113368; x=1694718168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuYVBuRk1qSk/vysKkYAGZLoaF4hP5KwSrbdU9HLCHc=;
        b=p2Lq9ky0W5gLAnrmGDcmUHxOW8NXRdgHbw8Dau7jkk2AfQ05FV/ja2EcWlp8B7n07F
         1g4nXmgOCYosKrvy5kG9urfks5Os3TT5ffNJ+o3SJGQI/jdss8PCKk+2lGzaCVwBAZwg
         Zuz32453ncqlURf6W1VJqMOzSUgaogwLrsvfnI/aSEqm+/lHiZYcZrVmrW7l15L/N4jY
         6y8IYzQtnu5rKTIahJuSrAWIDFOgQ75OGUU21rpoD+6VQNeHm3fjZs8OXllWyKunsTvh
         hHheSiQOzzPy8MYaOw7EZ+QM6VazxdVVSTZwRyV89KY9dUBBfjmSa6X72Cd9mnMdbgr9
         Unew==
X-Gm-Message-State: AOJu0YyaDAOGWBjOzcYk6QdfhPgxesfHO+yDYiFiZ0F3LXg4VWJcs9Og
        DGwhrNZHinjeg8+dEnM76mdEf2uCmFVICGkNPtEZmMJ7xtfex4qm
X-Google-Smtp-Source: AGHT+IFH+TTCwwws89F7SNPi0GGOZFWp/OkGv5hkCV0kl2J1CUqPAY/iOB9bwWhCU9n1g7MoTzaR/hVwP1cetSs2hGI=
X-Received: by 2002:a67:ebd9:0:b0:44e:a3e9:68d1 with SMTP id
 y25-20020a67ebd9000000b0044ea3e968d1mr5642709vso.1.1694071890893; Thu, 07 Sep
 2023 00:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-13-brgl@bgdev.pl>
 <CACRpkdYJhP5otaFXbn49sK_33GJMy85MszyD9rqoQT1-fqd9dA@mail.gmail.com>
In-Reply-To: <CACRpkdYJhP5otaFXbn49sK_33GJMy85MszyD9rqoQT1-fqd9dA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 7 Sep 2023 09:31:19 +0200
Message-ID: <CAMRc=MdXU_EiG4iYhHJd7faRPEQ21hXHhRpPAqTa-TiMiraZpw@mail.gmail.com>
Subject: Re: [PATCH 12/21] hte: allow building modules with COMPILE_TEST enabled
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 9:22=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Allow building all HTE modules with COMPILE_TEST Kconfig option enabled=
.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This should be a separate patch should it not?
> Just send it separately to Dipen so he can merge it.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Dipen,

Can you just pick this up and the other patch addressing a comment in
a HTE driver separately? Would spare a resend to the list and I'd drop
it from the series.

Bart
