Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025A67B27A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjI1Vmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjI1Vms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:42:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8119D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:42:47 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a1d0fee86aso96103957b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695937366; x=1696542166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyjoKETvc8Jkre1VW0VcBJjtFjfQTAwv92MnVeCdm0U=;
        b=hrfFgxrzFr4wjs3rnQxBqCdY/n5Utsm36cqoLfrH/1F9RcldTlldG4OkToP9KJvqpD
         LGtwnE65jvaAhjR/wapFGmwoLn/RPcR1HKmJokWFxJnR2zyigSUvWp1biBbijrsUlxlv
         6oZgC1uyaZ2RLd7h/6k2nQ5rsECucs/kS0oqSCClluIJSEyCKXOKMSqJYvMuxdlEY17N
         I1cEu+P83FnwwITx06+F0nqCTxLmY9dN+aRUVOqaqnOSYkpM6EX0YMIWaCYwxSBzlR9G
         RyfziRQ+QBlaTxc04M3MMYNdoWeeeCyiaP+ND3tx0/f83rsahIgexvBc9UbIqb9g8VTa
         GDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937366; x=1696542166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyjoKETvc8Jkre1VW0VcBJjtFjfQTAwv92MnVeCdm0U=;
        b=ShobGyGgdBqbH25C8Lew5wbi3ce1xWGpTtrm1ocTj3YDRimxzXKFmTJv9cxpV9IHHq
         hIYePcBFBZvkQ20mRdBE3onfs+QvEdq1KBrsOHbA4P7HVVUD7iYytE885cuMj7zhHDJ9
         xgMEljD3O016ztvDgsBwHiRvfqPUvM3/WZtftI2nIb+nK9fZj3DveK9EhhUHKXj9QVQP
         EiQxlHDmK1UgLMoRMR60HddHtSl2Z+sdwLYi2UGFjqFf0BVcMjnqDDkekaCP904oJr3Z
         g6jpjGHkBmqbObn/CGHqeMXn/TiShi6uCJSUrnI0W38k5g9B2GETZXsf3l4BVGaf5ztE
         CVvg==
X-Gm-Message-State: AOJu0YzBMeBFqTD7ifgneAvtDSmQWd6JSLU483IvmssFWUe5ggr+y2V5
        p+x/1V3TkjCapTmeV52sBL3ztQvIbQdyK0eQYDupyQ==
X-Google-Smtp-Source: AGHT+IGpk71VurMtp/ePcfVQM8FvTjVmQTqiAz9LlB+kRJrzAOI7qpjlMQxs+h+Ue0Bpl2YEFijapTB7lkIaA6g99sU=
X-Received: by 2002:a0d:e001:0:b0:59f:687c:fb36 with SMTP id
 j1-20020a0de001000000b0059f687cfb36mr2143294ywe.45.1695937366526; Thu, 28 Sep
 2023 14:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
 <CAD=FV=W2AKQSnWh02Lxbqi47M325JNCaEn1_B0xAW3PKPKKF7Q@mail.gmail.com> <CAD=FV=WZ+zX9jrwOhN_ZboSYSBomx2s5vifQEB6MzNFgj=g4Ow@mail.gmail.com>
In-Reply-To: <CAD=FV=WZ+zX9jrwOhN_ZboSYSBomx2s5vifQEB6MzNFgj=g4Ow@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 23:42:34 +0200
Message-ID: <CACRpkdZutdTDQkCSQoA0_0U=Qdf+xDWTu3PzvYRRz=cT18wHRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
To:     Doug Anderson <dianders@chromium.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:49=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:

> > I'm curious what the latest on this patch series is. Is it abandoned,
> > or is it still on your list to move forward with it? If it's
> > abandoned, does that mean we've abandoned the idea of breaking
> > ili9882t into a separate driver?
> >
> > From looking at things that have landed downstream in the ChromeOS
> > kernel trees it looks as if additional fixes are getting blocked from
> > being posted/landed because of the limbo state that this is in.
>
> I presume Linus is busy or otherwise indisposed.

Sorry I was looking for the branch with my patches and I have it
somewhere not ordinary :/

Originally I shelved it because I got requests to do additional
patches to the driver:
https://lore.kernel.org/dri-devel/CAD=3DFV=3DXkr3Qpd8m_6Xta_2jL_ezbxsmMyarb=
KXTXL+UJLG9xNw@mail.gmail.com/

To do measurements about binary code size in object files, and if it does,
then I need to invent new sequence macros (IIUC):
https://lore.kernel.org/dri-devel/CAD=3DFV=3DWju3WS45=3DEpXMUg7FjYDh3-=3Dmv=
m_jS7TF1tsaAzbb4Uw@mail.gmail.com/

So I just didn't have time for that extensive rework of the driver.

It's good feedback, but I just wanted to make the situation a little
bit better, and perfect is the enemy of good (TM).

> So I guess we have two options here:
>
> a) Cong Yang can post any relevant fixes to the existing "monolithic"
> panel driver so that we can get them landed and at least get things
> fixed.
>
> - or -
>
> b) Cong Yang could take over all or some of Linus's series and post
> new versions of it, addressing feedback.

Either works for me, I would prefer b), Cong is welcome to adopt
the patches if he/his employer want to. Go ahead!

We can't really let this one-size-fits-all driver go on like this.

My main concern with the "boe-tv101wum-nl6" driver is that it can
be renamed "cromeos-hackfest" at this point because it becomes
hard for any other system to reuse the panel drivers, the typical
example would be a system using say ili9882t but with
a different init sequence or something, why would they want
support for 9 unrelated panels compiled in? The condition that
these drivers should be related to the original panel that gave
name to the file has seemingly been dropped long ago.

It looks like the drivers only share the power lines (avdd, avee, pp3300,
pp1800) then this can be broken out to a helper library. But I am
sceptical about that too. I doubt that the vastly different panels
actually have exactly these these supply line names, I think it is
actually names of the rails on the chrome machine board. And that is
not how these regulators should be named, they should be named after
the input name on the component. This is really hard to catch in reviews wh=
en
we don't have datasheets so I'm not blaming anyone, but is this something
that even needs fixing in the device tree bindings? (By deprecation
and addition...) can we look into this?

I would say can we at least agree that before we merge one more
driver into this file, break out to subdrivers those that clearly have
an identifiable display controller and is thus reusable? From my
point of view I can just see the ili9882t so that's a good start.

Yours,
Linus Walleij
