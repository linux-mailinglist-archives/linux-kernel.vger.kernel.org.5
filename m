Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63059801D64
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjLBOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjLBOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:50:48 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBCC12E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:50:49 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7c45fa55391so985472241.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701528648; x=1702133448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ixg28vCNyeYFge8+qwTnb3fR5Cn16tF+NefpRupJIo=;
        b=CBlihGzOFUpPds/7yuAQ6eWBDx7r4rMgZ+Mze/Wr5RwIVtHoZz49hvoD9ggY5rv6ZO
         DzH4DESCFd/iVWnHYhtD6Vo30hJxq5NbO61OU9GFj8W5S/1xI7YasvM59VaUCkLkaBnI
         vmif2Q0/Xp4WXzHn9xk1D3FNayw5sVtgZyQVA70asApFeROEOVTtn/PGNgVuB9K41G+O
         zoszMEpTe2vGTdB6eVn/fS7ZyH8k7j05MrdeMGGiiiqPoZzkQVLtqpOBDOOD4FniGCrZ
         CtPncYJLixBeRnyls36N9gA3MDNU7FhYpHr44qXhCnKUNOJIGoOOOdI5CB5/iTykrR0H
         1Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701528648; x=1702133448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ixg28vCNyeYFge8+qwTnb3fR5Cn16tF+NefpRupJIo=;
        b=vigqWS+g0zg1QBsd/aLUmOnK7pBOODcH2nJTan5Mi/hSpsVa8+OVhZgwxEvFGd5sb9
         3OejvctMzs/A5RUrn6iMoz6nMfXJ8d+a/7dtYlCEgtwt14VZMz/F6XmuXYq4MeD74mQb
         kffIJrPoIKaw7rL2PXftat4e44CM4CeI2/yIHzg2Lx/mW2/hO5xQ1UxeJAQclhGHvAWN
         33ImlIoCb2ak9kwwrz8x1SYtaZ7GD8OW4UYB8+4GYqUrKc0VwPxHaYeNo1YpHSF1GUFv
         xPUhiYoQXIBEr0tRXI8lykLH4RFfLI1MGilMeBoJYQePfwKyMWIZGi7wfWiG8EKCdA1m
         aRlQ==
X-Gm-Message-State: AOJu0YyajmPcGqyT563wetVbYC+6Z2FYh3c+Z+tQ7MKVCiJQ2pyVjPGa
        f8XEsolanhEhh5rcHyvzQTuQYmWz+oJ4S0++qE8=
X-Google-Smtp-Source: AGHT+IE8qec2C6k83JGXnys0GKx41rq3i+6tLZnIp70pSrjs+tyidT8f0JZ+1VYuv6XjXPDL9j5GVHRqH6qDQRBzggY=
X-Received: by 2002:a67:e989:0:b0:464:4aca:51e8 with SMTP id
 b9-20020a67e989000000b004644aca51e8mr431734vso.35.1701528648668; Sat, 02 Dec
 2023 06:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128125025.4449-1-weixi.zhu@huawei.com> <20231128125025.4449-3-weixi.zhu@huawei.com>
 <e4eb5a24-e9cf-4944-9614-df5f5f3a7163@redhat.com>
In-Reply-To: <e4eb5a24-e9cf-4944-9614-df5f5f3a7163@redhat.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Sat, 2 Dec 2023 14:50:37 +0000
Message-ID: <CAKbZUD25mwVXowDcN1Cj5Op9wRAopYhYZcesR0tk2r_Wn-d95g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] mm/gmem: add arch-independent abstraction to
 track address mapping status
To:     David Hildenbrand <david@redhat.com>
Cc:     Weixi Zhu <weixi.zhu@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        weixi.zhu@openeuler.sh, mgorman@suse.de, jglisse@redhat.com,
        rcampbell@nvidia.com, jhubbard@nvidia.com, apopple@nvidia.com,
        mhairgrove@nvidia.com, ziy@nvidia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com,
        ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
        jgg@nvidia.com, leonro@nvidia.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com
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

On Fri, Dec 1, 2023 at 9:23=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 28.11.23 13:50, Weixi Zhu wrote:
> > This patch adds an abstraction layer, struct vm_object, that maintains
> > per-process virtual-to-physical mapping status stored in struct gm_mapp=
ing.
> > For example, a virtual page may be mapped to a CPU physical page or to =
a
> > device physical page. Struct vm_object effectively maintains an
> > arch-independent page table, which is defined as a "logical page table"=
.
> > While arch-dependent page table used by a real MMU is named a "physical
> > page table". The logical page table is useful if Linux core MM is exten=
ded
> > to handle a unified virtual address space with external accelerators us=
ing
> > customized MMUs.
>
> Which raises the question why we are dealing with anonymous memory at
> all? Why not go for shmem if you are already only special-casing VMAs
> with a MMAP flag right now?
>
> That would maybe avoid having to introduce controversial BSD design
> concepts into Linux, that feel like going a step backwards in time to me
> and adding *more* MM complexity.
>
> >
> > In this patch, struct vm_object utilizes a radix
> > tree (xarray) to track where a virtual page is mapped to. This adds ext=
ra
> > memory consumption from xarray, but provides a nice abstraction to isol=
ate
> > mapping status from the machine-dependent layer (PTEs). Besides support=
ing
> > accelerators with external MMUs, struct vm_object is planned to further
> > union with i_pages in struct address_mapping for file-backed memory.
>
> A file already has a tree structure (pagecache) to manage the pages that
> are theoretically mapped. It's easy to translate from a VMA to a page
> inside that tree structure that is currently not present in page tables.
>
> Why the need for that tree structure if you can just remove anon memory
> from the picture?
>
> >
> > The idea of struct vm_object is originated from FreeBSD VM design, whic=
h
> > provides a unified abstraction for anonymous memory, file-backed memory=
,
> > page cache and etc[1].
>
> :/
>
> > Currently, Linux utilizes a set of hierarchical page walk functions to
> > abstract page table manipulations of different CPU architecture. The
> > problem happens when a device wants to reuse Linux MM code to manage it=
s
> > page table -- the device page table may not be accessible to the CPU.
> > Existing solution like Linux HMM utilizes the MMU notifier mechanisms t=
o
> > invoke device-specific MMU functions, but relies on encoding the mappin=
g
> > status on the CPU page table entries. This entangles machine-independen=
t
> > code with machine-dependent code, and also brings unnecessary restricti=
ons.
>
> Why? we have primitives to walk arch page tables in a non-arch specific
> fashion and are using them all over the place.
>
> We even have various mechanisms to map something into the page tables
> and get the CPU to fault on it, as if it is inaccessible (PROT_NONE as
> used for NUMA balancing, fake swap entries).
>
> > The PTE size and format vary arch by arch, which harms the extensibilit=
y.
>
> Not really.
>
> We might have some features limited to some architectures because of the
> lack of PTE bits. And usually the problem is that people don't care
> enough about enabling these features on older architectures.
>
> If we ever *really* need more space for sw-defined data, it would be
> possible to allocate auxiliary data for page tables only where required
> (where the features apply), instead of crafting a completely new,
> auxiliary datastructure with it's own locking.
>
> So far it was not required to enable the feature we need on the
> architectures we care about.
>
> >
> > [1] https://docs.freebsd.org/en/articles/vm-design/
>
> In the cover letter you have:
>
> "The future plan of logical page table is to provide a generic
> abstraction layer that support common anonymous memory (I am looking at
> you, transparent huge pages) and file-backed memory."
>
> Which I doubt will happen; there is little interest in making anonymous
> memory management slower, more serialized, and wasting more memory on
> metadata.

Also worth noting that:

1) Mach VM (which FreeBSD inherited, from the old BSD) vm_objects
aren't quite what's being stated here, rather they are somewhat
replacements for both anon_vma and address_space[1]. Very similarly to
Linux, they take pages from vm_objects and map them in page tables
using pmap (the big difference is anon memory, which has its
bookkeeping in page tables, on Linux)

2) These vm_objects were a horrendous mistake (see CoW chaining) and
FreeBSD has to go to horrendous lengths to make them tolerable. The
UVM paper/dissertation (by Charles Cranor) talks about these issues at
length, and 20 years later it's still true.

3) Despite Linux MM having its warts, it's probably correct to
consider it a solid improvement over FreeBSD MM or NetBSD UVM

And, finally, randomly tacking on core MM concepts from other systems
is at best a *really weird* idea. Particularly when they aren't even
what was stated!

[1] If you really can't use PTEs, I don't see how you can't use file
mappings and/or some vm_operations_struct workarounds, when the
patch's vm_object is literally just an xarray with a different name

--=20
Pedro
