Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62645760187
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGXVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGXVtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:49:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251F10EF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:49:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9b835d302so3016634a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235387; x=1690840187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JxNZk8MsPm0PckOwS8aqqo0tEETYMartUX8cUScZv8=;
        b=sNy0k9jVu5XXThEW87lo7iGgQec96HT5eqtk7ZO4iOPcVT/rw22tK5w2E6TVRPIRq4
         0ozNHkWU/koSWcd6ZBb9QdtYXHX6UsYdumyrQEJ7+5z3+J+vrlgHQWwyF1IDE+9ks9F5
         5n6H2SkNJyCk+UCDlRAmo/hrUsIgT4mqxlPxJqWEYVUYecDNAdFFenUfrCVqTyIoYxeS
         /DucwDuBJTsiUNeTLhTlyMxCrfkTi5BAIxC8Qsds8+gyYR6H0onJECKKDcDWfNGIcOGI
         k8outEnb27us/xzGcHi3iHf+/NwZn/XU4QMlWbfP7Pa/g5upGjqGacpTI2lGTZ1iQD+R
         V9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235387; x=1690840187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JxNZk8MsPm0PckOwS8aqqo0tEETYMartUX8cUScZv8=;
        b=kH7WQQwocOUPQl+9S97eP9Mat+R5YWn17aWd6quAEhpT5ip7W8eSQxcrQMBe6pcCA2
         oeiovrJsUvL9ls49L8FeFOghJuquiu3A5KlskRkCl3IwCoSZJy82Ny/uXsVffgZPd7az
         7YcbQK8xNPu38JxQRwVZMUvrgWMiple8AqfcMyAgPStR+Hnp3LABm0ja4QrIdKFlF/4F
         LnCz2Sy3ByhlOJ9N1QasqqJwWAFqDOn7Vn3O1FwMgqji4Q29d/vXVfLRGkqx7/nsUw81
         qwroVbj2BhjDeo2GtJmBbdz1ddo+FjozEyXo+UQNSNGnIhqxiG29rLkC0toxh3gRY7iH
         22rA==
X-Gm-Message-State: ABy/qLZE7pn5RU6P/tOBQV+C4qNErzR4HMIStMMNESLCK19U5YT2kX+K
        hAkqWLgEcnP6WNnJ4ywB6Iz9HEd/kKwsteCvrHeAhm3N
X-Google-Smtp-Source: APBJJlHgGu7y5V/waK8csJmAHmWEnUcjX+s8f1sx/0/l7z27nPCykhtSD7Eaus/nRGhYly6k7G2UxNqGngB7lLrOWlo=
X-Received: by 2002:a05:6830:1d4a:b0:6b9:b8fe:bf73 with SMTP id
 p10-20020a0568301d4a00b006b9b8febf73mr6263188oth.7.1690235387724; Mon, 24 Jul
 2023 14:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230724074800.9099-1-xujianghui@cdjrlc.com> <d6c3b91864b9f3f90d8a2d3cd952bada@208suo.com>
In-Reply-To: <d6c3b91864b9f3f90d8a2d3cd952bada@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:49:36 -0400
Message-ID: <CADnq5_PgmnmoNRoePzH1_DShKv8qJt8KVcZGGEqO+wu10VdYnA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in arcturus_ppt.c
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

Applied.  Thanks!

On Mon, Jul 24, 2023 at 3:49=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: "foo* bar" should be "foo *bar"
> ERROR: spaces required around that '=3D' (ctx:VxW)
> ERROR: space prohibited before that close parenthesis ')'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 3ecb900e6ecd..b26e9ac1ac30 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -691,7 +691,7 @@ int smu_cmn_feature_set_enabled(struct smu_context
> *smu,
>
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(fea)  #fea
> -static const char* __smu_feature_names[] =3D {
> +static const char *__smu_feature_names[] =3D {
>         SMU_FEATURE_MASKS
>   };
>
> @@ -927,7 +927,7 @@ int smu_cmn_get_metrics_table(struct smu_context
> *smu,
>                               void *metrics_table,
>                               bool bypass_cache)
>   {
> -       struct smu_table_context *smu_table=3D &smu->smu_table;
> +       struct smu_table_context *smu_table =3D &smu->smu_table;
>         uint32_t table_size =3D
>                 smu_table->tables[SMU_TABLE_SMU_METRICS].size;
>         int ret =3D 0;
> @@ -969,7 +969,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table,
> uint8_t frev, uint8_t crev)
>         struct metrics_table_header *header =3D (struct metrics_table_hea=
der
> *)table;
>         uint16_t structure_size;
>
> -#define METRICS_VERSION(a, b)  ((a << 16) | b )
> +#define METRICS_VERSION(a, b)  ((a << 16) | b)
>
>         switch (METRICS_VERSION(frev, crev)) {
>         case METRICS_VERSION(1, 0):
