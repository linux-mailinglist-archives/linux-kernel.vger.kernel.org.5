Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3480F9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377670AbjLLWEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjLLWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:04:05 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BFCBC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:04:09 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d3644ca426so61204037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702418649; x=1703023449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJY8C1DWpCBLWloqWzk5/jPg3401/emPFTGMZQJWPSo=;
        b=vWZqK1nSJ/ndzZnbSOaNrhi5bXQ6HGdV2Qc+EK/t3eIrPXK3NhLEZBYxfqJEoQe9AV
         U2V7UMNIsEb45n3VHHPLali6WlE8cy9D+Sw8POHX/5ST8XZPHkPcDvxfK9EazoKlY3ru
         HffOTO7zDZxHIY4PTKvv6Z0AjXhNf5tkBttNIknshWGfSZ9KmhVMjzJM4mBDU1hKrenI
         kSfwOnH2ufq8tjZVpAuz+lgWbbVaGh7j6IwPqfBaQxypBXcGW7TP8vapY4Z1YSlwS6Gy
         DveZ/ohhFqRY/0FMRpiBuLCr/+FreWyANWbgr9iLoBX9s4OaUwkTTd1GIA6/hUizDdnO
         YUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702418649; x=1703023449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJY8C1DWpCBLWloqWzk5/jPg3401/emPFTGMZQJWPSo=;
        b=GoMLntw4Vg6V82E58oui8nS++NFtNnb6Dr4iW/voZZbSowRLdp7Z7sq+G8wRJ+VlYD
         IfZtB5GF1d0qoP4TkQ5Z0qmc9kh2tctFqLgCxH/vpnVsnT7Sxg0TpWZMjFVQykIju+q7
         K74yER6vU/C2MBhecbIu3rorkTNeqv5g2JlJB/RHmuvIPBDCDM2TH2W6wafXYOlTPsuo
         RrFcxMd4j8iCWr6lZJR0m3ULWIQTaM7vd63dgWurMvgK/wKaeGULb14YEMJzVPljAKMd
         zyYbxajPDm3fa2ZPWYfebf4T17XmL7TF8ihekiPsezQu0xSOZdaIjv+oMFzHHMA+RSZp
         Noow==
X-Gm-Message-State: AOJu0Yz8ZnImVjntXDoclrt45dfM33ISRRZsOzbZ+g2dJ7ShiJ80f5Zu
        bNZeM8WocT0jECLb9tg2nYfsnmxN5BYjWVzxLOumgw==
X-Google-Smtp-Source: AGHT+IEc9UlLnCrtenTjOxWpVWAwvAo/nKTuRt+2QrFiV7c4g5vWp+h3pcwwc+ssUoUZ+HBsOHFMUA722GrCgvfWqSg=
X-Received: by 2002:a81:52cd:0:b0:5e2:834e:7f76 with SMTP id
 g196-20020a8152cd000000b005e2834e7f76mr441125ywb.41.1702418648867; Tue, 12
 Dec 2023 14:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20231212205254.12422-1-quic_abhinavk@quicinc.com>
 <20231212205254.12422-2-quic_abhinavk@quicinc.com> <CAA8EJpr4X3RLFPfgfnsA+UpiOkV0eRzw_FnrEFykS908YuV9Aw@mail.gmail.com>
In-Reply-To: <CAA8EJpr4X3RLFPfgfnsA+UpiOkV0eRzw_FnrEFykS908YuV9Aw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 13 Dec 2023 00:03:57 +0200
Message-ID: <CAA8EJpooSO3vR+Kp+XHgwOwQy43CKdUsOJOD3LiQ1LxbyW_39w@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] drm/msm/dpu: add formats check for writeback encoder
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 23:30, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 12 Dec 2023 at 22:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >
> > In preparation for adding more formats to dpu writeback add
> > format validation to it to fail any unsupported formats.
> >
> > changes in v4:
> >         - change the failure message of the API
> >           drm_atomic_helper_check_wb_connector_state() to a generic
> >           one in case it checks more errors later and moreoever it
> >           already has debug message to indicate its failure
> >         - change the corresponding DPU_ERROR to DPU_DEBUG in-line with
> >           other atomic_check failure messages
> >
> > changes in v3:
> >         - rebase on top of msm-next
> >         - replace drm_atomic_helper_check_wb_encoder_state() with
> >           drm_atomic_helper_check_wb_connector_state() due to the
> >           rebase
> >
> > changes in v2:
> >         - correct some grammar in the commit text
> >
> > Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> > index bb94909caa25..4953d87affa1 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> > @@ -272,6 +272,7 @@ static int dpu_encoder_phys_wb_atomic_check(
> >  {
> >         struct drm_framebuffer *fb;
> >         const struct drm_display_mode *mode = &crtc_state->mode;
> > +       int ret;
> >
> >         DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
> >                         phys_enc->hw_wb->idx, mode->name, mode->hdisplay, mode->vdisplay);
> > @@ -308,6 +309,12 @@ static int dpu_encoder_phys_wb_atomic_check(
> >                 return -EINVAL;
> >         }
> >
> > +       ret = drm_atomic_helper_check_wb_connector_state(conn_state->connector, conn_state->state);
> > +       if (ret < 0) {
> > +               DPU_DEBUG("wb check connector state failed ret = %d\n", ret);
>
> We already have a debug message in
> drm_atomic_helper_check_wb_connector_state(). Can we please drop this
> one?

If you don't mind, I can just drop it while applying

>
> > +               return ret;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.40.1
> >
>
>
> --
> With best wishes
> Dmitry



-- 
With best wishes
Dmitry
