Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067EF80990C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572949AbjLHCLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHCLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:11:02 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C3171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:11:05 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-dbc4df9fb11so422803276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 18:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702001464; x=1702606264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrS1+gj4SQqrLBMUECtVXORlr6dGcnhoysWJjVqwxW0=;
        b=BvxLr56noAj0MwngcFDn9sBX4EkG4BqwIc4Ak82p+YDnmjrGZciQPj2XKeG9dXgxtM
         CGnKbQYASOFJbdM+AHJd83wDVE7rgJOgN0bIoUQWzSfWmF/exmxNVSrfATL5tz87AZRe
         0VRXEwfL6Gu7O1lDn/lKAqCcZlraQ6i2HBfKHN4RMhGY38o7V+iZsl1zrybPPOowbOtk
         FTesiy4M6Gkr7vvNz68zXWA6JLaUZRmOgJD55lMRL1TomYVVCtIdenNjqNxlcdhIh9Ah
         d6JNZZScjjbxp8YbRa37wGMXjsVAparQZYvs56jrRTqWnQkC6451RKKNi1gs/cjHGrey
         WZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702001464; x=1702606264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrS1+gj4SQqrLBMUECtVXORlr6dGcnhoysWJjVqwxW0=;
        b=fuHXrpOZEkoTfocwVYFgxxOjSYray1C5olMrXidDVcjhCS4a30O3BlJXBy+/J+LBe9
         OSlpyZHYg/L9FhclNhZiHU3hoC7yb6Uebpc5uFP6DGkKyW7MxYPUBV5T0KNaIWmma1IR
         Ycn5oc+NgfuKFAI8r2n6eSHdcGyJo4WND3Qqa7FCDGwOXGm13D1xzbSLo000xqIFUsPn
         UxFseahI2EiX4hkLTM2MNTrDutQuhcbccvEOmL5ubHBPaRdzq+/Kq8O9o5yJR+CCDPGr
         dgtLOIZNNyE44jMso1RC55/v28V2yfvyj4H4r0l5/7sGatv5s+RP3idFDxez9GwgKEje
         Atjg==
X-Gm-Message-State: AOJu0YyYIecFQf/bQyVSFi17JjeaoT4lmtTu+wMIY/rJjnTQKINi6+N8
        mbicQ8SH8SvioL9jPIDlPElBSinfzX2G3rX3pC2ZwA==
X-Google-Smtp-Source: AGHT+IFzB/fvfpt3l9KUjfBQeyBhYz5PrQ3cvYlMjYHNiikQIZ+vKmYh5c3DKdUmzSxnO8b96mhu8iTGOuCgu0Nogu4=
X-Received: by 2002:a25:d415:0:b0:db7:dacf:59f1 with SMTP id
 m21-20020a25d415000000b00db7dacf59f1mr3933594ybf.101.1702001464147; Thu, 07
 Dec 2023 18:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
 <CAMSo37XcwAn9znSQ8202LUTdBKLDz94QJ9i43aXya5LHs-4GiQ@mail.gmail.com>
 <87wmtqnk3y.fsf@kernel.org> <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
In-Reply-To: <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Fri, 8 Dec 2023 10:10:52 +0800
Message-ID: <CAMSo37UfQmpTb3_+URbGTbX77mTJNn4SC0aaVD5KXasMsW7Jow@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        Abhishek Kumar <kuabhs@chromium.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <jstultz@google.com>,
        Viktor Martensson <vmartensson@google.com>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 00:49, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrot=
e:
> >
> > > Recently during our Android build test on the Dragonboard 845c board,
> > > with the Android Common Kernel android11-5.4-lts and android12-5.4-lt=
s branches,
> > >
> > > we found there are some ufshcd related changes printed,
> > > and the serial console gets stuck, no response for input,
> > > and the Android boot is stuck at the animation window.
> > >
> > > The problem is reported here
> > >     https://issuetracker.google.com/issues/314366682
> > > You could check there for more log details.
> > >
> > > And with some bisection, I found it's related to this commit,
> > > when I revert this commit, the problem is gone.
> > >
> > > So replied here, not sure if you have any idea about it,
> > > or any suggestions on what we should do next to resolve the problem?
> >
> > FWIW we don't support Android kernels, only kernel.org releases.
>
> Right. If the problem also reproduces on mainline Linux then that
> would be interesting to know. I think db845c is at least somewhat well
> supported by mainline so it should be possible to test it there.

I checked with the ACK android-mainline branch, which is based on the
mainline Linux,
this commit is there, but the problem is not seen.

> If I had to guess, I'd think that probably the CE interrupts are
> firing nonstop for you and not getting handled. Then those constant
> interrupts are (presumably) causing the UFS controller to timeout. If
> this is true, the question is: why? Maybe you could use ftrace to
> confirm this by adding some traces to
> ath10k_snoc_per_engine_handler()? There's a way to get ftrace buffers
> dumped on panic (or, if you use kdb, it has a command for it).

Thanks for the suggestions, I will check internally on how to debug that.

> If this reproduces on mainline and it's not obvious how to fix this, I
> don't object to a revert. As per the description of the original
> patch, the problem being fixed was fairly rare and I didn't have a way
> to reproduce it. The fix seemed safe to me and we've been using it on
> Chromebooks based on sc7180, but if it had to get reverted it wouldn't
> be the end of the world.
>
> -Doug



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
