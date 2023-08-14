Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201F377BF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjHNRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjHNRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:53:36 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C573E5E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:53:26 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56d6dfa1f3cso2499281eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692035606; x=1692640406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNj4Ehy/sfd0pFzOH9dNZTRBv9sp3KUM4KIPo2H4CmY=;
        b=rN42HWWDFze8qvsP/5ZO5xHNVC1uJACbX1HAtVkEbdgDXR1+Bfdrm1H+0/7J4sJImJ
         oW2Y8orP6PAthtO1xZ3wQaRWB8YwRMcAJiTXh6YScl+8WM7UW36db95j/Bih10gi3eyX
         2ceDPLBzqQNeUnSckxy8FE2wOuuHIKM7XnXdrgYsWQd9OqT1PH5ffT8x7X9cELduQDDS
         I2+TovgvXXmA1otGD4LzagdMAN89bIGTRIE3pBzqLb4/Kq/RyPLV75k6meF6eeG5QKze
         4F/6NrcAg+UAW5vAozvCRLjnyFnYakzvFDQsRBPymTtzaCbADc6K6iKoe+XMcpYOF+Ji
         UXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035606; x=1692640406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNj4Ehy/sfd0pFzOH9dNZTRBv9sp3KUM4KIPo2H4CmY=;
        b=kEbwSip8PSiOVnLmY50H9vNHPdYGkbFD4EM0WGvFvxThj5bz4eaHUlVA/1VnbAgBdy
         7+PwMMP4fqA5KEYwUQ7oS8/JTxwA2SgWKdoAqXTe2Y4XLUOhDBjw2lpZd4HG9ItVJXnT
         g44wBOn6aFvJl0MC2rkr72HQqVZZb6djkl/8dJTyNtoZ2GEzuDNsgL+1QnznsGEaUPmd
         hI/Wx0rI+ok3dilC92cFjyywXwvC2ZnFtxAk6kzYUmKW8BkSaWjX9yB8aSNzhpreN8OW
         CCHpt8Qmi6S9Q5mLeTQZgKbQ40WAZ8fR2F+VZfC9fZiwyRYm5wP1L3dYG8HyAAvENnZG
         1kkQ==
X-Gm-Message-State: AOJu0YzKM2hYJZp467zaQfdz4t8uxmT/EJRZ+fR0MYAiN9GSZIgeOxqF
        Jqqfm4ujmecZErDw9jKknyfSN8iFl+rbQ7pWtm4=
X-Google-Smtp-Source: AGHT+IGJXHhBOUTVGCeeiEOn2js4InfzSyxZIwh2hBBvYmWwgDTWI6octp0dURI2oWFYuqtzBpHx3gdNmZPVQNUPUmE=
X-Received: by 2002:a05:6870:424c:b0:1be:c688:1cc with SMTP id
 v12-20020a056870424c00b001bec68801ccmr8400287oac.5.1692035605733; Mon, 14 Aug
 2023 10:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230731093009.3243-1-sunran001@208suo.com>
In-Reply-To: <20230731093009.3243-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Aug 2023 13:53:14 -0400
Message-ID: <CADnq5_Mmzv0-UmRX5fowsg6AOBmBvsWPjm2FSHmxL4oLF_MVDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in amdgpu_smu.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 31, 2023 at 5:30=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following enum go on the same line
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 36 +++++++------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..190a90b24d74 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -200,29 +200,25 @@ struct smu_power_state {
>         struct smu_hw_power_state                     hardware;
>  };
>
> -enum smu_power_src_type
> -{
> +enum smu_power_src_type {
>         SMU_POWER_SOURCE_AC,
>         SMU_POWER_SOURCE_DC,
>         SMU_POWER_SOURCE_COUNT,
>  };
>
> -enum smu_ppt_limit_type
> -{
> +enum smu_ppt_limit_type {
>         SMU_DEFAULT_PPT_LIMIT =3D 0,
>         SMU_FAST_PPT_LIMIT,
>  };
>
> -enum smu_ppt_limit_level
> -{
> +enum smu_ppt_limit_level {
>         SMU_PPT_LIMIT_MIN =3D -1,
>         SMU_PPT_LIMIT_CURRENT,
>         SMU_PPT_LIMIT_DEFAULT,
>         SMU_PPT_LIMIT_MAX,
>  };
>
> -enum smu_memory_pool_size
> -{
> +enum smu_memory_pool_size {
>      SMU_MEMORY_POOL_SIZE_ZERO   =3D 0,
>      SMU_MEMORY_POOL_SIZE_256_MB =3D 0x10000000,
>      SMU_MEMORY_POOL_SIZE_512_MB =3D 0x20000000,
> @@ -282,8 +278,7 @@ struct smu_clock_info {
>         uint32_t max_bus_bandwidth;
>  };
>
> -struct smu_bios_boot_up_values
> -{
> +struct smu_bios_boot_up_values {
>         uint32_t                        revision;
>         uint32_t                        gfxclk;
>         uint32_t                        uclk;
> @@ -305,8 +300,7 @@ struct smu_bios_boot_up_values
>         uint32_t                        firmware_caps;
>  };
>
> -enum smu_table_id
> -{
> +enum smu_table_id {
>         SMU_TABLE_PPTABLE =3D 0,
>         SMU_TABLE_WATERMARKS,
>         SMU_TABLE_CUSTOM_DPM,
> @@ -326,8 +320,7 @@ enum smu_table_id
>         SMU_TABLE_COUNT,
>  };
>
> -struct smu_table_context
> -{
> +struct smu_table_context {
>         void                            *power_play_table;
>         uint32_t                        power_play_table_size;
>         void                            *hardcode_pptable;
> @@ -390,8 +383,7 @@ struct smu_power_context {
>  };
>
>  #define SMU_FEATURE_MAX        (64)
> -struct smu_feature
> -{
> +struct smu_feature {
>         uint32_t feature_num;
>         DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
>         DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
> @@ -416,21 +408,18 @@ struct mclock_latency_table {
>         struct mclk_latency_entries  entries[MAX_REGULAR_DPM_NUM];
>  };
>
> -enum smu_reset_mode
> -{
> +enum smu_reset_mode {
>      SMU_RESET_MODE_0,
>      SMU_RESET_MODE_1,
>      SMU_RESET_MODE_2,
>  };
>
> -enum smu_baco_state
> -{
> +enum smu_baco_state {
>         SMU_BACO_STATE_ENTER =3D 0,
>         SMU_BACO_STATE_EXIT,
>  };
>
> -struct smu_baco_context
> -{
> +struct smu_baco_context {
>         uint32_t state;
>         bool platform_support;
>         bool maco_support;
> @@ -478,8 +467,7 @@ struct stb_context {
>
>  #define WORKLOAD_POLICY_MAX 7
>
> -struct smu_context
> -{
> +struct smu_context {
>         struct amdgpu_device            *adev;
>         struct amdgpu_irq_src           irq_source;
>
> --
> 2.17.1
>
