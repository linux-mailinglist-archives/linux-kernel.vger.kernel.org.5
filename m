Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3237C56F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjJKOgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJKOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:36:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF509D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:36:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15221a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697034969; x=1697639769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRia8k+03Oqwx1GX3n4lKL8Fmr4eu0Kd6W6Uh3EpGVs=;
        b=3zmuKZfYaSsgs99y+wRCOImGmrggkE4MUUdz04jVhCtA2dF+Tgj0RMOhA8l2DBRYz6
         VFSIdDo7QlXmOFGAMYacOoqx/8lF7zbGYPCO6uHaUUu43/MHFobDSkkyP0HDLKplWFIv
         CkEimNKLwBURxJOgxNnULIt877XOS0At5Xns5sPtirxnGF3ElbdK+TZNoKkzPR4U1K5z
         WnqPsYBXF2mJSFk8jlhIvVJlIyXyC9Bcf33u2C2t3FvlWHpd6juZ2AqmZvzBpKJ4dzDa
         RhitowQrGZAmwDqYgTleb/xv3wvzvHz6vj/13n43OL85NHfLpQR1lISWLfQzLCyo7Uv8
         DxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697034970; x=1697639770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRia8k+03Oqwx1GX3n4lKL8Fmr4eu0Kd6W6Uh3EpGVs=;
        b=CEn0kq19Y4RvKysB2lY9Aib/QAr2X00d/7AaogjCyHaz0xCXarvGlL9YcFz9M67aMM
         5t7ClWAlFljxBG2RazZ1o1PhZlVKf6wu7NSeCIxEnahWrdC/4svSsFI8L75ieACw67rx
         mQsc/UkdMBx6UGrJYEq+xNjlh2/n0cMMj5UO5HoTG8cDEYTNMjXqs8ObIj4q7ek7fWla
         ogQ7Cxg4s2x9C1bFy495H9jRWqF7PUeI7Y7IpGGgz7dSoEjhevYnD3Yx/wYTmmsT60UX
         Cftr83r7qOXDSKF48NnXNWamY3ZBPNec8eBp5lYzrGfB/Ah0R+fmn44vO8kcji0YEBpt
         Lxdg==
X-Gm-Message-State: AOJu0Yy69PtAHgIGFs7Q7tvEphiwxATv2MRwSOYz0GQ34V+tqGK8Wtdo
        2VGZNEAABonjzpPaJLbpk+atVxsiuvpqxtcjoCMFUg==
X-Google-Smtp-Source: AGHT+IGp0aCbVch3aWSyH7cHVNbtanzJle7cJ1cAmpcUd/wMeHz4+z/v7vHIwU0O/XV3e1Y9FOEIZ+CBjOydn+x9eiA=
X-Received: by 2002:a50:8ad1:0:b0:538:5f9e:f0fc with SMTP id
 k17-20020a508ad1000000b005385f9ef0fcmr158758edk.0.1697034969289; Wed, 11 Oct
 2023 07:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231010121402.3687948-1-yangcong5@huaqin.corp-partner.google.com>
 <20231010121402.3687948-2-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=VsjB-gsqXyAs+G8DpHJqHNTxeFXwbpgt20-Wgb757z1w@mail.gmail.com> <CAHwB_NKVSOLwBttWG9GQMvKEFGzuGeE6ukR=vNDNLpdVjjohng@mail.gmail.com>
In-Reply-To: <CAHwB_NKVSOLwBttWG9GQMvKEFGzuGeE6ukR=vNDNLpdVjjohng@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 11 Oct 2023 07:35:53 -0700
Message-ID: <CAD=FV=WFkRqkp8wcGG5uxE+7RqAQ40rSU-12Zig1R--ykcO8ZA@mail.gmail.com>
Subject: Re: [v2 1/3] drm/panel: ili9882t: Break out as separate driver
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 10, 2023 at 10:42=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,
>
> On Wed, Oct 11, 2023 at 3:11=E2=80=AFAM Doug Anderson <dianders@google.co=
m> wrote:
> >
> > Hi,
> >
> > On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/=
gpu/drm/panel/panel-ilitek-ili9882t.c
> > > new file mode 100644
> > > index 000000000000..e095ad91c4bc
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> > > @@ -0,0 +1,762 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Panels based on the Ilitek ILI9882T display controller.
> > > + */
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> >
> > nit: remove include of linux/of_device.h since you don't use any of
> > the functions declared there.
>
> It seems that of_device_get_match_data will be used.

Right... ...and of_device_get_match_data() is declared in...
<linux/of.h>. :-) See commit 82174a0a9c5c ("of: Move
of_device_get_match_data() declaration") and commit 722d4f06e560
("drm: Explicitly include correct DT includes").

We'll probably need to handle that when picking to downstream, but for
upstream you shouldn't be re-introducing of_device.h.


-Doug
