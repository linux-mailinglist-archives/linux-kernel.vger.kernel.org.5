Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9780B145
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574829AbjLIBKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjLIBKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:10:20 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37CDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:10:26 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db979bbae81so2640632276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 17:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702084225; x=1702689025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0cF4qScOHAj/rLxoLFVp+qFWMH6QJDJ7/2vWSbDCts=;
        b=pzCKJ9jTPUpIMrhI/6Zc8yC/Wv15STEJNx5GwYDSQIj0iCMdQRE6eqIZRP+BWTEoJv
         q2cIyu0XYKY0m6zVEND86LrsJxhz2prIoqeWYTsCNkKHwnkyxEhzwPtpY3qD3TthNpb9
         J5evHU4yiHrJaY42IiC+1O/j62JmUfJana1fgDsgJOQR20FaNopzfvr0m7uFzh3EoMQo
         pYBKEjW+wRo4FgF1vbeO9To5XVeZDgj2Fp0NPqaZTkn1zHVT/9gL4s72fyWYbL9kP35P
         2aTGKlKaVFO4kh5mD/5Eok8vKKlDkpFapTBy/62uMLQtsfDnqIk8/tYD4DmyCxxo/4eB
         hUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702084225; x=1702689025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0cF4qScOHAj/rLxoLFVp+qFWMH6QJDJ7/2vWSbDCts=;
        b=TzcVgvfs8cFvkNo4KBTtzN+94THdo7xG0ss130hytzkk0Q7V5jfmizJidFpkXc6tjb
         SzcQuTBvWcgkphZwS1L7cYiJ4t58OL0kp+yhjjQLvuOz/wTD02OK12FMrXaLJdV58L0y
         PC8prh+22nVTDZr6Z7es8Io21Ubueu0dnit6yVO1W4OY/PBlMvFU1bjptvWNBLYuokCO
         uco6rTG8VQGGSd411r5SCfdiPeQ3P85GpVYzsNuuZKnOfRMjFdOst0InKttEQgYFWw+d
         fAHEHRJ8PiBonj8FWUjEkvKE3oLEVohoUd5nHaT5YhKOlAH+gBdoA8RrCGv60E7zLKUi
         ygiA==
X-Gm-Message-State: AOJu0YyzViEjYa9hm+5RfYmL3dAccqqZ+0w4IB9eFLq/MVxHnFqSq8CR
        A8/seTLq6P6aGKe0owHGOCZ7cAWalHc7CK2YfNy9iQ==
X-Google-Smtp-Source: AGHT+IE10CwOce+2KoAJ+PwLPbS+wUqMMVGjhX0LH+NrP3xaVKzWzDZCe0cUxHTmX7XaO7p9EheS4HCqbz6bkiWDqao=
X-Received: by 2002:a25:27c3:0:b0:db9:565f:caf5 with SMTP id
 n186-20020a2527c3000000b00db9565fcaf5mr576625ybn.115.1702084225102; Fri, 08
 Dec 2023 17:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
 <20231208050641.32582-16-quic_abhinavk@quicinc.com> <CAA8EJpqfCfETawp1up76S6gryO+Q4KxPB3ThwZCe7DCkp=GkBQ@mail.gmail.com>
 <8eea4a8e-0c70-3768-79f0-1a2bfe083ed7@quicinc.com> <CAA8EJpoLzgwEYRcSKZUY1W9KUE9s3WR_bzpA3hmf5X9JGDGutA@mail.gmail.com>
 <1ab1862b-f486-00ee-91b4-ae20ff9e4321@quicinc.com>
In-Reply-To: <1ab1862b-f486-00ee-91b4-ae20ff9e4321@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 9 Dec 2023 03:10:13 +0200
Message-ID: <CAA8EJpouJRgaL9gwfRAgNdaxT82DshsmYpQba6m_oNdSXp_i8g@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] drm/msm/dpu: introduce separate wb2_format
 arrays for rgb and yuv
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2023 at 01:09, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/8/2023 12:45 PM, Dmitry Baryshkov wrote:
> > On Fri, 8 Dec 2023 at 19:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >> On 12/8/2023 3:44 AM, Dmitry Baryshkov wrote:
> >>> On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>>
> >>>> Lets rename the existing wb2_formats array wb2_formats_rgb to indicate
> >>>> that it has only RGB formats and can be used on any chipset having a WB
> >>>> block.
> >>>>
> >>>> Introduce a new wb2_formats_rgb_yuv array to the catalog to
> >>>> indicate support for YUV formats to writeback in addition to RGB.
> >>>>
> >>>> Chipsets which have support for CDM block will use the newly added
> >>>> wb2_formats_rgb_yuv array.
> >>>
> >>> This means that the catalog can go out of sync, if one adds a CDM
> >>> block but doesn't update wb_formats and vice versa.
> >>> Can we deduce the format list from the WB code? Is the format list
> >>> really static or does it change between platforms (please keep msm8996
> >>> / msm8998 in mind).
> >>>
> >>
> >> Yes this is a valid concern. catalog could potentially go out of sync.
> >>
> >> I checked a few chipsets now and the WB formats didnt change among them.
> >>
> >> I do need to check more chipsets but downstream does not maintain this
> >> in devicetree which means we can just move these arrays to WB code
> >> instead of maintaining them in the catalog.
> >
> > I think we should be comparing to some of the oldest generations, like
> > msm8998/sdm660 or ideally even msm8996/37/17/53.
> >
>
> I compared msm8998 just now and it does have different wb2 formats
> supported as compared to sc7280/sm8250.
>
> So unfortunately, this will have to remain in catalog for now.
>
> >> We will still need to maintain two arrays. One to be used if CDM block
> >> has been added and the other if not.
> >
> > Yes.
> >
>
> >> I must confess one point though. I have not seen any chipset yet where
> >> WB block is present but CDM block is not.
> >
> > I think this was the case for some of mdp5 1.x chips, but according to
> > my data this is correct for all the platforms that we want to support.
> >
> >> So at this point, the only purpose of the two arrays will be till the
> >> point where CDM blk has been added to all the required chipsets in the
> >> catalog. Then we can drop the RGB only array and maintain the one which
> >> has all formats.
> >>
>
> I think if we have to generalize this, some more study is needed of how
> to maintain this in the catalog without missing out on some more
> formats. But for now, what do you think of below approach:

As the list of formats differ from platform to platform, I'm fine with
listing them in the catalog (as we do with your patchset). Later we
can generalise or clean that up.

>
> 1) We have these two arrays as I have added these only for sc7280/sm8250
> and have confirmed that the formats listed there are accurate. At the
> very least, they do not expose more formats than what is supported. So
> even if someone adds CDM for other chipsets, they can re-use
> wb2_formats_rgb_and_yuv. It will certainly work just that its not the
> full list of supported formats.
>
> 2) Even if we do add CDM to other chipsets, what I can confirm is this
> will not break them as the list of formats we have right now are only
> lesser than the full list and not more.
>
> 3) In the follow up RFT which we discussed in the cover letter, let me
> try to re-factor wb2_formats based on the list of chipsets that are
> present in catalog including the older ones you have listed.

Sounds good!
Thank you for checking the msm8998.

>
> The issue is wb2_formats (so writeback) and not CDM itself as these are
> supported WB formats. So I think we need to re-work this a bit.
>
> >>>>
> >>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>> ---
> >>>>    .../msm/disp/dpu1/catalog/dpu_10_0_sm8650.h   |  4 +-
> >>>>    .../msm/disp/dpu1/catalog/dpu_6_0_sm8250.h    |  4 +-
> >>>>    .../msm/disp/dpu1/catalog/dpu_6_2_sc7180.h    |  4 +-
> >>>>    .../msm/disp/dpu1/catalog/dpu_7_2_sc7280.h    |  4 +-
> >>>>    .../msm/disp/dpu1/catalog/dpu_9_0_sm8550.h    |  4 +-
> >>>>    .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 37 ++++++++++++++++++-
> >>>>    6 files changed, 46 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> >>>> index 04d2a73dd942..eb5dfff2ec4f 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> >>>> @@ -341,8 +341,8 @@ static const struct dpu_wb_cfg sm8650_wb[] = {
> >>>>                   .name = "wb_2", .id = WB_2,
> >>>>                   .base = 0x65000, .len = 0x2c8,
> >>>>                   .features = WB_SM8250_MASK,
> >>>> -               .format_list = wb2_formats,
> >>>> -               .num_formats = ARRAY_SIZE(wb2_formats),
> >>>> +               .format_list = wb2_formats_rgb,
> >>>> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb),
> >>>>                   .xin_id = 6,
> >>>>                   .vbif_idx = VBIF_RT,
> >>>>                   .maxlinewidth = 4096,
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> >>>> index 58b0f50518c8..a57d50b1f028 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> >>>> @@ -336,8 +336,8 @@ static const struct dpu_wb_cfg sm8250_wb[] = {
> >>>>                   .name = "wb_2", .id = WB_2,
> >>>>                   .base = 0x65000, .len = 0x2c8,
> >>>>                   .features = WB_SM8250_MASK,
> >>>> -               .format_list = wb2_formats,
> >>>> -               .num_formats = ARRAY_SIZE(wb2_formats),
> >>>> +               .format_list = wb2_formats_rgb_yuv,
> >>>> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
> >>>>                   .clk_ctrl = DPU_CLK_CTRL_WB2,
> >>>>                   .xin_id = 6,
> >>>>                   .vbif_idx = VBIF_RT,
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> >>>> index bcfedfc8251a..7382ebb6e5b2 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> >>>> @@ -157,8 +157,8 @@ static const struct dpu_wb_cfg sc7180_wb[] = {
> >>>>                   .name = "wb_2", .id = WB_2,
> >>>>                   .base = 0x65000, .len = 0x2c8,
> >>>>                   .features = WB_SM8250_MASK,
> >>>> -               .format_list = wb2_formats,
> >>>> -               .num_formats = ARRAY_SIZE(wb2_formats),
> >>>> +               .format_list = wb2_formats_rgb,
> >>>> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb),
> >>>>                   .clk_ctrl = DPU_CLK_CTRL_WB2,
> >>>>                   .xin_id = 6,
> >>>>                   .vbif_idx = VBIF_RT,
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> >>>> index 19c2b7454796..2f153e0b5c6a 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> >>>> @@ -169,8 +169,8 @@ static const struct dpu_wb_cfg sc7280_wb[] = {
> >>>>                   .name = "wb_2", .id = WB_2,
> >>>>                   .base = 0x65000, .len = 0x2c8,
> >>>>                   .features = WB_SM8250_MASK,
> >>>> -               .format_list = wb2_formats,
> >>>> -               .num_formats = ARRAY_SIZE(wb2_formats),
> >>>> +               .format_list = wb2_formats_rgb_yuv,
> >>>> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
> >>>>                   .clk_ctrl = DPU_CLK_CTRL_WB2,
> >>>>                   .xin_id = 6,
> >>>>                   .vbif_idx = VBIF_RT,
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> >>>> index bf56265967c0..ad48defa154f 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> >>>> @@ -315,8 +315,8 @@ static const struct dpu_wb_cfg sm8550_wb[] = {
> >>>>                   .name = "wb_2", .id = WB_2,
> >>>>                   .base = 0x65000, .len = 0x2c8,
> >>>>                   .features = WB_SM8250_MASK,
> >>>> -               .format_list = wb2_formats,
> >>>> -               .num_formats = ARRAY_SIZE(wb2_formats),
> >>>> +               .format_list = wb2_formats_rgb,
> >>>> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb),
> >>>>                   .xin_id = 6,
> >>>>                   .vbif_idx = VBIF_RT,
> >>>>                   .maxlinewidth = 4096,
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>>> index 1be3156cde05..c52cac7a2288 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >>>> @@ -202,7 +202,7 @@ static const u32 rotation_v2_formats[] = {
> >>>>           /* TODO add formats after validation */
> >>>>    };
> >>>>
> >>>> -static const uint32_t wb2_formats[] = {
> >>>> +static const uint32_t wb2_formats_rgb[] = {
> >>>>           DRM_FORMAT_RGB565,
> >>>>           DRM_FORMAT_BGR565,
> >>>>           DRM_FORMAT_RGB888,
> >>>> @@ -236,6 +236,41 @@ static const uint32_t wb2_formats[] = {
> >>>>           DRM_FORMAT_XBGR4444,
> >>>>    };
> >>>>
> >>>> +static const uint32_t wb2_formats_rgb_yuv[] = {
> >>>> +       DRM_FORMAT_RGB565,
> >>>> +       DRM_FORMAT_BGR565,
> >>>> +       DRM_FORMAT_RGB888,
> >>>> +       DRM_FORMAT_ARGB8888,
> >>>> +       DRM_FORMAT_RGBA8888,
> >>>> +       DRM_FORMAT_ABGR8888,
> >>>> +       DRM_FORMAT_XRGB8888,
> >>>> +       DRM_FORMAT_RGBX8888,
> >>>> +       DRM_FORMAT_XBGR8888,
> >>>> +       DRM_FORMAT_ARGB1555,
> >>>> +       DRM_FORMAT_RGBA5551,
> >>>> +       DRM_FORMAT_XRGB1555,
> >>>> +       DRM_FORMAT_RGBX5551,
> >>>> +       DRM_FORMAT_ARGB4444,
> >>>> +       DRM_FORMAT_RGBA4444,
> >>>> +       DRM_FORMAT_RGBX4444,
> >>>> +       DRM_FORMAT_XRGB4444,
> >>>> +       DRM_FORMAT_BGR565,
> >>>> +       DRM_FORMAT_BGR888,
> >>>> +       DRM_FORMAT_ABGR8888,
> >>>> +       DRM_FORMAT_BGRA8888,
> >>>> +       DRM_FORMAT_BGRX8888,
> >>>> +       DRM_FORMAT_XBGR8888,
> >>>> +       DRM_FORMAT_ABGR1555,
> >>>> +       DRM_FORMAT_BGRA5551,
> >>>> +       DRM_FORMAT_XBGR1555,
> >>>> +       DRM_FORMAT_BGRX5551,
> >>>> +       DRM_FORMAT_ABGR4444,
> >>>> +       DRM_FORMAT_BGRA4444,
> >>>> +       DRM_FORMAT_BGRX4444,
> >>>> +       DRM_FORMAT_XBGR4444,
> >>>> +       DRM_FORMAT_NV12,
> >>>> +};
> >>>> +
> >>>>    /*************************************************************
> >>>>     * SSPP sub blocks config
> >>>>     *************************************************************/
> >>>> --
> >>>> 2.40.1
> >>>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry
