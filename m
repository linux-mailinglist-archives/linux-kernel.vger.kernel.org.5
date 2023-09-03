Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE235790D54
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbjICRe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345872AbjICRe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:34:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75952115
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:34:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a6190af24aso113674766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693762490; x=1694367290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFnqV560lAZ6YF/3E3DhwgPICGzqwbi6MBKG22yTZ8I=;
        b=YN71a+OBcSjTLJAlmaYCE7J0Bh9YOZyoPSH7kyFnOmMKyndqYOZm9V6ztRK73VORUo
         FChrQj9GVRCnQoDFiOe7rud7kvHRpiC2ZA77SpDQqwxAGs5DPeHDQ7kR7xK1P/Rl4vyD
         ZDv9rdpDHI4m39f3j43dJln1DSeTPraNhP6GFXcUL0VDcIwCxKIHb7RwxCn9MCAabqOL
         ojAupFjhb6g6jXrntWAb/7CF5evOE93K7gcbY8E7dPqvKaQnLdk2g9/+k9IhQul3815S
         y+K/W3zOPQhlHuaHFeYuu1mXJMvDp/ulP3ANtLIo1RHR26KCc21ZVzUu58NslrdHSfIm
         NwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693762490; x=1694367290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFnqV560lAZ6YF/3E3DhwgPICGzqwbi6MBKG22yTZ8I=;
        b=R0ldhwjffdk6CTX+m9s44C0ktP4XE5rRLP8SaDHXmIqzQtzaxW1BHa+QlgUVjPilK9
         GMGYUjMRX5OG8BrCad+tQchaR+bsEW5GJRTd8IMzyCqUxuD1J9Un34J13eI8S6fs9vmd
         u9lWakuKKZtVKzeE/zKdZmmHnBm5exI6qTgz581felIzgzVtnDSlV4rNZ2aUabMnlNne
         1JvB16JwT8deynm4P5edJ3R4MhzCWN06s7bGHx4gIgT/AG3bYQLGTj+WmhalMaXKhcE3
         ftk3wkYOVMpkulMBHv8FCskW2HnFehingIhaxqfn6FVKHfAAeZgHQVwDvB7pbn/eZ2/l
         klLg==
X-Gm-Message-State: AOJu0YwajqRIfofdQRXgA9zyAojtfcZOevu6181HGuUIaLA9BaOu5gvZ
        QkGXX3c/IgkOj7/jfpEKBZKq+Q==
X-Google-Smtp-Source: AGHT+IEe6KGCoDHH6YmYaRNcmoMmo0Ktbkc6BF0JUnIO99xIaVatxGpDQLavUlCRkTk6k8m2js43ww==
X-Received: by 2002:a17:906:f252:b0:9a1:eb67:c0ce with SMTP id gy18-20020a170906f25200b009a1eb67c0cemr6189371ejb.50.1693762490088;
        Sun, 03 Sep 2023 10:34:50 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906078d00b009a5f1d15642sm4955313ejc.158.2023.09.03.10.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 10:34:49 -0700 (PDT)
Message-ID: <0fef71be-91c7-41ed-bb2c-965b8aa4e8e3@linaro.org>
Date:   Sun, 3 Sep 2023 20:34:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/msm/dsi: Enable widebus for DSI
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230822-add-widebus-support-v4-0-9dc86083d6ea@quicinc.com>
 <20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 20:42, Jessica Zhang wrote:
> DSI 6G v2.5.x+ supports a data-bus widen mode that allows DSI to send
> 48 bits of compressed data instead of 24.
> 
> Enable this mode whenever DSC is enabled for supported chipsets.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi.c      |  2 +-
>   drivers/gpu/drm/msm/dsi/dsi.h      |  1 +
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 31 +++++++++++++++++++++++++++----
>   3 files changed, 29 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

