Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED66772C71
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHGROQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjHGROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:14:11 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DBE1FEB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:13:48 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bed90ee8b7so2683150fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428413; x=1692033213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNT2pPzXo/+0oZm3DAtNl1Zdp8iCzJdD2Cg8qDW5Fmc=;
        b=Sau5uY4A4SOGreJsBXpdzR0RFtMroS+Xw/+Dd2z/O2K7zss8phvshitDjUeP4uIwfh
         BsbzhMeT7vsslDRSoCacSCa+ovbnQlw8rBoXC7K0wP+Wy+1KI7q09Sf6LS+vm4ulke3O
         sxUFFmnLuLY871Ai+1BlzRHBxCGAmIsVSMt7LYSjy0nv8uswR5JEG07J0g3YBVq3bsze
         ctrP5wRMQwzyLdIiJ0LW/P1+JRc53bp8m3qHcw3Z8er45mGugQnf4BMUthx8gQWffOf6
         VYgIRSicd50rPgSqTM80X4YUl82qfBzE3xs+dJlKf1EPYcS1adX+hOjfXwV6B2I58kg3
         uN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428413; x=1692033213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNT2pPzXo/+0oZm3DAtNl1Zdp8iCzJdD2Cg8qDW5Fmc=;
        b=dfCBm/O53ll7YSgxcAskoPBwCyCDdKlXZBFSs7MpFguv6v64HF6HKtffxWvIEbf5QX
         0zPk9ISn1G0m0yRV38jyMRKA94RwW5GMFL+MRafQE3p6Wll83id5vm5f+fuBBedpt5GT
         053GzROfliBuyl+oa4QOUmrToojMaWvAcK5fxlAgCTbpdVZGH+bB3EFdsIwgivfsFd5O
         5JhEaSqr0zzpLoreBbkXrA8E1I/zj3dI5XFNAsKdfTg+HuGZKeYIIBXu/Xez3BPBqbf3
         JNw2q28MchCt4USlLvKql1iIr+FknvyKjt+ZuWJGiaDazL0HuXVfkYI9XRaUG85KZBOg
         /zQA==
X-Gm-Message-State: AOJu0Yzq9rE+Upy+qVlTMHRN6AwBR5NQfX31ajIvBmhPed/9ty6tGuyf
        +x25PXgzOvO3GjjhLdsp8tE8oqcRMsR54q3oPmRQHSN+
X-Google-Smtp-Source: AGHT+IGS0Hk2RkjYc2XJl6PanoOJZBzzEKeL5gjMguhmRAjwN/TWLHSj1ySl0gMy7ZRMsLbC9a0Re42pzE3JGeNmyzo=
X-Received: by 2002:a05:6870:148f:b0:1bb:c946:b80e with SMTP id
 k15-20020a056870148f00b001bbc946b80emr9826593oab.28.1691428412855; Mon, 07
 Aug 2023 10:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230802032256.10846-1-sunran001@208suo.com>
In-Reply-To: <20230802032256.10846-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:13:22 -0400
Message-ID: <CADnq5_O5FY_eYetryQ47FRwhh4-w=ifakZy0GNkvswQccuef2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in bios_parser2.c
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

As a follow up patch, care to drop the break statements after a return?

On Tue, Aug 1, 2023 at 11:23=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: switch and case should be at the same indent
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/display/dc/bios/bios_parser2.c    | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers=
/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 540d19efad8f..033ce2638eb2 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -772,20 +772,20 @@ static enum bp_result bios_parser_get_device_tag(
>                 return BP_RESULT_BADINPUT;
>
>         switch (bp->object_info_tbl.revision.minor) {
> -           case 4:
> -           default:
> +       case 4:
> +       default:
>                 /* getBiosObject will return MXM object */
> -               object =3D get_bios_object(bp, connector_object_id);
> +               object =3D get_bios_object(bp, connector_object_id);
>
>                 if (!object) {
>                         BREAK_TO_DEBUGGER(); /* Invalid object id */
>                         return BP_RESULT_BADINPUT;
>                 }
>
> -               info->acpi_device =3D 0; /* BIOS no longer provides this =
*/
> -               info->dev_id =3D device_type_from_device_id(object->devic=
e_tag);
> -               break;
> -           case 5:
> +               info->acpi_device =3D 0; /* BIOS no longer provides this =
*/
> +               info->dev_id =3D device_type_from_device_id(object->devic=
e_tag);
> +               break;
> +       case 5:
>                 object_path_v3 =3D get_bios_object_from_path_v3(bp, conne=
ctor_object_id);
>
>                 if (!object_path_v3) {
> @@ -1580,13 +1580,13 @@ static bool bios_parser_is_device_id_supported(
>         uint32_t mask =3D get_support_mask_for_device_id(id);
>
>         switch (bp->object_info_tbl.revision.minor) {
> -           case 4:
> -           default:
> -               return (le16_to_cpu(bp->object_info_tbl.v1_4->supportedde=
vices) & mask) !=3D 0;
> -                       break;
> -           case 5:
> -                       return (le16_to_cpu(bp->object_info_tbl.v1_5->sup=
porteddevices) & mask) !=3D 0;
> -                       break;
> +       case 4:
> +       default:
> +               return (le16_to_cpu(bp->object_info_tbl.v1_4->supportedde=
vices) & mask) !=3D 0;
> +               break;
> +       case 5:
> +               return (le16_to_cpu(bp->object_info_tbl.v1_5->supportedde=
vices) & mask) !=3D 0;
> +               break;
>         }
>
>         return false;
> @@ -1755,7 +1755,7 @@ static enum bp_result bios_parser_get_firmware_info=
(
>                         case 2:
>                         case 3:
>                                 result =3D get_firmware_info_v3_2(bp, inf=
o);
> -                                break;
> +                       break;
>                         case 4:
>                                 result =3D get_firmware_info_v3_4(bp, inf=
o);
>                                 break;
> @@ -2225,7 +2225,7 @@ static enum bp_result bios_parser_get_disp_connecto=
r_caps_info(
>                 return BP_RESULT_BADINPUT;
>
>         switch (bp->object_info_tbl.revision.minor) {
> -           case 4:
> +       case 4:
>             default:
>                     object =3D get_bios_object(bp, object_id);
>
> --
> 2.17.1
>
