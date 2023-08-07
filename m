Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E642772C10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjHGRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjHGRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:08:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9696FB1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:08:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bc9254a1baso3866450a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428107; x=1692032907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdH85ugcEgXLHyGrQRpZvP78lrIUwr56Sl8IQ0GRO88=;
        b=Ka+wLc1EWmyXGz8qPF+rmM2i6oBNtNMsELdKHf7S1L7UP7AalgAReU0XQ57ZWdIXH5
         BoLdcfAdYMK8kw06KcnIPL4zPRCTRDmH6zyBgc6hu7uTD0eUv2ZbWsldY9HZnEhN4x2z
         i0ESleSHM/LUMFGIf1/qiV6vQJk3amS+RKT3qh2yOHtLM8uONwYxMIJoDJ606Q3gsAAr
         wneVxQvL+u1Uh2fOCN2aajnaPXOsVTG6Na0BnGPvORO3nX+au8nPVuUC3LMc09DP6cbz
         4NfLjrD7DYeTn0LKmgtT+SBCKn9+L9+0KChOfEfCPin8XngNTE+s0LqXTjOvi5DVxRLi
         6zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428107; x=1692032907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdH85ugcEgXLHyGrQRpZvP78lrIUwr56Sl8IQ0GRO88=;
        b=V9C9IdEJtLJcZbCfNR0EIKUIAcfkcyA6jdnfI2PQqROjEWHiMBcSzoSsAG5ar9CHEM
         Y4sF6jHTsUu74ldsjSnGBwQci+Vij3USK+wEa5iT6yMDpfuvhVmAlgaMY0bPxVUbnjNw
         Ojkk/7hE+W0RV2lFb0Ua6lffQOlGCDrTLVF3W+URhPycg9LU4angG9zKYcrDDRXSzB+2
         SKHHHSIGad94RSPG2oFN1mWWxBgKCVL4d26hDlY9j/whgAKFVcsqh1LSAR6GnNxL0EfC
         nrls5z6jpyzr6SDtJ/u045TZZZ+OxUTzVBGxIA59yi+KWMbqFylzYF4691VopRIwqbVT
         pisg==
X-Gm-Message-State: AOJu0YxXe15Rhkom8FfAEYXBLMvcgzwaJLJ+NcdpMWq9K3+7zE2hj8yJ
        2mfbwgfGr4TBWjDfCRZ7vsK9MZ20unnW/qtqcM9C+SqE
X-Google-Smtp-Source: AGHT+IFg0f4fC0DsVOgW1GBDh+CWQNIFu6A8Is4zKYRgHi2S1GQnxQZp2dxCuhh5Uh404vG5UVZ0XtmAnHoqib//q4E=
X-Received: by 2002:a05:6870:c0c9:b0:1be:f7d8:e7af with SMTP id
 e9-20020a056870c0c900b001bef7d8e7afmr11024744oad.39.1691428106950; Mon, 07
 Aug 2023 10:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230802024725.10192-1-sunran001@208suo.com>
In-Reply-To: <20230802024725.10192-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:08:15 -0400
Message-ID: <CADnq5_Pb9yEKSTaA1hTM1G5yLjCa5QeDKmB7BdbJykVyK9XTdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/dc: Clean up errors in hpd_regs.h
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

On Tue, Aug 1, 2023 at 10:47=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required after that ',' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h b/drivers/gpu=
/drm/amd/display/dc/gpio/hpd_regs.h
> index dcfdd71b2304..debb363cfcf4 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hpd_regs.h
> @@ -36,17 +36,17 @@
>  #define ONE_MORE_5 6
>
>
> -#define HPD_GPIO_REG_LIST_ENTRY(type,cd,id) \
> +#define HPD_GPIO_REG_LIST_ENTRY(type, cd, id) \
>         .type ## _reg =3D  REG(DC_GPIO_HPD_## type),\
>         .type ## _mask =3D  DC_GPIO_HPD_ ## type ## __DC_GPIO_HPD ## id #=
# _ ## type ## _MASK,\
>         .type ## _shift =3D DC_GPIO_HPD_ ## type ## __DC_GPIO_HPD ## id #=
# _ ## type ## __SHIFT
>
>  #define HPD_GPIO_REG_LIST(id) \
>         {\
> -       HPD_GPIO_REG_LIST_ENTRY(MASK,cd,id),\
> -       HPD_GPIO_REG_LIST_ENTRY(A,cd,id),\
> -       HPD_GPIO_REG_LIST_ENTRY(EN,cd,id),\
> -       HPD_GPIO_REG_LIST_ENTRY(Y,cd,id)\
> +       HPD_GPIO_REG_LIST_ENTRY(MASK, cd, id),\
> +       HPD_GPIO_REG_LIST_ENTRY(A, cd, id),\
> +       HPD_GPIO_REG_LIST_ENTRY(EN, cd, id),\
> +       HPD_GPIO_REG_LIST_ENTRY(Y, cd, id)\
>         }
>
>  #define HPD_REG_LIST(id) \
> --
> 2.17.1
>
