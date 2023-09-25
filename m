Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95537AE1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjIYWyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:54:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7240A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:54:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso1599977a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695682441; x=1696287241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDlt8685IO8EfILel9/XklmeSwJWvdU7kfcz0SQh0FU=;
        b=ZXgPygvEB7wgRoLt7fFyMeQPzEf6+OurFXUC+J0Awl6AlIbKWlIFC+9TGGKSaUrCSo
         DTEeMC8X2kKHM8pdkYgF54JB/v0axj+BNVIORX/jS0s3oeHtZtgDuR0qiwgc0hi3C7vv
         wGQaelEQu5OtVpzgAYIN8jNyui7SNAWqPgK08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695682441; x=1696287241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDlt8685IO8EfILel9/XklmeSwJWvdU7kfcz0SQh0FU=;
        b=cx8J7IVar2+0liUyWBdAOqDL5cZtSU4zYhoeMLOpKd4+Q7lOj1ekZ/M6am5CHOTTPp
         5eOUohL9i6c983Ph1amRptsmm1amzsUng6wttRCUEdPHeoEea43pXA92XK2SsGP8BWiY
         94+NdRbM07nr4+txfWwRx+r+g1tTLIuCvUmhi/xP0vHUfuqK6g7OaTC7Tj6vpBtF2YG6
         +r59jx4vWFm00i6ltZq/Dnx7TROHN+o3d1kLuRmEtiKgsfFJI1FIl8PXLm9bbnbh+uLi
         E64cEsw13QwKrjk6i1rNOXD7pX4n3JQLpY5uf7IZS5mEad5AcQzLchPHGyV3GckcHpav
         WfIQ==
X-Gm-Message-State: AOJu0YztLnUeoUW3Q0XEg8v2lUQ2sPfSJaZ5naX+5/1/IDyeiIdYCL4G
        AsNGiHe187GAEU5okLjoKWngIEqIWB2mkTZkb8j5G4FB
X-Google-Smtp-Source: AGHT+IE6+9/oMorIzbeksu6Nj31MTuUvnSmgudOspoCkBuhBzNRwvrWekmFd5voDECq+cvcSMuVlDA==
X-Received: by 2002:a05:6402:b33:b0:523:33eb:1103 with SMTP id bo19-20020a0564020b3300b0052333eb1103mr7164515edb.14.1695682441259;
        Mon, 25 Sep 2023 15:54:01 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7d443000000b0052576969ef8sm5989808edr.14.2023.09.25.15.54.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 15:54:00 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53317e29b00so7892a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:54:00 -0700 (PDT)
X-Received: by 2002:a50:c04f:0:b0:525:573c:643b with SMTP id
 u15-20020a50c04f000000b00525573c643bmr16866edd.7.1695682440096; Mon, 25 Sep
 2023 15:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.1.I134336fce7eac5a63bdac46d57b0888858fc8081@changeid>
 <20230922075610.ekrzyz6hfcd3rjsm@fsr-ub1664-121.ea.freescale.net>
 <CAD=FV=ViV-n2T1Bup+XScsWD11yWpTmW3qEOLTTDj3kTtTY4Cg@mail.gmail.com> <20230925054710.r3guqn5jzdl4giwd@fsr-ub1664-121.ea.freescale.net>
In-Reply-To: <20230925054710.r3guqn5jzdl4giwd@fsr-ub1664-121.ea.freescale.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Sep 2023 15:53:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSzVx2aoTshrh-ZmaQ-uFqhzw6iZPSBzmeMenjvTs2Zw@mail.gmail.com>
Message-ID: <CAD=FV=XSzVx2aoTshrh-ZmaQ-uFqhzw6iZPSBzmeMenjvTs2Zw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 01/12] drm/imx/dcss: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 24, 2023 at 10:47=E2=80=AFPM Laurentiu Palcu
<laurentiu.palcu@oss.nxp.com> wrote:
>
> Hi Doug,
>
> On Fri, Sep 22, 2023 at 08:44:16AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Sep 22, 2023 at 12:56=E2=80=AFAM Laurentiu Palcu
> > <laurentiu.palcu@oss.nxp.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Sep 21, 2023 at 12:26:44PM -0700, Douglas Anderson wrote:
> > > > Based on grepping through the source code this driver appears to be
> > > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > > time. Among other things, this means that if a panel is in use that=
 it
> > > > won't be cleanly powered off at system shutdown time.
> > > >
> > > > The fact that we should call drm_atomic_helper_shutdown() in the ca=
se
> > > > of OS shutdown/restart comes straight out of the kernel doc "driver
> > > > instance overview" in drm_drv.c.
> > > >
> > > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > No issues found on i.MX8MQ.
> > >
> > > Tested-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> >
> > Thanks! Would you expect this patch to land through drm-misc? If so,
> > I'm happy to commit it there with your tags.
>
> Yes, please do. The i.MX8MQ DCSS patches go through drm-misc.

OK, landed in drm-misc-next:

89755ee1d593 drm/imx/dcss: Call drm_atomic_helper_shutdown() at shutdown ti=
me


> > If patches to this driver normally flow through drm-misc, I'm also
> > happy to post a patch to MAINTAINERS (or review a patch you post)
> > adding this to the entry for "NXP i.MX 8MQ DCSS DRIVER":
> >
> > T:     git git://anongit.freedesktop.org/drm/drm-misc
> >
> > ...which would make it obvious in the future that things should land
> > through drm-misc.
>
> Thanks, that sounds good.

https://lore.kernel.org/r/20230925154929.1.I3287e895ce8e68d41b458494a49a1b5=
ec5c71013@changeid
