Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0889A772D10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjHGRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHGRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:33:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A83D9F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:33:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1ebb85f99so4079725b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429630; x=1692034430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Xgnz7mlTNaIdh0IQghOP6QiClppwV7KNLYC2hrQ44c=;
        b=QPZZdCl+yIUJyB11mddD06BONdKoecQPaEP9meDsWe2HbjDlBALihWQ4wMNJ7FoIz1
         SQz3GbST9klBEdZ0nuYgVb3lBXEOFoBeNLSPG/M8wVoy0/B8fRmiRMuWrYjHSZ4Z7zlg
         TIKT1BQu0vFEXl46H7x5/YZ5tA5bhqJtArOU/pROsUWre5q+2u6RfXdx0yw0OOFPABuF
         Xem/F4Gqkvpur33XGzEI5spVd3kVX/AT2jkwK734EfSQ6iuPJgs1ksvXc+u5AkyDALYz
         4XXBL3B1shhfcVuLBt1JqhWB3hrwXWhfOaK8j5p3N3qZhhoyDuf37hBpU1ZxuPgv4D0X
         SpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429630; x=1692034430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Xgnz7mlTNaIdh0IQghOP6QiClppwV7KNLYC2hrQ44c=;
        b=P7x0bVldtwX0yzLzf8ZZGlILC+NnCu4pDhqi/JIVTXK1rvdHOQxBzY48y5Nl7eBw4j
         OttMBxspX+RIhypbl3OSw1pwlqyc5a0fEDx8aQ46Hfe1lNfAbQnbgFWrxdAWDe0woQ8r
         u7rAwOX4PSW6R+YIGyvqIGqCNx+z8cCEVebsuXedjM084A3b3rDOQ6F49ys4rpDn+m4w
         lWoxr4dgbRG9V94/uY77xkdAwfaDihqxsnK59i7MCnHYDF3lHUi0JsyZUKKIaoDSWh/I
         AnI0SmDIYetKxQBGsApHwkJlQaJGDO9e9/GfpKHuRSATU3DI1z4J1vV0jMKur8L7l17i
         8jcQ==
X-Gm-Message-State: AOJu0YxiCTwI776MhnyGCHwyQ/BmGt5b30xJIEc9TPSrnAcAGFjDBsSp
        tCUiFzMRSYMnm9CBJeixk31UZidVTq+y06W2DkKhOgSX
X-Google-Smtp-Source: AGHT+IGB/gO1axOANy6aP1Itgk+YXBFfN97zNjuiniI4JVi6s03LTT2FmLcUSxQdRIIa1IqEQiOwimnRFlqlirYYu4M=
X-Received: by 2002:a05:6808:15a5:b0:3a7:55f2:552d with SMTP id
 t37-20020a05680815a500b003a755f2552dmr11757972oiw.58.1691429629797; Mon, 07
 Aug 2023 10:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230802075309.13950-1-sunran001@208suo.com>
In-Reply-To: <20230802075309.13950-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:33:38 -0400
Message-ID: <CADnq5_NdP=Uk3JCFwvO12nOWGJuFh9ZWaEuH7zSWsKAM9hufXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in vcn_v3_0.c
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

On Wed, Aug 2, 2023 at 3:53=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open brace '{'
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: space required before the open parenthesis '('
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index b76ba21b5a89..1e7613bb80ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1105,7 +1105,7 @@ static int vcn_v3_0_start(struct amdgpu_device *ade=
v)
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG){
> +               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>                         r =3D vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.=
indirect_sram);
>                         continue;
>                 }
> @@ -1789,7 +1789,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser=
 *p, struct amdgpu_job *job,
>         struct amdgpu_bo *bo;
>         uint64_t start, end;
>         unsigned int i;
> -       void * ptr;
> +       void *ptr;
>         int r;
>
>         addr &=3D AMDGPU_GMC_HOLE_MASK;
> @@ -2129,7 +2129,7 @@ static int vcn_v3_0_set_powergating_state(void *han=
dle,
>                 return 0;
>         }
>
> -       if(state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -2137,7 +2137,7 @@ static int vcn_v3_0_set_powergating_state(void *han=
dle,
>         else
>                 ret =3D vcn_v3_0_start(adev);
>
> -       if(!ret)
> +       if (!ret)
>                 adev->vcn.cur_state =3D state;
>
>         return ret;
> @@ -2228,8 +2228,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs =
=3D {
>         .set_powergating_state =3D vcn_v3_0_set_powergating_state,
>  };
>
> -const struct amdgpu_ip_block_version vcn_v3_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version vcn_v3_0_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_VCN,
>         .major =3D 3,
>         .minor =3D 0,
> --
> 2.17.1
>
