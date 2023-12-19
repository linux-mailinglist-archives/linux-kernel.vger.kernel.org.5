Return-Path: <linux-kernel+bounces-5109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD88186A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB862844AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78018626;
	Tue, 19 Dec 2023 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQEeCdP1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6218032
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702986646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOC1MdaAQ4X/+ovjnXEnLv+95CBGdkO1BwPsDW7zKtU=;
	b=XQEeCdP1lzmD2YIWp2Wtjf4FdC/2GC3aaHx/PmGQ+YB2NQzgD+wOL2V/0P0Lc2F6zSOgHe
	Irg8dl8+rMVq9j9uhZf0+XrRWQP+tNyoLZ+zmZpv4DTRVt/HLvJ3Ubt5t3eT/bygpNfCGL
	Vt54prCXBLHNCBiMwG0gplpwtJywEA8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-cZw73IQMMs-KplFnigFKlA-1; Tue, 19 Dec 2023 06:50:45 -0500
X-MC-Unique: cZw73IQMMs-KplFnigFKlA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77f54424077so677838885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986643; x=1703591443;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOC1MdaAQ4X/+ovjnXEnLv+95CBGdkO1BwPsDW7zKtU=;
        b=rfVldIpxs8L+b1zIyVr9q8WsXOzo/qLS6YiKWPM/lTZAuYfTMB41ig7JjjJFoAXG0p
         Fbkz45oziYupnEsc48TuY+pBvCiLov8JXq/Ugwx9NY66BDVbCdq9As2sKXdGnSXBhIrP
         w9YebzCXF2cowRIXmXhemxA5K5yDSlMZ02l3i7wheKcVMtdiT1LJjinYbhyCQaBLJa5J
         Iph3JbQ4p7ZmG0Y2KIicX/fWJ374pHulpQzfZi6Bg2Sj93Q4tqnRKAM5nZUWzGV4OeRW
         IYTjw89K/f5g7Jzsz70Z0dMTv8Ifgw5ny7dcxZTFozvZJAZWq0mqSKYxYE292YNOtX12
         CIsA==
X-Gm-Message-State: AOJu0Yz2uUs95lRdXWI3t5rOaqfAEbK5yCp9JX2bhjlZB7Oxr0hSilgB
	hNtAxLD2CiNSiY93brIzfgQjr2rWKI6Fa/nNtWLXDx54lCiezF94Ycmw+xXOjadHNL2onbUvsTW
	35990WM6dY+tskrq+3/xjpnONyH5xrwos
X-Received: by 2002:a05:620a:4556:b0:77f:ba05:b2f8 with SMTP id u22-20020a05620a455600b0077fba05b2f8mr8805085qkp.108.1702986643620;
        Tue, 19 Dec 2023 03:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHZ70n2zZhUEZ/JhH1lJOi04y1wXGP9IZqBfCMM4jwlg7ggdD8+v5K/91ZxI23ykYIjIbEcA==
X-Received: by 2002:a05:620a:4556:b0:77f:ba05:b2f8 with SMTP id u22-20020a05620a455600b0077fba05b2f8mr8805077qkp.108.1702986643385;
        Tue, 19 Dec 2023 03:50:43 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id rr23-20020a05620a679700b0077edde498d3sm9051790qkn.89.2023.12.19.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 03:50:42 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Benjamin Segall <bsegall@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH 1/2] sched/fair: Only throttle CFS tasks on return
 to userspace
In-Reply-To: <xm26edfj2l8h.fsf@google.com>
References: <20231130161245.3894682-1-vschneid@redhat.com>
 <20231130161245.3894682-2-vschneid@redhat.com>
 <xm26sf4n2ar6.fsf@google.com>
 <xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com>
 <xhsmhy1dr9ygf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xm26edfj2l8h.fsf@google.com>
Date: Tue, 19 Dec 2023 12:50:38 +0100
Message-ID: <xhsmhv88u9zsh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 18/12/23 14:34, Benjamin Segall wrote:
> Valentin Schneider <vschneid@redhat.com> writes:
>>
>> So if I'm trying to compare notes:
>>
>> The dual tree:
>> - Can actually throttle cfs_rq's once all tasks are in userspace
>> - Adds (light-ish) overhead to enqueue/dequeue
>> - Doesn't keep *nr_running updated when not fully throttled
>>
>> Whereas dequeue via task_work:
>> - Can never fully throttle a cfs_rq
>> - Adds (not so light) overhead to unthrottle
>> - Keeps *nr_running updated
>
> Yeah, this sounds right. (Though for the task_work version once all the
> tasks are throttled, the cfs_rq is dequeued like normal, so it doesn't
> seem like a big deal to me)
>

In my implementation the cfs_rq's can be dequeued once all of their tasks
have been throttled, but the tasks aren't migrated back onto the cfs_rq's
until the unthrottle (rather than at the "final" throttle).

That is done because if a random task gets migrated to a throttled & empty
cfs_rq, we still need to schedule it 'till it exits the kernel, and we
don't want the now-in-userspace task to suddenly become eligible for
picking.

That adds these O(ntasks) loops in the unthrottle to re-shape the
cfs_rq's. The dual tree approach saves us from doing all that, IIUC
unthrottle_on_enqueue() only puts the se's in the task's direct hierarchy
back onto the second tree for them to be picked.


>>
>> My thoughts right now are that there might be a way to mix both worlds: go
>> with the dual tree, but subtract from h_nr_running at dequeue_kernel()
>> (sort of doing the count update in throttle_cfs_rq() early) and keep track
>> of in-user tasks via handle_kernel_task_prev() to add this back when
>> unthrottling a not-fully-throttled cfs_rq. I need to actually think about
>> it though :-)
>
> Probably, but I had tons of trouble getting the accounting correct as it
> was :P
>

Yeah so did I, cgroups are "fun".

>>
>> I'm trying to grok what the implications of a second tasks_timeline would
>> be on picking - we'd want a RBtree update equivalent to put_prev_entity()'s
>> __enqueue_entity(), but that second tree doesn't follow the same
>> enqueue/dequeue cycle as the first one. Would a __dequeue_entity() +
>> __enqueue_entity() to force a rebalance make sense? That'd also take care
>> of updating the min_vruntime.
>
> Yeah, the most sensible thing to do would probably be to just have curr
> not be in the queue, the same as the normal rbtree, and save the "on
> kernel list" as an on_rq-equivalent bool instead of as !list_empty(kernel_node).

Makes sense, I'll have a go at this.


