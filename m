Return-Path: <linux-kernel+bounces-11741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84781EB09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD371F22B11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E7C1FB5;
	Wed, 27 Dec 2023 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGfkZyKk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329701845
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d42ed4cdc7so343365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 16:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703638413; x=1704243213; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sehOb+VMc78wKPL1TpSEJ0N7yS0xhk1UrWSEsSbLGEk=;
        b=EGfkZyKkicSg6G0uEwEhhfl8nE0z0yOQiCz0/ZMlaCIrWC1NOM+1z/P5AChhTbJ+wc
         c/uq7iSyGo3rMzi5aWWhx9w3bjSYJ82YsIsuI67qbNJ9Wh9DZ/Jmy4jCdl+vejsQi/rn
         GUXk1IIrkFnkWyTr/lROFf7MG6wY86X8NPrMbJEzgc/CbN+wizab1iCjiUvBcyp3pkMc
         CCWqh3rkZmgqOddtyzXbKP5UFWa2xlsPGK8vx4ChuX0ntZ0j/UKyll5qAiXL9X5AMnMO
         stxhEGYwokjKxK1C1Fh5FHNdrTokCfB1UCEZxIZmhKxTA1knF7pdIvta2Kybz1UMs5aB
         jIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703638413; x=1704243213;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sehOb+VMc78wKPL1TpSEJ0N7yS0xhk1UrWSEsSbLGEk=;
        b=MHituGiAenX0Wru2ZqPhpmcnmiI+nFnqPO/uJxFaww0tpW9sVLtGT0NHrDMxostqaE
         h1/aYrGYXkeNgFtqqbd3b/XaFR7/AZ1EA9SoB4gCZWnh+t+YBOZz1D9jtY+6SPXa4EFI
         Ciii/Q8PWluCp+W1BMbokR6pEhU8pEVbFcM3UQunLYvMhmAyJZ3qre3VOQnZkUIVcgAX
         ktVeStuwpZnjXWf4VxkgQpnqhhfozXzER/bfN/Op13Sr/ljWGhmrrELqkzrALXko60SK
         pbvuItzANP7eheW4B3JfoRWawOR+7/SzlRbS/2FGnlwz5t8eh05rI9iyg0ttlv7IJZys
         ausQ==
X-Gm-Message-State: AOJu0Yxtc+sEH5B052H/0Nm7hikx0Xt0QDUD0tZFuzB38+vGIajlXB5w
	wVdBj9Gatx7CXa2AR6eK5k7zXGnJ9/R8
X-Google-Smtp-Source: AGHT+IFFtPjyAMjq4eKscHzLFbwxPV9QJHI7QFXIhLqeyUYv9QY4jeEdcH6tYGkSv2Fz/JNeL/S6jA==
X-Received: by 2002:a17:902:bb84:b0:1d4:55b3:45d9 with SMTP id m4-20020a170902bb8400b001d455b345d9mr233058pls.6.1703638413187;
        Tue, 26 Dec 2023 16:53:33 -0800 (PST)
Received: from [2620:0:1008:15:5a8c:89e6:ca2f:ea30] ([2620:0:1008:15:5a8c:89e6:ca2f:ea30])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0028b1fce7c01sm16313726pjh.37.2023.12.26.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 16:53:32 -0800 (PST)
Date: Tue, 26 Dec 2023 16:53:31 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
    Andrew Morton <akpm@linux-foundation.org>, surenb@google.com, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, souravpanda@google.com
Subject: Sysfs one-value-per-file (was Re: [PATCH] vmstat: don't auto expand
 the sysfs files)
In-Reply-To: <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com>
Message-ID: <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com> <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com> <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com> <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
 <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Dec 2023, Pasha Tatashin wrote:

> > > > > Whenever a new fields are added one of the following: node_stat_item
> > > > > numa_stat_item zone_stat_item, the /sys/devices/system/node/nodeX/vmstat
> > > > > files are auto expanded.
> > > > >
> > > > > This is a problem, as sysfs files should be only one value per file.
> > > >
> > > > Does this patch address the one-value-per-file issue?  (I think that ship
> > > > has sailed for vmstat.)
> > >
> > > That ship has sailed for vmstat, this patch addresses what was asked
> > > by GregKH: not to add new values to vmstat, as not to make the
> > > existing problem even worse. The sysfs file system has a one page
> > > limit per file. The developers will decide how to export the new items
> > > added to node_stat, numa_stat, zone_stat individually. Each new item
> > > can be exported in its own files, and must have its own documentation
> > > about interface stability, value meaning, and expectations when the
> > > stat file is absent.
> > >
> >
> > As of at least 6.5, /proc/vmstat is a strict superset of the per-node
> > vmstat.  Why is that a problem?
> 
> The intent of this series is to stop auto expanding
> /sys/devices/system/node/nodeX/vmstat as sysfs should only be one
> value per file, and the task is not to make things worse. /proc/vmstat
> is mostly ok, however we might not need to auto expand it as well, to
> avoid situations where removing a field becomes a problem, and we have
> to keep it in the file forever, like what we do with nr_unstable.
> 
> > There's great benefit to being able to use the sample implementations to
> > parse either /proc/vmstat *or* the per-node vmstat and without needing to
> > read the per-node vmstat plus some new set of sysfs files that are
> > one-value-per-file.  The per-node vmstat will always be multiple values,
> > in fact it's a key value pair.
> 
> Yes, but that file is already large, and soon can overflow a page
> size, instead of converting it to a binary format, let's add new items
> as one item per-file.
> 
> > I have to think that doing anything else for vmstat is just adding
> > complexity (like this patch) and actually making it *harder* on userspace
> > to read the data it needs.
> >
> > Yes, the per-node vmstat likely shouldn't be in sysfs at all but it
> > appears to have been added there 13+ years ago because it was a convenient
> > place to add a per-node variant.  That's not ideal, but owell.
> 
> It is up-to GregKH who requested this change. Greg, specifically
> requested not to add new fields into per-node vmstat, and we are
> adding new fields with per-page metadata series, and IOMMU accounting
> series as these files are auto-expanded without this series.
> 

Thanks, let's get clarification on this once and for all from Andrew and 
Greg.

I'd argue that the ship on the "sysfs one-value-per-file rule" has sailed 
for long-standing use cases where either (1) switching is just not 
possible or (2) switching would be an undue burden to the user.

An example of (1) would be THP enablement and defrag options:

$ grep . /sys/kernel/mm/transparent_hugepage/{defrag,enabled,shmem_enabled}
/sys/kernel/mm/transparent_hugepage/defrag:always defer defer+madvise [madvise] never
/sys/kernel/mm/transparent_hugepage/enabled:[always] madvise never
/sys/kernel/mm/transparent_hugepage/shmem_enabled:always within_size advise [never] deny force

This convention isn't going to change.  We're not going to suddenly add a 
new enablement or defrag option that can only be set in a newly added 
file that is one-value-per-file.

THP was obviously introduced before any sysfs "one-value-per-file rule" 
and, in retrospect, I think most people would agree that these files would 
be much better off implemented returning a single word.  But, choices 
where made in the "before times", and it was implemented in a way that 
shows all the possible choices and which one is in effect.  Owell.  We 
deal with it, and we move on.

Imagine if I add a new choice of "lightweight" to the "defrag" file.  The 
only rational way to do that would be to extend the current interface, not 
create a new /sys/kernel/mm/transparent_hugepage/defrag/lightweight file 
that is one-value-per-file that unsets all the other options in "defrag."
Please.

I use this an an extreme example, but a very real one: we can't break 
userspace and that will always supercede the desire to maintain 
one-value-per-file.

Don't get me wrong, I am all *for* one-value-per-file, it has many 
benefits.  But I disagree we should use it a a northstar for *existing* 
use cases if it actually means we'll be breaking userspace or making it 
much harder on userspace.

Under discussion in this thread would be an example of (2).  /proc/vmstat 
is a strict superset of its per-node 
/sys/devices/system/node/node*/vmstat counterparts.

For ZVCs, we *want* to ensure new stats are added to both.  For the same 
reason that we want to ensure old stats are removed from both.  Starting 
to maintain completely different implementations in the kernel comes with 
complexity, but also with risk of bugs.  Especially for something that 
works exceedigly well for the user today.

Saying that we can extend /proc/vmstat for more entries but then *not* 
extend /sys/devices/system/node/node*/vmstat for the exact same entries, 
and forcing those a new files with a single value, is doing a disservice 
to the user who wants to collect the data comprehensively with the same 
implementation for the entire system and each node.

The *only* time I think that makes sense is if all new vmstats must be 
added in their own files in both procfs (system-wide) and sysfs 
(per-node).  That very well may be the path forward, but get ready for an 
explosion in new top-level /proc files.  (It'll also be a shame for 
anybody who just dumps /proc/meminfo and /proc/vmstat in testing for 
capturing the state of the system.)

The discussion about needing to make vmstat be a binary file because it 
doesn't fit into a single page is not very realistic.  It will result in 
userspace breakage for everything parsing it as it is today, so let's just 
set that aside.  If a sysfs file needs to support returning more than 
PAGE_SIZE of contents, which is just an implementation detail, so be it.

For brand new interfaces, I'm all for it: add one-value-per-file and be 
done with it.

But for existing files and conventions, I think we should settle it as 
"keep doing what you've been doing for 13+ years" and don't force this 
argument every time a kernel developer wants to just add one more stat.

Over to Andrew and Greg.

