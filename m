Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17BA80A222
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjLHL0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjLHL0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:26:19 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF4610F7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:26:25 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d6b9143782so17110797b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702034784; x=1702639584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=byPYVY3l+3OcfSeHRN4sVPzEvG910jYH3sPHi/VI4Xw=;
        b=PyhQvVlhVu4qj5R5ZJJ66ct+Ht7sHRIPYKu6jnOSNl6ViXaq+6PQupYVWiZt5hMhtc
         qVPCyKk32mNJx4OyRL3BSsxyABTJPYPANUcQ2DLk+ydYgJRLhXfol3jm4LhyTo3Mmohp
         gm1z5Ap97CpzC3Ynl++EuobA61urN9uuFPt54wIr7+q24ZAVODyDXLbSOyg52T4EYVDp
         hw2/lt+RFG8E00LBg78gL6onxnagohLnFcgp1rsrvY/Y9uwiZuWNeY+MU4GKCaTsmCRk
         k8GmkQjnMvKck3GGV0Hv+22QTb1vfJrnwfPCRBtwBNMUzBWHt38XpncO8xzz/T41CVC6
         Qk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702034784; x=1702639584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byPYVY3l+3OcfSeHRN4sVPzEvG910jYH3sPHi/VI4Xw=;
        b=bZ/mpt30oc9DDixqkFa4jKDlsWevk4tyIWyKs6N9ObrK8a/9OGroS6Dg+8gohaXrLm
         4Rupk54dmR4FYxWKTp+GJnv06Y6sFrQD3F8LTaKCi5Wj+BOMwkjs4qPIqoRuaoW5OXcM
         swNYf7ENbw0WiAZxRQz1p0Cjp9+jmT9TXDye/3SGsjlpimONwERvz05WlTH4TBO5X0dy
         Ta7xIMlhLuylm36ZLXeBKfnlDMz/xEI15PG6LE8iSqsiXsQFjL1St4glyVwbHgCSKQaH
         Ocit1KZb1l6qI+EZyl8ZLp+8HB/Vxp61VR/d/sXkOh3WdCyCE2MCQdnQSXH/C/1PpKKv
         eiZg==
X-Gm-Message-State: AOJu0YyJZ+ZHaBtS4FDKd4JNUtgxcY4BeqMwfD3/ZodPLzNMLLYkcIo8
        tj5LcQ1i23aBlpb/7Zp5Dpz+CaqtC6Zc0D24tzXJTQ==
X-Google-Smtp-Source: AGHT+IHGGsTbAV5EBSGKjADTA/4cOM5MMdVRwIFGYX6nSYYueDpA1I/YNSvKbKDV21cpoUlQldGOr9DIM2R52NDc8GY=
X-Received: by 2002:a05:690c:c84:b0:5d3:d6c3:dcf with SMTP id
 cm4-20020a05690c0c8400b005d3d6c30dcfmr3647433ywb.15.1702034784451; Fri, 08
 Dec 2023 03:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-9-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-9-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:26:13 +0200
Message-ID: <CAA8EJppNfznTQydN+BDaFpHn432gAhHUJ+9pOvq+bV9pvE=qAg@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] drm/msm/dpu: add cdm blocks to RM
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Add the RM APIs necessary to initialize and allocate CDM
> blocks to be used by the rest of the DPU pipeline.
>
> changes in v2:
>         - treat cdm_init() failure as fatal
>         - fixed the commit text
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 13 +++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
>  2 files changed, 15 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
