Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6D17B0E32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjI0Vjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjI0Vjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:39:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606E2122
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:39:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59f6492b415so112439667b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695850775; x=1696455575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmIn/dsnWBGcOkNyP3wbdNzRj2XOsqPnxvNyHRusvkY=;
        b=gxXSZZlVNU528/50fdr+jfPDJ4hkFDA/+wX9r6IbldCcW30VSS302JjYkwzescC30X
         6A+CTMLvaC8n4vye5xNolesnq/hSTHZ/mpiQQJEZpI6Z4SF54EcB3fsxrPf+fDlQ9/Vf
         tL4csEhmWrwpT0jneBz6HKsJRefRLHywM78CHsDYLqtATTwrUOVNtw7pR+NXux05jz5a
         bFJuDaiHeDwX4r/deAjyoFgLmCsiAZk6Q0TVipGZHq1s+iZTGAJDFnTvfALJ6KhxQr+E
         KJLqZUuVkEwUiIKdM/K8coopSgNDfx2B2dyGETyNnAtMiz2Wh61FClYbzW45TAZudaby
         dx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850775; x=1696455575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmIn/dsnWBGcOkNyP3wbdNzRj2XOsqPnxvNyHRusvkY=;
        b=SJAJ6RU8us48qVC1g4nOCdqWMq5Vnypy8p435JPXk+13cyoYuE9S5KEYzhCiy2z3lh
         zCCCQnSqY/oDq6J+D8MO1Xd7Hka/m10uKnvZWPfUU3ThgjFLt7mTxrsNqI+1xInkjIK2
         PBIRTLAhAo/qhzU7VQL8ldcJqGpuAFWFbE6G5O8G0acouxg9q5MWebkjhNz+U6AbtHjR
         YGc54gjcgiphNr3EUbf+Whu4wTBdUq46jp5mNK+k/DXhNVSg4rTvHAvqkZVcKh2U3lwC
         DQr82gM+eIW8fjfzu7rvYQTmyAfv7oleL7tTC54sQ+LfSqhO0VfqyymwXT+AouTpDrhG
         fk1Q==
X-Gm-Message-State: AOJu0YxyvdfhfSvqrnNWGCfWeI99H2hC6IFsyAmY8Y/FIeJwNv+4J4T+
        /MdzcQA6bGoZknDWuweEdGgEy9ARS57e06RXUqP4ow==
X-Google-Smtp-Source: AGHT+IEgtxvEZTS7nj888nK+ibjNHsD4ifyjOceNKNWggrpLBaTJimKk+ph8GiVbZOQYshyOmycJsvLK022QeVxaMwY=
X-Received: by 2002:a81:52cd:0:b0:570:2542:cc9b with SMTP id
 g196-20020a8152cd000000b005702542cc9bmr2585219ywb.18.1695850775325; Wed, 27
 Sep 2023 14:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230920223242.3425775-1-yang@os.amperecomputing.com>
 <20230925084840.af05fefd19a101c71308a8cf@linux-foundation.org> <90fc0e8d-f378-4d6f-5f52-c14583200a2e@os.amperecomputing.com>
In-Reply-To: <90fc0e8d-f378-4d6f-5f52-c14583200a2e@os.amperecomputing.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Sep 2023 14:39:21 -0700
Message-ID: <CAJuCfpExMWXHfZjgZ=UKf4k=zxrNOLx2R-a_wQdZ3O_+JTOq4w@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
 MPOL_MF_MOVE are specified
To:     Yang Shi <yang@os.amperecomputing.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        willy@infradead.org, mhocko@suse.com, vbabka@suse.cz,
        osalvador@suse.de, aquini@redhat.com, kirill@shutemov.name,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:16=E2=80=AFAM Yang Shi <yang@os.amperecomputing.=
com> wrote:
>
>
>
> On 9/25/23 8:48 AM, Andrew Morton wrote:
> > On Wed, 20 Sep 2023 15:32:42 -0700 Yang Shi <yang@os.amperecomputing.co=
m> wrote:
> >
> >> When calling mbind() with MPOL_MF_{MOVE|MOVEALL} | MPOL_MF_STRICT,
> >> kernel should attempt to migrate all existing pages, and return -EIO i=
f
> >> there is misplaced or unmovable page.  Then commit 6f4576e3687b
> >> ("mempolicy: apply page table walker on queue_pages_range()") messed u=
p
> >> the return value and didn't break VMA scan early ianymore when MPOL_MF=
_STRICT
> >> alone.  The return value problem was fixed by commit a7f40cfe3b7a
> >> ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is speci=
fied"),
> >> but it broke the VMA walk early if unmovable page is met, it may cause=
 some
> >> pages are not migrated as expected.
> > So I'm thinking that a7f40cfe3b7a is the suitable Fixes: target?
>
> Yes, thanks. My follow-up email also added this.
>
> >
> >> The code should conceptually do:
> >>
> >>   if (MPOL_MF_MOVE|MOVEALL)
> >>       scan all vmas
> >>       try to migrate the existing pages
> >>       return success
> >>   else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
> >>       scan all vmas
> >>       try to migrate the existing pages
> >>       return -EIO if unmovable or migration failed
> >>   else /* MPOL_MF_STRICT alone */
> >>       break early if meets unmovable and don't call mbind_range() at a=
ll
> >>   else /* none of those flags */
> >>       check the ranges in test_walk, EFAULT without mbind_range() if d=
iscontig.

With this change I think my temporary fix at
https://lore.kernel.org/all/20230918211608.3580629-1-surenb@google.com/
can be removed because we either scan all vmas (which means we locked
them all) or we break early and do not call mbind_range() at all (in
which case we don't need vmas to be locked).

> >>
> >> Fixed the behavior.
> >>
>
