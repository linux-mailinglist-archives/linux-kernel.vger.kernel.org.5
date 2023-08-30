Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9279478E363
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbjH3Xkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbjH3Xkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:40:35 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A296A12C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:40:29 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d77a4e30e97so78265276.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693438829; x=1694043629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RW03Buigd8vZt6eYvyecwZ1KL1Q5FSJSIf3Tv8B2o+o=;
        b=oHHJrqMqRqEL3D20IVjugTQfMJb8hPKArCE08fM8QU66Ex5dG6COqWLBP3JnDhq23/
         jQrcRcX/VR1bhqX28iAptV7CKHXyKzCRpZN0Uv57TigP+kS1jYvUX4rIBS33UP36jMvp
         g5HzLMHj8c3Vqu5aWshCb6AURMvaUMMmb8IjEl3EdJIli0varx43qoDIQ67qeEFt7mlW
         O6wQwd4cyCh00EcnEYI4sxtkGXYyOvW5HVOEH93191SIIS2PiVPBoge25wUJh4E/Uq6u
         3LRw3Kb8X9PnqEZIjhBWdYRpmwK36B0StmUZnj4M9dLXZ3HnPPuO0FUHUXaVO3kvWtcC
         jhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693438829; x=1694043629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RW03Buigd8vZt6eYvyecwZ1KL1Q5FSJSIf3Tv8B2o+o=;
        b=K7Sg1FzkXykaa5/kjjj/leA7EACKR+ut1NnsN3IpnC+1iVkcl8Q65cv7BpNG+AxDCi
         MFL827r1eio5270JehfFwrH16hw69dsZsaFfBugBqBVGiBbhpSHQmFQO3+WMSRnThwG8
         /zgYP7huSgFwNRsuVJ+cMuzV7s/6Y4F4fe6nxEOFwv+zLgFO6IePC7QHAuYkeU7EXPh+
         sII2cjEZAI+bjuEmkbPMctBKhXIcJbPcp3xgpdCZezTsyf5eGrtKXrnI6sr2LGIHlR7w
         NVHyJWneHGw2geSBhvRTIYaUorXUKoLoBvOQP8OhbjSQbmwQdRs/qzZXhjDNSfYECsFX
         nFXg==
X-Gm-Message-State: AOJu0Yymkhf9ieR54ZbqkEfBT/WkTkboR63I6KLwOI42TsJzR2pnfivY
        YbjURkc0GEQH0fAzN7EAM93w2IpOogayvIuh8hXKNw==
X-Google-Smtp-Source: AGHT+IHRpuHMQeos/PbcvuIgXam01EiMFEv4kIeP7FrRqJXSgDs5wXyQUctlx8YiF/YdlbVx3rmwns4oiK1/Ze3DUKQ=
X-Received: by 2002:a25:dbd2:0:b0:d7b:a834:3b2c with SMTP id
 g201-20020a25dbd2000000b00d7ba8343b2cmr3295137ybf.1.1693438828881; Wed, 30
 Aug 2023 16:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com> <20230830224910.8091-4-quic_abhinavk@quicinc.com>
In-Reply-To: <20230830224910.8091-4-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 02:40:18 +0300
Message-ID: <CAA8EJppfO8G+6sFf6MUOJDG8swAtT3J6sAa_20xUJfPCcNq24w@mail.gmail.com>
Subject: Re: [PATCH 03/16] drm/msm/dpu: rename dpu_encoder_phys_wb_setup_cdp
 to match its functionality
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 01:49, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> dpu_encoder_phys_wb_setup_cdp() is not programming the chroma down
> prefetch block. Its setting up the display ctl path for writeback.
>
> Hence rename it to dpu_encoder_phys_wb_setup_ctl() to match what its
> actually doing.
>
> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

-- 
With best wishes
Dmitry
