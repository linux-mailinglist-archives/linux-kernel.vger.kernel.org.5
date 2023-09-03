Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5F790F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348902AbjICWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347610AbjICWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:39:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE3710D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:39:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52c9f1bd05dso1221201a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693780756; x=1694385556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJDVZGRXNPlbG+uW3nJBHU09g5j3lMYwRuZyrmz3c3s=;
        b=A9R2HPF7b9Rnaw/vH4m8rrUA90CWXX0it9o+shcTv1isTnhcVAe7JJBHc62qyV9ENN
         3Ya6ilV0CEdRB0d85byngRpfmbIq4FiAhD0Did8zr8k9QTZM08XnitXefmxdLpAN7S0D
         /TMWv1bJ8qKWtcxST2xb0cxbwCZhefTzYpN5WZryJEN4bpcVXRRnaW3B88KeymW0Lczc
         uZCfxAPsNacRi9Kk/7i6qdkrGApP7To4G7ff2gROKYJzvZMIb81L23Dc5NM8jbMox2OV
         jQbdvszTvCSgp8A0NLKti/YX05y0QB4tV8FvgEHAcpw8VBsCX8xXBT3f0JCXhFUaahLq
         X6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780756; x=1694385556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJDVZGRXNPlbG+uW3nJBHU09g5j3lMYwRuZyrmz3c3s=;
        b=Nxu7FL3hvhc87GayOj03965LcOXATHf6Xc6xASBq+YRIrK7+S4HHApxnPqVClXYFeV
         hCjmf/4xl1GlD1+I8IaMULzVh5A0iBa43aw78eDuUv3YYSvNzbm7qdGK9lsi5xSoKjOR
         UM19oRFwuoqid7BP6kblga7B9pwQo/ybJsKQMSBq+7583yEFuFZBO6Dfgdiklk9C5tAW
         s8P5YgfttxLJj7omSQ+nd/+XBAyfI4LhKCvLgxrNHKE777cFIqhsRM0jqLBoMSy9Cw2I
         5Wx5Fc/ChB2dx8nJHvJeP5isJzmIF6nNObbYsXNaX2r2tgtRH5DbwDBmKS4bGo1wN5M+
         gveA==
X-Gm-Message-State: AOJu0YwXqqslpbdH20eOxIOd5pFZhkSa2I6shRUg5Q9Y7M0LFl+FCsWr
        qg8FyFTDajD1or+/n+5EoSJruw==
X-Google-Smtp-Source: AGHT+IE8rdKKfRtiKAW4qUZx2CR6ApBgBWNohpTtDZ86s5LagIbmW/Z33cweCIm3MWR7p4a6suEfqA==
X-Received: by 2002:a50:ef1a:0:b0:523:6c47:56f8 with SMTP id m26-20020a50ef1a000000b005236c4756f8mr7429079eds.18.1693780756071;
        Sun, 03 Sep 2023 15:39:16 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052889d090bfsm4972604edb.79.2023.09.03.15.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:39:15 -0700 (PDT)
Message-ID: <74f45f3a-d075-4911-8173-2ddf4ba74b02@linaro.org>
Date:   Mon, 4 Sep 2023 01:39:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/msm/dp: Remove aux_cfg_update_done and related
 code
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
 <20230829184735.2841739-5-swboyd@chromium.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230829184735.2841739-5-swboyd@chromium.org>
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
> The member 'aux_cfg_update_done' is always false. This is dead code that
> never runs. Remove it.
> 
> Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 15 ---------------
>   1 file changed, 15 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

