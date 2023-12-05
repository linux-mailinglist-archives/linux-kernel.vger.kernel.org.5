Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BB805D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjLERzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjLERzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:55:16 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C11A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:55:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-423e04781d3so8561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701798921; x=1702403721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14hZsL2EZPjcbdl66EWnzrt1ktBdJ9RVwmhzDfYd1QY=;
        b=bMNVu7rUzOHAD8uG87TcJ4KoyxZfmrYKIwcMAEhVKmGuuMuxLSn/wrGrNZdFGFf458
         alwzU7uHYrdDdaQ54SYNnTmg9g4N4VA+VtflHhReB4gOXrwI+3neQo8KWebBcpA0HmwV
         9HjwRZ30ZJqYO7Fdt45rCWnpSQrTPoCOXvYe2m6OvclXY69UTu4OVJDHLfdorKBOjrSZ
         5aQuEmKvyWUUl6Ee80Cns+Oqzw9npGcJsNXIEldNUcNdxHIexO8/4oYZ/nSfrnDhjOu8
         gX2tWzHZjoC4DcCHaHOMhNvVSopAyz/neyjvYlpVpvQgxO3bclti1fE5A5POW9DnUgPt
         6f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798921; x=1702403721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14hZsL2EZPjcbdl66EWnzrt1ktBdJ9RVwmhzDfYd1QY=;
        b=hGbxxILIaSCrI2HEhIOzOtEPXFwYLECMq9RWPIGkP+rzhTKkpPpOGUjNGeBS535M72
         bFndTZE+z1APunwXXsDyHiOzuFW3xA0xYKWSZr0YoKo0t/k1rnorzodr8b4WjaY7m/CZ
         /KUfWFJ66Ql5FX3X/jPrJ4jro70AOs8wScZL5XPg+ZnM2Q7rihpoFnUnqa+bOz5C1sP0
         om7XM0prMhgCMOEtSJGsDiOuFhMKjKr+s0hDxeuyKrZhDQTX24JPyDo6Cp0TEHYX969f
         EO8RQGXIubjlV6+p1HBIYizgLQiUcVpfxBbHXudOdixMdDwrzfnO3fgzTIAicMo3CY2D
         Ppqg==
X-Gm-Message-State: AOJu0YwYHNVv7mvzQ/uiszlUu+TXWVef4k4HJ+A/9jOXlKUuSmsfrTRm
        DDizT4xzWlpIxQ14RZufuVDQYgj9DdgxV0ovz9MpCw==
X-Google-Smtp-Source: AGHT+IFuEEh+7llLgACUbcG3qpOSXaC4d/phdzPYYFh4nee56nOgh+uRdBPaMboPmcMAUuYsex0aFjYRwGCXDywPBVs=
X-Received: by 2002:a05:622a:216:b0:423:a0d5:6370 with SMTP id
 b22-20020a05622a021600b00423a0d56370mr1126930qtx.27.1701798921112; Tue, 05
 Dec 2023 09:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20231204172646.2541916-1-jthoughton@google.com> <70dcdad7-5952-48ce-a9b9-042cfea59a5d@arm.com>
In-Reply-To: <70dcdad7-5952-48ce-a9b9-042cfea59a5d@arm.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 5 Dec 2023 09:54:44 -0800
Message-ID: <CADrL8HVNBD=5akoTi3e0d6w=162Wak2cB2bc7jwQ8-DCAC4N1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: hugetlb: Fix page fault loop for
 sw-dirty/hw-clean contiguous PTEs
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 6:43=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 04/12/2023 17:26, James Houghton wrote:
> > It is currently possible for a userspace application to enter a page
> > fault loop when using HugeTLB pages implemented with contiguous PTEs
> > when HAFDBS is not available. This happens because:
> > 1. The kernel may sometimes write PTEs that are sw-dirty but hw-clean
> >    (PTE_DIRTY | PTE_RDONLY | PTE_WRITE).
>
> Hi James,
>
> Do you know how this happens?

Hi Ryan,

Thanks for taking a look! I do understand why this is happening. There
is an explanation in the reproducer[1] and also in this cover letter
(though I realize I could have been a little clearer). See below.

> AFAIK, this is the set of valid bit combinations, and
> PTE_RDONLY|PTE_WRITE|PTE_DIRTY is not one of them. Perhaps the real solut=
ion is
> to understand how this is happening and prevent it?
>
> /*
>  * PTE bits configuration in the presence of hardware Dirty Bit Managemen=
t
>  * (PTE_WRITE =3D=3D PTE_DBM):
>  *
>  * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
>  *   0      0      |   1           0          0
>  *   0      1      |   1           1          0
>  *   1      0      |   1           0          1
>  *   1      1      |   0           1          x
>  *
>  * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated=
 via
>  * the page fault mechanism. Checking the dirty status of a pte becomes:
>  *
>  *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
>  */

Thanks for pointing this out. So (1) is definitely a bug. The second
patch in this series makes it impossible to create such a PTE via
pte_modify (by forcing sw-dirty PTEs to be hw-dirty as well).

> > The second patch in this series makes step (1) less likely to occur.

It makes it impossible to create this invalid set of bits via
pte_modify(). Assuming all PTE pgprot updates are done via the proper
interfaces, patch #2 might actually make this invalid bit combination
impossible to produce (that's certainly the goal). So perhaps language
stronger than "less likely" is appropriate.

Here's the sequence of events to trigger this bug, via mprotect():

> > Without this patch, we can get the kernel to write a sw-dirty, hw-clean
> > PTE with the following steps (showing the relevant VMA flags and pgprot
> > bits):
> > i.   Create a valid, writable contiguous PTE.
> >        VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
> >        VMA pgprot bits: PTE_RDONLY | PTE_WRITE
> >        PTE pgprot bits: PTE_DIRTY | PTE_WRITE
> > ii.  mprotect the VMA to PROT_NONE.
> >        VMA vmflags:     VM_SHARED
> >        VMA pgprot bits: PTE_RDONLY
> >        PTE pgprot bits: PTE_DIRTY | PTE_RDONLY
> > iii. mprotect the VMA back to PROT_READ | PROT_WRITE.
> >        VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
> >        VMA pgprot bits: PTE_RDONLY | PTE_WRITE
> >        PTE pgprot bits: PTE_DIRTY | PTE_WRITE | PTE_RDONLY

With patch #2, the PTE pgprot bits in step iii become PTE_DIRTY |
PTE_WRITE (hw-dirtiness is set, as the PTE is sw-dirty).

Thanks!

> > [1]: https://gist.github.com/48ca/11d1e466deee032cb35aa8c2280f93b0
