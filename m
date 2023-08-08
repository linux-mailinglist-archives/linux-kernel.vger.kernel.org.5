Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF757736CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHHChU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHHChS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:37:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F9E83
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:37:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf91956cdso672251266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 19:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691462236; x=1692067036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Pzo/ae8fiZC5mD6rJbJETUk5SqmzLl4qP80bXe4VJw=;
        b=jp1qrrbYROFguZcOFx9Q8zIaj8439PAFQ7zNWYG0iZ0RiVY/dWssDNLrr6irn+1IVi
         0IY+prmE0xcz50IQCnF/HguKEH9Vi5T81s8LnWFPeoUsog6Kh9ajCk0j8NslPILHNN+E
         kUG5oNIUfzmbirknglpMB/MLFr8g56RxYdc6YJBJowu4B+tFY1EgNahw4FcMni62kmdv
         Y9XKLpNrHImDw9nNBB7VsSi/6UHQmuAmSd/WL/am0vqJvPlqmy6jClV2grrAilGUVfvF
         ShNFNDujmkhRvbKePthwC1uMIY5zf/+u7pAV+g5CXRUIF1PU7sw1WnIgxO4Rq/1+Koxk
         HGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462236; x=1692067036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Pzo/ae8fiZC5mD6rJbJETUk5SqmzLl4qP80bXe4VJw=;
        b=ShcPhcJ9t2Vx7AEcm2vNLozPnOclMggxvTQ5z888k5rC8b/pz5HxUt7o8Bua7Z+F2B
         vkE40gBkXa1xjPjXvy4iuUEgFEfQILL+7gQZxrR+tDd2V6LoF5VWSdD1CFlwaSw5obv2
         DzAIJ0jDF1KqgdB02tvxijwfteR5PLwdMNKt76poLbVF1HkDBb0OoteIchWuS9gn+hOG
         9Bh7shYKdGRwTeGMHCe+pcyyBF9Kl8LX9qeqeUpc/DIagHRX/wMWCqEhRlN9Q9uiIB7b
         bKEhnl/LuVHOOqfrsQ1f1mrVSU/k+IfJPpRQnOESjnFtZrHBBMHQhlEkiFUxmL740bGR
         6Qxg==
X-Gm-Message-State: AOJu0YyUtgpPXQQuyDo8Wn53zO1TRWwLj/DxSYVXbQhOknQXjCp/lqtn
        dOH2+orx7XD9ih1iBTkHRR+R5UercKhLT7M7238=
X-Google-Smtp-Source: AGHT+IEh9niFo4xdJ945FQYYzvfAVJ3a7wxVMppL7pEawqEYWNmd2+JTGsKdFCsEX2UI/cKYLZoP0spIVcDaXCc5E8U=
X-Received: by 2002:a17:906:3298:b0:99c:53f:1dc7 with SMTP id
 24-20020a170906329800b0099c053f1dc7mr8795188ejw.54.1691462235711; Mon, 07 Aug
 2023 19:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230807163238.2091-1-dakr@redhat.com>
In-Reply-To: <20230807163238.2091-1-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 8 Aug 2023 12:37:03 +1000
Message-ID: <CAPM=9twBcE8vRBvjxSSsk23wh246cBFX8jQx5Aap9veLYxOt-g@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next 0/5] Nouveau VM_BIND uAPI Fixes
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, bskeggs@redhat.com, kherbst@redhat.com,
        lyude@redhat.com, sfr@canb.auug.org.au,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the series:

Reviewed-by: Dave Airlie <airlied@redhat.com>

On Tue, 8 Aug 2023 at 02:32, Danilo Krummrich <dakr@redhat.com> wrote:
>
> The patch series provides a few fixes for the recently merged VM_BIND uAPI
> mostly addressing a couple of warnings.
>
> It also contains one patch to slightly reduce the memory footprint of
> struct nouveau_uvma.
>
> Danilo Krummrich (5):
>   nouveau/dmem: fix copy-paste error in nouveau_dmem_migrate_chunk()
>   drm/nouveau: nvkm: vmm: silence warning from cast
>   drm/nouveau: remove incorrect __user annotations
>   drm/nouveau: uvmm: remove incorrect calls to mas_unlock()
>   drm/nouveau: uvmm: remove dedicated VM pointer from VMAs
>
>  drivers/gpu/drm/nouveau/nouveau_dmem.c        |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_exec.c        |  6 ++---
>  drivers/gpu/drm/nouveau/nouveau_exec.h        |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 23 ++++++++-----------
>  drivers/gpu/drm/nouveau/nouveau_uvmm.h        | 14 +++++------
>  .../gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c    |  5 ++--
>  6 files changed, 24 insertions(+), 28 deletions(-)
>
>
> base-commit: 82d750e9d2f5d0594c8f7057ce59127e701af781
> --
> 2.41.0
>
