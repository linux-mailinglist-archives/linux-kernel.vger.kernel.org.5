Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B930F772C57
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjHGRMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjHGRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:14 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C219BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:12:05 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56cb1e602e7so2914552eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428324; x=1692033124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1fFiDl47tj0kGpFVmy5pI63q4LR33axRCdbXWh8XXc=;
        b=Dxv/yJ1pcK4dyFHi2blaRWsooeHDuJVqxDYsmx3LVyICVQ7gUd+DO1ddjkZHSLAk7f
         EcxaoiFdT0G5F01Nqg1UQLjI17n0RqJ1PrreI5L5bucMQSsGhxHM/HMhGi9abKNaK3oi
         f2luBXDYx9BylQ9olG46Veb8eHXZk0R/H/+sTGBCop3G113iOGbO3Kjax+nWjniQ20DW
         Hr7l0lV1iBzGVMs4o+lz0bQeCGPz/ajvCu2D8xpgYomMEy43wFFoIud812IjIKYwNTGe
         eQfU3W1uOdvk59laOm5gtyrOaMigl4L9H72rvRJkEl6Mj5fDCa0sCF5kpteaTHbu6ucT
         f4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428324; x=1692033124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1fFiDl47tj0kGpFVmy5pI63q4LR33axRCdbXWh8XXc=;
        b=ThLzamFz3X/brFe14TytnRovuW2t5HluWKYkCkUP+Wf0/gLQesAsA5kVTOIjuT2Q5t
         HxeyJF5khhBNG80Js9GfeWP1llTHYcIgXOHYYacjGpq0aRC005qEg1NFy4W/jeWMJRNP
         S//srDhPgKRaAkY7z3HJvivSZPjlcvgtEB3SM7Gh9vxah4xGpVvj4UPAMsQU0fd8HmNF
         bzgZKp0jag1JLsaAy7Rq68Nucdl92Njml9z/Uz+GskQw5SV7VVmzf2KuOAoD0gJInXZn
         q41w+3783sZO/Wnhl0p+oYuQpAvWzorKBXnEaIr5Us68u2UYXPOawV4xK7naOqXXU7ba
         0qQg==
X-Gm-Message-State: AOJu0YzHMiRr9ZLxjeV5Dud1iHx6K4HRIAzDN1GnLQIPhBBrf8KE0bJL
        tiPFMvKcOAVmCXWzWBzXjUsjNO7mdcgf6XVxQeo=
X-Google-Smtp-Source: AGHT+IHzkSIlb9qWb8fkuZr8pkIIw3XgHtPA3sONL8H7DYzco0Urpf/mPFc/8HIKfCJlsmFJ0Z5tso9FusLyZUVB+WI=
X-Received: by 2002:a4a:d2dc:0:b0:56c:43cd:7267 with SMTP id
 j28-20020a4ad2dc000000b0056c43cd7267mr8345158oos.8.1691428324097; Mon, 07 Aug
 2023 10:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230802030311.10746-1-sunran001@208suo.com>
In-Reply-To: <20230802030311.10746-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:11:53 -0400
Message-ID: <CADnq5_PfyEZEWw1T-9RBvVtNrkHS=UB36nF8-M9TyEOFaCX3Eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dcn316_smu.c
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

On Tue, Aug 1, 2023 at 11:03=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b=
/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> index 457a9254ae1c..3ed19197a755 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> @@ -34,23 +34,21 @@
>  #define MAX_INSTANCE                                        7
>  #define MAX_SEGMENT                                         6
>
> -struct IP_BASE_INSTANCE
> -{
> +struct IP_BASE_INSTANCE {
>      unsigned int segment[MAX_SEGMENT];
>  };
>
> -struct IP_BASE
> -{
> +struct IP_BASE {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
>  };
>
>  static const struct IP_BASE MP0_BASE =3D { { { { 0x00016000, 0x00DC0000,=
 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } } } };
>
>  #define REG(reg_name) \
>         (MP0_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg=
 ## reg_name)
> --
> 2.17.1
>
