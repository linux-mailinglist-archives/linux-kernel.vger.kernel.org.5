Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D169772AE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHGQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHGQcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:32:45 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD421BEA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:32:26 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a1fa977667so3589148fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425945; x=1692030745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygTIUkZv7ZsC1Ak6vtB58w1LRxko3ruoE1DG7vp7o7g=;
        b=LAXiJfRVuW487oHewQhGBJPinFMxMoTRw/6b/moPXJpsf1IV75KV9K92HO/autzoOR
         rRg0qd7U7Rch7Wyf05kMunfAcflWrTpZGS9VV080lDEDu+ZywvmMy7A8gT0slXNWrPOe
         VGhzlgOl2baKd3H6Y0Dqk1IvndoCx0uzmJ5fYVvf10TVZ9mIbR3WgwKEoIf15uhtr396
         g8OpYuIEtz1oW37MOQbIRoZUsuF9g6VwQHNKQpH0H2IF/L9A0cZ6mmMT9DXr5lwXXGXT
         dmvkYZG6pmghrVNBKPdjcPL8+A5MZfAaP7jF0+JZrPvfYJvw9ZtPhd8VI7tmcNLTh3A6
         Xl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425945; x=1692030745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygTIUkZv7ZsC1Ak6vtB58w1LRxko3ruoE1DG7vp7o7g=;
        b=bVb8N90GS0XiX/v+U07wnG+9CZhqw1rAPqcexl9x9o6jJDgFO+V6MYeqduT4/sUt90
         8QkxsjzMVi95UrPTWExxsAHTNmo+dOVHvHWNie9K5QVr3pR+EmfH3ZAHUx2lvwqYHLGV
         ddYb0e8CgR6Pjo4FX6XtkwDmL+tLpx6bd4npHBElcD+XLT/t74+VyQH1EhPxLqlMMRzI
         IK8tBzf2Bl8uw8GTfFodIQdqUzx9ThOwDdNWoQP2MSofRmeDd0k4LWCGZ4dhwVTTNQy+
         qUBxWvbJtfe21ejCxt3a15dMabeYxrZwVrTcu4iLAlSbAKbFxNuobBQLEFtF4mA/xMbJ
         3Xmw==
X-Gm-Message-State: AOJu0Yy+MQWLKnkQtPj1aNGXV3YCqy/x0zrClXgK6Q7jKLZv8zD6jI55
        wAKN3Vp4e4xepbSo0gsjXRbNtq0F9q+F0n1CHQhxgnu3
X-Google-Smtp-Source: AGHT+IFADLzDrmJBNqD0h6jZKZIbu6BHvz8y++9SQhxMWpdkTVMzHfELTGfP1WMkMgGjfOdSRul6Lm9Zr3/E55f5C9o=
X-Received: by 2002:a05:6870:8294:b0:1bb:8333:ab8a with SMTP id
 q20-20020a056870829400b001bb8333ab8amr10538221oae.4.1691425945123; Mon, 07
 Aug 2023 09:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230801055826.6000-1-sunran001@208suo.com>
In-Reply-To: <20230801055826.6000-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:32:14 -0400
Message-ID: <CADnq5_PJZ-vS+p8ky1C2LFPEfp6bVfTMveL7wFeKKytwvqePgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega10_hwmgr.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

This one doesn't apply due to whitespace differences.

Alex

On Tue, Aug 1, 2023 at 1:58=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing statements should be on next line
> ERROR: space required before the open brace '{'
> ERROR: space required before the open parenthesis '('
> ERROR: space required after that ',' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 08518bc1cbbe..ba7294daddfe 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -670,17 +670,23 @@ static int vega10_patch_voltage_dependency_tables_w=
ith_lookup_table(
>         for (i =3D 0; i < 6; i++) {
>                 struct phm_ppt_v1_clock_voltage_dependency_table *vdt;
>                 switch (i) {
> -               case 0: vdt =3D table_info->vdd_dep_on_socclk;
> +               case 0:
> +                       vdt =3D table_info->vdd_dep_on_socclk;
>                         break;
> -               case 1: vdt =3D table_info->vdd_dep_on_sclk;
> +               case 1:
> +                       vdt =3D table_info->vdd_dep_on_sclk;
>                         break;
> -               case 2: vdt =3D table_info->vdd_dep_on_dcefclk;
> +               case 2:
> +                       vdt =3D table_info->vdd_dep_on_dcefclk;
>                         break;
> -               case 3: vdt =3D table_info->vdd_dep_on_pixclk;
> +               case 3:
> +                       vdt =3D table_info->vdd_dep_on_pixclk;
>                         break;
> -               case 4: vdt =3D table_info->vdd_dep_on_dispclk;
> +               case 4:
> +                       vdt =3D table_info->vdd_dep_on_dispclk;
>                         break;
> -               case 5: vdt =3D table_info->vdd_dep_on_phyclk;
> +               case 5:
> +                       vdt =3D table_info->vdd_dep_on_phyclk;
>                         break;
>                 }
>
> --
> 2.17.1
>
