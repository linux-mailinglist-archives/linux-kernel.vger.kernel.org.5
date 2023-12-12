Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D380F964
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377451AbjLLVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377450AbjLLVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:30:08 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AABCB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:30:14 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d3644ca426so60860047b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702416613; x=1703021413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VlpWbvexUhGlHNJAFDVrmVYt7WuM+enr1YTAW9UOGnA=;
        b=a48PMt4j87C/YIiqP3Gl7lv0zvMNW8GTEgxtcekfkKQngp7S/1XLfROU/c71KABHuV
         G2PGyYxhP5IbZQQn8+ucCu0WvEAwUXh+EjBIC+VIpO3BpctiZwedJELqxmeKdbVu1n3I
         rEx+EGYwL2LUcj6CI5MeVku4SsbT8oatrwK8/tGP045a8zFCi0YNHYlVn4BPVCEGYoy+
         kfeFeCCVL6zz/Cl5WEEtdWwlYnCIxn1U7qL+E0frWzuRNqloGgHLIJTYFzUpe61yKrgw
         /ZYUogCUw+WGFYoQh4JPW3mhVcccQN+WqAaLfcPodwWp/1FjQ6oJHxzU/GuevkyUF/xW
         HVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416613; x=1703021413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlpWbvexUhGlHNJAFDVrmVYt7WuM+enr1YTAW9UOGnA=;
        b=wOkRA2Nw34VVmtapi424428sRAfBuncgTETLd1zaXinAfu2e/zFuqgQqgay2lJAeRj
         R3Y+Ud09rybEFKIbOPSLZrrs6ZLYlbqMYXx/5/tj6Xww0lNgm0SqLb+UtE98DzRdwmVu
         +ZqNHFusPgFrlKpuczlhl1Oj3uLIi9Dis2HmL84KtDEddaF1Ie/hbZ8kZsz6O3/M29LA
         CjtLPvZ56V4+/fsGH1LpRVBbiPnmJ7ale1aDDCgua5NFn/Z6wd8YA68GhCW3g4jq80dq
         yuQf0B6Ogt7lmMk0oqcJQBNowZxdtbfNoP4WkZ7MB5tFrP3/Yjxh2UcQBtcsi327TpFR
         W2iA==
X-Gm-Message-State: AOJu0YwonAbY8xn7ik4fhuCswixl0C0OsZluX0xVSERpFGKDlID47ZnQ
        QI3bcMCt8OR4BGWC/Mti2ww/BxLfaM4/IUELKfD2Yw==
X-Google-Smtp-Source: AGHT+IFVTRFHws0SaSDJI9xyqMKzMyeyLxK9i288K/Z0ixqQ6uiz13KN6T617psbtjooIQibdRWE7rcO98w06LywAx4=
X-Received: by 2002:a81:a00d:0:b0:5e1:a14f:4648 with SMTP id
 x13-20020a81a00d000000b005e1a14f4648mr2051555ywg.89.1702416613198; Tue, 12
 Dec 2023 13:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20231212205254.12422-1-quic_abhinavk@quicinc.com> <20231212205254.12422-2-quic_abhinavk@quicinc.com>
In-Reply-To: <20231212205254.12422-2-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 23:30:02 +0200
Message-ID: <CAA8EJpr4X3RLFPfgfnsA+UpiOkV0eRzw_FnrEFykS908YuV9Aw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 22:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> In preparation for adding more formats to dpu writeback add
> format validation to it to fail any unsupported formats.
>
> changes in v4:
>         - change the failure message of the API
>           drm_atomic_helper_check_wb_connector_state() to a generic
>           one in case it checks more errors later and moreoever it
>           already has debug message to indicate its failure
>         - change the corresponding DPU_ERROR to DPU_DEBUG in-line with
>           other atomic_check failure messages
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
> index bb94909caa25..4953d87affa1 100644
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
> +               DPU_DEBUG("wb check connector state failed ret = %d\n", ret);

We already have a debug message in
drm_atomic_helper_check_wb_connector_state(). Can we please drop this
one?

> +               return ret;
> +       }
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
