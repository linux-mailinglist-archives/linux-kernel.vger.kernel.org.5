Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88F77FAF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjK1AqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjK1AqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:46:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FAC1B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:46:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so3315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701132376; x=1701737176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX5y/+1xsJTb3d79j1A2vz0g1fgyzJ3hfPEMuJD84tQ=;
        b=IvzUw73L7c2geiXIEtp9BCl9QFFc8dWOtLEjEsF9vQYoyjfqhHpJdnmBxObwwjtKnv
         x9JGyplzbszEisFC6iYLkA/qex0Lnx1f552SKz24+HhsreCDPuL0HvZClsOdepKIOk10
         mQmHXo5SQtVkjKIQz+Sp5GsoomQQCNmwOV6ncF3Gy7pxRLNVYF1uF5mBjq6MVICxiCY+
         ZglnRT8r6NKzFZTwudmZdls+ZIRYcvjCFRqKIuh802uP3fUjGh05CLw/1sUC2M0rsjM+
         AX9x0d2iFPbF2BYbj5Ymfwk8abweg/S8XHAT/U9kKpx3Ou63W7lRq2Eztq0PNFVnSA88
         cRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701132376; x=1701737176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX5y/+1xsJTb3d79j1A2vz0g1fgyzJ3hfPEMuJD84tQ=;
        b=mp4psZQS3EbKScdFMtLaOd+oD8OTyduqIfT81+uMSxE5urvq2nBnf2IS7hsySk2nix
         5kdpRIGh7mjv2wzOI7AAKvQ56ZQH/aELodwg6BWNPToD5+9It+5pXFCpaytGQzjjihDP
         V1QqITMrtwZX7jMMxiNu6PxWLHS7ZMFEAPVLw0nxJs4GB6gTNwNJ+M6n32FcKJbmrMK2
         9kQFSI3RP+PFLr3D2vLZuBaAwi+BVu7+DWLxjeiRNGz7rQdOAL2KaMGI+tM6qJivNs/5
         WmfrOIP6mjkTAMHwicBF3ctF9JN51spqgdNcXmIFDvDupv7eJPyQvYOpgEWaAzBVoY38
         8KTw==
X-Gm-Message-State: AOJu0YyaYuJk2PUHunJfBiTpyo5xQe8tg/PLNm4A+zaB2vs95WuF8Tkd
        bT8kyNvrKmMHqmoR+qGIS07yKjF1frXTgYHDRu+K
X-Google-Smtp-Source: AGHT+IHTKx4qq0PtLWDhHqHYKuaX+k8K9wvvHKuyFFO0SY4Z0hFF7OwkyFrnm5b4J924iJAGZbl02apJHFMUQmMyzxE=
X-Received: by 2002:a05:600c:3b13:b0:40a:483f:f828 with SMTP id
 m19-20020a05600c3b1300b0040a483ff828mr731991wms.4.1701132375913; Mon, 27 Nov
 2023 16:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20231127153901.6399-1-maimon.sagi@gmail.com> <ZWUwTnWEHipJqHnk@hoboy.vegasvil.org>
In-Reply-To: <ZWUwTnWEHipJqHnk@hoboy.vegasvil.org>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 27 Nov 2023 16:46:03 -0800
Message-ID: <CANDhNCq=iV2_1bzaP=BYuUwJtNsQBdjuYqUUtsiLc-MCNURJ6w@mail.gmail.com>
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Sagi Maimon <maimon.sagi@gmail.com>, reibax@gmail.com,
        davem@davemloft.net, rrameshbabu@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 4:12=E2=80=AFPM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Mon, Nov 27, 2023 at 05:39:01PM +0200, Sagi Maimon wrote:
> >  Some user space applications need to read some clocks.
> >  Each read requires moving from user space to kernel space.
> >  This asymmetry causes the measured offset to have a significant error.
>
> Adding time/clock gurus (jstultz, tglx) on CC for visibility...
>

Thanks for the heads up! (though, "guru" is just the noise I make
standing up these days)

> >  Introduce a new system call multi_clock_gettime, which can be used to =
measure
> >  the offset between multiple clocks, from variety of types: PHC, virtua=
l PHC
> >  and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> >  The offset includes the total time that the driver needs to read the c=
lock
> >  timestamp.

This last bit about "offset includes the total time that the driver
needs to read the clock" is a bit confusing. It seems to suggest there
would be start/stop bookend timestamps so you could bound how long it
took to read all the clocks, but I don't see that in the patch.

> >  New system call allows the reading of a list of clocks - up to PTP_MAX=
_CLOCKS.
> >  Supported clocks IDs: PHC, virtual PHC and various system clocks.
> >  Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
> >  The system call returns n_clocks timestamps for each measurement:
> >  - clock 0 timestamp
> >  - ...
> >  - clock n timestamp
> >
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

Overally, while I understand the intent, I'm pretty hesitant on it
(and "__ptp_multi_clock_get multi_clk_get" has me squinting to find
the actual space amongst all the underscores :).

If the overhead of reading clockids individually is too much, it seems
like the next thing will be folks wanting to export multiple raw
hardware counter values so the counter->ns transformation doesn't get
inbetween each hw clock read, which this interface wouldn't solve, so
we'd have to add yet another interface.

Also, I wonder if trying to get multiple clocks in one read seems
similar to something uio_ring might help with? Though I can't say I'm
very savvy with uio_ring. Have folks looked into that?

thanks
-john
