Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F17CE02B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjJROiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjJROhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:37:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7B619B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:36:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4304630b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697639805; x=1698244605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MBHQrqw55UjZKvbwXO22BYYyiwvKly9qhomQTJhZaA=;
        b=LTMWXsZl7ZntBnZCC20Xjrfk97Cer1rljgImGjSohvVcKcqOzpavBwYWbDUK/Z1pD8
         GLcnCVSpUHFD216IF7rW2dyB5paHXnU3vFxaRW4b+izaVroXTCEeAQSmOqSJbvkhrM+h
         TkgcawNdYyafPNVBoWurEf3lsVP9zFYilePp2ByvmgzLJVgfUAIr8WBhkLJrOayqwzg7
         AY6CO4x03493qQalC6nr3+J22fKNB6JAxlMvNLE6EbnpRZ7R14vjrgXaTVfEPkwdpWBk
         jBh0fVEoc5IqGa8WRf+JhNxoRmUbgCvQfVHnNglD/TMPRW76tyNxcJkRmM1TG7JQ7T/3
         5y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639805; x=1698244605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MBHQrqw55UjZKvbwXO22BYYyiwvKly9qhomQTJhZaA=;
        b=hcTeDFnjRpsCuPi2Eit1LYYhwo7hWrYlYFPPKtNe/y29461YQX5J/bOlznK0zGZLje
         fzmOdhetIhim6Qxjc85rbVWQj4RhZ3O3vaeoN819afpfS9js6Ce+JoaS3yd4G+8hTh9g
         7Xd1YvHjko3h0RgdZdH5WZtXVxcS7U2xv0SZXlBMyj3W1MKBN/DjImLQ5B0rxVLoGf+O
         RddvjhIp6FnD8GtNrfUWgHonhHTimxf3/vXg/Xvt99W1LSLLYlkIP+ODUIX76ibdRS+h
         Ux3JXnX66qfzfTN44U87fXwQLIMiZMC9L0aFI3XPAmNJDolAnqpjJkCw1ECDo9qAMMhH
         xqIQ==
X-Gm-Message-State: AOJu0YxsAKTTw6911Adiak/1iC1XJHXeoR7lM0mAeIURSF52vYOx7rMF
        XUj/bmQzcxT3wypTf0KN484=
X-Google-Smtp-Source: AGHT+IEtWQEDU+xX49TW325o5ZdEYEM1SAd4UwkCDNJeh/9ChcecZD1WGA/QyoBI/Ln4jFvW9HeGow==
X-Received: by 2002:a05:6a20:9155:b0:15f:faab:1be1 with SMTP id x21-20020a056a20915500b0015ffaab1be1mr5760804pzc.20.1697639805239;
        Wed, 18 Oct 2023 07:36:45 -0700 (PDT)
Received: from [192.168.1.13] ([27.4.124.129])
        by smtp.gmail.com with ESMTPSA id r13-20020a6560cd000000b005aa800c149bsm1604838pgv.39.2023.10.18.07.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:36:44 -0700 (PDT)
Message-ID: <db7e32f5-440d-4e42-8a10-eab0f9d488c8@gmail.com>
Date:   Wed, 18 Oct 2023 20:06:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Fixing indentation and adding License
 Identifier tag
Content-Language: en-US
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231008172751.21953-1-bragathemanick0908@gmail.com>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20231008172751.21953-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/10/23 22:57, Bragatheswaran Manickavel wrote:
> On running checkpatch.pl to nouveau_drm.h identified
> few warnings. Fixing them in this patch
>
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> +/*
>
> WARNING: space prohibited between function name and open parenthesis '('
> +#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE +
> DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
>
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   include/uapi/drm/nouveau_drm.h | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
> index 8d7402c13e56..900ca4f1ebe5 100644
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: MIT */
>   /*
>    * Copyright 2005 Stephane Marchesin.
>    * All Rights Reserved.
> @@ -448,15 +449,15 @@ struct drm_nouveau_svm_bind {
>   
>   #define DRM_IOCTL_NOUVEAU_GETPARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GETPARAM, struct drm_nouveau_getparam)
>   #define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC      DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_ALLOC, struct drm_nouveau_channel_alloc)
> -#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
> +#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
>   
>   #define DRM_IOCTL_NOUVEAU_SVM_INIT           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_INIT, struct drm_nouveau_svm_init)
>   #define DRM_IOCTL_NOUVEAU_SVM_BIND           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_BIND, struct drm_nouveau_svm_bind)
>   
>   #define DRM_IOCTL_NOUVEAU_GEM_NEW            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_NEW, struct drm_nouveau_gem_new)
>   #define DRM_IOCTL_NOUVEAU_GEM_PUSHBUF        DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_PUSHBUF, struct drm_nouveau_gem_pushbuf)
> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
>   #define DRM_IOCTL_NOUVEAU_GEM_INFO           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_INFO, struct drm_nouveau_gem_info)
>   
>   #define DRM_IOCTL_NOUVEAU_VM_INIT            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_VM_INIT, struct drm_nouveau_vm_init)

A Gentle remainder. Can someone please help in reviewing these changes ?

Thanks,
Bragathe

