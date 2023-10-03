Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B9E7B7387
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjJCVvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjJCVvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:51:23 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B79A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:51:19 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59bc956b029so17627407b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696369878; x=1696974678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYSo37MNMNSHe1ppr3BExCLjoNGDWxayjSiu18PcIu8=;
        b=ri27ITsjTSgvn+nIfF0YFxTY+F0Fxw7G4FAcxQgvpz4KU2OQm/I+s8RPdt/za4zzCg
         Qo52DZ4C1srFUPa1v40iR0FRX3R3hJ+m5h38l6V7E3JSB/uQZOgihnt/imbto6Y+Ov0G
         pkz+4H9PCTOQg4rJpfGgeycyewVIysU0BUVCLgeu+jGaUgUm5r0AlfDF0+pNzR9VTcEj
         6uwJjHa4H9c6JMCz0dAd4DkRwrA3BIXcAl202z1TzpkWmLNwYkNbreclqc9sco+xeKaV
         DTyMHX361ef1kEA3yerNtiOU7YVvMh/y+bvBvRKm+4lsp+xCxJjzCtl+9bqvIfPdonof
         gwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369878; x=1696974678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYSo37MNMNSHe1ppr3BExCLjoNGDWxayjSiu18PcIu8=;
        b=Br8hpBS1/fziZ/sRdrobvli3s2vZ0gC9B0IMIb92nVOvjfTsFuzPPv/jRDWUYX8aK9
         1gYLSGF7yppiqZYbiZzeHwStyC7Wq2PoMOqwpfhOGybEMdyYjo6cXRnMUZm4Ojcl+Mq0
         rbWLUnm18ALP61W6CJqS/Pa24CuwKEf13xssyE3I2m/sICMYFwLS88dpoDNF4XkgRW/W
         GV65gPoZ8XSImQERR8TfMF5CgC0KOc1W8kKfsjEi4UViS+wUmRI2jHpiMrCp7Sa3/S92
         RgeqGy5vH2VPYYSxJpugLkymj1OG8XmKw9Em8xJufJyiZnin9+Wb5ntZMDMmw8IZhYol
         l5+A==
X-Gm-Message-State: AOJu0Yw8s7KXQAjy9acmVg7YdtuibTf3S+BJit1Av6imrP29U/lY+Gmp
        NnmMZkCwd/8J1BKec93LlZRkX/l5GUmmR7UiblSfoQ==
X-Google-Smtp-Source: AGHT+IFpAKaZcePQhrSK//gT7QKNjoNg5pwUIjzpRPi/IB8Rlk7anbHUuBthbP5VTQuPBwdWJWqTtFXTIqF0Q54meQM=
X-Received: by 2002:a81:4f85:0:b0:59f:4c75:1314 with SMTP id
 d127-20020a814f85000000b0059f4c751314mr925263ywb.4.1696369878633; Tue, 03 Oct
 2023 14:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Oct 2023 23:51:06 +0200
Message-ID: <CACRpkdY03QUkHcmyfTTfvVFbmNujW3qg5GcNJ-=8zj_zvGqDeg@mail.gmail.com>
Subject: Re: [PATCH 00/36] pinctrl: don't use GPIOLIB global numberspace in helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 4:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have a set of pinctrl helpers for GPIOLIB drivers that take a number
> from the global GPIO numberspace as argument. We are trying to get rid
> of this global numbering. Let's rework these helpers to use the
> recommended gpio_chip + controller-relative offset instead.
>
> This work is split into phases: first let's introduce the new variants
> of the helpers. Next: let's convert all users one-by-one for easier
> review. Finally let's remove the old helpers and rename the new variants
> to take the place of the old ones.

Almost too good attention to process here, I hope you used some
tooling and didn't do all this by hand...

I reviewed it by applying the lot with b4 on a branch off
my devel branch, and

git diff devel..HEAD

which shows what the goal of the patches is and since the
kernel clearly looks better after than before the patches:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Or I can just merge this branch into my devel (for v6.7)
branch, and offer you the same as immutable.
Which is my plan.

Shall I just do it?

Yours,
Linus Walleij
