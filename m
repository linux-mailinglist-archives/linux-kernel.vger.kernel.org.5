Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF0772C1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjHGRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGRJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFA1A3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:09:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bca3311b4fso3763121a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428174; x=1692032974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jIgVnoueyGuoTJM9oRGaL0Z4KOks1NDKm3coM6a4k4=;
        b=WU6FhVPUk+c9/0ssmY04UuJ0eweh00NYg8GTji8wHIwKHCVTvv0c2zK1Ug/ujUD6gz
         AnmiDqgBtEyqV4LjOVhMKfL++6kaQljSu6h6VuRc8fgcNqR9iGqBBI98eJESYSCoYxAS
         cP9ZGSIxQjq6IWEArJc6sgnmEymepDhcI2SRsDtJWhZ1MKR3dNWIvSJeHWTUk1SsCjm2
         6KLddPTGeqcsV9V6RHHKDG0YeKXXyJSLRCsoz0kLDObdZcgp+8f0dSBAbjkvvD5Q8QR8
         lYPIHBcFrqIX2DGA1WAb1jluI3jhhlNvZrvmIOeqQOZnHoGJ23J08irJ5dDYO/F6XJJt
         9F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428174; x=1692032974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jIgVnoueyGuoTJM9oRGaL0Z4KOks1NDKm3coM6a4k4=;
        b=Zg0Edk9Niu8R3OfD1Sd9C/NVSf/giyLVTYwu++1d7IwLrjMxlxirTQMtZ9mkdu2425
         De8QS5ly6CvAX1AUVMZGnLSYy6DcS6wjFkBwyFPIUpLsVWhJ6ZQJ8Bj8dg75f7+K0LH9
         5DFlyWKaJNzr0rrfKusCm586FDrvVMdnjqwqGXgjfI9CiebgToBlnnxlEfgUPF2Qa6AS
         9FBj+nOwTe2Zzd/MSlnoV63K5Zb/kfuZuqOqh4lS77EV6hfBFiz6dLf3kAxn5lfAZ1ey
         D6MMTa5rRdkovbxn+kgRvS7W6Ff2iDKWtH4lKgDlYEsv7mXvw0CIWa8kbEFpfVv8+FEU
         4AGA==
X-Gm-Message-State: AOJu0Yz/GyhIXrHrYvcOyoJaXWICuCxgQtNFUVME1hFzaBrvidgo1D8Z
        23/ZNzgp/IW2Qf9DJykmOoH8JMqSseu9Y7oAjRA=
X-Google-Smtp-Source: AGHT+IHLqGTWbZFxEncDmX3IyGHP0JHruWCMeH47oijw9u9DKLK1nQkjNfF5H4s2S7coBzII3b1PGff7l0Fpo5resTI=
X-Received: by 2002:a4a:d2dd:0:b0:56c:7120:8363 with SMTP id
 j29-20020a4ad2dd000000b0056c71208363mr9754624oos.5.1691428174605; Mon, 07 Aug
 2023 10:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230802025327.10370-1-sunran001@208suo.com>
In-Reply-To: <20230802025327.10370-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:09:23 -0400
Message-ID: <CADnq5_NAFjCLPr-6k7mn_G6TwiYgTTrYGZx-Xn2oqvcd6uaG2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dce110_hw_sequencer.c
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

On Tue, Aug 1, 2023 at 10:53=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open brace '{'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 20d4d08a6a2f..7f306d979c63 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -219,7 +219,7 @@ static bool dce110_enable_display_power_gating(
>         if (controller_id =3D=3D underlay_idx)
>                 controller_id =3D CONTROLLER_ID_UNDERLAY0 - 1;
>
> -       if (power_gating !=3D PIPE_GATING_CONTROL_INIT || controller_id =
=3D=3D 0){
> +       if (power_gating !=3D PIPE_GATING_CONTROL_INIT || controller_id =
=3D=3D 0) {
>
>                 bp_result =3D dcb->funcs->enable_disp_power_gating(
>                                                 dcb, controller_id + 1, c=
ntl);
> --
> 2.17.1
>
