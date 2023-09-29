Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4540C7B2D19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjI2HeR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjI2HeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:34:13 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF341B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:34:08 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6c4fc2ce697so3420082a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695972848; x=1696577648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUWQxOTsSrkcrkTI16CKvhBBl32jDdZTQBwnUO0YWt4=;
        b=DZhI3IOX/5p2CqZ4kKYF+HmfIDnF0b71WIGNw1f8H5KcrQYj59A6eYcKIGlxeTHvgF
         2xDrFtBxP1ebCpJfW6D3lBixXtfGSEfXNFLk+yd8sy4mxUhqWzJ4PPYNSdlW2KmQdqkr
         swXqmiHJNqeH2Up8eWDLtZZpPbqkIAAlj6+Iah2B9mYYGRXp1OiQYP7qTwxlMNdlJeog
         SN42+YpswLFcXn1W8d+IXuH/U5efeLeRo+0zhbQ5t8Y4znY+iW+SDITUZIfabQAZavps
         qcmvMp1zCdpAHE9jklNkyHN9sZucBYqS8+/mLX85wfg80sBin1nLQbclYAV5EHnU3D84
         zjcQ==
X-Gm-Message-State: AOJu0Yw5JsZdkCidmy3ThRIJCRtXxcDSoE/Bdv0WPwKtdphq7A/IS79H
        gkF/LWVeGv1M6/3UDuUGwE0Fb1iscQgK16pq
X-Google-Smtp-Source: AGHT+IE0EmpCvOWSyTsueVOx+MR39L8wX4Ufka6HJ5TsOz0J3t+JUxUCPVhoiq/gsC7Gnp7RLo1k5A==
X-Received: by 2002:a05:6830:3d0c:b0:6bf:1e78:cc52 with SMTP id eu12-20020a0568303d0c00b006bf1e78cc52mr3716684otb.25.1695972847776;
        Fri, 29 Sep 2023 00:34:07 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id g64-20020a0df643000000b0059bdac3fd08sm5282812ywf.48.2023.09.29.00.34.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 00:34:07 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a1ec43870cso70585667b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:34:07 -0700 (PDT)
X-Received: by 2002:a81:9152:0:b0:59b:c11:ad7c with SMTP id
 i79-20020a819152000000b0059b0c11ad7cmr3474689ywg.18.1695972847371; Fri, 29
 Sep 2023 00:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695903065.git.geert+renesas@glider.be> <0f0eae276da4f8ed44cd1a15ffa138879d27b148.1695903065.git.geert+renesas@glider.be>
 <d9020d20-f512-42e6-8259-a7377c3d0d58@suse.de> <CAMuHMdUXnT61Hj8JwPenD+x_0-k_wU3bUtj8k9wh7Dd+kN4_Dw@mail.gmail.com>
 <9af0ab00-7afd-493b-848a-a433e9b9e182@suse.de>
In-Reply-To: <9af0ab00-7afd-493b-848a-a433e9b9e182@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Sep 2023 09:33:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWRgL0uxLXt7geDCuHdQ=CDPhOzE7WCa4f4wRFvD50sw@mail.gmail.com>
Message-ID: <CAMuHMdXWRgL0uxLXt7geDCuHdQ=CDPhOzE7WCa4f4wRFvD50sw@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] drm: Split drm_modeset_helper_vtables.h
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Sep 29, 2023 at 9:11 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 28.09.23 um 17:32 schrieb Geert Uytterhoeven:
> > On Thu, Sep 28, 2023 at 3:59 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Am 28.09.23 um 14:16 schrieb Geert Uytterhoeven:
> >>> <drm/drm_modeset_helper_vtables.h> is the second largest header file in
> >>> the DRM subsystem, and declares helpers vtables for various DRM
> >>> components.  Several vtables contain methods with the same name, and all
> >>> but one vtable do not fit on the screen, making it hard to navigate to
> >>> the actual method one is interested in.
> >>>
> >>> Make it easier for the casual reviewer to keep track by splitting
> >>> <drm/drm_modeset_helper_vtables.h> in multiple header files, one per DRM
> >>> component.
> >>
> >> I never liked this header either, but do we need new header files? Each
> >> struct could be appended to the end of the regular header: struct
> >> drm_plane_helper_funcs to drm_plane.h, drm_connector_helper_func to
> >> drm_connector.h and so on.
> >
> > That would work for me, too.  But perhaps we want to maintain a clear
> > separation between core and helpers?
> >
> > Note that moving the contents to *_helper.h would be another option,
> > drm_crtc_helper.h and drm_plane_helper.h already exist.
>
> I've taken a closer look at the users of the _vtables header. There's
> code in drm_atomic_helper.c or drm_probe_helper.c that invokes the
> callback functions.
>
> The drivers fill the pointers with code that often comes from other
> helper modules. That code is in files like drm_plane_helper.c or
> drm_crtc_helper.c. There header files are drm_plane_helper.h, etc.
>
> In that context, the _vtables header makes sense, as it separates the
> callers from the callees. Putting the structs into headers like
> drm_plane_helper.h would move it to the callee side.
>
> I suggest to leave the header as it is. The fallout to the code base
> from refactoring seems worse than the current state.

To clarify: do you mean keeping the single big drm_modeset_helper_vtables.h,
or the split drm_*_helper_vtable.h set?

Thanks!

> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> ---
> >>> RFC, a future patch could replace inclusion of
> >>> <drm/drm_modeset_helper_vtables.h> by inclusion of one or more of the
> >>> new files, and reduce compilation time.
> >>> ---
> >>>    include/drm/drm_connector_helper_vtable.h   |  364 +++++
> >>>    include/drm/drm_crtc_helper_vtable.h        |  483 ++++++
> >>>    include/drm/drm_encoder_helper_vtable.h     |  381 +++++
> >>>    include/drm/drm_mode_config_helper_vtable.h |   97 ++
> >>>    include/drm/drm_modeset_helper_vtables.h    | 1466 +------------------
> >>>    include/drm/drm_plane_helper_vtable.h       |  297 ++++
> >>>    6 files changed, 1627 insertions(+), 1461 deletions(-)
> >>>    create mode 100644 include/drm/drm_connector_helper_vtable.h
> >>>    create mode 100644 include/drm/drm_crtc_helper_vtable.h
> >>>    create mode 100644 include/drm/drm_encoder_helper_vtable.h
> >>>    create mode 100644 include/drm/drm_mode_config_helper_vtable.h
> >>>    create mode 100644 include/drm/drm_plane_helper_vtable.h

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
