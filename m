Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C0790E91
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjICVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjICVvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:51:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A987EF2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:51:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso370697966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777901; x=1694382701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTOF9j4For5+IkQ27e09HtuZibYF6090duIvPCLqj1Q=;
        b=DrP7f358Y4qa8KG3MnYEqwMHeYWtfpCgIN8i7YdEGQ0jBCe/jUH5f+qiNjH8VfrdTq
         0sG7iKq4vFD74hREAfrEGjtBqWXtGBlEi72M3q8TIXEtYXZSs+iMODLTMAkJDby9lTB9
         mPqxlIUp6Z11lEkwWkzGYndgsf2VOxnsI5dCqp8Q4huhL4UV1C47RiX9E5tCZg5ep5V3
         aIARWttVfYWw6Dib2getMqhi5yqFAY9/lzQ2GOC0UTqdWLLR61V6jZR9esKfqd8iqx/5
         8vk7dW4r1R+fqkZqLSCcQCf7wZmzfZCU1oaWASOQBIR6L7YuXk4L6olNqnJcyItrmZJl
         vHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777901; x=1694382701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTOF9j4For5+IkQ27e09HtuZibYF6090duIvPCLqj1Q=;
        b=ZK3WxcILAP3LDihZjFmY3i8r+MkzoSzZMpCTv/WthaMCjEMnBq6jUJol9aUYHCIJ2A
         vYWu5YtfMywNX4Zzle9umIqAuOizUYAjH7nHLELY97bYUA4mc0Qr52sStURhCdN7UqOL
         vREJttbTiEO3Y13T606lfu9Rf/rbMCGJV+ZJLiDi2JbZwn+e/P0N5kf17IqjRQ1Ph5tl
         j3dE697vWoSTIFMoJEGjun+zG9o3ulw/BKzMhgtbpr7nBYq8T5zi/D9nhalvU6Bz84YL
         YahGOqH1aiXooPeh+Z0ObbM4VEuRmENuXz7+bI2B0oF9ibnQhGdJw86aBCFIpXvYthsQ
         9m0g==
X-Gm-Message-State: AOJu0Yw+4pPbvCHCIw8jJFPWTZEekg9tj9Dq/ssOM4/Jy8u9WsX1x2gV
        TuFIRLqUmjgYXWEB1T6jhiithA==
X-Google-Smtp-Source: AGHT+IGowAV7YLEFVUh9WoNGqh2dZVwEtPGL9Ejeb0BlXBpT0gKXQdTAwPamljsIXC+jZmW3nDLZWQ==
X-Received: by 2002:a17:907:7804:b0:99b:4210:cc76 with SMTP id la4-20020a170907780400b0099b4210cc76mr8743881ejc.28.1693777900332;
        Sun, 03 Sep 2023 14:51:40 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id jo26-20020a170906f6da00b0099ddc81903asm5256353ejb.221.2023.09.03.14.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 14:51:39 -0700 (PDT)
Message-ID: <af6f9379-76f5-44ae-9869-86c63caf3ab6@linaro.org>
Date:   Mon, 4 Sep 2023 00:51:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/msm/dp: do not reinitialize phy unless retry
 during link training
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org,
        marijn.suijten@somainline.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com>
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

On 09/08/2023 01:19, Kuogee Hsieh wrote:
> DP PHY re-initialization done using dp_ctrl_reinitialize_mainlink() will
> cause PLL unlocked initially and then PLL gets locked at the end of
> initialization. PLL_UNLOCKED interrupt will fire during this time if the
> interrupt mask is enabled.
> However currently DP driver link training implementation incorrectly
> re-initializes PHY unconditionally during link training as the PHY was
> already configured in dp_ctrl_enable_mainlink_clocks().
> 
> Fix this by re-initializing the PHY only if the previous link training
> failed.
> 
> [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/30
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

