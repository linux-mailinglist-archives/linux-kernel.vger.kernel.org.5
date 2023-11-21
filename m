Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C87F351B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjKURmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKURmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:42:16 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B42F112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:42:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so7643032a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700588530; x=1701193330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP5SDBtDUDWOkpqIezUOaAd1ybPjQCdnHFhT1QKkHvo=;
        b=h8s1Qya4T5KS5y5SZVXTpr9EPwIregpLJ/Q+WQh0UxEZ2AncM42L9/V5vkWoEi8h+b
         KTMBpmcvsS395oVVAL77yanwUJt1mhcUykigzA10zUSCdZpOUngYzegfHCZRneBfLq3+
         UAl+qLZYpzKhXjCAssyPcvPeobEWHYU5YnKRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588530; x=1701193330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP5SDBtDUDWOkpqIezUOaAd1ybPjQCdnHFhT1QKkHvo=;
        b=LxyqBdQT4Ao24wlTUyiOuBZlNm/qS3r8lqstFCrC7EpPePXr3RBktf2rvFYidxzzw4
         gSYZPKh2Pxa5uetjrUrRQSQIKyqJ9PDaQLWMw8HDwloRv2dD+cmVBmzVHsyvt+gS8LQU
         GPzCUmUbiuSQP/2fqF1NVMBvp2g1EiyJ8NijT/OOe5+WR0la0EjPhFcUY/FU+dIckQrf
         h7WTxdI2GU+r2mlFgcM5GBN0dtT9Qn3T/Xc+EDFS/9720CGLpa88LA0eMZWrRdEKgnGn
         LiqQXQuspDPBaCiG484NUE1dmZMa+DswOAo48EX1d49Z92N6i+wNZcjljuZt+gP7tXWV
         eCTQ==
X-Gm-Message-State: AOJu0Yy4E8/zkVTfq7zczIIZ6tJ6RX/ImZuZkDSamkG+jXwtTl4btWjU
        t6v9g6R9VtEtd9bFMcDUEg97kSj1d/5vGmeRXmHR/lC9
X-Google-Smtp-Source: AGHT+IHvV/RxDtIQ+NkX33z15OpsrfCVRn01dlk/9IyzokwavwpOCsGBZcnL/QXjWIQQfWZJ0P1iig==
X-Received: by 2002:a17:907:8dce:b0:9ae:5120:5147 with SMTP id tg14-20020a1709078dce00b009ae51205147mr8426442ejc.38.1700588529864;
        Tue, 21 Nov 2023 09:42:09 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id g27-20020a170906395b00b009fd727116b4sm3054689eje.129.2023.11.21.09.42.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:42:09 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so195e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:42:09 -0800 (PST)
X-Received: by 2002:a05:600c:c1a:b0:40b:2979:9cc2 with SMTP id
 fm26-20020a05600c0c1a00b0040b29799cc2mr1025wmb.1.1700588528601; Tue, 21 Nov
 2023 09:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <f8c1979e2c71d871998aec0126dd87adb5e76cce.camel@redhat.com>
In-Reply-To: <f8c1979e2c71d871998aec0126dd87adb5e76cce.camel@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Nov 2023 09:41:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VqZq33eLiFPNiZCJmewQ1hxECmUnwbjVbvdJiDkQMAJA@mail.gmail.com>
Message-ID: <CAD=FV=VqZq33eLiFPNiZCJmewQ1hxECmUnwbjVbvdJiDkQMAJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] r8152: Hold the rtnl_lock for all of reset
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grant Grundler <grundler@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 21, 2023 at 2:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> > As of commit d9962b0d4202 ("r8152: Block future register access if
> > register access fails") there is a race condition that can happen
> > between the USB device reset thread and napi_enable() (not) getting
> > called during rtl8152_open(). Specifically:
> > * While rtl8152_open() is running we get a register access error
> >   that's _not_ -ENODEV and queue up a USB reset.
> > * rtl8152_open() exits before calling napi_enable() due to any reason
> >   (including usb_submit_urb() returning an error).
> >
> > In that case:
> > * Since the USB reset is perform in a separate thread asynchronously,
> >   it can run at anytime USB device lock is not held - even before
> >   rtl8152_open() has exited with an error and caused __dev_open() to
> >   clear the __LINK_STATE_START bit.
> > * The rtl8152_pre_reset() will notice that the netif_running() returns
> >   true (since __LINK_STATE_START wasn't cleared) so it won't exit
> >   early.
> > * rtl8152_pre_reset() will then hang in napi_disable() because
> >   napi_enable() was never called.
> >
> > We can fix the race by making sure that the r8152 reset routines don't
> > run at the same time as we're opening the device. Specifically we need
> > the reset routines in their entirety rely on the return value of
> > netif_running(). The only way to reliably depend on that is for them
> > to hold the rntl_lock() mutex for the duration of reset.
>
> Acquiring the rtnl_lock in a callback and releasing it in a different
> one, with the latter called depending on the configuration, looks
> fragile and possibly prone to deadlock issues.

Yeah, I debated this as well. I looked through the USB code and I
couldn't find any reason that it wouldn't work to hold the lock for
the duration. I agree that it's a little more fragile in one sense,
but I think it avoids potential races too and that makes it less
fragile in a different sense. ;-)


> Have you tested your patch with lockdep enabled?

Yes, lockdep reported no problems with my patch. Indeed lockdep hints
are how I ended up with the current solution. When I originally tried
to lock the device in rtl8152_open() then lockdep yelled at me about
the AB BA issues between the device lock and the rtnl_lock() mutex
which made me realize that grabbing the rtnl_lock() in the reset code
was the right solution here.


> Can you instead acquire the rtnl lock only for pre_reset/post_rest and
> in rtl8152_open() do something alike:
>
>         for (i =3D 0; i < MAX_WAIT; ++i) {
>                 if (usb_lock_device_for_reset(udev, NULL))
>                         goto error;
>
>                 wait_again =3D udev->reset_in_progress;
>                 usb_unlock_device(udev);
>                 if (!wait_again)
>                         break;
>
>                 usleep(1);
>         }
>         if (i =3D=3D MAX_WAIT)
>                 goto error;
>
> which should be more polite to other locks?

Right, I could add a call to usb_lock_device_for_reset() here. That
shouldn't trigger AB BA lockdep splats since it has a timeout. I'm not
100% convinced that it's right, though. ...and I'm fairly certain that
if we call it we don't want to call it in a loop.

I don't think we should have a loop because
usb_lock_device_for_reset() already has a loop in it and I don't think
an extra loop will help. I'd imagine that usb_lock_device_for_reset()
would usually timeout only if USB reset is currently running and
somehow blocked. If pre_reset or post_reset are currently running then
they've already got the USB lock (from their caller) and may be
blocked waiting for the rtnl_lock. We've already got the rtnl_lock
(from our caller) and now we're waiting for the USB lock. In neither
case do I think it's a good idea to drop the locks that our caller
grabbed for us, so about the best we can do in that case is return an
error from r8152_open() after the first timeout.

Let's step back and think about why we might want to get the USB lock
in the first place. This would only be necessary if we dropped the
lock between pre_reset and post_reset, right? ...so we're trying to
make sure that we're not trying to open a device while the USB reset
code is half executed. I guess the expected order of operations we're
trying to protect against would be:

1. rtl8152_close() is called and has a transfer error that queues up a rese=
t.
2. USB reset starts and pre-reset runs. It should be a no-op because
netif_running() would return false.
3. rl8152_open() is called and opens the device successfully
4. USB reset runs post-reset, which is no longer the inverse of
pre-reset because netif_running() would return true. This would end up
with, among other things, an unbalanced napi_enable() count.

That feels relatively unlikely to actually hit but it does seem
conceivably possible. Thus if we do drop the rtnl_lock between
pre-reset and post-reset then I agree we should call
usb_lock_device_for_reset(). Probably we need to do that for _both_
rtl8152_open() and rtl8152_close()? We also probably don't need to
hold the lock for the whole duration of rtl8152_open() /
rtl8152_close(). We can just grab it and release it to make sure that
we're not midway through a reset.

I guess one sorta odd thing here is that it means that rtl8152_close()
could now fail if someone called it at just the right time and we were
unable to grab the USB lock. Though it does have an error return,
that's not a failure that I'd expect most users to be able to handle
terribly well. I guess conceivably we could return -EAGAIN or
-EDEADLOCK in this case, but ick...


Hopefully the above makes sense. I'd be interested to hear your
further thoughts on the issue. I'd still lean towards leaving the code
as-is and holding the rtnl_lock across the whole reset, but for all
practical purposes I think it would be fine to split it and add
usb_lock_device_for_reset() to the rtl8152_open() / rtl8152_close(),
since the issues I talk about above seem like they'd need extremely
rare timing conditions to hit.

-Doug
