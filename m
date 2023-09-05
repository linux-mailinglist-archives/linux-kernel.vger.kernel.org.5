Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A682792E99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbjIETOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbjIETOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:14:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB1D2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:14:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bcc0adab4so428367166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693941195; x=1694545995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUlpaGleIWzbTmcbFt9fpixpRahjTzIY6Eh3TvOZ30I=;
        b=ZVi0gty2OSESc9ZWShP4hzETHKY/cdLA9mLsO/TYauOUW4hkSz5i7C2q/u59etTo6n
         c9C2eQBgUKLvBHjwRle3ypcTIqJ9wcuplJxbtgqh+IIZqOG6ebBEEHyU+EqWxcpYWPrJ
         DOXIExx0QaaFB78tbm4hQvWxGRPEfRURDVjMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693941195; x=1694545995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUlpaGleIWzbTmcbFt9fpixpRahjTzIY6Eh3TvOZ30I=;
        b=DKPcr+XQlRWhjQGXopoo75txggLaU32Hop69l4WrFcjkNhGwcGui5uU4yG1jI2nGnf
         OUAgNJh3rzBMdiMNZMaAd0a/N46cemuFSnyDCcPKD7XVUfkXLXksrLMQ2LAzkYEsrBS8
         2mv1ShrNI4VH9F9VKq4fzpYKkABjuNcOkxd+GSwvqFBtgGkv3bPjVSQATAdwluqWstyv
         JdIYUctqCWiGfiHDyNB+XFmrI3kwn1XdC39M8frOS+iayzJV8vTjuIjDyWPcrFvIRMhj
         OeDmwHgUok34y+8nP5fwSTeoWxpipl9NdZrKIEJx5Wf4FYAszMPKvlunXp+BYC70bNWj
         C4Sg==
X-Gm-Message-State: AOJu0YwoyaUhRXsNWPfok2gKRYRr1Pb6+B8GH5ELA0Q6soyT9tjpSJdD
        od78c/MhPr5NT+Kd6Idz3O7t5t6R8Bhm1Fs+x2eS7nJ+
X-Google-Smtp-Source: AGHT+IEZJqVM/UDJCJXo3ymnOEd2tuTWr2VUwd8xbY3yGPQ7csv0MoUQT8dHTUUbNXrx5HxGPTtq/A==
X-Received: by 2002:a17:906:cc5b:b0:9a2:143e:a062 with SMTP id mm27-20020a170906cc5b00b009a2143ea062mr553994ejb.49.1693941194908;
        Tue, 05 Sep 2023 12:13:14 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906410900b009926928d486sm7931160ejk.35.2023.09.05.12.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 12:13:14 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso18795e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:13:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:3fe:e9ea:9653 with SMTP id
 l20-20020a05600c4f1400b003fee9ea9653mr25746wmq.4.1693941193859; Tue, 05 Sep
 2023 12:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <bphkopaq76imqzut7xrx7aprqybhx3veajdympqhig2wqlix6c@64ck23rc5cv7>
 <CAD=FV=XiVkoCsjin4R74nkcd8vzOq9uPq+o5cRjd=YOoPXuQkg@mail.gmail.com>
 <lhd6ai7d6swlxhisjhikytguor7pptrymo3bmfwej4k7zqrnv4@hp2gvhw7mh3m>
 <CAD=FV=XUhzguFCC=aKzHFMV0bBnZzkHXP_tx+P=PNkVr=8SnTA@mail.gmail.com>
 <mumiep5q7x7qj7k64h3cyodxrgk737iy5rum5keguquwymf2gy@3qruwfrqjgy7>
 <CAD=FV=VEene+nr1us87iA+bomxzQ039r-E+wqvizvFGbxXjDvA@mail.gmail.com>
 <wwzbd7dt5qyimshnd7sbgkf5gxk7tq5dxtrerz76uw5p6s7tzt@cbiezkfeuqqn>
 <CAD=FV=XcUVvg5Om__dD=i9zu7ZtQmvWicms9yN7w0c2nWGhqYg@mail.gmail.com>
 <p7okuysh442hulqls3ekbaar2bguqv67fum3gsb2cj75kjvdpx@uebwlgvf46sy>
 <CAD=FV=Xr4nZUeHY-FdiedcV=BuP5szNBEHPKjdRnA7c+3MADqg@mail.gmail.com>
 <nahwibpea2akyg7swbdb3f6xyv7fqs35v5spqbjfzfchxnoqqz@glgg5core75d> <CAD=FV=UKSc4mNjWcvLCXT9Tdeok=xRjA0oVoLKVkq+kQ9-4M0A@mail.gmail.com>
In-Reply-To: <CAD=FV=UKSc4mNjWcvLCXT9Tdeok=xRjA0oVoLKVkq+kQ9-4M0A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Sep 2023 12:12:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZOxT58=jx4=iAyjXGnON_qROy4puosT0WfB5yy+2Ndw@mail.gmail.com>
Message-ID: <CAD=FV=UZOxT58=jx4=iAyjXGnON_qROy4puosT0WfB5yy+2Ndw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] drm/panel_helper: Introduce drm_panel_helper
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
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

On Tue, Sep 5, 2023 at 9:45=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> As per our discussion, in V2 we will make drm_panel_remove() actually
> unprepare / disable a panel if it was left enabled. This would
> essentially fold in the drm_panel_helper_shutdown() from my RFC patch.
> This would make tdo_tl070wsh30_panel_remove() behave the same as it
> did before. Ugh, though I may have to think about this more when I get
> to implementation since I don't think there's a guarantee of the
> ordering of shutdown calls between the DRM driver and the panel.
> Anyway, something to discuss later.

Ugh, ignore the above paragraph. I managed to confuse myself and was
thinking about shutdown but talking about remove. Sigh. :( Instead,
pretend the above paragraph said:

As per our discussion, in V2 we will make drm_panel_remove() actually
unprepare / disable a panel (and print a warning) if it was left
enabled. This would essentially fold in the
drm_panel_helper_shutdown() from my RFC patch (but add a warning).
This would make tdo_tl070wsh30_panel_remove() behave the same as it
did before with the addition of a warning if someone tries to remove a
currently powered panel.

-Doug
