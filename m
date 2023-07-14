Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8882E75404F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjGNRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjGNRRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:17:06 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA01BF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:17:04 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-48168bbffbfso422226e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1689355024; x=1691947024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPkTDTNfOApHatP9lNZWj31zOJzwMg7NBxlcg43JW0A=;
        b=YJZ5856Wzct0W9OUT10Qr4DLI5UVwZNjb5sCCL+c4HA879k/1jjcx6Sqn3Pywy8Al3
         0MCtvdFfjgZ3JkmXgE9eilx7iKZU9vy2GL2Ia0aZUzEDNhmPkyVrBwps6B38KBgw7dpC
         ep3tvD5QGa2oGOOuZyX8f45fEit68XSGrz3AeTX1GAYMZEVK1LCvzdeCsyRHL55IycrX
         GLbDNA30Egw51BpH3JwWmvqSKExUMe4fvk84+lUWWDiE4E7HeRlVsyuD3dJ85QFG38PG
         UBg4cl8FtIeEgSYFf+PxULkyyZ4lCswJ5C6TGZ2CqcPtpogwQiOu/laZJqGlZp95X+TK
         SGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355024; x=1691947024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPkTDTNfOApHatP9lNZWj31zOJzwMg7NBxlcg43JW0A=;
        b=Xvuyo9MIhNAOHui0w9ICQHAmA1ETouqqHiBIxInUXUXhcysDKt1CwPQqzN0dMbg0pt
         lomHsJhM/SXfl3eJeXxoXX0bPncDR5982vr9jEqGjOvah4RsujDrQgboPdHdJ5CqbRcn
         a4fJJya5edaG7az3Qxainc/gvEcr3C6abHcWr6035nl+YLz13iYbx55MbF7aAk3cWfyH
         tP8+UiuIKXxMrknMNOGB0dmf/i9aQ1SGB9MRPFOfgbmZqMxsEmEiHyW7eix6IgXUG00K
         51aeOA9iQ6Js4WHW0ykAxQnc74FxzKetEinM2UtxDrWSCT7y6u9AH8YABr78hf2JgyVS
         1TQg==
X-Gm-Message-State: ABy/qLZl4/tvZ4x65k04dQJDtUEcIAKDMssnBreX5Pb4B5iPWHjNjIfI
        zx77OfA/LV0rQep6AliibT1Xta57+WOJMFjSHcoAcw==
X-Google-Smtp-Source: APBJJlF68nyBZQWjjKu6x2+WknZa+vyhroJilqDKSdVZZiJZNfDJ12qlqrbIltEhVmePfALAAyvocnnQfRhMzKvR9nY=
X-Received: by 2002:a1f:d045:0:b0:47e:8a9:478c with SMTP id
 h66-20020a1fd045000000b0047e08a9478cmr2987555vkg.16.1689355023876; Fri, 14
 Jul 2023 10:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230707190020.6280-2-vladimir.lypak@gmail.com> <7c4affcb-bcb4-5f4b-cc2f-bed2cad9de71@kontron.de>
In-Reply-To: <7c4affcb-bcb4-5f4b-cc2f-bed2cad9de71@kontron.de>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 14 Jul 2023 18:16:47 +0100
Message-ID: <CAPY8ntBWmfDPwPJS_z5tko7PUxHG9pVQ1DOKC3baGDCNzMzykw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/bridge: Fix handling of bridges with
 pre_enable_prev_first flag
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Vladimir Lypak <vladimir.lypak@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder

On Mon, 10 Jul 2023 at 08:46, Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 07.07.23 21:00, Vladimir Lypak wrote:
> > [Sie erhalten nicht h=C3=A4ufig E-Mails von vladimir.lypak@gmail.com. W=
eitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.=
ms/LearnAboutSenderIdentification ]
> >
> > In function drm_atomic_bridge_chain_post_disable handling of
> > pre_enable_prev_first flag is broken because "next" variable will alway=
s
> > end up set to value of "bridge". This breaks loop which should disable
> > bridges in reverse:
> >
> >  next =3D list_next_entry(bridge, chain_node);
> >
> >  if (next->pre_enable_prev_first) {
> >         /* next bridge had requested that prev
> >          * was enabled first, so disabled last
> >          */
> >         limit =3D next;
> >
> >         /* Find the next bridge that has NOT requested
> >          * prev to be enabled first / disabled last
> >          */
> >         list_for_each_entry_from(next, &encoder->bridge_chain,
> >                                  chain_node) {
> > // Next condition is always true. It is likely meant to be inversed
> > // according to comment above. But doing this uncovers another problem:
> > // it won't work if there are few bridges with this flag set at the end=
.
> >                 if (next->pre_enable_prev_first) {
> >                         next =3D list_prev_entry(next, chain_node);
> >                         limit =3D next;
> > // Here we always set next =3D limit =3D branch at first iteration.
> >                         break;
> >                 }
> >         }
> >
> >         /* Call these bridges in reverse order */
> >         list_for_each_entry_from_reverse(next, &encoder->bridge_chain,
> >                                          chain_node) {
> > // This loop never executes past this branch.
> >                 if (next =3D=3D bridge)
> >                         break;
> >
> >                 drm_atomic_bridge_call_post_disable(next, old_state);
> >
> > In this patch logic for handling the flag is simplified. Temporary
> > "iter" variable is introduced instead of "next" which is used only
> > inside inner loops.
> >
> > Fixes: 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to al=
ter bridge init order")
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>
> I haven't had a chance to look at this, but I still want to reference
> another patch by Jagan that intends to fix some bug in this area:
>
> https://patchwork.kernel.org/project/dri-devel/patch/20230328170752.11023=
47-1-jagan@amarulasolutions.com/
>
> +Cc: Jagan
>
> Dave, as you introduced this feature, did you have a chance to look at
> Jagan's and Vladimir's patches?

Sorry, they'd fallen off my radar.
I'm having a look at the moment, but will probably need to carry it
over to Monday.

  Dave
