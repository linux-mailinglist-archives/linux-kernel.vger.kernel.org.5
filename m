Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3777B324
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjHNIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjHNIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:01:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5297D9F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:01:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3197808bb08so486561f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692000089; x=1692604889;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HyrK9yUrT2T/ZNwRuy5YfUlkcnbL8Wy7txqOlS3kQs=;
        b=V6nDojvQDv+P/XF51KDUUdYDT1s9etF/cA5SWF72dHO3IJEWPbYYs0ztztyGHOv3nx
         200XucdYmp6wBwpUSphf9+ck6gNpSaBifeIWHLgNz0JdHXcZeDR9sD2t3aLuWuOxsDqa
         2Ebv2+jvjvI3Zd573qIDHxccD5xvmV0/3H7tlBsYR1fM2A0szxmCC1wlEhJQE6rkTNZB
         hQRj5czf/Jw58bTWTgIElQRpkTEgIsl+V9BV1cPnG/G43XrHkrq6YtBepuJzpr6y2TlA
         MTYYi16rap0+TcY9oKXksWIp36RRNvmGTsJWNfLeXDrikC6crfBwrRXjpQ8TPsyPFWsx
         V/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000089; x=1692604889;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+HyrK9yUrT2T/ZNwRuy5YfUlkcnbL8Wy7txqOlS3kQs=;
        b=QPKr70SccFEdJNfpb3fATMOGss93k4LZThv0Kq/gQNkSjIxN2sje82khxrG91K04Bn
         XyggnaGIdbOPiuVvjoTurSkIcR5TbtClvCAt5zZQUyylkFQxYgA1xTjJxYWkbs825B1N
         XOzlk4UjrFE5vqRwsmtg7lGLND2Wpz+uKcLBZIbkx/Ht1AFLK//EOUzIKKG8yo64Sybg
         scSBbMCcp2esmTI+ZaqgyEnHaCVa4b+v36V/lS10tq5Vq3X/7T8jD8vQ3CjfhFSk/2iH
         W/14BTIn20Ws1tJi88MRYrifsK9bqIsHP+5VmQUj2pqn2m+S4oY+IbzxOcOlyhmr797l
         CmWQ==
X-Gm-Message-State: AOJu0YyW4kXaPTAoyRzwCMSrV65Xiwo9LKREhwaozqn7RbcKEVcJ6tSj
        Sk2arKNOZeN6/9BSuiu83rH7oA==
X-Google-Smtp-Source: AGHT+IFdabwukLrD2dl+LcZLuQ3MoNMALZ/80yTL4ZPZvc66Cl28Ph45jSNj/aK3qCih/TW0KUiypg==
X-Received: by 2002:a5d:54cb:0:b0:317:5e73:7594 with SMTP id x11-20020a5d54cb000000b003175e737594mr5546842wrv.28.1692000088649;
        Mon, 14 Aug 2023 01:01:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d5106000000b003141a3c4353sm13605343wrt.30.2023.08.14.01.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:01:28 -0700 (PDT)
Message-ID: <6c0dd9fd-5d8e-537c-804f-7a03d5899a07@linaro.org>
Date:   Mon, 14 Aug 2023 10:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     quic_parellan@quicinc.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230725-visionox-vtdr-prev-first-v1-1-3bc44cec7dc6@quicinc.com>
 <dde2774e-6f0b-21d0-e9c9-4a5bd1eac4e8@linaro.org>
 <2f9a9450-438b-257d-759c-22b273a7b35d@quicinc.com>
 <c183d823-81d4-6d7c-98d9-649fa4041262@quicinc.com>
Organization: Linaro Developer Services
Subject: Re: [PATCH] drm/panel: Add prepare_prev_first flag to Visionox
 VTDR6130
In-Reply-To: <c183d823-81d4-6d7c-98d9-649fa4041262@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhinav,

On 10/08/2023 18:26, Abhinav Kumar wrote:
> Hi Neil
> 
> On 8/3/2023 10:19 AM, Jessica Zhang wrote:
>>
>>
>> On 7/31/2023 6:00 AM, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 26/07/2023 00:56, Jessica Zhang wrote:
>>>> Due to a recent introduction of the pre_enable_prev_first bridge flag [1],
>>>> the panel driver will be probed before the DSI is enabled, causing the
>>>> DCS commands to fail to send.
>>>>
>>>> Ensure that DSI is enabled before panel probe by setting the
>>>> prepare_prev_first flag for the panel.
>>>
>>> Well this is specific to MSM DSI driver, it's not related at all to the panel.
>>
> 
> I dont fully agree this is a MSM DSI driver specific thing.
> 
> If the panel can send its commands in its enable() callback, then this flag need not be set.
> 
> When a panel sends its DCS commands in its pre_enable() callback, any DSI controller will need to be ON before that otherwise DCS commands cannot be sent.
> 
> With this in mind, may I know why is this a MSM change and not a panel change?
> 
> As per my discussion with Dmitry during the last sync up, we were aligned on this expectation.

As of today, only the MSM DSI driver expects panels to have prepare_prev_first because it's the first
one calling pre_enable() before the DSI controller to be on, all other DSI drivers I know
still enables the DSI controller in mode_set() and thus can send commands in pre_enable() which
is a loose way to map the pre-video state for DSI panels...

A panel driver should not depend on features of a DSI controller, which is the case here
with this patch. Today's expectation is to send DSI commands in pre_enable() then when enabled
expect to be in video mode when enable() is called.

The main reason is because some DSI controllers cannot send LP commands after switching
to video mode (allwinner for example), so we must take this into account.

For v6.6, I don't see other solutions than reverting 9e15123eca79 (reverting won't regress anything,
because now it regresses also other panels on MSM platforms) and try to find a proper solution for v6.7...

Neil

> 
> Thanks
> 
> Abhinav
> 
>> Hi Neil,
>>
>> I think there might be some confusion caused by the commit message -- instead of "enabled before panel probe", it should be "enabled before panel pre_enable()" as the panel on commands are sent during prepare(), which is matched to bridge pre_enable().
>>
>> IIRC the general rule is that the panel driver should set the prepare_prev_first flag if the on commands are sent during pre_enable(), so I'll keep the code change but correct the commit message if that's ok with you.
>>
>> Thanks,
>>
> 
>> Jessica Zhang
>>
>>>
>>> Neil
>>>
>>>>
>>>> [1] commit 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")

It's not the right commit that cause regression here, it's :

9e15123eca79 drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset

>>>>
>>>> Fixes: 2349183d32d8 ("drm/panel: add visionox vtdr6130 DSI panel driver")
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>>>> index bb0dfd86ea67..e1363e128e7e 100644
>>>> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>>>> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>>>> @@ -296,6 +296,7 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
>>>>       dsi->format = MIPI_DSI_FMT_RGB888;
>>>>       dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
>>>>                 MIPI_DSI_CLOCK_NON_CONTINUOUS;
>>>> +    ctx->panel.prepare_prev_first = true;
>>>>       drm_panel_init(&ctx->panel, dev, &visionox_vtdr6130_panel_funcs,
>>>>                  DRM_MODE_CONNECTOR_DSI);
>>>>
>>>> ---
>>>> base-commit: 28a5c036b05fc5c935cc72d76abd3589825ea9cd
>>>> change-id: 20230717-visionox-vtdr-prev-first-e00ae02eec9f
>>>>
>>>> Best regards,
>>>

