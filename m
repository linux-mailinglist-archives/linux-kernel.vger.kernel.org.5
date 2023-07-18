Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8882E7587DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGRWAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGRWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:00:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69A1995
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:00:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so10235791e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689717617; x=1690322417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGhTE283vqSMbHE6NrAjPBOLH8wxgNh+ZZrxUXaoOpA=;
        b=ptwRQKkVwDdm7SgUSdqf5CGN3sboG/MAmMkkl8n6rXlRERI/19F7r0DmslJIxUZegm
         rjG5fC03XibcUo7oTKTvN96fEyYL3qgzz5iVCgXR1yoDk8a01ZC2F4GRIYgn5I/azdBB
         3zc15HqhLpqUx6XyH8Y704XRM6SxQObwURYueJP5DYM3FJkX/fqoKHy9FsqsEavtBxSl
         yVkZkWA6MgAMkT9RY7Ea/zE8svFgtm3dIOKFp9FOA5IqOCyf1Y8Dhq5s1iHvDkbxsPe1
         FZAnI/bN8h6RZ5iyI5gH8G2nAvgkiRwBiCIVpWH+bsyiCJ1fbi8vKo3HEf93cuP4koO3
         fP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717617; x=1690322417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGhTE283vqSMbHE6NrAjPBOLH8wxgNh+ZZrxUXaoOpA=;
        b=W9FGHcEKCYbzu+gS9UGh+VScvdWUYMLoZ/WxCP8dn597c2HH79wOb5An9B6LD35rSu
         GkDUCTNRUcQvhoqYogq5oFboFJ9dGH4yTOjTz3+PutbI56QNGbT5bqyUHPCQTx3INBYF
         1ge39nCpmPLK9qtsmzw2DMZgRfvxK5y5hlfbNDSk/+2Rtw89aYeCLw1z2rtEclgGMwEp
         wvZq0UUb/r+7RW+dNhf0I0BCpmmz2nnjxdClEtQ6dxTKhPuO7uQCb0K+PGh6+nQ+7QTS
         Ix/x4/9n7z966/hCbjfKUU06l9cDbM4B+d85AjawHVuLLbyFwe8GoehHO40++/wMqhy9
         ArwQ==
X-Gm-Message-State: ABy/qLZKvYggd1yPCidZeNdL0HA6TkLGFqWcBiPsb/Ml+pZ2REcCLiO8
        9suJgkIMWNZdmWT7ubzmBQ6Avg==
X-Google-Smtp-Source: APBJJlEiOlxqInpn4QDlGr4ndEv7whiX69SmWBBj7JvBf6THmHQRPk5bwDDcnQpA0AuCyVER4jwGUA==
X-Received: by 2002:a05:6512:234a:b0:4fb:8b2a:5e09 with SMTP id p10-20020a056512234a00b004fb8b2a5e09mr12140549lfu.43.1689717617303;
        Tue, 18 Jul 2023 15:00:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b14-20020ac25e8e000000b004fb745fd232sm633614lfq.30.2023.07.18.15.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:00:16 -0700 (PDT)
Message-ID: <ca9cf8b1-7a2d-dee5-5ce4-2ac338b2ecb5@linaro.org>
Date:   Wed, 19 Jul 2023 01:00:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/msm/dsi: Enable DATABUS_WIDEN for DSI command mode
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, quic_abhinavk@quicinc.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>
References: <20230713-add-widebus-support-v2-1-ad0added17b6@quicinc.com>
 <91bc6348-2030-85dd-1492-1609b392793f@linaro.org>
 <05996344-0e43-7f37-c99a-42c04f91dc83@quicinc.com>
 <CAA8EJppFDcrVdegskSD0TJPOdSzVw_50+Bq+u8LKn26jdKE=tw@mail.gmail.com>
 <19ff3766-a73e-761d-8965-015817fa9c0c@quicinc.com>
 <637e4979-cadc-2167-a14f-25363c9da990@linaro.org>
 <2804b7c7-0ed2-6490-3316-7a38eb1262f8@quicinc.com>
 <d7b93f39-e866-899b-578f-17f7bdd5bdd5@linaro.org>
 <b2b044f7-9ddd-1d68-4eae-d5670e70cc8c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <b2b044f7-9ddd-1d68-4eae-d5670e70cc8c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 23:44, Jessica Zhang wrote:
> 
> 
> On 7/17/2023 11:04 PM, Dmitry Baryshkov wrote:
>> On 18/07/2023 03:30, Jessica Zhang wrote:
>>>
>>>
>>> In addition, *_is_widebus_enabled() would only work under the 
>>> assumption that DSC (if supported) will always be enabled during 
>>> bootup for DSI. If there ends up being support for a panel that 
>>> allows for DSC to be enabled on the fly after bootup, the proposed 
>>> *_is_widebus_enabled() check would break since the assumption that 
>>> DSC is always enabled on bootup would not be true anymore.
>>
>> Why is that going to break?
> 
> 
> Currently, the msm_host->dsc is initialized in attach() [1] and we do 
> widebus setup during power_on() [2]. So we can assume that if the panel 
> supports DSC, msm_host->dsc will be not NULL during power_on() and the 
> widebus setup will work as expected.
> 
> However, if a panel supports enabling DSC after bootup, then 
> msm_host->dsc will be set later within the commit enable() path meaning 
> the necessary widebus setup during power_on() would *not* happen (as 
> *_is_widebus_enabled() would return false on account of msm_host->dsc == 
> NULL during power_on()).


Minor corrections:
- power_on() happens during pre_enable() stage,
- the dynamic msm_host->dsc can also be set during pre_enable() stage.

Note: there still exists dsi_mgr_bridge_mode_set(), which can also be 
used to set msm_host->dsc (however I would prefer to drop mode_set() 
completely and set the mode from atomic_enable().

I'd say, this is the minor issue. The dsi_timing_setup() is plagued with 
if (dsc) checks, so if we make DSC dynamic, it will have to be audited 
anyway.

> 
> Thanks,
> 
> Jessica Zhang
> 
> [1] 
> https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/gpu/drm/msm/dsi/dsi_host.c#L1587
> 
> [2] 
> https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/gpu/drm/msm/dsi/dsi_host.c#L2359
> 
>>
>> -- 
>> With best wishes
>> Dmitry
>>

-- 
With best wishes
Dmitry

