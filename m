Return-Path: <linux-kernel+bounces-16414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97817823E23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06120B23589
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5D20300;
	Thu,  4 Jan 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVPlIylK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015E20307
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704359156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iX9qGa68E78UJ5hvhNoD5drMxwjL+oaCeZZpL7pj4DY=;
	b=SVPlIylKFL+ZOYemddu8I6ZKxQ8BymNXAkmkXBwKNQ5KK13R0FBfla2NOyhV/Ca8lOtajg
	gn7U5+4LRRtoxSM5Z4WuV6I2JxHsgAfBuCrgMsAJbphM8Vn0x0pZiwiDAbx2DfZBsIvUpi
	OIj4RPmcpTk/GZj9fZzz95ev4pKUtmo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-E58fsocAMEmyys8TgsWxCg-1; Thu, 04 Jan 2024 04:05:55 -0500
X-MC-Unique: E58fsocAMEmyys8TgsWxCg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bbf47262ccso324953b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359154; x=1704963954;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX9qGa68E78UJ5hvhNoD5drMxwjL+oaCeZZpL7pj4DY=;
        b=TKl/iAYjZfOsgNbeGyWeYhOVQnaMAmSRvmnhQ8cJia+Thu4j7q6WAdhRM4xnudVeVX
         H7rfR+PPi5mHhhjR0PQPV5T2FLCWMwDk4nwkAPePdCimqBe1kAEjvDTBZZWnAAllKE4H
         7LVaF5umUL911BbfpvokLwW68ZtJwylUySv2RaIh4DcKbJyg1cunAjTtYR+/7xF+EZ8r
         PqAkzit6Ad2S0A6JyvwcwGjSU7DL+y3JStAJTbG71jO59zWEKh0zLh2VQ9p/v7ve0ZFt
         Bc57++ZbVOxsptujOIxQA2yXjyoyJB5HC9Dx+yWHYi6uB9Ys76dgePlLd1RkwBUZz8rg
         CgvQ==
X-Gm-Message-State: AOJu0Yyc7mJylX1XXwDhhxbjJ6J7Fnmyk3F2rSPpDAP1XiKun0VEC4OS
	NMo1ZXsI9h/Lt3rOGab+o2SX+LA0UAsw8wdu+EFe4US+7t50Vi5OJQe7LJCbPBr1l3oncrMy7XC
	QRj2XKxYivn9aEwwO7rb1E8AKLvBOgtET
X-Received: by 2002:a05:6808:1a94:b0:3b9:d927:ddb7 with SMTP id bm20-20020a0568081a9400b003b9d927ddb7mr228909oib.114.1704359154744;
        Thu, 04 Jan 2024 01:05:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcXwblzmJPqNerpl2OA9EGd4wENm9y6PKRdLr299Ev6F492CVmc5Lb+EkH+KOnVuVI7q//xg==
X-Received: by 2002:a05:6808:1a94:b0:3b9:d927:ddb7 with SMTP id bm20-20020a0568081a9400b003b9d927ddb7mr228902oib.114.1704359154404;
        Thu, 04 Jan 2024 01:05:54 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id i17-20020a056214031100b0067f3a1a7557sm11611255qvu.120.2024.01.04.01.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:05:53 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Alex Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org,
 curuwang@tencent.com
Subject: Re: [PATCH] sched/tracing: correct the task blocking state
In-Reply-To: <CAJy-Ammtn1Asw98fnB28ym-FF8Wafc=p9Nv_dDfY1pL3V8bCQA@mail.gmail.com>
References: <20240102073351.1527503-1-alexs@kernel.org>
 <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-Am=R=gRFqSdGjXaMqq7Yetpp-4=bLtnP-87GepN4zff5Tg@mail.gmail.com>
 <xhsmhjzork8x5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-AmkG+6jZCGFBnqA_33NtBBq_hjemqkPCbZX2Jty0KWQE+w@mail.gmail.com>
 <xhsmhbka2jzaj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-Ammtn1Asw98fnB28ym-FF8Wafc=p9Nv_dDfY1pL3V8bCQA@mail.gmail.com>
Date: Thu, 04 Jan 2024 10:05:50 +0100
Message-ID: <xhsmh4jftjwnl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/01/24 15:56, Alex Shi wrote:
> On Wed, Jan 3, 2024 at 9:56=E2=80=AFPM Valentin Schneider <vschneid@redha=
t.com> wrote:
>>
>> That's useful information - generally it's good to add the motivation fo=
r a
>> patch in the changelog.
>
> Thanks a lot for coaching, I changed the commit log in the v2 patch:
> https://lore.kernel.org/lkml/20240103081042.1549189-1-alexs@kernel.org/
> Btw, which way is usual prefered, send v2 patch in a separate thread
> or add '--in-reply-to' to follow this thread?
>

New threads are usually better, it makes it clear that it is a new version
of the patch and not just a reply to the previous version's
thread.

Reviewers/Maintainers can also jump more easily on the v(n+1) when it's a
separate thread, in case they missed / didn't have time to review the
previous version.

> Thanks
> Alex
>
>>
>> > Thanks!
>>


