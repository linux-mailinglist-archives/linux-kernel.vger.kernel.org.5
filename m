Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD17704AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjHDP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjHDP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:29:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C349CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:28:26 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d13e0bfbbcfso3287705276.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691162905; x=1691767705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOp+t06WK94f00hVoOjlTqLRBmqA68qFwjlm/n5u6Ec=;
        b=xHyAU5gFLrQk/gFvvaEuvE4iL524vBoq3VFKmFGmMrJmlrLhZ8ekaq6F3/eh661EnK
         UJx8eo2HkhJY/2v3qR0pPpqKEkGXXLOzA/IvPPkd+5jaEPwY1Ngv3Ljw4B/mGDWp6aJK
         U2OEf6+L1JpngBNlD6LdMhd5wf8Rx7GSYyBh3eQtosM8yz2CH69AJQohmY3pnrKAv2zn
         Yu6NCNB4LW4fzH5xJj4Kkt3EPcv8LFnL16A+0GbnMWkHwa6PHFgSRbJlFmYNrQTwnFCw
         fQwlAwv2JxvwaL/Gi26pgvLI04zes8zfaEXA0T6hfuDa/bxieF4/dpfgGKWORaWxaDyO
         bvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162905; x=1691767705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOp+t06WK94f00hVoOjlTqLRBmqA68qFwjlm/n5u6Ec=;
        b=Z+PUaO2XxCyKOSFQkmZt+8A4nNY8ZiulT2zHhc17y0DT8yPRb1k/OjnTwyX+4vxGbz
         vebsSlW07v8MnBufYviokAKSBtMZXtUXpKEcWhhy9Af1XamOVUK40DcMPYY4i40aL+GG
         ShaHosmFnlHEWXkWxjS0N6+GGtmQjCV2yI7yd9mygk14Y7mtqReO71SClYzK9dfE9UPY
         Xl4gsh357BliDEyvuFaBNpZhIB3H6/ssr7zH25mo22h95FMs1zBU7F0BaZyVppaY5Yth
         eOMBg8HeT1Cek59NcIjIiMl9+bv8Aw/DDBuyw4wUtabmooOpL/e8RkJKlkWsp6MPY8Qj
         wZTw==
X-Gm-Message-State: AOJu0Yzq0ypBpBZFoiPOWLlD3RzUBxgK1Z56ZqpFdf1Ba/52kC822u3K
        ewL+9OpitkkUnMSoQyhEH8kolgDKnUq02tKVfK9v9Q==
X-Google-Smtp-Source: AGHT+IHqkYFEA1xwnINMzjY1othogdYg+XLYUdXpv/bsW9GIOBmficGrOej0iBqP7HOWy9w0haZ7t5epondlOjOTEac=
X-Received: by 2002:a25:fc5:0:b0:cee:639a:be94 with SMTP id
 188-20020a250fc5000000b00cee639abe94mr78778ybp.0.1691162905601; Fri, 04 Aug
 2023 08:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212208.102501-1-robdclark@gmail.com> <20230727212208.102501-14-robdclark@gmail.com>
In-Reply-To: <20230727212208.102501-14-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 4 Aug 2023 18:28:14 +0300
Message-ID: <CAA8EJpq-Z7vNJjQML6waeHOAvQ_1EtU0Zx5-9f_q9j-KyOq4Tg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] drm/msm/adreno: Switch to chip-id for
 identifying GPU
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liu Ying <victor.liu@nxp.com>, Rob Herring <robh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 00:23, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Since the revision becomes an opaque identifier with future GPUs, move
> away from treating different ranges of bits as having a given meaning.
> This means that we need to explicitly list different patch revisions in
> the device table.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c      |   2 +-
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |   2 +-
>  drivers/gpu/drm/msm/adreno/a5xx_power.c    |   2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  14 ++-
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 137 +++++++++++----------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  14 +--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  49 ++++----
>  7 files changed, 115 insertions(+), 105 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
