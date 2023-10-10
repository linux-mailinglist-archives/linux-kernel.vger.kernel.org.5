Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506BC7C0087
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjJJPk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjJJPky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:40:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C12AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:40:53 -0700 (PDT)
Received: from [192.168.2.166] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50861660297B;
        Tue, 10 Oct 2023 16:40:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696952451;
        bh=Fn9PGvEa9Yc7DpxexISLyAMG9NitNBFOZPUGBK8Mwr8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EVCfOjeCtyWiIkX7YwniYZCBwWr/sV8dBMsVzDkF4b6wbS6S5tTGmNv+MFji27UTT
         KGNkwAeIzO3eb3jIR9+v+q0+myzoVs2/Wf2vA7AzPA071Ca1+mKJ8aw1MdFi+dUcv5
         Iy6Fu88f0mTypNe+PyhwaEkMaXFWjLlpXwtCZxOXRBccRNecWqSKdfIrr5Y3l86F5R
         e18dXtzfGr70Q35os1/wjMWJ+JoJkUKz7WWQaRx3E0xcmm887pSy6xDOqSS8V6Xbo4
         iyLbErkDr4HVT6PTl5Sy7F30lfC3tYTTWndZWxaNylJfizAzXAJPG5vuDgR8TmpAF2
         dxT1JitiyzRow==
Message-ID: <2f8bcce1-6551-6c2d-481c-67502c82bc68@collabora.com>
Date:   Tue, 10 Oct 2023 18:40:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/virtio: add new virtio gpu capset definitions
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Stefano Stabellini <stefano.stabellini@amd.com>,
        Honglei Huang <honglei1.huang@amd.com>,
        Julia Zhang <julia.zhang@amd.com>,
        Chen Jiqian <Jiqian.Chen@amd.com>
References: <20231010135722.1142265-1-ray.huang@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231010135722.1142265-1-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 16:57, Huang Rui wrote:
> These definitions are used fro qemu, and qemu imports this marco in the
> headers to enable gfxstream, venus, cross domain, and drm (native
> context) for virtio gpu. So it should add them even kernel doesn't use
> this.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> 
> Changes V1 -> V2:
> - Add all capsets including gfxstream and venus in kernel header (Dmitry Osipenko)
> 
> Changes V2 -> V3:
> - Add missed capsets including cross domain and drm (native context)
>   (Dmitry Osipenko)
> 
> v1: https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/
> v2: https://lore.kernel.org/lkml/20231010032553.1138036-1-ray.huang@amd.com/
> 
>  include/uapi/linux/virtio_gpu.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index f556fde07b76..240911c8da31 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -309,6 +309,10 @@ struct virtio_gpu_cmd_submit {
>  
>  #define VIRTIO_GPU_CAPSET_VIRGL 1
>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
> +#define VIRTIO_GPU_CAPSET_GFXSTREAM 3

The GFXSTREAM capset isn't correct, it should be GFXSTREAM_VULKAN in
accordance to [1] and [2]. There are more capsets for GFXSTREAM.

[1]
https://github.com/google/crosvm/blob/main/rutabaga_gfx/src/rutabaga_utils.rs#L172

[2]
https://patchwork.kernel.org/project/qemu-devel/patch/20231006010835.444-7-gurchetansingh@chromium.org/

-- 
Best regards,
Dmitry

