Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078D8110A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378277AbjLML7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjLML7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:59:12 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6170CB0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:59:18 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-dbccb65cff1so645127276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702468757; x=1703073557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyXRP+lDcGUWL91uKJAg/CGQD1HLIoJn9slNttkFTJM=;
        b=YuE7FGJSEwLA3kBdRQucpF/5UV6+KVePgeqWrojgDTQeYPotGdTwaKSixDU9G7M2k/
         nnGGB8EuIHQV74Ldrgbv13z1uF6Nd0nq8LL7ApbP9qpLEBy4vC1wkMBr0ZvSe5Dyf/Go
         mAw3xXqTmpUGzLo0LU2pVV+zBiSxP6W6ygd4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702468757; x=1703073557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyXRP+lDcGUWL91uKJAg/CGQD1HLIoJn9slNttkFTJM=;
        b=Pk1zMjOgspTL5XlxjzZtgegCze/BXuxEBO4F3mIxGZXJieo1VW/tDe0bPTBDzJFWki
         jTZtbGlzC3CIkXqPox3SULYbFk6JB+nVlVZKcaJ5WDbnX0Kob++nXPe5jV/RqFHoEcCl
         gX8Ng3/i44HA81cMTX7cXXNinECJsYmwk64GStF5sFkchPTQUcSzqNUgAV14GfDXyXNL
         GtyuK6nlUJpXgNPobPCKmHTVoygT+uYh14YQ393R/mSh+fcl24a/H+3BIiYJKU6WGt3V
         IfL5KDc5WTkIbteATT/QQvZRN4aMCOyDSpeMbNoNR8X7xZKzz3GL4UK87ktKmoJbyLq/
         otGQ==
X-Gm-Message-State: AOJu0YzKEGtnfgndz1awSRgwYMlfWZmiXIolBzbFcfU9RsKpkoWOyNYn
        VqHbIhEtCZH7Art9xDT0WejaxktJzTdXnicmqSB3cg==
X-Google-Smtp-Source: AGHT+IG/lGV3GLi5A77Pfj4Ksef7IAyWSzeuqOeDzG9y2WMz47wgsLwB0I4+VhFxi9w+BAa2/xBNS9Qr1EbIeeDX7eE=
X-Received: by 2002:a25:bec5:0:b0:dbc:ad3b:f751 with SMTP id
 k5-20020a25bec5000000b00dbcad3bf751mr2967257ybm.34.1702468757529; Wed, 13 Dec
 2023 03:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
 <20231205105341.4100896-3-dario.binacchi@amarulasolutions.com>
 <CAPY8ntAALKiTEG6qyFO=qVqSLUW9x8AMfPMc_TUwC3z8tJ7Kzw@mail.gmail.com>
 <CABGWkvq-fJTDFPB=389XbHW_SLt6BQr-BhjZqZ+01i3v8EaYwA@mail.gmail.com>
 <CAMty3ZBdCW=Rak8gMin8bt9JnFChAu6nw9n6xQyCSZw=63BukA@mail.gmail.com> <CAOf5uwm_YmXz0A6nuCbJh+iszwqWyQkRRKATKyWZ33YUgZmEnw@mail.gmail.com>
In-Reply-To: <CAOf5uwm_YmXz0A6nuCbJh+iszwqWyQkRRKATKyWZ33YUgZmEnw@mail.gmail.com>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 13 Dec 2023 12:59:05 +0100
Message-ID: <CABGWkvpryv=bKsro1=6AG9kH9mU63JdWkG4xyyKvr_Rq0iADHg@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] drm/bridge: Fix a use case in the bridge disable logic
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan and Dave,

On Wed, Dec 6, 2023 at 2:57=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Jagan
>
> On Wed, Dec 6, 2023 at 2:31=E2=80=AFPM Jagan Teki <jagan@amarulasolutions=
.com> wrote:
> >
> > Hi Dario,
> >
> > On Wed, Dec 6, 2023 at 6:57=E2=80=AFPM Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> > >
> > > Hi Dave and Jagan,
> > >
> > > On Tue, Dec 5, 2023 at 4:39=E2=80=AFPM Dave Stevenson
> > > <dave.stevenson@raspberrypi.com> wrote:
> > > >
> > > > Hi Dario
> > > >
> > > > On Tue, 5 Dec 2023 at 10:54, Dario Binacchi
> > > > <dario.binacchi@amarulasolutions.com> wrote:
> > > > >
> > > > > The patch fixes the code for finding the next bridge with the
> > > > > "pre_enable_prev_first" flag set to false. In case this condition=
 is
> > > > > not verified, i. e. there is no subsequent bridge with the flag s=
et to
> > > > > false, the whole bridge list is traversed, invalidating the "next=
"
> > > > > variable.
> > > > >
> > > > > The use of a new iteration variable (i. e. "iter") ensures that t=
he value
> > > > > of the "next" variable is not invalidated.
> > > >
> > > > We already have https://patchwork.freedesktop.org/patch/529288/ tha=
t
> > > > has been reviewed (but not applied) to resolve this. What does this
> > > > version do differently and why?
> > >
> > > My patches only affect drm_atomic_bridge_chain_post_disable(), wherea=
s
> > > Jagan's patch affects both
> > > drm_atomic_bridge_chain_post_disable() and drm_atomic_bridge_chain_pr=
e_enable().
> > > I tested Jagan's patch on my system with success and I reviewed with
> > > Michael Trimarchi the
> > > drm_atomic_bridge_chain_pre_enable() fixing and we think it's okay.
> > > We also believe that our changes to post_disable() are better, as we
> > > set the 'next' variable only when required,
> > > and the code is more optimized since the list_is_last() is not called
> > > within the loop.
> > > Would it be possible to use Jagan's patch for fixing
> > > drm_atomic_bridge_chain_pre_enable() and mine for
> > > fixing drm_atomic_bridge_chain_post_disable()?
> > >
> >
> > Can you please share the post-disabled bridge chain list with the
> > below example before and after your change?
>
> We have already git commit the description in how the patch affects
> the post_disable. As Dario
> reported your patch is ok even in our use case. We don't have a real
> use case as the one you describe.
>
> Can we know how you test it in this use case here? Can you test our
> patches of post_disable?
>
> Thanks
> Michael
>
> >
> > Example:
> > - Panel
> > - Bridge 1
> > - Bridge 2 pre_enable_prev_first
> > - Bridge 3
> > - Bridge 4 pre_enable_prev_first
> > - Bridge 5 pre_enable_prev_first
> > - Bridge 6
> > - Encoder
> >
> > Thanks,
> > Jagan.

Starting from my use case:

# cat /sys/kernel/debug/dri/32e00000.lcdif/bridge_chains
encoder[36]
bridge[0] type: 16, ops: 0x0, OF:
/soc@0/bus@32c00000/dsi@32e10000:fsl,imx8mn-mipi-dsim
bridge[1] type: 16, ops: 0x8, OF:
/soc@0/bus@32c00000/dsi@32e10000/panel@0:sharp,ls068b3sx0

I developed a pass through MIPI-DSI bridge driver to try to test your case:
# cat /sys/kernel/debug/dri/32e00000.lcdif/bridge_chains
encoder[36]
bridge[0] type: 16, ops: 0x0, OF:
/soc@0/bus@32c00000/dsi@32e10000:fsl,imx8mn-mipi-dsim
bridge[1] type: 16, ops: 0x0, OF: /pt_mipi_dsi1:amarula,pt-mipi-dsi
bridge[2] type: 16, ops: 0x0, OF: /pt_mipi_dsi2:amarula,pt-mipi-dsi
bridge[3] type: 16, ops: 0x0, OF: /pt_mipi_dsi3:amarula,pt-mipi-dsi
bridge[4] type: 16, ops: 0x0, OF: /pt_mipi_dsi4:amarula,pt-mipi-dsi
bridge[5] type: 16, ops: 0x0, OF: /pt_mipi_dsi5:amarula,pt-mipi-dsi
bridge[6] type: 16, ops: 0x8, OF: /pt_mipi_dsi5/panel@0:sharp,ls068b3sx02

The pre_enable_prev_first flag is set through the
"amarula,pre_enable_prev_first" dts property I put
in my dts.
Your and my patches give the same results (result: OK) in both your
use case and mine.
But If I test my new "enlarged" use case:

- Encoder
- bridge[0] (samsung-dsim)
- bridge[1] pre_enable_prev_first
- bridge[2] pre_enable_prev_first
- bridge[3] pre_enable_prev_first
- bridge[4] pre_enable_prev_first
- bridge[5] pre_enable_prev_first
- bridge[6] pre_enable_prev_first (Panel)

the result is:
my patches: KO
your patch: OK

So, I will remove my patches from the series.

Can the driver I implemented to test the use cases (pass through
MIPI-DSI) be considered useful for testing these
bridge pipelines?
Does it make sense to send its patch?

Thanks and regards
Dario

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
