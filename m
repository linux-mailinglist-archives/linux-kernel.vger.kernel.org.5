Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17554772C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjHGRTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjHGRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:18:52 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E81BF7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:18:44 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56d8bc0d909so753694eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428724; x=1692033524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47Rr/3UghjkQtHtnUD+LxrBoaPTikVLYxh6ulykjDi4=;
        b=TXhdtRQx2FmIOpLDtEf2CxM8TfUx3IKKt43guRPsVD2I3e4VN3U1DDE6vxswepiKXP
         yGtAbi42pg1rMhZ9WzSDjb35zj1EfeEnluDaJXoCZlZ+Kb4BC9IzChR68EnOGYYU1YRk
         VaJ+VLFCKRH6wNX0aBWNept//AvlhiMtw8+yoo7czF8t4y7vULYHopiFRjN5Rf5DKjza
         caXIkPnUuPq6mlz9TfNqNx0EtoHC+7oejVkQPJ1VDo603Vi+IFDDOpQHbrdpjsUR5TP6
         rbIbxEuhlCrDMrK0eyPH7OKj1NPuAaZ3bBlsy5LWwk3rFYf4UIoUQpK4G6kOxSSd2KpS
         yMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428724; x=1692033524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47Rr/3UghjkQtHtnUD+LxrBoaPTikVLYxh6ulykjDi4=;
        b=T8ngcRKPKTen/X8g+zYhiz9H5N00nr2NuMJKrAtr1lN2Dw+6RqaAyA9V+iSvc9D0ng
         CR0mxouumoGBqavOeaXVpQP3oMooDOwYMJZngVse5BY5p6Mq0hKVTWKp+vcSycuKCgYY
         Y1SJJQQO1dX0T+UIbrH+3GkF2f+DlSh3uvWtL9PE3Rqs+uNMFFNDrg5nTQfmAGJZ7fib
         OHqmvVkqSrNtzFgYaLnHUhPwXqlkJq3ZDpLtkhSUoTwout97+e+RcjW1F+Ocdy3zH+mA
         PyMprwUYpPSPtFTykenexcFCXH+aMMDHoGkcMUAIX+AjFSzBLYy0SurynxrTgzbypQq5
         NE0Q==
X-Gm-Message-State: AOJu0Yw+4pScc4sSSVPM1yqDW7+2Ofn0BPpwebwA30SoOQi06GbAGNGc
        K3JJhNsFaaLENaBlPtBqDI8WzAW0yxv8wYGkGMg=
X-Google-Smtp-Source: AGHT+IGoKOewF1vuvkvqzojnNhMFKp4viXf3zxLKQiaT0fZK5/PbD41GPWSxmCvC11eqAMgQJxf7OuNGuEVeUXHX33Q=
X-Received: by 2002:a4a:8554:0:b0:567:27f4:8c45 with SMTP id
 l20-20020a4a8554000000b0056727f48c45mr8880807ooh.8.1691428724196; Mon, 07 Aug
 2023 10:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230802064606.12005-1-sunran001@208suo.com>
In-Reply-To: <20230802064606.12005-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:18:33 -0400
Message-ID: <CADnq5_P6JgNkvrV69LDc7xcbOnLD9suUfdBnxK0NR+mHPLwyAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in vega20_ih.c
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

On Wed, Aug 2, 2023 at 2:46=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing statements should be on next line
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index 544ee55a22da..dbc99536440f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -500,7 +500,8 @@ static int vega20_ih_self_irq(struct amdgpu_device *a=
dev,
>         case 2:
>                 schedule_work(&adev->irq.ih2_work);
>                 break;
> -       default: break;
> +       default:
> +               break;
>         }
>         return 0;
>  }
> @@ -710,8 +711,7 @@ static void vega20_ih_set_interrupt_funcs(struct amdg=
pu_device *adev)
>         adev->irq.ih_funcs =3D &vega20_ih_funcs;
>  }
>
> -const struct amdgpu_ip_block_version vega20_ih_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version vega20_ih_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_IH,
>         .major =3D 4,
>         .minor =3D 2,
> --
> 2.17.1
>
