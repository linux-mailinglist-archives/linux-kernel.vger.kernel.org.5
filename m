Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09679D3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjILOeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbjILOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:34:07 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7BDCCC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:34:00 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd04558784so3760630a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694529239; x=1695134039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dKFEIXTO/fYJxz8BlxWUzzaN2EMr24kOQHXhchbq7s=;
        b=flSFfbv4v1p+DGZo2JYB+vDZiCSYIPETukF1ejQN6tqcIJusd3M0yGbQgXzpuksK/K
         +XI9R87IVpYII49ckMMciUZcWJtN+QIs/xe+wewlPXwP5hHiP8oAfB02S1zeb+ADlt+K
         Q1M/ahwWEIYWtfQNqgLrOHZ1aEdzyEN7UUaf7CsL9QmGIW8brBW00OCjOamucZN6qaxJ
         jR2PoKfEfmsp7KRzCr5c7ZfHh6KA84B4tRS/4NZ4Ai7rGTjM05DT5OzEm6csvmxR1gt/
         laHiCgMRKrOen+Zi0YihouBK9EbxtPX5rfToh9KyPBi0upIl5ZZjpSNy1/8tPiInUrlx
         ErgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529239; x=1695134039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dKFEIXTO/fYJxz8BlxWUzzaN2EMr24kOQHXhchbq7s=;
        b=PQEapaigJvQBy/3jR6CNg+7T6RsecJZJ+04DJmZ7/TaV2v2JJBug6LveB/auq9L46l
         2DtnelK9IaUBUE+UrMlMZ8IbZxvVhAhypjREUn1tW4VPTeX90akcvTkbdXVE6EG9IoIf
         WqSAJ60RX5Ma4XctNanFPVet6YpulV17tst1YAg0QDlKy1YkRB1PjZKadEj8iQmzwaP9
         4I3oEy6BDuzEaEnyi2obXd0fTxu1Uph0OphCsO10FFZiiAevYtlcm5F/uG0TPqsMIg7L
         NA+CVJ44NBSb60ZIcvqHcPNJyjCz0BbsK5/jkXovVjcAH0v+PVByKFCLFVEnIzr/FoXd
         C1TQ==
X-Gm-Message-State: AOJu0YwqcvgkwarjKSa+UZiwvktXuXNNZUW3MmfMprYli7teRzjyG0e4
        TclwaizdWtuN56hupzAUWNyE1RaQwpTvULTTxzo+4KXmRsLJbaXk
X-Google-Smtp-Source: AGHT+IF7v/EH9izxfCgVuOXL5ieHjf7eZgT8Tg5KUGthUuk6ErdYwCvLnnkT7oet8ChaD58qvb4D/C9pdVwjqY8Oiiw=
X-Received: by 2002:aca:2b15:0:b0:3a7:449c:8aae with SMTP id
 i21-20020aca2b15000000b003a7449c8aaemr15086835oik.26.1694529239541; Tue, 12
 Sep 2023 07:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230912085541.13682-1-brgl@bgdev.pl> <ZQBpSCx9D6ktkoIk@yury-ThinkPad>
In-Reply-To: <ZQBpSCx9D6ktkoIk@yury-ThinkPad>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 16:33:48 +0200
Message-ID: <CAMRc=MeZf5hXLNhO9STVN1co_z1zFgC8c-2+5Q=2nwALL-Nuuw@mail.gmail.com>
Subject: Re: [PATCH 0/4] genirq/irq_sim: misc updates
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 3:36=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Tue, Sep 12, 2023 at 10:55:37AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here are a couple of updates to the interrupt simulator. Two are minor:
> > remove an unused field and reorder includes for readability. The third
> > one simplifies the error paths by using new cleanup macros. To that end
> > we also add a cleanup definition for dynamic bitmaps.
>
> This looks like a v2 for https://lore.kernel.org/lkml/20230812194457.6432=
-1-brgl@bgdev.pl/
> Is it right? If so, can you keep history of submissions in the cover
> email please?

That series was mainly about fixing a resource leak. While it
contained a part of the changes that ended up here, I consider this
one a stand-alone enough to not make it a v2. Probably should have
mentioned that one though.

Bart
