Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20A2802306
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjLCLbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCLb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:31:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C343E9B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:31:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9b956c68cso37375961fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701603093; x=1702207893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66Aoa/dxI47/obkV1zabVPwJ1McMDn3dKlFH06pxzrQ=;
        b=AtyzRzEb4QZ+WS45ATBrbQZ5eM6SxFJYgsuAfICzO2PJ3cWbJ4fk27WYGX8T7hIgmg
         Qlkwom2U6yLXRCGNxz+Tv86/fMDIgtiMnUljKJLE4TPmO7RrvizExAOwnTiE1RydNQak
         VPWosledIWhMpV+ZjoRXkU4jLh9+sYQYbyVS7j8JFZXmxd0lIO6zhMq6TAxHgXazY0ZY
         pqGHVYX72gvdRAkUgG2Wlo0m6hzrNnx4XkNTCE/D8SlpN4bkHFYQl+oQw0FsLyvqzGWP
         mUSb/IYruyQSSrx/qumVflWbqdcqjtJEvd3BBFmTuUHyFIdWK6JQLIXbjjZmnIgyy/fX
         F9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701603093; x=1702207893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66Aoa/dxI47/obkV1zabVPwJ1McMDn3dKlFH06pxzrQ=;
        b=LblaLejeSbwbub+TEaFJviLsF3zDMQix2WTqZdRLmvKWYZMibn0AOaK+Kv5zj0/lmF
         7yzm2APvRCr4e0gDRxvMIfOW9z/JcTxEtmln6p+SlFt/F/br5xdViXwk2PQHSwROPz0s
         0C6fwD1pn/QfDIa6iXkbSfaVBV32wcAQIjHMjEVs7Bz2iMH8/cZZuVO/elFJ+nSW+KVm
         TK/UPQgJGb0Q6tER7hmPMkH9KVg6JhfLwPmo0vf24qLraqxmksferP6x0fic60ua/rcO
         Z8CoImH7oPgnyIkz0ki9LzT9KcZ8lIBYHKm0/rwZkhtJnCxeZ0gSu+Lq8wIqt+Q7fDbA
         lOYA==
X-Gm-Message-State: AOJu0YzlWNq7g7nIL8dOS4NjSMSqc07c7wczNcy+HeE49xFjZo7lqhMW
        2rc78/m0TsUlZo4YB7qzHbrfpA==
X-Google-Smtp-Source: AGHT+IFJF2uIQw16LPEWXGCcDiQFvQy273U89PuyeeiGEbrQ5BJZQUdHrcIEp5fGZblxU+A3YEYqsQ==
X-Received: by 2002:a2e:7a14:0:b0:2ca:135:2204 with SMTP id v20-20020a2e7a14000000b002ca01352204mr194590ljc.16.1701603093057;
        Sun, 03 Dec 2023 03:31:33 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a39-20020a2ebea7000000b002c9f70a0419sm274718ljr.140.2023.12.03.03.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 03:31:32 -0800 (PST)
Message-ID: <ae97ebc2-83d6-4f37-9b69-6a52303b0084@linaro.org>
Date:   Sun, 3 Dec 2023 13:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/msm/gem: Split out submit_unpin_objects()
 helper
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20231121003935.5868-1-robdclark@gmail.com>
 <20231121003935.5868-5-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231121003935.5868-5-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 02:38, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Untangle unpinning from unlock/unref loop.  The unpin only happens in
> error paths so it is easier to decouple from the normal unlock path.
> 
> Since we never have an intermediate state where a subset of buffers
> are pinned (ie. we never bail out of the pin or unpin loops) we can
> replace the bo state flag bit with a global flag in the submit.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gem.h        |  6 +++---
>   drivers/gpu/drm/msm/msm_gem_submit.c | 22 +++++++++++++++++-----
>   drivers/gpu/drm/msm/msm_ringbuffer.c |  3 ++-
>   3 files changed, 22 insertions(+), 9 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

