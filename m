Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2078BBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjH2AHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjH2AGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:06:33 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C7EE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:06:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d77b9d574f8so3400291276.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693267589; x=1693872389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NyT3vK31IPrSFR9t47ow0q9aTbU6VUd3gAc2WbXeYIQ=;
        b=K49qP+RM+YGZHGLGfDOZcQrv7y2Rk03KlmSBNaPaApU27Z4ONen0XHzXfbnQAdgL7O
         41VoyK9oeL86CRyFBvsxyp0i6pkNSAqdKLXD+1r5pCFLiCcoZLQ80MCtrxAh8Pkuy6fC
         0/9d9lYaD33NSvbcYCBzEL4pkoAwpuVM7zAhrRHiWzy0kV7r3UEfMCD8wXrhmjlMbTRq
         kMzy972lhQo53GP+k8zs+uXsFSECdnSI2f5EiOUQixq/4L/ORVEXAyzJ0ud9ylCaTboq
         dBVop0sMf9pQETQKP+BH07zEmH7l4p38O6DVEK0YycVazFAegp9EoaY7vYtbDYnHyBPr
         7HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693267589; x=1693872389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyT3vK31IPrSFR9t47ow0q9aTbU6VUd3gAc2WbXeYIQ=;
        b=QAKHeBH9EnsjbfZc8AhLlPVQJYOHGYZKx9yd6RMKR5yNyJf+0rOl6FA1Yu7esC7wub
         h31YxsgC/0MVU/Rzaerj2Sq/ZP+bJLJt6N44uDU5wqXeCgi8qdBTvGkF5066mK7UYLOg
         jqrbKDM8H7SwJ9zFSGU2ZP0kocxoU4Mqn+U/l3we1hzb94Gtyij8bCrM6mH8UczhVnBW
         uwEo/uUsTndusEElB6qdvKcq3EIUSDevBEFl3WfzMoaVT6jjvr1JwxU4ll1giLztEWdT
         plye1eD/HELkr/TQrs3MvDSxUp094hz5f7blQwQZWfIlBPMFAM5vyrrvHh2ExMm+Z/Dw
         QrBA==
X-Gm-Message-State: AOJu0Yz9CeeYGUMwOKYYSI6xTte4f+nX04eMWaeM2tbBHviZ6tENX0Q5
        sv3Qybk9Sfv8MJWW1In0Nx7hJBCaewiwclEAlsL1lg==
X-Google-Smtp-Source: AGHT+IEcaEy+asw8tMhYSo1Hv+7c+zGN66bTgKLzbphf2kb1mwQwkyFdO4JLRv0N94tRpZZoBCAjfW5Te4vzdnTQVtw=
X-Received: by 2002:a25:23cc:0:b0:d7b:2299:555a with SMTP id
 j195-20020a2523cc000000b00d7b2299555amr3714684ybj.17.1693267589082; Mon, 28
 Aug 2023 17:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com> <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
 <26b4bb91-8786-c7cf-a821-eb2b881a42ab@quicinc.com> <656526F6-C123-4A5A-9E62-6ED092474113@linaro.org>
 <1dfcd37e-11a6-fa77-6440-f0e6bd06998d@quicinc.com> <ae98c379-2ddb-6b4e-0de3-2b1c68a99ee7@quicinc.com>
In-Reply-To: <ae98c379-2ddb-6b4e-0de3-2b1c68a99ee7@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Aug 2023 03:06:17 +0300
Message-ID: <CAA8EJpq8nPDHPsi+qEUTePCVFYR5xbn1_4Odoqmf5-rJioYmQA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane property
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 02:45, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
>
>
> On 8/8/2023 3:57 PM, Jessica Zhang wrote:
> >
> >
> > On 8/7/2023 6:07 PM, Dmitry Baryshkov wrote:
> >>
> >>
> >> On 8 August 2023 00:41:07 GMT+03:00, Jessica Zhang
> >> <quic_jesszhan@quicinc.com> wrote:
> >>>
> >>>
> >>> On 8/4/2023 6:27 AM, Dmitry Baryshkov wrote:
> >>>> On Fri, 28 Jul 2023 at 20:03, Jessica Zhang
> >>>> <quic_jesszhan@quicinc.com> wrote:
> >>>>>
> >>>>> Document and add support for solid_fill property to drm_plane. In
> >>>>> addition, add support for setting and getting the values for
> >>>>> solid_fill.
> >>>>>
> >>>>> To enable solid fill planes, userspace must assign a property blob to
> >>>>> the "solid_fill" plane property containing the following information:
> >>>>>
> >>>>> struct drm_mode_solid_fill {
> >>>>>           u32 version;
> >>>>>           u32 r, g, b;
> >>>>> };
> >>>>>
> >>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >>>>> ---
> >>>>>    drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
> >>>>>    drivers/gpu/drm/drm_atomic_uapi.c         | 55
> >>>>> +++++++++++++++++++++++++++++++
> >>>>>    drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
> >>>>>    include/drm/drm_blend.h                   |  1 +
> >>>>>    include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
> >>>>>    include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
> >>>>>    6 files changed, 154 insertions(+)
> >>>>>
> >>>>
> >>>> [skipped most of the patch]
> >>>>
> >>>>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> >>>>> index 43691058d28f..53c8efa5ad7f 100644
> >>>>> --- a/include/uapi/drm/drm_mode.h
> >>>>> +++ b/include/uapi/drm/drm_mode.h
> >>>>> @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
> >>>>>           char name[DRM_DISPLAY_MODE_LEN];
> >>>>>    };
> >>>>>
> >>>>> +/**
> >>>>> + * struct drm_mode_solid_fill - User info for solid fill planes
> >>>>> + *
> >>>>> + * This is the userspace API solid fill information structure.
> >>>>> + *
> >>>>> + * Userspace can enable solid fill planes by assigning the plane
> >>>>> "solid_fill"
> >>>>> + * property to a blob containing a single drm_mode_solid_fill
> >>>>> struct populated with an RGB323232
> >>>>> + * color and setting the pixel source to "SOLID_FILL".
> >>>>> + *
> >>>>> + * For information on the plane property, see
> >>>>> drm_plane_create_solid_fill_property()
> >>>>> + *
> >>>>> + * @version: Version of the blob. Currently, there is only support
> >>>>> for version == 1
> >>>>> + * @r: Red color value of single pixel
> >>>>> + * @g: Green color value of single pixel
> >>>>> + * @b: Blue color value of single pixel
> >>>>> + */
> >>>>> +struct drm_mode_solid_fill {
> >>>>> +       __u32 version;
> >>>>> +       __u32 r;
> >>>>> +       __u32 g;
> >>>>> +       __u32 b;
> >>>>
> >>>> Another thought about the drm_mode_solid_fill uABI. I still think we
> >>>> should add alpha here. The reason is the following:
> >>>>
> >>>> It is true that we have  drm_plane_state::alpha and the plane's
> >>>> "alpha" property. However it is documented as "the plane-wide opacity
> >>>> [...] It can be combined with pixel alpha. The pixel values in the
> >>>> framebuffers are expected to not be pre-multiplied by the global alpha
> >>>> associated to the plane.".
> >>>>
> >>>> I can imagine a use case, when a user might want to enable plane-wide
> >>>> opacity, set "pixel blend mode" to "Coverage" and then switch between
> >>>> partially opaque framebuffer and partially opaque solid-fill without
> >>>> touching the plane's alpha value.
> >>>
> >>> Hi Dmitry,
> >>>
> >>> I don't really agree that adding a solid fill alpha would be a good
> >>> idea. Since the intent behind solid fill is to have a single color
> >>> for the entire plane, I think it makes more sense to have solid fill
> >>> rely on the global plane alpha.
> >>>
> >>> As stated in earlier discussions, I think having both a
> >>> solid_fill.alpha and a plane_state.alpha would be redundant and serve
> >>> to confuse the user as to which one to set.
> >>
> >> That depends on the blending mode: in Coverage mode one has
> >> independent plane and contents alpha values. And I consider alpha
> >> value to be a part of the colour in the rgba/bgra modes.
> >
> > Acked -- taking Sebastian's concern into consideration, I think I'll
> > have "PIXEL_SOURCE_SOLID_FILL_RGB" and add a separate
> > "PIXEL_SOURCE_SOLID_FILL_RGBA".
>
> Hi Dmitry,
>
> Since it looks like there's still some ongoing discussion with Pekka
> about whether to support an RGBA solid fill source, I'll just leave a
> note to add an RGBA source in the future.

Sure! Let's get the basic framework landed. After that we can extend
it with RGBA, if that seems sensible.

>
> Thanks,
>
> Jessica Zhang
>
> >
> > Thanks,
> >
> > Jessica Zhang
> >
> >>
> >>
> >>>
> >>> Thanks,
> >>>
> >>> Jessica Zhang
> >>>
> >>>>
> >>>> --
> >>>> With best wishes
> >>>> Dmitry
> >>
> >> --
> >> With best wishes
> >> Dmitry



-- 
With best wishes
Dmitry
