Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D314177942B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjHKQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:17:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A82694
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:17:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so3478998e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691770668; x=1692375468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2gSBPKAlfj96SXmOm7KUFn9UQg8rFevKIpSF4EFD0s=;
        b=VbF1MsQVpjuK29p6lUu0cazT3/Cq+2NXuthRHhd8u5uDDMW/p0J++4lL/oWuaqzhsF
         a/mMZxAiJF1Sl11AVKy9iik9m2YmTr1ljou4gIYOGVvv6XTZNx7KKj4KaspbA2xpkV9T
         pb3nm5HgEKXCKj3U5bmPTevnzp881LXdE5nwREQayrI3y675HdNGSHiS2nV8pV42RoJS
         x8hhpZwFVsfi5eizMOaWA12LQx6fJOhgrY9SMsCgIZAgPLgp58so2WKpzY0qDcRCeXAs
         jSozEFRUN9p8i+IsKQ0hZtu9EwdQJgkTix4/kEoYZlZKufStdRag8W3SfEcvaB4blIVD
         VM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770668; x=1692375468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2gSBPKAlfj96SXmOm7KUFn9UQg8rFevKIpSF4EFD0s=;
        b=aXnZFwNl23xvWAyqCCeAgch9P6vBwuSmu4ZUYu8fjZ+SKNByUgQIGCWzw1Vlc8yJyR
         P4Wh/W2yH3wulNjzMHxV/Gl9aHsBjJGATea8wBBW4gNOKa8u8WPpkq//7M6Lo0tDfnTM
         gijoIZCELvapYNGVgyf692ptVJ1XEVcqx4DiGdyUVGWIfOH9AiJSQUeiq4cRjZgBq2W7
         H9W1rMyrqWssIekBxT9misWxiWewHBjSV+dOffy/5FKjSsbCV6DpZdgo0O+4MSLMsZfJ
         5aOBKJCvxw2Ev+JbQNPrH+vvZ9TOWKvHQebghzM8epJ8cGYVR7TvFG8PclSuGX/nXllq
         DlAw==
X-Gm-Message-State: AOJu0YyE1B2L7hr7Hye/lN0pFhMg3RhG5HmKfnnUSUVrgRADpF5LABLk
        bX5AXNZWddDxOAtVM+oONdQ=
X-Google-Smtp-Source: AGHT+IHR5UUVXRQtpaX+qj7roLMDkQXkVR/6t2Q956x1Qp4fFtaEciJEI/y8z28z2ZUo8amjjAUWjQ==
X-Received: by 2002:a05:6512:3e1e:b0:4f8:7897:55e6 with SMTP id i30-20020a0565123e1e00b004f8789755e6mr2152260lfv.45.1691770667954;
        Fri, 11 Aug 2023 09:17:47 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id 5-20020ac24825000000b004fe0c3d8bb4sm783212lft.84.2023.08.11.09.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:17:47 -0700 (PDT)
Message-ID: <09c63a63-4967-4289-9538-e144842de8c3@gmail.com>
Date:   Fri, 11 Aug 2023 19:19:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/bridge: tc358768: Fix use of uninitialized
 variable
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
 <20230804-tc358768-v1-1-1afd44b7826b@ideasonboard.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230804-tc358768-v1-1-1afd44b7826b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2023 13:44, Tomi Valkeinen wrote:
> smatch reports:
> 
> drivers/gpu/drm/bridge/tc358768.c:223 tc358768_update_bits() error: uninitialized symbol 'orig'.
> 
> Fix this by bailing out from tc358768_update_bits() if the
> tc358768_read() produces an error.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 819a4b6ec2a0..bc97a837955b 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -216,6 +216,10 @@ static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
>  	u32 tmp, orig;
>  
>  	tc358768_read(priv, reg, &orig);
> +

no need for blank line

> +	if (priv->error)
> +		return;
> +
>  	tmp = orig & ~mask;
>  	tmp |= val & mask;
>  	if (tmp != orig)
> 

-- 
Péter
