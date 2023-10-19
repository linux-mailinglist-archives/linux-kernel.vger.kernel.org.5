Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D267CFD55
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbjJSOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJSOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:51:32 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD00138
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:51:30 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so3972344fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697727088; x=1698331888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQdIc8b8rLwyEGA7aYkkgb3aiLBGi2Off4qaN8J15KY=;
        b=ZTxhDBjAtX+5kJhEDdpqeru5eZI8nysDBUP6DlZaFz0Y0kFnia8zam77Axgs6en1LB
         zvLsqAEXBfrUuc52azb7eqvqb75jvlIwat3557ky/vQbi80BlssBumdgVcUiOpRzRDuR
         0XOnq8esxkuh2ObH/G8yqeOvFQfcKw9Pk+oGbB+m5hol8p+heQO/NbQ3y19g0Y9Xen9t
         mRbveExeqQw+/dW1YFYbnmrWY27/Ii5b/1IJU030oJ+q3kpwq15eh0x/yHMqap8W/lgd
         Sc2OFdWEge1VGQDwTRuky2oASQTTV7RDYEvBXFXg/Fd0S4SQtul6bZ0oq3h7wyP2xuq9
         1jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727088; x=1698331888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQdIc8b8rLwyEGA7aYkkgb3aiLBGi2Off4qaN8J15KY=;
        b=omx+U5BN1En/N9QvzKu2mlNig2BjFVoKJJoH8c6Gi5fZqSbpetjnODJesOQ/Ude5MM
         GE16xCbqrfm2B1xn9MjFb98DtCRxMZOINPq4Q03oA3NaBcazkO2VlYg+x7b6HTCkPdxw
         7ZcNRtbICirKrxrU2917ai9mn/Ehf76lwbvHrci7FNtatS/zKahLQcYRpfzht5XyW1B3
         4iJNJ1dVY0K4/b4FKzYQAxRZIjgGcB2DLah0YxHj+t8dYRuSY/Qa9WoIAKDNLhQAJarY
         uhcz6rzNXGrhaP3FPIJ6ubzRRj0Cmr03w6T63sJnj51M3wTV843sZ5ycg1LSQrQGN5Ig
         AvXQ==
X-Gm-Message-State: AOJu0Yw3GUgumfvP2PXffiksMzQ0GWXFLruWr75QKE11i5wkd1PfvV61
        DWsRjwu7pZygu3jl57KJThCbt5sVRgkL+6HVnLKrKLKc
X-Google-Smtp-Source: AGHT+IHty6N7HTJwpNZ/GBo+XwmpY21HacXzaSadWjnIqIdv5tFUJe93vf7vOV7YvaUrmXuFxsys+iKlKN6c5XNdTMY=
X-Received: by 2002:a05:6870:1205:b0:1ea:8645:6352 with SMTP id
 5-20020a056870120500b001ea86456352mr2048322oan.11.1697727088053; Thu, 19 Oct
 2023 07:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231019033826.127396-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20231019033826.127396-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Oct 2023 10:51:16 -0400
Message-ID: <CADnq5_OjCTV=-EAZ3coKVKBkpWZTBg+sH1zJBM8e9Ng3Kmh47A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Oct 18, 2023 at 11:38=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2902 dm_resum=
e() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6940
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 801f87a12ccf..0e1f8c5d7f9b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2899,7 +2899,7 @@ static int dm_resume(void *handle)
>         }
>
>         /* power on hardware */
> -        dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>
>         /* program HPD filter */
>         dc_resume(dm->dc);
> --
> 2.20.1.7.g153144c
>
