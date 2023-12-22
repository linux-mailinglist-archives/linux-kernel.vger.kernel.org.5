Return-Path: <linux-kernel+bounces-9362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BF81C49A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BA41F24FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C4B664;
	Fri, 22 Dec 2023 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCx9S3m7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912AB64C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3fde109f2so70465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703222094; x=1703826894; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EpVJPwV8xdpCi/BHsDHoW6FS2qv5qcoyo7OpZbQn6A=;
        b=WCx9S3m7pk1lihD5xJoDSKjIa9xo9tRYe3zQ9eUez0o1qJW2zagmSpFDObFRmIOdTi
         k9ox3oU6BN6FwFNEIhoJ4EnwYJ2XexVBJ9lrkW57IXwNsquUGo9b/yLgaPydp85awA3x
         NY1E/d0fvasvkSRJaMbcPKQrwPbcYkTBBFKTMi9s8c2MEkl71AbPei+bAAmN6V9Sw509
         fh4pHV8g9Acn0MfpYf2N3iEaWxWWIn/fVDGEY1L7Xb936i2pZ+UGlLOFaQzW0KvrMCDz
         LksD8UqiJlhaXYAm7zWWeADf+Nm6vfy0Dg3PgScKI4my/ECTWEeUfk/AFDQDulrncwTz
         cDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703222094; x=1703826894;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EpVJPwV8xdpCi/BHsDHoW6FS2qv5qcoyo7OpZbQn6A=;
        b=DcHcmwGtmrPZ0BYJhiACMhe56WEHCh9/ry3c59UolRzKssaIHGAZVNtAzTd4uK2rUh
         F9T2bYzGqxzfz8T3EgpzxF9ZxD7v2/B6Z8C/E7ufnRJFmyP/6i3XjjTNqtHXogkasmhV
         6MjdQEEHVpniCx6BBoLfFLAvMNgz35/W04GDY9fT4jCn/zTpsg4vI1fk93sSbg6ttZst
         +BLa5l0CwRqDo5ixE93dKQfyp/GOV92oCYNXcB9DWg+FzOYSUb/9h6IGO8o4ttn+0qod
         gkO9GBEW531besfC2QEp2Lh515wRxuE02bAl/SD71M/0SbxhjDhA2n3FsrX40n0LO9aG
         oGgw==
X-Gm-Message-State: AOJu0Yya0eHh+h7R4e0saUcnjZRjTm4HDQTy58NK15yAGR8CLdu12cXE
	T4al7UlIF52nRHdt4vrGnuseB8Z986gK
X-Google-Smtp-Source: AGHT+IGwoh3X7adS7L4evXjC4NNt2+Ju49v+fiMnSiMHHPnVEmAeTX8TfE9pYRDSDNridjP5qtla6A==
X-Received: by 2002:a17:903:2310:b0:1d3:dc24:31c with SMTP id d16-20020a170903231000b001d3dc24031cmr61138plh.3.1703222094173;
        Thu, 21 Dec 2023 21:14:54 -0800 (PST)
Received: from [2620:0:1008:15:a7bc:c7f0:fb7e:556d] ([2620:0:1008:15:a7bc:c7f0:fb7e:556d])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090ad71500b0028b43d3250csm2653671pju.43.2023.12.21.21.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 21:14:53 -0800 (PST)
Date: Thu, 21 Dec 2023 21:14:52 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Yu Zhao <yuzhao@google.com>
cc: Henry Huang <henry.hj@antgroup.com>, yuanchu@google.com, 
    akpm@linux-foundation.org, 
    =?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    =?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
In-Reply-To: <CAOUHufZwXBs4x7GeawrjZNEwTBdV=mf-DYrZuF4j=10URHwQTw@mail.gmail.com>
Message-ID: <931f2e6d-30a1-5f10-e879-65cb11c89b85@google.com>
References: <CAJj2-QGqDWGVHEwU+=8+ywEAQtK9QKGZCOhkyEgp8LEWbXDggQ@mail.gmail.com> <20231222024458.12441-1-henry.hj@antgroup.com> <CAOUHufZwXBs4x7GeawrjZNEwTBdV=mf-DYrZuF4j=10URHwQTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003067076-520779642-1703222093=:711362"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003067076-520779642-1703222093=:711362
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 21 Dec 2023, Yu Zhao wrote:

> > Thanks for replyting.
> >
> > On Fri, Dec 22, 2023 at 07:16 AM Yuanchu Xie wrote:
> > > How does the shared memory get charged to the cgroups?
> > > Does it all go to cgroup A or B exclusively, or do some pages get
> > > charged to each one?
> >
> > Some pages get charged to cgroup A, and the other get charged to cgroup B.
> 
> Just a side note:
> We can potentially "fix" this, but it doesn't mean this is a good
> practice. In fact, I think this is an anti-pattern to memcgs:
> resources should be preferably isolated between memcgs, or if a
> resource has to be shared between memcgs, it should be charged in a
> predetermined way, not randomly to one of the memcgs sharing it.
> 

Very interesting thread, a few questions for Henry to understand the 
situation better:

 - is the lack of predeterministic charging a problem for you?  Are you
   initially faulting it in a manner that charges it to the "right" memcg
   and the refault of it after periodic reclaim can causing the charge to
   appear "randomly," i.e. to whichever process happened to access it 
   next?

 - are pages ever shared between different memcg hierarchies?  You 
   mentioned sharing between processes in A and A/B, but I'm wondering
   if there is sharing between two different memcg hierarchies where root
   is the only common ancestor?

 - do you anticipate a shorter scan period at some point?  Proactively
   reclaiming all memory colder than one hour is a long time :)  Are you
   concerned at all about the cost of doing your current idle bit 
   harvesting approach becoming too expensive if you significantly reduce
   the scan period?

 - is proactive reclaim being driven by writing to memory.reclaim, by
   enforcing a smaller memory.high, or something else?

Looking forward to learning more about your particular issue.
--2003067076-520779642-1703222093=:711362--

