Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFD790F12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbjICWjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349060AbjICWjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:39:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA2DFB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:39:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4bdso1085169a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693780768; x=1694385568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64IskuQuClXBpnMvldmQrJ5JN6x55RtC96YOLaP2MLE=;
        b=e71isxNG97bmhW9j7JXMjkIvfdJlHdzxqga09kLZ8hqjmziHK7x/8nozXT19GQ6U7P
         SikJ2hNj2ug0yOGSVtxDrZA5uXznEGXPV0dufgpHgVBS9//3vd3ozoBL/8LPyqSkAw5O
         zbhl+0OG9/HLwqX6y88jVcwFJVMMT+eMT0uhO99uHlAfkZQrsX+BTFiQ27Dqnk+3jnII
         m7gf4UjxHtOf8GTJ/1AltyhvlQi74uHNlEDLqHhgcUUAN+SDfJu34EEZ3nGslWQiWTOc
         RXy+Rx3wQK58+27FF2HmseA4dI/Z0pymQQ8RuXHFTyEFF/PTX6ZwTJp4IxOVQg3H5ZuT
         ggjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780768; x=1694385568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64IskuQuClXBpnMvldmQrJ5JN6x55RtC96YOLaP2MLE=;
        b=MQN76Ao3yo525QKLoP525l0EJeNxLzrvGIBlLfrdZ61h8jO0kpNAVDIEQk8KToVi7T
         +ZOoPNldlpHPVsjlsW4JK7RLxyrSVHcsGLOCPMOp4Xq/kygl0gtY8MTsKRJcaZEkLNMy
         TAGaFkjNZQjFpl+ULgcpQuh9ew5R6sxWpG0gq5llZRV6Rk7HzeO6WSKAtMgM0FcUcBnL
         BXz1MSxrw1pdIXpn5Gh/70CMJjSEoVfsKa53vYo67unyzVLn1XKnUi4CZQNGbWndXjEQ
         7fkTqRuPbIMjwYMsfw0btsMYfzDvWS/psaF3OCIIcL958qFcFNNYC1ii278HFNnPozQ7
         xvsQ==
X-Gm-Message-State: AOJu0YyuvHvm4BQOm7gGjem0vvDpv8Q8IQWv/vh9kAAGSWa731UM2RRS
        Oafq2UAyBw7YZkHwIWX/AQBaaA==
X-Google-Smtp-Source: AGHT+IEx1q4XhkhCeBmp20jVm4futZYqogZ7sv4YonHFB6mBEBeALQ2rV63p1riW/bCqaQU7aIQdQw==
X-Received: by 2002:aa7:d9cb:0:b0:525:69ec:e1c8 with SMTP id v11-20020aa7d9cb000000b0052569ece1c8mr4984850eds.40.1693780768344;
        Sun, 03 Sep 2023 15:39:28 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052889d090bfsm4972604edb.79.2023.09.03.15.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:39:28 -0700 (PDT)
Message-ID: <900f1290-e7ed-4f61-be10-53955171abb4@linaro.org>
Date:   Mon, 4 Sep 2023 01:39:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/msm/dp: Simplify with
 drm_dp_{max_link_rate,max_lane_count}()
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20230829184735.2841739-1-swboyd@chromium.org>
 <20230829184735.2841739-6-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-6-swboyd@chromium.org>
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

On 29/08/2023 21:47, Stephen Boyd wrote:
> These are open-coded versions of common functions. Replace them with the
> common code to improve readability.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

