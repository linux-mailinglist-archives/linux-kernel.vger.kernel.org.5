Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238DF7EF541
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjKQP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:26:37 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC760D56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:26:33 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50906f941so29608181fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234792; x=1700839592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv7ltsAYcQTMvzd2FUagZjickZhGfcpanYHo/YoGbKs=;
        b=NAdVFCaJEVf1Maa239vIG6XO/8RtjQGTpZOBnEoWIF5loaWI+ZwT1N7X/FRGYSE7n1
         zft+NGGmLSWmZVFknmyldiTSwADQYflrRZuxki/GpMEdwtq8l3qp27lUw1PrLkUln49F
         YmG9oga6WTEftIzZ6Z+nzE72M0KcfDJU3swBXnmPgUoxJAL8tXW9ZiY/HfSWHb2h5xLU
         UrbdazipW++vUcGVeWH74KgeMgGMkj7i1Yseu4SETM5tqAaJSy5nHHVZo++TnrumJmsn
         c6THuL5V6Xh+ftrqFMacZ/rVo2aabccPqxgj5VL9C3UzsehoYxB9X0zy2NTR3rOH3OTH
         RyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234792; x=1700839592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv7ltsAYcQTMvzd2FUagZjickZhGfcpanYHo/YoGbKs=;
        b=w5bTgvGRfYG03wl2GULiP2FSyPSnmvsfkxnTBBYuE9quoNu8c06TZVn5GY/CMLkDzW
         XCZmF2eUqRldNtVylk7SXB3gK5V7is5iwiBZh2HDqkjmBB7BKx9ZFZj7tc1fgB12jfWs
         QcQxA4fytW9/uvijSg1gXVQnJxvr85ujX7bZzfk9CPyXZfTvgGV+mvEZ4YKELcPVvn8u
         Seg36A7UywypgIMfLee8SiIozY4lZPKUAcAi4SoP6Q4Y9dJFAyXtDPlA7CfmzDCspiya
         gtGDuwuexrdggrGTccAuf+WhPOF0TwxvHtFbGiM/cKK4uNJMd0YMeJHCjZ/ZQBlt/N3h
         ugYA==
X-Gm-Message-State: AOJu0YwbKwyd0dmFrWPqlux/EiTcP2HXwjfQgwAlWKFR2E7iGRMqOFdd
        6Vx6mYjL0cNTz3WBQ0V3aMd3o5E+45V5VV85i5d0V+sDbBi2BQ==
X-Google-Smtp-Source: AGHT+IEtMiRDAfvb9ms84AqQzKN3gOAhZ1sldrQlVSpPjuMCXsfZ9mA3X0hwOrvqQEmpGvSF3T0dOOfmGy6LvwD6yNQ=
X-Received: by 2002:a2e:9d92:0:b0:2c5:8a0:b502 with SMTP id
 c18-20020a2e9d92000000b002c508a0b502mr8711151ljj.48.1700234791421; Fri, 17
 Nov 2023 07:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20231116201547.536857-1-peterx@redhat.com> <20231116201547.536857-2-peterx@redhat.com>
In-Reply-To: <20231116201547.536857-2-peterx@redhat.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 17 Nov 2023 07:26:19 -0800
Message-ID: <CANaxB-w+zde9zNMqC4naOuu+Vdid41Vwjb_jtkrLUTbaKWN1Eg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/pagemap: Fix ioctl(PAGEMAP_SCAN) on vma check
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:15=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> The new ioctl(PAGEMAP_SCAN) relies on vma wr-protect capability provided =
by
> userfault, however in the vma test it didn't explicitly require the vma t=
o
> have wr-protect function enabled, even if PM_SCAN_WP_MATCHING flag is set=
.
>
> It means the pagemap code can now apply uffd-wp bit to a page in the vma
> even if not registered to userfaultfd at all.
>
> Then in whatever way as long as the pte got written and page fault
> resolved, we'll apply the write bit even if uffd-wp bit is set.  We'll se=
e
> a pte that has both UFFD_WP and WRITE bit set.  Anything later that looks
> up the pte for uffd-wp bit will trigger the warning:
>
> WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_=
wp arch/x86/include/asm/pgtable.h:403 [inline]
>
> Fix it by doing proper check over the vma attributes when
> PM_SCAN_WP_MATCHING is specified.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and option=
ally clear info about PTEs")
> Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Andrei Vagin <avagin@gmail.com>

> ---
>  fs/proc/task_mmu.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 51e0ec658457..e91085d79926 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1994,15 +1994,31 @@ static int pagemap_scan_test_walk(unsigned long s=
tart, unsigned long end,
>         struct pagemap_scan_private *p =3D walk->private;
>         struct vm_area_struct *vma =3D walk->vma;
>         unsigned long vma_category =3D 0;
> +       bool wp_allowed =3D userfaultfd_wp_async(vma) &&
> +           userfaultfd_wp_use_markers(vma);
>
> -       if (userfaultfd_wp_async(vma) && userfaultfd_wp_use_markers(vma))
> -               vma_category |=3D PAGE_IS_WPALLOWED;
> -       else if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
> -               return -EPERM;
> +       if (!wp_allowed) {
> +               /* User requested explicit failure over wp-async capabili=
ty */
> +               if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
> +                       return -EPERM;
> +               /*
> +                * User requires wr-protect, and allows silently skipping
> +                * unsupported vmas.
> +                */
> +               if (p->arg.flags & PM_SCAN_WP_MATCHING)
> +                       return 1;
> +               /*
> +                * Then the request doesn't involve wr-protects at all,
> +                * fall through to the rest checks, and allow vma walk.
> +                */
> +       }
>
>         if (vma->vm_flags & VM_PFNMAP)
>                 return 1;
>
> +       if (wp_allowed)
> +               vma_category |=3D PAGE_IS_WPALLOWED;
> +
>         if (vma->vm_flags & VM_SOFTDIRTY)
>                 vma_category |=3D PAGE_IS_SOFT_DIRTY;
>
> --
> 2.41.0
>
