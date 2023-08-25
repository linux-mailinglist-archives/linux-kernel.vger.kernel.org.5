Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5B788C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHYPKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHYPJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:09:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0B2127
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:09:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so16212a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692976184; x=1693580984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gq9jP84cRzBl+sgoqLbq4czFux7bqHqPTg17tu5c2I=;
        b=RyctydAu22cbp3h3vbRM953UBzLWrLOTdnyk9vhHxdiLZi9tU1GIy8j6dDoLZrUEvT
         5lBY/92+L4PiJTQ5s8tkJqbB400jpopoDGPsbc3xoGk5nKBjfoN4WolBXCLd9kBsD6VO
         PiWTGrliNKrT0wTTGVpt2ZkwEgBQ8kbW7O6imKrFM3nKIgex83iLXruvVCFhAhkk7dGt
         TGbI+vrUqlpAlmw1t6La4Djd58YtohilqyAysq6OuG61WbTo986oqsleRRDuEY/DGcOj
         aUG9+3P0voNqK94zB/RjWKu17235i6wxPPbMHVvU6BkuufKzjvFeiU7Wqj6wOtp5qEZc
         Aemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692976184; x=1693580984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gq9jP84cRzBl+sgoqLbq4czFux7bqHqPTg17tu5c2I=;
        b=elvoc/BMJoiAn6YkpY51eQy2tvNUeY72LvOxlIxyGqezauLmZfAcITOE4r/RtofQQm
         KxZoL1K08TZcJ8ETCNA3sSPKq0eFj4y5H6hrqQKTPZ3jTC8lfQQUG3ahYDy1UUidhxqK
         CbgXMcydGLLAqHL+TGGre+Q3tzZuei+jz0qjtiq/YX3uRteIgGw3/NJqPSMEzyAv/vjR
         o+RscJdzP3zV8diR/NZH7MbN1Q2w6ox97Ku5K0G9COANXE3BCuGCPX96Vecq4EKllnfh
         J8U+eek8r6rmCA/oye+lfuwG+8ygEK8425Ws+JkaIJZXJPTEhSZnOuxjfOj7Hch9q4WW
         1TSQ==
X-Gm-Message-State: AOJu0YzxMAL5H0HqFJ8NgsV+c6KC2wD556FPAzCC8XcUGCsps+y2zwNe
        T8LDwkLmHtNliydpk13WCHtHMIf5BbAPoU+lIfLAMKOmuJeXNnjzIYqoOQ==
X-Google-Smtp-Source: AGHT+IHUSbWA6D7Kr7ih9MQvH+AX9k2ln5in8pCdueT+yk36uQ89b3zjjhcJfDCPyElxPO1Arxlzr+hUBFrnlLobzrE=
X-Received: by 2002:a50:9fa5:0:b0:523:d5bc:8424 with SMTP id
 c34-20020a509fa5000000b00523d5bc8424mr172162edf.5.1692976184443; Fri, 25 Aug
 2023 08:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230821234844.699818-1-zokeefe@google.com> <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com> <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
 <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com> <ZOijSwCa9NFD6DZI@casper.infradead.org>
 <9f967665-2cbd-f80b-404e-ac741eab1ced@redhat.com>
In-Reply-To: <9f967665-2cbd-f80b-404e-ac741eab1ced@redhat.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Fri, 25 Aug 2023 08:09:07 -0700
Message-ID: <CAAa6QmQRFwzXWHEL2d74sX6JuciJeBzprk1NxCWKB6i53gmt6Q@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
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

On Fri, Aug 25, 2023 at 5:58=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.08.23 14:49, Matthew Wilcox wrote:
> > On Fri, Aug 25, 2023 at 09:59:23AM +0200, David Hildenbrand wrote:
> >> Especially, we do have bigger ->huge_fault changes coming up:
> >>
> >> https://lkml.kernel.org/r/20230818202335.2739663-1-willy@infradead.org

FWIW, one of those patches updates the docs to read,

"->huge_fault() is called when there is no PUD or PMD entry present.  This
gives the filesystem the opportunity to install a PUD or PMD sized page.
Filesystems can also use the ->fault method to return a PMD sized page,
so implementing this function may not be necessary.  In particular,
filesystems should not call filemap_fault() from ->huge_fault(). [..]"

Which won't work (in the general case) without this patch (well, at
least the ->huge_fault() check part).

So, if we're advertising this is the way it works, maybe that gives a
stronger argument for addressing it sooner vs when the first in-tree
user depends on it?

> >> If the driver is not in the tree, people don't care.
> >>
> >> You really should try upstreaming that driver.
> >>
> >>
> >> So this patch here adds complexity (which I don't like) in order to ke=
ep an
> >> OOT driver working -- possibly for a short time. I'm tempted to say "p=
lease
> >> fix your driver to not use huge faults in that scenario, it is no long=
er
> >> supported".
> >>
> >> But I'm just about to vanish for 1.5 week into vacation :)
> >>
> >> @Willy, what are your thoughts?
> >
> > Fundamentally there was a bad assumption with the original patch --
> > it assumed that the only reason to support ->huge_fault was for DAX,
> > and that's not true.  It's just that the only drivers in-tree which
> > support ->huge_fault do so in order to support DAX.
>
> Okay, and we are willing to continue supporting that then and it's
> nothing we want to stop OOT drivers from doing.
>
> Fine with me; we should probably reflect that in the patch description.

I can change these paragraphs,

"During the review of the above commits, it was determined that in-tree
users weren't affected by the change; most notably, since the only relevant
user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
explicitly approved early in approval logic.  However, there is at least
one occurrence where an out-of-tree driver that used
VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.

Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
any ->huge_fault handler a chance to handle the fault.  Note that we
don't validate the file mode or mapping alignment, which is consistent
with the behavior before the aforementioned commits."

To read,

"The above commits, however, overfit the existing in-tree use cases,
and assume that
the only reason to support ->huge_fault was for DAX (which is
explicitly approved early in the approval logic).
This is a bad assumption to make and unnecessarily prevents general
support of ->huge_fault by filesystems. Allow returning "true" if such
a handler exists, giving the fault path an opportunity to exercise it.

Similarly, the rationale for including the VM_NO_KHUGEPAGED check
along the fault path was that it didn't alter any in-tree users, but
was likewise similarly unnecessarily restrictive (and reads odd).
Remove the check from the fault path."

> >
> > Keeping a driver out of tree is always a risky and costly proposition.
> > It will continue to be broken by core kernel changes, particularly
> > if/when it does unusual things.
> >
>
> Yes.
>
> > I think the complexity is entirely on us.  I think there's a simpler wa=
y
> > to handle the problem, but I'd start by turning all of this "admin and
> > app get to control when THP are used" nonsense into no-ops.
>
> Well, simpler, yes, but also more controversial :)
>
> --
> Cheers,
>
> David / dhildenb
>
