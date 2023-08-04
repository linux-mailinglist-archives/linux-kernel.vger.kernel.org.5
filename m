Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF276FBFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjHDI2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjHDI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:28:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488946B0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:27:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3176a439606so1510515f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691137654; x=1691742454;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9wgTUQn0TUv85U4NzlTuNM4xsF5mRqXaVcUR2Ag3v48=;
        b=OQI01q6T8aWKBPx8fpasMUlWadmKwxaKkRt2WPRQvVM8/dxCkrDWFCOlB6J4on399q
         q+yVNeVquC4PD3/cQq9PCvjsUVN4iMNgmGwXLWQmvXSb2wBaeTjoaFVQiLeVb4nHiaLn
         xA0ABmgsQ5LegV6/F4sDwExQCoy4VKzhTZYSPyHYyLLhlj917ufGSgqvqlvzhsgUCS8F
         ac519QRNlw6EgYBBd6fM5FJr4MdfMPvsQC51Gu36hP21Z7x4XtKDesyULefrtOYi/nxU
         mR1hThJbrXMdngfG6vTeBPISvPlYDzTE+hXQnPYZku1C+qF0006qRbCr5TCR5zZl9rtd
         /Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137654; x=1691742454;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wgTUQn0TUv85U4NzlTuNM4xsF5mRqXaVcUR2Ag3v48=;
        b=GRp3iYp5jTgYFV2d8GeZ4nhuViqJWdLd/5u2SvfcT5iEh0q3JkkvSc8nYCepc09x40
         o27nYF7CHljuw6Rbo1q00gvxKbW6swXRfkr2pPMt4y0beksPmQJOQQckfmZK4/NGRKMs
         OFld3OeM8Fq7RUbeLu+dMvV/W3P+cUPUW5ziT4eptaai2nS6iE8JHafA/jNHgqRonLPH
         mbYztRGhmobtFv+ILW1xMXQYkg+epJ1JXdneIs+fPkpGlmp6k2D53+sQESNDZJ/hRyFg
         MtsHUtHZZZ7tUBxrh3Wmudg8VrWVIztXHxIEZYyxIRf/GbRer4Qee4KiDJ8CWpzNNBB2
         hFng==
X-Gm-Message-State: AOJu0Ywg0gzv7ZtvdfWd5IlQjyhEpLJuuDNS3EEzZiHVV4URWI38CLwx
        bsdrnJhx2mT3M9ccC9suK8CBPg==
X-Google-Smtp-Source: AGHT+IFvwzimT7kRHpEasj8HMGvxUFZJqMsy+rVWiIcU9lnQxLv1cng1oltuluScMA5L/0uG0BvCXQ==
X-Received: by 2002:adf:e40a:0:b0:314:37e7:efb4 with SMTP id g10-20020adfe40a000000b0031437e7efb4mr699960wrm.11.1691137654228;
        Fri, 04 Aug 2023 01:27:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b526:9083:f5a6:4af1? ([2a01:e0a:982:cbb0:b526:9083:f5a6:4af1])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4009000000b00317a04131c5sm1905558wrp.57.2023.08.04.01.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:27:33 -0700 (PDT)
Message-ID: <142025e0-9ee2-36d6-2600-085db71a3f0a@linaro.org>
Date:   Fri, 4 Aug 2023 10:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <CAA8EJportnT-xHFH8QP+aiomXMLbm1r=02HMB-eNDEU+JqgEoQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAA8EJportnT-xHFH8QP+aiomXMLbm1r=02HMB-eNDEU+JqgEoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 11:08, Dmitry Baryshkov wrote:
> On Wed, 2 Aug 2023 at 11:52, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> This reverts commit [1] to fix display regression on the Dragonboard 845c
>> (SDM845) devboard.
>>
>> There's a mismatch on the real action of the following flags:
>> - MIPI_DSI_MODE_VIDEO_NO_HSA
>> - MIPI_DSI_MODE_VIDEO_NO_HFP
>> - MIPI_DSI_MODE_VIDEO_NO_HBP
>> which leads to a non-working display on qcom platforms.
>>
>> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
> 
> Nit: I think the preferred form is to write `... reverts commit abcdef
> ("foo and bar")', but I might be wrong.

Yep, I'll fix all that while applying.

Thanks,
Neil

> 
> Other than that:
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Robert Foss <rfoss@kernel.org>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>> Link: https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
>> index 5163e5224aad..9663601ce098 100644
>> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
>> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
>> @@ -774,9 +774,7 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
>>          dsi->lanes = 4;
>>          dsi->format = MIPI_DSI_FMT_RGB888;
>>          dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>> -                         MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
>> -                         MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
>> -                         MIPI_DSI_MODE_NO_EOT_PACKET;
>> +                         MIPI_DSI_MODE_VIDEO_HSE;
>>
>>          ret = devm_mipi_dsi_attach(dev, dsi);
>>          if (ret < 0) {
>>
>> ---
>> base-commit: f590814603bf2dd8620584b7d59ae94d7c186c69
>> change-id: 20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-6f042b1ba813
>>
>> Best regards,
>> --
>> Neil Armstrong <neil.armstrong@linaro.org>
>>
> 
> 

