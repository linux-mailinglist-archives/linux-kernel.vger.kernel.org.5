Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D177BF868
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjJJKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:20:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92632A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:20:08 -0700 (PDT)
Received: from [192.168.2.166] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7B966607038;
        Tue, 10 Oct 2023 11:20:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696933207;
        bh=YSDyKgPNyiB+QTT7s4ufQBw3fEv/PdNJkCJQZQDh4Vo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OllMAykefJP7nIDKcFzhsjRzHS2mMNgFI7SoNBpkaxC58mEK3CGDkFBOXWKizChPg
         5wR8Pj7AjMHTvbvd6ck2SwHFaIwbTA5NRbbUC/43iliwVWXxDna0yhbM1uyiPjqxUu
         PgXolgxHtzowAUIia0bplggbIBX8th0NB+m5/OazWCZXYFicE/gghwvu500apL28HP
         NTSdMaSgEV4dd2sQ5fQlCIr7PHO+quq3TvbxQ7hopEPRgetANb02cmoZHb35TG3kWb
         yexjBY7gjE4jthNmyBYp2h2a8N7PBXgPBSRLWhDoYiQ3P8DEGK4C0MbzSl+eby021A
         HsazYPe0HQclQ==
Message-ID: <245f993a-72f2-7834-34b4-345f97737be1@collabora.com>
Date:   Tue, 10 Oct 2023 13:20:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/virtio: add definitions for gfxstream and venus
 capset
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
References: <20231010032553.1138036-1-ray.huang@amd.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231010032553.1138036-1-ray.huang@amd.com>
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

Hi,

On 10/10/23 06:25, Huang Rui wrote:
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
>  include/uapi/linux/virtio_gpu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index f556fde07b76..327792658bdc 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -309,6 +309,8 @@ struct virtio_gpu_cmd_submit {
>  
>  #define VIRTIO_GPU_CAPSET_VIRGL 1
>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
> +#define VIRTIO_GPU_CAPSET_GFXSTREAM 3
> +#define VIRTIO_GPU_CAPSET_VENUS 4
>  
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

By the "all" capsets, I meant to pick up all definitions from crosvm.
There should be VIRTIO_GPU_CAPSET_DRM at minimum, could you please add it?

-- 
Best regards,
Dmitry

