Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FF812BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443465AbjLNJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjLNJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:40:33 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED23B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:40:38 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7c5cb5eeab1so2625977241.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702546837; x=1703151637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdaVZVYnYeQOiEs5xQZ/aME71d5T9TRS2cRXJbz9OzI=;
        b=Z04AwDsXS2DLvcErL/s5f0v5AKqhNeA20bUlFX+DuUlIZ4WVLnfKWa+q/8Kz8NG2cn
         pHGlQkLmw+1iE8sEBEfUZJjxM/0jZ4Y7LPHGP7qFMJzC44ixqEXkEEbNBPupr5nVeK8U
         ltU1ykW5HKKuJcob+PNJn0Ax889LGILAeSb7BnBrU5hEtFE+CjTjeWxMzKr6Iehj/t/Y
         sK/p5TJaDa9WwbyXWvVD4wz78qYXo3LFOnCxVadJ8PY4KiToHBkpsipOwJ15tgArL454
         LFphXP12ZlGoAvu3bZYWroCYJg+GjqrypWfxBKAww1bKzwWi9Lg8g6nUcKrMBlM5/22S
         wBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546837; x=1703151637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdaVZVYnYeQOiEs5xQZ/aME71d5T9TRS2cRXJbz9OzI=;
        b=EM1PCEQOZWcwTaFrzHDc7qgT2e75TZFy6scfDaT2easYlWpS3ppn9YPqmGCbDgcQmw
         fdtyQC/hUdtR7BcGp/9F55RFOkyq080V49I8IgmzP6L47gZB8oOxE4CHZVn4+6YEA9Km
         GHI4i0/Am0dei4ngFpYPpQuF3hAmGO5gqEquIP2nJx29RITrBc/tYOYQzkSoxfYpG0uO
         lgMkc7W8vivAdOwtlJgHbdRR5NtXpSJBPrwjWMWNMps0Z298mTT486REo0oNwf5NVfTc
         +bb6Jp/AVeMv1ZTWIJvCxaiy6X5fy517rEn21e5ChVC89v+tbWoWIEqBP9mi2ArUId1t
         LIWQ==
X-Gm-Message-State: AOJu0Yxb7kaSaEGiz6ccWPqN16KBUwSL9fSWmWisGdOljlJSgnDrRX5W
        Eq4Lv704BRRlLDCuRPwXjr8OuMJprtxRQNCt5AmFoQ==
X-Google-Smtp-Source: AGHT+IGZq5rJhUCqBnslm+4oKVQDWly4syWw/KzYFHCO/NyKaF+WrXN5yqJAb7UuR4cmKFlK1da29q0Fk9+wrzXGSak=
X-Received: by 2002:a05:6102:4746:b0:464:8ba6:2a66 with SMTP id
 ej6-20020a056102474600b004648ba62a66mr5927212vsb.31.1702546837567; Thu, 14
 Dec 2023 01:40:37 -0800 (PST)
MIME-Version: 1.0
References: <ZXm3rayrcvfO1t1Z@smile.fi.intel.com> <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
 <ZXnU3tMYCc2Rw8Qv@rigel> <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
 <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com>
 <ZXnb-ks_noYLWZZ2@smile.fi.intel.com> <CAMRc=MfaHKKKNkXW0L1FPjCH4VvG22Vn9q8z9tupZCtCEKZU2g@mail.gmail.com>
 <ZXoO8B0N3S49GnvX@smile.fi.intel.com> <ZXpJueTnmtUIecCd@rigel> <ZXplMThBSD53UV0s@rigel>
In-Reply-To: <ZXplMThBSD53UV0s@rigel>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Dec 2023 10:40:26 +0100
Message-ID: <CAMRc=MeZg0xg7ASA3x4PxCYymCmCEp0zZbUgGTCCzrjPaPZCag@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
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

On Thu, Dec 14, 2023 at 3:15=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Dec 14, 2023 at 08:18:01AM +0800, Kent Gibson wrote:
> > On Wed, Dec 13, 2023 at 10:07:12PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 13, 2023 at 08:03:44PM +0100, Bartosz Golaszewski wrote:
> > >
> > > ...
> > >
> > > > > - it adds complications for no benefit
> >
> > It provides a placeholder for collective documentation and clarifies
> > scope for the reader.
>
> Turns out kernel-doc can't deal with a struct variable declaration - it
> needs the struct to be named.
>
> So this doesn't parse:
>
> static struct {
>         struct rb_root tree;
>         spinlock_t lock;
> } supinfo;
>
> but this does:
>
> static struct supinfo {
>         struct rb_root tree;
>         spinlock_t lock;
> } supinfo;
>
> at which point I prefer the separate struct and var declarations as per
> the patch.
>
> Opinions?
>

Yeah, don't make it a kernel doc. It's a private structure, no need to
expose documentation for it in docs. Just use a regular comment - say
what it is and why it's here.

Bart

> Cheers,
> Kent.
>
