Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FA7CBC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjJQHZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjJQHZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:25:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537EAAB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:25:27 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a82c2eb50cso45668257b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697527526; x=1698132326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlhxWtNcEtPdlgFrUV2Qe5Hlpzoe4VwBmwyo3n0xQ7Y=;
        b=JFJ2UgrdX7J1U/it2TBiA0kVHK/Hd+JGsBr6L6zwqhFG/bWv4arkKFbVMncihyEqPA
         JuvT97RC5ZdEDeXU6MfHzXvuRXEmCUsBhCbnyBH6EQO128TPT1J5/Zq/y5RKVIOxly9S
         eT1XMbTDyPc/LLeN3zC/zzWfA6QGQ5TFFlPwAefppAqU5skqxT28tkpHO13LzMf9hwps
         oep/iM4XXPK73CGdPtwQGrckZxOMdza7Gp7KjriS45mzvvuWxbA5xyLgVsOp6fNaXmFh
         +U70TIJDJPmshPu4nRPEG3I0BhhNLXcWGrqXq/sSKx9m0XxwE5aA8CPoS/3xLaXXuPFN
         xFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697527526; x=1698132326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlhxWtNcEtPdlgFrUV2Qe5Hlpzoe4VwBmwyo3n0xQ7Y=;
        b=dGqwa3zlFIFu7em2v6u1SmGnPnG3/DVpQEI9tZ7Ewbo17D22sFkFovLif209q9Q4Hq
         3nqIy/dbEpSnR/eD7/N12UoxybKPBb5bxo8ereymPQNn7Cy9FMue8jS0z8eyhRzljIW6
         RuQLwJxxqNQ5xseexR165T+Qzf6nrj9s1nYtC8LO0nS9kQKjJZMRCg+ZoH9I802uCPc2
         mIhrqEhoBcFgkND2+X1+qnimOA+f/oxQ4XaGeeKab4ETanG4aUeYn6O0jtEwaRLJQtp5
         dkZLYo8Y+/HV0Ev2u7P/U2LLpZJU+bhkSzvuAOo0ujmPX/8fX/E6lvyeX4s+cFhYgEJC
         GR6g==
X-Gm-Message-State: AOJu0YxYzceegLzxFFBhbW27tU5LL239zG+wytkS8JTOr8dyMtsPZenA
        FYh+k6ScA8hmkPb0vWSKpQD+rTzbLeI4MSbTRKWbzw==
X-Google-Smtp-Source: AGHT+IENnjJOV5JRk8GZZ8lld1NThYpPL3nSEbH7tZD0rqOcShuOqE0pwsLzTmY5xzyWjOahVXDxQJiH030g1Mf79EA=
X-Received: by 2002:a81:490b:0:b0:5a8:3f2:b538 with SMTP id
 w11-20020a81490b000000b005a803f2b538mr1472895ywa.37.1697527526514; Tue, 17
 Oct 2023 00:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
 <20230828-solid-fill-v6-7-a820efcce852@quicinc.com> <20230829112230.7106a8bf@eldfell>
 <752176d8-23f4-4689-8bf4-db27f153fd39@quicinc.com> <6851b864-447f-453f-8b34-1fbb6e97eefe@linaro.org>
 <26585954-7c86-45fd-9190-f1109cbe9901@quicinc.com>
In-Reply-To: <26585954-7c86-45fd-9190-f1109cbe9901@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 17 Oct 2023 10:25:14 +0300
Message-ID: <CAA8EJpoo4PSAzpjLcfdA0brNFZbTuCnv_HdztQ9Pnc_EnXgEmg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH RFC v6 07/10] drm/atomic: Loosen FB atomic checks
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        sebastian.wick@redhat.com, Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        quic_abhinavk@quicinc.com, Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        laurent.pinchart@ideasonboard.com, Daniel Vetter <daniel@ffwll.ch>,
        contact@emersion.fr,
        Marijn Suijten <marijn.suijten@somainline.org>,
        wayland-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Tue, 17 Oct 2023 at 03:41, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
> On 9/24/2023 3:23 AM, Dmitry Baryshkov wrote:
> > On 22/09/2023 20:49, Jessica Zhang wrote:
> >>
> >>
> >> On 8/29/2023 1:22 AM, Pekka Paalanen wrote:
> >>> On Mon, 28 Aug 2023 17:05:13 -0700
> >>> Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
> >>>
> >>>> Loosen the requirements for atomic and legacy commit so that, in cases
> >>>> where pixel_source != FB, the commit can still go through.
> >>>>
> >>>> This includes adding framebuffer NULL checks in other areas to
> >>>> account for
> >>>> FB being NULL when non-FB pixel sources are enabled.
> >>>>
> >>>> To disable a plane, the pixel_source must be NONE or the FB must be
> >>>> NULL
> >>>> if pixel_source == FB.
> >>>>
> >>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >>>> ---
> >>>>   drivers/gpu/drm/drm_atomic.c        | 20 +++++++++++---------
> >>>>   drivers/gpu/drm/drm_atomic_helper.c | 36
> >>>> ++++++++++++++++++++----------------
> >>>>   include/drm/drm_atomic_helper.h     |  4 ++--
> >>>>   include/drm/drm_plane.h             | 29
> >>>> +++++++++++++++++++++++++++++
> >>>>   4 files changed, 62 insertions(+), 27 deletions(-)
> >>>
> >>> ...
> >>>
> >>>> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> >>>> index a58f84b6bd5e..4c5b7bcdb25c 100644
> >>>> --- a/include/drm/drm_plane.h
> >>>> +++ b/include/drm/drm_plane.h
> >>>> @@ -992,6 +992,35 @@ static inline struct drm_plane
> >>>> *drm_plane_find(struct drm_device *dev,
> >>>>   #define drm_for_each_plane(plane, dev) \
> >>>>       list_for_each_entry(plane, &(dev)->mode_config.plane_list, head)
> >>>> +/**
> >>>> + * drm_plane_solid_fill_enabled - Check if solid fill is enabled on
> >>>> plane
> >>>> + * @state: plane state
> >>>> + *
> >>>> + * Returns:
> >>>> + * Whether the plane has been assigned a solid_fill_blob
> >>>> + */
> >>>> +static inline bool drm_plane_solid_fill_enabled(struct
> >>>> drm_plane_state *state)
> >>>> +{
> >>>> +    if (!state)
> >>>> +        return false;
> >>>> +    return state->pixel_source == DRM_PLANE_PIXEL_SOURCE_SOLID_FILL
> >>>> && state->solid_fill_blob;
> >>>> +}
> >>>> +
> >>>> +static inline bool drm_plane_has_visible_data(const struct
> >>>> drm_plane_state *state)
> >>>> +{
> >>>> +    switch (state->pixel_source) {
> >>>> +    case DRM_PLANE_PIXEL_SOURCE_NONE:
> >>>> +        return false;
> >>>> +    case DRM_PLANE_PIXEL_SOURCE_SOLID_FILL:
> >>>> +        return state->solid_fill_blob != NULL;
> >>>
> >>> This reminds me, new UAPI docs did not say what the requirements are for
> >>> choosing solid fill pixel source. Is the atomic commit rejected if
> >>> pixel source is solid fill, but solid_fill property has no blob?
> >>
> >> Hi Pekka,
> >>
> >> Yes, if pixel_source is solid_fill and the solid_fill property blob
> >> isn't set, the atomic commit should throw an error.
> >>
> >> Will document this in the UAPI.
> >
> > I don't see a corresponding error check in atomic_check() functions.
> > Could you please check that there is one, as you are updating the uAPI.
>
> Hi Dmitry,
>
> Sorry for the late response.

No worries.

>
> drm_plane_has_visible_data() is being called from
> drm_atomic_plane_check() which is called from drm_atomic_commit() (via
> drm_atomic_check_only()).
>
> It's also called within the atomic_check() callstack in
> drm_atomic_helper_check_plane_state(), though that check will set
> plane.visible to false and return 0.
>
> Would it be better to have a more explicit `if (source == solid_fill &&
> !plane->solid_fill_blob) then return -EINVAL` check in atomic_check()?

No. Your current code is good already. It was me who missed the
visible data check.
If you are going to send the next version for some reason, it might be
good to add a small comment to drm_atomic_helper_check_plane_state().
Something like 'check that the selected pixel source (fb, solid fill,
etc.) is valid'.

>
> Thanks,
>
> Jessica Zhang
>
> >
> >>
> >> Thanks,
> >>
> >> Jessica Zhang
> >>
> >>>
> >>> This should be doc'd.
> >>>
> >>>
> >>> Thanks,
> >>> pq
> >>>
> >>>> +    case DRM_PLANE_PIXEL_SOURCE_FB:
> >>>> +    default:
> >>>> +        WARN_ON(state->pixel_source != DRM_PLANE_PIXEL_SOURCE_FB);
> >>>> +    }
> >>>> +
> >>>> +    return state->fb != NULL;
> >>>> +}
> >>>> +
> >>>>   bool drm_any_plane_has_format(struct drm_device *dev,
> >>>>                     u32 format, u64 modifier);
> >>>>
> >>>
> >
> > --
> > With best wishes
> > Dmitry
> >



-- 
With best wishes
Dmitry
