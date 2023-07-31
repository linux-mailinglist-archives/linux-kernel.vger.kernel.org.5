Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889B769A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjGaOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjGaOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:51:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA4CE78;
        Mon, 31 Jul 2023 07:51:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-314417861b9so3867611f8f.0;
        Mon, 31 Jul 2023 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690815079; x=1691419879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAPrkbK19s/j5Zx9BvuYAYuY534VPCFu5UMSEPN+FAE=;
        b=ONefshDkN1jXMyg0wZ8QEmmAPXYcp3mA7Y4rLHbZ0B/sSm8FGewPffgqtdxTL/X1iT
         AtnNYgJ+osFjNol3DgEwCoRMsRzED9sEjdYo+XNB6jA/vpUD06z0WPGVpFwk6veFO9OU
         ibatrDvsrl3GB3m2uFuEY1sklgbBbV+M1ieeB/BLXlqQriOZZEEhJRnlTc6k3zry1pGI
         8gT4pqVcCYAqeSjkliWxyT6pMGXOg8y1USl58BKNqUR4FGu0Ju4rskBjkX0SaL4zQ9IR
         mABJjkmvgdQUqRb0sebjRifxOKcjyv4RmV6FD7aKFsKCahByl3oE/ln33nEvLUOnN/IR
         cPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815079; x=1691419879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAPrkbK19s/j5Zx9BvuYAYuY534VPCFu5UMSEPN+FAE=;
        b=EdkSzJe4WXKljAkSuv6Tp5vkScZYwp2APQQ6e98Cr/gZ/TGLmYiADEgYwRNXnImXeB
         1NBkZyx35/Es/EOuUmYt3U9hLimN4+Yc5BKYTmGNjyM4z4VPX33ICVxfTBZdjBPSExK5
         aI25fSquP9JRudKjSGgt/ZSN/fJ4BHCNzws0v3t/n5cOUGB/mIOZcPRYp3VSBLpOHCwn
         FEnaYxwWPKh6ITwnpYuLVa1jrlqV/neqqikLm71217Q50+6c1xoOjnUOH6/q9plt/wun
         hxl+dPglZ9qA55tjUARp8AjL/MDVC33jOnxb+KmLZzauRqdlwabNhGt3eEcY5vwGCmGU
         NinQ==
X-Gm-Message-State: ABy/qLZOx1f+WHqxdRaTwqlLiHDkGzooLPXnmuoe4RNYPNuS2RaAjfIv
        4bl9IWyr9i/gJYvhcm83hoqFzTKxXCFEdjSi8D4=
X-Google-Smtp-Source: APBJJlHp9CxGwet2vmvPctm3AruUc8MW3kWbH5+YX2xIIUpW5tevxLfL1O+U73H0pP1U9NLaYEZRubIxIr3M2m/csAQ=
X-Received: by 2002:adf:e752:0:b0:314:3f98:a788 with SMTP id
 c18-20020adfe752000000b003143f98a788mr58676wrn.7.1690815079341; Mon, 31 Jul
 2023 07:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAF6AEGtan-bQ7syKAwOKDY=044aKu26SLPQ0j1ieLqXNyQQS3g@mail.gmail.com>
 <282e-64c7a800-77-46253680@38053863>
In-Reply-To: <282e-64c7a800-77-46253680@38053863>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 31 Jul 2023 07:51:07 -0700
Message-ID: <CAF6AEGufEzyOygPt6-tCbSC75GSD7sOB=FHE4nNGwPre6kHuOA@mail.gmail.com>
Subject: Re: [PATCH v10] drm: Add initial ci/ subdirectory
To:     Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc:     Daniel Stone <daniel@fooishbar.org>, emma@anholt.net,
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

On Mon, Jul 31, 2023 at 5:25=E2=80=AFAM Helen Mae Koike Fornazier
<helen.koike@collabora.com> wrote:
>
> Hello all,
>
> Thanks for your comments.
>
> On Friday, July 28, 2023 11:37 -03, Rob Clark <robdclark@gmail.com> wrote=
:
>
> > On Thu, Jul 27, 2023 at 10:26=E2=80=AFPM Daniel Stone <daniel@fooishbar=
.org> wrote:
> > >
> > > On Thu, 27 Jul 2023 at 22:47, Rob Clark <robdclark@gmail.com> wrote:
> > > > > I did run into a bit of a chicken vs. egg problem with testing th=
e "in
> > > > > tree" version (compared to earlier versions which kept most of th=
e yml
> > > > > and scripts in a separate tree), is that it actually requires thi=
s
> > > > > commit to exist in the branch you want to run CI on.  My earlier
> > > > > workaround of pulling the drm/ci commit in via
> > > > > ${branchname}-external-fixes no longer works.
> > > >
> > > > After unwinding some more gitlab repo settings that were for the
> > > > previous out-of-tree yml setup, I have this working.
> > > >
> > > > Tested-by: Rob Clark <robdclark@gmail.com>
> > > > Acked-by: Rob Clark <robdclark@gmail.com>
> > >
> > > And it's also:
> > > Acked-by: Daniel Stone <daniels@collabora.com>
> > >
> > > It's been back and forth a few times by now and reviewed pretty
> > > heavily by all the people who are across the CI details. I think the
> > > next step is to answer all the workflow questions by actually getting
> > > it into trees and using it in anger. There was some discussion about
> > > whether this should come in from drm-misc, or the core DRM tree, or a
> > > completely separate pull, but I'm not sure what the conclusion was ..=
.
> > > maintainers, thoughts?
> >
> > I'd prefer a separate pull, so that I could merge it into msm-next as
> > well without having to pull in all of drm-misc
>
> Should we create a drm-ci ?

I guess we can just wait and see how often it is that drm/ci updates
need to be merged into multiple driver trees.  Hopefully most of the
drm/ci changes are just expectation file updates which should go via
driver tree.  Maybe i-g-t uprevs, if they have a lot of expectation
changes would be something drivers would want to merge into their own
tree?  But I guess we can see how it goes.

> >
> > Possibly some other driver trees would like to do similar?
> >
> > BR,
> > -R
>
> Also, please wait for v11, I have a few adjustments to make as pointer by
> some comments, and also regarding xfails list and how the configs should
> be organized (unless if you are fine merging this version and I can submi=
t
> the adjustments later).

Ok

BR,
-R

> Thanks,
> Helen
>
