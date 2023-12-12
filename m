Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4FD80E4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjLLHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:17:36 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98FA1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:17:43 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d6b9143782so47545457b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702365462; x=1702970262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TVT/VN6qzSaiQZWjp2ufbT3HoEBo3Ldac4YHEG+4eFk=;
        b=C8oFOrkrnQig3UG2RTHHrbOkAwi+6+Z0OAGFzr1UBzIyt0jeyZKw1VUoKi8A2dTcko
         1JTP3x5vAjhP02Y7V9D1L5LNgcIW1I5gJ/AAvhnQm25zR4G7QoaTfVDb0v1qVG58hVYk
         JthjdyUxtNER8/oAngxbACB7ynYfx3eArKamoJnJ9z4vBR894r4zkhCMqIYZRgkq7Q30
         jyS1Ay3f6R/ArmHYHlF61x64oycLGVG9KY2MKMM0OObi9bwSHBsIJwbsVdAwwOiwiEoP
         qKYxWo22qRLZqu/4PK+IJCMkuTSMgPa5nXRJQkJoUqh0qOzuIYTIaS2XkLSASu0HTU9l
         bhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702365462; x=1702970262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVT/VN6qzSaiQZWjp2ufbT3HoEBo3Ldac4YHEG+4eFk=;
        b=faCYg7Jqq8jJPqgh57qJ/530MLjtb8TLycXdLLnEtfj14nZoDDmTKnfU3VKyTpCPEh
         zODjQx8iby1GZU8bsLeW+17byEsDPa9LJq0WsTiO0aG7l+Uis+7SANHjDbzm0uEVpU9Q
         O9iPIAPmu0/ciZ3dH4AT1HzkR7CdXLfUBSROtvt6J6irQls6vNNcXOeUiDJVMdgkYMly
         y8HmH5GJCQzjjZcVhoKZVrFFqcLtzWP+hSF12e1VqxYy0PhMuTvf+0k//+FOBZjaMBrE
         7XXQwQ/eAmR/L80DEXvRSHgF9CJKt+A8pO3zAsHzKRmk2eWuwK0l0kzG3+NzDnG73n80
         ZTfQ==
X-Gm-Message-State: AOJu0Yy0etDLemFgIxO49t8ao0cTMomXj4djc5T7J57jha9xctg9ovAu
        mYxQqcrPjPZSv4AdNnYuB5hiCXhFf0W08/Wzb51rOQ==
X-Google-Smtp-Source: AGHT+IGdY+48fFdjXN2QvKpKjOQibG0qDG90jwUmBOaZ1dBjjCo4WU08VY6Au/aVmWsNr2/iTZ+jXH8kXiKlsPNtwjc=
X-Received: by 2002:a81:5fc5:0:b0:5de:a315:b72c with SMTP id
 t188-20020a815fc5000000b005dea315b72cmr4968084ywb.95.1702365462403; Mon, 11
 Dec 2023 23:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com> <20231212002245.23715-12-quic_abhinavk@quicinc.com>
In-Reply-To: <20231212002245.23715-12-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 09:17:31 +0200
Message-ID: <CAA8EJpqOFMoWd8OEBMVoJVe619+HVjq2w+uwTJG25PT7mrJ2jQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] drm/msm/dpu: add an API to setup the CDM block
 for writeback
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
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

On Tue, 12 Dec 2023 at 02:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Add an API dpu_encoder_helper_phys_setup_cdm() which can be used by
> the writeback encoder to setup the CDM block.
>
> Currently, this is defined and used within the writeback's physical
> encoder layer however, the function can be modified to be used to setup
> the CDM block even for non-writeback interfaces.
>
> Until those modifications are planned and made, keep it local to
> writeback.
>
> changes in v3:
>         - call bind_pingpong_blk() directly as disable() is dropped
>         - add dpu_csc10_rgb2yuv_601l to dpu_hw_util.h and use it
>         - fix kbot error on the function doc
>         - document that dpu_encoder_helper_phys_setup_cdm() doesn't handle
>           DPU_CHROMA_H1V2
>
> changes in v2:
>         - add the RGB2YUV CSC matrix to dpu util as needed by CDM
>         - use dpu_hw_get_csc_cfg() to get and program CSC
>         - drop usage of setup_csc_data() and setup_cdwn() cdm ops
>           as they both have been merged into enable()
>         - drop reduntant hw_cdm and hw_pp checks
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312102149.qmbCdsg2-lkp@intel.com/
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h  |  6 ++
>  .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   | 93 ++++++++++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h   | 14 +++
>  3 files changed, 112 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


--
With best wishes
Dmitry
