Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2B8015CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjLAV7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAV7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:59:20 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864DFF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:59:26 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d400779f16so10606647b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701467966; x=1702072766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+exs5h/ORFFX83E63BLP4xoRIe35RXovt/mscKVvNI=;
        b=hX6VTg28CCxCeP57YZmXo477YSgmH93Dw4fBMR4wa6zhQtrlFGN42dTJW7ffMyR2CE
         vAl1PUUYT91fOBJfopsUCUmAArwAU/VlXXeMGz5isSl2Of77vITRovW1K3zBV9xyb6x/
         KF/Q9DLL8h61WDxD5pTUbV55HXMS1+wiPLdBdZlMrzgejIPbQuH9TyOBSG6+RPX7iyxJ
         H8lRnSppJWjq8j4vS8hgcP5RY9WmKYYEZv4al4VbPGw/seqJTkfGMlmuoO1bX93eVAb5
         nrrvinDEAAMx+dOteVgfbjAyhpSDOX90IBDRwxDtT8COoK3qtagPQW8Pz4x5gnhfgFzM
         7Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701467966; x=1702072766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+exs5h/ORFFX83E63BLP4xoRIe35RXovt/mscKVvNI=;
        b=ZjX4VoQ5DHvUA/gQjBelB9O1CW0c33n3hwj7c9DDtPbMcFMlA4nFDLxUqpnyq089HW
         oGtYugu9skF/nVSNoTb/+pHjGqNa/tmLhu3w7FZ83dBGuHXzAmRUMGTBMCYoq3bPIY4Z
         hcN8/iH/JZ/0PN2KWdpF+E34YXS/tdS+pRx2Fixuf3ApOWnrd5GyU/EnB06SM6Ml9cwN
         Mswc205swSH4kbPyDTAfb4KdyMj7pzqvWbHXecT0BPlNxHNzwYmjfLjOosUHppSxPk7O
         VHS8GVbA/FqhGltGT9dWxUBkwEGC5BOQZiUmSY2/Xk/QhRCiNat0wrs6acGtYtbqcYfL
         /XZg==
X-Gm-Message-State: AOJu0YzdgmB4+X348fv99OAxCzWcJZfSZUm6IwXJMpb9+P3jccR6atYp
        lqiVotrrHWIf1neZc4DidDdYDr2KCS02BQ1ftgGx9A==
X-Google-Smtp-Source: AGHT+IH5pinfBxSB4oGxosUPol8k+50xPe9U5E7xmyyM7NKUdtj+66RiOT8P6mzKNjGWMLXdmWbEEzCJywNKZK4Oneo=
X-Received: by 2002:a0d:e684:0:b0:5d7:1a33:5ad3 with SMTP id
 p126-20020a0de684000000b005d71a335ad3mr115182ywe.32.1701467965712; Fri, 01
 Dec 2023 13:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com> <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
In-Reply-To: <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 1 Dec 2023 13:59:14 -0800
Message-ID: <CAJuCfpGtfxmyGDeCH9+YMMd-aX2z9pgdBch+DD7vGZzcfaC+kw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 12:47=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 01.12.23 10:29, Ryan Roberts wrote:
> > On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> >> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> >> into destination buffer while checking the contents of both after
> >> the move. After the operation the content of the destination buffer
> >> should match the original source buffer's content while the source
> >> buffer should be zeroed. Separate tests are designed for PMD aligned a=
nd
> >> unaligned cases because they utilize different code paths in the kerne=
l.
> >>
> >> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> ---
> >>   tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >>   tools/testing/selftests/mm/uffd-common.h     |   1 +
> >>   tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++=
++
> >>   3 files changed, 214 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/=
selftests/mm/uffd-common.c
> >> index fb3bbc77fd00..b0ac0ec2356d 100644
> >> --- a/tools/testing/selftests/mm/uffd-common.c
> >> +++ b/tools/testing/selftests/mm/uffd-common.c
> >> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool=
 wp)
> >>      return __copy_page(ufd, offset, false, wp);
> >>   }
> >>
> >> +int move_page(int ufd, unsigned long offset, unsigned long len)
> >> +{
> >> +    struct uffdio_move uffdio_move;
> >> +
> >> +    if (offset + len > nr_pages * page_size)
> >> +            err("unexpected offset %lu and length %lu\n", offset, len=
);
> >> +    uffdio_move.dst =3D (unsigned long) area_dst + offset;
> >> +    uffdio_move.src =3D (unsigned long) area_src + offset;
> >> +    uffdio_move.len =3D len;
> >> +    uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> >> +    uffdio_move.move =3D 0;
> >> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> >> +            /* real retval in uffdio_move.move */
> >> +            if (uffdio_move.move !=3D -EEXIST)
> >> +                    err("UFFDIO_MOVE error: %"PRId64,
> >> +                        (int64_t)uffdio_move.move);
> >
> > Hi Suren,
> >
> > FYI this error is triggering in mm-unstable (715b67adf4c8):
> >
> > Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=3D16,
> > @uffd-common.c:648)
> >
> > I'm running in a VM on Apple M2 (arm64). I haven't debugged any further=
, but
> > happy to go deeper if you can direct.
>
> Does it trigger reliably? Which pagesize is that kernel using?
>
> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() uses
> default_huge_page_size(), which reads the default hugetlb size.
>
> That, however, does not necessarily correspond to the THP size. That one
> can be obtained using read_pmd_pagesize() in vm_util.c

Oh, I didn't realize that default_huge_page_size() is not always the
actual THP size. Will fix.

>
> I quickly scanned the code (still want to take a deeper look), but all
> PAE checks looked sane to me.
>
> I think the issue is folio split handling. I replied to the patch.

Thanks for your hint! That's very possibly the reason for the test
failure. I'm in the process of trying to reproduce this issue on
ARM64. If I'm unable to do so then I'll create a patch to split
PTE-mapped THP when encountered and will ask Ryan to try that.
Thanks,
Suren.

>
> --
> Cheers,
>
> David / dhildenb
>
