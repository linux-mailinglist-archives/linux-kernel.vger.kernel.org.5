Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77EA780C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbjHRNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377245AbjHRNg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:36:59 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE93ABA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:36:56 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-447d394d1ebso1267699137.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692365815; x=1692970615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsIumgRdmbXKKYutVbfz6n61nD3x8NOvvC4wDvxP2gk=;
        b=sbrcxzr75o4G0iGqXKHkOONZixAw9f8EmtDCp8021zK2/IdPDeFXGqYWQXyiVNF2zZ
         NsfF/0HolBSlJcr1cw98eQ2NRw/t2slOCXLvbz+KDhlLxlFS+p+NdPwekmm2dc7dpRIU
         poM58PKuoWSuiDP+vHYADTQXryKG9SinLcoI3uGLqOtuZWbfzLvHkIUlvkFaiQFbHYew
         tcl6UquTenA9i6lM26k6ekCxb+yHwvbaaWfGpwTUCb80bZQI1+Y3mfI/csRoocP+wfHt
         01AUcWwONsOWPZ0Qbei9a3JKLUiMeKT2ihilxi2G1Ja7BmfsWV5bJEl+xMFJ4UDjrMyP
         yMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692365815; x=1692970615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsIumgRdmbXKKYutVbfz6n61nD3x8NOvvC4wDvxP2gk=;
        b=D5yogJu2BJWcCPKCt8J0mQapl3cr87sedOQDlFfTW3XIW92TyWdFiUFdQNPmCMRudt
         ioYT64Z0q8pvOSc2GbAdnS6JIsCuoNr8wKezj55VLjqCx1T22qnwG7hQ3yB4fUblQQ8J
         oiKwc062ATo5Po8LFJvh7jpyS2XMfAr4S4xGE6PVoCzvWpIFmWlQXy4OIXJXZW22zFUo
         YHhdcpXSmb48wfXFZbaEe3L6RtRryxFfM9huVnAZuSV6c4eyTXiocmrn6CcxsJwpTtIR
         lBz2QVFkaXfGA9Fqh/0n9avV7nVkbPiC/6Vbtq7W0NuJI0LPw6ZwJpmY754Bj2XKaR+a
         CBCQ==
X-Gm-Message-State: AOJu0Yx4+Vo5AdoEikn6zsQ/KhUCKnTHPOS3cxyl+hsmnUD9Z+eHyrBX
        TdnO5TZj/2hqTop2q6T8WkYeZP0dGQRIGU5KMZYNeA==
X-Google-Smtp-Source: AGHT+IH40OZbT/t7F3DFRbLyk8HlJv878bO7NIIMY/PzuMHb78kJ3oPz0yuq6grwoWoboGjCQVbVd/YESqxy/iKdGiQ=
X-Received: by 2002:a05:6102:11ea:b0:445:944:b6dc with SMTP id
 e10-20020a05610211ea00b004450944b6dcmr2634570vsg.7.1692365814977; Fri, 18 Aug
 2023 06:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230817184958.25349-1-brgl@bgdev.pl> <ZN9JID53QpSz4epI@smile.fi.intel.com>
 <CAMRc=MfZ=GgcqKkDXkUgWC-bdCJECs0HfjRe9Ffy-Metwz6fFQ@mail.gmail.com> <ZN9ySmxxdoLODcc9@smile.fi.intel.com>
In-Reply-To: <ZN9ySmxxdoLODcc9@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 18 Aug 2023 15:36:44 +0200
Message-ID: <CAMRc=McZM=OZzpwKL2x4PjYY4BtJBOVjvKOshcD5Zk8ECnJsng@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] gpio: cdev: bail out of poll() if the device goes down
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 3:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 18, 2023 at 02:06:21PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Aug 18, 2023 at 12:34=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 08:49:52PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Wake up all three wake queues (the one associated with the characte=
r
> > > > device file, the one for V1 line events and the V2 line request one=
)
> > > > when the underlying GPIO device is unregistered. This way we won't =
get
> > > > stuck in poll() after the chip is gone as user-space will be forced=
 to
> > > > go back into a new system call and will see that gdev->chip is NULL=
.
> > >
> > > Why can't you use the global device unbind notifications and filter o=
ut
> > > what you are interested in?
> >
> > There's no truly global device unbind notification - only per-bus.
> > GPIO devices can reside on any bus, there are no limitations and so
> > we'd have to subscribe to all of them.
>
> We have, but it requires a bit of code patching.
> Look at device_platform_notify()/device_platform_notify_remove().
>
> I noticed, btw, that platform_notify() and Co is a dead code :-)
> Maybe it can be converted to a list and a manager of that list,
> so specific cases can utilize it.
>

That's not going to happen anytime soon and I doubt Greg would like
the idea without more users interested in receiving these events. :(

This GPIO notifier is an implementation detail - once we do have
global notifiers, we can switch to using them instead.

Bart
