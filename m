Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003267930C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbjIEVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjIEVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:11:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70CBC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:11:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c1c66876aso434982566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693948269; x=1694553069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef2qFmNn3xvEcf4Oez9oM77hxc0tHJu7wEpJkm7cD0k=;
        b=A1LlaS/xXK/50tzUNIDkH0A6F81s0j1fpIWB45quLX/3CesolIeqyE0+5+W/kUrvXP
         blrk5Cvjw9CttGEND9h5L+xPfRCeWN0qHBZhhgwVYf180k3p88eo63FY7jGxW2QAqz76
         r4DH+HN8L6Dv1eMWtmh+4X1c70+CcD00YdJWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693948269; x=1694553069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef2qFmNn3xvEcf4Oez9oM77hxc0tHJu7wEpJkm7cD0k=;
        b=D4BB9yTr/z8CW2rnT2dqBe6gdDGXq+6sgLiA036AAtYGnAlUuW+zP8FtTpqVeTHpEg
         eyjL4Squ+ApcARo+jRy8qEW3e/91az437j8dNwhjEeOi42NZQkyOgJZICe2qWKkCkmv6
         Sa31mPbGMhgqsNU8rzDMCGC9PrBVFYTmwI70LD67Twz8+vUbQP6iVHzpMNx2CZ3Fh+9p
         hnxfGQYDSObmBmUg8SSY8Buh6s+/JJC/DbnWC2Hf9Bvi3ZkHj8cLH+s32BuhrO+59t4R
         PH6wutb9MclwinDjC0Y/Ae8F8JjJhMDnNycMNbXyQXHUrka+ea8cG+/ZWyGIMVxJw0pd
         cSeA==
X-Gm-Message-State: AOJu0YwRJlJ2epRTj2/KoX16rk8bQRP5XOPNu027dm6JVnPJAP+lxkyI
        Qs6sMrYiWJANNdltVphY8Z/e0B36OY3OAxLCT98CH94e
X-Google-Smtp-Source: AGHT+IH7WdaFpLO9sxWVemhJsyrjwFn7JX7/F4RCan/8xmZxabz0eFS7SbIbE8pIWVvBtBl5JLCsgg==
X-Received: by 2002:a17:906:cc12:b0:9a1:ea01:35b1 with SMTP id ml18-20020a170906cc1200b009a1ea0135b1mr710753ejb.62.1693948268911;
        Tue, 05 Sep 2023 14:11:08 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709066c8600b00989828a42e8sm8070713ejr.154.2023.09.05.14.11.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:11:08 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso9635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:11:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3502:b0:3f7:3e85:36a with SMTP id
 h2-20020a05600c350200b003f73e85036amr11498wmq.7.1693948267775; Tue, 05 Sep
 2023 14:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.15.Iaf638a1d4c8b3c307a6192efabb4cbb06b195f15@changeid> <CAMuHMdWOB7d-KE3F7aeZvVimNuy_U30uk=PND7=tWmPzCd7_eg@mail.gmail.com>
In-Reply-To: <CAMuHMdWOB7d-KE3F7aeZvVimNuy_U30uk=PND7=tWmPzCd7_eg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Sep 2023 14:10:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WufC0WrnEZVEi5vQudpGnxiphJpJ6SwsEitm8zEnzJiA@mail.gmail.com>
Message-ID: <CAD=FV=WufC0WrnEZVEi5vQudpGnxiphJpJ6SwsEitm8zEnzJiA@mail.gmail.com>
Subject: Re: [RFT PATCH 15/15] drm/renesas/shmobile: Call drm_helper_force_disable_all()
 at shutdown/remove time
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        biju.das.jz@bp.renesas.com, daniel@ffwll.ch,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, paul@crapouillou.net,
        tzimmermann@suse.de
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

On Mon, Sep 4, 2023 at 12:28=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Douglas,
>
> On Sat, Sep 2, 2023 at 1:42=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> > Based on grepping through the source code, this driver appears to be
> > missing a call to drm_atomic_helper_shutdown(), or in this case the
> > non-atomic equivalent drm_helper_force_disable_all(), at system
> > shutdown time and at driver remove time. This is important because
> > drm_helper_force_disable_all() will cause panels to get disabled
> > cleanly which may be important for their power sequencing. Future
> > changes will remove any custom powering off in individual panel
> > drivers so the DRM drivers need to start getting this right.
> >
> > The fact that we should call drm_atomic_helper_shutdown(), or in this
> > case the non-atomic equivalent drm_helper_force_disable_all(), in the
> > case of OS shutdown/restart comes straight out of the kernel doc
> > "driver instance overview" in drm_drv.c.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks for your patch!
>
> > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> > @@ -179,12 +180,20 @@ static int shmob_drm_remove(struct platform_devic=
e *pdev)
> >
> >         drm_dev_unregister(ddev);
> >         drm_kms_helper_poll_fini(ddev);
> > +       drm_helper_force_disable_all(ddev);
>
> After "[PATCH v3 36/41] drm: renesas: shmobile: Atomic conversion part
> 1"[1], this function will already call drm_atomic_helper_shutdown()...
>
> >         free_irq(sdev->irq, ddev);
> >         drm_dev_put(ddev);
> >
> >         return 0;
> >  }
> >
> > +static void shmob_drm_shutdown(struct platform_device *pdev)
> > +{
> > +       struct shmob_drm_device *sdev =3D platform_get_drvdata(pdev);
> > +
> > +       drm_helper_force_disable_all(sdev->ddev);
>
> ... and this should be replaced by a call to drm_atomic_helper_shutdown()=
.
>
> [1] https://lore.kernel.org/dri-devel/fd7a6702490bd431f314d6591551bb39e77=
e3304.1692178020.git.geert+renesas@glider.be

Ah, thanks! I will put this patch on hold and check back in a few
weeks to see how things are looking. If you wanted to fold it into
your series I certainly wouldn't object to it, but if not that's fine
too. ;-)

-Doug
