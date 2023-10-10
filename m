Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0437BF213
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbjJJFGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJFGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:06:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BBA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 22:06:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5892832f8daso4721994a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 22:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696914397; x=1697519197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOJpq6c6s18P1xv5mPHPFQ059Qqr7Fqb/L8fc3dxEDE=;
        b=Cr39ojbKg7h5vNaYgsGR9MB3tsCYVh8dq8zEJw5SfEEDvjfTKLuWmnC6Xqj2POeFps
         qq8syYL2zCQvyIHW4wObq3sLWJyOhSpDv1fIex1wNO0qgyHuq7jKloqIl5Nf/Nge+yAM
         x1bkdij/LpjDn1raMos/tQvH4kncj2FHNWSE28MegnXBlMMekEQfQtSZtU2FrTpgIaGo
         tngNFuJisQza6AC2Swc318rYE5Xd0U4nw/N8RhKjMBEj67pHwRnA0P/ArGHrqluSQGYM
         8IKVWKVFT1rCjJ/udOEs3vECrqpgEORQFeUec22edWoK3tAeI0B3rzge9IJJfIw169bu
         NKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696914397; x=1697519197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOJpq6c6s18P1xv5mPHPFQ059Qqr7Fqb/L8fc3dxEDE=;
        b=IRFEd68yYuut+quc0U78BAdyrpidMwlNoiSvjW1y/Y89Av1MdzbLdO2oKywOyQCIMM
         SRO2c24xJrgZ5ID6vASeLHl0iSwWvww7gVUI2VTOxvTzfRSVB5jx8Xk8/zE+8I2ZnPcJ
         fI18r1r2nRyvHI1+VGfYiH6G44lUSz277ZqNFngf747gam2pzhWFZ8qsV6VxUjrEVKTI
         9kxBMa4G+uPIvg7Is3R+3QbFBnghxKmKABbNKjrdMd/FclO3NPP003dt/UY/suLAnLZO
         8e8SkIwbMmtwYLMUj2ALd2z+wIQL+F8+EiyBZXptIT/ekQmoq4wpNyOV/RFr7ANC6RVT
         zPqQ==
X-Gm-Message-State: AOJu0Yyd1ppy8e4mwM/gGDTzTH69ii2kI6xJfrUHPeYA3Sn85b9FNmdq
        MDb4uoR7odcbIkAhXTWkAxBxCMz4jGP0InlnVKY=
X-Google-Smtp-Source: AGHT+IHd83jSJ6M1Vx4lr+7TJNkqYPfC9JgUfPbyQX1kIR5I4kFdgIy/DJn5rN9qu2fv2H3MxopU5g==
X-Received: by 2002:a17:90a:5415:b0:279:5a3:d5f with SMTP id z21-20020a17090a541500b0027905a30d5fmr22903431pjh.9.1696914396639;
        Mon, 09 Oct 2023 22:06:36 -0700 (PDT)
Received: from [157.82.206.10] ([157.82.206.10])
        by smtp.gmail.com with ESMTPSA id cf9-20020a17090aebc900b00279163e52bbsm9184945pjb.17.2023.10.09.22.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 22:06:36 -0700 (PDT)
Message-ID: <9daf0765-b58c-438f-937c-a8efc0631a66@daynix.com>
Date:   Tue, 10 Oct 2023 14:06:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: add definitions for gfxstream and venus
 capset
To:     Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Stefano Stabellini <stefano.stabellini@amd.com>,
        Honglei Huang <honglei1.huang@amd.com>,
        Julia Zhang <julia.zhang@amd.com>,
        Chen Jiqian <Jiqian.Chen@amd.com>
References: <20231010032553.1138036-1-ray.huang@amd.com>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231010032553.1138036-1-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/10 12:25, Huang Rui wrote:
> These definitions are used fro qemu, and qemu imports this marco in the
> headers to enable gfxstream or venus for virtio gpu. So it should add it
> even kernel doesn't use this.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> Changes V1 -> V2:
> - Add all capsets including gfxstream and venus in kernel header (Dmitry Osipenko)
> 
> v1: https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/
> 
>   include/uapi/linux/virtio_gpu.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index f556fde07b76..327792658bdc 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -309,6 +309,8 @@ struct virtio_gpu_cmd_submit {
>   
>   #define VIRTIO_GPU_CAPSET_VIRGL 1
>   #define VIRTIO_GPU_CAPSET_VIRGL2 2
> +#define VIRTIO_GPU_CAPSET_GFXSTREAM 3
> +#define VIRTIO_GPU_CAPSET_VENUS 4
>   
>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>   struct virtio_gpu_get_capset_info {

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
