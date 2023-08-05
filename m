Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2B7710BD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjHERDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjHERDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB9B4206
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691254970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwC2ZFlhYxmRV4GegFNry2xNQ2qKII2yxV/GxFfD/+Q=;
        b=QRdHD3hjtLpyFARvkD3iXYX4WLzHGPgtBC0/jH+Woft7HBO2Q4yY/g6I4cQPHzeAGnGLQ0
        mjDIayRPCEC+dGUbUXuDKKuADPZi6PdM5DPXmJ2oYiDxW9n3J4UXgTHSgYOIG4R64bjqAQ
        Bgi/ypTy8fnqcWa1YCrBJsX+bIX5fMg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-xmMjsubCMMOH4XkZ5ISgMg-1; Sat, 05 Aug 2023 13:02:49 -0400
X-MC-Unique: xmMjsubCMMOH4XkZ5ISgMg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b839ca1362so6754051fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 10:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691254967; x=1691859767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwC2ZFlhYxmRV4GegFNry2xNQ2qKII2yxV/GxFfD/+Q=;
        b=k+jf8zAOefdJAfHHCptKkhypJBiDwjAK8BSc7fcQV855EXLVvjilMsLjYmgzozxFVV
         EvfH/tO2sdVkIRdzv3980WhDjIaqRUgnSzx6vCl7SfUajwXmrRm2NA+AMW49j+yXPj2H
         gIaLsH2+z8MPVR9tlSX8Yz2iZcRDuDywtjGQPfgL2G1mn0wJ8iMJBpMyQUkYO3hWbkyk
         WcxE2z6B9stYkdexa6fVkf+UY18lkbHNeHat1w1NH64GNVYxmapMBqZ32P1Y3vGCui0g
         XBUi/hQLU5xmwQjUnO18yLNptN/wSavnFWKcUsP7IQgy6TX+pdABTz/uie3ejP7OwSI2
         3WOQ==
X-Gm-Message-State: ABy/qLboukLjxxYcc9LuI6eHarTFLPZJj4h/TMx67RF7TrMslDKl+L2b
        deTzZPd462cfZOZsc/+VHew8tyesXLJecQMy6qefdnFZ++fugulaUa9B4ID24tmjEEhIvQqyWVR
        f4PFB8a75GgP4F+vFmHj/IUfjvvLn+glgqdfmxbRX
X-Received: by 2002:a05:651c:2c6:b0:2b6:120a:af65 with SMTP id f6-20020a05651c02c600b002b6120aaf65mr11587129ljo.3.1691254967644;
        Sat, 05 Aug 2023 10:02:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGYiaAtFICZukz9GbgjadQIab1/CS12YPAHJmL8CGE4gx4kvaxS7NRq41yHA7pyNnx9RsTZk5QJDcTdUUMT23U=
X-Received: by 2002:a05:651c:2c6:b0:2b6:120a:af65 with SMTP id
 f6-20020a05651c02c600b002b6120aaf65mr11587124ljo.3.1691254967373; Sat, 05 Aug
 2023 10:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230805160027.88116-1-dakr@redhat.com>
In-Reply-To: <20230805160027.88116-1-dakr@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 5 Aug 2023 19:02:36 +0200
Message-ID: <CACO55tuS=tg_r-9W1fCr55svT8U0GhxLauMAmAmW7A052S_Mdg@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next] nouveau/dmem: fix copy-paste error in nouveau_dmem_migrate_chunk()
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        lyude@redhat.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 6:00=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> w=
rote:
>
> Fix call to nouveau_fence_emit() with wrong channel parameter.
>
> Fixes: 7f2a0b50b2b2 ("drm/nouveau: fence: separate fence alloc and emit")
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nou=
veau/nouveau_dmem.c
> index 4ad40e42cae1..61e84562094a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -678,7 +678,7 @@ static void nouveau_dmem_migrate_chunk(struct nouveau=
_drm *drm,
>         }
>
>         if (!nouveau_fence_new(&fence))
> -               nouveau_fence_emit(fence, chunk->drm->dmem->migrate.chan)=
;
> +               nouveau_fence_emit(fence, drm->dmem->migrate.chan);
>         migrate_vma_pages(args);
>         nouveau_dmem_fence_done(&fence);
>         nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);
>
> base-commit: 82d750e9d2f5d0594c8f7057ce59127e701af781
> --
> 2.41.0
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

