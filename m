Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E1176AE9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjHAJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjHAJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:39:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264021996
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:37:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31765792c7cso5679085f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690882659; x=1691487459;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KPQo2Sh4IXaPrcdWyouCsvWXkycrqlPg24jNznzZZU8=;
        b=xPrZ0QsT+UCwbOrRmQ1iTIgW5yLAxZGGQqiow0SZZkONajlepMLeQGKf+pUxiUVpni
         KPaXzaJpC85Lp8y3d1XsgoRj9+8WuvMQV9q1yMgrqGsFjlg8ivD+Pl3Q97MZQKakSd23
         swWMMlKChNDlsbz8BTs96LibCclG20GI8kLt793fFNTbVeHQKp+Y6vq/rigZ92gZwktV
         jdnOJU7RmWicqqlovnGi2z5Nvcom6MPsZrFYRGgsKfFFrEWVkHuvm9veLdSZaJqvyWzG
         LnP3Yyc8mzEObLF17JiS/jyqK+RwPdm4zVmxzvoZ5ws04ay7y9PN0H38KB3dNKkoQfLF
         vt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882659; x=1691487459;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPQo2Sh4IXaPrcdWyouCsvWXkycrqlPg24jNznzZZU8=;
        b=L+Y5b04yJOkSTXB72UkMU6Co1o24jbwYmbZtiJI/Is/FL5BJdpPgnRM5w392kc61xI
         Ek7IwVrTUa6aw3Sk82MI7xnHrrgRre5JyopBSB+PpVsLNQQt8DvIeUC7hr+XqqrAswih
         C8CyaFDOyyY3D3olFEG+qSwTOkMAqesv+cNdlNGkHXixBdrKgs54WVSVI6KMMnS1L95T
         f8eFelmYqUE+s4CmOFeFhVdc7CWPaS8P8A/XkEeiorxARZh+2DVfizlMXDfJ5B3ivued
         kyBw77f2eDz92FvGR3d2SN1lEifyU7ZgL2Erxcf9Kb4dXSHjQON+032Xhprq/fgTeKJ8
         YJBw==
X-Gm-Message-State: ABy/qLb4BGtsO7HD/8svunCR1JiF4qj/bUOsh3p4r8UJAd976GH1jF/P
        3ZT9ZHf4GP8v0B8Ry7mLBgyz/w==
X-Google-Smtp-Source: APBJJlFbgnS1mG8QzPSLJ4CJ7E9E15Yo2VWKgpnJaJ46srodTeo/zkoTU+shqPjT/ZJ26C2M++xkdw==
X-Received: by 2002:adf:ef8c:0:b0:317:62c3:13a7 with SMTP id d12-20020adfef8c000000b0031762c313a7mr1916263wro.19.1690882659482;
        Tue, 01 Aug 2023 02:37:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b92a:81a9:df6e:1e3? ([2a01:e0a:982:cbb0:b92a:81a9:df6e:1e3])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d6b85000000b0031455482d1fsm1771236wrx.47.2023.08.01.02.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 02:37:39 -0700 (PDT)
Message-ID: <eb2b978d-cebb-b865-150d-8291ab5ab134@linaro.org>
Date:   Tue, 1 Aug 2023 11:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: it6505: Check power state with
 it6505->powered in IRQ handler
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230727100131.2338127-1-treapking@chromium.org>
Organization: Linaro Developer Services
In-Reply-To: <20230727100131.2338127-1-treapking@chromium.org>
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

On 27/07/2023 12:01, Pin-yen Lin wrote:
> On system resume, the driver might call it6505_poweron directly if the
> runtime PM hasn't been enabled. In such case, pm_runtime_get_if_in_use
> will always return 0 because dev->power.runtime_status stays at
> RPM_SUSPENDED, and the IRQ will never be handled.
> 
> Use it6505->powered from the driver struct fixes this because it always
> gets updated when it6505_poweron is called.
> 
> Fixes: 5eb9a4314053 ("drm/bridge: it6505: Guard bridge power in IRQ handler")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
>   drivers/gpu/drm/bridge/ite-it6505.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 6c2fcd8b8780..2f300f5ca051 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2517,9 +2517,11 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
>   	};
>   	int int_status[3], i;
>   
> -	if (it6505->enable_drv_hold || pm_runtime_get_if_in_use(dev) <= 0)
> +	if (it6505->enable_drv_hold || !it6505->powered)
>   		return IRQ_HANDLED;
>   
> +	pm_runtime_get_sync(dev);
> +
>   	int_status[0] = it6505_read(it6505, INT_STATUS_01);
>   	int_status[1] = it6505_read(it6505, INT_STATUS_02);
>   	int_status[2] = it6505_read(it6505, INT_STATUS_03);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
