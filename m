Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37878070ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378565AbjLFNbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378484AbjLFNbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:31:16 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A039AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:31:22 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db54611b920so4868915276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701869481; x=1702474281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FewHbthA5tIi/+DoNr+3p8lXbtSbIVFpc9WJQbitIjE=;
        b=f8v66MoG6F7M2rrOHZA1Lk0aM/dTPj8ltY6CATGBB4G4kX4GXQO3beb46/8xu2vINA
         QkWQISCWSGUGK8Klnmz6+zmd7YXPztnT572p0WzEaVzLvuVo7e2CpI9I57Q4/G1spvZl
         XH9ybUXB+3dpibLCn0koGZWJrg9ZdDv1CC4E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701869481; x=1702474281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FewHbthA5tIi/+DoNr+3p8lXbtSbIVFpc9WJQbitIjE=;
        b=k00FbhOa2vl7+2DmDYkgpF3YFffm3babHQT9LD3v5G2T6C+R3j8ibiT8RO9v2jFAMN
         D3z10gET6/kkfEJE/4pC9ns3h2QPRoWiGb+eImWbmG7zahU2/I3IyzX/14RicIzjAXAe
         3cHy+wtNxMj1Kg3VMj6/vdQM/mP/Rs8pbSUSpK5yQDns9h5s6xLnimtnG5tC8LRT9fqO
         ywljNDqQp1Nd5SHXKHPyKxenBy7bqqDSc7RagiXz6FAKHqgXyfkGLpUMunvxmfalC8Zo
         YU0EEEhg84u4l3oMR/4PFer+8aC7KymL38EvBhl3fkZFnKmA5ycB43IwUy6mne30PeVn
         HxDw==
X-Gm-Message-State: AOJu0YxSU7rzNMbTRAI5ZI+XgQYjVZ3PJbtzSE5DSrQURVaI8l2PSsQW
        /FUsUOD8fM+0xfaiAgUTJwlCMWo3EiUh0UGpLy26EQ==
X-Google-Smtp-Source: AGHT+IGkU1/QHUGepldrjZH1LMdVc1asZvayNB5NfRB3ai5lxSqWKfAcrwb0/nHUGw2DBbJuz0gdjyFX582NfXzVXRI=
X-Received: by 2002:a25:260c:0:b0:db5:483d:b4f3 with SMTP id
 m12-20020a25260c000000b00db5483db4f3mr637943ybm.36.1701869481167; Wed, 06 Dec
 2023 05:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
 <20231205105341.4100896-3-dario.binacchi@amarulasolutions.com>
 <CAPY8ntAALKiTEG6qyFO=qVqSLUW9x8AMfPMc_TUwC3z8tJ7Kzw@mail.gmail.com> <CABGWkvq-fJTDFPB=389XbHW_SLt6BQr-BhjZqZ+01i3v8EaYwA@mail.gmail.com>
In-Reply-To: <CABGWkvq-fJTDFPB=389XbHW_SLt6BQr-BhjZqZ+01i3v8EaYwA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 6 Dec 2023 19:01:10 +0530
Message-ID: <CAMty3ZBdCW=Rak8gMin8bt9JnFChAu6nw9n6xQyCSZw=63BukA@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] drm/bridge: Fix a use case in the bridge disable logic
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
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

Hi Dario,

On Wed, Dec 6, 2023 at 6:57=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Hi Dave and Jagan,
>
> On Tue, Dec 5, 2023 at 4:39=E2=80=AFPM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Dario
> >
> > On Tue, 5 Dec 2023 at 10:54, Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> > >
> > > The patch fixes the code for finding the next bridge with the
> > > "pre_enable_prev_first" flag set to false. In case this condition is
> > > not verified, i. e. there is no subsequent bridge with the flag set t=
o
> > > false, the whole bridge list is traversed, invalidating the "next"
> > > variable.
> > >
> > > The use of a new iteration variable (i. e. "iter") ensures that the v=
alue
> > > of the "next" variable is not invalidated.
> >
> > We already have https://patchwork.freedesktop.org/patch/529288/ that
> > has been reviewed (but not applied) to resolve this. What does this
> > version do differently and why?
>
> My patches only affect drm_atomic_bridge_chain_post_disable(), whereas
> Jagan's patch affects both
> drm_atomic_bridge_chain_post_disable() and drm_atomic_bridge_chain_pre_en=
able().
> I tested Jagan's patch on my system with success and I reviewed with
> Michael Trimarchi the
> drm_atomic_bridge_chain_pre_enable() fixing and we think it's okay.
> We also believe that our changes to post_disable() are better, as we
> set the 'next' variable only when required,
> and the code is more optimized since the list_is_last() is not called
> within the loop.
> Would it be possible to use Jagan's patch for fixing
> drm_atomic_bridge_chain_pre_enable() and mine for
> fixing drm_atomic_bridge_chain_post_disable()?
>

Can you please share the post-disabled bridge chain list with the
below example before and after your change?

Example:
- Panel
- Bridge 1
- Bridge 2 pre_enable_prev_first
- Bridge 3
- Bridge 4 pre_enable_prev_first
- Bridge 5 pre_enable_prev_first
- Bridge 6
- Encoder

Thanks,
Jagan.
