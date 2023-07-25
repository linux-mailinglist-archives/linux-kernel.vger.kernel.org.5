Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C226B761CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGYPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGYPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:05:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108619B4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:05:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so8687081e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690297537; x=1690902337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izSbvCwS33Nzu8WcsjFx0swOUhDCZ5hfgSwNc0cg4uM=;
        b=INwq7DEc2KTUbBH8qu1xUVJucRdHelF2FWT/7UoQM7/Crg1oHw0GTwilYzO+TR3aft
         izxyLQ4l49k5dZJjQM4o0xu4t1XK8BR1rbFGEANWFYDKDI01ACwGlDiQTpzgdhTLlC3m
         rZrWjVqTfOhnTN6nhjMA3MdLYrWJzCkpvDQ7IhQbTw1pNHg20xdcOm91Fs2enBPE9MgS
         iq7Uz7ik/cTqR1RK1TMiBscx+cC+MiMs1jYWLQMgbFBrWczHbLypcMWEyJoNRzW/5BOL
         VfqdvP9RJuVTAA7bFLNhC8SEsHc/qrOxEvDp0Ilr7jiOaoPO8Gq6HyJfY6aydjvO9zJu
         U7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297537; x=1690902337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izSbvCwS33Nzu8WcsjFx0swOUhDCZ5hfgSwNc0cg4uM=;
        b=eK06bYCKWhQT4LCApYYmopTLG44eS4zEjca9cESq0hU87GNdWyNH6EjusKSTBkUVUG
         yibLlwrcUZA0Ye+FOLiAZODj90Y4DOoiPWdcg4q+KI50zEs0Jb48Jdqeu6CGyC5bbWcC
         90fD0/QmYcm8PTSAkxbDfgiU0WXMUSbkmsVDjfdEahDvZGIjI9DYRdV79c438tPATiMg
         sL2+NP45iCRsMGuyY3BAo2YkhjvEqAP3jBGK9vRrFWeW7LUFFD6G6/qsrs0DGBWmin2r
         LaQbQ4+yrTF66TwA1273sHbtZUZn4SWoSIJTegTQgs78ZZ57vK4mNU+Ia/9stoTkcFLc
         PaUw==
X-Gm-Message-State: ABy/qLZwcxPY/Xl2RvsXe0Q7B/PzxtpfJu8UXsvaJaD3cDdsEXSKgADf
        G3rJqF1nPLmX0xV1ig8FllksfbDlddNtGsr78orRGyBL
X-Google-Smtp-Source: APBJJlErgxAq0AM7XIRqNwjKdD9Sby9qr60ycVyvpIw0pM350sS8HYl7GbZot1w/EWlL49IB7nOENZntcNNTUTfgGvE=
X-Received: by 2002:a05:6512:ac8:b0:4fb:89ac:a967 with SMTP id
 n8-20020a0565120ac800b004fb89aca967mr7157951lfu.56.1690297536906; Tue, 25 Jul
 2023 08:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <e292a30f-5cad-1968-de4f-0d43c9c1e943@igalia.com> <45a1e527-f5dc-aa6f-9482-8958566ecb96@mailbox.org>
In-Reply-To: <45a1e527-f5dc-aa6f-9482-8958566ecb96@mailbox.org>
From:   =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date:   Tue, 25 Jul 2023 11:05:00 -0400
Message-ID: <CAAxE2A6OhFVKSm8VY1iNJx_FvDH-ojfgxvSjTmJUwtcmouoLMw@mail.gmail.com>
Subject: Re: Non-robust apps and resets (was Re: [PATCH v5 1/1] drm/doc:
 Document DRM device reset expectations)
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org,
        pierre-eric.pelloux-prayer@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 4:03=E2=80=AFAM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 7/25/23 04:55, Andr=C3=A9 Almeida wrote:
> > Hi everyone,
> >
> > It's not clear what we should do about non-robust OpenGL apps after GPU=
 resets, so I'll try to summarize the topic, show some options and my propo=
sal to move forward on that.
> >
> > Em 27/06/2023 10:23, Andr=C3=A9 Almeida escreveu:
> >> +Robustness
> >> +----------
> >> +
> >> +The only way to try to keep an application working after a reset is i=
f it
> >> +complies with the robustness aspects of the graphical API that it is =
using.
> >> +
> >> +Graphical APIs provide ways to applications to deal with device reset=
s. However,
> >> +there is no guarantee that the app will use such features correctly, =
and the
> >> +UMD can implement policies to close the app if it is a repeating offe=
nder,
> >> +likely in a broken loop. This is done to ensure that it does not keep=
 blocking
> >> +the user interface from being correctly displayed. This should be don=
e even if
> >> +the app is correct but happens to trigger some bug in the hardware/dr=
iver.
> >> +
> > Depending on the OpenGL version, there are different robustness API ava=
ilable:
> >
> > - OpenGL ABR extension [0]
> > - OpenGL KHR extension [1]
> > - OpenGL ES extension  [2]
> >
> > Apps written in OpenGL should use whatever version is available for the=
m to make the app robust for GPU resets. That usually means calling GetGrap=
hicsResetStatusARB(), checking the status, and if it encounter something di=
fferent from NO_ERROR, that means that a reset has happened, the context is=
 considered lost and should be recreated. If an app follow this, it will li=
kely succeed recovering a reset.
> >
> > What should non-robustness apps do then? They certainly will not be not=
ified if a reset happens, and thus can't recover if their context is lost. =
OpenGL specification does not explicitly define what should be done in such=
 situations[3], and I believe that usually when the spec mandates to close =
the app, it would explicitly note it.
> >
> > However, in reality there are different types of device resets, causing=
 different results. A reset can be precise enough to damage only the guilty=
 context, and keep others alive.
> >
> > Given that, I believe drivers have the following options:
> >
> > a) Kill all non-robust apps after a reset. This may lead to lose work f=
rom innocent applications.
> >
> > b) Ignore all non-robust apps OpenGL calls. That means that application=
s would still be alive, but the user interface would be freeze. The user wo=
uld need to close it manually anyway, but in some corner cases, the app cou=
ld autosave some work or the user might be able to interact with it using s=
ome alternative method (command line?).
> >
> > c) Kill just the affected non-robust applications. To do that, the driv=
er need to be 100% sure on the impact of its resets.
> >
> > RadeonSI currently implements a), as can be seen at [4], while Iris imp=
lements what I think it's c)[5].
> >
> > For the user experience point-of-view, c) is clearly the best option, b=
ut it's the hardest to archive. There's not much gain on having b) over a),=
 perhaps it could be an optional env var for such corner case applications.
>
> I disagree on these conclusions.
>
> c) is certainly better than a), but it's not "clearly the best" in all ca=
ses. The OpenGL UMD is not a privileged/special component and is in no posi=
tion to decide whether or not the process as a whole (only some thread(s) o=
f which may use OpenGL at all) gets to continue running or not.

That's not true. I recommend that you enable b) with your driver and
then hang the GPU under different scenarios and see the result. Then
enable a) and do the same and compare.

Options a) and c) can be merged into one because they are not separate
options to choose from.

If Wayland wanted to grey out lost apps, they would appear as robust
contexts in gallium, but the reset status would be piped through the
Wayland protocol instead of the GL API.

Marek



Marek
