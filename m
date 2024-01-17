Return-Path: <linux-kernel+bounces-29481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D3830F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D2F1F25924
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490DC286AF;
	Wed, 17 Jan 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+isSKsH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8882868D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705529699; cv=none; b=OHJ2gbnRfAq4jnfprjNiq/uOL1kJGUL/ZHcc9uJGMJSiGxk+KYWg/q6R8UvfCk7JIYqTuycaULFKvUOTeEM9CHjARR0qdlCCB6/4Bwo5ZZgsXNCtOSBy6ZRLgoK5L13xhkNxmcJfSGUH5Z+gIZjWctpuwTblO0y4nCiEfU5k+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705529699; c=relaxed/simple;
	bh=NkvEXTpBfoUpi2iXajrBKt8X8S/DHNktsJvGm0GzI0E=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version; b=E0K6VspCNUn2kU/AERsSItt+pzkx2CDDfr82VWufbKwRHeqaI66IGZAF3aj6bLFEqh1O/C6OnufY0GgPn+i3bXKecTC40HAMimEhqBbXzksC2vHTfwx//TnfEHoQRWVVGG46gLYyWnJRXElAN3I3oT6DEBc+RFiqwy4EY9CIgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+isSKsH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705529698; x=1737065698;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NkvEXTpBfoUpi2iXajrBKt8X8S/DHNktsJvGm0GzI0E=;
  b=M+isSKsHaFrxij+GIYFqgRz3Ysr+2JdjJWJG+eMVqT3eXCKLXnMZ6s1b
   E5S2b4pfzhfC3ZDUSjE1S/p6Unb+8yqrcEWJeaPZnuRDwRUHOZDVrDAHW
   GgEMcYfT7gOii4rP4Ib96/HnjDn5kX4l1U1sTjr7d/Uw1xQJkNjSukRGa
   5SOnZ9gzqIY+R9vJkUUYgDbrwzEVpSG1ZPyF9fdRlt/AJE83A/Pv/6ojt
   yobUzx3NcC5b0B/J58Sq/tTywzql4WzWXi3h2PdQR2ZaGBjDW6PMWogvp
   9c611ZSGiNJYDbnu2gaeIRU1xl6TfQKLbitzX7sm7KqEAzWcil/o5qXXu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="6987197"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="6987197"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="157140"
Received: from kappusam-mobl.amr.corp.intel.com (HELO [10.212.188.217]) ([10.212.188.217])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:14:57 -0800
Message-ID: <cc135e4ba87bf64b384a529ccbd4c644bb135266.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/7] padata: dispatch works on different nodes
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mike
 Kravetz <mike.kravetz@oracle.com>, David Rientjes <rientjes@google.com>, 
 linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com, David Hildenbrand
 <david@redhat.com>, Muchun Song <muchun.song@linux.dev>
Date: Wed, 17 Jan 2024 14:14:56 -0800
In-Reply-To: <ea4a5417-1fce-4b36-be4d-215086fd7e96@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
	 <20240102131249.76622-4-gang.li@linux.dev>
	 <1d9074955618ea0b4b155701f7c1b8b18a43fa8d.camel@linux.intel.com>
	 <feaf7851-f924-48f4-b16a-2fa5efdb28cf@linux.dev>
	 <1bd6ee64a600daad58866ce684b591d39879c470.camel@linux.intel.com>
	 <ea4a5417-1fce-4b36-be4d-215086fd7e96@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-15 at 16:57 +0800, Gang Li wrote:
>=20
> On 2024/1/13 02:27, Tim Chen wrote:
> > On Fri, 2024-01-12 at 15:09 +0800, Gang Li wrote:
> > > On 2024/1/12 01:50, Tim Chen wrote:
> > > > On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
> > > > > When a group of tasks that access different nodes are scheduled o=
n the
> > > > > same node, they may encounter bandwidth bottlenecks and access la=
tency.
> > > > >=20
> > > > > Thus, numa_aware flag is introduced here, allowing tasks to be
> > > > > distributed across different nodes to fully utilize the advantage=
 of
> > > > > multi-node systems.
> > > > >=20
> > > > > Signed-off-by: Gang Li <gang.li@linux.dev>
> > > > > ---
> > > > >    include/linux/padata.h | 3 +++
> > > > >    kernel/padata.c        | 8 ++++++--
> > > > >    mm/mm_init.c           | 1 +
> > > > >    3 files changed, 10 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/include/linux/padata.h b/include/linux/padata.h
> > > > > index 495b16b6b4d72..f79ccd50e7f40 100644
> > > > > --- a/include/linux/padata.h
> > > > > +++ b/include/linux/padata.h
> > > > > @@ -137,6 +137,8 @@ struct padata_shell {
> > > > >     *             appropriate for one worker thread to do at once=
.
> > > > >     * @max_threads: Max threads to use for the job, actual number=
 may be less
> > > > >     *               depending on task size and minimum chunk size=
.
> > > > > + * @numa_aware: Dispatch jobs to different nodes. If a node only=
 has memory but
> > > > > + *              no CPU, dispatch its jobs to a random CPU.
> > > > >     */
> > > > >    struct padata_mt_job {
> > > > >    	void (*thread_fn)(unsigned long start, unsigned long end, voi=
d *arg);
> > > > > @@ -146,6 +148,7 @@ struct padata_mt_job {
> > > > >    	unsigned long		align;
> > > > >    	unsigned long		min_chunk;
> > > > >    	int			max_threads;
> > > > > +	bool			numa_aware;
> > > > >    };
> > > > >   =20
> > > > >    /**
> > > > > diff --git a/kernel/padata.c b/kernel/padata.c
> > > > > index 179fb1518070c..1c2b3a337479e 100644
> > > > > --- a/kernel/padata.c
> > > > > +++ b/kernel/padata.c
> > > > > @@ -485,7 +485,7 @@ void __init padata_do_multithreaded(struct pa=
data_mt_job *job)
> > > > >    	struct padata_work my_work, *pw;
> > > > >    	struct padata_mt_job_state ps;
> > > > >    	LIST_HEAD(works);
> > > > > -	int nworks;
> > > > > +	int nworks, nid =3D 0;
> > > >=20
> > > > If we always start from 0, we may be biased towards the low numbere=
d node,
> > > > and not use high numbered nodes at all.  Suggest you do
> > > > static nid =3D 0;
> > > >=20
> > >=20
> > > When we use `static`, if there are multiple parallel calls to
> > > `padata_do_multithreaded`, it may result in an uneven distribution of
> > > tasks for each padata_do_multithreaded.
> > >=20
> > > We can make the following modifications to address this issue.
> > >=20
> > > ```
> > > diff --git a/kernel/padata.c b/kernel/padata.c
> > > index 1c2b3a337479e..925e48df6dd8d 100644
> > > --- a/kernel/padata.c
> > > +++ b/kernel/padata.c
> > > @@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct
> > > padata_mt_job *job)
> > >           struct padata_work my_work, *pw;
> > >           struct padata_mt_job_state ps;
> > >           LIST_HEAD(works);
> > > -       int nworks, nid =3D 0;
> > > +       int nworks, nid;
> > > +       static volatile int global_nid =3D 0;
> > >=20
> > >           if (job->size =3D=3D 0)
> > >                   return;
> > > @@ -516,12 +517,15 @@ void __init padata_do_multithreaded(struct
> > > padata_mt_job *job)
> > >           ps.chunk_size =3D max(ps.chunk_size, job->min_chunk);
> > >           ps.chunk_size =3D roundup(ps.chunk_size, job->align);
> > >=20
> > > +       nid =3D global_nid;
> > >           list_for_each_entry(pw, &works, pw_list)
> > > -               if (job->numa_aware)
> > > -                       queue_work_node((++nid % num_node_state(N_MEM=
ORY)),
> > > -                                       system_unbound_wq, &pw->pw_wo=
rk);
> > > -               else
> > > +               if (job->numa_aware) {
> > > +                       queue_work_node(nid, system_unbound_wq,
> > > &pw->pw_work);
> > > +                       nid =3D next_node(nid, node_states[N_CPU]);
> > > +               } else
> > >                           queue_work(system_unbound_wq, &pw->pw_work)=
;
> > > +       if (job->numa_aware)
> > > +               global_nid =3D nid;
> >=20
> > Thinking more about it, there could still be multiple threads working
> > at the same time with stale global_nid.  We should probably do a compar=
e
> > exchange of global_nid with new nid only if the global nid was unchange=
d.
> > Otherwise we should go to the next node with the changed global nid bef=
ore
> > we queue the job.
> >=20
> > Tim
> >=20
> How about:
> ```
> nid =3D global_nid;
> list_for_each_entry(pw, &works, pw_list)
> 	if (job->numa_aware) {
> 		int old_node =3D nid;
> 		queue_work_node(nid, system_unbound_wq, &pw->pw_work);
> 		nid =3D next_node(nid, node_states[N_CPU]);
> 		cmpxchg(&global_nid, old_node, nid);
> 	} else
> 		queue_work(system_unbound_wq, &pw->pw_work);
>=20
> ```
>=20

I am thinking something like

static volatile atomic_t last_used_nid;

list_for_each_entry(pw, &works, pw_list)
 	if (job->numa_aware) {
		int old_node =3D atomic_read(&last_used_nid);
	=09
		do {
			nid =3D next_node_in(old_node, node_states[N_CPU]);
		} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));
 		queue_work_node(nid, system_unbound_wq, &pw->pw_work);	=09
 	} else {
 		queue_work(system_unbound_wq, &pw->pw_work);
	}

Note that we need to use next_node_in so we'll wrap around the node mask.

Tim

