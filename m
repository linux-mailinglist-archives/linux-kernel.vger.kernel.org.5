Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B650772CC8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjHGRYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHGRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:24:30 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD691F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:24:29 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56c711a88e8so3143061eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429069; x=1692033869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk0YYbyx4I/Kc7B3FfXc0ayH25iR8p6gWIqgWH2jzaU=;
        b=IMFEz6z3YFbR7tfyTdeLiJC/61zlz3a64TqyyFz86IYDFtKhmMxx6zobDSrkEuDwwP
         Ij4S9CDbItFYO4w+G2+KVQmoaIFmzAMz169J6xJzn69hm98xDFKC87fgWAa3SVAG5pnP
         zr2qlxmdgdrvNShMFhCkaxb3FCuRYHMsc4LIt/Ep9VR9Ue+4XPQM7463VRoGpV0Yitk9
         v0z0/oZg5mTGRrbtVoyqBuSv9IVrIDdeeg2MOqUhLLnadkRGsWsI8R4AhchGxoYeQU/k
         eiC2iKuAU5sePRcP+QEGe1igBT6NM3JVQoGippB0sZiW4PVCSPz9ZsXOkGKpcErYMo7l
         svWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429069; x=1692033869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kk0YYbyx4I/Kc7B3FfXc0ayH25iR8p6gWIqgWH2jzaU=;
        b=YGoTMx7GTbQ0aLTc6BDpkwMoxifuDsqGvne19Z5+rE7sFLGbfWDi8Nw6bih2dY2I1+
         Bq/7TZ/pcqsxiJhieOSEDwil80wRtyCId8b8yhePWShTgMdHAcT0r6Pui/ylR477Rdx/
         5B1yskIC8QR5GPZDiWC6EU9D3sveoDXJbgWZaKxs2y1/VUwCiUg2ePF7w/zdteDrZRIh
         dCkNE7BA4jSCwLi5Uoj56eX9VWqi14wOAmSj3do50w8d2CY/7WUZF+9lfo0orIkpmW+G
         94Osi2ZLR3BWHoX1+QvgQ/h3byUqfpJ9i1TWg2XewyCz9wkHKqT1EvGbrhxBiyZuGXYa
         x2sw==
X-Gm-Message-State: AOJu0Yxwgj41YWQPmbDY9+xiiRjFlJ+7AyXYZvNgwiPtH3e5sIF2HN8H
        fZOUAk3f+crT9cRaKHu1MxrnvdYuYpXQU3+8pE2LjRlI
X-Google-Smtp-Source: AGHT+IHij9VSawOKKzWitWCyuAIbykzrq30l4F4sGTL1EkMxZFRlc8pSLkfzNh6bCO4VIzteBVAJ+l/hmFIN16heAKQ=
X-Received: by 2002:a4a:3803:0:b0:56d:2a98:a77b with SMTP id
 c3-20020a4a3803000000b0056d2a98a77bmr8612071ooa.3.1691429068958; Mon, 07 Aug
 2023 10:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230802070632.12626-1-sunran001@208suo.com>
In-Reply-To: <20230802070632.12626-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:24:18 -0400
Message-ID: <CADnq5_NqVzu4gxx9dM3ALQCi-SRfqG_BfrhcQqB3X=aj14aAGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in mxgpu_nv.c
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

On Wed, Aug 2, 2023 at 3:06=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: else should follow close brace '}'
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_nv.c
> index cae1aaa4ddb6..6a68ee946f1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -183,12 +183,10 @@ static int xgpu_nv_send_access_requests(struct amdg=
pu_device *adev,
>                         if (req !=3D IDH_REQ_GPU_INIT_DATA) {
>                                 pr_err("Doesn't get msg:%d from pf, error=
=3D%d\n", event, r);
>                                 return r;
> -                       }
> -                       else /* host doesn't support REQ_GPU_INIT_DATA ha=
ndshake */
> +                       } else /* host doesn't support REQ_GPU_INIT_DATA =
handshake */
>                                 adev->virt.req_init_data_ver =3D 0;
>                 } else {
> -                       if (req =3D=3D IDH_REQ_GPU_INIT_DATA)
> -                       {
> +                       if (req =3D=3D IDH_REQ_GPU_INIT_DATA) {
>                                 adev->virt.req_init_data_ver =3D
>                                         RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RC=
V_DW1);
>
> --
> 2.17.1
>
