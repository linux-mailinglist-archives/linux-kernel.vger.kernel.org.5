Return-Path: <linux-kernel+bounces-135301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1B89BE9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BB12839EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB36A33B;
	Mon,  8 Apr 2024 12:07:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E24F69E07;
	Mon,  8 Apr 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578026; cv=none; b=nY5WLGxmVaSlWfirF/32HupGRqufqt40NcJhGC7l75jiSDyu50RBi1ATkx9SAoMEfmLHHaUItV5BeMOv+8LhV7o0P9n8g3KUsPasVXNx8kQ9zsURuONXA6ba31VMpU6SEaTl17FerNyp/PC/rQDjjIyipGJVbFYojlvvjnicUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578026; c=relaxed/simple;
	bh=WKSmpMAYsLBJV7k1A1XvG5fWMhX00XretvQcvSHo02I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW08STdJXQi0SjGbHVowlIxWmVBFGJOAxGAdr8rj1oucyCiHXWntUAGcE3dzG6MBsHXZJxxza0WsMNW0s8DYg0taR93XjcN2Vtt/pJVYEaOeDUnHAwW4Ib3Pf/t0vM+l9GxGXFHQOz6m1dnqpXhIW3DuU6KGEOyFMbFzkhXY6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-6b-6613dde2594e
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 5/7] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Mon,  8 Apr 2024 21:06:44 +0900
Message-ID: <20240408120648.2947-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240405192430.67046-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXC9ZZnke6ju8JpBpduG1tM7DGwmLN+DZvF
	rhshFvcfvGa3+L/3GKPFk/+/WS1O3Gxks+j8vpTF4vKuOWwW99b8Z7U4sv4si8Xms2eYLRYv
	V7PY1/GAyeLw1zdMFpMvLWCzeDHlDKPFyVmTWSxmH73H7iDssfT0GzaPDU1AYuesu+weLftu
	sXss2FTq0XLkLavH4j0vmTw2repk89j0aRK7x4kZv1k8dj609HixeSajR2/zOzaPz5vkAvii
	uGxSUnMyy1KL9O0SuDKuL3nPXNCbU/GhaQ9TA+Pe4C5GTg4JAROJby27WboYOcDsuzf5QcJs
	AmoSV15OYgKxRQQUJc49vsjaxcjFwSwwg0Xi8MIuRpCEsECCRNuNj6wgNouAqsTX/qNgc3gF
	zCS+z1OEGK8p8Xj7T3YQm1PAWOJf8x4WEFtIgEfi1Yb9YGN4BQQlTs58AhZnFpCXaN46mxlk
	l4TAKXaJGY9fM0EMkpQ4uOIGywRG/llIemYh6VnAyLSKUSgzryw3MTPHRC+jMi+zQi85P3cT
	IzDqltX+id7B+OlC8CFGAQ5GJR5ei6vCaUKsiWXFlbmHGCU4mJVEeINNBdOEeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MBosWLTgofmMp6u6xJMOLNQv
	vsK729unJv3Ve3bhR6apRVOzTiw9+zV8m7PwjZm8O/M/apa/+Xc1cpf7nn5ZH7mU+vCsZzI7
	LBN5xVe4NkemLL2qrb2VzbRsXbj8rucsFx3yGxs2/2v+8kJUQkfV+0LOP7nGA0lps3dsmOXK
	WzVlrWW8m2GxhBJLcUaioRZzUXEiADhtLDS2AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXCNUNLT/fRXeE0g/3/lSwm9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXQ++c5ocXjuSVaLzu9LWSwu75rDZnFvzX9WiyPr
	z7JYbD57htli8XI1i0PXnrNa7Ot4wGRx+OsbJovJlxawWbyYcobR4uSsySwWs4/eY3cQ81h6
	+g2bx4YmILFz1l12j5Z9t9g9Fmwq9Wg58pbVY/Gel0wem1Z1snls+jSJ3ePEjN8sHjsfWnq8
	2DyT0aO3+R2bx7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoEr4/qS98wFvTkVH5r2MDUw
	7g3uYuTgkBAwkbh7k7+LkZODTUBN4srLSUwgtoiAosS5xxdZuxi5OJgFZrBIHF7YxQiSEBZI
	kGi78ZEVxGYRUJX42n+UBWQOr4CZxPd5iiBhCQFNicfbf7KD2JwCxhL/mvewgNhCAjwSrzbs
	BxvDKyAocXLmE7A4s4C8RPPW2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85
	P3cTIzC+ltX+mbiD8ctl90OMAhyMSjy8DneE04RYE8uKK3MPMUpwMCuJ8AabCqYJ8aYkVlal
	FuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MNY7hjFPabxx5mFWp/n7
	ZZub/MzL4ww/v0mqvb5a4UYI40sGuR3Lev/1Lmrp2378RO6yo2GW0bmrr+0s3ql86/Xvmuq9
	ho0X4g+1KJw/6Dn9/dvsm6ZLKh/ZHH2u1XS39IPq1L33svoSmtsurYmc9XbfwVgrh1bfDcIM
	fRtOmLC825iwv2uniKcSS3FGoqEWc1FxIgCHbSUfqwIAAA==
X-CFilter-Loop: Reflected

On Fri,  5 Apr 2024 12:24:30 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Fri,  5 Apr 2024 15:08:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > This patch introduces DAMOS_MIGRATE_COLD action, which is similar to
> > DAMOS_PAGEOUT, but migrate folios to the given 'target_nid' in the sysfs
> > instead of swapping them out.
> > 
> > The 'target_nid' sysfs knob is created by this patch to inform the
> > migration target node ID.
> 
> Isn't it created by the previous patch?

Right.  I didn't fix the commit message after split this patch.  I will
fix it.

> > 
> > Here is one of the example usage of this 'migrate_cold' action.
> > 
> >   $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
> >   $ cat contexts/<N>/schemes/<N>/action
> >   migrate_cold
> >   $ echo 2 > contexts/<N>/schemes/<N>/target_nid
> >   $ echo commit > state
> >   $ numactl -p 0 ./hot_cold 500M 600M &
> >   $ numastat -c -p hot_cold
> > 
> >   Per-node process memory usage (in MBs)
> >   PID             Node 0 Node 1 Node 2 Total
> >   --------------  ------ ------ ------ -----
> >   701 (hot_cold)     501      0    601  1101
> > 
> > Since there are some common routines with pageout, many functions have
> > similar logics between pageout and migrate cold.
> > 
> > damon_pa_migrate_folio_list() is a minimized version of
> > shrink_folio_list(), but it's minified only for demotion.
> 
> MIGRATE_COLD is not only for demotion, right?  I think the last two words are
> better to be removed for reducing unnecessary confuses.

You mean the last two sentences?  I will remove them if you feel it's
confusing.

> > 
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> > ---
> >  include/linux/damon.h    |   2 +
> >  mm/damon/paddr.c         | 146 ++++++++++++++++++++++++++++++++++++++-
> >  mm/damon/sysfs-schemes.c |   4 ++
> >  3 files changed, 151 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 24ea33a03d5d..df8671e69a70 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -105,6 +105,7 @@ struct damon_target {
> >   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
> >   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
> >   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
> > + * @DAMOS_MIGRATE_COLD: Migrate for the given cold region.
> 
> Whether it will be for cold region or not is depending on the target access
> pattern.  What about 'Migrate the regions in coldest regions first manner.'?
> Or, simply 'Migrate the regions (prioritize cold)' here, and explain about the
> prioritization under quota on the detailed comments part?

"Migrate the regions in coldest regions first manner under quota" sounds
better.  I will change it.

> Also, let's use tab consistently.

Yeah, it's a mistake.  will fix it.

> >   * @DAMOS_STAT:		Do nothing but count the stat.
> >   * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
> >   *
> > @@ -122,6 +123,7 @@ enum damos_action {
> >  	DAMOS_NOHUGEPAGE,
> >  	DAMOS_LRU_PRIO,
> >  	DAMOS_LRU_DEPRIO,
> > +	DAMOS_MIGRATE_COLD,
> >  	DAMOS_STAT,		/* Do nothing but only record the stat */
> >  	NR_DAMOS_ACTIONS,
> >  };
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 277a1c4d833c..fe217a26f788 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -12,6 +12,9 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/rmap.h>
> >  #include <linux/swap.h>
> > +#include <linux/memory-tiers.h>
> > +#include <linux/migrate.h>
> > +#include <linux/mm_inline.h>
> >  
> >  #include "../internal.h"
> >  #include "ops-common.h"
> > @@ -226,8 +229,137 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
> >  
> >  enum migration_mode {
> >  	MIG_PAGEOUT,
> > +	MIG_MIGRATE_COLD,
> >  };
> >  
> > +static unsigned int migrate_folio_list(struct list_head *migrate_folios,
> > +				       struct pglist_data *pgdat,
> > +				       int target_nid)
> 
> To avoid name collisions, I'd prefer having damon_pa_prefix.  I show this patch
> is defining damon_pa_migrate_folio_list() below, though.  What about
> __damon_pa_migrate_folio_list()?

Ack.  I will change it to __damon_pa_migrate_folio_list().

> > +{
> > +	unsigned int nr_succeeded;
> > +	nodemask_t allowed_mask = NODE_MASK_NONE;
> > +
> 
> I personally prefer not having empty lines in the middle of variable
> declarations/definitions.  Could we remove this empty line?

I can remove it, but I would like to have more discussion about this
issue.  The current implementation allows only a single migration
target with "target_nid", but users might want to provide fall back
migration target nids.

For example, if more than two CXL nodes exist in the system, users might
want to migrate cold pages to any CXL nodes.  In such cases, we might
have to make "target_nid" accept comma separated node IDs.  nodemask can
be better but we should provide a way to change the scanning order.

I would like to hear how you think about this.

> > +	struct migration_target_control mtc = {
> > +		/*
> > +		 * Allocate from 'node', or fail quickly and quietly.
> > +		 * When this happens, 'page' will likely just be discarded
> > +		 * instead of migrated.
> > +		 */
> > +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> > +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> > +		.nid = target_nid,
> > +		.nmask = &allowed_mask
> > +	};
> > +
> > +	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
> > +		return 0;
> > +
> > +	if (list_empty(migrate_folios))
> > +		return 0;
> 
> Can't these checks be done by the caller?

Sure.  I will move them to the caller.

> > +
> > +	/* Migration ignores all cpuset and mempolicy settings */
> > +	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
> > +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
> > +		      &nr_succeeded);
> > +
> > +	return nr_succeeded;
> > +}
> > +
> > +static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
> > +						struct pglist_data *pgdat,
> > +						enum migration_mode mm,
> 
> Again, 'mm' makes my poor brain a bit confused.  What about 'mode'?
> And, seems this is not used at all in this function?  Can we just drop this?

Ack.  I will remove it in this patch and introduce it in the patch where
it's used.

> > +						int target_nid)
> > +{
> > +	unsigned int nr_migrated = 0;
> > +	struct folio *folio;
> > +	LIST_HEAD(ret_folios);
> > +	LIST_HEAD(migrate_folios);
> > +
> > +	cond_resched();
> 
> We will do this again at the beginning of the loop.  Do we need this here?

This comes from shrink_folio_list() but this function is way simpler so
it can be removed.

> > +
> > +	while (!list_empty(folio_list)) {
> > +		struct folio *folio;
> > +
> > +		cond_resched();
> > +
> > +		folio = lru_to_folio(folio_list);
> > +		list_del(&folio->lru);
> > +
> > +		if (!folio_trylock(folio))
> > +			goto keep;
> > +
> > +		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> 
> Why?  I think we could want to migrate active pages in some use case, e.g., to
> reduce memory bandwidth?

Yeah, I will remove it.

> > +
> > +		/* Relocate its contents to another node. */
> > +		list_add(&folio->lru, &migrate_folios);
> > +		folio_unlock(folio);
> > +		continue;
> > +keep:
> > +		list_add(&folio->lru, &ret_folios);
> > +		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> 
> Can this happen?  I think this could be too much test?  checkpatch.pl also
> warns.

Likewise, the current shrink_folio_list does so brought it in this patch
as well, but I think we can remove it here.

> > +	}
> > +	/* 'folio_list' is always empty here */
> > +
> > +	/* Migrate folios selected for migration */
> > +	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, target_nid);
> > +	/* Folios that could not be migrated are still in @migrate_folios */
> > +	if (!list_empty(&migrate_folios)) {
> > +		/* Folios which weren't migrated go back on @folio_list */
> > +		list_splice_init(&migrate_folios, folio_list);
> > +	}
> 
> Let's not use braces for single statement
> (https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces).

Hmm.. I know the convention but left it as is because of the comment.
If I remove the braces, it would have a weird alignment for the two
lines for comment and statement lines.

> > +
> > +	try_to_unmap_flush();
> > +
> > +	list_splice(&ret_folios, folio_list);
> 
> Can't we move remaining folios in migrate_folios to ret_folios at once?

I will see if it's possible.

> > +
> > +	while (!list_empty(folio_list)) {
> > +		folio = lru_to_folio(folio_list);
> > +		list_del(&folio->lru);
> > +		folio_putback_lru(folio);
> > +	}
> > +
> > +	return nr_migrated;
> > +}
> > +
> > +static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
> > +					    enum migration_mode mm,
> 
> Again, I'd prefer calling this 'mode' or something other than 'mm'.
> And, seems 'mm' is not really used in this function.  It is passed to
> 'damon_pa_migrate_folio_list()' but it deosn't really use it.  Can we drop
> this?

Sure.  I will drop it here and rename it to "mode" where it's used.

> > +					    int target_nid)
> > +{
> > +	int nid;
> > +	unsigned int nr_migrated = 0;
> 
> Let's make this matches with the return type of this function.

Ack.  will change it to unsigned long.

> > +	LIST_HEAD(node_folio_list);
> > +	unsigned int noreclaim_flag;
> > +
> > +	if (list_empty(folio_list))
> > +		return nr_migrated;
> > +
> > +	noreclaim_flag = memalloc_noreclaim_save();
> > +
> > +	nid = folio_nid(lru_to_folio(folio_list));
> > +	do {
> > +		struct folio *folio = lru_to_folio(folio_list);
> > +
> > +		if (nid == folio_nid(folio)) {
> > +			folio_clear_active(folio);
> 
> I think this was necessary for demotion, but now this should be removed since
> this function is no more for demotion but for migrating random pages, right?

Yeah,  it can be removed because we do migration instead of demotion,
but I need to make sure if it doesn't change the performance evaluation
results.

> > +			list_move(&folio->lru, &node_folio_list);
> > +			continue;
> > +		}
> > +
> > +		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> > +							   NODE_DATA(nid), mm,
> > +							   target_nid);
> > +		nid = folio_nid(lru_to_folio(folio_list));
> > +	} while (!list_empty(folio_list));
> > +
> > +	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> > +						   NODE_DATA(nid), mm,
> > +						   target_nid);
> > +
> > +	memalloc_noreclaim_restore(noreclaim_flag);
> > +
> > +	return nr_migrated;
> > +}
> > +
> >  static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> >  				      enum migration_mode mm)
> >  {
> > @@ -247,7 +379,11 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> >  		folio_test_clear_young(folio);
> >  		if (!folio_isolate_lru(folio))
> >  			goto put_folio;
> > -		if (folio_test_unevictable(folio))
> > +		/*
> > +		 * Since unevictable folios can be demoted or promoted,
> 
> Let's use the term 'migrated' instead of 'demoted' or 'promoted'.

Ack.

> > +		 * unevictable test is needed only for pageout.
> > +		 */
> > +		if (mm == MIG_PAGEOUT && folio_test_unevictable(folio))
> >  			folio_putback_lru(folio);
> >  		else
> >  			list_add(&folio->lru, &folio_list);
> > @@ -258,6 +394,10 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> >  	case MIG_PAGEOUT:
> >  		applied = reclaim_pages(&folio_list);
> >  		break;
> > +	case MIG_MIGRATE_COLD:
> > +		applied = damon_pa_migrate_pages(&folio_list, mm,
> > +						 s->target_nid);
> > +		break;
> >  	default:
> >  		/* Unexpected migration mode. */
> >  		return 0;
> > @@ -314,6 +454,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
> >  		return damon_pa_mark_accessed(r, scheme);
> >  	case DAMOS_LRU_DEPRIO:
> >  		return damon_pa_deactivate_pages(r, scheme);
> > +	case DAMOS_MIGRATE_COLD:
> > +		return damon_pa_migrate(r, scheme, MIG_MIGRATE_COLD);
> >  	case DAMOS_STAT:
> >  		break;
> >  	default:
> > @@ -334,6 +476,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
> >  		return damon_hot_score(context, r, scheme);
> >  	case DAMOS_LRU_DEPRIO:
> >  		return damon_cold_score(context, r, scheme);
> > +	case DAMOS_MIGRATE_COLD:
> > +		return damon_cold_score(context, r, scheme);
> >  	default:
> >  		break;
> >  	}
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 1a30ea82c890..18b7d054c748 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -1406,6 +1406,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
> >  	"nohugepage",
> >  	"lru_prio",
> >  	"lru_deprio",
> > +	"migrate_cold",
> >  	"stat",
> >  };
> >  
> > @@ -1659,6 +1660,9 @@ static ssize_t target_nid_store(struct kobject *kobj,
> >  			struct damon_sysfs_scheme, kobj);
> >  	int err = 0;
> >  
> > +        if (scheme->action != DAMOS_MIGRATE_COLD)
> > +                return -EINVAL;
> > +
> 
> I think user could set target_nid first, and then action.  So I think this
> should not return error?

Make sense.  I will drop this check.

Thanks,
Honggyu

> >  	/* TODO: error handling for target_nid range. */
> >  	err = kstrtoint(buf, 0, &scheme->target_nid);
> >  
> > -- 
> > 2.34.1
> > 
> > 
> 
> 
> Thanks,
> SJ

