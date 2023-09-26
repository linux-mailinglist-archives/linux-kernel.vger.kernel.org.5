Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F257AF64A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjIZWaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIZW17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:27:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F581CA09
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:49:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so1170987166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695764991; x=1696369791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP3ecDRzqPITWRfDVWIXzXwRZ85vGykA6jszJPAUAs0=;
        b=EHX0p2mOP7k4lYx04LaYM9hPc3xuFiiJ7IuU2/wwksuKQX32nuU7XdPRK9g4XQFVMw
         PANiwA+i33GsM6Idx12E7CRYgNQhd7gOeBivLg6EkPKt0yV7AloSWc3fBSuTm/wNE5Zw
         bHIf30fm32A+mX+xLh3jgPiMhn3WlbXEkJP4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764991; x=1696369791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP3ecDRzqPITWRfDVWIXzXwRZ85vGykA6jszJPAUAs0=;
        b=qpBndAXLiOLZAkh7Pzar0Mohz8VXCf0Yjb1kw1YoXorbmmwjzMi/zVAOdXc2qbyVli
         OtbCdljfKT+/TliiHLfjxlt0dg87eck4RtNTWuwXoYN018Lgh8eZvEWJcJFnlN+OjwHu
         usgtn0K+rTfdhsP6XAfiVuseEc3X2T7cEXYHHvZYPmznWc8GNFLbHtUr4Ozca1RposP6
         Gk7481KIOhEjGfkwXFv14gY19fCDYi69BHe1WLA2mMeUwIhgXpTDLUHsxcvT/um/d3dK
         Q2hsbW3VMYUxvZPDJvwCkk+MGOz6LFaoqOjYXGmTiYdRmF+spIhXxWANPxCqNuqyeXbA
         dNZw==
X-Gm-Message-State: AOJu0YxgLilfVWpAHry1/6bJ0rYCUzDRrKZm79MFJ287TKeAgjOxRb5N
        nKz+yPRyrvsRFPXBXid6mZfdrAO2abt40/iNb9IlFwzH
X-Google-Smtp-Source: AGHT+IHjKeSXMrt06j3p7yMWq/NVOqM4bUv/fyCDyNFdOq12aDk/uiZJLdna29K4PWrhndAoBi4tyg==
X-Received: by 2002:a17:907:7635:b0:99c:ad52:b00 with SMTP id jy21-20020a170907763500b0099cad520b00mr3450ejc.6.1695764990956;
        Tue, 26 Sep 2023 14:49:50 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id hs35-20020a1709073ea300b009b28ad521f4sm2830704ejc.4.2023.09.26.14.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 14:49:49 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4063c2ed5ebso12165e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:49:49 -0700 (PDT)
X-Received: by 2002:a05:600c:ad9:b0:401:c94d:d6de with SMTP id
 c25-20020a05600c0ad900b00401c94dd6demr152686wmr.2.1695764989474; Tue, 26 Sep
 2023 14:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org> <CAD=FV=W2AKQSnWh02Lxbqi47M325JNCaEn1_B0xAW3PKPKKF7Q@mail.gmail.com>
In-Reply-To: <CAD=FV=W2AKQSnWh02Lxbqi47M325JNCaEn1_B0xAW3PKPKKF7Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Sep 2023 14:49:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WZ+zX9jrwOhN_ZboSYSBomx2s5vifQEB6MzNFgj=g4Ow@mail.gmail.com>
Message-ID: <CAD=FV=WZ+zX9jrwOhN_ZboSYSBomx2s5vifQEB6MzNFgj=g4Ow@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Mon, Sep 18, 2023 at 9:19=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jul 3, 2023 at 6:21=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> >
> > This is two patches fixing things I would normally complain about
> > in reviews, but alas I missed this one, so I go in and fix it up
> > myself.
> >
> > Discovering that a completely unrelated driver has been merged
> > into this panel driver I had to bite the bullet and break it out.
> > I am pretty suspicious of the other recently added panel as well.
> >
> > I am surprised that contributors from manufacturers do not seem
> > to have datasheets for the display controllers embedded in the
> > panels of their products. Can you take a second look?
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Changes in v3:
> > - Rebase on drm-misc-next
> > - Convert the two newly added Starry panels as well.
> > - Break out the obvious ILI9882t-based panel into its own driver.
> > - Link to v2: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v=
2-0-457d7ece4590@linaro.org
> >
> > Changes in v2:
> > - Fix a missed static keyword
> > - Link to v1: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v=
1-0-8ac378405fb7@linaro.org
> >
> > ---
> > Linus Walleij (4):
> >       drm/panel: boe-tv101wum-nl6: Drop macros and open code sequences
> >       drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking
> >       drm/panel: ili9882t: Break out as separate driver
> >       drm/panel: ili9882t: Break out function for switching page
> >
> >  drivers/gpu/drm/panel/Kconfig                  |    9 +
> >  drivers/gpu/drm/panel/Makefile                 |    1 +
> >  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 3037 ++++++++++------=
--------
> >  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  |  759 ++++++
> >  4 files changed, 2067 insertions(+), 1739 deletions(-)
>
> I'm curious what the latest on this patch series is. Is it abandoned,
> or is it still on your list to move forward with it? If it's
> abandoned, does that mean we've abandoned the idea of breaking
> ili9882t into a separate driver?
>
> From looking at things that have landed downstream in the ChromeOS
> kernel trees it looks as if additional fixes are getting blocked from
> being posted/landed because of the limbo state that this is in.

I presume Linus is busy or otherwise indisposed.

So I guess we have two options here:

a) Cong Yang can post any relevant fixes to the existing "monolithic"
panel driver so that we can get them landed and at least get things
fixed.

- or -

b) Cong Yang could take over all or some of Linus's series and post
new versions of it, addressing feedback.

I would tend to say we should go with "a)" because I think Linus needs
to be involved in some of the cleanup discussions.

-Doug
