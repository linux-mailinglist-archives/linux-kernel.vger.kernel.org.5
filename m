Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84B7794B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjHKQdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:33:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE4109
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:33:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so3612233e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691771587; x=1692376387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Kmg99ifzvVDXw5iZF67CnPsk4R1aNFzdMl+/K7HXgc=;
        b=I0Bwbkye7tXfJM3o4t36qj6mD05r/dqvJZR0jcPgseHrr/gA5yyKFgQadJ5qvYL7T1
         7PiYMe00V8B4o+CtGwdRqSSa6fq4sAibeJDkeTh/XtR785K1WThCx7FDzoWI7u6ISLp8
         uVTa6+WSWdaXgcxm8635IeKHbyFuPCnqRTn7pxNRM3L+5WtT4eluR3dgPFwzX3FB7QJT
         C7U1+ho4n/2RZrX5hFrMMLnxksJIw4jmiO6bmlYF9nZsopofcgUc1iJQXMzJz6kHMC3r
         oopbZmOrkw+HbXvouLZxCTSo5CHikfLLhpsn1ghwL2OmtNdm3PqKzTZCkfRobWrQzB2C
         C/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771587; x=1692376387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Kmg99ifzvVDXw5iZF67CnPsk4R1aNFzdMl+/K7HXgc=;
        b=jB1MSiSLxts7WHBQVtLkgHXZMzM1aMxYYCN72UaGZa7u+nHwRNXbQfHlaE50cc1GKk
         BqeiedxbETtllfggwYMC0ZekiT8h7yht8c5PQpGNDQN09bk666B8mM3hvrP2wwhqSiFG
         UU54a58vk3qMdfeJYHbp6oY0E72CoY3Y/hgTBqtFnbl16Q8oFv8cxUj62AFX/taAHSah
         8nEMEphwQMz+WL6WM7G9sloWdYzuvIqr/0S3kivV39m+T602nzkuuNTp6hHs1aD0SY/h
         wH85XPZJA/LI+t8id1xAfeYIBErK9qjxXhXyd7hRhQVj327MvL5fsbDVwzJA/Rjqn0TR
         17rQ==
X-Gm-Message-State: AOJu0YyaU3D0mUFxDvbEqMpN4acGWbs4EYEgxTy65PfBp7brZTior738
        A1MMagAmzNVeVv0eg5zLn6k=
X-Google-Smtp-Source: AGHT+IFElx8WS0ZZqIvWLUu7tKaWNnBRxvEUBFofkrojqyjjnTkXPXKV4dBNqgEmzlv7RfLEI+WZ7A==
X-Received: by 2002:a19:8c56:0:b0:4fe:6ff:dfcb with SMTP id i22-20020a198c56000000b004fe06ffdfcbmr1706443lfj.30.1691771587622;
        Fri, 11 Aug 2023 09:33:07 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id a5-20020a19f805000000b004fb9536bc99sm778839lff.169.2023.08.11.09.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:33:07 -0700 (PDT)
Message-ID: <455e16aa-7e51-4ebf-ab36-2bd5db4e4f16@gmail.com>
Date:   Fri, 11 Aug 2023 19:35:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-9-1afd44b7826b@ideasonboard.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230804-tc358768-v1-9-1afd44b7826b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2023 13:44, Tomi Valkeinen wrote:
> The tc358768_ns_to_cnt() is, most likely, supposed to do a div-round-up
> operation, but it misses subtracting one from the dividend.
> 
> Fix this by just using DIV_ROUND_UP().

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 9411b0fb471e..dc2241c18dde 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -630,7 +630,7 @@ static int tc358768_setup_pll(struct tc358768_priv *priv,
>  
>  static u32 tc358768_ns_to_cnt(u32 ns, u32 period_ps)
>  {
> -	return (ns * 1000 + period_ps) / period_ps;
> +	return DIV_ROUND_UP(ns * 1000, period_ps);
>  }
>  
>  static u32 tc358768_ps_to_ns(u32 ps)
> 

-- 
Péter
