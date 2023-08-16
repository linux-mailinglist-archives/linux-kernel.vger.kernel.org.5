Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AC377DA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbjHPF4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbjHPFzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:55:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439AE56;
        Tue, 15 Aug 2023 22:55:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1d03e124so754907366b.2;
        Tue, 15 Aug 2023 22:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692165352; x=1692770152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aZkOL7SjZGnUHAIvEt/YDknB7+2gxb44+woju4e+uE=;
        b=VfCom1umUhKMEoU/+uHAV8huhuxTS3rkeuRK8CgGS4Pf/0CTvzwkECTCCDk0Nz8fYJ
         ZZwtkJuX4W3UOGSquDKAByWKGnq6kkeoW+l8JP3MOKY/nu3d8hsm5OQx3/P2yfLrBbnu
         3z5awkUHCDiAGeng8HrzdRBzgarA0HmQEtvoEAT7+4oKmYqPuqnXmlMk+jjFTlPlMNs8
         lBy632wiFdEarOdwxdnWDGbxjB/UJdfJFF9XdgK9RgQVln/1VrKM3lVuVg7/eZua2Fyt
         YzWi4KzHUqWcbOY+IxfQ9wQAUz1Ic6Mn7vmooNKeN0HCI7gcNF0jBcHSDGRtrxTYkR3R
         GrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692165352; x=1692770152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aZkOL7SjZGnUHAIvEt/YDknB7+2gxb44+woju4e+uE=;
        b=GJi3JcALOSR/H54/S9tbcGkG/zVcD6pQGEYRZ+DZFjbH5PATHPb1UwD4qwistTOn/s
         LFcCIoOBScHTckEw/xrm/sHzuaax5d3ZGTYKNSdiIkHMjvC2+XpBnj0WOj07+l5r4DCo
         fMc2sJ0iVvlDUj4VRvh5/PCcCUw/8mmg9Oor0exHHjtLtFoFrVJXDvVOESQfXc5UsCEo
         yljUrf0esddL0Z1qDMPSQS8kJwywEGvQbimQcNzgdymoRiuftJDhmxyTq6CozJDUQJbf
         qDYtKGHBk/clU/y6RigoT2G8uPvn+0Rc7gXG5o3+SJXkKmhIEtONTfTtgr5vBd8lKez1
         Ky3Q==
X-Gm-Message-State: AOJu0YywSJBQhSav/G8DWl7diATbYMVr8Sz1uju7YsZQwwiDtQ7asuMo
        BfT98Jqzq1k3gJ4yz3RI7H8=
X-Google-Smtp-Source: AGHT+IF4cQjPHPsGP77huoi8BSKDn99dS/edqLrfBHnOmj+6zJvC5sm7DmueoS1E10YGpHFIdUgYtQ==
X-Received: by 2002:a17:906:259:b0:991:ed4e:1c84 with SMTP id 25-20020a170906025900b00991ed4e1c84mr667070ejl.25.1692165351663;
        Tue, 15 Aug 2023 22:55:51 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15f4:7600:d198:bace:ace6:651f? ([2a00:e180:15f4:7600:d198:bace:ace6:651f])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906190900b00992c92af6easm8031662eje.161.2023.08.15.22.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 22:55:51 -0700 (PDT)
Message-ID: <d1831afd-9e02-fbc9-69f7-e8f044f35ee0@gmail.com>
Date:   Wed, 16 Aug 2023 07:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amdgpu: register a dirty framebuffer callback for
 fbcon
Content-Language: en-US
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Guchun Chen <guchun.chen@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20230815172700.255596-1-hamza.mahfooz@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230815172700.255596-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 15.08.23 um 19:26 schrieb Hamza Mahfooz:
> fbcon requires that we implement &drm_framebuffer_funcs.dirty.
> Otherwise, the framebuffer might take a while to flush (which would
> manifest as noticeable lag). However, we can't enable this callback for
> non-fbcon cases since it might cause too many atomic commits to be made
> at once. So, implement amdgpu_dirtyfb() and only enable it for fbcon
> framebuffers on devices that support atomic KMS.
>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org # 6.1+
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2519
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2: update variable names
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 26 ++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index d20dd3f852fc..d3b59f99cb7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -38,6 +38,8 @@
>   #include <linux/pci.h>
>   #include <linux/pm_runtime.h>
>   #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_drv.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_fb_helper.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
> @@ -532,11 +534,29 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
>   	return true;
>   }
>   
> +static int amdgpu_dirtyfb(struct drm_framebuffer *fb, struct drm_file *file,
> +			  unsigned int flags, unsigned int color,
> +			  struct drm_clip_rect *clips, unsigned int num_clips)
> +{
> +
> +	if (strcmp(fb->comm, "[fbcon]"))
> +		return -ENOSYS;

Once more to the v2 of this patch: Tests like those are a pretty big 
NO-GO for upstreaming.

Regards,
Christian.

> +
> +	return drm_atomic_helper_dirtyfb(fb, file, flags, color, clips,
> +					 num_clips);
> +}
> +
>   static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>   	.destroy = drm_gem_fb_destroy,
>   	.create_handle = drm_gem_fb_create_handle,
>   };
>   
> +static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
> +	.destroy = drm_gem_fb_destroy,
> +	.create_handle = drm_gem_fb_create_handle,
> +	.dirty = amdgpu_dirtyfb
> +};
> +
>   uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>   					  uint64_t bo_flags)
>   {
> @@ -1139,7 +1159,11 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
>   	if (ret)
>   		goto err;
>   
> -	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		ret = drm_framebuffer_init(dev, &rfb->base,
> +					   &amdgpu_fb_funcs_atomic);
> +	else
> +		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
>   
>   	if (ret)
>   		goto err;

