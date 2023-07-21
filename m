Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B475CCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjGUQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjGUQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:00:06 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D82E30C7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:00:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b049163c93so1343118fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955204; x=1690560004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5EvHH1DtEeFzSe/qfbeuuYUsnqICJDx2+XgzP0/NPs=;
        b=QbJzX9iZpCz6sryu/XX2sbkAG/F7Ftohnc5pzMW3hZqdW/isAkFf/g5ilsNkyhXlwK
         +WTjE6agHX3wYY3e5enOfq4YSz5wQEY9CCv88zbPaeL6+JuxwgEiu0ZtFnEgQeqJUnIu
         ODmlcdotKUQIm0/qUVERDiShiOp0OvTCy/HGzLzaIJ8jutp/H4QdeJf5TDDc7fqxHJDy
         foCNPc/MhMneu26q6uT+VSwHlNiSEBKvn55xkqBisEMH+Dib+cHmo893h9LCsOqkGqFg
         jo27fk99aa99nEnU0o9KX9m2XvKYfZGQnxtZNmB6z5mXpSvkym3wJJjOq27hAfXgPyUb
         WGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955204; x=1690560004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5EvHH1DtEeFzSe/qfbeuuYUsnqICJDx2+XgzP0/NPs=;
        b=Sn0Oai3I4v4gBRXixkqvA+hDuTdKo4EvR2/yDNHhF1vX0UNnSoD1pYGMSE5qCmCU/V
         w1vDDlT7PAckpOZCxmwphCpZXgb/Ra420ARuAzqjO0909UhICB60FNJah+AzGuak0uT5
         60NIhfr2mkYUnnZqtQbxhg1DZB8wEkxcrbbvcS7u8TbOpHSnpCUtpO+/iTVYIxw95vHq
         JmNU97Xy2hGuC/tT4I6d1Zww097fvjdB6tx+/jUM25BmY0aweBb2uXwzcdwTw+i35msZ
         SYIUQNe/VUkl4VxoRGxp/m8Ub4wq9a0ZpfpOK1T5oo1DqVm1Ls0eDSRXRKc19uKSpExx
         mXrA==
X-Gm-Message-State: ABy/qLZqwBE0M9nVH4I3Z9Up7MkHKjDM2deYnB+AzCT8BY5vtMZK/ti7
        ZI1Z55oWaalbEVJPfOW7fbtXbOj3BR2qo34M0j2ezTJI
X-Google-Smtp-Source: APBJJlH9uiN6ru/ABZodG46E50A0fohiI1ZXIZvNZwBeCL8QDXjl+XGWVujd3gtuauMG1+1seuNo/guT77TUv3eGpmE=
X-Received: by 2002:a05:6870:46a2:b0:1ba:64a5:d2d1 with SMTP id
 a34-20020a05687046a200b001ba64a5d2d1mr2503528oap.20.1689955204629; Fri, 21
 Jul 2023 09:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230721035225.4986-1-xujianghui@cdjrlc.com> <f2e8d7241330934429e19a960a232f9c@208suo.com>
In-Reply-To: <f2e8d7241330934429e19a960a232f9c@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jul 2023 11:59:53 -0400
Message-ID: <CADnq5_NKs6n1v+j6cTeo9OZ04yB12fHXD06XbzjWGzdBaE7RpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: open brace '{' following struct go on the
 same line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 11:53=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: open brace '{' following struct go on the same line
>

The description doesn't match what the patch is doing.

Alex

> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index ddc488251313..0cf564ea1ed8 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -429,10 +429,10 @@ int amdgpu_pm_load_smu_firmware(struct
> amdgpu_device *adev, uint32_t *smu_versio
>   int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool
> enable);
>   int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev,
> uint32_t size);
>   int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev,
> uint32_t size);
> -int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,enum
> pp_clock_type type,
> -                                 uint32_t *min,uint32_t *max);
> -int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,enum
> pp_clock_type type,
> -                                  uint32_t min,uint32_t max);
> +int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev, enum
> pp_clock_type type,
> +                                 uint32_t *min, uint32_t *max);
> +int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev, enum
> pp_clock_type type,
> +                                  uint32_t min, uint32_t max);
>   int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev);
>   int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum
> smu_event_type event,
>                               uint64_t event_arg);
