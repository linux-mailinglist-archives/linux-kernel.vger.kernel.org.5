Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A0766F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjG1Ohs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjG1Ohq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:37:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EEE3C24;
        Fri, 28 Jul 2023 07:37:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso3848262e87.1;
        Fri, 28 Jul 2023 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690555064; x=1691159864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoBzPwja36fkGB2m2EIbRi55n5XYr4VNaYPCpY7zeKs=;
        b=mH17P6vfTfQdoT14pC3A4FfDJ2VBrkghAG4nBuM7YP9r7FzJpwrAFXB5UMTvtqhF40
         XHnTn9QeyjMKGzDXjQG0c4Tthbnl8t35Fbo4n0fUp5eVbJ8S11AC+mfrG/aPvVGubjpv
         jcunb7H8In7x+NbtE3ATP0FXQh2giufFWcsNZQpuzRCASB4ZZzp/+9+VsRFyxq7TerlQ
         B+DbL/+fE4gdv7uvDxokIcRTP7edsXWY1QHw87YUGF1qk1FfE0wcZmB6VBIGvlKbqDz5
         HQ1cwr6QXDanyk/pTVPTws4QTPAuqgF5F7qbF5rszCMz9nMXITHPXWMZeujKdSciAojn
         hIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555064; x=1691159864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoBzPwja36fkGB2m2EIbRi55n5XYr4VNaYPCpY7zeKs=;
        b=l9e5FwHvTOMXcKdiekO7vWTS3MvKOAJXB+CSd15W0VQ3DFIigq/4TSaUFLXmfrJdKz
         LBNnHhXnolxI0JSfowCkvSFo/K3GvlTS7y3479V3Y884eHeuPgw0BtawIrfl/FD5xfYt
         DAst7MJy+B9CfjNN8LQDiwbOmFcriMYUpUwdBMXiKCN6AXjulzCcHJ49dJUQmTygQVpK
         1xN19LGiztr1aVKnK2ENvLnuT590EOdK4TonePvag3cI1CXLanimKv6oj9Hqo/URQ/cS
         PfRhtoB5fSJ4mhCiO6Bf0qcmiSLInW7oOBIpezTJ8xvSi9UbrgYN0157+yGPwvyw7vg3
         /GYw==
X-Gm-Message-State: ABy/qLZ8F4r0/jQy5FD6qy0wphnZQMjtq92Yx64J0NmGt7Ca48ZAofQN
        HAgNkD0XAh7XK7sNJExwgZ+iFUbUv75Y4+2gZrE=
X-Google-Smtp-Source: APBJJlGUbR0qC9paIuIRHruH4iJ3Oi11S/UE+z1ge7FEfFZqlKQmVxkAQlUoMKoxelzsZCTu0j9nGxem/4l8cRw0JdU=
X-Received: by 2002:a05:6512:2083:b0:4fd:f590:1ff7 with SMTP id
 t3-20020a056512208300b004fdf5901ff7mr1806954lfr.40.1690555063602; Fri, 28 Jul
 2023 07:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230720152737.102382-1-helen.koike@collabora.com>
 <CAF6AEGtXL5vjp3Uup6Mk19MiY8E26-tpyXVmxXYhMd3fiadykQ@mail.gmail.com>
 <CAF6AEGsxLg4og1EkCdno6P8x31KK=rJfmerJa8uMeNR-n7RVRg@mail.gmail.com> <CAPj87rPNyJ=mX1Um6yaN_jTV2gH5MhMxr3mnSb7=nB7NEOf2Ag@mail.gmail.com>
In-Reply-To: <CAPj87rPNyJ=mX1Um6yaN_jTV2gH5MhMxr3mnSb7=nB7NEOf2Ag@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 28 Jul 2023 07:37:31 -0700
Message-ID: <CAF6AEGtan-bQ7syKAwOKDY=044aKu26SLPQ0j1ieLqXNyQQS3g@mail.gmail.com>
Subject: Re: [PATCH v10] drm: Add initial ci/ subdirectory
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Helen Koike <helen.koike@collabora.com>, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        jbrunet@baylibre.com, robdclark@google.com, corbet@lwn.net,
        khilman@baylibre.com, sergi.blanch.torne@collabora.com,
        gustavo.padovan@collabora.com, linux-rockchip@lists.infradead.org,
        daniels@collabora.com, martin.blumenstingl@googlemail.com,
        mripard@kernel.org, anholt@google.com,
        linux-mediatek@lists.infradead.org, robclark@freedesktop.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de, Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
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

On Thu, Jul 27, 2023 at 10:26=E2=80=AFPM Daniel Stone <daniel@fooishbar.org=
> wrote:
>
> On Thu, 27 Jul 2023 at 22:47, Rob Clark <robdclark@gmail.com> wrote:
> > > I did run into a bit of a chicken vs. egg problem with testing the "i=
n
> > > tree" version (compared to earlier versions which kept most of the ym=
l
> > > and scripts in a separate tree), is that it actually requires this
> > > commit to exist in the branch you want to run CI on.  My earlier
> > > workaround of pulling the drm/ci commit in via
> > > ${branchname}-external-fixes no longer works.
> >
> > After unwinding some more gitlab repo settings that were for the
> > previous out-of-tree yml setup, I have this working.
> >
> > Tested-by: Rob Clark <robdclark@gmail.com>
> > Acked-by: Rob Clark <robdclark@gmail.com>
>
> And it's also:
> Acked-by: Daniel Stone <daniels@collabora.com>
>
> It's been back and forth a few times by now and reviewed pretty
> heavily by all the people who are across the CI details. I think the
> next step is to answer all the workflow questions by actually getting
> it into trees and using it in anger. There was some discussion about
> whether this should come in from drm-misc, or the core DRM tree, or a
> completely separate pull, but I'm not sure what the conclusion was ...
> maintainers, thoughts?

I'd prefer a separate pull, so that I could merge it into msm-next as
well without having to pull in all of drm-misc

Possibly some other driver trees would like to do similar?

BR,
-R
