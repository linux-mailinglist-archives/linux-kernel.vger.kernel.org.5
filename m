Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2BA803A63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbjLDQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344763AbjLDQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:35:35 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8360B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:35:40 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d7692542beso19991447b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701707740; x=1702312540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jABw2zbx7ijea0rhPxJuqEg+N1RDQxgva2LQbaOAzns=;
        b=zcMi7qeEGh7ktceqXYRGk16iQYqVcbQIXe0R50O5EPCofGnE8Bw50A/c8tZlCZ/I0z
         VM9vplNfCl1ZhVWc3SgZX7xID/n2QlDtyEP4sMeO7p9hdmkV3LgbW/wFwWuJoSmjWszT
         +NgFKGZUlr5vJI/V2myauNJ1ogYnr8vlIErTi4h3TLIhucYJKouiSYY+/g7/YzQbyIdk
         P9ZqFgF/Wg9gPi6YARUji4q/7jGLVjTuIhhrja2T+w5yHN/WY+ZswNzD6kGzLd7Q0v7p
         dRHhyMi2IouYffx/IzpxtvkEXBQis3xjkP0KYzvt4djd6tIG4pSyARCLTGsTwEJVnFy6
         Npmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707740; x=1702312540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jABw2zbx7ijea0rhPxJuqEg+N1RDQxgva2LQbaOAzns=;
        b=Vz6G4NM/enpj4MP7icXKJqPjd+HJLdvli1xpMZrERBOUr/n9bOEEGb+JjW14Bm8H3w
         ZpaUgPBIJd+aa42u3hBbkCifZohY5jNT2b50DPveCn/8IHuOefyAAPD7WK4EtWDAKZyO
         GknJ/tfm/WiywFGXa0/Hh+yK8A6AkG0cLHS5yNKYLl3zPpdmGg2N9JRKAZtqLbLL/ASr
         dJH9k9V4ShEMnqKt2McL3LM71Pc5RHR7/zmuBSSgu3FqfsP4lkTvWwyDYRVXKTf2ta2/
         ksXuZ28BuVMJQJvs2eJOqQFlDexrvsh1hxtBeoP9O+DQtyVq2zVI1dNVe4k/8w3wtYaH
         8Ivw==
X-Gm-Message-State: AOJu0YzCL6zqibNlWS8+z0Xx7d6+zmuXZKGPxXuRDr/Zbrb/mTpFxRfR
        aycj0Fi5NGWF+smzGnhKopOL2gWmOsYxCYMJcQajVA==
X-Google-Smtp-Source: AGHT+IEPIvS2v9x5/LGkP67CUghbCwHnkkFfGaI/Rzd47JgebT80lAaPaT/OgP4FMUPPtIDXwaqelTsXTcjSOD2IRY4=
X-Received: by 2002:a05:690c:a06:b0:5d7:1940:53c2 with SMTP id
 cg6-20020a05690c0a0600b005d7194053c2mr3349401ywb.58.1701707739801; Mon, 04
 Dec 2023 08:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com> <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
 <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com> <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
 <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com> <744be4e0-48e0-4c77-825c-711386dd205f@arm.com>
In-Reply-To: <744be4e0-48e0-4c77-825c-711386dd205f@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 4 Dec 2023 08:35:27 -0800
Message-ID: <CAJuCfpHpbz4fWawmYU=B1D5pPE4+x0Wj0V-514Dja9UWcwiL9A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 1:27=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 04/12/2023 04:09, Suren Baghdasaryan wrote:
> > On Sat, Dec 2, 2023 at 2:11=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 02.12.23 09:04, Ryan Roberts wrote:
> >>> On 01/12/2023 20:47, David Hildenbrand wrote:
> >>>> On 01.12.23 10:29, Ryan Roberts wrote:
> >>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> >>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> >>>>>> into destination buffer while checking the contents of both after
> >>>>>> the move. After the operation the content of the destination buffe=
r
> >>>>>> should match the original source buffer's content while the source
> >>>>>> buffer should be zeroed. Separate tests are designed for PMD align=
ed and
> >>>>>> unaligned cases because they utilize different code paths in the k=
ernel.
> >>>>>>
> >>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>>>> ---
> >>>>>>    tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >>>>>>    tools/testing/selftests/mm/uffd-common.h     |   1 +
> >>>>>>    tools/testing/selftests/mm/uffd-unit-tests.c | 189 ++++++++++++=
+++++++
> >>>>>>    3 files changed, 214 insertions(+)
> >>>>>>
> >>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
> >>>>>> b/tools/testing/selftests/mm/uffd-common.c
> >>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
> >>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
> >>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
> >>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, =
bool wp)
> >>>>>>        return __copy_page(ufd, offset, false, wp);
> >>>>>>    }
> >>>>>>    +int move_page(int ufd, unsigned long offset, unsigned long len=
)
> >>>>>> +{
> >>>>>> +    struct uffdio_move uffdio_move;
> >>>>>> +
> >>>>>> +    if (offset + len > nr_pages * page_size)
> >>>>>> +        err("unexpected offset %lu and length %lu\n", offset, len=
);
> >>>>>> +    uffdio_move.dst =3D (unsigned long) area_dst + offset;
> >>>>>> +    uffdio_move.src =3D (unsigned long) area_src + offset;
> >>>>>> +    uffdio_move.len =3D len;
> >>>>>> +    uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> >>>>>> +    uffdio_move.move =3D 0;
> >>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> >>>>>> +        /* real retval in uffdio_move.move */
> >>>>>> +        if (uffdio_move.move !=3D -EEXIST)
> >>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
> >>>>>> +                (int64_t)uffdio_move.move);
> >>>>>
> >>>>> Hi Suren,
> >>>>>
> >>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
> >>>>>
> >>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=3D=
16,
> >>>>> @uffd-common.c:648)
> >>>>>
> >>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any fur=
ther, but
> >>>>> happy to go deeper if you can direct.
> >>>>
> >>>> Does it trigger reliably? Which pagesize is that kernel using?
> >>>
> >>> Yep, although very occasionally it fails with EAGAIN. 4K kernel; see =
other email
> >>> for full config.
> >>>
> >>>>
> >>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() us=
es
> >>>> default_huge_page_size(), which reads the default hugetlb size.
> >>>
> >>> My kernel command line is explicitly seting the default huge page siz=
e to 2M.
> >>>
> >>
> >> Okay, so that likely won't affect it.
> >>
> >> I can only guess that it has to do with the alignment of the virtual
> >> area we are testing with, and that we do seem to get more odd patterns
> >> on arm64.
> >>
> >> uffd_move_test_common() is a bit more elaborate, but if we aligned the
> >> src+start area up, surely "step_count" cannot be left unmodified?
> >>
> >> So assuming we get either an unaligned source or an unaligned dst from
> >> mmap(), I am not convinced that we won't be moving areas that are not
> >> necessarily fully backed by PMDs and maybe don't even fall into the VM=
A
> >> of interest?
> >>
> >> Not sure if that could trigger the THP splitting issue, though.
> >>
> >> But I just quickly scanned that test setup, could be I am missing
> >> something. It might make sense to just print the mmap'ed range and the
> >> actual ranges we are trying to move. Maybe something "obvious" can be
> >> observed.
> >
> > I was able to reproduce the issue on an Android device and after
> > implementing David's suggestions to split the large folio and after
> > replacing default_huge_page_size() with read_pmd_pagesize(), the
> > move-pmd test started working for me. Ryan, could you please apply
> > attached patches (over mm-unstable) and try the test again?
>
> Yep, all fixed with those patches!

Great! Thanks for testing and confirming. I'll post an updated
patchset later today and will ask Andrew to replace the current one
with it.
I'll also look into the reasons we need to split PMD on ARM64 in this
test. It's good that this happened and we were able to test the PMD
split path but I'm curious about the reason. It's possible my address
alignment calculations are  somehow incorrect.
Thanks,
Suren.

>
>
> > Thanks,
> > Suren.
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
>
