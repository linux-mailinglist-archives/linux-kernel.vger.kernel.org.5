Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535E080543F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjLEMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbjLEMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:35:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D315C124;
        Tue,  5 Dec 2023 04:35:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-286dc26147dso697094a91.3;
        Tue, 05 Dec 2023 04:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701779720; x=1702384520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCPNXIipBFO4e3fU1ItwsDrZJmF1i1S9KCyToMsJuPI=;
        b=gNXhMFIL4xVxrxL+O4OtJKI6ZoLEWRBOtWBU73qtNO9SUvqN+yS964YA0MmZhb9/9U
         mepodb3jEKUmEMpmiYIOuf4oulhQaz7tqxRlnD+YsVvESxUmVEJR/hwOTuIjCebzMd1F
         9UX+nml8X7BQw5e9ComR8MiMxWlaKvUK+crIvwPIC7YKPUgtkxPDyztmyVLM4EAsNMCE
         e152XwGTcHxzyz11haO8DUgSPrvhf58r8nR+rG4JGA6uoLWdxD53lSjt3FqgfBvrwJbG
         2pMvesFSUkhwUhOxkdIF9qWkWOYrZTEg7vkuf2WYoJ+tQMQ7Ypj6f+TYC3RArE+KVpPT
         zzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779720; x=1702384520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCPNXIipBFO4e3fU1ItwsDrZJmF1i1S9KCyToMsJuPI=;
        b=c8Tf0kqOVKB6QMWtEqx+HD1BOHCkuw9ZGVnPeFoNu9D9b4RbwQ5bK2fZq+25erPF69
         ewPawbEwhdtFxUi0PXX9JhfRxAQ4aQDHHrIB/hIf6VE16ZYrC0F7nQ23EpUsQDU7w7u/
         jhuwArzMtpSJRPvemehvIfq5r8dfN8imHMxy9m9N9VW6hJQv2wGBU29q9TGwAcB29+TI
         9HqZIIY/3AygkrFfxU5Rriygt76L0OPwpsqdyxNSldmvByVsjd+i6T10Vrx90+SvrNWc
         dVA0dreA3TfBpZj+rr70AhfiWKFjWNDWyQXXzH+hAwfD0E5kmhcRVoyi1af20+Y9BcPA
         p8Iw==
X-Gm-Message-State: AOJu0YwC9gHoEwWGkSmcnRk/rCtY0itJWc4otGBl36DCYaC75GaUI4Pu
        BThRUXvyrtUKmg8S9YM25N5ByfX6vfGNuDgtBao=
X-Google-Smtp-Source: AGHT+IFccT82pIRM0QptS9G8/lfCF+MOYdAcHvVMFLnXZwCn/Vr7J72FAJHJKrcIDWm1thma/YCqb9IrWr5PPXfnoWQ=
X-Received: by 2002:a17:90b:3b8b:b0:286:d464:686e with SMTP id
 pc11-20020a17090b3b8b00b00286d464686emr1048259pjb.20.1701779720100; Tue, 05
 Dec 2023 04:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20231205-rkisp-irq-fix-v1-0-f4045c74ba45@ideasonboard.com>
 <20231205-rkisp-irq-fix-v1-2-f4045c74ba45@ideasonboard.com>
 <CAHCN7xJqw-hSD7rWfxFq5NWnF+=RrpCWR+js9358jAL0_WzVFw@mail.gmail.com> <b61d7adb-5b45-4366-a98c-d0de91d409c8@ideasonboard.com>
In-Reply-To: <b61d7adb-5b45-4366-a98c-d0de91d409c8@ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 5 Dec 2023 06:35:08 -0600
Message-ID: <CAHCN7xJcYACscBHExh6n-kAKofrk=E2VTncm8Y_ZmWjcj_yzPA@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: rkisp1: Fix IRQ handler return values
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 6:02=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> On 05/12/2023 13:57, Adam Ford wrote:
> > On Tue, Dec 5, 2023 at 2:10=E2=80=AFAM Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >>
> >> The IRQ handler rkisp1_isr() calls sub-handlers, all of which returns =
an
> >> irqreturn_t value, but rkisp1_isr() ignores those values and always
> >> returns IRQ_HANDLED.
> >>
> >> Fix this by collecting the return values, and returning IRQ_HANDLED or
> >> IRQ_NONE as appropriate.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >> ---
> >>   drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 18 +++++++++++=
+++----
> >>   1 file changed, 14 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/dri=
vers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> >> index 76f93614b4cf..1d60f4b8bd09 100644
> >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> >> @@ -445,17 +445,27 @@ static int rkisp1_entities_register(struct rkisp=
1_device *rkisp1)
> >>
> >>   static irqreturn_t rkisp1_isr(int irq, void *ctx)
> >>   {
> >> +       irqreturn_t ret;
> >> +
> >>          /*
> >>           * Call rkisp1_capture_isr() first to handle the frame that
> >>           * potentially completed using the current frame_sequence num=
ber before
> >>           * it is potentially incremented by rkisp1_isp_isr() in the v=
ertical
> >>           * sync.
> >>           */
> >> -       rkisp1_capture_isr(irq, ctx);
> >> -       rkisp1_isp_isr(irq, ctx);
> >> -       rkisp1_csi_isr(irq, ctx);
> >>
> >> -       return IRQ_HANDLED;
> >> +       ret =3D IRQ_NONE;
> >> +
> >> +       if (rkisp1_capture_isr(irq, ctx) =3D=3D IRQ_HANDLED)
> >> +               ret =3D IRQ_HANDLED;
> >> +
> >> +       if (rkisp1_isp_isr(irq, ctx) =3D=3D IRQ_HANDLED)
> >> +               ret =3D IRQ_HANDLED;
> >> +
> >> +       if (rkisp1_csi_isr(irq, ctx) =3D=3D IRQ_HANDLED)
> >> +               ret =3D IRQ_HANDLED;
> >> +
> >
> > It seems like we're throwing away the value of ret each time the
> > subsequent if statement is evaluated.  Whether or not they return
> > didn't matter before, and the only one that seems using the return
> > code is the last one.
> >
> > Wouldn't it be simpler to use ret =3D rkisp1_capture_isr(irq, ctx), ret
> > =3D rkisp1_isp_isr(irq, ctx) and ret =3D rkisp1_csi_isr(irq, ctx) if we
> > care about the return code?
> >
> > How do you expect this to return if one of the first two don't return
> > IRQ_HANDLED?
>
> I'm sorry, I don't quite follow what you mean. Can you elaborate a bit?
>
> We want the rkisp1_isr() to return IRQ_NONE if none of the sub-handlers
> handled the interrupt. Otherwise, if any of the sub-handlers return
> IRQ_HANDLED, rkisp1_isr() returns IRQ_HANDLED.

OK.  I understand your explanation.  I retract my comment.  I'll try
to test this series tonight on my imx8mp

adam


>
>   Tomi
>
