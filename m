Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8B7F1BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjKTSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjKTSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:05:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBAA4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:05:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548f35e6a4bso205773a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700503502; x=1701108302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfQgWIiUL3Fow7Ad2MX3WF/O+vZdxL2eavqBiY3Rc9k=;
        b=UpabyqmbB+ek2UGQg8lweA3q9EHnaRDqWa2EAjoloH8hoyUpsPI23OQT+LKIWJ+5qY
         2Q1xz9twyYwE00H5FF+Hfwt//izPH6uSeK0et1VVh+WuGLWhz2SNO5No++wOa82+6ExA
         Yni8FPpQSUFcHLADzSEeVv+rSc2SLVGH/TbAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700503502; x=1701108302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfQgWIiUL3Fow7Ad2MX3WF/O+vZdxL2eavqBiY3Rc9k=;
        b=uEpY5BmOJ9aLQ+iDwxd9amyLXKcgmzrs09jjowNJAMTbYI9bmbytb8vzl8ADvpMJWI
         o9ihYhW0mFIVYnrRI/WOEfhay2gLjdZEV776i3SZV6RMdjSQe3QUwdTOFr1CuEUO3M93
         k8guDglpkuen2dIXJ4GaFHt3IN5sV9p4RDtHBdHHfBuFYyB8K0/pQOJTetOmkjCsxQCO
         By6I76XdWtXwdZAQE79hJ5fHSv88cLiNMVwLYWEDgexUJc1Q1vc3/wuviNTx259uYi/y
         3xtNQa8G0X1nwqg5e8SYJcTe4pswFBxz7hdPcRpFOYmVuIuLY5wAd3HW+KUw9M3FEPnE
         OrRA==
X-Gm-Message-State: AOJu0YwlAozvGaVWu/Vxvhwwg03G52+V1YM/eGz7zTyFfNveKNS/uDgF
        fpdE3zP5dvUHkss72N2Hp4iMNRm52z/+2YJtJeiTzQ==
X-Google-Smtp-Source: AGHT+IGSVs+0nU3b27dOzjH4ccrHvsitzo0pfSIWKq0nR+10Z3NrIXt9p5q8QDsCElWG/u4WFQ4mUg==
X-Received: by 2002:aa7:dace:0:b0:543:caf4:e5bc with SMTP id x14-20020aa7dace000000b00543caf4e5bcmr170640eds.1.1700503501667;
        Mon, 20 Nov 2023 10:05:01 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id f10-20020a50a6ca000000b0053dd8898f75sm3971233edc.81.2023.11.20.10.05.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 10:05:01 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so2625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:05:00 -0800 (PST)
X-Received: by 2002:a05:600c:3c8b:b0:3f7:3e85:36a with SMTP id
 bg11-20020a05600c3c8b00b003f73e85036amr395736wmb.7.1700503500479; Mon, 20 Nov
 2023 10:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20231117032500.2923624-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WAPAhMfK5jgkMS=m3grxaUtrDoZnQs3rmbLpLX84+j1w@mail.gmail.com> <CAHwB_NLHqyP6mpQJHw86Hk-g3d8Q9xjRBde_YTTQiuLBwAhEKQ@mail.gmail.com>
In-Reply-To: <CAHwB_NLHqyP6mpQJHw86Hk-g3d8Q9xjRBde_YTTQiuLBwAhEKQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Nov 2023 10:04:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vf0t_-t0CgLdGM2KMYtDcmf5sq4ej-G94ecKBxMO8K2w@mail.gmail.com>
Message-ID: <CAD=FV=Vf0t_-t0CgLdGM2KMYtDcmf5sq4ej-G94ecKBxMO8K2w@mail.gmail.com>
Subject: Re: [PATCH V2] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@google.com>,
        David Airlie <airlied@gmail.com>, zhouruihai@huaqin.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 19, 2023 at 5:33=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,
>
> On Sat, Nov 18, 2023 at 1:11=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Thu, Nov 16, 2023 at 7:25=E2=80=AFPM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > The refresh reported by modetest is 60.46Hz, and the actual measureme=
nt
> > > is 60.01Hz, which is outside the expected tolerance.
> >
> > Presumably you've swapped the numbers above? The value reported by
> > modetest is 60.01Hz and the actual measurement is 60.46Hz?
>
> No, the value reported by modetest is 60.46Hz.

Indeed. I somehow assumed that the old value of "clock / (htotal *
vtotal)" would have been the one that was closer to 60 Hz, but doing
the math I agree with you. Specifically:

>>> 161600000 / ((1200 + 40 + 20 + 40) * (1920 + 116 + 8 + 12))
60.46093983837174

>>> 162850000 / ((1200 + 50 + 20 + 50) * (1920 + 116 + 8 + 12))
60.005453366348306

Thanks for correcting me!

-Doug
