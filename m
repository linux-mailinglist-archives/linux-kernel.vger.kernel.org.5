Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4780180A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjLAXsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLAXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:48:12 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6951AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:48:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bc743c7f7so3753775e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701474496; x=1702079296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJVF1ZrmInpC3Gvm7OoxUYxrkOmo0ZmH7AoQY/EPSs0=;
        b=mZd1tuEKRfnRNS0QnROcQtzivqmaGm5La3GJFMAIGcspDCufWl11BE3goa/nC5mDQQ
         YCqC974jIbEYugeztPTDvqyIM+9yXh4wFiRRUcpqLha/OBxP34b+oTw5NS1MUS6Oct+k
         DQyhIpdTHTL8Bau8vQXNeJzDsFa1pELRgdVP0iTkPW7k2yILuwN318fSiM7WiVhcUs8U
         5iv9uDU7/Iq8FoLPv+pd/7A8eIEl++jLsl+XdBHx4RTq9VoAlVMogquSZIXWzWH5ago0
         id71As2c4cd5GqgBlDeiE4fXLzLMtIHPO+j5VVteSSTzYGcMyh0BgXbi7oNt+4cEmfHB
         fNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474496; x=1702079296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJVF1ZrmInpC3Gvm7OoxUYxrkOmo0ZmH7AoQY/EPSs0=;
        b=LBsnaT4ywgSl2737pEpdGMS1Qmdb7VyGT/19R8rNgNp2r+KqmyRxhtO1dVDaVcA1fO
         /q8FV2luKQPmJETETPvHOBBOsjNGfBeeVobXFFB+QzhFhJdIRHHX4JndOegnWA4MSAj5
         OPCef2j1UXJWKFJZSZWt3vRuTIs5YxMS+d9OGCaCgMsLpmwGMGp5lOSqCar0vV9XRcSQ
         5JmFQdBMT5djiz8Kq5qgoOoFbwnpJ7/VYDsPPV+jYs0OyFaaathlrqqlBovpl4kkiUaG
         TnObK5PhPOIfuazGhkPuYKduZBnvl7GxvM488eSpnZehYQIW+lxf6dX7uuQ8ymHUxMaq
         aImw==
X-Gm-Message-State: AOJu0Yy1pogJ7RKeWM2aiF6uK+j2SwZz6zQvqN2qZzCcXFbHNiv8n7fj
        s9vZ9dDq3aFJIPn7qlKMQTJXeg==
X-Google-Smtp-Source: AGHT+IHTNUQKLLhXANUvRoFzT3r6DBEs/yUnPcAE4JI0ahtu6IrjM/fQLRF3nClcM2LwCY50wd2GhA==
X-Received: by 2002:a2e:991a:0:b0:2c9:b8c6:1a3f with SMTP id v26-20020a2e991a000000b002c9b8c61a3fmr1491188lji.46.1701474496154;
        Fri, 01 Dec 2023 15:48:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b002c9e7c4a7c0sm118565lja.33.2023.12.01.15.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 15:48:15 -0800 (PST)
Message-ID: <e380c8c6-59eb-46c2-8b62-e9cbc4e90752@linaro.org>
Date:   Sat, 2 Dec 2023 01:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: add QMP dependency
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231016200415.791090-1-arnd@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231016200415.791090-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 23:04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When QMP is in a loadable module, the A6xx GPU driver fails to link
> as built-in:
> 
> x86_64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gmu.o: in function `a6xx_gmu_resume':
> a6xx_gmu.c:(.text+0xd62): undefined reference to `qmp_send'
> 
> Add the usual dependency that still allows compiling without QMP but
> otherwise avoids the broken combination of options.
> 
> Fixes: 88a0997f2f949 ("drm/msm/a6xx: Send ACD state to QMP at GMU resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/msm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

