Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363FA806AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346830AbjLFJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbjLFJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:10:39 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F310CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:10:44 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db539f21712so595327276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701853843; x=1702458643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9n2kthQbWTkNG2GdCSNciiPlzGwjGTmUOsOXRq6uUuY=;
        b=ZNXBy+lAjJ0UZY2tYwI839okbpIMEVyxAxzPa4/b3MqjchcuREcMdc3mJ1Uf0S4Gji
         QELRocPEwAspjSv3QoH/I/CjNaeSNV5tAqkVfN2dYYgHJE4mj3cjEybL7WQu8ts2UhBz
         3emm0e27U0LZn3VxgBIFv+JRyxD8ag9AOQHRHKKX1SA+aLumQSM2lszhjgNPoQAMcQpo
         +CvY1ov3LyIUkd1dJA0TAmNak9Pen2RLHzFqO7Pum5dPxWZE8WRFkj4t5LyTUV49BRn5
         RxK7XqklHanj75yw6B2dddGVL1eREaiz4OEpo8Xdak3F/DH+/6o398AhywSoQ+X0SGji
         HPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853843; x=1702458643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9n2kthQbWTkNG2GdCSNciiPlzGwjGTmUOsOXRq6uUuY=;
        b=dnKa8dNmUlQQ5gArmjeNRAw+uV2PHLbi/KaakIxQVovCH8S56AkgamkMi5m1KPRuMf
         ZlowwDOa42zXpGhD58w6h2sjT0bbkUhrejH3BIcAaV45h2E8+2tPMaTUKgSemeVoAcVg
         DmOfBqZY3TnqR4uPDQEhSBnYPPYblUoWRNjb6ytEdFLNcttxz80D6lH6cSf3wJ1VTcF/
         WX/FJT5KVbNsfSRqwzlIzx7o7cKoQMnVrL/BumWvfmzZnbvark56Oo4ZiyEAiNuOJUfj
         kpiSfwmEJRqLcGbmFyBhJF4AvuHUq/QL6nYXEhKVpesJrYaOeJPRYAFX+A5SwXRRiKAz
         1usA==
X-Gm-Message-State: AOJu0YxgfD4wjrd/Nq4cwHAdkL4OOEoxxx/DqKHoh/PhmbPaI6ZnNAfz
        Ew4ZAj03PSPlVmD8srmgYBKJV/BrDu/yXpqz8tFkUbM3hf5iEWSw
X-Google-Smtp-Source: AGHT+IEXzruhFFkHB0Fa+/n84Bb6lIWEsIELJtEm0FOsD8vWSyRbbfLPr/HFQvgfnZNoovdex9inHxAp8BUvFfqaPBM=
X-Received: by 2002:a25:cf13:0:b0:db4:d68:d450 with SMTP id
 f19-20020a25cf13000000b00db40d68d450mr2003989ybg.25.1701853843738; Wed, 06
 Dec 2023 01:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20231205220526.417719-1-robdclark@gmail.com> <20231205220526.417719-2-robdclark@gmail.com>
In-Reply-To: <20231205220526.417719-2-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Dec 2023 11:10:32 +0200
Message-ID: <CAA8EJpoguMhnO2LbQvpbSiuq6PAxqc3cT1nLKFmrA43sP9c-3g@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/msm/adreno: Split up giant device table
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
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

On Wed, 6 Dec 2023 at 00:05, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Split into a separate table per generation, in preparation to move each
> gen's device table to it's own file.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 59 +++++++++++++++++++---
>  1 file changed, 51 insertions(+), 8 deletions(-)

-- 
With best wishes
Dmitry
