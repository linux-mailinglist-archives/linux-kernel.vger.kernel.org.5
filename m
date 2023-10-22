Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813497D2327
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjJVNMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 09:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjJVNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 09:12:04 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64993
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 06:12:02 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49d14708479so1044747e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697980321; x=1698585121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n14inrlLM8vPXRMfuVwUS3U6ZdZSp+CHks2nE3oKINY=;
        b=WmU6GHR9yOh4wTflJsbann/p92US66Vj55mRo+5EGlyHIWh8ADfcDELwgh/2wJG6rk
         eTeYz7do+Rjucy5novLvXbdIhS4DRB1kpCUhqVPqZe34KM3xKrYMZNRE9/xow7H7wpBv
         Q3/xl1QvHU1qehqYiTWrgafMxZVsnlseV66gvpabb+3i4pldoCa8SQIGvvS1nSxoCt3b
         FUo+4K999GwwiWdgPorNEq9C5/Y315EhwSFl0Gtg9lx71edd9UFylcpPz+QKT7wSliqz
         9b6PYK5uMliem1XZTfmlPECc/aMrLoSLYFcZznddJZ3x/XGvJVu9X0CcmXp09OsEPnrJ
         HBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697980321; x=1698585121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n14inrlLM8vPXRMfuVwUS3U6ZdZSp+CHks2nE3oKINY=;
        b=LPR2AQ95hx7Z5yklN2mCAw1P1wiXnh8s/AF88egI7KAivo7egySZ7BAD6/XUGobAKU
         cr4k0HvBUwWNo4iPKeHMOY3/NUC0QLzMPZDATiSfgasjeejK1Ol05w1OcIvSdi2U+WZD
         7mU73f3c7NavtYvCd5dhCobFX1zukhF+f5tID6XBPWNpUXLvYze5oQGISuL43oXdj/XZ
         AvLj4Z0l6zfXxCl0I/9o/PeFv52rDpoG9mr3+7upkSbN5w2LR41ce1A/Ptsh1OhqK1er
         +Q1limg5GrX45IYbGb8mcW+CO1ENhuzVu+OaHig2zW4B401+lSRHeOrDqdBINOvonbkt
         MU6w==
X-Gm-Message-State: AOJu0Yy7KY8i0XeFAlQYJeZSN4MpJieAFJPUQlB2w34pLmmGcEzTmnTs
        Gk6JKk292obJjw9tbGjATlhyerFj1ea+dG0of8ukdg==
X-Google-Smtp-Source: AGHT+IHkyqhGHX/LRYj1VxwZbZRr4om/qdfHJtPuVNpi/cxilynMAIJLtQ2gqgVYJ9WHj4uIBimH3Cmru4TlyTCu0So=
X-Received: by 2002:a05:6122:a03:b0:49a:c339:11b9 with SMTP id
 3-20020a0561220a0300b0049ac33911b9mr6194675vkn.11.1697980321673; Sun, 22 Oct
 2023 06:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231021183925.22831-1-brgl@bgdev.pl> <CAHk-=wiOJO8nfcDeUMwYXPQHLtTnngSDd4ieUWegW1Aru8TbnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiOJO8nfcDeUMwYXPQHLtTnngSDd4ieUWegW1Aru8TbnQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 22 Oct 2023 15:11:50 +0200
Message-ID: <CAMRc=Mc-oz4e4d9pJbvki3kGgMj1DzSS1EDKcycswJKCNAbqOQ@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Sat, Oct 21, 2023 at 10:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 21 Oct 2023 at 11:39, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> >  drivers/gpio/gpio-vf610.c   | 15 ++++++++-------
> >  drivers/gpio/gpiolib-acpi.c |  1 +
> >  2 files changed, 9 insertions(+), 7 deletions(-)
>
> I have no idea how you get that diffstat.
>

I have diff.algorithm =3D patience in my gitconfig. Typically this
results in better diffs but not this time for some reason.

Bart
