Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC0800923
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378368AbjLAKy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378366AbjLAKy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:54:56 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B2C19F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:55:02 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4644b935a0aso619397137.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 02:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701428101; x=1702032901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRc7hGweDPEOg5xEFn3wNwDGBn9iwKQTXIiSrreqaqk=;
        b=0H0S8Iv2GLs/hEmyWlkPoW69eFRJARXjBH+M+vOKy1yVUzhP1suY6kIGSBRVIqAzVs
         uxxYN5MgSHj0CgGKXQAa1RPE1dviHs7vG8wDmOQOz0olEUL8FjNlrc5sAKByY8oSoLJz
         oFMb76JAC5o+jJDTQ8LklAzf2eCn2ul6n+MMLVZ84LeCz/xIM3l5/zBUEu6UJKA4BxR1
         2hDGRfuUBPp1InGZ6a9+GFEndGSraJ48XS+mfvmtWAboZCHwK6IfboA+5rA9lZPtYJtR
         jWDM2b+ELreAxINTCsWZdedf2MSePywIOVF8cOC7NEHrYoXKCxJRCAdHESy4R4ogr4WK
         gQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701428101; x=1702032901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRc7hGweDPEOg5xEFn3wNwDGBn9iwKQTXIiSrreqaqk=;
        b=dMmKTk5oA4zHZM/dkTMS8NTMB5WSWkEnA3+Pe58PIsZFjBUV+1p7ttzFQ/x9nfLjS9
         DzIE7IHF6AagizTLgF591S6zyvf0zdpexkSbvRbvFR2Ado11mZyvDknpu68zoVMCjvjg
         +8iizI4esMf+xN9rJff2//mF7ofnoykvkq6mQu1/G6NCxhOIL8CgNopKSiWLg2Kw7IMr
         l5fZJqdqsB1kahp0heNPe4nvl6JI2cIif0lDR+llK/kYX5kLl8QcZCXcflfDsCoz1RfL
         eamzkdma5ahCQOTwGtU52RYnAbSnt9hyL9rhAv+OS0CnKAQEMBevbG0tmms+GCLGCIxY
         /meA==
X-Gm-Message-State: AOJu0YzS7sFvtr9UOa43YuWPBmDly1nyuqitfEtjJllpu+MjBWPcJ369
        5zBmGDW32omD/1dq6BSQ9hJpvaLuhwZr3NeETOLQiA==
X-Google-Smtp-Source: AGHT+IGAlIaVRocI/1rYFwxey38Epksigkho811/nZO5hyApNGNgobsySh/w+WreQNGFp5LlrF+be6aYd1v3OJPVV5A=
X-Received: by 2002:a05:6102:945:b0:45d:b7f4:4639 with SMTP id
 a5-20020a056102094500b0045db7f44639mr22603164vsi.25.1701428101626; Fri, 01
 Dec 2023 02:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20231130134630.18198-1-brgl@bgdev.pl> <20231130134630.18198-2-brgl@bgdev.pl>
 <ZWi34tkzNsvkCQqi@smile.fi.intel.com>
In-Reply-To: <ZWi34tkzNsvkCQqi@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Dec 2023 11:54:50 +0100
Message-ID: <CAMRc=McfMpir_i=0vRoveozQDBp-4W8c9ufbhD55jLoTKdGEZQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] gpiolib: provide gpiochip_dup_line_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 02:46:21PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiochip_is_requested() not only has a misleading name but it returns
> > a pointer to a string that is freed when the descriptor is released.
> >
> > Provide a new helper meant to replace it, which returns a copy of the
> > label string instead.
>
> ...
>
> > + * Must not be called from atomic context.
>
> Put the respective lockdep annotation.
>

What are you referring to?

Bart

> ...
>
> > +     char *cpy;
>
> So, why not naming it fully, i.e. "copy"?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
