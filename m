Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5096980E45F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjLLGkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:40:33 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADDBCB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 22:40:40 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5c85e8fdd2dso51929937b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 22:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702363239; x=1702968039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lcEihlupVu268DH+1hoAuEO92XmVKwEZxV6GmYSg0is=;
        b=E0gFxP/51ysGH1haapRzeez/0OhW6DggLsPy7QbZ8jf3jlJPzsANmA3DLdgRh+KAIw
         2cBRv41tqJoujo1VfJWLyycexCVNQtkQvZxVPOkG1H7aC1mFhE/RZ35EDRN0pDUT6L/b
         NBW1JgeRPpNHSi5Xsxc+WAyvZfN8I34NN3jIs2OFJjNmZbeRIGYuxtps02+N/4Z9csrD
         tK5HGarcHrvmxSCrks8kW4tv6Fy2KujbmgCuTDImFPEtiKtbPqcMIoYQjjwavKM6rEcW
         WFwb7e1VBOJrxeyKc09lSst3RZxLH1mGYx5/PN0b3ZRWY6L5MShUBtz+nzvdmK1vTamd
         PV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702363239; x=1702968039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcEihlupVu268DH+1hoAuEO92XmVKwEZxV6GmYSg0is=;
        b=toJA+RpE+EgeRV6NW/Xlp/emHLRmGiryIZZvDHUo1GseC0kAWfxaPNv6Dl+CAK4kCT
         VBfTFRuXkDpQ+kg0+4Cy0SnPuwPvGBS+s3I+WgAe7fUDq6V4gWKjZrSDZb1Pz2g8ccPK
         GcoCorcOyW2nX5A/0GqFhZDOvpvUE33Sxl/8Jy3XHh1AmgNIxyy7x2vfCJqPpBci4X+B
         woA8fTDHgUNtxbjb1j8Qtf46DBrgqqhhN3SDMLPvfEWrm0qNJoC2L/m2cQHOHRLYun20
         qh4I9+VLw0Lm+quODC9hoe3IYF1ryR3sVcT4OyB5epyy3GqPcGrCEHWfIeiDSU8B661q
         iDVg==
X-Gm-Message-State: AOJu0Yz6hbAP8GNs5uuHxMRt/Lu2xxVHQ0gZWWW1sxAVS6rLntharLFT
        7mN8r44INyEMCcEZny29euF6Ov5JUrmvsq/fhtr0Yg==
X-Google-Smtp-Source: AGHT+IGvdM5RN8xlu8UqMlYeZbm9dcOMR2ckPy/eZiaBukMGeBzh2gvRdEC6oHdspw1yXZaOd4HQflJN0ZoVqg9U260=
X-Received: by 2002:a0d:f943:0:b0:5d7:1940:dd69 with SMTP id
 j64-20020a0df943000000b005d71940dd69mr4160485ywf.63.1702363239266; Mon, 11
 Dec 2023 22:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com> <20231212002245.23715-2-quic_abhinavk@quicinc.com>
In-Reply-To: <20231212002245.23715-2-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 08:40:28 +0200
Message-ID: <CAA8EJpqJOh0R1X3i1UGe9hHoezV4uBNDCWPFSdeuXyC6Ju4eHA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] drm/msm/dpu: add formats check for writeback encoder
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 02:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> In preparation for adding more formats to dpu writeback add
> format validation to it to fail any unsupported formats.
>
> changes in v3:
>         - rebase on top of msm-next
>         - replace drm_atomic_helper_check_wb_encoder_state() with
>           drm_atomic_helper_check_wb_connector_state() due to the
>           rebase
>
> changes in v2:
>         - correct some grammar in the commit text
>
> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index bb94909caa25..425415d45ec1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -272,6 +272,7 @@ static int dpu_encoder_phys_wb_atomic_check(
>  {
>         struct drm_framebuffer *fb;
>         const struct drm_display_mode *mode = &crtc_state->mode;
> +       int ret;
>
>         DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
>                         phys_enc->hw_wb->idx, mode->name, mode->hdisplay, mode->vdisplay);
> @@ -308,6 +309,12 @@ static int dpu_encoder_phys_wb_atomic_check(
>                 return -EINVAL;
>         }
>
> +       ret = drm_atomic_helper_check_wb_connector_state(conn_state->connector, conn_state->state);
> +       if (ret < 0) {
> +               DPU_ERROR("invalid pixel format %p4cc\n", &fb->format->format);
> +               return ret;
> +       }

There is no guarantee that there will be no other checks added to this
helper. So, I think this message is incorrect. If you wish, you can
promote the level of the message in the helper itself.
On the other hand, we rarely print such messages by default. Most of
the checks use drm_dbg.

> +
>         return 0;
>  }
>
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
