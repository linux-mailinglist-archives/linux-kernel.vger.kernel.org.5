Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030ED76EE45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjHCPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjHCPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:36:36 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B621430F8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:36:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d16639e16e6so1103143276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691076995; x=1691681795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0RiJFEC2TyWpgAWWlJd3Y77KTp5pRBuPs5ibASU4PI=;
        b=msm0BrH5ifzTm01PEG8loMj+Dv1GrOKfhgu/XSIx1g+nFlN4UO80QOmhBgbUGHLOET
         maNjsAY+vGJJgwH/4V+q274S7lxVJ/o1g++CATTAcBMW68NExx464ohZxTreY1fYRZL9
         JbA/OcyXEEyywWi2COfWs6+oNKRJ06biZaviM8/KGRJfrpmWZWNddjeqEDPGvdDyXIdq
         onfSG/O6E5wBSjEE4dpknFYoFiabzYeUYTekvYoYg1mkfzN879EnqlJ1Z25Iul8WbTXR
         7wEeb8bfakbUlapSQzWb7Twa/r6JvEBEYvwDEoi+KyEk7sG3EuSL9+cYm2WtLuKINiY3
         2wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076995; x=1691681795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0RiJFEC2TyWpgAWWlJd3Y77KTp5pRBuPs5ibASU4PI=;
        b=G5KAYWVXmBJh/BxbEYydbwO1wXLUFZBVu99jYblg+b4awyXd4S5OOS/4FTtiK9UyjE
         QCCChQxG5ZJ+sYHVvxl+MvzHFxBdnROQkqt3oB1oT/EzQD665ZDfTf8FjfqQ0cKgOJva
         8fGLjVyivgTC9JFAEqrkTrNEIL/BeJJu+LvVvSB348iR4kSGwge+qUD/d0RKQgsUA+q0
         BdJi0HAbmKTB+2bXCt0rOMcvoXNSgDMfumLEtaxd5yq4p0IxlUsFxCsRDqGMbNnpCUTA
         YD7v1a49JUVy6M9jYWxPZyLruNRAYB/Se59EQkJGvWgBOffFVOn0Ij5tHXgg2Akc+467
         qpYg==
X-Gm-Message-State: ABy/qLYs4ObGn6WVunDA1hs+xJpmgoDNEpHCbaxI6LfKHlvU9rkPpjkU
        ZVA1brzGaAQcM7Q84bJ2hY5FKKMlsyywDxRJavb4UA==
X-Google-Smtp-Source: APBJJlFYQquHXzrsKhhJGfCCxFrZ+hdH5p9FtN6ueneVgQ9/HLwNKPKeUcb1fuSTmM6kdAbJLQt1skEwUHmvVNRluF4=
X-Received: by 2002:a25:738f:0:b0:d04:caf3:261e with SMTP id
 o137-20020a25738f000000b00d04caf3261emr16385250ybc.53.1691076994786; Thu, 03
 Aug 2023 08:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org> <20230802185547.GC32500@pendragon.ideasonboard.com>
 <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org> <20230802191351.GA1407@pendragon.ideasonboard.com>
 <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org> <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr>
 <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr>
In-Reply-To: <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Aug 2023 18:36:23 +0300
Message-ID: <CAA8EJppCECObEe5UG3LsHUsmYfKzakWzVw33S4nVc=DB9sA0ig@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
To:     Simon Ser <contact@emersion.fr>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
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

On Thu, 3 Aug 2023 at 18:31, Simon Ser <contact@emersion.fr> wrote:
>
> On Thursday, August 3rd, 2023 at 17:22, Simon Ser <contact@emersion.fr> w=
rote:
>
> > The KMS docs describe "subconnector" to be defined as "downstream port"=
 for DP.
> > Can USB-C (or USB) be seen as a DP downstream port?
>
> To expand on this a bit: I'm wondering if we're mixing apples and
> oranges here. The current values of "subconnector" typically describe
> the lower-level protocol tunneled inside DP. For instance, VGA can be
> tunneled inside the DP cable when using DP =E2=86=92 VGA adapter.

My opinion hasn't changed: I think this should be the USB connector
with proper DP / DVI / HDMI / etc. subconnector type (or lack of it).
In the end, the physical connector on the side of laptop is USB-C.

If we want to make it different from GUD, we might want to define a
USB-DP connector type (which would also include SlimPort).

>
> However, in the USB-C case, DP itself is tunneled inside USB-C. And you
> might use a USB-C =E2=86=92 DP adapter. So it's not really *sub*connector=
, it's
> more of a *super*connector, right?
>
> I think [1] is somewhat related, since it also allows user-space to
> discover whether a connector uses USB-C. But relying on sysfs to figure
> this out isn't super optimal perhaps.
>
> [1]: https://lore.kernel.org/dri-devel/20221108185004.2263578-1-wonchung@=
google.com/



--=20
With best wishes
Dmitry
