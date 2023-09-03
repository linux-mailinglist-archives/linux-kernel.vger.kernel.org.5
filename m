Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA1C790D4E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbjICRej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbjICRei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:34:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E1E5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:34:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso346523866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693762474; x=1694367274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fRYDJegopoDvX4wUumAqbN8+NBFikZtoO1OhinvgIE=;
        b=fLrlS7KBy2YjQL1M1QV4bx50kSoBFchBHv/1CcJTffnpbteah5LslzTH+Io+7ASN/d
         PYUJOylQfsMybBmFBtU+YsJLZl1kvU6obqUNGX1WRZsqVCP9l9HVuFlVvDtKejDLULo+
         eoHZRODyqIE+pqEuGxNYx3P2cAsdzhcsJluWq7m3XI1MlDAddeQ8aLk5P42Gj2XlewMP
         +gMSgo2gxCGbLiZ2mJ18yEC9ohR9PAxT35VpXxmXy/5gyxBiiwtvb9W05CbKdTGfczQa
         dxSuvdwdyRnlR6YN2OpUoC7vs9TY0ZfgmEC0kd3BQNsdL+8SGjFYgx1fdy9RdbPSU11u
         olVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693762474; x=1694367274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fRYDJegopoDvX4wUumAqbN8+NBFikZtoO1OhinvgIE=;
        b=GNIpy6PJ0CmEv+G72fmXGev+AgOXRgs5n2lcVHB1bJCESaud3sk+R3gmskTN8K05Dy
         QSPSGWM3735Q/coxFLh90w8GNyW+pISCh+Nr8tOpRtWKkta8NM/V645a6/E6RbAucGb7
         iw1z0VGlj1nEfW5EBpBqMLNiEyVRGKLry52RvQ8WCxTDhdyWh3KK1nyq+LaaguiDjv3a
         Jq372iO+WxZi1alFUTmtMz7GPIPp5NQYAO7v+BRiataPoLgalzLHe1qadXcedayHR09j
         /adMh/JGptG4WC9s52h9GZz4gjYv1c6EIwKfs/wpzf2B/bal5UeReXohueE3gX5F/B0d
         StEw==
X-Gm-Message-State: AOJu0Yw0IT4gX965Hf2I2kO9lP/9aboc7/e7lYKpeCnguC6LFaXVIlHO
        dvFtFzFd6h/m1X3NYu8C/vtwfA==
X-Google-Smtp-Source: AGHT+IEiBqUVEY+DFZIBnmFkaJIanvV7apy1ANrMlmBkH3n5xhkvCR0N0KP+JkDDWqdjj5WERM6kOQ==
X-Received: by 2002:a17:907:3e1f:b0:9a5:9b93:d60d with SMTP id hp31-20020a1709073e1f00b009a59b93d60dmr11038685ejc.36.1693762473985;
        Sun, 03 Sep 2023 10:34:33 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906078d00b009a5f1d15642sm4955313ejc.158.2023.09.03.10.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 10:34:33 -0700 (PDT)
Message-ID: <6d269101-d18d-4783-a8fd-3b59a23d3700@linaro.org>
Date:   Sun, 3 Sep 2023 20:34:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] drm/msm/dpu: Enable widebus for DSI INTF
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230822-add-widebus-support-v4-0-9dc86083d6ea@quicinc.com>
 <20230822-add-widebus-support-v4-2-9dc86083d6ea@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230822-add-widebus-support-v4-2-9dc86083d6ea@quicinc.com>
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
> DPU supports a data-bus widen mode for DSI INTF.
> 
> Enable this mode for all supported chipsets if widebus is enabled for DSI.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c          | 7 +++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 7 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          | 1 +
>   drivers/gpu/drm/msm/dsi/dsi.c                        | 5 +++++
>   drivers/gpu/drm/msm/msm_drv.h                        | 5 +++++
>   6 files changed, 25 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

