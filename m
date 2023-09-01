Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01E478FD3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349445AbjIAM3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbjIAM3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:29:42 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ADA10EC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:29:31 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44e8fc5dc63so835657137.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693571370; x=1694176170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIF+BJX70BXX/vgywLDEAMh001J81bkBPvdNjVPAH9k=;
        b=NGvGzfexigUfoAMMYJOXotyL7WzGlXZx7G4+pDFCpaa0FudLt7ixYHORpG0snitJiJ
         Q5KeLehF5HJW1PvG+urF1YSBgnzdifmw6c7ZKIaYv/nYIUtk/lgEhyK9MnRR9z89oDA+
         1pQsbN+/9ZJchjUzHsbY/SagiYKe2o7do8fckDxhoHxtrBHq0zu4zzIiUlRCxhmTn+lq
         e6XKai4RVkFJoZKWX7O5AIqgCiVVLihIQoq9s/3AC8aQZFaKJhQNF9BNMHnBbCWKfHDK
         tI/eS7KADN7rdx/Tf5YLwb5VVDMqwIUQV07upCxGizsjRM6CwFHmt8bf+ofN3YPlyplT
         uuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571370; x=1694176170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIF+BJX70BXX/vgywLDEAMh001J81bkBPvdNjVPAH9k=;
        b=I3e3ylPRsJm7TubkljtJNqleS3kmBjDPhrlJtjMIjloGjy9TlxwfJDagOuzHxFq5dR
         You3EfFY4xA36RYggNcBZsOr+pT8UNW2ubre/+w9u8K4jrEvToDLzDCF9szjxf5kNGr2
         L6jtnc1QEE6gY61AESNiP3tW/P6akafgNYi521S7L9i3KfH9aVLO3qD4se4qpAyS3BVU
         BSLDH4bwNJKcHbr5mPhGgmfDi8g1xeD43xJ5w3SeLHiAYmXboBEu2MGMYvKmZTGtZcwd
         yDQlC3uenkq230LpynHqGpRyNvI/4ngHh1sVJY5X4upcSGyu9mdBdRsueCos0sssWxTK
         TKDA==
X-Gm-Message-State: AOJu0Yz7iuMezgd4vUq0GRNDzzsB926EpKaFvZmJESJ6H/fq2Oi2oMs7
        dc3PJznDHe0yS/kwvpNedWFukmeD1vyeuUN6L1jlXA==
X-Google-Smtp-Source: AGHT+IEg9KYnIv9qRIHKnZB8G66H9r5yMxmoO+7Ha9bqKao7Y134298c3nNCpQPma3FFeZH7YsBr6mREcxJ8zl8Lfmg=
X-Received: by 2002:a67:e98f:0:b0:44e:8ef9:3370 with SMTP id
 b15-20020a67e98f000000b0044e8ef93370mr2069516vso.5.1693571370491; Fri, 01 Sep
 2023 05:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230901113520.13352-1-brgl@bgdev.pl> <ZPHVZQ3NmqWE1cYg@smile.fi.intel.com>
In-Reply-To: <ZPHVZQ3NmqWE1cYg@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Sep 2023 14:29:19 +0200
Message-ID: <CAMRc=Mfinj1rCoOR5_VkEyp9X+=NryyyQtGg3=H5mq_vPz4ZHA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: remove stray newline in gpio/driver.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 2:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 01, 2023 at 01:35:20PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Fix a double newline in the GPIO provider header.
>
> Separate patch for this?!
> I would just fold it in the extern removal and that's it.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

It's nowhere near the code I modified in the other one.

Just slap a reviewed-by on it and let's move on, more important
patches are coming up. :)

Bart
