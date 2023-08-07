Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4D772BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHGQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjHGQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:57:58 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465AF1FEB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:57:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bc886d1504so4280710a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427451; x=1692032251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kh1xzBadLmh2qA8wkKzSd+vRAvsZi6LIWJNonqOAF4=;
        b=AINZ+DhsEQhQlmOljZ+xtGPGL0DytFbSQVnn73Q1Je/I5GOFflZx0PfcT8ncmMcq+3
         Z0OKGSaHziRAa+r+aSbsc17Kw8zVFenaJ2BGpA5KCKQyqCfeNm32zD26Oktr5hBxPOed
         O6xS+pdu1Hx+hPlizgIl5FFSYp1ykPSyA7HoxMpKEVcxg3mYY0vlJ7Wp97Ys0gUHcawW
         uQLcivNjmeyUjso4zBNZhTyC3S4A4BAB9dsOTJVemlBQkDVfVbCXbHmrG7++DuQaMECR
         WV3JngWAvz4SkVrQyXbDWr/CIx2OTiVltJcY/f/0XpCDq2/unP8kEPU6Zci8bPZD17zZ
         hDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427451; x=1692032251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kh1xzBadLmh2qA8wkKzSd+vRAvsZi6LIWJNonqOAF4=;
        b=a+6XoPSvJuSY+ULwj8qZxWm0tNPltATC2Wu5zmbckgFbDdtUQlvFRSS512wh/S8sJ3
         sHyLq9x5LEd1s+BuOU5hxVDBrwGfWLBmdDETpWRzkvzE9byXWNBttHfy2wZtSIx6wfec
         5sB7ukVHjzY1kYJypIRdclmyI2E0Pe13hiNjTB6+J62LSLutuciCs71RfE7oRmCHUAvy
         rhl+SM67PJYT9X3Zhhq4FUg7EcgEJWUVBebHsylb7+gd8Cv3i7LPoMYjlpZzoTptsxc7
         NH48a8SG2zjlVsxT1b2OTJCovXcmqBlzbgIXXVgH59hYwmtrekrYIHNT0bPL+U/A8Srn
         pbqw==
X-Gm-Message-State: AOJu0YwzfaBqauS7LfKZtL5JnqbBj5LlQRWp8w984W0awnOCfcnhAydV
        bWUZrSiS3dJZrgnn4sFIfEoOYJ9iCr5aY/FgCRY=
X-Google-Smtp-Source: AGHT+IFgIiyoPnCL1Z493bDNIEvDWWcfT8nAXm9S5Di6zVxHONd01uFMyhOHHiViiSNz2wtQ2zBhupM9zVUisfGmTUA=
X-Received: by 2002:a05:6870:a113:b0:1bb:8d8f:9c6e with SMTP id
 m19-20020a056870a11300b001bb8d8f9c6emr11573707oae.10.1691427451074; Mon, 07
 Aug 2023 09:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230802013118.8677-1-sunran001@208suo.com>
In-Reply-To: <20230802013118.8677-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:57:20 -0400
Message-ID: <CADnq5_PAxk1EvXnPMT2xVTFyC1E7f_ThtH_gqhKrM7H4v14a=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu7.h
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

On Tue, Aug 1, 2023 at 9:31=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h b/drivers/gpu/dr=
m/amd/pm/powerplay/inc/smu7.h
> index e14072d45918..bfce9087a47f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
> @@ -101,8 +101,7 @@
>  #define VR_SMIO_PATTERN_2        4
>  #define VR_STATIC_VOLTAGE        5
>
> -struct SMU7_PIDController
> -{
> +struct SMU7_PIDController {
>      uint32_t Ki;
>      int32_t LFWindupUL;
>      int32_t LFWindupLL;
> @@ -136,8 +135,7 @@ typedef struct SMU7_PIDController SMU7_PIDController;
>  #define SMU7_VCE_MCLK_HANDSHAKE_DISABLE                  0x00010000
>  #define SMU7_VCE_SCLK_HANDSHAKE_DISABLE                  0x00020000
>
> -struct SMU7_Firmware_Header
> -{
> +struct SMU7_Firmware_Header {
>      uint32_t Digest[5];
>      uint32_t Version;
>      uint32_t HeaderSize;
> --
> 2.17.1
>
