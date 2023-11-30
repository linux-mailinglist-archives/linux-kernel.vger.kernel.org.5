Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05B7FF3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbjK3PpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjK3PpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:45:14 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436710D5;
        Thu, 30 Nov 2023 07:45:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso981344276.1;
        Thu, 30 Nov 2023 07:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701359119; x=1701963919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LfUJvZcECV2OLIK51x1URKvRT3tty1HIzScZdH3myE=;
        b=gr+oTEZJT1Sl8CPBfCJgiQdG8I/oMxIjRfpJHUdsYkeslEkYYroCURsZJBJLWLkL6P
         bOc6o1ANK+Gj4dGbpky1wbIQmKcK2+VF/nqyTwe/lFc7Gqh9WGPAPWh5bkNkLtqQI477
         0v84rFB6iV4qEJ31pgiO4Exh3kTfc/BYqlGyEGprILIIaPdxyuTjgqmYoof0Vit+eXHO
         C0WOvHByISRyj/hCrCl0gC5ImAKU/fHrwW29BnN8lfOnXunQcBOqq6dPeQUn6E4iqcEr
         IYTpWNYrK3Ye82226F5sQKzGCLFmzrQa+QrhLcXM2xu6h8I3WSpvH9Vr/enACbJkY1o3
         mKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701359119; x=1701963919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LfUJvZcECV2OLIK51x1URKvRT3tty1HIzScZdH3myE=;
        b=FVHou9lLQ0VL2qUYEtjP6/Qd41ayFK23Hiq77vfPvgzpEiNssXx3EwFYfz9reXmJxx
         18ZdvEFn87wYDdTZFYwF4Wak3KWUGVBqJ+p2mJZxYYAa8hO9v8DmGeiYCdwSLCSksiB9
         Y+R4yzy8z6jXJ1DWzHkD1pGdAXTbMS81RLVPWGBUuM24sMp2beEFxTk12EDEnb3n4O75
         WLMcH+cPiUYPiHsi39Kvv1WIruWYv5CY52DHm/UcPNwKefOEfiu9frO/ljGdQqpmeSOT
         1PodSasUNm5oLniSUIAXisinp+KT1EpXanbPF+WhgU3gCrvwSZptnzAv/84GF1x80W15
         /vfw==
X-Gm-Message-State: AOJu0YxILXPz8ulKfybvqjB3quQqYIcp6EV86jmO0Vj6x6XhAL6xHOmm
        vUUnMKl9rWhm0hMSvJPgxthSyTNegsmSd5OImeA=
X-Google-Smtp-Source: AGHT+IEGwQ0wkgJ/HJHi+WTOwH4YC53KjLeCK/BXJqoZi8k8UErMGuY3MqGPX0IX0aq2FEmoS60rqPUGLOTCH1JHnKo=
X-Received: by 2002:a25:3d46:0:b0:d91:b6e5:54dd with SMTP id
 k67-20020a253d46000000b00d91b6e554ddmr21470653yba.3.1701359119126; Thu, 30
 Nov 2023 07:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20231127153901.6399-1-maimon.sagi@gmail.com> <ZWUwTnWEHipJqHnk@hoboy.vegasvil.org>
 <CANDhNCq=iV2_1bzaP=BYuUwJtNsQBdjuYqUUtsiLc-MCNURJ6w@mail.gmail.com>
In-Reply-To: <CANDhNCq=iV2_1bzaP=BYuUwJtNsQBdjuYqUUtsiLc-MCNURJ6w@mail.gmail.com>
From:   Sagi Maimon <maimon.sagi@gmail.com>
Date:   Thu, 30 Nov 2023 17:45:08 +0200
Message-ID: <CAMuE1bG1ShKVakUH5f41_NNixBZRTUgXW8-=BWZxfNde6ohbVw@mail.gmail.com>
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
To:     John Stultz <jstultz@google.com>
Cc:     Richard Cochran <richardcochran@gmail.com>, reibax@gmail.com,
        davem@davemloft.net, rrameshbabu@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,
Thanks for your notes.

On Tue, Nov 28, 2023 at 2:46=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> On Mon, Nov 27, 2023 at 4:12=E2=80=AFPM Richard Cochran
> <richardcochran@gmail.com> wrote:
> >
> > On Mon, Nov 27, 2023 at 05:39:01PM +0200, Sagi Maimon wrote:
> > >  Some user space applications need to read some clocks.
> > >  Each read requires moving from user space to kernel space.
> > >  This asymmetry causes the measured offset to have a significant erro=
r.
> >
> > Adding time/clock gurus (jstultz, tglx) on CC for visibility...
> >
>
> Thanks for the heads up! (though, "guru" is just the noise I make
> standing up these days)
>
> > >  Introduce a new system call multi_clock_gettime, which can be used t=
o measure
> > >  the offset between multiple clocks, from variety of types: PHC, virt=
ual PHC
> > >  and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> > >  The offset includes the total time that the driver needs to read the=
 clock
> > >  timestamp.
>
> This last bit about "offset includes the total time that the driver
> needs to read the clock" is a bit confusing. It seems to suggest there
> would be start/stop bookend timestamps so you could bound how long it
> took to read all the clocks, but I don't see that in the patch.
>
You are right it is a little confusing, I will remove it from the commit .

> > >  New system call allows the reading of a list of clocks - up to PTP_M=
AX_CLOCKS.
> > >  Supported clocks IDs: PHC, virtual PHC and various system clocks.
> > >  Up to PTP_MAX_SAMPLES times (per clock) in a single system call read=
.
> > >  The system call returns n_clocks timestamps for each measurement:
> > >  - clock 0 timestamp
> > >  - ...
> > >  - clock n timestamp
> > >
> > > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
>
> Overally, while I understand the intent, I'm pretty hesitant on it
> (and "__ptp_multi_clock_get multi_clk_get" has me squinting to find
> the actual space amongst all the underscores :).
>
struct __ptp_multi_clock_get __user * ptp_multi_clk_get has many
underscores indeed :-)
I will rename it, if you have any naming suggestions, I will be glad to hea=
r it.

> If the overhead of reading clockids individually is too much, it seems
> like the next thing will be folks wanting to export multiple raw
> hardware counter values so the counter->ns transformation doesn't get
> inbetween each hw clock read, which this interface wouldn't solve, so
> we'd have to add yet another interface.
>
future raw HW counter read interface:
=E2=80=A2 For PHC - reading raw HW counter is driver dependent, and will
require changes in many existing PTP drivers.
=E2=80=A2 For System clock it is possible but with much more code changes a=
nd
the improvements seems to be small.
=E2=80=A2 The issue you introduced can be reduced (but not completely
overcome) by user space usage of the interface.
For example, to minimize the difference between clock X and clock Y,
users can call  multi_clock_gettime  with 3 clock reads : X, Y, and X
again.
Considering gain (thin extra accuracy) vs pain (a lot of code changes,
also for system clocks) and needs =E2=80=93 we chose to settle with the
current suggested interface.

> Also, I wonder if trying to get multiple clocks in one read seems
> similar to something uio_ring might help with? Though I can't say I'm
> very savvy with uio_ring. Have folks looked into that?
>
I am also not an expert with the uio_ring/liburing, but I researched a
little and it seems it is mainly used for IO operations and support
only few of them (IORING_OP_READV, IORING_OP_SENDMSG, etc.)
I am not sure how to implement it for consecutive clock_gettime system
calls and if it can be done at all.
Even if it can be done, it adds a lot of complexity to the user space
code and the use in one generic system call is more elegant in my
opinion.
For example: Looking at the existing ioctl PTP_SYS_OFFSET,
theoretically it can also be implemented by uio_ring, but it is still
a more elegant solution.
> thanks
> -john
