Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375E7BDEC5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376428AbjJINWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376396AbjJINWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:22:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2228F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:22:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so13049a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696857770; x=1697462570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ucMi41TQkv++KBAnHCuW8sOa9RykSneNLP1uSJ3/rY=;
        b=4M3epxgkhirh85jt5J2jq1bEB8pXmohefDRjKIBkTZ0+ADikHycH2uYGACgkxdFgg6
         9vLZCpWMdx3aAeu2wCk8CDNkCFNrdDfjBD51CSVjtT8uDo1aUrTeu+Au0ZNV75NfdSAL
         rMEOHII2SvIaDoLQXKpBiuJiWY5+CLFRP6FmCac1QE49vz+RN7s/NOaTDAzsljmxYxxd
         ReMcnsQXjEqviPU0hQgLEtGcVc7vnwxJg73VSOIbd+jwafpYv1qfGjpdnGSBx6lU+cfK
         FDHPU6t4g8Sxe2RRbH6thXnHdd7iVaYEHz8gxyqu5OJqzaSGNAWvssTnBSbYGeEUfYD1
         j3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857770; x=1697462570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ucMi41TQkv++KBAnHCuW8sOa9RykSneNLP1uSJ3/rY=;
        b=P+Ec/FMYcSQpiXzho+T16FfZsuK1jae8KW9SsYVLFtqtokMWKT38IMev7jjOe6aTSi
         kUnbzasutkV3h1nu5g2zZShBwzvJZTdMm48CI/iAdgQGvInCfgmwyc4mC7ZH7ISaVkSu
         u6p5/AQCUSUeYAZmDRiY5lkRZIw74IrNIVhQhFZelxyjvE6XwZoYNQAsEA+bMf9VLDmB
         dQ3ApsytfKORN010ZR9hPLhAClsBoC+sRCqCo+jFFTBxiXWF7b+AymiUQiTh5EfwgLH/
         noV0FvwEr3EHpfYwyQsonqTBNuBeQoQKhqoB/pMYnWdN9h8GGJazAKsy5JlwdKCaWyo/
         2BSw==
X-Gm-Message-State: AOJu0YyalAH8cdswVpJkGXHksotpoU+9rXk0jAz048YiTOQxvmoKKYSR
        3QK9puC9NE4cZdwbPNTFHbAJuH+NzGIWuWap0QfK14883IZT5seHfu0=
X-Google-Smtp-Source: AGHT+IFOUr34G+Yla/d4AVAiHklOzTMuqIvsyl6uOGRaCES8wUndJpjxEHBlFLQrrKJSoyqaqmBfRSqGnVKYP8wY0oM=
X-Received: by 2002:a05:6402:d4b:b0:53a:ff83:6123 with SMTP id
 ec11-20020a0564020d4b00b0053aff836123mr227837edb.3.1696857770226; Mon, 09 Oct
 2023 06:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230925200110.1979606-1-zokeefe@google.com> <20231006105012.61a12beefaa0f9a5adc8299f@linux-foundation.org>
In-Reply-To: <20231006105012.61a12beefaa0f9a5adc8299f@linux-foundation.org>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 9 Oct 2023 06:22:14 -0700
Message-ID: <CAAa6QmTqk5bBMOMiuWP-92NcYN2XckXHpHLa8WJPysC2g8Mtxw@mail.gmail.com>
Subject: Re: [PATCH v4] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Fri, Oct 6, 2023 at 10:50=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 25 Sep 2023 13:01:10 -0700 "Zach O'Keefe" <zokeefe@google.com> wr=
ote:
>
> > The 6.0 commits:
> >
> > commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> > commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> >
> > merged "can we have THPs in this VMA?" logic that was previously done
> > separately by fault-path, khugepaged, and smaps "THPeligible" checks.
> >
> > During the process, the semantics of the fault path check changed in tw=
o
> > ways:
> >
> > 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> > 2) We no longer checked if non-anonymous memory had a vm_ops->huge_faul=
t
> >    handler that could satisfy the fault.  Previously, this check had be=
en
> >    done in create_huge_pud() and create_huge_pmd() routines, but after
> >    the changes, we never reach those routines.
> >
> > During the review of the above commits, it was determined that in-tree
> > users weren't affected by the change; most notably, since the only rele=
vant
> > user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> > explicitly approved early in approval logic. However, this was a bad
> > assumption to make as it assumes the only reason to support ->huge_faul=
t
> > was for DAX (which is not true in general).
> >
> > Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> > any ->huge_fault handler a chance to handle the fault.  Note that we
> > don't validate the file mode or mapping alignment, which is consistent
> > with the behavior before the aforementioned commits.
>
> It's unclear what are the userspace visible impacts of this change.
> Which makes it hard for others to determine whether -stable kernels
> should be patched.

IMO, I don't think this change is suitable for -stable; the only users
that would have been affected are those that maintain out-of-tree
drivers / code that hooked into ->huge_fault() or used VM_MIXEDMAP +
THP. No users of the in-tree kernel would have been affected. It's
still a good "fix" to make going forward (and certainly happy to be
able to help Saurabh out).

+ greg k-h for vis / to confirm.

> > Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> > Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
>
> It's nice to include a Closes: link after a Reported-by:.  Then readers
> are better able to answer the above question.

Ah, apologies, Andrew; I didn't know such a tag existed -- I'll be
sure to include it in the future.

> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: David Hildenbrand <david@redhat.com>
>
