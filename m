Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48D76CE2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjHBNQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHBNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:16:12 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDF41707
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:16:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so55954181fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690982169; x=1691586969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QuYbDs0o/lKReDAlVsA0tmrajcMvPefdsHw2ReF2TME=;
        b=Qp/4qWRHDJbL+JzF6LcscHIRKDocxkRUkWLRJc6by/yns1P0xKX7TS9k9iCa3dbcb5
         uTZkKyXKBZrlpK99odYF7sYYF3w9prf+ssgAtfzhZnFCbNmt40P2xeRQhbr+jsQXmRiq
         N836nKx/P4KwxIQDDCCHkazOyc5lfJcP5OeKUcknBIii+e9u0URXf3+qZOeGQOvbhPwZ
         4q9DpjxVJdHMeRnqftvmBqdV5lVA4aCQog/5o5wDv+I1svZO6uxhu4AfCMKomQI2yOuv
         zc8JBhhFAyT/TQ3I+5THmVFoyMMd304o+KhVJts6Ww1hKT+SjaY8VwsEhNz7XhFKWubO
         +8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982169; x=1691586969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuYbDs0o/lKReDAlVsA0tmrajcMvPefdsHw2ReF2TME=;
        b=DdQ2YJ1cYA5k72iXUo67kKfoKYKNCwAxIlJAjgEi+v8pvJXdV6M15oUaAHBnPjOHkY
         Xyd3PJz8R3s3BivhlWGujjqmBao/oswdIIkcSHgKF3AD6GFNdVyP7izF8PX/Y2g+DH6h
         Je/aEIARmVh6SZ8LJBW8wNXlT2xGtHLT3xSOK91SHUR6ZcRb8mulEyoTXJpJ2LC5GQyq
         XhQj5Bap2cNapvt7ZWdIF7TUK1IzQl73O77lRy1gLStUUno6VI3zn1Lz/G/X2FH6HKNH
         32vrf6qkDc2CpEX0N2mMmSHd+qSWlyWb4Uk84h9+/A1JnDNubvhUTa2uGT0ZSPiuH7El
         a04w==
X-Gm-Message-State: ABy/qLbcuZd38Rp/1zkVRE7pblV+S6vFxl71C5EMOTJenbzfyk7dBj2R
        pm5kS0X1GQDU3BjH9Fck3wwJHQ==
X-Google-Smtp-Source: APBJJlEwf8cbRfEkX+3lgs9hZ2Yhr7Pb+DMnJsd9bIOtfsF7jalxDXP4wlTacz5kIsfila/3ymvwXg==
X-Received: by 2002:a05:651c:14b:b0:2b3:4ea3:d020 with SMTP id c11-20020a05651c014b00b002b34ea3d020mr5205327ljd.17.1690982169195;
        Wed, 02 Aug 2023 06:16:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id s19-20020a2e9c13000000b002b96a8e1ebfsm3594890lji.87.2023.08.02.06.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:16:08 -0700 (PDT)
Message-ID: <6f96cd11-5055-ab36-74e3-20a45c0d8b40@linaro.org>
Date:   Wed, 2 Aug 2023 16:16:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-GB
To:     Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <6cd079a4-2f5b-0169-cbaf-b59a72f1b32b@denx.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <6cd079a4-2f5b-0169-cbaf-b59a72f1b32b@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 15:07, Marek Vasut wrote:
> On 8/2/23 10:52, Neil Armstrong wrote:
>> This reverts commit [1] to fix display regression on the Dragonboard 845c
>> (SDM845) devboard.
>>
>> There's a mismatch on the real action of the following flags:
>> - MIPI_DSI_MODE_VIDEO_NO_HSA
>> - MIPI_DSI_MODE_VIDEO_NO_HFP
>> - MIPI_DSI_MODE_VIDEO_NO_HBP
>> which leads to a non-working display on qcom platforms.
>>
>> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and 
>> EOT packet")
>>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Robert Foss <rfoss@kernel.org>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA 
>> and EOT packet")
>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>> Link: 
>> https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> This breaks LT9611 operation on i.MX8M Mini/Nano/Plus, so, NAK.
> 
> I am currently using this LT9611 with Linux 6.1.y in production and this 
> is not acceptable. I also believe the correct fix is on the MSM side, 
> not on the LT9611 driver side, since MSM incorrectly implements these 
> flags.

There is no indication that MSM gets these flags wrong.

Let me quote the DSI 1.3 (I think Abhinav already quoted DSI 1.2).

Chapter 8.11.1 Transmission Packet Sequences:

========
If a peripheral timing specification for HBP or HFP minimum period is 
zero, the corresponding Blanking
Packet may be omitted. If the HBP or HFP maximum period is zero, the 
corresponding blanking packet
shall be omitted.
========

Next, chapter 8.11.2 Non-Burst Mode with Sync Pulses

======
Normally, periods shown as HSA (Horizontal Sync Active), HBP (Horizontal 
Back Porch) and HFP
(Horizontal Front Porch) are filled by Blanking Packets, with lengths 
(including packet overhead)
calculated to match the period specified by the peripheral’s data sheet. 
Alternatively, if there is sufficient
time to transition from HS to LP mode and back again, a timed interval 
in LP mode may substitute for a
Blanking Packet, thus saving power. During HSA, HBP and HFP periods, the 
bus should stay in the LP-11
state.
========

So, by the spec, sending the HSA / HBP / HFP as blanking packets should 
always be accepted (and it is the default mode). Switching to LP-11 
should be permitted if there is a sufficient time to switch to LP-11 and 
back. Not sending the packets is only possible if the peripheral 
(lt9611) says so.

We already know that lt9611 breaks if we try switching to LP-11 during 
this period. We know that the there is a requirement time for the HSA / 
HBP / HFP, because the HDMI monitor needs them. Thus, I can only 
emphasise that the behaviour before the offending patch was correct.

Last, but not least, breaking the in-kernel platform for the out-of-tree 
peripheral doesn't sound correct.

I can only propose the following steps:

1. land the revert to unbreak existing users.

2. Marek to propose and land the DT bindings & driver change that will 
enable the workaround for the particular platform (i.MX8m).

-- 
With best wishes
Dmitry

