Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D77FFDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377000AbjK3Vwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbjK3Vwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:52:32 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03C110FC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:52:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc79f73e58so17565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701381158; x=1701985958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfe9+yUHQWvFF1MBxcyQEWLBB5xhP4R/v24MyHrer70=;
        b=0tepH5WbTQDmSBXXhFxxics+9wndxDVEo7hFze81ihmWMaiRmp5254VIEOZUvOB2wy
         63Qz9piC+Lk2GItfcKvudo3r8eRj/CzXqt8K9Bk6YQ0RML4NkmI1AQkplvtJPgklBcRq
         7bygYxKAHNltIvNwgTw4FbmO9w4OBnv30ciCcl+Ebin1e9u+XaLmOB+rsUtPWfP/IpA5
         KMO2KVrbWJY41zRN39DEthXOHRp1HyBD1jTFnbCrOL//YsRXNnejbq3Rz8Rw5JQYm1Ap
         AW7V/g7UvGAeGTm6zPCqE1aMbQl1mTHDiCRmHQ3gKSeM1EX0nLOAkKSmvHeY6v/8yTKB
         EpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381158; x=1701985958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sfe9+yUHQWvFF1MBxcyQEWLBB5xhP4R/v24MyHrer70=;
        b=I5zuPCh9ZiJ02641WkDTVBx5MxFe58gVx05Dg+FOCSTmiAlg6unAdThMUlSmrUzzqO
         KQwnrOUFJlLEalkOXv2Kpd7Uj6KHAjoReNqwVUTT0qKHNvRkkwNVvKgmVjhnGqQ/ejI8
         CqE5VSjKEX6sMl2deQrHApWf+7PVlfriSUypPYUIRCOnwAiwKDNyZfe901uyV7KTiIQ+
         endAiO+1WRMoomMKqavtisvrM64axsxLqjqFqOdwGyB78dwUFI/Pw//ORPGmpXkWO2p3
         x61+3oWBnJ8wQ7plgJfb6DiMcIGjlfsLrv53xCQu/lzTcMghXApmf8xmvKf13juRWF02
         EjUQ==
X-Gm-Message-State: AOJu0YyDEOGKWls+/twM6D+bIBMLRhraI2Q4SmW64AoY/xVN8bdYC2yO
        YNbFn5ZNpJbc8IeUG0Vd0s0Ex/UQrux/SQB3QI5jgg==
X-Google-Smtp-Source: AGHT+IEScePdJsCv50KSaFJEK6pXwpZ9MhWwQ6fW0VE537kDsUCVBfYIWXio57IpD3sjKnP6BGpD7VHJg69DMzuDouE=
X-Received: by 2002:a17:902:b684:b0:1cf:b218:25c7 with SMTP id
 c4-20020a170902b68400b001cfb21825c7mr39731pls.0.1701381157613; Thu, 30 Nov
 2023 13:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka> <20231130165642.GA386439@cmpxchg.org>
 <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV> <CALvZod5dkpnF5h3u3cfdD4L8SExPZCXaPpt4fvpeVRiHPS8ySA@mail.gmail.com>
 <ZWkAiZ+Wx6VwRAPu@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZWkAiZ+Wx6VwRAPu@dschatzberg-fedora-PF3DHTBV>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 30 Nov 2023 13:52:26 -0800
Message-ID: <CALvZod7Buc1TPXFDA2fE8+apE9VJDA=uAYB1u00kyZy9oLbmgA@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 1:37=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> On Thu, Nov 30, 2023 at 12:30:27PM -0800, Shakeel Butt wrote:
> > On Thu, Nov 30, 2023 at 11:47=E2=80=AFAM Dan Schatzberg
> > <schatzberg.dan@gmail.com> wrote:
> > >
> > > On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> > > > [...]
> > > > So I wouldn't say it's merely a reclaim hint. It controls a very
> > > > concrete and influential factor in VM decision making. And since th=
e
> > > > global swappiness is long-established ABI, I don't expect its meani=
ng
> > > > to change significantly any time soon.
> > >
> > > I want to add to this last point. While swappiness does not have
> > > terribly well-defined semantics - it is the (only?) existing mechanis=
m
> > > to control balance between anon and file reclaim. I'm merely
> > > advocating for the ability to adjust swappiness during proactive
> > > reclaim separately from reactive reclaim. To what degree the behavior
> > > and semantics of swappiness change is a bit orthogonal here.
> >
> > Let me ask my question in this chain as it might have been missed:
> >
> > Whatever the semantics of swappiness are (including the edge cases
> > like no swap, file_is_tiny, trim cache), should the reclaim code treat
> > the global swappiness and user-provided swappiness differently?
>
> I can't think of any reason why we would want swappiness interpreted
> differently if it's provided at proactive reclaim time vs
> globally. Did you have something in mind here?

Nah just wanted to know what you are aiming for.
