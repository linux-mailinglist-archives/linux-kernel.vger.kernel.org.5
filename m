Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2420F77092A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHDTlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHDTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:41:38 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386EE1BF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:41:37 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so2750498276.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691178096; x=1691782896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHMki7/FqDD8zTNQC+pLkhxz8kuXqcTnPlOuRvnVTtE=;
        b=Vt5J/SYoA2BETosVLi1Z8rDMJ7C1tMwsq0wbp+Y+7Xe+E8oMkTdmh8xQS2K/M4rgLS
         qaMb2FAc38/A8ejy72BXIC5uOrzmyaQMRfxOq2uxN5W9WwYlvQMgrAc54upZEZHGZ8gj
         c6DIfMyXr5q0L3mbNnZkPrSaKymGkPBY3y+ndOBprsxSy2tRplQIhkBTaxOSmiTxcMd2
         6gfZdCozLV0NV6CyRgiBE8ubbhhvi5mAuTUDKWXkaVgLtfJcS+X84kQMDTVrP7Fb8aRy
         9Rp9VD5tt95j+z55dJsJsOwixY0SHp9pq/IjlFhPlXbVKuL0kNzYc98IijW8e/RLGGa4
         c2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691178096; x=1691782896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHMki7/FqDD8zTNQC+pLkhxz8kuXqcTnPlOuRvnVTtE=;
        b=CaUyKhOTA91ChcAtpG/2Z7pZATI6HYRTs8Nf3hwHiwjtUxAAE2rVqI7VOwG02OU6Au
         JHERPunVOH5OGgDncPoCuSaep7zVOPpy4ZdwNorhzGZhGJEttCWg7j4OpQNA5VE4P4Uy
         +TQRn06QF9KmkZ41wEkPjrq0rtGsk3DzdIxlWowrVbtgHhREgscd21xiOio+4xXdqTKq
         WYRcAn5Ib8kgCcyF3p6bMI72O5Qwthlu++8WXrz5dD2B6OEugr0e1XpjBgLblobZqa5h
         HDqiyqSAdSzMKeRaBcToiql3UPmPW+aBfO3sGNgYQZjwgLrf9qbBwzN081J9x/X3q1uY
         YbZA==
X-Gm-Message-State: AOJu0YwHhmcYG55E2IX7S4jemHsMUZAlukunJOl7DAhh4dwSAcuRPtu8
        qySpygOlJbUIV/eGmC7hT29PiCeLA0Q9PaSQSlSJgQ==
X-Google-Smtp-Source: AGHT+IFbAJ3wcgQP1rxqmFG9jFoIPPqOhwLHRY5JeMk6aighD1yYuboh5YvVtU33dQQ7NA7e7n4hn7JdaWdEvd2TVqQ=
X-Received: by 2002:a25:2043:0:b0:d0e:fc28:3777 with SMTP id
 g64-20020a252043000000b00d0efc283777mr2153163ybg.9.1691178096206; Fri, 04 Aug
 2023 12:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com> <20230804152724.3090321-2-surenb@google.com>
 <20230804121416.533bb81336ded8f170da097e@linux-foundation.org>
In-Reply-To: <20230804121416.533bb81336ded8f170da097e@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Aug 2023 12:41:23 -0700
Message-ID: <CAJuCfpHNURUbyxRTaVLigo-Keyff60i_dSp9YCESQXTs98tzNQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm: enable page walking API to lock vmas during
 the walk
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, kernel-team@android.com,
        Linus Torvalds <torvalds@linuxfoundation.org>
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

On Fri, Aug 4, 2023 at 7:14=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri,  4 Aug 2023 08:27:19 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > walk_page_range() and friends often operate under write-locked mmap_loc=
k.
> > With introduction of vma locks, the vmas have to be locked as well
> > during such walks to prevent concurrent page faults in these areas.
> > Add an additional member to mm_walk_ops to indicate locking requirement=
s
> > for the walk.
> >
> > ...
> >
> >  18 files changed, 100 insertions(+), 20 deletions(-)
> >
>
> That's a big patch for a -stable backport.
>
> Presumably the various -stable maintainers will be wondering why we're
> doing this.  But, as is so often the case, the changelog fails to
> describe any user-visible effects of the change.  Please send this info
> and I'll add it to the changelog.

The change ensures that page walks which prevent concurrent page
faults by write-locking mmap_lock, operate correctly after
introduction of per-vma locks. With per-vma locks page faults can be
handled under vma lock without taking mmap_lock at all, so write
locking mmap_lock would not stop them. The change ensures vmas are
properly locked during such walks. A sample issue this solves is
do_mbind() performing queue_pages_range() to queue pages for
migration. Without this change a concurrent page can be faulted into
the area and be left out of migration.

>
>
