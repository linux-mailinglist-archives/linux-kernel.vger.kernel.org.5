Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B268022FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjLCL3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjLCL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:28:50 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF2196
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:28:42 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso17536901fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602921; x=1702207721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7k/TcV4Cokn5QDPYijyDf1OwkI3RiXghan4g2PqQJc=;
        b=XcND2Bvh54UQmUp0MY7KcLxiaQDpDGJa9kmJ0QmCKyDfAVz6Fa48sBk3M7gIZP/ecY
         aCbk3h9JRjhPGQVLDtJMpZY2QSovxsDjNGEQnJa5QID5+mX0/xcPTDnIkhKeoKNJ6yfo
         +OA3aM0YEiY/BadniPZ7D0yCEM0Rt+Ev55KANZy18Y2erHyhkoCJsIv1eOB0+1S0sNYt
         3lKxIRurQnDFMQ2QG1ajJfkOFYdzNPXSnfj6i1jpgcXeoU/q0jvpFf5k34BhTfAXYhNc
         rwspSlYg3iDzKHn8IPXGSyJf7VC2EOGTnOpioYM10haxylmm25wLrxObooJn0XHawnYt
         PLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602921; x=1702207721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7k/TcV4Cokn5QDPYijyDf1OwkI3RiXghan4g2PqQJc=;
        b=ACLmEEXeFAaB67n65XBf0xO3dIVXTuyVUr/49g/sYr6p6t7M0SHfqAZgIFC752M291
         SrjfFJpYbsw9n8c5LYAfTmOt08EZQT8DxgnfYbBMiqYwrTO58AbyoOoQno0cy/8DJwIB
         s5hYPOpjqrrU9yKPxLJ5LiPgSL13yXd9z2gh4cy9ex9f+Me43SgayLgrW7ifpQdmeedN
         nMVOplNNnzcvIzb3dQF+5GJK7nBQF8/zacKv7xGbKHCj7y0vNXEYL5WbsTSzPAE3hdH8
         QpIrFMIKxdwg5Wfu0aaueLdMr9HedI4LFbwbgBro7gLL05wEZcduyZjQQeh9YKPmDZIa
         gSUw==
X-Gm-Message-State: AOJu0YyQoRfhuU6Obv3kzzKKyNziMngKPLlKxfRIGfVOGpu+YuvKBBG4
        G7tehah6QBOQWNXlO5TlCXnxXw==
X-Google-Smtp-Source: AGHT+IGqFOCoj6Ejh31/xdT35ajIygeshLhzcKMzHS5YU2NmxWqCFUAgyHrCF7ifRWiANO1HUtNWBQ==
X-Received: by 2002:a2e:99d5:0:b0:2c9:e7ea:6d3b with SMTP id l21-20020a2e99d5000000b002c9e7ea6d3bmr1232579ljj.90.1701602921149;
        Sun, 03 Dec 2023 03:28:41 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a39-20020a2ebea7000000b002c9f70a0419sm274718ljr.140.2023.12.03.03.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 03:28:40 -0800 (PST)
Message-ID: <ed17e7d1-c99d-45d9-a9ba-743ccc07961e@linaro.org>
Date:   Sun, 3 Dec 2023 13:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/msm/gem: Remove "valid" tracking
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
 <20231121003935.5868-2-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231121003935.5868-2-robdclark@gmail.com>
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
> This was a small optimization for pre-soft-pin userspace.  But mesa
> switched to soft-pin nearly 5yrs ago.  So lets drop the optimization
> and simplify the code.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gem.h        |  2 --
>   drivers/gpu/drm/msm/msm_gem_submit.c | 44 +++++-----------------------
>   2 files changed, 8 insertions(+), 38 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

