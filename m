Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2570677DDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbjHPJxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbjHPJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:53:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13C2726
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:52:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso8228513a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692179564; x=1692784364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3+V3AaCHKihRhw6vb0FdbJtuhD76LgeUye7PCXJ2SE=;
        b=pCrQaVcJL1qGo0F3u2cicidBkvSixEzj/UC9HA4fvFjmSJFLyVCUuD8LrFYV1uMDl1
         Ls9z37cIl9arAHJLxUQjOehJEZJOfMfOlVH5Km68rI3wjQm2/LqCzJ2Pqa8EkBcZtkIP
         vsDN21u5MFWtAi0tGNLhHisbc+zH3JeF6TJp5rDk7HvatXc9S0Ok+PiTgd5GWYjRHaaJ
         r40+JeaLFugdRe3j7GidHCLL1KvbhEpHNFHI/H7lEq4A/3uBRqMFSSva6PkPb7t5KiyY
         a+7UwQtyizab6u8hgrs2lGAOJAcSMUIGijPgKd0MtoXDmeY4RIjZrYiBMbFfOkJ5R9iv
         CC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692179564; x=1692784364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3+V3AaCHKihRhw6vb0FdbJtuhD76LgeUye7PCXJ2SE=;
        b=APv16/ogd9m4Tmb0X9eZAxirns5f8ezOwXeOsQji7Ab4y1v2psbYfQ3SFn3Zw3GOKR
         cvQE5+PSi/rovYmGNRDAHgGcxpyvuWev5+uu1hmR196SpLi2HGRwnGCkf6BLFx9jr5SF
         cvWpLrC9yYmylnjh5MN2fl/S/Km3zYkVlGr29uZgqgHOgLAD6AnGQtfPQiWFrE0jxDdh
         TZsYBTzJ8F94twD3crybBjU+xil/us5hpOcffxCX0y7er+wQVkxs6GSrgvBOzL4wJwF5
         wi032rFjf06jeKdYroW1dl/zUo2xtkn/upFHfttcEAjSPzj8Vs6JO7wwIiN45eu8ewIn
         bEdQ==
X-Gm-Message-State: AOJu0YwtICLBkNP26ylLTtjYYTP9ryyTjEO0wuuf3DSyHWrWN8LMq2ue
        WR+XI2t+YAlk5ZpXJHCbWfw=
X-Google-Smtp-Source: AGHT+IEnlQcEDjqLhUl1YzI9zcNBO8j+Yrulk+M7ocpIBv2GEEKh5r//p6Mor7/UcqXW8fvYoqyDwg==
X-Received: by 2002:a05:6402:1215:b0:523:1400:2d7c with SMTP id c21-20020a056402121500b0052314002d7cmr1080264edw.35.1692179564384;
        Wed, 16 Aug 2023 02:52:44 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15f4:7600:6260:d6f0:1ba4:569e? ([2a00:e180:15f4:7600:6260:d6f0:1ba4:569e])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d9d1000000b0052563bff34bsm4045903eds.63.2023.08.16.02.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 02:52:43 -0700 (PDT)
Message-ID: <9fb57890-9efc-de70-ab37-8b5dc13cf871@gmail.com>
Date:   Wed, 16 Aug 2023 11:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/4] drm/amdgpu: Move coredump code to amdgpu_reset
 file
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        alexander.deucher@amd.com, christian.koenig@amd.com
References: <20230815195100.294458-1-andrealmeid@igalia.com>
 <20230815195100.294458-4-andrealmeid@igalia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230815195100.294458-4-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.08.23 um 21:50 schrieb André Almeida:
> Giving that we use codedump just for device resets, move it's functions
> and structs to a more semantic file, the amdgpu_reset.{c, h}.
>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Acked-by: Christian König <christian.koenig@amd.com> for this patch here.

I'm going to push patch #1 from this series into our internal branch 
since that is actually a bug fix.

 From my side the rest looks good as well, but going to leave this here 
on the list until Shashank had time to take a look as well.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  9 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 78 ----------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 76 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 11 +++
>   4 files changed, 87 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0d560b713948..314b06cddc39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1100,15 +1100,6 @@ struct amdgpu_device {
>   	uint32_t			aid_mask;
>   };
>   
> -#ifdef CONFIG_DEV_COREDUMP
> -struct amdgpu_coredump_info {
> -	struct amdgpu_device		*adev;
> -	struct amdgpu_task_info         reset_task_info;
> -	struct timespec64               reset_time;
> -	bool                            reset_vram_lost;
> -};
> -#endif
> -
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>   {
>   	return container_of(ddev, struct amdgpu_device, ddev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b5b879bcc5c9..9706f608723a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -32,8 +32,6 @@
>   #include <linux/slab.h>
>   #include <linux/iommu.h>
>   #include <linux/pci.h>
> -#include <linux/devcoredump.h>
> -#include <generated/utsrelease.h>
>   #include <linux/pci-p2pdma.h>
>   #include <linux/apple-gmux.h>
>   
> @@ -4799,82 +4797,6 @@ static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -#ifndef CONFIG_DEV_COREDUMP
> -static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> -			    struct amdgpu_reset_context *reset_context)
> -{
> -}
> -#else
> -static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> -		size_t count, void *data, size_t datalen)
> -{
> -	struct drm_printer p;
> -	struct amdgpu_coredump_info *coredump = data;
> -	struct drm_print_iterator iter;
> -	int i;
> -
> -	iter.data = buffer;
> -	iter.offset = 0;
> -	iter.start = offset;
> -	iter.remain = count;
> -
> -	p = drm_coredump_printer(&iter);
> -
> -	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
> -	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> -	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> -	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
> -	if (coredump->reset_task_info.pid)
> -		drm_printf(&p, "process_name: %s PID: %d\n",
> -			   coredump->reset_task_info.process_name,
> -			   coredump->reset_task_info.pid);
> -
> -	if (coredump->reset_vram_lost)
> -		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> -	if (coredump->adev->num_regs) {
> -		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
> -
> -		for (i = 0; i < coredump->adev->num_regs; i++)
> -			drm_printf(&p, "0x%08x: 0x%08x\n",
> -				   coredump->adev->reset_dump_reg_list[i],
> -				   coredump->adev->reset_dump_reg_value[i]);
> -	}
> -
> -	return count - iter.remain;
> -}
> -
> -static void amdgpu_devcoredump_free(void *data)
> -{
> -	kfree(data);
> -}
> -
> -static void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> -			    struct amdgpu_reset_context *reset_context)
> -{
> -	struct amdgpu_coredump_info *coredump;
> -	struct drm_device *dev = adev_to_drm(adev);
> -
> -	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
> -
> -	if (!coredump) {
> -		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
> -		return;
> -	}
> -
> -	coredump->reset_vram_lost = vram_lost;
> -
> -	if (reset_context->job && reset_context->job->vm)
> -		coredump->reset_task_info = reset_context->job->vm->task_info;
> -
> -	coredump->adev = adev;
> -
> -	ktime_get_ts64(&coredump->reset_time);
> -
> -	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
> -		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> -}
> -#endif
> -
>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   			 struct amdgpu_reset_context *reset_context)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 5fed06ffcc6b..46c8d6ce349c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -21,6 +21,9 @@
>    *
>    */
>   
> +#include <linux/devcoredump.h>
> +#include <generated/utsrelease.h>
> +
>   #include "amdgpu_reset.h"
>   #include "aldebaran.h"
>   #include "sienna_cichlid.h"
> @@ -167,5 +170,78 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
>   	up_write(&reset_domain->sem);
>   }
>   
> +#ifndef CONFIG_DEV_COREDUMP
> +void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> +		     struct amdgpu_reset_context *reset_context)
> +{
> +}
> +#else
> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> +		size_t count, void *data, size_t datalen)
> +{
> +	struct drm_printer p;
> +	struct amdgpu_coredump_info *coredump = data;
> +	struct drm_print_iterator iter;
> +	int i;
> +
> +	iter.data = buffer;
> +	iter.offset = 0;
> +	iter.start = offset;
> +	iter.remain = count;
> +
> +	p = drm_coredump_printer(&iter);
> +
> +	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
> +	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> +	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> +	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
> +	if (coredump->reset_task_info.pid)
> +		drm_printf(&p, "process_name: %s PID: %d\n",
> +			   coredump->reset_task_info.process_name,
> +			   coredump->reset_task_info.pid);
> +
> +	if (coredump->reset_vram_lost)
> +		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> +	if (coredump->adev->num_regs) {
> +		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
> +
> +		for (i = 0; i < coredump->adev->num_regs; i++)
> +			drm_printf(&p, "0x%08x: 0x%08x\n",
> +				   coredump->adev->reset_dump_reg_list[i],
> +				   coredump->adev->reset_dump_reg_value[i]);
> +	}
> +
> +	return count - iter.remain;
> +}
>   
> +static void amdgpu_devcoredump_free(void *data)
> +{
> +	kfree(data);
> +}
>   
> +void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> +			    struct amdgpu_reset_context *reset_context)
> +{
> +	struct amdgpu_coredump_info *coredump;
> +	struct drm_device *dev = adev_to_drm(adev);
> +
> +	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
> +
> +	if (!coredump) {
> +		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
> +		return;
> +	}
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
> +		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +}
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index f4a501ff87d9..362954521721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -87,6 +87,15 @@ struct amdgpu_reset_domain {
>   	atomic_t reset_res;
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
>   
>   int amdgpu_reset_init(struct amdgpu_device *adev);
>   int amdgpu_reset_fini(struct amdgpu_device *adev);
> @@ -126,4 +135,6 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
> +void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> +		     struct amdgpu_reset_context *reset_context);
>   #endif

