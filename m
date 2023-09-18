Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8A7A478D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbjIRKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241170AbjIRKsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:48:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B21B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:48:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34fc7f51441so8100085ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695034089; x=1695638889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11o+CB6BjJCUVYOY4jdnDbQOvIN+SebUJmbfTwlkwtE=;
        b=RFZxy3vXJ6tjw3VVolbsrVSwfpSUQZa6o7TCcpwofO1DgKNFOmLBp3IhRPqCedVhvG
         ahOJD7EvqD4f/0+ErY+nlwFBI0rUi8MMb7qKxfVVe63t1RXMW85o+NGnIItVTKfBXlYr
         P1JBlXPnsRCrK1T6epsGYpnSRQOB+2v485K7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034089; x=1695638889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11o+CB6BjJCUVYOY4jdnDbQOvIN+SebUJmbfTwlkwtE=;
        b=NJcfMxuMxPmj6VmUftztzJP6nzq+M+xZaZBHX8Ozw1yYW6JFQQMITFwDA5AsYLFMVn
         54ioB4RshttygEOdAfoeKeo4x3Aani8iusLGH39KihS2H94DX1qc6iojNYTRSOMchWPw
         xTJizvwwdpUKnEfzooQ0YbZd/MoGIV6TmncoO6vBJ77eb7ajHkeI/S1JN296opPuWWUA
         1vg+qofdTNmWW76nCo6ZYMrLQ9gKIqfTz26SsioLfuxUpDxQx0b/3JGlvMiPnl4LZCN2
         kF0t24F1Vta3cEbcKosvrQHjUawPCk9I0EQeiULAjRIYLRLqaJTtz+eSZCHVVUwW1vA/
         hWig==
X-Gm-Message-State: AOJu0YzW906z9AoBjSVX+KqjSKdYF7lOvZbCMaO23h46kaqG7bJjC4rl
        ZbZsQz8rdlmu2KQHcRTUYlFpFgPBSJHUASY8ex4IAg==
X-Google-Smtp-Source: AGHT+IHHXY55uBLRcP570zPJDwVI/dbnejliUKJly5ts+po/aM4PFZjQw4lYauKzRX/yoR9j2WkW8Q==
X-Received: by 2002:a92:c26b:0:b0:346:8b4:34c with SMTP id h11-20020a92c26b000000b0034608b4034cmr11205385ild.16.1695034089004;
        Mon, 18 Sep 2023 03:48:09 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id b9-20020a056e020c8900b0034e1092bccfsm3001656ile.80.2023.09.18.03.48.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 03:48:06 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7983b202929so165480139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:48:06 -0700 (PDT)
X-Received: by 2002:a5e:9804:0:b0:780:ce72:ac55 with SMTP id
 s4-20020a5e9804000000b00780ce72ac55mr10973227ioj.10.1695034085996; Mon, 18
 Sep 2023 03:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230822132646.9811-1-jason-jh.lin@mediatek.com> <5a4a0d12-d16a-0836-f6c5-6e6c2f3a9097@collabora.com>
In-Reply-To: <5a4a0d12-d16a-0836-f6c5-6e6c2f3a9097@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 18 Sep 2023 18:47:28 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng8033sSGNFYr1vYfYfHbdG0Dk_0xai08=uomGO-EN66A@mail.gmail.com>
Message-ID: <CAC=S1ng8033sSGNFYr1vYfYfHbdG0Dk_0xai08=uomGO-EN66A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Add spinlock for setting vblank event in atomic_begin
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Wed, Sep 13, 2023 at 4:35=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 22/08/23 15:26, Jason-JH.Lin ha scritto:
> > Add spinlock protection to avoid race condition on vblank event
> > between mtk_drm_crtc_atomic_begin() and mtk_drm_finish_page_flip().
> >
>
> Hello Jason,
>
> Can you please provide more information about this race condition?
> (check below)
>
> > Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8=
173.")
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/=
mediatek/mtk_drm_crtc.c
> > index d40142842f85..128a672fe3c9 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -746,6 +746,9 @@ static void mtk_drm_crtc_atomic_begin(struct drm_cr=
tc *crtc,
> >                                                                        =
 crtc);
> >       struct mtk_crtc_state *mtk_crtc_state =3D to_mtk_crtc_state(crtc_=
state);
> >       struct mtk_drm_crtc *mtk_crtc =3D to_mtk_crtc(crtc);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&crtc->dev->event_lock, flags);
> >
> >       if (mtk_crtc->event && mtk_crtc_state->base.event)
> >               DRM_ERROR("new event while there is still a pending event=
\n");
> > @@ -756,6 +759,8 @@ static void mtk_drm_crtc_atomic_begin(struct drm_cr=
tc *crtc,
>
> ...because my suspect is that what creates the race condition in this fun=
ction is
> the unlocked *assignment* to mtk_crtc->event, not the rest.
>
> If I'm right, you don't need to unconditionally spinlock at the beginning=
 of this
> function hence ever-so-slightly improving performance compared to this ve=
rsion.
>
> Can you please try this one and check if this *also* solves the issue?
>
>         if (mtk_crtc_state->base.event) {
>                 mtk_crtc_state->base.event->pipe =3D drm_crtc_index(crtc)=
;
>                 WARN_ON(drm_crtc_vblank_get(crtc) !=3D 0);
>
>                 spin_lock_irqsave(&crtc->dev->event_lock, flags);
>                 mtk_crtc->event =3D mtk_crtc_state->base.event;
>                 spin_lock_irqrestore(&crtc->dev->event_lock, flags);
>
>                 mtk_crtc_state->base.event =3D NULL;
>         }
>
> P.S.: I'd try that myself, but I can't seem to reproduce the issue.

I'm still able to reproduce it so I gave it a try, and this approach
also seems to fix the issue.  :)
FWIW, the way I reproduce that is to toggle the night light mode on
and off repeatedly through the UI panel while playing YouTube videos
on my device.

Jason, can you post a new version with Angelo's suggestion?

Regards,
Fei

>
> Regards,
> Angelo
>
