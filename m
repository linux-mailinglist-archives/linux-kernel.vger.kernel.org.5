Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050E180986A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444225AbjLHBLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:11:00 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE751712
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:11:06 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so20622361fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701997864; x=1702602664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPIpR2OhS8FsOJYuELc4EcfXoYVEFO3KDU00U/AniAY=;
        b=LuF7Njc9/olaMgMGhQBUoHypebXo/IuLosXImsBj/fW9c82Bmrt3ByXfbFvi/QG5AJ
         iX7bO5WajAfWZ2492D/mvRUYekJQcCP/CUpodDecmS4a3QdKG9RwLeNU3dG6MIih6uND
         g5iWJosCpPBxM4e7BOdsX9ZS0hARDdgqkNV2xRmJ5SLNQITopIXOHnUm4n4b2qJSACtC
         49+XMtDDRS1/jFRHchndv+MHMajZvmySCMfFAXbtRsjMr3LQ6HWIC/9dq5UYk+fCAkL2
         Kyxjp50I5tzAs7bzdWull4syDLxcec/ukTlVk/vN8fwUJJcxZXg+6Wk7gZFlbjejbalR
         GZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997864; x=1702602664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPIpR2OhS8FsOJYuELc4EcfXoYVEFO3KDU00U/AniAY=;
        b=JXfgugbXXhqkCs8dxEGzGFz6IewGZ5zHQI0MT+Sb9IrL3AOz5bCzfMXi2bsrNjbciB
         SAKiL4NMwRweY21gBZ4kPFjQwLMNJWpcHfBuHDM/u5be79F6sQI5BAjvAXzec9/jeCHf
         Ohg7zeVuxEtVfpWxXJEREVcKj84p07k5QczQteHQXV40WxoNeYf9Sg0BKSoxXeNFPStC
         zZR3cRaOMI3yzoPTJwTbX6KKAJLAXjcxQmVFrhOymOH7bSGd4POooA24sJYhwtq8eq+i
         RCMlUGMK0RFx5qfxlBZstQtVXQLl8QBC1Pgs5bh97GBTojvKczFTA8gWOWuHMjG9QawI
         htWw==
X-Gm-Message-State: AOJu0YzyAQm+3jSU0YhbJMwHptH9618mCzOfun3o31kHX55vkS9VeBWU
        z1pUrXaTM+JCWHCimg8AETcdJg==
X-Google-Smtp-Source: AGHT+IEWZjda2fsJ0zD6R8OaPvGCIhuiY+08NdpNxfUAkKx96xvmVTnzBUfNL5Fr1v/oeWTLLPMssw==
X-Received: by 2002:a05:651c:117:b0:2c9:fa20:89e1 with SMTP id a23-20020a05651c011700b002c9fa2089e1mr2063453ljb.9.1701997864531;
        Thu, 07 Dec 2023 17:11:04 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id r1-20020a2e94c1000000b002c9e6cbf78esm86616ljh.19.2023.12.07.17.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 17:11:03 -0800 (PST)
Message-ID: <22f39a38-6293-424e-898e-77edc071ef75@linaro.org>
Date:   Fri, 8 Dec 2023 03:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dp: Fix platform_get_irq() check
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <c12bb69b-d676-4345-9712-48aab48f2b48@moroto.mountain>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <c12bb69b-d676-4345-9712-48aab48f2b48@moroto.mountain>
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

On 06/12/2023 14:02, Dan Carpenter wrote:
> The platform_get_irq() function returns negative error codes.  It never
> returns zero.  Fix the check accordingly.
> 
> Fixes: 82c2a5751227 ("drm/msm/dp: tie dp_display_irq_handler() with dp driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

