Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9687B572F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbjJBPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbjJBPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:46:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACDB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:46:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso5393695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696261584; x=1696866384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GpMdvzAhSdXiBMXOyN3F1QMGpt/m//1LDMJoTB334A=;
        b=ZrF4qCCJOkE1NbJu85xCV7Aw9uMwnjHr9keoXCpj2emPn/Z//eQnhb6qL9U0pYSBZD
         ix2Yl5Sn2J/ecHuIKoPcPniQ6eA0zjRD3BbTTEdfLd1YyEqgHmdKx1VZbIccwg3l9DhC
         QhyN8Vxz2YW0I4GXEZUDojrGmge5C/u3IFR3imI8VbNZ7yATaaKeCBggHtCaZUZnubYr
         JYZRbWuFTdEmY6owceXSgzRofke/dcy5fbFzm0oF7tZCUlELPNTLEvlbxTxQ+uFyngkm
         kbMuTmOBjFCqU+ET1NEFHl5cA2csLbn/l7ASNXYfltMLKAaLcdEqSAYOFnjtPkp32yUT
         2Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261584; x=1696866384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GpMdvzAhSdXiBMXOyN3F1QMGpt/m//1LDMJoTB334A=;
        b=GrRSJrfFCY99fKIv69cO+nNDuyHVxV3ZjoWW9I1MbFdPNZAi7Ls6PKlxrJOEGQHVXY
         7nW6qmv5dW+BhmXvo5RawSmtXGw0NpOt3iYJ7fii9FTJqcJSCpS+Be7vPU0ajpDkWJaB
         wt116o2RxKoz+nn7x/15s4FskaeC90TUIDYRcWK7u2YUyhZqt4I0C1WPPYhSRqbztCAV
         MrQFDRnXffyrdEZNr6lgYam/9eSEzyWn+IE3I0nlOOBLNZJCvOIwcsvR/vidDWb6SdT0
         K35r5WTXwGQ0bk8hnaioeUCHMND3AGvfV+XmAMq2ytfVrtJoscx0sO7rOTi1MBe8NYjw
         BGbA==
X-Gm-Message-State: AOJu0YwNMZ49p4BKbDI6UDgILpKJZcQdjm1/sSA/v3POyo86ZiG8fS9V
        K/LkbQzKESsKnM/a/qNYVGZrGINfyCKJTWGjvQXn/Q==
X-Google-Smtp-Source: AGHT+IGEVLTkfWI+L/ulZiTspdc5BVdb2gZ1malMtYF9uJmeShnHEQls1etvNfmxXXXmazmJYi3tfR+ki49hFstKvsI=
X-Received: by 2002:a5d:6d47:0:b0:317:6579:2b9f with SMTP id
 k7-20020a5d6d47000000b0031765792b9fmr2579wri.30.1696261583969; Mon, 02 Oct
 2023 08:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
In-Reply-To: <ZRrf8NligMzwqx97@x1n>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 2 Oct 2023 16:46:11 +0100
Message-ID: <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
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

On Mon, Oct 2, 2023 at 4:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
> > In case we cannot simply remap the page, the fallback sequence (from th=
e
> > cover letter) would be triggered.
> >
> > 1) UFFDIO_COPY
> > 2) MADV_DONTNEED
> >
> > So we would just handle the operation internally without a fallback.
>
> Note that I think there will be a slight difference on whole remap
> atomicity, on what happens if the page is modified after UFFDIO_COPY but
> before DONTNEED.
>
> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threads
> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
> during movement, and it will generate a missing event after moved, with
> latest data showing up on dest.
>
> I'm not sure that means such a fallback is a problem, Suren may know
> better with the use case.

Although there is no problem in using fallback with our use case but
as a user of userfaultfd, I'd suggest leaving it to the developer.
Failing with appropriate errno makes more sense. If handled in the
kernel, then the user may assume at the end of the operation that the
src vma is completely unmapped. And if not correctness issues, it
could lead to memory leaks.
>
> Thanks,
>
> --
> Peter Xu
>
