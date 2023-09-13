Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D379F105
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjIMSUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjIMSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:20:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204811BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f71b25a99so54089f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629199; x=1695233999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3JqoOh+25nY/g0sbcImIfYwmx6qLRTASwuSntRUYYo=;
        b=k+WXJvzFe9O6ykJ42oNJEMqxQYzWkCWiyjEqCwScxsx1jQvjP7ZnuRJImRtnmCTXuj
         sYYe0wslM0rvMcag+JTct4qu3L/mzox93hjYfgP39vBTx3+hLqYWqInNtCSXMoKxhcGG
         cb4YZivUxbVTZnwT18/LsAjfkzo2riAR51ywI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629199; x=1695233999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3JqoOh+25nY/g0sbcImIfYwmx6qLRTASwuSntRUYYo=;
        b=UewUZ3oWpj+nXjFBczeHcEhk/shgOy3TqJecHi8IQo/bxu46d5yD34xZ6Cw6R4Zu7L
         W2eCmnWgWlLrhqMWNtXtzpU4iZs4QLrKF1PMFbGy58zRgAz7NcS23Th2TVMSkQVAcHmJ
         bc/WWVrlKUT4YUqrNXT7IBls+iGjyV3pkgn8QMrEYjykFeD7Gtmx9eFKBEpH+lPAVkui
         h7yAdxd1velKFhQ72yuCx1M/JiXi6SQYbwE0mx+TDa/0LrFb3eJThmyWXmprUVz43SX5
         yUTgCNJkLE/Z86Vc0T3nSx9UFpyOcV4/lO1Dhagk7NZI1P17GVoX7cBitd5PDiv2x4nf
         hYIg==
X-Gm-Message-State: AOJu0YxOdHjHZ4quxV2bhi5S/QzjITrlGM3TwjKPew08KsmLwuigmWwS
        gvdUj9NEFLxraBC/KcPiVbuV/SdX/I7ChCymVNQDxjoL
X-Google-Smtp-Source: AGHT+IGQ6VtiaCKKpVuezPfLpJnAFJPiNsRk9yzxH8ccZyBTC5xRzMTP4fNfKhBAsgELDll6k5J9zw==
X-Received: by 2002:adf:d0ce:0:b0:31c:6525:770d with SMTP id z14-20020adfd0ce000000b0031c6525770dmr2578251wrh.1.1694629199025;
        Wed, 13 Sep 2023 11:19:59 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402070f00b005288f0e547esm7659274edx.55.2023.09.13.11.19.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:19:57 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-402c80b71ecso11295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:19:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1827:b0:3fe:f32f:c57f with SMTP id
 n39-20020a05600c182700b003fef32fc57fmr197827wmp.0.1694629196921; Wed, 13 Sep
 2023 11:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230901163944.RFT.1.I906acd535bece03b6671d97c2826c6f0444f4728@changeid>
 <4b3a93c9ab2432f8ae0e9282d9e00d2a.mripard@kernel.org> <CAD=FV=VO_AxBuJya_Rea2xHJ3NMR7RL2+YV3VTMUXAwsnTkJew@mail.gmail.com>
In-Reply-To: <CAD=FV=VO_AxBuJya_Rea2xHJ3NMR7RL2+YV3VTMUXAwsnTkJew@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:19:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WwmQMmRnkMMEnQPpVCGtuO-7T_yGaQxuBys=g+sUyDLw@mail.gmail.com>
Message-ID: <CAD=FV=WwmQMmRnkMMEnQPpVCGtuO-7T_yGaQxuBys=g+sUyDLw@mail.gmail.com>
Subject: Re: [RFT PATCH 1/6] drm/atomic-helper: drm_atomic_helper_shutdown(NULL)
 should be a noop
To:     Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 5, 2023 at 2:14=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Sep 4, 2023 at 12:55=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > On Fri, 1 Sep 2023 16:39:52 -0700, Douglas Anderson wrote:
> > > As with other places in the Linux kernel--kfree(NULL) being the most
> > > famous example--it's convenient to treat being passed a NULL argument
> > > as a noop in cleanup functions. Let's make
> > > drm_atomic_helper_shutdown() work like this.
> > >
> > >
> > > [ ... ]
> >
> > Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Thanks! If there are no objections, I'd tend to land this patch
> sometime early next week just to get it out of the queue, even if
> other patches in the series are still being discussed / need spinning.
> If anyone objects to that idea, please shout.

Landed to drm-misc-next.

2a073968289d drm/atomic-helper: drm_atomic_helper_shutdown(NULL)
should be a noop
