Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99535750E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjGLQX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjGLQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:23:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B331A30E6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:22:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso112200641fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689178931; x=1691770931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=822yCiNqjSfwRkfO3jmPGKsHeLxeECmnUFTSeOcnIiE=;
        b=uhkgSzcr5RvXjx0/U8Vt3bAOoKxhMAr8AYhmq1yYoPTM8iinfH+ZH/c3bLlXFtoZcW
         NqTbKpDnG5/Py82xlsqiXPF1YIUFij0h4n2P0PcaDd9CE8xt4vy78TGH0gYXtt4ul0p5
         8Y92SUTzzsax1fBecr1sBdVEiXRFRw7xJsh+hvy/uioWkiIwNQmU8oggaCwsuVOfhdj9
         RL92I1RaDek/EHTndEd1yvJKb8GefmD6Lwd1VJBqu+LAp47JVXA7j4xoIWcciXRCjZi/
         WRMWs0MtbuQRiU3P8rsJhxkhMqKPHgVt4FfxnYRjO8jC50Uqh0kMvW5lUhL6pKDQSCz/
         EuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178931; x=1691770931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=822yCiNqjSfwRkfO3jmPGKsHeLxeECmnUFTSeOcnIiE=;
        b=fXjdcd6xfZCmAL0+qAsv/ebELLt/T1OG02VQxy9pskQzUD6b1la2yLBCSMrmX+LpXM
         5ZApBN3M1nRlYw/idItqaxRqrMbNWLg3mcfnBFLrzozPBPFHxMIC2w6xK1+pyzCwbwaF
         ACx++ctA6eYuYhWQamTehuXl2dgpXvXGOMk1Ogva0G42eb5+PipbVqI/tdqitveFyOeI
         HKUrdRI7RmNfo2AjL35pHvswgutfgdSjLgrT4Z2r1tsOoWzjph6aEIfNmXT4GrSVn/sG
         FKNC5cGDZuSk1oiU58FJw3vwy0jl8H9yDUyZsezdzF/mUnwOEDopPpSVaPhzrjyMCPvf
         E9wA==
X-Gm-Message-State: ABy/qLa7cYcXdg2MBTUDO6hDaXxBS4J875QqSeaqIodlcwsdFZasw4Zn
        ya6sOHL19HWGiD2C9d3AUQzIYvVocUgT8l4ol0kGiQ==
X-Google-Smtp-Source: APBJJlF+IVZfLNT7bNOLaB03plynXvyRL7AkXl/pQT0RIcyULWZjFlpnngkKQ8Kbmqry19r5Upla8kwXe2tYin3qG7g=
X-Received: by 2002:a2e:8612:0:b0:2b6:a6a6:4a16 with SMTP id
 a18-20020a2e8612000000b002b6a6a64a16mr15894975lji.3.1689178931318; Wed, 12
 Jul 2023 09:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230712100105.105889-1-brgl@bgdev.pl> <ZK7L3P+U/Q9kWnA9@smile.fi.intel.com>
In-Reply-To: <ZK7L3P+U/Q9kWnA9@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 12 Jul 2023 18:21:58 +0200
Message-ID: <CAMRc=MfJk+HM-mksxk9AY_+JfGJL_ng+gcrBx3igX3tcJaHNQg@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: fix a typo in comment
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 5:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 12, 2023 at 12:01:05PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > It was supposed to say 'for' not 'fo'.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Perhaps you can you run codespell and fix all problematic places at once?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

This is the only one reported by codespell. Thanks.

Bart
