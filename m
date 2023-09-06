Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9C7940A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbjIFPpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbjIFPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:45:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6411724;
        Wed,  6 Sep 2023 08:45:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501ce655fcbso568449e87.2;
        Wed, 06 Sep 2023 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694015125; x=1694619925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQiQz3+I8vY7abxTdtpZH6nA7V1qCV7p78jA8rANmPQ=;
        b=gzp8cybGh4kcFhSKABARyH74YGcXRlIhJwkjBtOAUiBUiP7M8ms/Hr5HrH/IkGf2fF
         P6VqVTkmb78oA7uTiIljwcHbQnubGAv+MV5ijm7Uu656a3GYgaf9aqSfQxukoRgTODnb
         CzTH7dySxB0yXjRvc5sgCyAcfouzzHMFmJvgcJ/9a+7oLb0eFpVRGI90pvTq97d7dDHE
         lNGaKi8rvxQnsfFjdoCkYCfgki4YHQZDovY6fWyaaDTiTXS8hJadNTL075Qg2g65suft
         5VcWhej2++KqejFYH5cXWNKn9FGGmSqJWKTmTzvNO+fQtULol5bYiqHru42s87ZNkaYv
         bqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694015125; x=1694619925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQiQz3+I8vY7abxTdtpZH6nA7V1qCV7p78jA8rANmPQ=;
        b=RvH44m28HyvQdRWb5I33N/Sr9m4OiWsm0Za2HM+hV6r/RHHzdxRUdHFJTM7TDQIyjJ
         Rms0huxn+4hbZJYEYGDOIFBgAelAeIFnujRHFjLGCtsKExYNCPAiZl8TVFBVeAi1nUye
         koXkLDSfR0ZHgZQZlCd0SWRZEJTHwRzXkr7mZ1SiTxijOAjhzhmDWg3ubXa4DMLm6xzI
         RWDhJsMwUA2aZaUg1Rpp6YtixxOAhpzxWHJS7cpLOE1b+j73prDf3g0R6mRncE8OhPmc
         vTYRil/k2rpi3wLoxNrFcJ9yn98iubwCJKZ+tOqti8sTtRvzavHbqbLZn0E8kWnXOXW0
         In8Q==
X-Gm-Message-State: AOJu0YwqvCgCmPC+zxMMLsuQLV2Kfc1+hYTx9wVysI6kfNwNG+aM2PdX
        CuuTFhW21bbzelK0AKyHdjXOGLIKqV5tazWCrN3evEnGiTI=
X-Google-Smtp-Source: AGHT+IGm7N3BRJVcQSOdqp9OH33rDfjW6f4DnESXe0m8BhdERx7Qf1v1ZaMFytEvmwuINjsC95nv70MIL6kH97FuTAE=
X-Received: by 2002:a05:6512:1115:b0:501:fe39:ee00 with SMTP id
 l21-20020a056512111500b00501fe39ee00mr67264lfg.60.1694015124716; Wed, 06 Sep
 2023 08:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230826152111.13525-1-max@enpas.org> <20230826152111.13525-3-max@enpas.org>
 <ec4d07de-4944-a7ea-2b74-c4162af75b16@enpas.org>
In-Reply-To: <ec4d07de-4944-a7ea-2b74-c4162af75b16@enpas.org>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Wed, 6 Sep 2023 08:45:12 -0700
Message-ID: <CAEc3jaDoRESqJ_6KAa6FHvbF=R4ZRV0P+=4KY5pjYPCrwroqCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hid-sony: DS3: Report analog buttons for Sixaxis
To:     Max Staudt <max@enpas.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Vicki Pfau <vi@endrift.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:12=E2=80=AFPM Max Staudt <max@enpas.org> wrote:
>
> On 8/27/23 00:21, Max Staudt wrote:
> > This change exposes these buttons as axes in a way that is as backwards
> > compatible and as close to the Linux gamepad spec as possible.
> >
> > [...]
> >
> >   - The D-Pad as ABS_HAT0X/ABS_HAT0Y, -255 to 255
>
>
> One further idea:
>
> The DualShock 3 reports all 4 D-pad buttons separately, and hid-sony curr=
ently reports them as discrete digital buttons to userspace.
>
>
> Would it be better to do the same with the analog buttons, i.e. to report=
 the 4 measurements as discrete axes, rather than the current patch's appro=
ach of merging them into two logical axes?
>
> Of course, this would require 4 more axes, this would not fit into any ex=
isting scheme, and since we've run out of ABS_MISC+n at this point, this co=
uld be a further reason for officially reserving a range of axes for analog=
 buttons. Something like:
>
>
> #define ABS_BTN_SOUTH           0x40
> #define ABS_BTN_A               ABS_BTN_SOUTH
> #define ABS_BTN_EAST            0x41
> #define ABS_BTN_B               ABS_BTN_EAST
> #define ABS_BTN_C               0x42
> #define ABS_BTN_NORTH           0x43
> #define ABS_BTN_X               ABS_BTN_NORTH
> #define ABS_BTN_WEST            0x44
> #define ABS_BTN_Y               ABS_BTN_WEST
> #define ABS_BTN_Z               0x45
>
> #define ABS_BTN_DPAD_UP         0x46
> #define ABS_BTN_DPAD_DOWN       0x47
> #define ABS_BTN_DPAD_LEFT       0x48
> #define ABS_BTN_DPAD_RIGHT      0x49
>
> #define ABS_MAX                 0x4f
> #define ABS_CNT                 (ABS_MAX+1)
>
>
>
> Max
>

Hi Max,

Sorry for the late response, but I have been on vacation and just got back.

Analog buttons are as you know, fairly common on game controllers. For
this reason, I was working on this about 5 years ago as my company had
a need for it, but the need died out. I did send a proposal at the
time to linux-input, which I encourage you to look at ('Proposal to
support pressure sensitive "analog" buttons in evdev' on linux-input).
There are some good comments in there.

The summary of the discussion and also my thoughts is not to simply
reuse existing axes, but think of things in a bigger picture. In
particular I brought the example of analog keyboards into the
discussion at the time (Wooting made one) in which ALL buttons are
analog. The landscape has probably changed and I haven't caught up.
Quickly looking it looks like Razor now has one too and there are
probably more.

The key question is what are the similarities between these analog
devices. It feels it are not 'just' axes. There might be some level of
configurability (though not all of that) for example some keyboards
seem to use it as a way to trigger digital key presses at configurable
thresholds among others. Please look at the old discussion as there
were some good suggestions there if I recall from Peter Hutterer among
others.

Thanks,
Roderick
