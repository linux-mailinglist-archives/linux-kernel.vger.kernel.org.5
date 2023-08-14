Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482AF77BFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjHNSsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHNSsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:48:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A1F1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:48:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2431a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692038908; x=1692643708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyHWTzG4ijgJg3zlJfOxdGz41fwifX3dI+PZ0fOTOHA=;
        b=JdfU/5ruki1e7gDB/9c4eSChzNb303LI9YXp0mpWVposcgzf8PxhYBCSAzeTgpP1eI
         HvX17Rh/hxtGWwpLdp5zDg4vTq8SXuhJch908IoPSevK2Xe3jisJfSeEghxnosCospoM
         xJ5320wZXMIHROtoQBOcyuIxddXpOHDBjykqsm+PnAQ1/4H7dcFUL/GFnFkOxHG4MJlg
         WDaXMulNdn1Ku5n6+9PuPwFJ+c41JoTyA+XX0Xhx4JWait3HJQQTBLuq4ofakP/qR+ZV
         TfYhjrhTEthCEvPtrhu7iekhM3SoWEwBN7BzRzqQIsRM+fUr8hYvX9MFNPW6qKco2Ce3
         KXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038908; x=1692643708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyHWTzG4ijgJg3zlJfOxdGz41fwifX3dI+PZ0fOTOHA=;
        b=Ovl9mpGmT990Eff+547G3SSg3LBsR1hWzTW1/yRrVfBJh208IJw8aghf04UppeLzw4
         2kw5ER09iuJj1GIZ3liBVPTpYmbcAk7KUoALZAAgTJiVWKBDch1U6GZ6eA8OkafRKdH4
         QBOw6nXWhkQoip9wCfPlRs24VmfJ9H90YNa2LvSIdWC6slMentQ2QBx7u1KisNCMIFul
         ncQAGvT7MelfJXCBZQHHgFnTpn9HJFurBd/CU4A4Rppoxbt/2FOrEsYahmLrI+xntgXW
         LU584oYrtkwbpkWunu74y0mibTWHSWGYFr7MjqwFyeiNTVYhFJAb2PrKMhApaQCVosvr
         LFXg==
X-Gm-Message-State: AOJu0YxPRpO0aeOeFJK/OANv8B6+8Sb5RI5xq3I9A+kECaaB2Xj+a+Zs
        9N8ctX/xCvrQFO0sd+te2cAGgzkCwoPG0pQWEplgiA==
X-Google-Smtp-Source: AGHT+IEcpK4nmeQ2r+LKdimObrzoGBi182a6AUbULOFCc73Z+MR7QTMJtr8LUewd2DtlYEUprqKzfXt2yGhNTGmumNo=
X-Received: by 2002:a50:c30e:0:b0:522:cc9c:f5a4 with SMTP id
 a14-20020a50c30e000000b00522cc9cf5a4mr296056edb.4.1692038907622; Mon, 14 Aug
 2023 11:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 14 Aug 2023 11:47:50 -0700
Message-ID: <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:19=E2=80=AFPM Saurabh Singh Sengar
<ssengar@microsoft.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Zach O'Keefe <zokeefe@google.com>
> > Sent: Sunday, August 13, 2023 2:31 AM
> > To: linux-mm@kvack.org; Yang Shi <shy828301@gmail.com>
> > Cc: linux-kernel@vger.kernel.org; Zach O'Keefe <zokeefe@google.com>;
> > Saurabh Singh Sengar <ssengar@microsoft.com>
> > Subject: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
> > __transhuge_page_enabled()"
> >
> > [You don't often get email from zokeefe@google.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > The 6.0 commits:
> >
> > commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()") com=
mit
> > 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> >
> > merged "can we have THPs in this VMA?" logic that was previously done
> > separately by fault-path, khugepaged, and smaps "THPeligible".
> >
> > During the process, the check on VM_NO_KHUGEPAGED from the
> > khugepaged path was accidentally added to fault and smaps paths.  Certa=
inly
> > the previous behavior for fault should be restored, and since smaps sho=
uld
> > report the union of THP eligibility for fault and khugepaged, also opt =
smaps
> > out of this constraint.
> >
> > Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> > Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/huge_memory.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c index
> > eb3678360b97..e098c26d5e2e 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct
> > *vma, unsigned long vm_flags,
> >                 return in_pf;
> >
> >         /*
> > -        * Special VMA and hugetlb VMA.
> > +        * khugepaged check for special VMA and hugetlb VMA.
> >          * Must be checked after dax since some dax mappings may have
> >          * VM_MIXEDMAP set.
> >          */
> > -       if (vm_flags & VM_NO_KHUGEPAGED)
> > +       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
> >                 return false;
> >
> >         /*
> > --
> > 2.41.0.694.ge786442a9b-goog
>
> Thanks for the patch, I realized with the commit 9fec51689ff60,
> !vma_is_anonymous restriction is also introduced. To make fault path
> work same as before we need relaxation for this check as well. Can we
> add the below as will in this patch:
>
> -       if (!vma_is_anonymous(vma))
> +       if (!is_pf && !vma_is_anonymous(vma))
>                 return false;

Hey Saurabh,

Thanks for pointing this out, and sorry for the mixup.

I'll try looping in some folks from DAX and fs worlds to be sure,
since my knowledge doesn't extend far into those realms.

I was under the understanding that CONFIG_READ_ONLY_THP_FOR_FS was
supposed to keep the filesystem blissfully unaware of hugepages; IOW,
that assembling file-backed hugepages was supposed to be a
pagecache-only thing .. or be DAX.

The early check:

if (vma_is_dax(vma))
        return in_pf;

Should handle the DAX case.

IIUC, the check, lower down:

if (!in_pf && file_thp_enabled(vma))
        return true;

Was supposed to be the last check for eligible file-backed memory, and
here it's clear that we don't support faulting-in hugepages over
file-backed memory.

Looking at current users of struct vm_operations_struct->huge_fault, I see:

drivers/dax/device.c : dev_dax_huge_fault
fs/ext4/file.c : ext4_dax_huge_fault
fs/xfs/xfs_file.c : xfs_filemap_huge_fault
fs/erofs/data.c : erofs_dax_huge_fault
fs/fuse/dax.c: fuse_dax_huge_fault

All of which *look* like they operate on DAX-backed memory (I checked
the xfs handler, it does so as well) -- so they should have been
whitelisted by the vma_is_dax() check.

All this to say, the kernel doesn't _currently_ support faulting-in
hugepages over non-DAX file-backed memory. However, it seems we don't
give that ->huge_fault handler a fair shake.

Saurabh, does your use case fall outside this?

Willy -- I'm not up-to-date on what is happening on the THP-fs front.
Should we be checking for a ->huge_fault handler here?

Thanks,
Zach

> - Saurabh
>
