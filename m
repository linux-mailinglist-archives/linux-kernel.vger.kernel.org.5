Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADE27FFC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjK3Uaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjK3Uad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:30:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317AC170D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfd9ce0745so1275ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701376239; x=1701981039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0GgAeTxou/WviiWghWlEQir3U8XoSLtDVw1f4rh7wk=;
        b=d4y9otrl3zoLccFUcDL6v7kOBnO5McfWqkdXQPXOZ6vu3Xh4oVh45HWVLekuY3EQUY
         jfQZPPTIb84AQBJHnPjwPHXZ4JFkqU64LexPu2NrdBFFdNbekOk6FBafFSjTtLWOJV6c
         V/u4Nph88NrnGUWxfjUzq/Fc1g50RUalOGiF8YloSSdeXEROClRsy3Ht5SKW4dr5lWjv
         lV7wRN4C7ale8qvvniBgqtLZt1FUDfgbDKH1Tw5aEjK4TqSxfrtlt5bUJJBJcik+X1wb
         Y2slW3GeHDD+zv1P9KUsIF0CA++aSwH9Fs7Qwh74vStWp56Dr+aLWkQdXzDGwVEyr59+
         UUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376239; x=1701981039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0GgAeTxou/WviiWghWlEQir3U8XoSLtDVw1f4rh7wk=;
        b=C9h7F6+tNDEn9RjsTDTzPHeYnhlkG67WBV/HQO4akMnzYIk4jk5ekniZyNM1jURS9Y
         LawdxRiNuCXI2NqS06HDAe5RzWT4ROV1BKoEvg65dtCbNqMZQyyceJyoEr5SXUvoL/PY
         SvRrkn7DHFfgSyC/BcXpbQd/ymTpi2EaLwRdP6c7b53U97H4KAAxXAUHcSPHcqir9wvS
         IHB/OW4X/WLdnP+fzp4RNsnv5QoofiI4OVxrHorwZ3qyIzrQcxhAcqRlbadoimyJDaov
         3TjiOM3iTDOlnCNJ5CQMwE98q+x55yMmQSsmSvoeGeCKhLv7VrpDXga8tkadYT0eCUDX
         33TQ==
X-Gm-Message-State: AOJu0Yz1W5L3blWI+640k9GVS3cXKMlEPFenZkefxNSp3RlyGjjBeVH4
        Zfs45wKW8TpiUydNDIAhVVM64r7Ja4KBe/qh2dqT4A==
X-Google-Smtp-Source: AGHT+IFALleiRKpy4be/3B0fJjnqsRAMk9mHiJRVXRJ1MUw9jngX/21Z5USdXgeYBJ7HRdM1SRQ30MFo8J0rdQZhK98=
X-Received: by 2002:a17:902:e812:b0:1c7:25e4:a9d5 with SMTP id
 u18-20020a170902e81200b001c725e4a9d5mr4421plg.17.1701376239428; Thu, 30 Nov
 2023 12:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka> <20231130165642.GA386439@cmpxchg.org> <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 30 Nov 2023 12:30:27 -0800
Message-ID: <CALvZod5dkpnF5h3u3cfdD4L8SExPZCXaPpt4fvpeVRiHPS8ySA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
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

On Thu, Nov 30, 2023 at 11:47=E2=80=AFAM Dan Schatzberg
<schatzberg.dan@gmail.com> wrote:
>
> On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> > [...]
> > So I wouldn't say it's merely a reclaim hint. It controls a very
> > concrete and influential factor in VM decision making. And since the
> > global swappiness is long-established ABI, I don't expect its meaning
> > to change significantly any time soon.
>
> I want to add to this last point. While swappiness does not have
> terribly well-defined semantics - it is the (only?) existing mechanism
> to control balance between anon and file reclaim. I'm merely
> advocating for the ability to adjust swappiness during proactive
> reclaim separately from reactive reclaim. To what degree the behavior
> and semantics of swappiness change is a bit orthogonal here.

Let me ask my question in this chain as it might have been missed:

Whatever the semantics of swappiness are (including the edge cases
like no swap, file_is_tiny, trim cache), should the reclaim code treat
the global swappiness and user-provided swappiness differently?
