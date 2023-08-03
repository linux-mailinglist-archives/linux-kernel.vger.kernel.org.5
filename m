Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3646276F44C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjHCUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjHCUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:53:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821411F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:53:07 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so1526857276.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691095987; x=1691700787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+/rsOB7MMmBCNLpA1DSHrmhyVa9IiA1ZsxUc+a34xks=;
        b=RH84+1CJ4J7o12qkrpYNs8Bej9TkQF8S4TLX7oEr5N+h+z+fy0dhYSClNZzl/6m0Bv
         AZwljIAJxGYG45SiW/ZqKIpTufDlmnCsbNXoL2TRnFHhh48TpWoJFjU/FD/rM0pXx6v8
         +JK7XD1hHEcXMvM2ucGqwDEJ2IENdzJ1N2r9/cXMk0qXupEG25oXxPPMaW++Hz8R8JCq
         OGHH+CN4c97LNzGblfO0lsrdPe1Bc59CNMQDcMhEVzBoLanBki4WjWtqf+U1ZVZXuRuG
         vJfe8rdj/CJ3KZ8wk3sqceim/3qbCdR8E26QK2TNgV/01CQIsn8rs/9sPmpNCE5TmqNS
         TgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691095987; x=1691700787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/rsOB7MMmBCNLpA1DSHrmhyVa9IiA1ZsxUc+a34xks=;
        b=Y2+A5E44WJc2UqTDXkxfairjvNrY57zJuNLXLOEwcDQEFaOd8J5yRWjxoDE/Yc4Nzw
         6rDVx04HgzG6nHBMGjGfmtjDcwg1jcqUHzNTW6x/ES0PWL1s9GC3N2Ic7akAWWZEFYS0
         kSpXmEMpsMptJZ4+hxdaFVs2+qse65V8vbgOrdBqYvkK+63zA1YYhDVMO4to+gSuzKt/
         L/p078R7Pm67z1cBq6SxCkfYsB98UayPzMb0IRt1+fp4m65vj8AzG9FD4lXw9OVlseP1
         JH2ETPFs+D8r1Jtr1oFop7R38XVyvgJGY1kYVbvwOAueeaqjSK+SI5cI/5f1rMkj91RH
         O5XQ==
X-Gm-Message-State: ABy/qLa6v7mzuiU3gLvyEtIfFW9gyB5IBT1GN3hVUvhfEp/+ZjbyScCy
        Y7RN/LR40olQYb64F2EpY8wQgRxVE05G2jMoAbtsgg==
X-Google-Smtp-Source: APBJJlFCpGsVSdiQfwS0p+VQYoS4e9Qf1T09P86LKX7oHgpLrEC3CSHbMyEUBQ2rC/l5XoIxk//OPVDBmF7ryG8u4GM=
X-Received: by 2002:a25:360a:0:b0:c67:77be:9ad9 with SMTP id
 d10-20020a25360a000000b00c6777be9ad9mr16975325yba.30.1691095986858; Thu, 03
 Aug 2023 13:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230803194724.154591-1-danila@jiaxyga.com>
In-Reply-To: <20230803194724.154591-1-danila@jiaxyga.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Aug 2023 23:52:56 +0300
Message-ID: <CAA8EJpoy4w6j3yZMqEhh9xJiZieZuqyw2tOBSbhT0uuqoEMU-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/msm/dpu: Add support for SM7150
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        neil.armstrong@linaro.org, rfoss@kernel.org, andersson@kernel.org,
        quic_khsieh@quicinc.com, quic_vpolimer@quicinc.com,
        quic_rmccann@quicinc.com, quic_jesszhan@quicinc.com,
        liushixin2@huawei.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidwronek@gmail.com
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

On Thu, 3 Aug 2023 at 22:47, Danila Tikhonov <danila@jiaxyga.com> wrote:
>
> This series adds DPU support for Qualcomm SM7150 SoC.
>
> Danila Tikhonov (2):
>   dt-bindings: display/msm: document DPU on SM7150
>   drm/msm/dpu: Add SM7150 support
>
>  .../bindings/display/msm/qcom,sm7150-dpu.yaml | 116 ++++++++
>  .../msm/disp/dpu1/catalog/dpu_5_2_sm7150.h    | 277 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   1 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
>  5 files changed, 396 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h

Could you please include MDSS bindings and msm_mdss.c patch into v2?

-- 
With best wishes
Dmitry
