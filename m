Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC4782386
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjHUGTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjHUGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:19:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFAA2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:19:32 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34ca192f8feso4977505ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692598772; x=1693203572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e24p/QGiX61DaJt8Acom0fYKmpB5lPPX58liDQjeNco=;
        b=A70g4Wy7cm2gbVvWuYVT9fi3bvriKwgHb51o8ClH9pqYUoPl6kLC73sAAHHDcz3e2d
         1q/lwlU4PwbVCuqMGrYpeieXDNkNSoOa73S76dhzd8vV+UjeFFgxAlNEiEQTaIwdM7Lh
         c29qapExHwfx/X47+nROYws9x+EsQyGeylt9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692598772; x=1693203572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e24p/QGiX61DaJt8Acom0fYKmpB5lPPX58liDQjeNco=;
        b=IA6jKORvZq3yImlRapoei5PQ6IGUiLwY4Pi67iQIih152yVbggUVkzFtWeEzTsr3IT
         yeGTr4D67AaFfLcMYMGuxXozGsXvAD7/xnoAJF5Unnst0bU4QfVSvicnBmX04EJ4zEuo
         lsG3mVMVDUbsLSxq3JpPhLh1PdGN1OsvFA1bgfjhnvgGl7O9q2B4E9t1OV0ztnK6R16j
         Irnxm2BzeTFOWpo0nsYBOnKM0mmt9PNyPON5qg5LDFfVChISbE+9ApXYxl0Xg3gRGGsn
         EeHl546ffIkXlPenZzeZP3R+iA+UhToNZ62qv5X0ECSYfv51NR9gu05Mj3s0qbtadasd
         HTUQ==
X-Gm-Message-State: AOJu0YwidQ0Y0dKJ9XjoPz5rIYTKUlUnF/k+0cHw1hWVeP5+synYIcwH
        AuRcGckFPW7QyYuB/xTGU9CgpyaYeV901H8tpRc=
X-Google-Smtp-Source: AGHT+IFHPPh/uZN3lU1pTa1NsZU/1NjGlQqL3m2eo3nLk8WeQ6kLf8+pusYec/yQEwLMhzznOm1N9w==
X-Received: by 2002:a05:6e02:d4a:b0:349:76b0:4dde with SMTP id h10-20020a056e020d4a00b0034976b04ddemr6750945ilj.11.1692598771798;
        Sun, 20 Aug 2023 23:19:31 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id i14-20020a056e02054e00b0034bad471d1fsm2290390ils.3.2023.08.20.23.19.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 23:19:31 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77a62a84855so98650239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:19:30 -0700 (PDT)
X-Received: by 2002:a5e:9e02:0:b0:787:8d2:e0c with SMTP id i2-20020a5e9e02000000b0078708d20e0cmr7366242ioq.12.1692598770209;
 Sun, 20 Aug 2023 23:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
 <20230821033532.GA21555@google.com>
In-Reply-To: <20230821033532.GA21555@google.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 21 Aug 2023 14:18:53 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhT8b8aWAA=eDq_6kEjS3fWTMBTAjV2BGc2CNtGy_rD0Q@mail.gmail.com>
Message-ID: <CAC=S1nhT8b8aWAA=eDq_6kEjS3fWTMBTAjV2BGc2CNtGy_rD0Q@mail.gmail.com>
Subject: Re: [PATCH] spmi: mediatek: Fix UAF on device remove
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Yu-Che Cheng <giver@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        James Lo <james.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
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

On Mon, Aug 21, 2023 at 11:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Mon, Jul 17, 2023 at 05:39:35PM +0800, Yu-Che Cheng wrote:
> > The pmif driver data that contains the clocks is allocated along with
> > spmi_controller.
> > On device remove, spmi_controller will be freed first, and then devres
> > , including the clocks, will be cleanup.
> > This leads to UAF because putting the clocks will access the clocks in
> > the pmif driver data, which is already freed along with spmi_controller=
.
> >
> > This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
> > building the kernel with KASAN.
> >
> > Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
> > clocks before freeing spmi_controller.
> >
> > Reported-by: Fei Shao <fshao@chromium.org>
> > Signed-off-by: Yu-Che Cheng <giver@chromium.org>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Stephen, could you pick this up?
>
> > ---
> >
> >  drivers/spmi/spmi-mtk-pmif.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.=
c
> > index b3c991e1ea40..74b73f9bc222 100644
> > --- a/drivers/spmi/spmi-mtk-pmif.c
> > +++ b/drivers/spmi/spmi-mtk-pmif.c
> > @@ -465,7 +465,7 @@ static int mtk_spmi_probe(struct platform_device *p=
dev)
> >       for (i =3D 0; i < arb->nclks; i++)
> >               arb->clks[i].id =3D pmif_clock_names[i];
> >
> > -     err =3D devm_clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
> > +     err =3D clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
> >       if (err) {
> >               dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
> >               goto err_put_ctrl;
> > @@ -474,7 +474,7 @@ static int mtk_spmi_probe(struct platform_device *p=
dev)
> >       err =3D clk_bulk_prepare_enable(arb->nclks, arb->clks);
> >       if (err) {
> >               dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err)=
;
> > -             goto err_put_ctrl;
> > +             goto err_put_clks;
> >       }
> >
> >       ctrl->cmd =3D pmif_arb_cmd;
> > @@ -498,6 +498,8 @@ static int mtk_spmi_probe(struct platform_device *p=
dev)
> >
> >  err_domain_remove:
> >       clk_bulk_disable_unprepare(arb->nclks, arb->clks);
> > +err_put_clks:
> > +     clk_bulk_put(arb->nclks, arb->clks);
> >  err_put_ctrl:
> >       spmi_controller_put(ctrl);
> >       return err;
> > @@ -509,6 +511,7 @@ static void mtk_spmi_remove(struct platform_device =
*pdev)
> >       struct pmif *arb =3D spmi_controller_get_drvdata(ctrl);
> >
> >       clk_bulk_disable_unprepare(arb->nclks, arb->clks);
> > +     clk_bulk_put(arb->nclks, arb->clks);
> >       spmi_controller_remove(ctrl);
> >       spmi_controller_put(ctrl);
>
> Maybe we need devres versions of spmi_controller_alloc and
> spmi_controller_add to avoid this in the future? I'm sure
> drivers put all sorts of stuff in their private data.

Sounds good, I think I can send a follow-up series for that.

Regards,
Fei

>
> ChenYu
>
> >  }
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
