Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA3754548
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGNXH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGNXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB501980
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689376034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqDiqY4N3zDWFlHFUlK8i/J+HIGUbJcqEkShbsY9GIc=;
        b=f9et3qhpSwLrtPcgCY38XnaG/DuBMVVRKerQVi8WgEQUliqz+1ZUUOQJJN89xOTSFWudI5
        c0YQILwGVvkzu4fAklrjI7ltP9dh7bF/luHDwxJHqPhUy0MPaBQrMGR2p/rKxBT+AzIIOL
        n7Bq8G/Sh+5SPjGz7XkDwCrkAhmUQyM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-_VJNrJFENIG_QznVHihixg-1; Fri, 14 Jul 2023 19:07:13 -0400
X-MC-Unique: _VJNrJFENIG_QznVHihixg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e6c83cf0so24725926d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689376032; x=1691968032;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqDiqY4N3zDWFlHFUlK8i/J+HIGUbJcqEkShbsY9GIc=;
        b=LTOjmjscyBHxrSnna/eV2vfF1Sll60ADezYHgeqCXBG0n7PcOehgKsC590CPzrZXWF
         itC1HWhy8ZGpmKNeP6nY7l91ZFgB7NTX9wpN++hxQuh5uhy5k23mDrfYGRHhOyzfF6LV
         jF006puWXfFTbMnpyJ7Ox96whazawV2Wdp2r/br3RyqJJ7ilvSDsLVfMHn7waVH1Lb7N
         eJyzHB2jE1/ZJF0BYpSfFQxJ5sdiOsmfh2xqlb2E2rzChNKM/5oBjZe6kz+lmKn6wpeL
         XqcXfNnEQjEmJYX4romwaph2VxRe++Br1/g7adt1A19srvU/gL4pDW2c/Tpd6Ga5GL5I
         1Q6w==
X-Gm-Message-State: ABy/qLa/xA1+VLLhuVvApq/nKgBzTDbty5WJSnFiiFhXKtVAA7YDBZa6
        QJGtjHN0g3EOWQVwuissXShVpZ/t5eaqthPc4/SbpENySvwwypmVU3RL2eMagRxjG/7TZ1tCGxh
        3YUJMl8iKoC/EG0J0UGYVCrph
X-Received: by 2002:a05:622a:11ca:b0:400:91d8:a704 with SMTP id n10-20020a05622a11ca00b0040091d8a704mr8261747qtk.47.1689376032712;
        Fri, 14 Jul 2023 16:07:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFEDeUJQAf5GAAHKm0EYcAKtwaaDfwtH7D7qV8NAv+bu8ED8AvVMP5+iouCbmTPPgwbpF9k0w==
X-Received: by 2002:a05:622a:11ca:b0:400:91d8:a704 with SMTP id n10-20020a05622a11ca00b0040091d8a704mr8261731qtk.47.1689376032460;
        Fri, 14 Jul 2023 16:07:12 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87318000000b00402364e77dcsm4334646qto.7.2023.07.14.16.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 16:07:11 -0700 (PDT)
Message-ID: <856d1130fad58062ea454da297fa64348382bda2.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/fifo:Fix Nineteen occurrences of the
 gk104.c error: ERROR: : trailing statements should be on next line
From:   Lyude Paul <lyude@redhat.com>
To:     huzhi001@208suo.com, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Jul 2023 19:07:10 -0400
In-Reply-To: <0ad4154429aaa41ca26da859c3f35784@208suo.com>
References: <5c894d0a8a178628ca200d054004be3c@208suo.com>
         <f25017a660f8a3a4e49258a1d96003dc@208suo.com>
         <2f4a7303e305d07fdd9c15a9dc95dc5f@208suo.com>
         <d0d767fb0dd3a9b7642559f379dbb0d6@208suo.com>
         <0ad4154429aaa41ca26da859c3f35784@208suo.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK - checkpatch.pl is a (strongish) guideline, but not a rule. In the case=
s
corrected in the patch series here, we format the switch cases on single li=
nes
as it dramatically improves the readability of what is otherwise just a /lo=
ng/
list of slightly different static mappings. I don't believe we're the only
part of the kernel to do this either.

On Fri, 2023-07-14 at 14:58 +0800, huzhi001@208suo.com wrote:
> Signed-off-by: ZhiHu <huzhi001@208suo.com>
> ---
>   .../gpu/drm/nouveau/nvkm/engine/fifo/gk104.c  | 40 ++++++++++++++-----
>   1 file changed, 29 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c=20
> b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
> index d8a4d773a58c..b99e0a7c96bb 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
> @@ -137,15 +137,29 @@ gk104_ectx_bind(struct nvkm_engn *engn, struct=20
> nvkm_cctx *cctx, struct nvkm_chan
>       u64 addr =3D 0ULL;
>=20
>       switch (engn->engine->subdev.type) {
> -    case NVKM_ENGINE_SW    : return;
> -    case NVKM_ENGINE_GR    : ptr0 =3D 0x0210; break;
> -    case NVKM_ENGINE_SEC   : ptr0 =3D 0x0220; break;
> -    case NVKM_ENGINE_MSPDEC: ptr0 =3D 0x0250; break;
> -    case NVKM_ENGINE_MSPPP : ptr0 =3D 0x0260; break;
> -    case NVKM_ENGINE_MSVLD : ptr0 =3D 0x0270; break;
> -    case NVKM_ENGINE_VIC   : ptr0 =3D 0x0280; break;
> -    case NVKM_ENGINE_MSENC : ptr0 =3D 0x0290; break;
> -    case NVKM_ENGINE_NVDEC :
> +    case NVKM_ENGINE_SW:
> +        return;
> +    case NVKM_ENGINE_GR:
> +        ptr0 =3D 0x0210;
> +        break;
> +    case NVKM_ENGINE_SEC:
> +        ptr0 =3D 0x0220;
> +        break;
> +    case NVKM_ENGINE_MSPDEC:
> +        ptr0 =3D 0x0250;
> +        break;
> +    case NVKM_ENGINE_MSPPP:
> +        ptr0 =3D 0x0260;
> +        break;
> +    case NVKM_ENGINE_MSVLD:
> +        ptr0 =3D 0x0270;
> +        break;
> +    case NVKM_ENGINE_VIC:
> +        ptr0 =3D 0x0280; break;
> +    case NVKM_ENGINE_MSENC:
> +        ptr0 =3D 0x0290;
> +        break;
> +    case NVKM_ENGINE_NVDEC:
>           ptr1 =3D 0x0270;
>           ptr0 =3D 0x0210;
>           break;
> @@ -435,8 +449,12 @@ gk104_runl_commit(struct nvkm_runl *runl, struct=20
> nvkm_memory *memory, u32 start,
>       int target;
>=20
>       switch (nvkm_memory_target(memory)) {
> -    case NVKM_MEM_TARGET_VRAM: target =3D 0; break;
> -    case NVKM_MEM_TARGET_NCOH: target =3D 3; break;
> +    case NVKM_MEM_TARGET_VRAM:
> +        target =3D 0;
> +        break;
> +    case NVKM_MEM_TARGET_NCOH:
> +        target =3D 3;
> +        break;

This one isn't very long, but I'd still say it's definitely a lot easier to
read in the compact form. If anything, the only change I would make here is
formatting the default: case to be on a single line as well

>       default:
>           WARN_ON(1);
>           return;

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

