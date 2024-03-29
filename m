Return-Path: <linux-kernel+bounces-124361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A443589163A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03694B21689
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F084AEED;
	Fri, 29 Mar 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWUxQpAP"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726B4594F;
	Fri, 29 Mar 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705399; cv=none; b=gxIU6HrPO0ZiDkapDQcogV+AaVoZomeHKDQ9l+oSNJHoMiH79Rwi4zRprFHGDjnk8AkOPU/VnnZFI+XBCCp7H8OYCKVgEsZqZ/Afo5RN4/sA6R+73B0F9YWtWhyRT+3tY3BXZFfeWeoYWSEPvHO9h4+6/r5OUXDFRBtb8B/QsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705399; c=relaxed/simple;
	bh=m/1irspid2yhG/ZRvOgLcpF7TGDSpxl6shghAlMMFM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txovwwNyz3DHL6QIs5JwttodHfBzCT58iFhMZgOvaNPsnhJS40gAjYJlw8rx28eILs6bzkf3uRWg1TcP/6FhSpAnhJFIBwD59NajtW44Gs2KPJbCbZoxc9Gcq9GkceekRlfWfUlfhk0Y6ZvA1MRo+95qmEH71F9O3Z3hCKGcvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWUxQpAP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so1209235f8f.2;
        Fri, 29 Mar 2024 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711705396; x=1712310196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq5J+3hpMTsfHTgbS2ASWTSfU51EuKZyXWloCoK4DVI=;
        b=GWUxQpAPGq6HH2Nj/6oX0fhluJqOAKcoC0tNS2jqAdK9Cjtg4OXk8m2Fq10cs+ktwI
         CA+oIYMRby5wi/Slnb1S6LYAjHUfN64DILk/MFbdk6R0pjmEErk+uEuLJ+E21Mteirr4
         /XwdcEPCfmCVh3/1Jkl4HEj8DAKJ8gKz45a0Memvsnu2hSMnop6/ajm3B8prwvM9iV14
         jQoZ6h0evPpcq+86dHvH77FMzAp6nJ2W0brkyViAx6xtxgEvN/jQPAroX3nEbq1KhMLC
         MCJKwxurubDYfUmaqP9MTKzvUulfb/VEYQwO/QFPRbYaFc0feiO+Ady9xw/t6NZnKuEr
         SjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705396; x=1712310196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq5J+3hpMTsfHTgbS2ASWTSfU51EuKZyXWloCoK4DVI=;
        b=Ib6K6pYYdLlUZBcjhZ0EuM7xotSKqNoa7r48YUwHvd6IsWEG1Nw7l29WPYU79rgctt
         LLnJaRVYXpXaRf9p+Q79YdBpwcACQMcQaqFWx50D04D77Ifp4TYlY8Z8JwR8cfiD4+80
         dd8BOkAGM1W9iAzFDuxWQAqvA3TwCeNq/pXKRBL58EsnPvh9rdR5GGQEDyCqva0KTJIr
         KfB/iHrtMCGHCRdvzO7OysnkY8TihqxN4f7+nq4Xkr/UADGOcFmR/6MJXnA0+LdkrwNh
         HWF7St2ZbXAcrB+fTPThbLbX5FxKb0BmMY1oomLKdyhkg3plVK20NsF9NbwmFOFzylHP
         jpKw==
X-Forwarded-Encrypted: i=1; AJvYcCXhxUVlwE4xsKGpz4BU+p+y6hG5GSxpD9pTA65aH9JDu78kQcLCwYBqwSXeXPOcBVf9UMVMMxUfOLv351IREp+Ro9UhKlXl9KlqjazofLOFb1rPMlMv0rj4ZRkBO95hL2ZsiDV6O63Qo68=
X-Gm-Message-State: AOJu0YzfqFQ90mdR2xQROazpYsHZyQPnCeSh39f0MqMeSgl9CR5H1kqk
	gptUTC01frjTqZsogA1UE7Gb9sEOzvFm4D6K/Zv6kh8aWBjczcAR0PIHL1YHHw6tzAZ+yNqPbny
	uJ/BrdN5AzQoSF+e0wqGtLoQ+wv8=
X-Google-Smtp-Source: AGHT+IFUhvqc+Uk3QWp1JwfgwRfahkXFz0WEW4YuyzEaJ4EY/YMklo7HsZNOOleaOUrxa+yvy8BttXBBmCVUxfwvohc=
X-Received: by 2002:a5d:6102:0:b0:33d:f3c4:6002 with SMTP id
 v2-20020a5d6102000000b0033df3c46002mr1141766wrt.1.1711705395737; Fri, 29 Mar
 2024 02:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com> <5e10988d-5652-4e03-b866-7f0daccafcad@kernel.org>
In-Reply-To: <5e10988d-5652-4e03-b866-7f0daccafcad@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 29 Mar 2024 17:43:04 +0800
Message-ID: <CAHJ8P3KEOC_DXQmZK3u7PHgZFmWpMVzPa6pgkOgpyoH7wgT5nw@mail.gmail.com>
Subject: Re: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:40=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 3/29/24 11:44, Zhiguo Niu wrote:
> > A WARN may occur when async_depth is set from user by sysfs,
> > the warning log is as following:
> >
> > [  623.848659] WARNING: CPU: 0 PID: 7798 at lib/sbitmap.c:537 sbitmap_q=
ueue_get_shallow+0x2c/0x38
> > [  623.878550] CPU: 0 PID: 7798 Comm: kworker/u16:2 Tainted: G        W=
  OE      6.6.0-mainline-g8d9254e6f4a0-dirty-ab000013 #1
> > [  623.880091] Hardware name: Unisoc UMS9621-base Board (DT)
> > [  623.880906] Workqueue: writeback wb_workfn (flush-254:48)
> > [  623.881748] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [  623.882763] pc : sbitmap_queue_get_shallow+0x2c/0x38
> > [  623.883525] lr : __blk_mq_get_tag+0x50/0xd4
> > [  623.884198] sp : ffffffc08a073230
> > [  623.884745] x29: ffffffc08a073230 x28: ffffffc0821445e0 x27: 0000000=
000000000
> > [  623.885799] x26: ffffff8087de8000 x25: 0000000000000000 x24: 0000000=
000000002
> > [  623.886849] x23: ffffffc0820f2008 x22: ffffff8088ac3918 x21: ffffff8=
08c358f10
> > [  623.887897] x20: ffffff808c358f00 x19: ffffffc08a073360 x18: ffffffc=
08bde70a8
> > [  623.888946] x17: 000000007e57c819 x16: 000000007e57c819 x15: fffffff=
dfe000000
> > [  623.889993] x14: 0000000000000001 x13: 0000000000000004 x12: 0000000=
3c6c931ed
> > [  623.891038] x11: ffffff80939a3800 x10: ffffffc0801ac88c x9 : 0000000=
000000000
> > [  623.892086] x8 : 0000000000000006 x7 : 0000000000000000 x6 : ffffffc=
080765204
> > [  623.893131] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000=
000000000
> > [  623.894174] x2 : ffffffc080765224 x1 : 0000000000000005 x0 : ffffff8=
08c358f10
> > [  623.895221] Call trace:
> > [  623.895660] sbitmap_queue_get_shallow+0x2c/0x38
> > [  623.896379] blk_mq_get_tag+0xa0/0x350
> > [  623.896992] __blk_mq_alloc_requests+0x218/0x300
> > [  623.897715] blk_mq_submit_bio+0x314/0x774
> > [  623.898369] __submit_bio+0xb4/0xe0
> > [  623.898950] submit_bio_noacct_nocheck+0x110/0x324
> > [  623.899692] submit_bio_noacct+0x278/0x3f8
> > [  623.900344] submit_bio+0xcc/0xe8
> > [  623.900900] f2fs_submit_write_bio+0x100/0x428
> > [  623.901605] __submit_merged_bio+0x74/0x1ac
> > [  623.902269] __submit_merged_write_cond+0x188/0x1f4
> > [  623.903022] f2fs_write_data_pages+0xb10/0xc2c
> > [  623.903727] do_writepages+0xf4/0x618
> > [  623.904332] __writeback_single_inode+0x78/0x60c
> > [  623.905055] writeback_sb_inodes+0x294/0x520
> > [  623.905734] __writeback_inodes_wb+0xa0/0xf4
> > [  623.906413] wb_writeback+0x188/0x4e8
> > [  623.907014] wb_workfn+0x420/0x608
> > [  623.907582] process_one_work+0x23c/0x55c
> > [  623.908227] worker_thread+0x2ac/0x3e4
> > [  623.908838] kthread+0x108/0x12c
> > [  623.909389] ret_from_fork+0x10/0x20
> >
> > The rootcause is user may set async_depth to a value which is less
> > than its initial value from dd_init_hctx->dd_depth_updated, and this
> > initial value is set to sbq->min_shallow_depth, when async_depth is
> > modified by user from sysfs, sbq->min_shallow_depth will not be changed
> > simultaneously, and it is also not easy to obtain tag sbitmap informati=
on
> > in deadline_async_depth_store.
> >
> > So a suitable value should be set to min_shallow_depth in dd_depth_upda=
ted.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >  block/mq-deadline.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index 02a916b..89c516e 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -646,10 +646,12 @@ static void dd_depth_updated(struct blk_mq_hw_ctx=
 *hctx)
> >       struct request_queue *q =3D hctx->queue;
> >       struct deadline_data *dd =3D q->elevator->elevator_data;
> >       struct blk_mq_tags *tags =3D hctx->sched_tags;
> > +     unsigned int shift =3D tags->bitmap_tags.sb.shift;
> > +     unsigned int dd_min_depth =3D max(1U, 3 * (1U << shift)  / 4);
>
> Extra blank space before "/".
Hi Damien Le Moal
Thank you for this detailed review, I will fix it with suggestions
from other reviewers.
> That division could also be replaced with ">> 2".
yes, I just refer to the original code "dd->async_depth =3D max(1UL, 3 *
q->nr_requests / 4);"
thanks!
>
> >
> >       dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
> >
> > -     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_dep=
th);
> > +     sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd_min_depth)=
;
> >  }
> >
> >  /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
>
> --
> Damien Le Moal
> Western Digital Research
>

