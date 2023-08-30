Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2AC78E37D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbjH3Xst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344548AbjH3Xss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:48:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A4198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:48:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d746ea563f9so90369276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693439317; x=1694044117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KIXBc71uKxSxe6iurnFTvwcLV9QQp1uK3k3HIPwq90Y=;
        b=hcXSBLqovlC6W6RiCEK+ctPph9DDVH4NGBNKaGx6TkSHf08MAUhR2MGrvn3Xh0vy2t
         cRzTITVjtHZnRKY2/C8UCafeNS9799hkCIJDVQCYTssWCjwlwxhPFXmGxX7ioZi1eNC6
         eVykABeuyU805Xp21m4wsGgKX823a523HieIwqzf2BPFgTjmUmeE+3nCXZ4q1dij4jLk
         igStNpLnAE1+TFzxx7dqfqnwlbroghQFB5UxAd2RFuhGa/RpfFDARjj72Fm0bWQ1cEqc
         G2Oq4Nw0rGceCxsjfpejy+GlTPphgTzTRk5OP2TxicfpE6yErXmodmZkmRBkT1BIRlns
         4FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693439317; x=1694044117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIXBc71uKxSxe6iurnFTvwcLV9QQp1uK3k3HIPwq90Y=;
        b=c+9OOZXnrX3fI1vD5DwwNFlhz05DjpOqr+yUlKVYUShZpzdGkjzV/QodORRkjo391v
         LQOBBEJFyKr8bcZG+HfUjZlpehmZAHx0MRuJHEYpEZIb5uExJ41fq364sEH/z/CYrmnf
         +QnXgd5LJMTOf14EXYeNIi/KZvzA0M80g4Dq1iJkYBi76WpYpGF2WzLcC9ST3gMESQd4
         QFL945X7DJXrku1Yc7Ew4OBpq45aigG5L80FlhwjB90ELOFuY3QQhbePuBJggktZmZfN
         gmpwRnBgtKhRl5I8CiEF8ky5T4Gj7Gwhn874z1+27M7mMkTxlqll1K571bW48bu2yC3v
         Ce1w==
X-Gm-Message-State: AOJu0Yz9uqcoCZeyADkl9v+mUcD0hDRswwDB2d91NXZ6HJ23My2rBdJK
        SB0jytiCSWQhsMNbi3haPEyWgBuhp3leZ+BnvYh1HA==
X-Google-Smtp-Source: AGHT+IHTzXVzK/5FqCy1xL2xl8K3p1akBKR/g7LahJuj92gVr2cLENA8eYL7vTXOPqWIdOjggJ8S+j+nCSqDTS2cWHk=
X-Received: by 2002:a25:9092:0:b0:d74:6163:db8c with SMTP id
 t18-20020a259092000000b00d746163db8cmr3737036ybl.41.1693439316955; Wed, 30
 Aug 2023 16:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com> <20230830224910.8091-8-quic_abhinavk@quicinc.com>
In-Reply-To: <20230830224910.8091-8-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 02:48:25 +0300
Message-ID: <CAA8EJpoRcdHtyp3mym5HB2A=O6V4qUNTpnMkvm+OiSt7nHuXJw@mail.gmail.com>
Subject: Re: [PATCH 07/16] drm/msm/dpu: add cdm blocks to RM
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Add the RM APIs necessary to initialize and allocate CDM
> blocks by the rest of the DPU pipeline.

... to be used by the rest?

>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index f9215643c71a..7b6444a3fcb1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -8,6 +8,7 @@
>  #include "dpu_kms.h"
>  #include "dpu_hw_lm.h"
>  #include "dpu_hw_ctl.h"
> +#include "dpu_hw_cdm.h"
>  #include "dpu_hw_pingpong.h"
>  #include "dpu_hw_sspp.h"
>  #include "dpu_hw_intf.h"
> @@ -90,6 +91,9 @@ int dpu_rm_destroy(struct dpu_rm *rm)
>                 }
>         }
>
> +       if (rm->cdm_blk)
> +               dpu_hw_cdm_destroy(to_dpu_hw_cdm(rm->cdm_blk));
> +
>         for (i = 0; i < ARRAY_SIZE(rm->hw_wb); i++)
>                 dpu_hw_wb_destroy(rm->hw_wb[i]);
>
> @@ -240,6 +244,19 @@ int dpu_rm_init(struct dpu_rm *rm,
>                 rm->hw_sspp[sspp->id - SSPP_NONE] = hw;
>         }
>
> +       if (cat->cdm) {
> +               struct dpu_hw_cdm *hw;
> +
> +               hw = dpu_hw_cdm_init(cat->cdm, mmio);
> +               /* CDM is optional so no need to bail out */
> +               if (IS_ERR(hw)) {
> +                       rc = PTR_ERR(hw);
> +                       DPU_DEBUG("failed cdm object creation: err %d\n", rc);

No. If it is a part of the catalog, we should fail here as we do in other cases.


> +               } else {
> +                       rm->cdm_blk = &hw->base;
> +               }
> +       }
> +
>         return 0;
>
>  fail:
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> index 2b551566cbf4..29b221491926 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> @@ -22,6 +22,7 @@ struct dpu_global_state;
>   * @hw_wb: array of wb hardware resources
>   * @dspp_blks: array of dspp hardware resources
>   * @hw_sspp: array of sspp hardware resources
> + * @cdm_blk: cdm hardware resource
>   */
>  struct dpu_rm {
>         struct dpu_hw_blk *pingpong_blks[PINGPONG_MAX - PINGPONG_0];
> @@ -33,6 +34,7 @@ struct dpu_rm {
>         struct dpu_hw_blk *merge_3d_blks[MERGE_3D_MAX - MERGE_3D_0];
>         struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
>         struct dpu_hw_sspp *hw_sspp[SSPP_MAX - SSPP_NONE];
> +       struct dpu_hw_blk *cdm_blk;

struct dpu_hw_cdm *cdm (or cdm_blk), please.

>  };
>
>  /**
> --
> 2.40.1
>


--
With best wishes
Dmitry
