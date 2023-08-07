Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4A4772B41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHGQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjHGQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:41:14 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAD1100
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:41:12 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bca66e6c44so4062436a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426472; x=1692031272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX744ksRAmEB2v2LFFyLe06U3uCgrdtHOoMM/78k+Wc=;
        b=cZnexmh9fQVWZ9khuz+PAU8TeTeq25QZFx4DiE/RKo0hYnUD5kIjMl9MjMu9V33l4k
         36xQj3yvh9m6Y0AkYS+yM3wdNhL+cQ03mzP3bBj1GcnG0cZA36gRimxwQqQcaPdzA7jE
         cYRL0/DnTsST7u42ktbmYpyI1ik9k2rgEK9IqaFshKFBqcYD53jTqYKoB4/n+V+zKPue
         eO03F0Saw862kGqJMfxX1Uer9RO9CNaxh9un+/DurDLR1Khr8l/WRSTJbSZIgBkouvyC
         8zXkHV+tEaeVeWOLkmfbHgxHOoehcRXEjylnRI+pEamVEpr+UA61GkSQt0e8spBeu6WF
         jQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426472; x=1692031272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX744ksRAmEB2v2LFFyLe06U3uCgrdtHOoMM/78k+Wc=;
        b=S+VVIjk2pgF8O0X0Qqs7EJadcdd5gzS2EdcbhKBicnj0S/QI+yAseNhTIH9VX8JWC3
         EicLEyhhnRf4EpfSGVCw9bZQ468jLd2qG9xgbFVnaEJ3QsvZDbA0gKrdVYWF5tvVTeem
         4n30a0T2DeictVtFL1jEAC07I2q8UeA2bRF8AXiGMShMPlc2d5kD5qchobm0Q3gfZaaX
         g9CQxu+y3IFas8ZwEKPVq1zQBpPRpYLnwmbTSQBEMbLkfr3yBtwDVvRlWZL1Au8RlxZj
         cgqlmcWZD8+mgsiD9fV32cEV9yYcKdNxPW97OBmOf9/44itnlNrA/3JKkCcl+Rb5nHej
         lAeA==
X-Gm-Message-State: AOJu0YzUl16oOVWUnqewRuR1UXljH1J3g9HjgJCpGXHmecsoMWKqqFxx
        4PRJWBQldTF61GHze8xsW0LEVYBWp2sdiC0BQwI=
X-Google-Smtp-Source: AGHT+IF++/sSKVlLioAJq19YbZy4gat4ybxvqCv9EBBFQSz7GX0zsq7s8IFYUU5nuP/v/12NG7/4k2tOv5FGeAPGbeE=
X-Received: by 2002:a05:6870:8a28:b0:1bb:4ec1:50af with SMTP id
 p40-20020a0568708a2800b001bb4ec150afmr11767708oaq.4.1691426471339; Mon, 07
 Aug 2023 09:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230801092213.7360-1-sunran001@208suo.com>
In-Reply-To: <20230801092213.7360-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:41:00 -0400
Message-ID: <CADnq5_MOWKO0q=7+oVtqGbqreH-cpTMyK_PCY-4Dp4Z-wTi2cw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: Clean up errors in smu_helper.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:22=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited before that close parenthesis ')'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> index 2a75da1e9f03..83b3c9315143 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> @@ -194,7 +194,7 @@ int smu_set_watermarks_for_clocks_ranges(void *wt_tab=
le,
>  #define PHM_WAIT_INDIRECT_FIELD_UNEQUAL(hwmgr, port, reg, field, fieldva=
l)                          \
>                 PHM_WAIT_INDIRECT_REGISTER_UNEQUAL(hwmgr, port, reg, \
>                                 (fieldval) << PHM_FIELD_SHIFT(reg, field)=
, \
> -                                       PHM_FIELD_MASK(reg, field) )
> +                                       PHM_FIELD_MASK(reg, field))
>
>
>  #define PHM_WAIT_VFPF_INDIRECT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr,     \
> --
> 2.17.1
>
