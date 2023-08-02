Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2869376CCD0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjHBMhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHBMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:37:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9626AF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:37:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e742a787so578796f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979825; x=1691584625;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jrSPn8uyBFzRlxR+Ji/34MvxQrN7UVymtJpqlJ09TOQ=;
        b=LhGQ8Ujrxun3Cl8x3JP5tCEBSn9XR8IAaa7hkvYRe9Ss1m9YPVHELYUxyQM5ZMtdiA
         T0qZdmi/3Q+h19quNandhvsRj1MVGldnputZWZBhe77Xd3hZnu1xBn4eQNyBkX+W3pjF
         nuQ4c96VjSU++8tUislZZ1eVxwd6lQdNyC0/jUN84X8mpemDTfMG1pYOUERUTi1Em1ot
         Xk3+0hZY+7UxobD7CIdp3JF8rPqBLUqEjF6NVAva4RAu6akZqrnGcQ+bnZkDchii8Acb
         C/zqWJS84HnMpmPmR7GcQAHtxvQpmYjYMJxVJYUPpGVox5Ds/0PXnoNNRE/5vUVZDQKj
         OiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979825; x=1691584625;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrSPn8uyBFzRlxR+Ji/34MvxQrN7UVymtJpqlJ09TOQ=;
        b=hEzeJz7kqislnstmlHLmVyZR8nQhnNqRDDtE1R4Umhis4KaGCkC/3243q0h3+u61lY
         XCA1FCblq2fQZ+TmoJOiti+4Bc5nIOQIpfRDEwBLVYN0sALBt2IEfpxM3NzHOlO2tZqi
         tQrLrwOy09nauuuCYANSq402+x+mjr7guG1Z57aBhBM6KkPYiMxbE2O9ujTETc8FgOUO
         ekkxJmFT9Otq/n2ghp8IoM5JpF9AL7Ppw28ppD7k5oQKGhkCIeDiInmE6rQmwBnSyscf
         gkqeThGLcxxoJD3wUDBsIOmwcKklVrTxVuRwiyt+aT2wghf+M24QfSK2SukXwJVJIcW7
         EIHg==
X-Gm-Message-State: ABy/qLalEtZ4aP1GFVMyYTewieTIRy4XUN71JYTtmhB1hSySLEQvj/tB
        R7YjoAZqiiR+JeFMR1nchB2w4w==
X-Google-Smtp-Source: APBJJlEwph2F2iPAVAzMcuAz2CiigiGjwl6AbLLv8PVkzvqa+Q652tWVZe8/GW+lCGFBb18f92FqUQ==
X-Received: by 2002:adf:f108:0:b0:317:6855:dc24 with SMTP id r8-20020adff108000000b003176855dc24mr5085178wro.21.1690979824908;
        Wed, 02 Aug 2023 05:37:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196? ([2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d6b85000000b0031455482d1fsm5081609wrx.47.2023.08.02.05.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:37:04 -0700 (PDT)
Message-ID: <c2644543-2e81-3351-ee1e-76f5f32c4ac5@linaro.org>
Date:   Wed, 2 Aug 2023 14:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <6cd079a4-2f5b-0169-cbaf-b59a72f1b32b@denx.de>
 <084ca94e-d694-878e-0646-f4c89043cd28@denx.de>
Organization: Linaro Developer Services
In-Reply-To: <084ca94e-d694-878e-0646-f4c89043cd28@denx.de>
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

On 02/08/2023 14:28, Marek Vasut wrote:
> On 8/2/23 14:07, Marek Vasut wrote:
>> On 8/2/23 10:52, Neil Armstrong wrote:
>>> This reverts commit [1] to fix display regression on the Dragonboard 845c
>>> (SDM845) devboard.
>>>
>>> There's a mismatch on the real action of the following flags:
>>> - MIPI_DSI_MODE_VIDEO_NO_HSA
>>> - MIPI_DSI_MODE_VIDEO_NO_HFP
>>> - MIPI_DSI_MODE_VIDEO_NO_HBP
>>> which leads to a non-working display on qcom platforms.
>>>
>>> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
>>>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Robert Foss <rfoss@kernel.org>
>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
>>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>>> Link: https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> This breaks LT9611 operation on i.MX8M Mini/Nano/Plus, so, NAK.
>>
>> I am currently using this LT9611 with Linux 6.1.y
> 
> Correction, 6.1.y only with the DSIM patches backported.

Well you'll need to keep [1] backported on your downstream branch,
this revert won't propagate to v6.1 stable anyway.

> 
>> in production and this is not acceptable. I also believe the correct fix is on the MSM side, not on the LT9611 driver side, since MSM incorrectly implements these flags.
> 

Since [1] breaks Qcom boards on v6.5, and [1] was added for v6.5 to make the bridge work
on i.MX8M Mini/Nano/Plus, it's not acceptable either to keep it for the v6.5 release.

Neil
