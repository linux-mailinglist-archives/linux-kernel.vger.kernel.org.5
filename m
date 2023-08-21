Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E83782CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjHUPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjHUPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:09:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B1E7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:09:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so13686a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692630559; x=1693235359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oXoZoJuq/woE5y++bD9WQmvRVH8quzKKFsoooaxq1U=;
        b=0VuG3D0cAeTL/+xjnA7JNL7tY4pXxB/TaRxiQmcFKvqB47W9SvpCkhRpS3yJVxVXyA
         ZSTxAiuxf4wvJoOfayjhuMnJ7VnB8Pk7ctFrHAsgdXGUDJlhb2kPNNtU0AbJcvGrjVC2
         MJBghAqUEM/oznwDye8sU4lHbx3zzgURcgRM+HYxW+PXkrlWy9EBDNHbtlOx8S8cuuPq
         tZ4cqODsFbA2No6za+frgx125lKSY/nSllrTrm87PPYh0LLMUR2EL8d65LxH0S5D4lLQ
         N7en3HcGgLyAkHJj5yfUtidQHRaLbpSsHO5QiHFk6jYC8jEe2W9l/iJJ4mND8fISrIJ7
         r5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630559; x=1693235359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oXoZoJuq/woE5y++bD9WQmvRVH8quzKKFsoooaxq1U=;
        b=U48tNYg+MSrgMUvmJtMHf0fCKTcMN5JMkER8dXVmTaJmn2SKi9iXl83gz9v6a0L9a7
         IhZIeFHl0sOmQ9cmnHRlf5TPPWOsHCxdRHM3hbn6Vke3DZo5+xk5JLpp4xi09YJbNTx3
         WWI/icxJ+pL/GmfT8pOEjTx+y/aINfJz7rcxZvBcIO4N+1/kAw5WmeH85ygnuPkZlwEp
         9MM+JVpP7AJqWlsZ+5IuU9Q0VdQMC+LK6mYm9Mwv/9vVt3gPXUOLkw3xzEmbiMhO5hpk
         a2w376raltn+k+GS6ADE8SxoYJMWbOBFvlbt24Hir8EbQKyHr6aI5hW+u0rGrmsw69Zn
         nYHg==
X-Gm-Message-State: AOJu0YznXG5esKw77Pl5yBUA9rY+FO3Cr17DDYAroNvBmH1PJNMywBec
        A0xmSXGyqKWOW4JEsAf7xMe1qy3lIyJIsaNodDsmEA==
X-Google-Smtp-Source: AGHT+IG+biksOoGPIZ3ACervhJwDQAtg5fB09XOFkWi+plYXi1gTQbF2w0KLDwnf9pV9btWcD9Fb9mxGBp51w5zIfnY=
X-Received: by 2002:a50:d5c2:0:b0:522:4741:d992 with SMTP id
 g2-20020a50d5c2000000b005224741d992mr255782edj.4.1692630559271; Mon, 21 Aug
 2023 08:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmRrnRHEEQMMYe20GLXj7g+LVVHVRAKUdSLy=jUW=khb2A@mail.gmail.com>
 <CAHbLzko_xLiqkNgjA7DhVFBSW6qJdAwgfk557YKV+ZpwS2x16w@mail.gmail.com>
 <CAAa6QmSxab2-m-RopQtZnBpxTLX25K=KZE+EPmA+wWb_yTqf0Q@mail.gmail.com> <CAHbLzko1J9ds_JfZe83JwEx=395sPExB7mQ0faju6OSaQ2tmnQ@mail.gmail.com>
In-Reply-To: <CAHbLzko1J9ds_JfZe83JwEx=395sPExB7mQ0faju6OSaQ2tmnQ@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 21 Aug 2023 08:08:42 -0700
Message-ID: <CAAa6QmRLkh-g4ge4D9nQge=wHFwTz8CKB7AsjcJ9akDV8d0Z_A@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Yang Shi <shy828301@gmail.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Aug 18, 2023 at 2:21=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Thu, Aug 17, 2023 at 11:29=E2=80=AFAM Zach O'Keefe <zokeefe@google.com=
> wrote:
> >
> > On Thu, Aug 17, 2023 at 10:47=E2=80=AFAM Yang Shi <shy828301@gmail.com>=
 wrote:
> > >
> > > On Wed, Aug 16, 2023 at 2:48=E2=80=AFPM Zach O'Keefe <zokeefe@google.=
com> wrote:
> > > >
> > > > > We have a out of tree driver that maps huge pages through a file =
handle and
> > > > > relies on -> huge_fault. It used to work in 5.19 kernels but 6.1 =
changed this
> > > > > behaviour.
> > > > >
> > > > > I don=E2=80=99t think reverting the earlier behaviour of fault_pa=
th for huge pages should
> > > > > impact kernel negatively.
> > > > >
> > > > > Do you think we can restore this earlier behaviour of kernel to a=
llow page fault
> > > > > for huge pages via ->huge_fault.
> > > >
> > > > That seems reasonable to me. I think using the existence of a
> > > > ->huge_fault() handler as a predicate to return "true" makes sense =
to
> > > > me. The "normal" flow for file-backed memory along fault path still
> > > > needs to return "false", so that we correctly fallback to ->fault()
> > > > handler. Unless there are objections, I can do that in a v2.
> > >
> > > Sorry for chiming in late. I'm just back from vacation and trying to =
catch up...
> > >
> > > IIUC the out-of-tree driver tries to allocate huge page and install
> > > PMD mapping via huge_fault() handler, but the cleanup of
> > > hugepage_vma_check() prevents this due to the check to
> > > VM_NO_KHUGEPAGED?
> > >
> > > So you would like to check whether a huge_fault() handler existed
> > > instead of vma_is_dax()?
> >
> > Sorry for the multiple threads here. There are two problems: (a) the
> > VM_NO_KHUGEPAGED check along fault path, and (b) we don't give
> > ->huge_fault() a fair shake, if it exists, along fault path. The
> > current code assumes vma_is_dax() iff ->huge_fault() exists.
> >
> > (a) is easy enough to fix. For (b), I'm currently looking at the
> > possibility of not worrying about ->huge_fault() in
> > hugepage_vma_check(), and just letting create_huge_pud() /
> > create_huge_pmd() check and fallback as necessary. I think we'll need
> > the explicit DAX check still, since we want to keep khugepaged and
> > MADV_COLLAPSE away, and the presence / absence of ->huge_fault() isn't
> > enough to know that (well.. today it kind of is, but we shouldn't
> > depend on it).
>
> You meant something like:
>
> if (vma->vm_ops->huge_fault) {
>     if (vma_is_dax(vma))
>         return in_pf;
>
>     /Fall through */
> }

I don't think this will work for Saurabh's case, since IIUC, they
aren't using dax, but are using VM_HUGEPAGE|VM_MIXEDMAP, faulted in
using ->huge_fault()

The old (v5.19) fault path looked like:

static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
                                          unsigned long vm_flags)
{
        /* Explicitly disabled through madvise. */
        if ((vm_flags & VM_NOHUGEPAGE) ||
            test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
                return false;
        return true;
}

/*
 * to be used on vmas which are known to support THP.
 * Use transparent_hugepage_active otherwise
 */
static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vm=
a)
{

        /*
         * If the hardware/firmware marked hugepage support disabled.
         */
        if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_D=
AX))
                return false;

        if (!transhuge_vma_enabled(vma, vma->vm_flags))
                return false;

        if (vma_is_temporary_stack(vma))
                return false;

        if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
                return true;

        if (vma_is_dax(vma))
                return true;

        if (transparent_hugepage_flags &
                                (1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
                return !!(vma->vm_flags & VM_HUGEPAGE);

        return false;
}

For non-anonymous, the next check (in create_huge_*) would be for that
->huge_fault handler, falling back as necessary if it didn't exist.

The patch I sent out last week[1] somewhat restores this logic -- the
only difference being we do the check for ->huge_fault in
hugepage_vma_check() as well. This is so smaps can surface this
possibility with some accuracy. I just realized it will erroneously
return "true" for the collapse path, however..

Maybe Matthew was right about unifying everything here :P That's 2
mistakes I've made in trying to fix this issue (but maybe that's just
me).

[1] https://lore.kernel.org/linux-mm/20230818211533.2523697-1-zokeefe@googl=
e.com/
