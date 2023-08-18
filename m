Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73578134C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379599AbjHRTR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379594AbjHRTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:17:09 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587C3A9C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:17:08 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44bf46b6f97so1469583137.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692386227; x=1692991027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2olCtSHMv9S/Vh31p+VxmPYSbsc15i9V3z5v16wQ4o=;
        b=4VQGvdlGGDz23r41y9pnJZRRDATqlDECx3YkBOnI7gPAk0tJtKvjP5NIDrjDJZO+el
         6CQQRFO0AGt9XvTFfe5gdUqoWQSNPgxm+8FnFIArhiFwCtK05ec4HNlyeA7NKJ4JCbfK
         ZV/1HMK7zRMAHFMuTRtxnWbwYgGUooNd/jPa6V7b02Qmh0tMZOi2/Ujg1JyUmEzeglQ7
         fZB7vooQmhUtDErUm1DDacESeFAqB5WRX2CGDDEl/n26Za52IYyD6nOXyxefqZ3vfrkB
         T3PXRRT8TW3iysN2cqfBZhlMIQMTzW7DV50jxOK1ZzHLyB4Q7sOQFR2o5GR5jYFVParP
         sSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692386227; x=1692991027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2olCtSHMv9S/Vh31p+VxmPYSbsc15i9V3z5v16wQ4o=;
        b=FDvVF7MqczaUA6kqLFtq7Y3FzEevjremojVPNfFBg4ZoeN/3einE29azMEeztDowzm
         Jgehgmz+oMJo7sVZBNrRm0u8CkX+P+IFbIo7r1BcQpfreFUG0BJJv2IxMJ4u/nIn0C8b
         6U/9r06vpdsfgYIh+UTSCZ7pf+1UyEno35XXgYE5qCZCdV86U8W+5peXHUFrcyTqXbWj
         6xoLiQXIvDEze5bo1/5DsBV5drN1WMtIl1JnN+zgsFwWtI4jwcBdf38eC8mlva36x2Yn
         wpOE8WWbn/ZAHs5W/CCupeJXZqOWw5nD3VN5nXd07rmoxSg6uBJ7ctti9qRw3ps+Oqgc
         17Ow==
X-Gm-Message-State: AOJu0YzUtsBmTLt6kaiC0LIDYb9i002vJXykrTqEoyeWDxmvvdmVMTuD
        dV8lS2uLyaBtnAIp725NCWQafeQEZPretCUQClAa3Q==
X-Google-Smtp-Source: AGHT+IE/kBmoW0BQWLrg6txTAoMm4KHbkTcnawgJ2C+J9UbjrJHAfGNuIopRxTkk7HSivygkSlNdaunNKcCWDHnyc7w=
X-Received: by 2002:a67:fdc3:0:b0:443:5ddf:4f5b with SMTP id
 l3-20020a67fdc3000000b004435ddf4f5bmr173242vsq.11.1692386227207; Fri, 18 Aug
 2023 12:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230817184958.25349-1-brgl@bgdev.pl> <ZN9JID53QpSz4epI@smile.fi.intel.com>
 <CAMRc=MfZ=GgcqKkDXkUgWC-bdCJECs0HfjRe9Ffy-Metwz6fFQ@mail.gmail.com>
 <ZN9ySmxxdoLODcc9@smile.fi.intel.com> <CAMRc=McZM=OZzpwKL2x4PjYY4BtJBOVjvKOshcD5Zk8ECnJsng@mail.gmail.com>
In-Reply-To: <CAMRc=McZM=OZzpwKL2x4PjYY4BtJBOVjvKOshcD5Zk8ECnJsng@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 18 Aug 2023 21:16:56 +0200
Message-ID: <CAMRc=McXpjqFDfkGMaRqDnLs+sRGYrBK3+5Qsjq9HNYwOHaUgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] gpio: cdev: bail out of poll() if the device goes down
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

On Fri, Aug 18, 2023 at 3:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Fri, Aug 18, 2023 at 3:29=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Aug 18, 2023 at 02:06:21PM +0200, Bartosz Golaszewski wrote:
> > > On Fri, Aug 18, 2023 at 12:34=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Thu, Aug 17, 2023 at 08:49:52PM +0200, Bartosz Golaszewski wrote=
:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Wake up all three wake queues (the one associated with the charac=
ter
> > > > > device file, the one for V1 line events and the V2 line request o=
ne)
> > > > > when the underlying GPIO device is unregistered. This way we won'=
t get
> > > > > stuck in poll() after the chip is gone as user-space will be forc=
ed to
> > > > > go back into a new system call and will see that gdev->chip is NU=
LL.
> > > >
> > > > Why can't you use the global device unbind notifications and filter=
 out
> > > > what you are interested in?
> > >
> > > There's no truly global device unbind notification - only per-bus.
> > > GPIO devices can reside on any bus, there are no limitations and so
> > > we'd have to subscribe to all of them.
> >
> > We have, but it requires a bit of code patching.
> > Look at device_platform_notify()/device_platform_notify_remove().
> >
> > I noticed, btw, that platform_notify() and Co is a dead code :-)
> > Maybe it can be converted to a list and a manager of that list,
> > so specific cases can utilize it.
> >
>
> That's not going to happen anytime soon and I doubt Greg would like
> the idea without more users interested in receiving these events. :(
>
> This GPIO notifier is an implementation detail - once we do have
> global notifiers, we can switch to using them instead.
>
> Bart

Seems to me the whole platform_notify() thing was meant for a
different purpose. There's no trace for it ever being used for
notifying users about driver bind and unbind events.

It appears to me too that adding a global notifier would be as simple
as extending the functionality of bus_notify() with a second, global
notifier chain. But I won't be the one to propose this to Greg KH. :)

Bart
