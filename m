Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B577437D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjHHSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjHHSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:05:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE914D27E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:03:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230f8da574so3397527a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514228; x=1692119028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCtF+tlL9RHfHxmqFs9C5rEqPpa4jyBqd3r5LEKKols=;
        b=aBZltA2/j9gJFH0DRcIaD9UZ+V275GL4XmWvgdVWIUuVgUcK27xI5Ww5ou0S7ZgVMr
         snr8roKmVsjyHHP11xm9jT1M/Zp+uryGzqDuWIWnEzOxZ7D0ygH5UFIvdvX3eFJIMWIH
         G3VOIqnsf8GUXZY1dL3Bzcj3/Z8a8eGMNdO3vIFIJqH3hfYVuF5F0lXDnqZ1uE4LtLuX
         CDgwjYrk3+fPOwLG8R+U4eN3LV6sSG1M0xr7TjY1vQIQaz5YSfS66mP8qo23BCxne606
         h1CAp1VACppO8pFyUmq4aByRHoPBHz1f4Uf7NWs4wvGQfUPrmGlFOcMrNqTFl3go/TMV
         8Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514228; x=1692119028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCtF+tlL9RHfHxmqFs9C5rEqPpa4jyBqd3r5LEKKols=;
        b=IcwP9SxHzhAOeuHTkUbpKrY4YjppvvuKS0UoV9ixdRX09+jG24Lwkk3WD5IPxb/0yP
         kBmwP/OzOffgIGJJWzB8jmIxxRgceqDrnUawDOdF4y+RVw3QY5xuM1F8tBBEvVfOQeV+
         8OOjmwh8M7iJ0dQfZKBd8V0OkCBahD0t7eiXstW/qqt+33Havfk7SBUNReae7mXyxPNK
         WGyBXrDVDKcO0FJWDF22CNYkO32bCIYM1T/2JOqTlu0jWB0SKy/DgoqA4I5J3ThTG4Gg
         hiJW3AcGBn+ec92WTl6Ba1nKksYWGtaWCaW6I9NRff/OKyRTFJT8Dt10IObU2eC8sj54
         HZsA==
X-Gm-Message-State: AOJu0YzA1PISu0uxrmRAnN0oDc4NBOAc3P0V400L2lPE+eTPog4L4WCD
        5qL+gzxWNACExDKSxThAA2UgvXS+eHiqC7DP4CA=
X-Google-Smtp-Source: AGHT+IGiRf3LjW21hBgVZPw8p0E39D05fmYq9Nt6u/oqdz7fmoq9LG0DSAo2VVHnZ97EOoXBgYqFG2/wFndCouOjoWo=
X-Received: by 2002:aa7:d04c:0:b0:523:9c4:544f with SMTP id
 n12-20020aa7d04c000000b0052309c4544fmr386743edo.31.1691514227607; Tue, 08 Aug
 2023 10:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <ZMz3IXIzXS5gNK3G@phenom.ffwll.local> <CA+hFU4wbn=efbS10c14A9sLTf9GYJ_O12kowh76ELLdo2+x5fA@mail.gmail.com>
In-Reply-To: <CA+hFU4wbn=efbS10c14A9sLTf9GYJ_O12kowh76ELLdo2+x5fA@mail.gmail.com>
From:   =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date:   Tue, 8 Aug 2023 13:03:11 -0400
Message-ID: <CAAxE2A48uybsU6DY+fLTzQ9K2b0Ln+SW6bt3capbGAGb7L8fvQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
To:     Sebastian Wick <sebastian.wick@redhat.com>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's the same situation as SIGSEGV. A process can catch the signal,
but if it doesn't, it gets killed. GL and Vulkan APIs give you a way
to catch the GPU error and prevent the process termination. If you
don't use the API, you'll get undefined behavior, which means anything
can happen, including process termination.



Marek

On Tue, Aug 8, 2023 at 8:14=E2=80=AFAM Sebastian Wick <sebastian.wick@redha=
t.com> wrote:
>
> On Fri, Aug 4, 2023 at 3:03=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> wr=
ote:
> >
> > On Tue, Jun 27, 2023 at 10:23:23AM -0300, Andr=C3=A9 Almeida wrote:
> > > Create a section that specifies how to deal with DRM device resets fo=
r
> > > kernel and userspace drivers.
> > >
> > > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > > ---
> > >
> > > v4: https://lore.kernel.org/lkml/20230626183347.55118-1-andrealmeid@i=
galia.com/
> > >
> > > Changes:
> > >  - Grammar fixes (Randy)
> > >
> > >  Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 68 insertions(+)
> > >
> > > diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-u=
api.rst
> > > index 65fb3036a580..3cbffa25ed93 100644
> > > --- a/Documentation/gpu/drm-uapi.rst
> > > +++ b/Documentation/gpu/drm-uapi.rst
> > > @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a =
third handler for
> > >  mmapped regular files. Threads cause additional pain with signal
> > >  handling as well.
> > >
> > > +Device reset
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +The GPU stack is really complex and is prone to errors, from hardwar=
e bugs,
> > > +faulty applications and everything in between the many layers. Some =
errors
> > > +require resetting the device in order to make the device usable agai=
n. This
> > > +sections describes the expectations for DRM and usermode drivers whe=
n a
> > > +device resets and how to propagate the reset status.
> > > +
> > > +Kernel Mode Driver
> > > +------------------
> > > +
> > > +The KMD is responsible for checking if the device needs a reset, and=
 to perform
> > > +it as needed. Usually a hang is detected when a job gets stuck execu=
ting. KMD
> > > +should keep track of resets, because userspace can query any time ab=
out the
> > > +reset stats for an specific context. This is needed to propagate to =
the rest of
> > > +the stack that a reset has happened. Currently, this is implemented =
by each
> > > +driver separately, with no common DRM interface.
> > > +
> > > +User Mode Driver
> > > +----------------
> > > +
> > > +The UMD should check before submitting new commands to the KMD if th=
e device has
> > > +been reset, and this can be checked more often if the UMD requires i=
t. After
> > > +detecting a reset, UMD will then proceed to report it to the applica=
tion using
> > > +the appropriate API error code, as explained in the section below ab=
out
> > > +robustness.
> > > +
> > > +Robustness
> > > +----------
> > > +
> > > +The only way to try to keep an application working after a reset is =
if it
> > > +complies with the robustness aspects of the graphical API that it is=
 using.
> > > +
> > > +Graphical APIs provide ways to applications to deal with device rese=
ts. However,
> > > +there is no guarantee that the app will use such features correctly,=
 and the
> > > +UMD can implement policies to close the app if it is a repeating off=
ender,
> >
> > Not sure whether this one here is due to my input, but s/UMD/KMD. Repea=
t
> > offender killing is more a policy where the kernel enforces policy, and=
 no
> > longer up to userspace to dtrt (because very clearly userspace is not
> > really doing the right thing anymore when it's just hanging the gpu in =
an
> > endless loop). Also maybe tune it down further to something like "the
> > kernel driver may implemnent ..."
> >
> > In my opinion the umd shouldn't implement these kind of magic guesses, =
the
> > entire point of robustness apis is to delegate responsibility for
> > correctly recovering to the application. And the kernel is left with
> > enforcing fair resource usage policies (which eventually might be a
> > cgroups limit on how much gpu time you're allowed to waste with gpu
> > resets).
>
> Killing apps that the kernel thinks are misbehaving really doesn't
> seem like a good idea to me. What if the process is a service getting
> restarted after getting killed? What if killing that process leaves
> the system in a bad state?
>
> Can't the kernel provide some information to user space so that e.g.
> systemd can handle those situations?
>
> > > +likely in a broken loop. This is done to ensure that it does not kee=
p blocking
> > > +the user interface from being correctly displayed. This should be do=
ne even if
> > > +the app is correct but happens to trigger some bug in the hardware/d=
river.
> > > +
> > > +OpenGL
> > > +~~~~~~
> > > +
> > > +Apps using OpenGL should use the available robust interfaces, like t=
he
> > > +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL=
 ES). This
> > > +interface tells if a reset has happened, and if so, all the context =
state is
> > > +considered lost and the app proceeds by creating new ones. If it is =
possible to
> > > +determine that robustness is not in use, the UMD will terminate the =
app when a
> > > +reset is detected, giving that the contexts are lost and the app won=
't be able
> > > +to figure this out and recreate the contexts.
> > > +
> > > +Vulkan
> > > +~~~~~~
> > > +
> > > +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for subm=
issions.
> > > +This error code means, among other things, that a device reset has h=
appened and
> > > +it needs to recreate the contexts to keep going.
> > > +
> > > +Reporting causes of resets
> > > +--------------------------
> > > +
> > > +Apart from propagating the reset through the stack so apps can recov=
er, it's
> > > +really useful for driver developers to learn more about what caused =
the reset in
> > > +first place. DRM devices should make use of devcoredump to store rel=
evant
> > > +information about the reset, so this information can be added to use=
r bug
> > > +reports.
> >
> > Since we do not seem to have a solid consensus in the community about
> > non-robust userspace, maybe we could just document that lack of consens=
us
> > to unblock this patch? Something like this:
> >
> > Non-Robust Userspace
> > --------------------
> >
> > Userspace that doesn't support robust interfaces (like an non-robust
> > OpenGL context or API without any robustness support like libva) leave =
the
> > robustness handling entirely to the userspace driver. There is no stron=
g
> > community consensus on what the userspace driver should do in that case=
,
> > since all reasonable approaches have some clear downsides.
> >
> > With the s/UMD/KMD/ further up and maybe something added to record the
> > non-robustness non-consensus:
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Cheers, Daniel
> >
> >
> >
> > > +
> > >  .. _drm_driver_ioctl:
> > >
> > >  IOCTL Support on Device Nodes
> > > --
> > > 2.41.0
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> >
>
