Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF42A772CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjHGRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHGRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:30:46 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1989F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:30:45 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bba254a7d4so3728674fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429444; x=1692034244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eZYdmrjAP5EddhK/TydIBrWHOpUy2tMR3k7Eu28CYk=;
        b=sIp4cWE5E3ZUVbnRwYtZBltpvrR15qc7USeqwZdtG5tHnasnq6srmO6P4PErTH0OaE
         CiaD2iA8XvY23Oxy98c24QfUDH0pluFraH4/EZfCcXkjx72qY2NJVrmvIIE5T6reFAgk
         L2A+7LEt2DlQczPtC5L7EdTa7MLXcnt5xoj//Wzan7wYwZk7SFVhdoxGUKaRTM3WdK5G
         9GbYdRWDQHMtXvQy0K5DDILh4ldmfbPQnlU4z+QH0fMstmdSZfDu0zVUONOWQWxE/HGS
         NMNZHEiepso6Ld90bkyc3W1P6OSsEx3ICbSxAJdXmZpOLHz3qX7kMvX84spRdwO8JES5
         GaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429444; x=1692034244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eZYdmrjAP5EddhK/TydIBrWHOpUy2tMR3k7Eu28CYk=;
        b=YCeESfmnBBzwy3mDq7PLhLVhUoi/S1krz3pXk+ETeCgdaGL5K+ORepNXvdLpvacrtS
         AA3cKmM1j0VQSKkhmdoZU+PBDY+mwtriMjiMQaBch4HUBWGp0vhWi9RG4xH2Z7Z30cbZ
         hmOvvedVz4bBSx1Tnozkcb2hAKrHN+ofehtOBOQhQbwuEnyg6lBdPj7gEPYow1q0F8Wi
         7JIoE4kuFdc5DisHKCuHZKCbVvoTxoqoESG+QMe5oBz3Tbj6+RspSv25dJhex6UqnYcs
         CLkPrl9dIpp8byoDT2mg0kiSH+l3MOCTmB28sZZ6TJAuvvVCKZnWjJs38iwSVGCzZKnW
         Cjxg==
X-Gm-Message-State: AOJu0YxKFzNNjggl1yyALJdFQqMilXPxFw0kBc4KXqSqBzUFOGBIyS+m
        XCQUbuNE53xAfyLd/cmC76BM7awYa2QlkgZxKyiHkBsr
X-Google-Smtp-Source: AGHT+IGDHPNaPPiohwJKBgOo50isGGbZwLzfB6fU3qc7nO5Hd1NEo8h/7Goesn/N9+Q6Gw0yE1WYUMWdJFcSp0+ZRJA=
X-Received: by 2002:a05:6870:d252:b0:1bf:5e6c:ce72 with SMTP id
 h18-20020a056870d25200b001bf5e6cce72mr13336767oac.53.1691429444578; Mon, 07
 Aug 2023 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230802073542.13515-1-sunran001@208suo.com>
In-Reply-To: <20230802073542.13515-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:30:33 -0400
Message-ID: <CADnq5_MjuJVSYdTU+irpko9AkNerY-YaaaDDc94QAEVTUPGkuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in mxgpu_vi.c
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

On Wed, Aug 2, 2023 at 3:35=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that '-=3D' (ctx:WxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_vi.c
> index 288c414babdf..59f53c743362 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -334,7 +334,7 @@ static void xgpu_vi_mailbox_send_ack(struct amdgpu_de=
vice *adev)
>                         break;
>                 }
>                 mdelay(1);
> -               timeout -=3D1;
> +               timeout -=3D 1;
>
>                 reg =3D RREG32_NO_KIQ(mmMAILBOX_CONTROL);
>         }
> --
> 2.17.1
>
