Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF87B7EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbjJDMTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjJDMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:19:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BDAC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:19:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-694f3444f94so1604886b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696421951; x=1697026751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEeWc8DqfnzpJ6zj4F7xZkjTH42TKKVplAVNMTpWCq8=;
        b=v6oaLhg8dYROMsptZsOZh5zEFwFQwGvuD/eneU/pxyMBaB6S//Uz9dUwiwVVbf+9DC
         MGeFgSEmYsegeGS7bTwHzipVfzqmZ2LndT5vDh5BsO11XZpKc3gxMOyfwBnJq4RBkTWO
         y5gOZj85KskooD/IV/ZxYcCnbwqZbAezLxazF85i0ggpfe4Ww1YyKsMLY3OZX0sXMHyD
         9jYlHN8mel5qQPlK6wguoD3iHqyW+R8zba99FfiA6dYOvPZ9fMEWAeENOqPIXM5GX31c
         L9ALvofbTm80W6xBREhX2rTN5r+UUbHvoccrI482uhraja+IY99hRAkWCO7y86kVyTR5
         N71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421951; x=1697026751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEeWc8DqfnzpJ6zj4F7xZkjTH42TKKVplAVNMTpWCq8=;
        b=hFC8aCwqA+gRvteftrbzY2DeZa4bh6OnUwHVn3dtvCKTmVJvBceNRBEYTGw7vAHPZF
         k51bAaZ8XHgCMkzCmbpbFS2BHvoio9W6HZDHi+6tvBj1VxPZSnoXSpqoqVPstejQZnRp
         aykXWTycuneETdFQ2rXRBF7NWiAOaEGKDYt59ap229Q/C3Y3qXfP/7HJraK97ZBQpBls
         e8eEBKTbhHFNy2VoFJxSSjKc1kroM16lUnZgfKIQMaeDq2MZy2USQw+VSFRM/pJnMHD+
         dGSYkuceKKoUI5288RlRWx+Vdly1hfemUSmw4hnhoJrapgL8lfduubqFhljq2Yf4/Jkm
         ewGA==
X-Gm-Message-State: AOJu0Yw2SnQ6uOwYuNm3NgS0JdmEe5YiTfcVAOAp/q5r4QnBav4NPatH
        XYc+w7MxwYq49RoUW9vXgVTHQzGR7QSAHrpIr6M0LQ==
X-Google-Smtp-Source: AGHT+IEzfoagUbnIfET05xNcAuU7M6mTc0Wm2xWkyvWAiOWEx1SL7Xac1rTM6tKJ/hNG9/88u8rYMlRcR6LUAbiA98M=
X-Received: by 2002:a05:6a21:6d9b:b0:14b:8023:33cb with SMTP id
 wl27-20020a056a216d9b00b0014b802333cbmr2654388pzb.11.1696421951306; Wed, 04
 Oct 2023 05:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-hib_zero_bitmap_fix-v2-1-6a530b7b6e98@quicinc.com>
In-Reply-To: <20231004-hib_zero_bitmap_fix-v2-1-6a530b7b6e98@quicinc.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 4 Oct 2023 08:18:35 -0400
Message-ID: <CADyq12ziGEpkpvLv9zg91Zpp-12GW1iLnXcT8LaMt48WiKaVMw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kernel@quicinc.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 1:01=E2=80=AFAM Pavankumar Kondeti
<quic_pkondeti@quicinc.com> wrote:
>
> The following crash is observed 100% of the time during resume from
> the hibernation on a x86 QEMU system.
>
> [   12.931887]  ? __die_body+0x1a/0x60
> [   12.932324]  ? page_fault_oops+0x156/0x420
> [   12.932824]  ? search_exception_tables+0x37/0x50
> [   12.933389]  ? fixup_exception+0x21/0x300
> [   12.933889]  ? exc_page_fault+0x69/0x150
> [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> [   12.935428]  snapshot_write_next+0x7c/0x9f0
> [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> [   12.937035]  ? hib_submit_io+0xa5/0x110
> [   12.937501]  load_image+0x83/0x1a0
> [   12.937919]  swsusp_read+0x17f/0x1d0
> [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> [   12.938967]  load_image_and_restore+0x45/0xc0
> [   12.939494]  software_resume+0x13c/0x180
> [   12.939994]  resume_store+0xa3/0x1d0
>
> The commit being fixed introduced a bug in copying the zero bitmap
> to safe pages. A temporary bitmap is allocated with PG_ANY flag in
> prepare_image() to make a copy of zero bitmap after the unsafe pages
> are marked. Freeing this temporary bitmap with PG_UNSAFE_KEEP later
> results in an inconsistent state of unsafe pages. Since free bit is
> left as is for this temporary bitmap after free, these pages are
> treated as unsafe pages when they are allocated again. This results
> in incorrect calculation of the number of pages pre-allocated for the
> image.
>
> nr_pages =3D (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_uns=
afe_pages;
>
> The allocate_unsafe_pages is estimated to be higher than the actual
> which results in running short of pages in safe_pages_list. Hence the
> crash is observed in get_buffer() due to NULL pointer access of
> safe_pages_list.
>
> Fix this issue by creating the temporary zero bitmap from safe pages
> (free bit not set) so that the corresponding free bits can be cleared whi=
le
> freeing this bitmap.
>
> Cc: stable <stable@kernel.org>
> Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image =
file")
> Suggested-by:: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
> Changes in v2:
> - Allocate zero bit map from safe pages as suggested by Brian
> - Link to v1: https://lore.kernel.org/r/20230929-hib_zero_bitmap_fix-v1-1=
-6cfdcb785250@quicinc.com
> ---
>  kernel/power/snapshot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e9f7e2bdc0..0f12e0a97e43 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2647,7 +2647,7 @@ static int prepare_image(struct memory_bitmap *new_=
bm, struct memory_bitmap *bm,
>         memory_bm_free(bm, PG_UNSAFE_KEEP);
>
>         /* Make a copy of zero_bm so it can be created in safe pages */
> -       error =3D memory_bm_create(&tmp, GFP_ATOMIC, PG_ANY);
> +       error =3D memory_bm_create(&tmp, GFP_ATOMIC, PG_SAFE);
>         if (error)
>                 goto Free;
>
> @@ -2660,7 +2660,7 @@ static int prepare_image(struct memory_bitmap *new_=
bm, struct memory_bitmap *bm,
>                 goto Free;
>
>         duplicate_memory_bitmap(zero_bm, &tmp);
> -       memory_bm_free(&tmp, PG_UNSAFE_KEEP);
> +       memory_bm_free(&tmp, PG_UNSAFE_CLEAR);
>         /* At this point zero_bm is in safe pages and it can be used for =
restoring. */
>
>         if (nr_highmem > 0) {
>
> ---
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> change-id: 20230929-hib_zero_bitmap_fix-bc5884eba0ae
>

Thanks!
Brian

> Best regards,
> --
> Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>
