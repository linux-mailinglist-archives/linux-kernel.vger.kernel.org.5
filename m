Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E96753390
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjGNHub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjGNHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:50:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F630DC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:50:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992ca792065so213837166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689321023; x=1691913023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WS0uRbknENSFdhFyzOpTBxGUHhSmQi3/u5sdc2+cv28=;
        b=MT3RHzYfatlsktEfUwhZ4T41uHOlJSAajosy8POWYmo98w03os4GfagCgRREa7BoC9
         fOrX04cWgfF2dG+S82LR8SjlthNpsk1GCKfidm8Wy94xWWesDePrx6UyqlcETZwAZkK3
         3IOLbLgNu7oGHbVBlZW0XizZCqCqwb1x/zLlebjSPLLu/McfGZzcUnMrcD3XKT9H7opS
         aP5hzkxQDYjPdCFij4pW1G2QfrozQwoN/0rDOyyAZYZWhKo0aGye4pBkg7Zk1e0ImmiB
         kVpMJnYrqElJietXYC4/HR5rTIfRJLf81Pd7yhFR+uwuV3+C30VdQvABzrp2Y9ARHsz3
         T9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321023; x=1691913023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WS0uRbknENSFdhFyzOpTBxGUHhSmQi3/u5sdc2+cv28=;
        b=fA5tsXQwMcHSw8M2mNfFbnyw6saaofKDt0Yh+v6VaPadP6NX11KfD+I+qCCFcwPGs5
         qmOKmkzk/Kf6XtMOnb8HTuMh3OFhcPYLPKfIwRwLHHqJ1nyF/Ey2jRUmZlxB+JZZh08O
         6+KkC4XmSKnChpucuvgR7Dob6UruluFQktyGXaRdGmCgkkdbXgAxkUYoAMJ59mLzn90q
         27Co7TZyXSwClO3gV9LvRcy3wUtwHvd+i+Kg8+EN/B9OkYWyt78y1xV0jk/da4uxTHMo
         jwltjbNgCN2uFrDpNkaodYbekypoP+gliUchcEEsicQ0JUkpSG9Eovr6xCvu6hNpAHEe
         3KNQ==
X-Gm-Message-State: ABy/qLbzXU1T9uh1+WYd8obRHr7lb8Y4yfGmHMcCCErOgG0roslEZPvh
        V2OGKo55movnz0TwQ/4tUZw=
X-Google-Smtp-Source: APBJJlGyf2JY/FhxaHjGybcshfi+GT0jf0yTIK77WHTzLdrH8owNW5XBn7XuYbFFeBUVUbLKK8JQjQ==
X-Received: by 2002:a17:906:1009:b0:994:5340:22f4 with SMTP id 9-20020a170906100900b00994534022f4mr391867ejm.6.1689321023278;
        Fri, 14 Jul 2023 00:50:23 -0700 (PDT)
Received: from ?IPV6:2a00:e180:156e:8700:817e:6375:6a13:2da9? ([2a00:e180:156e:8700:817e:6375:6a13:2da9])
        by smtp.gmail.com with ESMTPSA id lc16-20020a170906f91000b0096f6a131b9fsm5041020ejb.23.2023.07.14.00.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:50:22 -0700 (PDT)
Message-ID: <f5c72c41-5d36-710c-72a8-c06260a2df41@gmail.com>
Date:   Fri, 14 Jul 2023 09:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/6] drm/amdgpu: Rework coredump to use memory
 dynamically
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        michel.daenzer@mailbox.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        alexander.deucher@amd.com, christian.koenig@amd.com
References: <20230713213242.680944-1-andrealmeid@igalia.com>
 <20230713213242.680944-4-andrealmeid@igalia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230713213242.680944-4-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.07.23 um 23:32 schrieb André Almeida:
> Instead of storing coredump information inside amdgpu_device struct,
> move if to a proper separated struct and allocate it dynamically. This
> will make it easier to further expand the logged information.
>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v2: Replace GFP_KERNEL with GPF_NOWAIT

Much better, thanks!

>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 14 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65 ++++++++++++++--------
>   2 files changed, 51 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dbe062a087c5..e1cc83a89d46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1068,11 +1068,6 @@ struct amdgpu_device {
>   	uint32_t                        *reset_dump_reg_list;
>   	uint32_t			*reset_dump_reg_value;
>   	int                             num_regs;
> -#ifdef CONFIG_DEV_COREDUMP
> -	struct amdgpu_task_info         reset_task_info;
> -	bool                            reset_vram_lost;
> -	struct timespec64               reset_time;
> -#endif
>   
>   	bool                            scpm_enabled;
>   	uint32_t                        scpm_status;
> @@ -1085,6 +1080,15 @@ struct amdgpu_device {
>   	uint32_t			aid_mask;
>   };
>   
> +#ifdef CONFIG_DEV_COREDUMP
> +struct amdgpu_coredump_info {
> +	struct amdgpu_device		*adev;
> +	struct amdgpu_task_info         reset_task_info;
> +	struct timespec64               reset_time;
> +	bool                            reset_vram_lost;
> +};
> +#endif
> +

We should probably put that into amdgpu_reset.h instead and move the 
amdgpu_coredump_* functions into amdgpu_reset.c as well.

Apart from that this looks good of hand.

Thanks,
Christian.

>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>   {
>   	return container_of(ddev, struct amdgpu_device, ddev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a824f844a984..e80670420586 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4963,12 +4963,17 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_DEV_COREDUMP
> +#ifndef CONFIG_DEV_COREDUMP
> +static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> +			    struct amdgpu_reset_context *reset_context)
> +{
> +}
> +#else
>   static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>   		size_t count, void *data, size_t datalen)
>   {
>   	struct drm_printer p;
> -	struct amdgpu_device *adev = data;
> +	struct amdgpu_coredump_info *coredump = data;
>   	struct drm_print_iterator iter;
>   	int i;
>   
> @@ -4982,21 +4987,21 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>   	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>   	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>   	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> -	drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
> -	if (adev->reset_task_info.pid)
> +	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
> +	if (coredump->reset_task_info.pid)
>   		drm_printf(&p, "process_name: %s PID: %d\n",
> -			   adev->reset_task_info.process_name,
> -			   adev->reset_task_info.pid);
> +			   coredump->reset_task_info.process_name,
> +			   coredump->reset_task_info.pid);
>   
> -	if (adev->reset_vram_lost)
> +	if (coredump->reset_vram_lost)
>   		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> -	if (adev->num_regs) {
> +	if (coredump->adev->num_regs) {
>   		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
>   
> -		for (i = 0; i < adev->num_regs; i++)
> +		for (i = 0; i < coredump->adev->num_regs; i++)
>   			drm_printf(&p, "0x%08x: 0x%08x\n",
> -				   adev->reset_dump_reg_list[i],
> -				   adev->reset_dump_reg_value[i]);
> +				   coredump->adev->reset_dump_reg_list[i],
> +				   coredump->adev->reset_dump_reg_value[i]);
>   	}
>   
>   	return count - iter.remain;
> @@ -5004,14 +5009,34 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>   
>   static void amdgpu_devcoredump_free(void *data)
>   {
> +	kfree(data);
>   }
>   
> -static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
> +static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> +			    struct amdgpu_reset_context *reset_context)
>   {
> +	struct amdgpu_coredump_info *coredump;
>   	struct drm_device *dev = adev_to_drm(adev);
>   
> -	ktime_get_ts64(&adev->reset_time);
> -	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
> +	coredump = kmalloc(sizeof(*coredump), GFP_NOWAIT);
> +
> +	if (!coredump) {
> +		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
> +		return;
> +	}
> +
> +	memset(coredump, 0, sizeof(*coredump));
> +
> +	coredump->reset_vram_lost = vram_lost;
> +
> +	if (reset_context->job && reset_context->job->vm)
> +		coredump->reset_task_info = reset_context->job->vm->task_info;
> +
> +	coredump->adev = adev;
> +
> +	ktime_get_ts64(&coredump->reset_time);
> +
> +	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
>   		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
>   }
>   #endif
> @@ -5119,15 +5144,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					goto out;
>   
>   				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
> -#ifdef CONFIG_DEV_COREDUMP
> -				tmp_adev->reset_vram_lost = vram_lost;
> -				memset(&tmp_adev->reset_task_info, 0,
> -						sizeof(tmp_adev->reset_task_info));
> -				if (reset_context->job && reset_context->job->vm)
> -					tmp_adev->reset_task_info =
> -						reset_context->job->vm->task_info;
> -				amdgpu_reset_capture_coredumpm(tmp_adev);
> -#endif
> +
> +				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
> +
>   				if (vram_lost) {
>   					DRM_INFO("VRAM is lost due to GPU reset!\n");
>   					amdgpu_inc_vram_lost(tmp_adev);

