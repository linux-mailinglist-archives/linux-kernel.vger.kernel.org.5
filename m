Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FCE806A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjLFJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjLFJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:12:41 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA810DD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:12:47 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-db539ab8e02so5269509276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701853966; x=1702458766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ff5+UzJ+HzQvyI9Kv5LqVNtPJDYPRZAn3y8IpX5aL58=;
        b=SfTwvksUFh9tI4flYkE4Rbqypi5jyjsA6ZkdTQpC7KeJGgRB6NBut+pofMjAwUawZn
         M/gAi9/bzHVc8OxqhU3O0Pwe1BhbI9TW0n5dxVjSI1g76uvvdUrZabrCYfdIHcGbEYkZ
         EMRdEj7RXEQwloeY5ra71GCX8kfClB38v7BS1KesdMI2Vpl6fQbF5QPPX73M/NnI0eg0
         92epXtRd9ywBQTy95c03DaiGpZZs2HIBPisaDhxG0OT8j80rX7kIGNLJwO/WJqug34up
         hVMfGccyvz7zGon4G5QmypPps5Qz/2Wfmrv09Il78n2b4YXPQrMPPEfshilPF+dxUNv9
         H8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853966; x=1702458766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff5+UzJ+HzQvyI9Kv5LqVNtPJDYPRZAn3y8IpX5aL58=;
        b=W4eFUkNN0MxKcw9XChtS2S2wxAQ2HbHrtf6gTyPKFX6+O/NCJv3mnqxnMnAsadoBxh
         Nv9k0KsS3AYdJYLNjEX5Sb0oPsZw6Gw0yHBsy/khf44eABtrmiH0AzCY+/IYNCCxhOPV
         nO//wgJbH/kd8yptDOfjYtQWupkEN7/A5eZ+h0WgUsDc6wdWuLP2aw2REV5n/NDeqmwJ
         2L/x1hnNSWVg67wv13LAdPJGR1dyjnwVl/XU7DGV5NWa7mu8C0gx3cif9veWw28D77fd
         oYzyTBeBbCjaSIJ7BIRuSlAJ3JrhAWpy1va8e8CnfOeUjm0QP+O7UsV5NwHsrlROafR9
         zGoQ==
X-Gm-Message-State: AOJu0YzKFs+lkHj99qwSlnuwq+D9vnHlleLKN0RbjcDoIALsTWbRYwBk
        6MpGDOLZ6V2JD/RKOZjtuq6Niv/OTqrr//j9STEGGw==
X-Google-Smtp-Source: AGHT+IF0IeDJuQTQHa31o0GrY9n748UF5ySeUAAC+78Y2uK2gEvwmXjDq5q4H7heMWz5QEHQTEqoZpREOkNduuqkEVs=
X-Received: by 2002:a25:2fca:0:b0:db5:4e46:891d with SMTP id
 v193-20020a252fca000000b00db54e46891dmr385828ybv.12.1701853966723; Wed, 06
 Dec 2023 01:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20231205220526.417719-1-robdclark@gmail.com> <20231205220526.417719-4-robdclark@gmail.com>
In-Reply-To: <20231205220526.417719-4-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Dec 2023 11:12:35 +0200
Message-ID: <CAA8EJpppdueDRZ+J+X=QVViQNdhdY93TnDRfUyHXE7-AfQM6+w@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/msm/adreno: Move hwcg regs to a6xx hw catalog
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, 6 Dec 2023 at 00:06, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Move the hwcg tables into the hw catalog.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 560 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 558 ---------------------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   3 -
>  3 files changed, 560 insertions(+), 561 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
