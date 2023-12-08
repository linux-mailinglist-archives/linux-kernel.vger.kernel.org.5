Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8453C80A1EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573709AbjLHLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjLHLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:13:23 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C809F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:13:29 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d747dbf81eso17013797b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702034008; x=1702638808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt7VH34vIXt25vrgUruA60BaGXHVidQ+RAFVzJPEkF8=;
        b=HrS+LEaTPmWq+dwQ1SAV/2wwDdbPRyp+zf+D9Gb7JwjRXbZ125v9N4VjuiR8jVjXJC
         U1wE3R2YDaEGch5PRNn6GD3SKcXMV6BaSUOIiIip0ZmLq4PR7B4Xk5pG/NP2ioNQ7XFw
         d78W5EkTfwJXEuBHIAVzlUmHkF+DkjWC+Aizy905pA9W0MInsBOVyQamB5kU63Yo3PXw
         A+gZoPLVQKuOPDtEaJrReFaSX04ccrkJ2y28gz4KXPzZpAx7ug8lEPBPKQS2pv9AS7vv
         91/Ng9g6rtJMgxmotM5hGYES6wYjHKLAKV+/1yNg3PSlEO9qlb6Gklm0w3CMxj72nPKA
         kOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702034008; x=1702638808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yt7VH34vIXt25vrgUruA60BaGXHVidQ+RAFVzJPEkF8=;
        b=v4RVm+yT3sCgOVZYsvc4NNl4YeF6DMp1USWDJbn0xx4CSaEnrvjk50p/wlj8JteGJO
         8ehfKwv/VZLjCgjYTWxk470iC2oOFaZ7dLAfUJsx4xYaMiz60o/P+hQH/1wvPnQKKXyM
         TgD8FuCdSO06ZL/ZqezK0hOavymh8E6fEr8emLNDMJeKi28w3eZVXuaDyPjlEQyD93wc
         2kau3AQReoc6FHOhaQQfmPHE9Gfg1QzlMVOEl8ssyT6j/08C5u2j/J7aprH4CtKfpuqp
         pFnh49y1eMqyIDi/lrTY0+9icXdnb22FFxLtSRvPD8t7VumJhqN2lG5tEZbZ5qT/4fgt
         Dkqg==
X-Gm-Message-State: AOJu0YyLcO1gIJhZzEey1PMu9gUyKs+v+dvNsmAb4XLhO2IQ7sdPzoCv
        eLtD3J3iqI5VL3P2CfTx04jQzOeRUhXKjidv7G7RrQ==
X-Google-Smtp-Source: AGHT+IEgLxut2LZKFwy8YPZiuTpL0zQRaZYu54PpvxGKqsQUheHzwcxxpJkcW4s18OsvT+SKUHlcC/jSfnNlgNEOLcg=
X-Received: by 2002:a81:aa0d:0:b0:5d3:d439:aabe with SMTP id
 i13-20020a81aa0d000000b005d3d439aabemr3762797ywh.26.1702034008459; Fri, 08
 Dec 2023 03:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-6-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-6-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:13:17 +0200
Message-ID: <CAA8EJpqpWxO=GjSp-CKRD2Vy89FxBPmDWNhPstfF=_y-xHvV_A@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] drm/msm/dpu: add cdm blocks to sc7280 dpu_hw_catalog
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
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

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Add CDM blocks to the sc7280 dpu_hw_catalog to support
> YUV format output from writeback block.
>
> changes in v2:
>         - remove explicit zero assignment for features
>         - move sc7280_cdm to dpu_hw_catalog from the sc7280
>           catalog file as its definition can be re-used
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h  |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c      | 10 ++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h      | 13 +++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h         |  5 +++++
>  4 files changed, 29 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
