Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56536751367
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGLWMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjGLWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:12:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A019B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:12:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso113050e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689199952; x=1689804752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqJysxxH1qyXFydxpNCv52Aaqqbtf6IwIITmwO/wNJQ=;
        b=JBQeOa4LORI6IiOjXziMyaosDGZUzKT8grbrXHAZmLPrP8dHVOYLwvub8tlUqcaVVB
         giXaxvW6g9aVaw2k9tFBQPZWgdaMoFodILOEXc0p6pg2IELeA5TWjRWuMDTiAquAfmZK
         iel7rZZVdH8ucTP/q/y3ILDsYgLTWRT3HzCyTV52VYnyZf9get3Pyq/UdgiF/gO/fnQ3
         o8xV7l70pRaRwkFWw5v6poV7RzWOfFAyZLuibSMEhV31HywY9qSsdt6tL1rypspLJsgT
         r8v76q5j/6f5IxrzWM9p/Fa7iwKmT58lhz/qlfvUq8mmmIbvZKm1r927Xd/4s6lDNY3Q
         v8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689199952; x=1689804752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqJysxxH1qyXFydxpNCv52Aaqqbtf6IwIITmwO/wNJQ=;
        b=K54swoZEG/6Vbg4hhHp2ktIffmD5iPqer5O8oEoHfqQyKxYtP/F9oHIYtfD+zQ+Zjo
         kEZIB/AYXBnteNtrzx7zsVbgAJa5mKXXkt+Vv/zyt31+z8KKrKJlGIuL3RIAfY2fyJgs
         ZoOpweaOoq8Y1MndJ7oft84BUnp9F++fGonOBgE6oSXBV+evEzk33PQgJTS+k4g2qiMT
         JthqU3xlAEYun0Iiv/M2Wyao8vwld9ut8Nxp4C5Vai5LX5J6W+dHNsw9V2ArIgP9xgF0
         T9NlIYGLtuFxOuiDla5f5oFZxTdjcJJW2v94AcTP3+qOZLmzE4sQnktvq78Vvxdq0CYD
         AXHA==
X-Gm-Message-State: ABy/qLaw+m2UBNqNmYcXhPLg8PPtUUnpoS0nLyQshQBwDY6j579EX9pc
        +Jzc+wH6VHKXYIKqFjnNX1KXRA==
X-Google-Smtp-Source: APBJJlEYK5pVKISzqJSpYdTFE5+RBHoJVqo0NACxt7MWjJFIbYGhPLLWT27+wIuJW1HjBYGUyJft+g==
X-Received: by 2002:a05:6512:230a:b0:4fa:a217:1e76 with SMTP id o10-20020a056512230a00b004faa2171e76mr20605162lfu.9.1689199952649;
        Wed, 12 Jul 2023 15:12:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c5-20020ac25305000000b004f3789c8bd5sm866377lfh.132.2023.07.12.15.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 15:12:32 -0700 (PDT)
Message-ID: <f0778167-17c7-b072-1e44-e8b6cdeb29d6@linaro.org>
Date:   Thu, 13 Jul 2023 01:12:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 4/5] drm/msm/dpu: rename enable_compression() to
 program_intf_cmd_cfg()
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230712012003.2212-1-quic_abhinavk@quicinc.com>
 <20230712012003.2212-5-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712012003.2212-5-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 04:20, Abhinav Kumar wrote:
> Rename the intf's enable_compression() op to program_intf_cmd_cfg()
> and allow it to accept a struct intf_cmd_mode_cfg to program
> all the bits at once. This can be re-used by widebus later on as
> well as it touches the same register.
> 
> changes in v5:
> 	- rename struct intf_cmd_mode_cfg to dpu_hw_intf_cmd_mode_cfg
> 	- remove couple of comments
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 8 ++++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 8 +++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          | 9 +++++++--
>   3 files changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

