Return-Path: <linux-kernel+bounces-15084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AD822717
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F41B22473
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164694A28;
	Wed,  3 Jan 2024 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zkgl1Y5z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3BA4A17
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso41055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 18:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704249376; x=1704854176; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v52EQ/A6TAXr6Z6qExZ1s4TncM4K58Y7qBR/ZAdYtZw=;
        b=zkgl1Y5zMfOgL4mgoVIgXA+R42WJsUf0x52qHk2ZZ+9OH+mQUwQFMSUWECiZAyA2JJ
         41mViPrXyloIXsAJeE76Zr5LjmpTehUvWhiK3Z4L00dlyPknfmgRnfvD1hrARUEW95l+
         nskDPCYfzusA+Fr4bWUu7kjlPfbzpL1lRwef98qHIKc+9fX+KM5+L1ZxyEUveu0rjLdt
         VC5hxU1nb1LOLDRgzV0p8In+l63sBxQERjoRa2Z34NLcv1HY0bFEJOd4DMGBScQJPgWD
         WU1xA4ZcK2m+Vqbtqve8i6NgFN7uNkYLfsWNBQhYUutukX5uWVBDOqSJn4wK1PzTJaet
         VvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704249376; x=1704854176;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v52EQ/A6TAXr6Z6qExZ1s4TncM4K58Y7qBR/ZAdYtZw=;
        b=M4q7dc6FnCE43UcIP2KYBpZO01W7+txKYXV/XjdxGA7tivJiRg/j6mhUvdnuSKAKGN
         0Rj0786iDQvJt0BYYtJhY6MP6OSONCaJ4bCvhrkfAgqzeAYzVQctqpCSB2gBbzgLedr1
         A1HXwZJZK9mTpdzeY0bB48UI+eXhKbEtT2Dki0/CHFrp2oIWirQKNunoHxpK6y+UNB/I
         CfR9qjANQjNMk2HatMkJebvZMoYD2bHZtpiLYW0td3+3D+DpCOfUVyMmrArB/G9ZSPom
         5dCfzoveAKUq9wH0LekqjJmmhp3RTR1M5UtDzajKub4tywv47PyTEyEYGoAeLVu7+Zry
         UPjw==
X-Gm-Message-State: AOJu0YxUpCzWkt9sy+AxdEds2KP7T4lIlYvsro94eEX6vd/xicC9CEWZ
	5j/Nx/auKZKJ+n2pFdyAkRy2Wk0b0hXISMMGlfgoX1WvZOAC
X-Google-Smtp-Source: AGHT+IHRLCBiISoazm9mVZrqDO51ftpMM1MRJLgMJGTk721tHqv+vKNga7SoDo23wTY/QHS60Zi41g==
X-Received: by 2002:a17:902:ec85:b0:1d3:b085:5e4b with SMTP id x5-20020a170902ec8500b001d3b0855e4bmr84957plg.16.1704249376239;
        Tue, 02 Jan 2024 18:36:16 -0800 (PST)
Received: from [2620:0:1008:15:c73b:7876:89ec:9102] ([2620:0:1008:15:c73b:7876:89ec:9102])
        by smtp.gmail.com with ESMTPSA id si13-20020a17090b528d00b0028cbfdbd804sm336031pjb.45.2024.01.02.18.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 18:36:15 -0800 (PST)
Date: Tue, 2 Jan 2024 18:36:15 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Gang Li <gang.li@linux.dev>
cc: David Hildenbrand <david@redhat.com>, 
    Mike Kravetz <mike.kravetz@oracle.com>, 
    Muchun Song <muchun.song@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v3 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
In-Reply-To: <958bf051-e776-4cbf-ae3c-76ee82d55bcc@linux.dev>
Message-ID: <d6b8518b-9686-5766-d906-6b35edab2583@google.com>
References: <20240102131249.76622-1-gang.li@linux.dev> <20240102131249.76622-5-gang.li@linux.dev> <19b08bb8-1fbd-557b-2684-5c29c5c783e6@google.com> <958bf051-e776-4cbf-ae3c-76ee82d55bcc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Jan 2024, Gang Li wrote:

> On 2024/1/3 09:32, David Rientjes wrote:
> > Same error as v2:
> > 
> > mm/hugetlb.c:3315:53: warning: variable 'node' is used uninitialized
> > whenever '&&' condition is false [-Wsometimes-uninitialized]
> >          for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node,
> > &node_states[N_MEMORY]) {
> >          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > mm/hugetlb.c:1501:3: note: expanded from macro 'for_each_node_mask_to_alloc'
> >                  nr_nodes > 0 &&                                         \
> >                  ^~~~~~~~~~~~
> > mm/hugetlb.c:3342:38: note: uninitialized use occurs here
> >          list_add(&m->list, &huge_boot_pages[node]);
> >                                              ^~~~
> > mm/hugetlb.c:3315:53: note: remove the '&&' if its condition is always true
> >          for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node,
> > &node_states[N_MEMORY]) {
> >                                                             ^
> > mm/hugetlb.c:3310:7: warning: variable 'node' is used uninitialized whenever
> > 'if' condition is false [-Wsometimes-uninitialized]
> >                  if (!m)
> >                      ^~
> > mm/hugetlb.c:3342:38: note: uninitialized use occurs here
> >          list_add(&m->list, &huge_boot_pages[node]);
> >                                              ^~~~
> > mm/hugetlb.c:3310:3: note: remove the 'if' if its condition is always true
> >                  if (!m)
> >                  ^~~~~~~
> > mm/hugetlb.c:3304:20: note: initialize the variable 'node' to silence this
> > warning
> >          int nr_nodes, node;
> >                            ^
> >                             = 0
> > 2 warnings generated.
> > 
> 
> How did you get those warnings? I got nothing in my compilation.
> 

I'm using clang.

You spotted the issue in your earlier reply about the potentially 
uninitialized use of "node" when adding to the list.

