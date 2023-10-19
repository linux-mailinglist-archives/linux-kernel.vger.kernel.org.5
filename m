Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4007CEE99
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJSEXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:23:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411F121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:23:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c434c33ec0so52086325ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697689410; x=1698294210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIOghrBmVZu6lgiOtXXOECZ8n+mlWZ7P1vW/PW8XFuE=;
        b=ivUmsiuenE6awRzxVvACitJVgj8QcdmwpBC3igjuwRXI4YYsIoh8LC5DA5yP1JaHfv
         8UbmVvP/QULegyvvSKxQ2hzu/F5ZyIHugc70rSNNcRhSTPsGNRl3IzHewmeQyPseErgN
         AzicKAHxjQiO3ZJIyj9uyd5kKoh1qP++q9Zff7WPVhGpDv62xNSg4YepTrMfoLGMLirk
         rym8NzRS/jRayHvp+UKBvg9tCeyVWJTeZZgGZwnM3A5akSUtpwrs1mE9uQUAQpZWnkrS
         6PDchtsLUBOEgG+AV67VUfHqlOYODVIku2265JA6EXnx37S23nar9WlUCU/DyadJX/XS
         8D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697689410; x=1698294210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIOghrBmVZu6lgiOtXXOECZ8n+mlWZ7P1vW/PW8XFuE=;
        b=OGhVX9HGMxosxD9qA/5CFT4JFhlONHqP7z+UxAs5NJT2BvmMLPgqest0Ye5TNNX9tp
         pYsyuzPc6P3mDmyUwi/opP8qw5gQt41UH2h6M4lOIud7syZ5fZOTWMAp1+hHGXDzQqed
         KDD0wJ6gFVgAjyeY6Q1MgywL7dBZck3L9gDN0BYqBt+K7RJodQxgNE7PRRpIEOWjwihU
         7HNag9yXo2pJAPS5l0kfhIyWsZ/WkVMdsQVMFXuonW/RHsXkQW9i28o7HiMbfllCgPrP
         8CqvM7Z9yfe8+uCtxQ+mz6lL9C+u40b9OLN6nTBj3KbYTOCwvn+VJV7XlXDg4CZEJ3jI
         4ZJw==
X-Gm-Message-State: AOJu0Yy0TMkqVDv8yz7lAPgblxM8HDQ/CuPnxh+4LONfmEaEkkMUxes1
        QmNwVatrXO2ewI2TkmN240M82g==
X-Google-Smtp-Source: AGHT+IEpwj8F0CwiHYwEL/qYEFayCGnPsZ0W41oVGG2vRz+p0X0xMd0PQySyypQbuglemxOUwBY+xg==
X-Received: by 2002:a17:902:ef0e:b0:1ca:362b:1482 with SMTP id d14-20020a170902ef0e00b001ca362b1482mr1083218plx.67.1697689409640;
        Wed, 18 Oct 2023 21:23:29 -0700 (PDT)
Received: from [157.82.207.43] ([157.82.207.43])
        by smtp.gmail.com with ESMTPSA id bj11-20020a170902850b00b001bf8779e051sm733646plb.289.2023.10.18.21.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 21:23:29 -0700 (PDT)
Message-ID: <04b6caa4-32c2-40f9-a095-dbabfce6de9a@daynix.com>
Date:   Thu, 19 Oct 2023 13:23:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/virtio: add new virtio gpu capset definitions
Content-Language: en-US
To:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Huang Rui <ray.huang@amd.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
References: <20231010135722.1142265-1-ray.huang@amd.com>
 <2f8bcce1-6551-6c2d-481c-67502c82bc68@collabora.com>
 <2c162058-288c-9e9e-48d5-3b2ddb0cc1fa@collabora.com>
 <ZSYnQbHUecuUlwvr@amd.com>
 <CAAfnVB=Mki1zEyjByJ_7tRrib74E4KSbjezqQcb_Uia8EQEXHw@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAfnVB=Mki1zEyjByJ_7tRrib74E4KSbjezqQcb_Uia8EQEXHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/19 8:25, Gurchetan Singh wrote:
> 
> 
> On Tue, Oct 10, 2023 at 9:41 PM Huang Rui <ray.huang@amd.com 
> <mailto:ray.huang@amd.com>> wrote:
> 
>     On Tue, Oct 10, 2023 at 11:52:14PM +0800, Dmitry Osipenko wrote:
>      > On 10/10/23 18:40, Dmitry Osipenko wrote:
>      > > On 10/10/23 16:57, Huang Rui wrote:
>      > >> These definitions are used fro qemu, and qemu imports this
>     marco in the
>      > >> headers to enable gfxstream, venus, cross domain, and drm (native
>      > >> context) for virtio gpu. So it should add them even kernel
>     doesn't use
>      > >> this.
>      > >>
>      > >> Signed-off-by: Huang Rui <ray.huang@amd.com
>     <mailto:ray.huang@amd.com>>
>      > >> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      > >> ---
>      > >>
>      > >> Changes V1 -> V2:
>      > >> - Add all capsets including gfxstream and venus in kernel
>     header (Dmitry Osipenko)
>      > >>
>      > >> Changes V2 -> V3:
>      > >> - Add missed capsets including cross domain and drm (native
>     context)
>      > >>   (Dmitry Osipenko)
>      > >>
>      > >> v1:
>     https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/ <https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com/>
>      > >> v2:
>     https://lore.kernel.org/lkml/20231010032553.1138036-1-ray.huang@amd.com/ <https://lore.kernel.org/lkml/20231010032553.1138036-1-ray.huang@amd.com/>
>      > >>
>      > >>  include/uapi/linux/virtio_gpu.h | 4 ++++
>      > >>  1 file changed, 4 insertions(+)
>      > >>
>      > >> diff --git a/include/uapi/linux/virtio_gpu.h
>     b/include/uapi/linux/virtio_gpu.h
>      > >> index f556fde07b76..240911c8da31 100644
>      > >> --- a/include/uapi/linux/virtio_gpu.h
>      > >> +++ b/include/uapi/linux/virtio_gpu.h
>      > >> @@ -309,6 +309,10 @@ struct virtio_gpu_cmd_submit {
>      > >>
>      > >>  #define VIRTIO_GPU_CAPSET_VIRGL 1
>      > >>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
>      > >> +#define VIRTIO_GPU_CAPSET_GFXSTREAM 3
>      > >
>      > > The GFXSTREAM capset isn't correct, it should be
>     GFXSTREAM_VULKAN in
>      > > accordance to [1] and [2]. There are more capsets for GFXSTREAM.
>      > >
>      > > [1]
>      > >
>     https://github.com/google/crosvm/blob/main/rutabaga_gfx/src/rutabaga_utils.rs#L172 <https://github.com/google/crosvm/blob/main/rutabaga_gfx/src/rutabaga_utils.rs#L172>
>      > >
>      > > [2]
>      > >
>     https://patchwork.kernel.org/project/qemu-devel/patch/20231006010835.444-7-gurchetansingh@chromium.org/ <https://patchwork.kernel.org/project/qemu-devel/patch/20231006010835.444-7-gurchetansingh@chromium.org/>
>      >
>      > Though, maybe those are "rutabaga" capsets that not related to
>      > virtio-gpu because crosvm has another defs for virtio-gpu capsets
>     [3].
>      > The DRM capset is oddly missing in [3] and code uses "rutabaga"
>     capset
>      > for DRM and virtio-gpu.
>      >
>      > [3]
>      >
>     https://github.com/google/crosvm/blob/main/devices/src/virtio/gpu/protocol.rs#L416 <https://github.com/google/crosvm/blob/main/devices/src/virtio/gpu/protocol.rs#L416>
> 
>     Yes, [3] is the file that I referred to add these capsets
>     definitions. And
>     it's defined as gfxstream not gfxstream_vulkan.
> 
>      >
>      > Gurchetan, could you please clarify which capsets definitions are
>      > related to virtio-gpu and gfxstream. The
>      > GFXSTREAM_VULKAN/GLES/MAGMA/COMPOSER or just the single GFXSTREAM?
> 
> 
> It should be GFXSTREAM_VULKAN.  The rest are more experimental and easy 
> to modify in terms of the enum value, should the need arise.
> 
> I imagine the virtio-spec update to reflect the GFXSTREAM to 
> GFXSTREAM_VULKAN change will happen eventually.

I think this is a matter what the committee should determine, but in 
general I don't think it is OK to change the existing identifier.

I also think even experimental values should be added to virtio spec at 
an early stage unless such an "experiment" is done only on one laptop. 
We can obsolete a capset anytime so it's more important to avoid 
conflicts of capsets.
