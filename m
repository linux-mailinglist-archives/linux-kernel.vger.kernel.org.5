Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B4675744F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGRGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRGhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:37:12 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B3100
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:37:11 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4814299c981so1891014e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689662231; x=1692254231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gBoG3t1UefRa8EkOhssPB7UZLWGuGIe6z2Ts9f7jOk=;
        b=bEke5BuJ8ozhIP3kmA8f3lB0O2yXtncsd0xG7i5YJu9GInFfFvMxV8pyQcoUJc/iza
         Wkt58V7uHgG+4P026IwVUvMLWnEppGnx7bJQOZduKfkIFCFsDiyqZ7DA2zYPb4R8MFOk
         H22RYXHd4wDn8A4b496I7MK44cLzBSIJEskvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662231; x=1692254231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gBoG3t1UefRa8EkOhssPB7UZLWGuGIe6z2Ts9f7jOk=;
        b=ANoUxpTtGvNomIShEpwt4mhd9U8wBU0E9HDhU3a41UCwX/nRAfuQffDqZQzXmG6i2p
         0wK9pgGeBe4aPogbtlYnA+74zYnGaygIEKBHTmJcfbshQ+ScMb38EuDvBqzF+/sWeKmp
         fpkE8hlNq1rPnzz8W8PqtTVbgzcANjF7Y+u/tzaj45kFd2JZkKKnycrPigdUE0jKN4L/
         N4GWruuqFbUxvxi29eVR9XEdPw8rt5AptBs9SuyRudnWZ5IuAuYOrUDbF/WVlhL0lnz/
         06fF8zmSA791Qn70VON1gFgsNrG/oTBFWFtsq3wPRUAqMyFDBETuoWkHyC5zOc7UXUut
         T/sg==
X-Gm-Message-State: ABy/qLb0gyUk4h+KRodwqbOtI/+XRgja4Qh1zA6alypg70/lWzDYRikY
        rzzhOuds9SbDYUFY38xucxv7F+rfabUcBZo83eebtg==
X-Google-Smtp-Source: APBJJlH1qnC65qp8EOsAPsktOzCwybrfdVeNXU1/cIgj71YvePCV7l/VEGzQzcTLdXzUy67HQB6TtAIg49/fUtpYi6s=
X-Received: by 2002:a1f:dd84:0:b0:471:cfa1:5065 with SMTP id
 u126-20020a1fdd84000000b00471cfa15065mr1103389vkg.3.1689662230790; Mon, 17
 Jul 2023 23:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230711091155.2216848-1-wenst@chromium.org> <CAD=FV=UW=VrrCB8Ko7ysWTia--hG6t+4BmRwodY=nkL=DyP6CQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UW=VrrCB8Ko7ysWTia--hG6t+4BmRwodY=nkL=DyP6CQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 18 Jul 2023 14:36:59 +0800
Message-ID: <CAGXv+5Fu1JR_9Mjn+hQNnh+iZYL6D9u=KM4AuAKEkSW3JTNxhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO B116XAB01.4 (HW:0A) panel entry
To:     Doug Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 5:40=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Jul 11, 2023 at 2:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > This panel is found at least on the MT8183-based Juniper Chromebook,
> > also known as the Acer Chromebook Spin 311. It matches the common
> > delay_200_500_e50 set of delay timings.
> >
> > Add an entry for it.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index fbd114b4f0be..df7e3cff004c 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1866,6 +1866,7 @@ static const struct panel_delay delay_200_500_e20=
0 =3D {
> >   */
> >  static const struct edp_panel_entry edp_panels[] =3D {
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B12=
0XAN01.0"),
> > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B11=
6XAB01.4"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B13=
3UAN02.1"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B11=
6XAK01.6"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B=
116XAK01"),
>
> You're about 1 month too late. ;-) This landed in drm-misc-next as
> commit 1ebc9f0365ef ("drm/panel-edp: Add AUO B116XAB01.4 edp panel
> entry").
>
> You can find it on drm-misc-next: https://cgit.freedesktop.org/drm/drm-mi=
sc/log/
>
> Specifically see:
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D1ebc9f0365ef

Argh, you're right. I vaguely remember it. I was on v6.5-rc1 when I sent
this.

ChenYu
> -Doug
