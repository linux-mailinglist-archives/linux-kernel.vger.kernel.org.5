Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36377D147
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbjHORo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbjHORow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:44:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225FCD1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:44:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so751000566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692121489; x=1692726289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JSgFrf+2kkEmerp3RRl98sdsBqIkHfp3UikiJcKWgM=;
        b=qEc/0JaanwDr/Al3050w5zRmsrL2qePQie6W4NeJpLVJzuJx6KpI5fQ2B5/mcCTimV
         Yvij3Y8kPWDqmyvMmfNBGNoLZHrP6sJfrOvvKr1CqpM4rX1a4kDMCQwnBfzkiZwUjaeC
         aLxxZ9MxcyDm6qUL/nQq+j0+WEIhNCNlPozzli1w52r9IblX521N/iuP9d5CD18YwrYu
         8k62bSyYaWy7OEi/H/uLFYJ4aD57Aak24mrhQpvehwOy1yGsTN7TJ2S92XzJYlhTHOTJ
         s0C5eIYHp+xHZ4sQKn8al40sgPFuCM65xJMsZ4E1TqtBp3ZJYx6vDePV0gjvQ2NYnLvo
         d4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121489; x=1692726289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JSgFrf+2kkEmerp3RRl98sdsBqIkHfp3UikiJcKWgM=;
        b=lWKjDGgdonm7r27/iRcvkhh0mSTXOHhYSSCkCoyK0G9fQv7EvR6ytbBVu5IRof16bp
         OQtBT94lG8PJO6xnJkWoJNm6k8mlvOtXwQI9BabYIJ5gCX/jx9JO7ZhuNzYzo/ensDnG
         CYqtYuOcCeAelOa8KZMDOJspe4HSt03BamNGlch9TKZVH628mgBmdn2b0GZTZLfJXqVw
         aYyHzwzBeyRFi0ICtq0QYfX0nKSAeBPK7RISSu07TuRy4kaTyIV/i7/xcPZ7urwcqGGY
         ICMHccU3No9EZhJib1bT7nuY4XnSgif6ksFb5onqkaRE0rWKGU1IjdETcpC8tq+yHuRk
         g5QA==
X-Gm-Message-State: AOJu0Yy+YyadNjHgWFgosQSxbM6Lyy5/THTIO9+zEUYuJpkPB3KElvcd
        dYdcTqjIHTb1z/mpEpO5oz4=
X-Google-Smtp-Source: AGHT+IHtGzfSBIZp1ZgfqHxNMJsQgMI1BL4uIlMg5bxvIx68EnmbP3EwgOCzWPBx4AVj82ygSvO/Vg==
X-Received: by 2002:a17:906:3098:b0:99b:d2a9:9a01 with SMTP id 24-20020a170906309800b0099bd2a99a01mr11930248ejv.0.1692121489299;
        Tue, 15 Aug 2023 10:44:49 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:3b18:d442:101d:d282? ([2a02:908:8b3:1840:3b18:d442:101d:d282])
        by smtp.gmail.com with ESMTPSA id lj9-20020a170906f9c900b00988be3c1d87sm7307852ejb.116.2023.08.15.10.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 10:44:48 -0700 (PDT)
Message-ID: <ff415397-c226-bf78-4a91-9651498b2ce4@gmail.com>
Date:   Tue, 15 Aug 2023 19:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/11] drm/bridge: tc358768: Add
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
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
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-11-1afd44b7826b@ideasonboard.com>
 <e857d383-2287-a985-24c5-fa1fff1da199@gmail.com>
 <0855d804-3ba3-4f29-32b1-bab3b999e506@ideasonboard.com>
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
In-Reply-To: <0855d804-3ba3-4f29-32b1-bab3b999e506@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 12:04, Tomi Valkeinen wrote:
> On 13/08/2023 20:11, Maxim Schwalm wrote:
>> On 04.08.23 12:44, Tomi Valkeinen wrote:
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>> ---
>>>   drivers/gpu/drm/bridge/tc358768.c | 64 +++++++++++++++++++++++++++------------
>>>   1 file changed, 45 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
>>> index ea19de5509ed..a567f136ddc7 100644
>>> --- a/drivers/gpu/drm/bridge/tc358768.c
>>> +++ b/drivers/gpu/drm/bridge/tc358768.c
>>> @@ -131,8 +131,17 @@ static const char * const tc358768_supplies[] = {
>>>   
>>>   struct tc358768_dsi_output {
>>>   	struct mipi_dsi_device *dev;
>>> +
>>> +	/* Legacy field if DRM_BRIDGE_ATTACH_NO_CONNECTOR is not used */
>>>   	struct drm_panel *panel;
>>> -	struct drm_bridge *bridge;
>>> +
>>> +	/*
>>> +	 * If DRM_BRIDGE_ATTACH_NO_CONNECTOR is not used and a panel is attached
>>> +	 * to tc358768, 'next_bridge' contains the bridge the driver created
>>> +	 * with drm_panel_bridge_add_typed(). Otherwise 'next_bridge' contains
>>> +	 * the next bridge the driver found.
>>> +	 */
>>> +	struct drm_bridge *next_bridge;
>>>   };
>>>   
>>>   struct tc358768_priv {
>>> @@ -391,8 +400,6 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
>>>   				    struct mipi_dsi_device *dev)
>>>   {
>>>   	struct tc358768_priv *priv = dsi_host_to_tc358768(host);
>>> -	struct drm_bridge *bridge;
>>> -	struct drm_panel *panel;
>>>   	struct device_node *ep;
>>>   	int ret;
>>>   
>>> @@ -420,21 +427,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
>>>   		return -ENOTSUPP;
>>>   	}
>>>   
>>> -	ret = drm_of_find_panel_or_bridge(host->dev->of_node, 1, 0, &panel,
>>> -					  &bridge);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>> -	if (panel) {
>>> -		bridge = drm_panel_bridge_add_typed(panel,
>>> -						    DRM_MODE_CONNECTOR_DSI);
>>> -		if (IS_ERR(bridge))
>>> -			return PTR_ERR(bridge);
>>> -	}
>>> -
>>>   	priv->output.dev = dev;
>>> -	priv->output.bridge = bridge;
>>> -	priv->output.panel = panel;
>>>   
>>>   	priv->dsi_lanes = dev->lanes;
>>>   	priv->dsi_bpp = mipi_dsi_pixel_format_to_bpp(dev->format);
>>> @@ -463,7 +456,7 @@ static int tc358768_dsi_host_detach(struct mipi_dsi_host *host,
>>>   
>>>   	drm_bridge_remove(&priv->bridge);
>>>   	if (priv->output.panel)
>>> -		drm_panel_bridge_remove(priv->output.bridge);
>>> +		drm_panel_bridge_remove(priv->output.next_bridge);
>>>   
>>>   	return 0;
>>>   }
>>> @@ -544,7 +537,40 @@ static int tc358768_bridge_attach(struct drm_bridge *bridge,
>>>   		return -ENOTSUPP;
>>>   	}
>>>   
>>> -	return drm_bridge_attach(bridge->encoder, priv->output.bridge, bridge,
>>> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
>>> +		struct device_node *node;
>>> +
>>> +		/* Get the next bridge, connected to port@1. */
>>> +		node = of_graph_get_remote_node(priv->dev->of_node, 1, -1);
>>> +		if (!node)
>>> +			return -ENODEV;
>>> +
>>> +		priv->output.next_bridge = of_drm_find_bridge(node);
>>> +		of_node_put(node);
>>> +		if (!priv->output.next_bridge)
>>> +			return -EPROBE_DEFER;
>>> +	} else {
>>> +		struct drm_bridge *bridge;
>>> +		struct drm_panel *panel;
>>> +		int ret;
>>> +
>>> +		ret = drm_of_find_panel_or_bridge(priv->dev->of_node, 1, 0,
>>> +						  &panel, &bridge);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (panel) {
>>> +			bridge = drm_panel_bridge_add_typed(panel,
>>> +				DRM_MODE_CONNECTOR_DSI);
>>> +			if (IS_ERR(bridge))
>>> +				return PTR_ERR(bridge);
>>> +		}
>>> +
>>> +		priv->output.next_bridge = bridge;
>>> +		priv->output.panel = panel;
>>> +	}
>>> +
>>> +	return drm_bridge_attach(bridge->encoder, priv->output.next_bridge, bridge,
>>>   				 flags);
>>>   }
>>>   
>>>
>> This patch unfortunately breaks the display output on the Asus TF700T:
>>
>> [drm:drm_bridge_attach] *ERROR* failed to attach bridge /i2c-mux/i2c@1/dsi@7 to encoder LVDS-59: -517
>> tegra-dc 54200000.dc: failed to initialize RGB output: -517
>> drm drm: failed to initialize 54200000.dc: -517
>> ------------[ cut here ]------------
>> WARNING: CPU: 3 PID: 69 at lib/refcount.c:28 tegra_dc_init+0x24/0x5fc
>> refcount_t: underflow; use-after-free.
>> Modules linked in: elants_i2c panel_simple tc358768 atkbd vivaldi_fmap
>> CPU: 3 PID: 69 Comm: kworker/u8:6 Not tainted 6.5.0-rc2-postmarketos-grate #95
>> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> Workqueue: events_unbound deferred_probe_work_func
>>   unwind_backtrace from show_stack+0x10/0x14
>>   show_stack from dump_stack_lvl+0x40/0x4c
>>   dump_stack_lvl from __warn+0x94/0xc0
>>   __warn from warn_slowpath_fmt+0x118/0x16c
>>   warn_slowpath_fmt from tegra_dc_init+0x24/0x5fc
>>   tegra_dc_init from host1x_device_init+0x84/0x15c
>>   host1x_device_init from host1x_drm_probe+0xd8/0x3c4
>>   host1x_drm_probe from really_probe+0xc8/0x2dc
>>   really_probe from __driver_probe_device+0x88/0x19c
>>   __driver_probe_device from driver_probe_device+0x30/0x104
>>   driver_probe_device from __device_attach_driver+0x94/0x108
>>   __device_attach_driver from bus_for_each_drv+0x80/0xb8
>>   bus_for_each_drv from __device_attach+0xa0/0x190
>>   __device_attach from bus_probe_device+0x88/0x8c
>>   bus_probe_device from deferred_probe_work_func+0x78/0xa4
>>   deferred_probe_work_func from process_one_work+0x208/0x420
>>   process_one_work from worker_thread+0x54/0x550
>>   worker_thread from kthread+0xdc/0xf8
>>   kthread from ret_from_fork+0x14/0x2c
>> Exception stack(0xcf9c5fb0 to 0xcf9c5ff8)
>> 5fa0:                                     00000000 00000000 00000000 00000000
>> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> ---[ end trace 0000000000000000 ]---
> 
> Hi Maxim,
> 
> Can you try the attached patch (on top of the series)? If it helps, I'll 
> refresh the series with the fix.
> 

Thanks, Tomi! This fixes the issue.

Best regards,
Maxim
