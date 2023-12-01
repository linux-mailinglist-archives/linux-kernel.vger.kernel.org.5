Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A538801118
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378354AbjLAQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjLAQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:27:00 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CDDF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:27:06 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db4050e68f3so761524276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701448025; x=1702052825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdQY2rO8kp3VX8kHp5yrzZMNN707JWDTWQPo3xyvnp8=;
        b=RR0Mv9ymrym2ni/1mvWkg9VapYsH/92smUvcMiwz8B1ekokVYGtVC36HRbwV6m3eEH
         fSALy95idxbo/3jpAr/HlIHtNCOwZmu4OhzJM9p5mPIrOQmi7bwduFAxAzZvPocvXqvd
         BDVrpZhgTerv6XGO0CCL9WzwxPI8gh1r18ylAlWvg9XQ2wcymSk5fMaV8eMatXiHx3K8
         hg3pss+Qm2MRgdyEZbrCPa1ssvaMPmizbIqMcgxWvWIHuyYyctDAV3T/AV/1b+WqIMLP
         M2XTC8cq9ZYwXQNh11yP/tLPKjBh5WNauAjf4QJlcW1jfhHEAUkqW+bOTDWVhAwS0w0Y
         wKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448025; x=1702052825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdQY2rO8kp3VX8kHp5yrzZMNN707JWDTWQPo3xyvnp8=;
        b=LK7b0p5uMkk7unhmlsKnZQ9y35KNAGkR4LvagCbCscTzIPdMZ0h0JJ6hAVkblqEGJ8
         BMZmKXboc3rhGdhE7YjCz89i+j/2AutZkFgWggHpw49bkEUNv1+7Jc6ff2g4Vjsbu3tt
         /HVaJmC76wAQfYvQEsoBfmQP7JnaFBWQmtJftTZTO4v7jTqykiKlZ6Gekdv44mpiwgl0
         JB6D4KTp9e4MDSamZ0acxwpAfJrb4rqnrCQrD7mLf58HwodSkF1EEXAbmkk0JMx+IxlP
         dY5bUvm1iJOqwVYXeV7Xv+R7OHgwIM3AtPmt4OMtB9D/abKbVdwC+EaTsaYVpDidSw1h
         Ok4w==
X-Gm-Message-State: AOJu0Yx5gq2UEGVb+vFlEnO9o2uzjwFXeZfNKd1lDW6EC1RyqIp0+Dug
        jFFjUvC9Mro/uWo4K754v+i8v7Lv8LsipWVfW9nIoQ==
X-Google-Smtp-Source: AGHT+IEom/S4gZpVn1oYHJmGvaqqrg1rL1XCWGsO98iZ+FbjMDZpHCZVbMQBZZO7cGiucq3ZSmPfizY6/7p5S2bZcqQ=
X-Received: by 2002:a25:244d:0:b0:da0:c49a:5fdf with SMTP id
 k74-20020a25244d000000b00da0c49a5fdfmr22604397ybk.7.1701448024871; Fri, 01
 Dec 2023 08:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
In-Reply-To: <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 1 Dec 2023 08:26:51 -0800
Message-ID: <CAJuCfpH8-jsxBRiLeLGWOFYnFE2iuSPfsveZkRf=MYZ6d=G7QA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
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

On Fri, Dec 1, 2023 at 1:29=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> > Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> > into destination buffer while checking the contents of both after
> > the move. After the operation the content of the destination buffer
> > should match the original source buffer's content while the source
> > buffer should be zeroed. Separate tests are designed for PMD aligned an=
d
> > unaligned cases because they utilize different code paths in the kernel=
.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >  tools/testing/selftests/mm/uffd-common.h     |   1 +
> >  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
> >  3 files changed, 214 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/s=
elftests/mm/uffd-common.c
> > index fb3bbc77fd00..b0ac0ec2356d 100644
> > --- a/tools/testing/selftests/mm/uffd-common.c
> > +++ b/tools/testing/selftests/mm/uffd-common.c
> > @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool =
wp)
> >       return __copy_page(ufd, offset, false, wp);
> >  }
> >
> > +int move_page(int ufd, unsigned long offset, unsigned long len)
> > +{
> > +     struct uffdio_move uffdio_move;
> > +
> > +     if (offset + len > nr_pages * page_size)
> > +             err("unexpected offset %lu and length %lu\n", offset, len=
);
> > +     uffdio_move.dst =3D (unsigned long) area_dst + offset;
> > +     uffdio_move.src =3D (unsigned long) area_src + offset;
> > +     uffdio_move.len =3D len;
> > +     uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > +     uffdio_move.move =3D 0;
> > +     if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > +             /* real retval in uffdio_move.move */
> > +             if (uffdio_move.move !=3D -EEXIST)
> > +                     err("UFFDIO_MOVE error: %"PRId64,
> > +                         (int64_t)uffdio_move.move);
>
> Hi Suren,
>
> FYI this error is triggering in mm-unstable (715b67adf4c8):
>
> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=3D16,
> @uffd-common.c:648)
>
> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, =
but
> happy to go deeper if you can direct.

Hi Ryan,
Thanks for reporting! Could you please share your kernel config file?

There are several places UFFDIO_MOVE returns EBUSY: 4 places in
move_pages_huge_pmd(), 2 places in move_present_pte(), 2 places in
move_pages_pte() and once in move_swap_pte(). While I'm trying to
reproduce, it would be useful if you could check which place is
triggering the error.
Thanks,
Suren.

>
> Thanks,
> Ryan
>
>
> > +             wake_range(ufd, uffdio_move.dst, len);
> > +     } else if (uffdio_move.move !=3D len) {
> > +             err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.mo=
ve);
> > +     } else
> > +             return 1;
> > +     return 0;
> > +}
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
