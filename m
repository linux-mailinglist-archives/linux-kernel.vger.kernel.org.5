Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43380A1E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjLHLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHLLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:11:50 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93775123
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:11:56 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d7b1a8ec90so16282347b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702033916; x=1702638716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5sTiUJetif/fgYO2zq3XsvRjD/RlEkJTpjxX1dPW9o=;
        b=FI9UmczH+EOkyJ9SmpY8NjmlO9WMp4nc5kX0QGlmMgSgsvJ5zz9EqRYQJP7R7ycegJ
         O0mowC1pIBhhSD6995KWu0XC06qlwPvyxtObE8xfBl/AqhXvksEaI235BuHc48+DPF9o
         C7p9O5duCemIcyXLGVQQLh7EW0NhYf8uFdywN7OvSRXbyxKuGdFywp3gUxd9QZ3DKNml
         jBmqH64mVATFI6By2Y86ox0w0mg38HCR30jwqCOpAfNjhhRdJnyxE7Ivgek1r0ACNwbV
         YiIpOptEEvxEE/irX52WPsQxZm94HCv9qoAYYwCm1UV2vQpO2rF0AwpVWCznMzc5tPdV
         YrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033916; x=1702638716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5sTiUJetif/fgYO2zq3XsvRjD/RlEkJTpjxX1dPW9o=;
        b=tqAy4nN2htA/gQ2ifxe5A+NLBzQKYAcgv8Q9yMrovC9pRivaRltONkpsc5OUT9MiB8
         Wg6VgM5EeJ8eTZR3vLCLqej63kq7B+NhnyFFcuwKHmQjaxKgJHDzY6dUgHEJsMltfe0/
         1yJRu2ljwzGd88ZWjpXFXGtHUpf2Q7S3aHCw8HUWib++Mel95ar5dw40jaUdegDph6gq
         K96vR6q8LdYadgb47uLkRKGCnBPIERuO0fx8NN73tz1JnfoklLzc4OHwLh1NZ3gJ5iKH
         khWYQsgfo6CDC92qu8k71kROw7H3c6eE33UIoP1kterWyqI2N6LSHiIgO9M5oaJlNDO2
         rCgQ==
X-Gm-Message-State: AOJu0YzfBsXbC7PESPXf0tnUHmSB28ZgZOB8REdpyQ4UCTtkeLqJ4382
        rmSPM6DNa00ULTJoq1Mok4YVg5EV13Hvro7b0eR95g==
X-Google-Smtp-Source: AGHT+IGadWRb7RLKWnHwQIGRXCckpkVS7uf7R7LgUD+cmDd+xOtJ0ovssIG5r2vaLiyKiudQIHYP9pqYEOJNDQwjEx0=
X-Received: by 2002:a81:ae01:0:b0:5d0:aa04:7b71 with SMTP id
 m1-20020a81ae01000000b005d0aa047b71mr3251777ywh.24.1702033915757; Fri, 08 Dec
 2023 03:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-4-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-4-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:11:44 +0200
Message-ID: <CAA8EJpqaZc7xB8Jb8uweKZHgLRb8SBtEN_rUCxWAK_u7hW8H-A@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] drm/msm/dpu: fix writeback programming for YUV cases
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
> For YUV cases, setting the required format bits was missed
> out in the register programming. Lets fix it now in preparation
> of adding YUV formats support for writeback.
>
> changes in v2:
>     - dropped the fixes tag as its not a fix but adding
>       new functionality
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
