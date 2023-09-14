Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51B7A0F30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjINUpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjINUpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:45:39 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FD32120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:45:35 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5734f54dc44so797467eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694724335; x=1695329135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYFkx59s2xs5GUhtqs0B2NG56CjyPAmSZL2SFzjSb1A=;
        b=W18YskAvzb69o+UD1NsNXlpUCA99U/LyMniG/sAUQ0DjEHvN8NE9hQAnnEDVRHAMfm
         N+B/fifc0k5H5AjbSX/owFBpfab3Hyp6h1ecUrNHQPRunknFGwuHQpXT2hzmdjiyEH91
         foqsP1AxTgYSEGa1pQh/hVM3d/6x+HAvcyKYvCcU0uiyXbxutloPHlLude4e0OC/hMCv
         4EH9RxcquG8AjjebWOXU9hKAOfv1KLPwUpCUWgcTqatR5CbNC3/Jv0mj1/v7nHUndmIj
         KqeBr5fGpLVRjHZp9BhNfKJw5rnTKwVVA8t3BJJsD2xVvsB84w8trX65s4JGVaJomRiz
         Ke6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724335; x=1695329135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYFkx59s2xs5GUhtqs0B2NG56CjyPAmSZL2SFzjSb1A=;
        b=CQevixNVsi5OP2g09V7IOGuVKLfNllTbzOCU1A8+FxeL/m223S1yueO7vrJU8o4JCj
         klU2xVkglWR6eZScM4PKPkqf8J6rjb/+EQmKCQe0M7dOZX6XktOrbLerNR4HDgPAr+A6
         xuQ6CVt6eefiRxj6HCvfGfcwIhsRCz8C4NW+gEOYdtmLG2O8gH13rkA+kSLsS+KCnoFm
         lWleUUIfVLAb1JElvat398gakTSErgI589ndF0rthqzs1fL8seEFgrZJn/Aee6A1qXsW
         RSgy0u2DiE0XqviSsA51Z0KeFuQ2QyUDW6Iooy1o2W4U/9eVAKKQuFRkAJ3B5WAiJljD
         IUfA==
X-Gm-Message-State: AOJu0YwHGD9Jbl7Pag4O3RkTgAtMXyPXKzQHENvqqK4i+VJL0cgcb3c3
        cplBQ02BW/ZmF4NqAOLYXZKWk25cXCzNYtIPa/poSCEy
X-Google-Smtp-Source: AGHT+IF0ninFMuKfFQj4R5kEyD2TqpllZdJ07TUZpeOjkb7E2DciQ4ukpmEmeloHGp0094kz4pau7MLErnTAD7pMk9o=
X-Received: by 2002:a05:6870:3412:b0:1ad:5317:1f7d with SMTP id
 g18-20020a056870341200b001ad53171f7dmr6949318oah.39.1694724334982; Thu, 14
 Sep 2023 13:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230914094533.213548-1-liucong2@kylinos.cn> <BN9PR12MB52574EE1CDCCD04336E963FFFCF7A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52574EE1CDCCD04336E963FFFCF7A@BN9PR12MB5257.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Sep 2023 16:45:23 -0400
Message-ID: <CADnq5_Oaw6Cm+oUb_TpfPwTt_euA85CB1aY6dxcW=r2hjp_Aig@mail.gmail.com>
Subject: Re: [PATCH] fix a memory leak in amdgpu_ras_feature_enable
To:     "Zhang, Hawking" <Hawking.Zhang@amd.com>
Cc:     Cong Liu <liucong2@kylinos.cn>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Yang, Stanley" <Stanley.Yang@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Sep 14, 2023 at 5:53=E2=80=AFAM Zhang, Hawking <Hawking.Zhang@amd.c=
om> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: Cong Liu <liucong2@kylinos.cn>
> Sent: Thursday, September 14, 2023 17:46
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <ai=
rlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Yang, Stanley <Stanley.Y=
ang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Cong Liu <liucong2@kylinos.cn>; amd-gfx@lists.freedesktop.org; dri-de=
vel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] fix a memory leak in amdgpu_ras_feature_enable
>
> This patch fixes a memory leak in the amdgpu_ras_feature_enable() functio=
n.
> The leak occurs when the function sends a command to the firmware to enab=
le or disable a RAS feature for a GFX block. If the command fails, the kfre=
e() function is not called to free the info memory.
>
> Fixes: bf7aa8bea9cb ("drm/amdgpu: Free ras cmd input buffer properly")
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 8eb6f6943778..b4a8ea946410 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -802,6 +802,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *a=
dev,
>                                 enable ? "enable":"disable",
>                                 get_ras_block_str(head),
>                                 amdgpu_ras_is_poison_mode_supported(adev)=
, ret);
> +                       kfree(info);
>                         return ret;
>                 }
>
> --
> 2.34.1
>
