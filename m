Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF597BB674
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjJFLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjJFLbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:31:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242083
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:31:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c3c424d502so6733181fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696591890; x=1697196690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KXF1BPtCc4Qnp06IeKWmuYEI/cvy2qSDqKPkYcCjtk=;
        b=yRqVVhGCHPo7a93lWNRQ6gmx62V62HSzpyjAYi8bmBG0BCHdIXpRBKDZpDey5Gpyoz
         Fg/1nLhEXrds6bAPD1NzVz6ukXJgbUdBDJThGzAZDz736gtLTwBIr9OY7OxELEEe+7bs
         QENoOhrJRLGJK2j9tTeqih4kKb2quT7o/oX5Iq9ZuNv+bQEf64pftvDePQL8T5HW71p/
         mNEFFR483hEp29w+aplH8gpUBc+u4KVXpWZ4ZJ7/qfGyb1OWy42KToBk3Qdtbh/IORKa
         rZuWJz/74EiV54eStElGl6wbPTeYEtjGBHYYyj/5+BUqN2hvNo7Pn0+3lxu9yuYGo8gw
         JfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696591890; x=1697196690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KXF1BPtCc4Qnp06IeKWmuYEI/cvy2qSDqKPkYcCjtk=;
        b=fK2Y0WPiSEaC9SNcSbQAckRNDXM/v/S8uqFkMYVJprhq1K42ayazE/mkI8JdveFYwf
         XDZ7iI/l4Awep47byalRevBWDqPUlKMhQx592mEUkTJ5kBI/R4Hui7YJ7sY31rG7Tklp
         qt+MUiMZqS6rwhooSojGV5SyWIKHrnMqlq9EbBCVx7oBDFukNJKMg64nnqLUPt+2cNPh
         jHSZE3laW88wfYNKqHgfXSAHn2snf83lVmbWtlA4qYebsqzKpd4iIO3gyyxuq5XI8DqA
         B1kwpNlxS/ekFN0k1/+Jl9HdwOcS+VEiWa8L/pO1b5OjaY5GsKPYobje28tXpW3aTB1o
         YOkg==
X-Gm-Message-State: AOJu0Yzel85zs7K7ezCgupBmZsYKh2WbVV+OXblKGTW8fb/gmYJNCoT/
        Qj9IAACLmail0gvpGXiNx1AhRw==
X-Google-Smtp-Source: AGHT+IFnb4SzgNnqN1744K1drSFI1lxMxH0rmjdh00B4/aRtrjljwPbT5PoXIyoAxOYKsWxiAGDzgA==
X-Received: by 2002:a2e:96c6:0:b0:2bc:ce85:2de2 with SMTP id d6-20020a2e96c6000000b002bcce852de2mr7283181ljj.37.1696591889169;
        Fri, 06 Oct 2023 04:31:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r6-20020a2e9946000000b002bce3123639sm743777ljj.98.2023.10.06.04.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:31:28 -0700 (PDT)
Message-ID: <f9a97fe6-89d1-40d7-8e13-c756f341bf39@linaro.org>
Date:   Fri, 6 Oct 2023 14:31:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] drm/msm/dp: tie dp_display_irq_handler() with dp
 driver
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696436821-14261-1-git-send-email-quic_khsieh@quicinc.com>
 <1696436821-14261-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1696436821-14261-2-git-send-email-quic_khsieh@quicinc.com>
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

On 04/10/2023 19:26, Kuogee Hsieh wrote:
> Currently the dp_display_request_irq() is executed at msm_dp_modeset_init()
> which ties irq registering to the DPU device's life cycle, while depending on
> resources that are released as the DP device is torn down. Move register DP
> driver irq handler to dp_display_probe() to have dp_display_irq_handler()
> IRQ tied with DP device. In addition, use platform_get_irq() to retrieve irq
> number from platform device directly.
> 
> Changes in v5:
> -- reworded commit text as review comments at change #4
> -- tear down component if failed at dp_display_request_irq()
> 
> Changes in v4:
> -- delete dp->irq check at dp_display_request_irq()
> 
> Changes in v3:
> -- move calling dp_display_irq_handler() to probe
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 32 +++++++++++++-------------------
>   drivers/gpu/drm/msm/dp/dp_display.h |  1 -
>   2 files changed, 13 insertions(+), 20 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

