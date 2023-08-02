Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A676C7D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHBICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjHBICd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:02:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3B82689
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:02:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31751d7d96eso5515099f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690963350; x=1691568150;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UAFJ+rv+IE187x/FwcspFH0+iOTtGpFlE/cBuRXsXsw=;
        b=n6syPma2ESApR8RUDCbIcg+b5msMUdwamEE/iYQvwZFvFNIAVioaro4B/arOcpLdbO
         fDZdhx0ge1q6bbPSd+mjsXF2w8eUtp51X1K9Sk3dJYd7+JTSRclVoJpqW164kth6ukCx
         BloSMDZ8zglmm8Zy+mRoyU8Wfb25UummOTwsG/uD5GdlpGc2e7nB2Foou5UhYbaAu3cg
         8GsnHSZlaf41ibwFtovWYpantHy8tRsib/EvHRl1htSHnz+9jIBzjgfMSehQx2YsddA/
         LVXOamf2KlPp6t1IT/db7e2gMyXO5Rl7FOM3Ttzh2zMEx/wCNHCvyqmhX4YyCieN2DrV
         OAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963350; x=1691568150;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAFJ+rv+IE187x/FwcspFH0+iOTtGpFlE/cBuRXsXsw=;
        b=fKG/fAICaKplb9UiB+PdzQO5RjLabvyG/Ypijor9ElODHFrl6FKl6+E9acVIq8TeFU
         mdmlUE/YC7KB1dXxXyKyphjdtmzRGwYqOJyRJUBBGUIcKKgFFB+x1uz4bfv26vS9cTkW
         OEMUp6u6Md72hXBvQEWtf6SaZm5FpuHE5oEXF8FPii6zIX7lxiiszBYADaDW31wCbFa6
         xejF5/5AoxUgnOOmS1KX3mATItmyF7q50vAzkONm91UgzXMt0dlXu1FAUz/UxJ3aR7eM
         8VbloQkNQutYyjJDAfS/mIPQBFUaLUWvmz7aZY3ip0WwDu4Z3xY9YuqWNE6ctzzWXP+3
         V7lg==
X-Gm-Message-State: ABy/qLaN3GKcEYkdoh+w+W92y07OLYaVwed0uygpYIwJMyxT1DnkHUZb
        fgnDB5EMvAiBgkejz8WbOyrtyw==
X-Google-Smtp-Source: APBJJlGNEmI9TnXQHyKu4wFteuwTzcg/moZ+xGeiXcdvcDgox/jG6L0Ux5vxL4yzA89PisW1fAHrOw==
X-Received: by 2002:adf:ea4b:0:b0:317:5a71:9231 with SMTP id j11-20020adfea4b000000b003175a719231mr4169246wrn.51.1690963350340;
        Wed, 02 Aug 2023 01:02:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196? ([2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe587000000b00314172ba213sm18244774wrm.108.2023.08.02.01.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 01:02:29 -0700 (PDT)
Message-ID: <33f4fbe0-5fd7-569d-dbee-f55520693373@linaro.org>
Date:   Wed, 2 Aug 2023 10:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4] drm/bridge: Add debugfs print for bridge chains
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20230802-drm-bridge-chain-debugfs-v4-1-7e3ae3d137c0@ideasonboard.com>
Organization: Linaro Developer Services
In-Reply-To: <20230802-drm-bridge-chain-debugfs-v4-1-7e3ae3d137c0@ideasonboard.com>
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

On 02/08/2023 09:04, Tomi Valkeinen wrote:
> DRM bridges are not visible to the userspace and it may not be
> immediately clear if the chain is somehow constructed incorrectly. I
> have had two separate instances of a bridge driver failing to do a
> drm_bridge_attach() call, resulting in the bridge connector not being
> part of the chain. In some situations this doesn't seem to cause issues,
> but it will if DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is used.
> 
> Add a debugfs file to print the bridge chains. For me, on this TI AM62
> based platform, I get the following output:
> 
> encoder[39]
> 	bridge[0] type: 0, ops: 0x0
> 	bridge[1] type: 0, ops: 0x0, OF: /bus@f0000/i2c@20000000/dsi@e:toshiba,tc358778
> 	bridge[2] type: 0, ops: 0x3, OF: /bus@f0000/i2c@20010000/hdmi@48:lontium,lt8912b
> 	bridge[3] type: 11, ops: 0x7, OF: /hdmi-connector:hdmi-connector
> 
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v4:
> - Move 'struct drm_minor' to be along the other declarations
> - Added Tested-by and Reviewed-by
> - Link to v3: https://lore.kernel.org/r/20230731-drm-bridge-chain-debugfs-v3-1-7d0739f3efa3@ideasonboard.com
> 
> Changes in v3:
> - Use drm_for_each_bridge_in_chain()
> - Drop extra comment
> - Fix whitespace issue
> - Call drm_bridge_debugfs_init() only if the driver uses modeset
> - Drop #ifdef for drm_bridge_debugfs_init() declaration
> - Link to v2: https://lore.kernel.org/r/20230721-drm-bridge-chain-debugfs-v2-1-76df94347962@ideasonboard.com
> 
> Changes in v2:
> - Fixed compilation issue when !CONFIG_OF
> - Link to v1: https://lore.kernel.org/r/20230721-drm-bridge-chain-debugfs-v1-1-8614ff7e890d@ideasonboard.com
> ---
>   drivers/gpu/drm/drm_bridge.c  | 46 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_debugfs.c |  2 ++
>   include/drm/drm_bridge.h      |  3 +++
>   3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index c3d69af02e79..39e68e45bb12 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -27,8 +27,10 @@
>   #include <linux/mutex.h>
>   
>   #include <drm/drm_atomic_state_helper.h>
> +#include <drm/drm_debugfs.h>
>   #include <drm/drm_bridge.h>
>   #include <drm/drm_encoder.h>
> +#include <drm/drm_file.h>
>   #include <drm/drm_of.h>
>   #include <drm/drm_print.h>
>   
> @@ -1345,6 +1347,50 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>   EXPORT_SYMBOL(of_drm_find_bridge);
>   #endif
>   
> +#ifdef CONFIG_DEBUG_FS
> +static int drm_bridge_chains_info(struct seq_file *m, void *data)
> +{
> +	struct drm_debugfs_entry *entry = m->private;
> +	struct drm_device *dev = entry->dev;
> +	struct drm_printer p = drm_seq_file_printer(m);
> +	struct drm_mode_config *config = &dev->mode_config;
> +	struct drm_encoder *encoder;
> +	unsigned int bridge_idx = 0;
> +
> +	list_for_each_entry(encoder, &config->encoder_list, head) {
> +		struct drm_bridge *bridge;
> +
> +		drm_printf(&p, "encoder[%u]\n", encoder->base.id);
> +
> +		drm_for_each_bridge_in_chain(encoder, bridge) {
> +			drm_printf(&p, "\tbridge[%u] type: %u, ops: %#x",
> +				   bridge_idx, bridge->type, bridge->ops);
> +
> +#ifdef CONFIG_OF
> +			if (bridge->of_node)
> +				drm_printf(&p, ", OF: %pOFfc", bridge->of_node);
> +#endif
> +
> +			drm_printf(&p, "\n");
> +
> +			bridge_idx++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct drm_debugfs_info drm_bridge_debugfs_list[] = {
> +	{ "bridge_chains", drm_bridge_chains_info, 0 },
> +};
> +
> +void drm_bridge_debugfs_init(struct drm_minor *minor)
> +{
> +	drm_debugfs_add_files(minor->dev, drm_bridge_debugfs_list,
> +			      ARRAY_SIZE(drm_bridge_debugfs_list));
> +}
> +#endif
> +
>   MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
>   MODULE_DESCRIPTION("DRM bridge infrastructure");
>   MODULE_LICENSE("GPL and additional rights");
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index a3a488205009..2de43ff3ce0a 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -31,6 +31,7 @@
>   
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_auth.h>
> +#include <drm/drm_bridge.h>
>   #include <drm/drm_client.h>
>   #include <drm/drm_debugfs.h>
>   #include <drm/drm_device.h>
> @@ -274,6 +275,7 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>   
>   	if (drm_drv_uses_atomic_modeset(dev)) {
>   		drm_atomic_debugfs_init(minor);
> +		drm_bridge_debugfs_init(minor);
>   	}
>   
>   	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index bf964cdfb330..c339fc85fd07 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -36,6 +36,7 @@ struct drm_bridge;
>   struct drm_bridge_timings;
>   struct drm_connector;
>   struct drm_display_info;
> +struct drm_minor;
>   struct drm_panel;
>   struct edid;
>   struct i2c_adapter;
> @@ -949,4 +950,6 @@ static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
>   }
>   #endif
>   
> +void drm_bridge_debugfs_init(struct drm_minor *minor);
> +
>   #endif
> 
> ---
> base-commit: a0c64d153d687756c8719b8d10e609d62e1cb6fd
> change-id: 20230721-drm-bridge-chain-debugfs-0bbc1522f57a
> 
> Best regards,

LGTM, thanks tomi !

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
