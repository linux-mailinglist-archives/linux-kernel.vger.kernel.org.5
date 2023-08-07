Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F0772C79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjHGRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHGRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:15:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144419A2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:15:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9a2416b1cso4072416a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428517; x=1692033317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kFXDoHF7GQ9pqFFzxyYijKExHAUDXpf8bLNBIMwDQc=;
        b=j4omNGFfHvaJj3AnMmflJ8VRfcki1f4QtDauC81JM+6mpZqIjmSRLFdAJ6sCbCRglX
         cN37W4uaQFKQ/eK5tQ9P6W/89vbqENJteuDp1IgSM3HiHyrtnaITT0x8NUlkO+4JueNo
         idOJ/K9S+oDMT8ltHPmUVe3LRjYClIrVFih9B0+554N1Nc0EKktiSjkSrFfp/mz5wKZM
         Cm53anU91soLJFagVTuQOQZ3Bcp5BO4z1lQTTgdZA5j3yEtJQpgkOHe0rnJAU5cr4jlj
         B72dgfIj77DUl88zbwYqZp+p9tNuoz07zQJ4tnobJ6BTGbYLhfLfFlxtadlHID0gmoXN
         vXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428517; x=1692033317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kFXDoHF7GQ9pqFFzxyYijKExHAUDXpf8bLNBIMwDQc=;
        b=QFRvO5EI0ZQmJmAb6XGAfwfG6j8EwlKZA5QSC4Mj2VfyipuE1iVWeMFxJ4DxjrnZDa
         Rlzlc5aD+hUEuq60nsYepPYBG1sv8ybZeUtmZqCYt5TG/skmYN9JMGjmMZgJHx24Wis+
         krAotpGZ9OEPV6JepVEXmCTocWvrHDkmfd9qLmiw4WvSgEysJMUEHPU9FEzbEZZd6qze
         7+qu1dLp6boCqBy6DLRucO0xIrV2XFZ7XKIQqGyfRQyZ9vhgirEQDv4bLI2m2BtxqGuM
         7HSB2ZiPo68wbryXZAZd4v/D+goCeXn9cOI6dHTaTPKtMQd8gM8iIuOMOgP8vfl4Kozn
         1L2Q==
X-Gm-Message-State: AOJu0YyskxuSKAUNHAigxPPRFQXJ7jvVsn4uqCNbtrk0P+bKwGgLbINh
        taJvI6Ao0r9vbsu570hGbau/2veqXtMU+G84JK87DA/V
X-Google-Smtp-Source: AGHT+IHcvWbklkO9vjl1KqJpyj7I8Hljj5IDdhpuX3IRLnuKNb8XtBUIRPgPCQCqfMbxqlSjM0DOG2YxjYtujvCBJT0=
X-Received: by 2002:a05:6870:d154:b0:1be:f8d9:7bdd with SMTP id
 f20-20020a056870d15400b001bef8d97bddmr11390360oac.6.1691428516729; Mon, 07
 Aug 2023 10:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802062025.11332-1-sunran001@208suo.com>
In-Reply-To: <20230802062025.11332-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:15:05 -0400
Message-ID: <CADnq5_PFMaDMHX_VfpBAfVusz-8XPVu3C-WP9ugCrfDx1HbHrw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in display_mode_vba_30.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 2, 2023 at 2:20=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: else should follow close brace '}'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 9af1a43c042b..ad741a723c0e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -784,8 +784,7 @@ static unsigned int dscComputeDelay(enum output_forma=
t_class pixelFormat, enum o
>                 Delay =3D Delay + 1;
>                 //   sft
>                 Delay =3D Delay + 1;
> -       }
> -       else {
> +       } else {
>                 //   sfr
>                 Delay =3D Delay + 2;
>                 //   dsccif
> @@ -3489,8 +3488,7 @@ static double TruncToValidBPP(
>                 if (Format =3D=3D dm_n422) {
>                         MinDSCBPP =3D 7;
>                         MaxDSCBPP =3D 2 * DSCInputBitPerComponent - 1.0 /=
 16.0;
> -               }
> -               else {
> +               } else {
>                         MinDSCBPP =3D 8;
>                         MaxDSCBPP =3D 3 * DSCInputBitPerComponent - 1.0 /=
 16.0;
>                 }
> --
> 2.17.1
>
