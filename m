Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E97B6CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjJCPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjJCPVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:21:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054083;
        Tue,  3 Oct 2023 08:21:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c67060fdfaso720837a34.2;
        Tue, 03 Oct 2023 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696346477; x=1696951277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z9Omi3EfSCh5yQBotfP7z50wuoV8LxiixPm+3LhYpQ=;
        b=W/uABWY7+nWORqtxp2xxh3C9pESQRDAXnESbr9XkTG9k3BVAWuHFom+I1PrAhimvtY
         mqKu1JBNvVP5gL5mJdRFgztku2SJ0DJNtMSnArNeOdJ+KThWZRKUQjp1vwYT5R2lwLCu
         ZxTHb2iG0zHN6geSe4B2Hx9urNjNUVvuh04dDz6Kvp8oHDLz6f+HMqXm08XIk9CU1avL
         CAQiVxYc7QY83rVFIwTrhv5JDQY1TBXimvREC/n1jF0OA+iFIX51+LIoyyn9iO76gj2x
         9SwBokj/p/7z3aAj1WRTq7gyGOUi4bxvizUB1FDkuvHfdDxJGp96dsxpNr2cJOiUSBaM
         kevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346477; x=1696951277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z9Omi3EfSCh5yQBotfP7z50wuoV8LxiixPm+3LhYpQ=;
        b=CWtujNoZaur6xqGH5d6HpYilwtlw2x6teeMya8wMhoSho0TItzy/fb21CXv/mDbpGY
         ZBl5crE1NufgbsF5Wp2Y4mZI2FVQJQRj/cGBJxjjEbKxemzE8y5dANHdUX5KjO2rTTOy
         MmuZ86WT+8far9eYrcLTc5pKL0rYSQD7dt9aGiJXWvPS5AOcvwmODU4vQkY2frbW8Ul+
         UAMigfC0YDISOM7SXbj1LgdpoXzbqe0d/Z+rHRpLkMmTGow7r/YhPkOSdrwsR3MJnEOa
         MSE0FsdociA1FVHu4G+a0kS7/gfhfUyM7OTldw7EuCmcskAhocROvO3tQLXM2p59TQdq
         ew1g==
X-Gm-Message-State: AOJu0YxShHN0valcvhHvWegu88zJah3uxMLLCBKf+iDOZoABtPrsZFh9
        +pHxSaMuutHeyW2dHkgT0RAXOTIN8VBCWsVjN44=
X-Google-Smtp-Source: AGHT+IETV0LxOFOFHvGdReEo1wLRQ8Ox2E/7FPUFivgbHbFlkNM6gGwPKhV0dJeUxwQtnlsDb11uHiHvgJ37tK2KI/c=
X-Received: by 2002:a05:6808:92:b0:3a8:5fd6:f4cf with SMTP id
 s18-20020a056808009200b003a85fd6f4cfmr15159009oic.22.1696346477021; Tue, 03
 Oct 2023 08:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-31-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-31-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:20:40 +0300
Message-ID: <CAHp75VdvUUw77MuuhY3Ts9L0ezOdakyppQcnikpYCu672Ghb9Q@mail.gmail.com>
Subject: Re: [PATCH 30/36] pinctrl: remove old GPIO helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 5:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Old variants of pinctrl GPIO helpers are no longer used. Let's remove
> them as well as convert all static functions in pinctrl/core.c that
> still deal with global GPIO numbers to using the gpio_chip + offset
> pairs.

This patch does three thighs as I see it.

First of all, it silently converts to RAII. Please, do this separately.
Second, it shuffles a lot of code between old and new implementations.
What I prefer to see is what the subject tells: only "-" (minus)
lines.
Third, it will become easier if you name the "new" functions better to
begin with, it will help a lot here.

--=20
With Best Regards,
Andy Shevchenko
