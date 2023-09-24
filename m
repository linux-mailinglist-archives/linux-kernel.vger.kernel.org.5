Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6BC7AC774
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIXKKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIXKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:10:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B1103
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:09:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32325534cfaso237011f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695550195; x=1696154995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2UMVpz+yvvkwATkXQokHfFZzHF3TmawiwpTGEMOBpQ=;
        b=hsGshAti7sB3qP+RKWKp+jVyaKCyZA9yvn+Hp7HPya+nbJGS1y3nHISDM7FFscPZe9
         dwyQm6hwLe534blEsMonMQBb+5cwz4KQk3l0RutR2NEX34kfIjmX8BTxQ2C+YHBQq3BC
         neXrgKcLmYmSUOX9xavmBlx+Pdc6IKG0MeaZDl+QslNrjeukI+Z6M+Lu7Q/rejt0Y4u+
         jjmFnyfMpgT/nUWjOc9/F8vDwEnRCa8O/3nCafgUbkGxZAFGlQCAaZJssBEsh+U5cvz+
         DTgbIiJMo/IBr43yF8e+nd2aEAT+Iw9hn/ZbJOOyV/E2F37PBqtv0c9Z40Z85hKsXAJQ
         IbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695550195; x=1696154995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2UMVpz+yvvkwATkXQokHfFZzHF3TmawiwpTGEMOBpQ=;
        b=GYdA3DlWgOuy+mKadHcrkiEdw8A6K/s38TOUcNHJpXMOMMMFhZ1HWzzGFqnPT9GP2V
         0hsVBj+76NhKCnJxo9jqgPLFrfZ6s5jMoYKRj9WpnZI8d/mSfPclnMSxjKzyJb9OIHzk
         Dq3ySv7dJ+L5Ihd8SPbfnKkxhxDI4DA1WsINYaQIogXiO+9NAKy982nw09L8WbKvLpaH
         dOuBKIEZorvnNBxYmYwm6gHmUbAd+E8PVXmvAtTnySW5oHMlrMrCQBB2DOAubgpYg0gz
         Ak9LdRcaK6sHGjr12nMehKKlX7+ssTQXRzduKdE3Zw3dTJ8UDJ4iXOeuaqBVhkwQgF5K
         5xpg==
X-Gm-Message-State: AOJu0YyFkqy+VDNKn85ig9id3xnkI+oOZ41xlYkWj99l+by0ybAZ7m+p
        LdhVzvgIuaxxZSywTYJ2LvrR+g==
X-Google-Smtp-Source: AGHT+IHDjtkitMT/+apVHnmsEYPtq5T343OoIdxluv9GvpNWnmlfEU8l0VAIXXFUrKjCoPD+hWx8cw==
X-Received: by 2002:adf:cd81:0:b0:321:61c1:7879 with SMTP id q1-20020adfcd81000000b0032161c17879mr3556577wrj.30.1695550195694;
        Sun, 24 Sep 2023 03:09:55 -0700 (PDT)
Received: from [10.73.151.44] ([188.111.42.10])
        by smtp.gmail.com with ESMTPSA id c12-20020adfed8c000000b0032179c4a46dsm8886160wro.100.2023.09.24.03.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 03:09:55 -0700 (PDT)
Message-ID: <7e230ebf-7c12-4809-b6a0-285eab805a1a@linaro.org>
Date:   Sun, 24 Sep 2023 13:09:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 05/10] drm/atomic: Add solid fill data to plane
 state dump
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
 <20230828-solid-fill-v6-5-a820efcce852@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230828-solid-fill-v6-5-a820efcce852@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 03:05, Jessica Zhang wrote:
> Add solid_fill property data to the atomic plane state dump.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/drm_atomic.c | 4 ++++
>   drivers/gpu/drm/drm_plane.c  | 8 ++++++++
>   include/drm/drm_plane.h      | 3 +++
>   3 files changed, 15 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

