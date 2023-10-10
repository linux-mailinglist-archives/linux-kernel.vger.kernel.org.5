Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525087C0431
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjJJTLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbjJJTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:11:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17158E0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so2691a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696965103; x=1697569903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmjErNj6cLHcO0s7PJGZsoXQtRcGQqMYUEfJq8NBOjo=;
        b=maZySBjGgF20+xAxLcuzu6WFVPXxIrLhGzPtXRx7psguyrbiiEDcqA96W5otl5Wsrk
         H8KmjqJsLs3ZdbJJpELZjIXBpktJhkzaTdjK6OZBCRdFmLtl3b4yJyaaN+NVs+RzFc/y
         BeWP0zc6JdP+Lwn32/OYnzDZXCO30tnXJbG2jC/sv8x65QobIBk2Uc16ad+ajlRoZjCt
         fhBp1ugqlt5MX+7oaBVwaTwOThHPZKF1D7SGtza96XbIrRqzAiff5ZeZ5GVpF5yMVdTS
         EIPOrjXDE+4xj4ZGBByLxxMt2l1iDGqeCyYayua4W4CtkUpmuVSSGvknADS00dZtm6Pa
         VVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965103; x=1697569903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmjErNj6cLHcO0s7PJGZsoXQtRcGQqMYUEfJq8NBOjo=;
        b=fv4UbDQ7ZT8KixxDaGLxLIWX9qfSfmVxHMFK9AEDn6m0oVk3otmrk/BLni5xwmw9PZ
         pdFH8vZWAShcYkN7n2mjDM/VjMr9PBoYka2UFd28cSg/qdooGXnmXEB8HEOmP3RgbuJ8
         Fgf3n8CfOloRv8ynHACShTjAxw58IaTXbWXxduN6qUwcINrjf3KjQrf3wwZ4ynvqm8JT
         2YafsrMgOCw/BVk8FGttKBmiFEYB/PqVTwH2ZJWaYCpTcRtJp6nXIzIvolHu99gZB00C
         PVruItqrZKaRdY7ICPcC7QwyqAv1sD5TuHdSJpC5LqdcbEHjLyyc0KemTOWAmeJjYROL
         BGkQ==
X-Gm-Message-State: AOJu0YxjX/Efvrk2JpfoOYapJMSNaIP0fPXi9Eu6PmnF2AQl7zm0OKtD
        W/duGjv+B9Cvo9VEZbr0lGZ+Fz2F4SggitMu5oT/Gw==
X-Google-Smtp-Source: AGHT+IF44V9VAvMHDXj78txqmMrBQ5P2zJqqx5htIgx/2JlftTdgM1YVJ7acLqOWZw5OeYg6E3fJaN0KSIczk6RAUH0=
X-Received: by 2002:a50:cc9a:0:b0:53d:a40e:bed1 with SMTP id
 q26-20020a50cc9a000000b0053da40ebed1mr26458edi.3.1696965102691; Tue, 10 Oct
 2023 12:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231007060639.725350-1-yangcong5@huaqin.corp-partner.google.com>
 <20231007060639.725350-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=W3ef3vWrWRDPKgeUjcapEticj4=EWdC-bOb=ph0DShsA@mail.gmail.com> <CAHwB_N+=h8-5H6SM8REAge19SgLvrZD=drAP83QnSuuqB5gN8A@mail.gmail.com>
In-Reply-To: <CAHwB_N+=h8-5H6SM8REAge19SgLvrZD=drAP83QnSuuqB5gN8A@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 10 Oct 2023 12:11:30 -0700
Message-ID: <CAD=FV=XtqPJ77dx8uRb0=tMvC3CvgH5X+7mUJeXgcG228kZfUg@mail.gmail.com>
Subject: Re: [v1 2/2] drm/panel: ili9882t: Avoid blurred screen from fast sleep
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 10, 2023 at 4:36=E2=80=AFAM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,
>
> On Tue, Oct 10, 2023 at 4:44=E2=80=AFAM Doug Anderson <dianders@google.co=
m> wrote:
> >
> > Hi,
> >
> > On Fri, Oct 6, 2023 at 11:07=E2=80=AFPM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > At present, we have found that there may be a problem of blurred
> > > screen during fast sleep/resume. The direct cause of the blurred
> > > screen is that the IC does not receive 0x28/0x10. Because of the
> > > particularity of the IC, before the panel enters sleep hid must
> > > stop scanning, i2c_hid_core_suspend before ili9882t_disable.
> > > This doesn't look very spec-compliant.
> >
> > Presumably you could be more spec compliant if we used
> > "panel_follower" in this case? Would that be a better solution?
>
> In the "panel_follower" solution, the phenomenon is the same.
> The current order is
> ili9882t_disable=3D>i2c_hid_core_suspend=3D>elan_i2c_hid_power_down=3D>il=
i9882t_unprepare,
> ili9882t need touchpanel stop scanning,i2c_hid_core_suspend before
> ili9882t_disable.

Ugh, that's unfortunate. Though is there a reason why you couldn't
just move the `ili9882t_enter_sleep_mode()` to `ili9882t_unprepare()`?
That seems like it should be OK and even perhaps makes it more
symmetric with thue enable?


> > > @@ -507,7 +526,7 @@ static int ili9882t_prepare(struct drm_panel *pan=
el)
> > >         gpiod_set_value(ili->enable_gpio, 1);
> > >         usleep_range(1000, 2000);
> > >         gpiod_set_value(ili->enable_gpio, 0);
> > > -       usleep_range(1000, 2000);
> > > +       usleep_range(40000, 50000);
> >
> > nit: use 40000, 41000 instead of 40000, 50000. Linux almost always
> > uses the longer delay, so that'll save ~9 ms. The only reason for the
> > range is to optimize kernel wakeups which is really not a concern
> > here.
>
> We need 50ms delay to meet the requirement.

I'll respond to your v2, but if you need 50 ms then your current delay is w=
rong.


-Doug
