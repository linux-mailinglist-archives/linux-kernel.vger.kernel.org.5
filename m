Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531E77AC76E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjIXKJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIXKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:09:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F356FF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:09:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so4476378f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695550139; x=1696154939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nXbLBps5WiXoEQE9WIccP8ivtaXBMcUBjjWn1Nzz6o=;
        b=gMaqaLKbEM6hqWo8Bv9w5+HAAYgps8BVv7igu5y9Kz2jxIf+5XGtb99DXPYiLe6jkP
         sBmd+FC+6hTfQCBApHPZD3ctauVZF6ZlLfMjE60fgSfdP03piBIMABzaE+kLLQVkr167
         7L0QaYZWr8S7009/Ifn1NjIrwlwaAvIs+w/4kODmxBlgtlWkEFlQsGqgOe37j7WUFyAZ
         pz0QCJgZnHyPs/C2i/0Lm0FI3WW9Sg6A/OESWJhx+x/to9nrl3egBtZw9YUkQJhPOcJA
         lx6otTda7zCMAnbG7qk4/SCm3exWI73xcb+IHNM1Au7LvP0OlX9kZTgBOWcZu7KJonRO
         NNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695550139; x=1696154939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nXbLBps5WiXoEQE9WIccP8ivtaXBMcUBjjWn1Nzz6o=;
        b=Abq3ap2oMQUAjzj1GLR0EAlUzU362PfIRNs7tT6lbCpw/Ut61UxGLen3F4auUcX6jN
         8VLbAediLU969jYK4A3x4cjVu46pbWbgg4kY6ZUITY/LfMK4pAbhB9GCVoAIhzkjkASj
         6gUH/CgA8w53GhVvWRnuzWRM5AuO2AhLR5XfiYMzhMtbNkCHGjIaA3xPR3xB+3hNr5SP
         SnhXP+QSJys+r03SWXpxzSvc/dth3Ypko1Dm/SUbce5E5rwZebkyeOMW+9dG5RwV7xdD
         /cj+ZrX19uCUb4SIcCMP/1AeDUGp2YjewD/aakoE1Eb6nOUgwOEDmbdY2Z56DikXpaDD
         kvcg==
X-Gm-Message-State: AOJu0YzbammrKQ4CpldaTgYWDsUT7N5BVd+PTYTO5dJQDtaRLuxa64mM
        ASDXMcOYmLvAz+SLJ7kCnOxFPQ==
X-Google-Smtp-Source: AGHT+IGc7cLLbVqMAyuO/HE0VQk/0NVpOb/G3zdJclMXCsC6r8WRPOfcesZEX59sT3GWSsST1pnbuA==
X-Received: by 2002:a05:6000:1cc4:b0:321:68fa:70aa with SMTP id bf4-20020a0560001cc400b0032168fa70aamr4018108wrb.9.1695550138694;
        Sun, 24 Sep 2023 03:08:58 -0700 (PDT)
Received: from [10.73.151.44] ([188.111.42.10])
        by smtp.gmail.com with ESMTPSA id c12-20020adfed8c000000b0032179c4a46dsm8886160wro.100.2023.09.24.03.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 03:08:58 -0700 (PDT)
Message-ID: <2803eb0a-99c5-4cb6-9422-7b8e392f2b7d@linaro.org>
Date:   Sun, 24 Sep 2023 13:08:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 04/10] drm/atomic: Add pixel source to plane state
 dump
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
 <20230828-solid-fill-v6-4-a820efcce852@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230828-solid-fill-v6-4-a820efcce852@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 03:05, Jessica Zhang wrote:
> Add pixel source to the atomic plane state dump
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/drm_atomic.c        | 1 +
>   drivers/gpu/drm/drm_blend.c         | 1 +
>   drivers/gpu/drm/drm_crtc_internal.h | 1 +
>   3 files changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

