Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17E7EE70D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjKPS4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKPS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:56:31 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D7D49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:56:28 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so573503fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700160987; x=1700765787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfl7Uje3tFYF1t/Z0iO7j2ft62sWmma7geyA5tMKm+Q=;
        b=aGRkJP2DuN5gk7rnTPLq8IzGGvC84hP6apKgTBU4otytwtjEWx9REEmT/LsD7bs27l
         KhRXK8u4Xz6zbV2hawueArs7BmKUBkQweJZ1hep52qC73Spz2AGZfGmbajvCQeb3S105
         kyEdejmoYmw94o0LsH5wDdEOfHdNHjd+iXzAulI8NPZoPFX3pqZjdWjGu/00UwWI2eJ+
         cY7+bBIAgsPTa/qwuj3NROmqp9iM6yZAL0N6s6ueLC3042OcG9P+6lSD41a6lJhd19rL
         RdzbZ98nuhROilQqN0PromkVnZYYbvDBYwQiqmOY08Il7LMGWWRJp4bsMcHPDwhodjbp
         8F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160987; x=1700765787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mfl7Uje3tFYF1t/Z0iO7j2ft62sWmma7geyA5tMKm+Q=;
        b=gO5p7mqmz6iYCuqseQaCl9y+o+8bz9oqccKiJ+/BbiWQ6Q/mZiu97mot3grjCXRmKG
         eqyM/7CT2Lxp7fnpJZfwszwcwbfQFcIdUVGQ3Aaorr0N1dHkUjxsYTHHRPxKzdt6jdci
         OB9Hxk7Rb5jNSaWyrq3dCPRoJBpSBptY17im0rJ4PHu2nggw+QNgap62+iB4cQL4kc6q
         BEf0wEwBifhrdnO5QlbXyIentHWqBzO/BSDvyNiLOMwLYhUYFon9Djbpg/rKNHLlpa3m
         vWwSJ0/PTC/UyECyjnjjrMHYAohL1ieqEYkC0drN8gUTI+H+GsaEwZLqEfeCn47dG9BV
         ZI7A==
X-Gm-Message-State: AOJu0YxK4zsZ1PH6XmBM2fgYHhgt8f+AqG3x1yOtI6Y/m84BkMFPUCrB
        XyJqRZ1aeSfkpIEK6aBEJFD2oeemShXqDdifUhk=
X-Google-Smtp-Source: AGHT+IHCyvXgVJb/dXO1JI3dVNFjLVgyT6C3jPYtogIsMwQHwJ320YLStLK7w8M+mFJb8NeQCY67F77NmvAqaEZRIr4=
X-Received: by 2002:a05:6870:3c09:b0:1ea:406:4dff with SMTP id
 gk9-20020a0568703c0900b001ea04064dffmr21289052oab.50.1700160987524; Thu, 16
 Nov 2023 10:56:27 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNsDLvZR8RGf9ji5938QreSix89FCpGHju+9in2x6OfDw@mail.gmail.com>
 <CADnq5_ObMvxN4pFAsWU7OM3SAtYCNHKE_fHsLqizGm0p1ubp=w@mail.gmail.com>
 <CABXGCsPXp_pWZcyVQajYSTZKeViRqjfXK2=jmuRXh0yug_OoWQ@mail.gmail.com>
 <CADnq5_ND_aBmsD3X=tx2==EM7VOz4EBwid4hRVZ79mbi6bWq1w@mail.gmail.com>
 <CABXGCsOn2a9vZj_1yET96mum=wjGmer6tHG=XgToS76L9ihdUg@mail.gmail.com> <CABXGCsOKs33zOC-X7p5QOVWbSzDnSzuxAyGL-oxFBMVFx10pmQ@mail.gmail.com>
In-Reply-To: <CABXGCsOKs33zOC-X7p5QOVWbSzDnSzuxAyGL-oxFBMVFx10pmQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Nov 2023 13:56:16 -0500
Message-ID: <CADnq5_Ndk0Z14gnk9=f6nsiQFHU9F3z9Vd2ca8fKsbrmyyTKxw@mail.gmail.com>
Subject: Re: 6.7/regression/KASAN: null-ptr-deref in amdgpu_ras_reset_error_count+0x2d6
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 1:14=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Wed, Nov 8, 2023 at 4:24=E2=80=AFAM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > Thanks, after applying the patch GPU loading meets expectations.
> > Games are working so overall all looking good for now.
> >
>
> Unfortunately I didn't check this patch on 7900XTX.
> And now I see that this patch leads the systems with 7900XTX GPU to a
> lot of protection fault messages in the kernel log.
>
> [   75.211702] gmc_v11_0_process_interrupt: 164 callbacks suppressed
> [   75.211706] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
> [   75.211715] amdgpu 0000:03:00.0: amdgpu:   in page starting at
> address 0x00008087fe5fd000 from client 10
> [   75.211718] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D53
> [   75.211720] amdgpu 0000:03:00.0: amdgpu: Faulty UTCL2 client ID: SDMA1=
 (0xe)
> [   75.211723] amdgpu 0000:03:00.0: amdgpu: MORE_FAULTS: 0x1
> [   75.211725] amdgpu 0000:03:00.0: amdgpu: WALKER_ERROR: 0x1
> [   75.211727] amdgpu 0000:03:00.0: amdgpu: PERMISSION_FAULTS: 0x5
> [   75.211729] amdgpu 0000:03:00.0: amdgpu: MAPPING_ERROR: 0x1
> [   75.211732] amdgpu 0000:03:00.0: amdgpu: RW: 0x1
> [   75.211740] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
> [   75.211743] amdgpu 0000:03:00.0: amdgpu:   in page starting at
> address 0x00008087bffff000 from client 10
> [   75.211746] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> [   75.211748] amdgpu 0000:03:00.0: amdgpu: Faulty UTCL2 client ID: CB/DB=
 (0x0)
> [   75.211750] amdgpu 0000:03:00.0: amdgpu: MORE_FAULTS: 0x0
> [   75.211752] amdgpu 0000:03:00.0: amdgpu: WALKER_ERROR: 0x0
> [   75.211754] amdgpu 0000:03:00.0: amdgpu: PERMISSION_FAULTS: 0x0
> [   75.211756] amdgpu 0000:03:00.0: amdgpu: MAPPING_ERROR: 0x0
> [   75.211758] amdgpu 0000:03:00.0: amdgpu: RW: 0x0
> [   75.212337] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault
> (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
> [   75.212344] amdgpu 0000:03:00.0: amdgpu:   in page starting at
> address 0x00008087fe5fd000 from client 10
> [   75.212348] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00041B52
> [   75.212352] amdgpu 0000:03:00.0: amdgpu: Faulty UTCL2 client ID: SDMA0=
 (0xd)
> [   75.212356] amdgpu 0000:03:00.0: amdgpu: MORE_FAULTS: 0x0
> [   75.212359] amdgpu 0000:03:00.0: amdgpu: WALKER_ERROR: 0x1
> [   75.212363] amdgpu 0000:03:00.0: amdgpu: PERMISSION_FAULTS: 0x5
> [   75.212367] amdgpu 0000:03:00.0: amdgpu: MAPPING_ERROR: 0x1
> [   75.212370] amdgpu 0000:03:00.0: amdgpu: RW: 0x1
>
> The full kernel log attached below.

This patch should address the issue:
https://patchwork.freedesktop.org/patch/567101/
If you still see issues, you may also need this series:
https://patchwork.freedesktop.org/series/126220/

Alex
