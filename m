Return-Path: <linux-kernel+bounces-12857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B281FB40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF61F23F36
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549EB10945;
	Thu, 28 Dec 2023 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4VIuaT64"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B210947
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso698455ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703796754; x=1704401554; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S788tp3IyJJGZzIwxLHgTA4XtDw+UIahU/ujGgekUjs=;
        b=4VIuaT64H1q3F/1QIroidqb8/tFm6CxIPexsb1EpqvyOAILt46luAZClmdgwl/r3ko
         MoQxhQAo5EnwYZ6pPLg0PDj4D+STFxqi8cXpLHEEu+NZg3rM3o2i90bBPwTHi8qiBmj+
         6xkL2NNvF4QTiqf7fyi3K/3dltVEvvgUeM+TPmioPiqLz1EjU0pVr5Le14Mmg56yEyEl
         Ec6vnTsGC1v6b4KVDoV6+VSzdziqZ0q6lOkzNCMInaLMXObEdmjNY1+MV9fwCMhNCwU/
         4bp4rmuq+URqic1tHzu6EOpFBwPk0IDR5OR0sRvEwZmcJ5MVMZXDqScYwINZ0jxLV9yG
         vf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703796754; x=1704401554;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S788tp3IyJJGZzIwxLHgTA4XtDw+UIahU/ujGgekUjs=;
        b=W9dJEClVWy+efYWqvoLawij1olCpP3+tQ6KiBIV6bq1AXga0Di+T209ykh7i0xHv28
         KONUWve7sDnpj4oi4q3EcOT2l1FeoFxN9XOY3j3Uv9EKktkHceoWVpOQmMIoTTp0rx8w
         QA8b6GU2JLPePI4R/CT6cFtyS7ZhIgk4e9RIV9XpWPO9LfHV74QgxDrgCpkwxGtxwOYL
         GsDmgqGjOzCMrQIYKLGMWWjlVEGI7h2LRqo3AVWbnTTbWQtrUeMwJgG0qsWPuPlIaM9A
         hx7f68a3pA8TM9hG2IQ6+tjQB0ptGVIJ1cHHsD+Hyt3z+0Er1tftSNRmatayz6uHC8Ke
         /D6Q==
X-Gm-Message-State: AOJu0YyPDFFrbY5BHOyxD0BEp4njNCwphZ2lDhkQQpad+Ka7One+JVbj
	hebmG3kdHorGlm3XWw9nvKz9Yrposgoi
X-Google-Smtp-Source: AGHT+IGlbqQLYbN6grmwp2KQNqREMnkwdmeje4MbNj3wZpkS6osclrkD9IvJ/FUiRZL1Hu3H0NWZtQ==
X-Received: by 2002:a17:902:ce85:b0:1d0:a45c:202 with SMTP id f5-20020a170902ce8500b001d0a45c0202mr771128plg.24.1703796753327;
        Thu, 28 Dec 2023 12:52:33 -0800 (PST)
Received: from [2620:0:1008:15:5eb6:dfb2:ff4b:8b64] ([2620:0:1008:15:5eb6:dfb2:ff4b:8b64])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001d1cd7e4acesm14344261plb.68.2023.12.28.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:52:32 -0800 (PST)
Date: Thu, 28 Dec 2023 12:52:32 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, rafael@kernel.org, 
    Andrew Morton <akpm@linux-foundation.org>, surenb@google.com, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, souravpanda@google.com
Subject: Re: Sysfs one-value-per-file (was Re: [PATCH] vmstat: don't auto
 expand the sysfs files)
In-Reply-To: <2023122824-washout-shrubs-1d6d@gregkh>
Message-ID: <829410ca-1454-968e-b724-0ef0bfbca5cc@google.com>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com> <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com> <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com> <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
 <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com> <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com> <2023122824-washout-shrubs-1d6d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 28 Dec 2023, Greg Kroah-Hartman wrote:

> > I'd argue that the ship on the "sysfs one-value-per-file rule" has sailed 
> > for long-standing use cases where either (1) switching is just not 
> > possible or (2) switching would be an undue burden to the user.
> > 
> > An example of (1) would be THP enablement and defrag options:
> > 
> > $ grep . /sys/kernel/mm/transparent_hugepage/{defrag,enabled,shmem_enabled}
> > /sys/kernel/mm/transparent_hugepage/defrag:always defer defer+madvise [madvise] never
> > /sys/kernel/mm/transparent_hugepage/enabled:[always] madvise never
> > /sys/kernel/mm/transparent_hugepage/shmem_enabled:always within_size advise [never] deny force
> > 
> > This convention isn't going to change.  We're not going to suddenly add a 
> > new enablement or defrag option that can only be set in a newly added 
> > file that is one-value-per-file.
> > 
> > THP was obviously introduced before any sysfs "one-value-per-file rule" 
> 
> No, the rule has been there since "day one" for sysfs, this file snuck
> in much later with no one noticing it against the "rules" and I've been
> complaining about it every time someone tries to add a new field to it
> that I notice.
> 

Ah, gotcha, thanks.  I had assumed that the push for one-value-per-file 
started after thp, and perhaps even because of thp :)  I have to admit 
that whenever I log into a new server type one of the first things I do is

$ cat /sys/devices/system/node/node*/distance

and that table just makes intuitive sense.  If we were to go back in time 
and reimplement that as one-value-per-file, I'd just assume that many 
userspace implementations would just need to read 64 different files to 
structure it into the same exact table.

On the other hand, I have wished countless times that the thp settings 
would have actually been one-value-per-file from the start.

