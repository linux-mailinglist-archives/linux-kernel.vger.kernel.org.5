Return-Path: <linux-kernel+bounces-654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D5081441D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349D1B21B21
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7E168D4;
	Fri, 15 Dec 2023 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+z5cJjN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C219445
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3333131e08dso370135f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702631054; x=1703235854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaIyphWUSQyUpejH9hCl/lG3GBHHtOu7lr9wkQ40dik=;
        b=c+z5cJjN7mA1m/CKR/55oF5vTusQoFVBMrtN9DryLV5ONYa9kirJ4hqum0064GdLFk
         AyjNn8mcg7FuGQSmFNxhYPHdiLGO39ps7TPzmHHBwnt1lEnP85GfwWsInLckNMP2xLvw
         Gekntf6F3ciMAudkpWfGFnnGTtgnfp3ozxlqYW8v+a+6BhwQCk+SmqJIGiqJeiw4PNc9
         2zKXrjA6b475Fm5rExtxOxhV6HmgptO1GwezPvQtCCge5DVIKIthIhwbsBzFjf19Fkda
         uzh6/V/hEvyKdxbIciA7ic6oLp8Y0wuwhpCDb5F+oqu3U5qu/nl1jHxHwvrEfW41WV3T
         Ezeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631054; x=1703235854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaIyphWUSQyUpejH9hCl/lG3GBHHtOu7lr9wkQ40dik=;
        b=jrqStDfb/3I6YcMV26Ai0cE68nZA5GzK5K/So/XEjhow7vW5w9LWN1EIB0NhKefZTQ
         +OuluTbEXCFfdkvklIZwMHb4wJmQnAe25qoqWxutfqy4oH4m917bze3b4V8o9LQXG4P/
         myq0CICsUQinW/Xs7puwgpZjibkPceaQdGwxwjG0A7ewaMP3PGYp/6BmZXBC4RR9GsxR
         KWtCrtCg9xcurzM6P3qaV7RVi7D0EXB2omqNM5PZum0ofW3cZfIqefsyIlXz4XIAAuMz
         beqiDNXfms1BlqAMm2aqCkb9R7FnLbJoTJoHBRBleFmLmRa8jtZsjfzY1LGwPRSUfaHH
         dU1g==
X-Gm-Message-State: AOJu0YzbY+1DREZ4aA0nYVrAZ82MrBygW63rKz/gThpyuXJVgspHR8Vj
	/X1qNXNPSiee8ndfi6i1JUOhPP0Mqn5ulWvkHEi/HnGI9bl3SQ==
X-Google-Smtp-Source: AGHT+IFzDm2ZZchAa+UO0pY9j5mB1kEkbjEkDV1HH0hLSaOcaCQH+rFOXeT99l8oRX5huImiVGfNayxeCt2uOlat2yo=
X-Received: by 2002:adf:e343:0:b0:333:39d4:ff80 with SMTP id
 n3-20020adfe343000000b0033339d4ff80mr5948727wrj.90.1702631053688; Fri, 15 Dec
 2023 01:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211052850.3513230-1-debug.penguin32@gmail.com>
 <CAKEwX=MzkBt1F2WZaacuCQ+E6eWt1AKvbGZ6JFHy5tkoYigqQg@mail.gmail.com>
 <CALk6Uxog_LLF2dec2J54baMfee8jCOEabjWLG6-L=FEyZ-FFBQ@mail.gmail.com> <CAKEwX=OwFk7aL-PGE4JBR0qy5NzbDbSmPGyu8yd7FK+yU8mRBg@mail.gmail.com>
In-Reply-To: <CAKEwX=OwFk7aL-PGE4JBR0qy5NzbDbSmPGyu8yd7FK+yU8mRBg@mail.gmail.com>
From: Ronald Monthero <debug.penguin32@gmail.com>
Date: Fri, 15 Dec 2023 19:03:37 +1000
Message-ID: <CALk6Uxp_vKh2y-Fjh5=0gP_gmBZTLuJ8T0CLAFedRp79zaJikQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Nhat Pham <nphamcs@gmail.com>
Cc: sjenning@redhat.com, akpm@linux-foundation.org, 
	Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
..
< snipped >

> I should have been clearer. I'm not against the change per-se - I
> agree that we should replace create_workqueue() with
> alloc_workqueue(). What I meant was, IIUC, there are two behavioral
> changes with this new workqueue creation:
>
> a) We're replacing a bounded workqueue (which as you noted, is fixed
> by create_workqueue()) with an unbounded one (WQ_UNBOUND). This seems
> fine to me - I doubt locality buys us much here.

Yes the workqueue attribute change per se but the existing
functionality remains seamless and the change is more a forward
looking change. imo under a memory pressure scenario an unbound
workqueue might workaround the scenario better as the number of
backing pools is dynamic. And with the WQ_UNBOUND attribute the
scheduler is more open to exercise some improvisations in any
demanding scenarios for offloading cpu time slicing for workers, ie if
any other worker of the same primary cpu had to be served due to
workers with WQ_HIGHPRI and WQ_CPU_INTENSIVE.Although normal and
highpri worker-pools don't interact with each other, the target cpu
atleast need not be the same if our worker for zswap is WQ_UNBOUND.

Also noting that the existing wq of zwap worker has the WQ_MEM_RECLAIM
attribute, so is there a rescue worker for zswap during a memory
pressure scenario ?
Quoting: "All work items which might be used on code paths that handle
memory reclaim are required to be queued on wq's that have a
rescue-worker reserved for execution under memory pressure. Else it is
possible that the worker-pool deadlocks waiting for execution contexts
to free up"

Also additional thought if adding WQ_FREEZABLE attribute while
creating the zswap worker make sense in scenarios to handle freeze and
unfreeze of specific cgroups or file system wide freeze and unfreeze
scenarios ? Does zswap worker participate in freeze/unfreeze code path
scenarios ?

> b) create_workqueue() limits the number of concurrent per-cpu
> execution contexts at 1 (i.e only one single global reclaimer),
> whereas after this patch this is set to the default value. This seems
> fine to me too - I don't remember us taking advantage of the previous
> concurrency limitation. Also, in practice, the task_struct is
> one-to-one with the zswap_pool's anyway, and most of the time, there
> is just a single pool being used. (But it begs the question - what's
> the point of using 0 instead of 1 here?)

Nothing in particular but I left it at default 0, which can go upto
256 ( @maxactive per cpu).
But if zswap worker is always intended to only have 1 active worker per cpu=
,
then that's fine with 1, otherwise a default setting might be flexible
for scaling.
just a thought, does having a higher value help for larger memory systems  =
?

> Both seem fine (to me anyway - other reviewers feel free to take a
> look and fact-check everything). I just feel like this should be
> explicitly noted in the changelog, IMHO, in case we are mistaken and
> need to revisit this :) Either way, not a NACK from me.

Thanks Nhat, for checking. Above are my thoughts, I could be missing
some info or incorrect
on certain fronts so I would seek clarifications.
Also thanks in advance to other experts/maintainers, please share
feedback and suggestions.

BR,
ronald

