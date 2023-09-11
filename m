Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA38079ADFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjIKVFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbjIKM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:58:01 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501CE40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:57:57 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49352207f33so1622130e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694437076; x=1695041876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq9dNzonQexMD+yn7Vskd2yTLNtgiIlfzqxh9CCDUGw=;
        b=aL57E0SnUWkVDL7Bt9U+7Y1EGFvdSU/WRlJy1/k1FKKBr+cOZObHpR6qoq/jHezlMh
         AQnBXON+H3vOAz46a9gcrPKyWDlBgMMppyWVvqBNNih09rlH1NeA0fiSuKe1vEfR1EGz
         xrmL/FVVVgMSR6CwHkBWob95LipH7AMNo4yHcMq90HLUnvpnsFGNmSK0P8da7u/5Fjgf
         75zIA1/HtRVu7AJRrYJOkoeHWmQ0zkfuzcp58iK5b/iCffOGM9vrwmuLDSUgh51OnvYW
         sVVFHAzAlcmEr+w0uRCFYxYHs5Sw4+yBTnHf7bTJ7BI6a6HQ28lhctWQk/EjVg5IbSa/
         +tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437076; x=1695041876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq9dNzonQexMD+yn7Vskd2yTLNtgiIlfzqxh9CCDUGw=;
        b=VIhzqpN/8l/5YMaTH3UsbBm3V3wdMON880/4Sx4vi9U1A3PIpGHAz9rA5asW0ybp3t
         AJjU+YiD5zXQBTqDDAhaprVXYoNn3jUsqtOs3t8kErG+8hPVVOUyULXdPhSnUDk3q6QB
         03ml466ktX0pjv6NeSD8lcyyQHp6G6LitwsNicQ76brz/wrBQIIvRYaLsKEOg/sy/wkZ
         BBqNveOrWepJ8oSDwGTBty+3cFMwxlniDOzHYzw8CGZZ1uN7+bOAhF4PY39EU7rl0fFx
         YA5Ndr7PnBo71OHX1JB/q6bSHRvR297Q7GalbKzgLBHRTKptuRdAG9nXA8/9+Y2boaVw
         d+JQ==
X-Gm-Message-State: AOJu0YyVZSFoHPEMLkTth5q8zIaoQSNM2U6cTansQ6WzOcyGm9eK4r8g
        qrT6xuXtmbPXtClnB2IFZ4i4V0pWDqNrRARIuQEyEQ==
X-Google-Smtp-Source: AGHT+IGWgZr0hmnQ+lqns9cOMLK/t4LepUDDeinpP84jhoMV1MO4JspKksqmLZv2c8U0A63jcNgZJszsa0rXZlnwn2o=
X-Received: by 2002:a1f:fc4c:0:b0:48c:fc50:4292 with SMTP id
 a73-20020a1ffc4c000000b0048cfc504292mr7139587vki.15.1694437076283; Mon, 11
 Sep 2023 05:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230911110740.16284-1-brgl@bgdev.pl> <ZP8N4M6cqyP9rS3W@smile.fi.intel.com>
 <CAMRc=Mf8zhmMaMSoO_cceG9meCHr1AbZMMRJE7Qms8qEt047Cg@mail.gmail.com>
In-Reply-To: <CAMRc=Mf8zhmMaMSoO_cceG9meCHr1AbZMMRJE7Qms8qEt047Cg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 14:57:45 +0200
Message-ID: <CAMRc=Md++13y-h1xUADUkqshWFau0vqSvZoL2w27Rw1CM1MNUw@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: sim: don't fiddle with GPIOLIB private members
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 2:56=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Mon, Sep 11, 2023 at 2:54=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Sep 11, 2023 at 01:07:40PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We access internals of struct gpio_device and struct gpio_desc becaus=
e
> > > it's easier but it can actually be avoided and we're working towards =
a
> > > better encapsulation of GPIO data structures across the kernel so let=
's
> > > start at home.
> > >
> > > Instead of checking gpio_desc flags, let's just track the requests of
> > > GPIOs in the driver. We also already store the information about
> > > direction of simulated lines.
> > >
> > > For kobjects needed by sysfs callbacks: we can iterate over the child=
ren
> > > devices of the top-level platform device and compare their fwnodes
> > > against the one passed to the init function from probe.
> > >
> > > While at it: fix one line break and remove the untrue part about
> > > configfs callbacks using dev_get_drvdata() from a comment.
> >
> > (Just wondering if you used --patience)
> >
>
> I may have forgotten this one time. I need to add an alias.
>

Ah, I can do "git config --global diff.algorithm patience". Will use
it from now.

Bart

> Bart
>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
