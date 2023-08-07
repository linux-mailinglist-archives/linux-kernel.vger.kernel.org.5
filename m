Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBC772CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjHGR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjHGR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:28:21 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C9107
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:28:19 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bb7d1f7aeaso3644926fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429299; x=1692034099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6FY/UHSIx30Eyl3JB6lbFhNoI7t76m1Z5h0FHFcD3Q=;
        b=MYw0o2mS1cTy+1qyqEKIAgKE7BzKVVUvpaT2XZdx3nB2IZEHgOkKbL4BfL/tAT7lw1
         jHMMyGzKb6oFcXfvnBa0iAYbORSMk/1ne/+3Xe7qWFQTGEc3Jjn6TrYcQeY8R1fML0Uj
         j77kIqGN3ChpU5cD/a1rHQnpHZ4Wlkc0ezRVwJYA5srFGs58eCGn2F88hXA7++wHYCzH
         tnjFbNBppzC4A86iRy71wFSdtTYfUnoJSzCCFmLOAoPr/Qh/pZUmXFeKfIPBnFcORbx1
         VTSC1vQ1pzw5JngwVdeZr0vaXuchbTwneqGKn1cKiPsf9gPdE4MHzZMDeuvWuLIlQyWF
         Er+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429299; x=1692034099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6FY/UHSIx30Eyl3JB6lbFhNoI7t76m1Z5h0FHFcD3Q=;
        b=Ns1zXaxmEVtPxe5ML835Beo8/e1WqBY0hhWEl+rT7CQCzYuWajp0yCagT6aAwdZa3S
         Ub2poFX5px+Hf23OhX9aSiQop2A1SuPKsQfSUP0vgiUoA4MVSCWtJ5EP+wnHXmiLvDpA
         uG6R1ko3DASb386/Vb6bt5gr7OjYTCeP8VcTN9zf+d2IsnTRmdzVVY0r2LHUEBRaWyZj
         CjRLuTZqfzrV362t3xWnU0UfweHNC9G2OGTTHnR1vIaahtn5wCjUmwAN6xP8kObZyJiV
         5wQAJzzQFfxFlv5XRY1hXiPDP7BM1q4n7G14OUsvlxs1MdEI9ZV+aEYp48JaIFEkK5ou
         nLeg==
X-Gm-Message-State: AOJu0YzLouCXneRZ94uOjORSCytJZF3qLz3rZDOYe4n5hFXbY0ixFSdt
        +1wHYyZIsYG9mxVe2ba/iLDIwY+WXwzDs76PZ7w=
X-Google-Smtp-Source: AGHT+IHASMiUy5XrNmZvfsMZItI1yzQbhJ7cbtQGgY7fuzl77I6Cwqlpqrq0rHwSHjFykof0W4qkKe9uQC7EKB45UoU=
X-Received: by 2002:a05:6870:4694:b0:1be:cc5b:6ce with SMTP id
 a20-20020a056870469400b001becc5b06cemr11564723oap.20.1691429299068; Mon, 07
 Aug 2023 10:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230802072621.13162-1-sunran001@208suo.com>
In-Reply-To: <20230802072621.13162-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:28:08 -0400
Message-ID: <CADnq5_NS0yx5pu3S1WE38OaYV=O2-Tp1QGgfWD+v2r6AJWoSiA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in amdgpu_trace.h
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

On Wed, Aug 2, 2023 at 3:26=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: "foo* bar" should be "foo *bar"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index 525dffbe046a..2fd1bfb35916 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -432,7 +432,7 @@ TRACE_EVENT(amdgpu_vm_flush,
>                            ),
>             TP_printk("ring=3D%s, id=3D%u, hub=3D%u, pd_addr=3D%010Lx",
>                       __get_str(ring), __entry->vmid,
> -                     __entry->vm_hub,__entry->pd_addr)
> +                     __entry->vm_hub, __entry->pd_addr)
>  );
>
>  DECLARE_EVENT_CLASS(amdgpu_pasid,
> @@ -494,7 +494,7 @@ TRACE_EVENT(amdgpu_cs_bo_status,
>  );
>
>  TRACE_EVENT(amdgpu_bo_move,
> -           TP_PROTO(struct amdgpu_bo* bo, uint32_t new_placement, uint32=
_t old_placement),
> +           TP_PROTO(struct amdgpu_bo *bo, uint32_t new_placement, uint32=
_t old_placement),
>             TP_ARGS(bo, new_placement, old_placement),
>             TP_STRUCT__entry(
>                         __field(struct amdgpu_bo *, bo)
> --
> 2.17.1
>
