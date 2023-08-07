Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B77B772C73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHGROh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHGROf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:14:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E1919A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:14:07 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9cf1997c4so3945949a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428446; x=1692033246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EBbZKi3RkEqdqagrdNXc65Wt2bOkGGaDnR6Sxbz/TU=;
        b=Qk5swv/rGyqvsGjlOFfJ0Eay/dnLGQMDdxpB7Z+8yqfQuDyGpSyqB6bDT158gP1Njg
         /GG+KK2Js0vHJmMHmMKKQN8IRMf6wGIbPw5z29lUjzsavTXUyVPT0BLOQBDZ6Phtp5Er
         WMQdzQ4PcGeLGF+gEZyv6Q5JvvB00w5oYLzayYnDNtQ7AKKn9wBtlFLWCy+PJFmmYUcm
         sYZ2eV6JaCXSvGcsrlAUQRyEhNXq2g/zmmy0qkoX+WBiGn2vjBhmKXpdNQ9172k4wLj/
         8cM8GBR4uyZ02T7GkCJyNNNVpHdD46XUBb6B7hJ2D1Cpq0uekYwByOV98M+VNgwHtpQj
         Jodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428446; x=1692033246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EBbZKi3RkEqdqagrdNXc65Wt2bOkGGaDnR6Sxbz/TU=;
        b=cApHqgVBsdQcwPFQ6qCvDaUYW1N4NZtOXgbuZBNSqCYf+oWycUK/DvIMcQQeg2sGPw
         ZeGtbiG9YBiHw9T+5k9QDk1AAv4htouZbSMCOg0WhfY2aj0zTW2ODk9jzMJPg+NNvaPq
         sLncLPBcE2G3WYfkMolmT3Woxag8n7fuFkpJDbP8R7yfZrWLgsm5223sn3rtIOw0SaZ6
         Er2w9UJ0pjyOHGSOnKEX/nIgJtJzA5GERZ6m3s0VFGBM6SWB5Tui107kZD0Ast2KZM3E
         kblrpxihkj0OnlDA4eek5hyO4rtUqfJz5VkS2Khf77V4jGW7IXzj3ise2utlRFjJQhrK
         DJtQ==
X-Gm-Message-State: AOJu0YxL6+Js05UY/BN/rCOFP+yq8WgaLDovYupJKw7j1dGcCtFMeqJm
        yWDySSicBMdyQS8hxOVU9QtNQp7ehjoF991Q20c=
X-Google-Smtp-Source: AGHT+IFc0NAbYU5nU/5o1tjMWmuS8uQgHR8QgnNK+2Zu4oa67IfIMb8gua5e9zY5SdJnbhTMerc9FVwW6XDxVCPgFS8=
X-Received: by 2002:a05:6870:42d0:b0:1bb:84f4:d787 with SMTP id
 z16-20020a05687042d000b001bb84f4d787mr11938381oah.10.1691428446578; Mon, 07
 Aug 2023 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230802061423.11155-1-sunran001@208suo.com>
In-Reply-To: <20230802061423.11155-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:13:55 -0400
Message-ID: <CADnq5_Ob=reocYAdj8QhB03bREr-3xRY0uTt3EQtA3Ld-exBeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dc_stream.c
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

On Wed, Aug 2, 2023 at 2:14=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index ea3d4b328e8e..05bb23bc122d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -71,8 +71,7 @@ static bool dc_stream_construct(struct dc_stream_state =
*stream,
>
>         /* Copy audio modes */
>         /* TODO - Remove this translation */
> -       for (i =3D 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++=
)
> -       {
> +       for (i =3D 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++=
) {
>                 stream->audio_info.modes[i].channel_count =3D dc_sink_dat=
a->edid_caps.audio_modes[i].channel_count;
>                 stream->audio_info.modes[i].format_code =3D dc_sink_data-=
>edid_caps.audio_modes[i].format_code;
>                 stream->audio_info.modes[i].sample_rates.all =3D dc_sink_=
data->edid_caps.audio_modes[i].sample_rate;
> --
> 2.17.1
>
