Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C0772A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjHGQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjHGQWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:22:25 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7810DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:22:20 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56cb1e602e7so2880119eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425340; x=1692030140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUVPtQ4uffECPeWL3GR8MnvNWj95BmoZE6AwQJLdvYA=;
        b=JnhpwUbEwmaB1X5eMIa1H0Ttk0AcCLltM036ifUFbLvc6yGDivsEkCFumZISCdcDMQ
         AhQV9+qcbVwMEM03Pjgf1D2o1DLKUssmEsUOhimspCKQ6jDnv9JbmeNHT7lrn0ixFj/r
         HQclzQrXsdiftsx6b1pSUD9/R6NvZvwJiezg/6QBJkytuZ6q46c1ekYhW5aQ15ByKVHe
         3uIaTxEP8DV/s/yV9vbn1e+pFzKTEZaBGnekH11guLHmPJCZrf8SdadeGaxJN84+02wR
         2H0VsNVHdZ4frXhUXTbICU/4wu4ujQIoq7lOOL5gfuNkyxiE7CsiarObdDICNyXL7reA
         sAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425340; x=1692030140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUVPtQ4uffECPeWL3GR8MnvNWj95BmoZE6AwQJLdvYA=;
        b=O+FgSsjiXYOxk9s4R9Hm48KuAtDycb5MWxEqKXWxa83wCJkTHY5jNA+uEpY4yZG1Gf
         z47KuZghfG/IGVpPfJmDbwGGb4NV5M05Rk4sPEGSm8LQkuMyy4JFlB/DNKf6K9VrnGoR
         vQjxBuW+eY4u2tsS45aVNvaj/E2+UGDymsWbGuZQDzNx1WVRfSd/nIO4eGMEmAqp3OQV
         5vcmUzpSH8CgLI1TZgWcp2fDZ+fIG2DE1Ra8eXIXLB7hB150aC9txwqYcvrPdc136+m+
         yA63nhLR2YsT0pMIlFHyr/vquFedOZduHdt0VEn9Z64QLGpR30E8eon6WIZ7HXX7pLWO
         xNCA==
X-Gm-Message-State: AOJu0YyOCorMLEeXElr+N90jgCrU4bg1+ol8OavHmygX7UQAyCWK4+Wf
        AlQVC36W0sGgXjjtByqJ+w6rekba9fkZhIgC+Ds=
X-Google-Smtp-Source: AGHT+IFG0/Am3diUr/m2+r/PPuvSgAgvYLcl/89tTxa/yB4pEVFb/nj9I+lomFUljhKSdlsnRF0dCzxkTjpd/0TGMUs=
X-Received: by 2002:a05:6870:7010:b0:1bb:5480:4b4 with SMTP id
 u16-20020a056870701000b001bb548004b4mr11226715oae.8.1691425340185; Mon, 07
 Aug 2023 09:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230801020839.4369-1-sunran001@208suo.com>
In-Reply-To: <20230801020839.4369-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:22:09 -0400
Message-ID: <CADnq5_PYShAc4M47zrfbzv4FUe1oD8+k08Q4_oDPzp4xoE_eGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_5_ppt.c
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

On Mon, Jul 31, 2023 at 10:08=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited before that ',' (ctx:WxW)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index 42f110602eb1..87a79e6f983b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -75,7 +75,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_5_message_=
map[SMU_MSG_MAX_COUNT] =3D
>         MSG_MAP(SetDriverDramAddrHigh,            PPSMC_MSG_SetDriverDram=
AddrHigh,      1),
>         MSG_MAP(SetDriverDramAddrLow,          PPSMC_MSG_SetDriverDramAdd=
rLow,  1),
>         MSG_MAP(TransferTableSmu2Dram,           PPSMC_MSG_TransferTableS=
mu2Dram,               1),
> -       MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDr=
am2Smu ,       1),
> +       MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDr=
am2Smu,        1),
>         MSG_MAP(GetGfxclkFrequency,          PPSMC_MSG_GetGfxclkFrequency=
,      1),
>         MSG_MAP(GetEnabledSmuFeatures,           PPSMC_MSG_GetEnabledSmuF=
eatures,               1),
>         MSG_MAP(SetSoftMaxVcn,          PPSMC_MSG_SetSoftMaxVcn,        1=
),
> --
> 2.17.1
>
