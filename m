Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE597E2ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjKFVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:17:56 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC27AF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:17:52 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9dd5879a126so495790366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699305471; x=1699910271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAnPepekn0x1vd4cfhce4CIyWaNk1MulfdxYt46UIgc=;
        b=PznbsALXkm9uyk2DK9Bo6VJORe44GAcpckaeSL0s/gISyJJCpflPlY/Q8OHZ2mmUNj
         /UMY8SCsGiPoKmi1eXiwgEQd3TY8/g2ohz0EFG6ZR5KCrw9TWjiYSi4jfgjm3eeIlfTO
         kPI8puQk6RMmQIGmy/Z26pK6+FtjVRrDv51kscsaWD/iq0VCC7XiI2DGpWD38Jv0O1r+
         nTIGhPs92ipifQCWBlnSdkBaEtF5IqStVro4nRgV0qjhBhnOdEUknZvUnoblNgOiY6+k
         Dhh4CstswOIYvHmrOlt7E/YvZYiR5DSXvA4JHxAvZfArHi6vmGF48yVDU3kvh014grg9
         2OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305471; x=1699910271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAnPepekn0x1vd4cfhce4CIyWaNk1MulfdxYt46UIgc=;
        b=LjAheVYdmEeWASkvXMA6kYGW4W3CtnLGph0GEpiVf3pcYEBToiPTk9Ri1PnbzBmsoy
         XxjnfpaumnP9rNUJc8V8ft2RxBHlSdWYZUCQLm/crvJjW5npss27+B/P9ypjmojinPs8
         Wr3sTNkzvrzhnze34lHzya9V4rI10gVlBfc9X/9lM8KCujE1yuP58a5MqtEp5gszpBjH
         5fJpHHJZqGHv88GmBLYInyX/b8YZUvAtASYNoB97FhxnhSRlspFumAf2eJiMfQtndZsG
         +qa2mNigNfaMigEgIQdvzNuZeWsjliaAOYbWvF/usTtJyORHnvYADjBcW0kaTbefFS2Z
         fpjw==
X-Gm-Message-State: AOJu0Yyj7OK7BUsLqTHd9nftaxzgFewe0aO5rAzfAOcQ1uIJ3Gor8sJ/
        x/9VC/rEkStRmwf48T6/DYZ7Tm2olQppASm7vbrrdw==
X-Google-Smtp-Source: AGHT+IGOjsdVz/kagTQoVD1M4q/hpjgaTIGdDmAJ91afhh21ti6yIDPUL1wxJ28xkf3TBI5vb5Wymu1dBshzViRM6SE=
X-Received: by 2002:a17:907:7295:b0:9bf:30e8:5bf9 with SMTP id
 dt21-20020a170907729500b009bf30e85bf9mr14245983ejc.4.1699305471174; Mon, 06
 Nov 2023 13:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20231104031303.592879-1-longman@redhat.com> <20231104031303.592879-3-longman@redhat.com>
 <CAJD7tkZirDce=Zq9bm_b_R=yXkj1OaqCe2ObRXzV-BtDc3X9VQ@mail.gmail.com> <2212f172-def9-3ec7-b3d7-732c2b2c365e@redhat.com>
In-Reply-To: <2212f172-def9-3ec7-b3d7-732c2b2c365e@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Nov 2023 13:17:14 -0800
Message-ID: <CAJD7tkYmSAg_T289jRczARsXu2sCW0GrR9VPyL04fQRKzCK0hg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 12:37=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 11/6/23 15:07, Yosry Ahmed wrote:
> > On Fri, Nov 3, 2023 at 8:13=E2=80=AFPM Waiman Long <longman@redhat.com>=
 wrote:
> >> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
> >> the updated tree in a way to pop out the leaf nodes first before
> >> their parents. This can cause traversal of multiple nodes before a
> >> leaf node can be found and popped out. IOW, a given node in the tree
> >> can be visited multiple times before the whole operation is done. So
> >> it is not very efficient and the code can be hard to read.
> >>
> >> With the introduction of cgroup_rstat_updated_list() to build a list
> >> of cgroups to be flushed first before any flushing operation is being
> >> done, we can optimize the way the updated tree nodes are being popped
> >> by pushing the parents first to the tail end of the list before their
> >> children. In this way, most updated tree nodes will be visited only
> >> once with the exception of the subtree root as we still need to go
> >> back to its parent and popped it out of its updated_children list.
> >> This also makes the code easier to read.
> >>
> >> A parallel kernel build on a 2-socket x86-64 server is used as the
> >> benchmarking tool for measuring the lock hold time. Below were the loc=
k
> >> hold time frequency distribution before and after the patch:
> >>
> >>       Hold time        Before patch       After patch
> >>       ---------        ------------       -----------
> >>         0-01 us        13,738,708         14,594,545
> >>        01-05 us         1,177,194            439,926
> >>        05-10 us             4,984              5,960
> >>        10-15 us             3,562              3,543
> >>        15-20 us             1,314              1,397
> >>        20-25 us                18                 25
> >>        25-30 us                12                 12
> >>
> >> It can be seen that the patch pushes the lock hold time towards the
> >> lower end.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> > I don't know why git decided to show this diff in the most confusing
> > way possible.
> I agree. The diff is really hard to look at. It will be easier to apply
> the patch & looks at the actual rstat.c file.

Would the diff be simpler if patches 1 & 2 were squashed?

[..]
> >
> >>    *
> >>    * The only ordering guarantee is that, for a parent and a child pai=
r
> >> - * covered by a given traversal, if a child is visited, its parent is
> >> - * guaranteed to be visited afterwards.
> >> + * covered by a given traversal, the child is before its parent in
> >> + * the list.
> >> + *
> >> + * Note that updated_children is self terminated while updated_next i=
s
> >> + * parent cgroup terminated except the cgroup root which can be self
> >> + * terminated.
> > IIUC updated_children and updated_next is the same list.
> > updated_children is the head, and updated_next is how the list items
> > are linked. This comment makes it seem like they are two different
> > lists.
> Thanks for the comment. I will rework the comment to clarify that a bit
> more.
> >
> > I am actually wondering if it's worth using the singly linked list
> > here. We are saving 8 bytes percpu, but the semantics are fairly
> > confusing. Wouldn't this be easier to reason about if you just use
> > list_head?
> >
> > updated_children would be replaced with LIST_HEAD (or similar), and
> > the list would be NULL terminated instead of terminated by self/parent
> > cgroup. IIUC the reason it's not NULL-terminated now is because we use
> > cgroup->updated_next to check quickly if a cgroup is on the list or
> > not. If we use list_heads, we can just use list_emtpy() IIUC.
> >
> > We can also simplify the semantics of unlinking @root from the updated
> > tree below, it would just be list_del() IIUC, which is actually more
> > performant as well. It seems like overall we would simplify a lot of
> > things. When forming the updated_list, we can just walk the tree and
> > splice the lists in the correct order.
> >
> > It seems to me that saving 8 bytes percpu is not worth the complexity
> > of the custom list semantics here. Am I missing something here?
>
> It will cost an additional 16 bytes of percpu memory if converted to
> list_heads. Like other lists, there will be sibling and children
> list_heads. There are also 2 pointers to update instead of one. Anyway,
> I don't have an objection to convert them to list_heads if agreed by Teju=
n.

Yes you are right. It's definitely not free, but it's also not super
costly. It's just that every time I look at the rstat code I need to
remind myself of how updated_next and updated_children work. I will
let Tejun decide.
