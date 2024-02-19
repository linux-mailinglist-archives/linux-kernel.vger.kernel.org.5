Return-Path: <linux-kernel+bounces-71179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D685A1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB058281E55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D12C19A;
	Mon, 19 Feb 2024 11:17:08 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207BE200C8;
	Mon, 19 Feb 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341427; cv=none; b=B5IV9v3Y++LacQyBNHdprQbUuyG4ZKwyRGdG9O2ljcvI6CGeRvp4EJgVQ9+5wpd13MK0faO2srByVQIgMI4yltPXiIueek77fD3tNfnzmB0rwURz1El4xTUGMr+qTkRGjbKS4QQAALhWEKB/acP1WHlaBOXRxNJ+IAbRltC5qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341427; c=relaxed/simple;
	bh=T4/GoWefqsmk3T2TyBkikQx3EB5lK7Ir7VybrQOUuWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVqPNf1ze5Z4GK5o5ZSwJiZNY2eVjvfFp+8GgtGFwR20VamfHDprgT3h7bIBaCFdB45WBPBNRu5P6TXGECag+Q3uNKDMVPtDIdw24Zj0MoVFjZbWrsQz3f6bcsKMeX14xi6MKGQJsCypnUcJWDWd4SWr7KnQQyOMDN2IbIicehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 41JBGckY022711;
	Mon, 19 Feb 2024 05:16:38 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 41JBGblb022710;
	Mon, 19 Feb 2024 05:16:37 -0600
Date: Mon, 19 Feb 2024 05:16:37 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH 2/13] Add TSEM specific documentation.
Message-ID: <20240219111636.GA22664@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-3-greg@enjellic.com> <ffdd5e4d10865da5f767df53b12bb6db@paul-moore.com> <20240108114324.GA4085@wind.enjellic.com> <CAHC9VhR+Sukfi+-7TTxK2Paxon6i+zDxaELzXUZ=eBOUMf9nwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR+Sukfi+-7TTxK2Paxon6i+zDxaELzXUZ=eBOUMf9nwA@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 19 Feb 2024 05:16:38 -0600 (CST)

On Mon, Feb 05, 2024 at 11:09:28AM -0500, Paul Moore wrote:

Hi, I hope the week is starting well for everyone.

Sorry for the delay in responding, was involved with a bit of
travel.

> On Mon, Jan 8, 2024 at 6:43AM Dr. Greg <greg@enjellic.com> wrote:
> > On Wed, Jan 03, 2024 at 11:00:33PM -0500, Paul Moore wrote:

> > > > +           trusted pid=PID key=HEXID
> > > > +                   The trusted keyword is used by a trust
> > > > +                   orchestrator to indicate that the process
> > > > +                   identified by the PID argument should be
> > > > +                   allowed to run in trusted status after the
> > > > +                   modeling of a security event.
> >
> > > I mentioned this quite a few times in my review of the previous
> > > patchset, PIDs are not a safe way to identify a process in the
> > > system.  PID reuse/recycling is a real danger and you need to
> > > account for this risk.
> >
> > We will defer that discussion to our previous e-mail where we
> > discussed how this is addressed.

> Adding a secret key/token/etc. may provide some additional
> authentication benefits, but it doesn't entirely solve the PID
> identification issue, it only reduces the likelihood of a process
> misidentification.

We agree with you that PID reuse/recycling is a real danger.  It is
our position that TSEM, for its purposes, properly mitigates this
risk.  

Before doing that, for the benefit of everyone reading along.  The
threat scenario is that a process waiting for model evaluation of an
LSM hook by an external trust orchestrator could be killed and a
process with an identical PID substituted.  This would result in the
trust orchestrator setting the trust status of the wrong process.

Big picture overview:

- A trust orchestrator enforces a security model that has been
  previously established through unit testing as valid.  Substituting
  an alternate process with the same PID would result in that process
  being constrained to only security states that are considered valid.

- Once a process has been designated as untrusted, that status cannot
  be reversed by occupying a known good security state.  Thus a
  process misidentification attack cannot be used to reverse the
  trust state of an untrusted process.

For purposes of further clarification, lets look at the relevant
portions of the TSEM code.

For an externally modeled domain, the process begins with the export
of the security event description by tsem_export_event() in export.c:

---------------------------------------------------------------------------
int tsem_export_event(struct tsem_event *ep)
{
	int retn = 0;
	struct export_event *exp;
	struct tsem_task *task = tsem_task(current);
	struct tsem_context *ctx = task->context;

	exp = allocate_export(ep->locked);
	if (!exp) {
		pr_warn("tsem: domain %llu failed export allocation.\n",
			ctx->id);
		return -ENOMEM;
	}

	exp->type = ep->locked ? EXPORT_ASYNC_EVENT : EXPORT_EVENT;
	exp->u.ep = ep;
	tsem_event_get(ep);

	spin_lock(&ctx->external->export_lock);
	list_add_tail(&exp->list, &ctx->external->export_list);
	spin_unlock(&ctx->external->export_lock);

	if (ctx->external->export_only || ep->locked) {
		trigger_event(ctx);
		return 0;
	}

	task->trust_status |= TSEM_TASK_TRUST_PENDING;
	trigger_event(ctx);

A TSEM modeled task can exist in one of two states: TRUSTED and
UNTRUSTED in combination with TRUST_PENDING.  The process trust status
gets set to TRUST_PENDING to force it to wait until it is released by
the trust orchestrator.  The orchestrator is signaled to indicate that
a security event is in need of evaluation.

The process then waits in the following loop until the trust
orchestrator issues a control plane call to set its trust status and
clear the TRUST_PENDING state.  The PID slot will be maintained and
thus unavailable by virtue of the task maintaining a reference to the
PID slot while it is sleeping.

	while (task->trust_status & TSEM_TASK_TRUST_PENDING) {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule();
		if (fatal_signal_pending(task)) {
			retn = -EPERM;
			task->trust_status = TSEM_TASK_UNTRUSTED;
		}
	}

The only way out of the loop is to either have the TRUST_PENDING
status cleared by the orchestrator or to have a fatal signal queued.
In the event of the latter condition, the process trust state is set
to untrusted for the exit and an error is returned to the trust
orchestrator.

An error return from a control plane call would be considered an
actionable event to shutdown the workload, secondary to it being
considered untrusted by virtue of a failure that should not occur.
The process itself would be considered untrusted during its exit.

Next, lets consider the issues and protections surrounding the
initiation of a fatal signal.

A security modeling namespace serves as a boundary for a kill signal,
unless a cross-model signal generation event has been enabled in the
signal initiating namespace or the initiating process has
CAP_MAC_ADMIN privileges.  Either case admits the notion that such a
signal is being administratively allowed from a security perspective.

Within a security namespace, for a kill signal to be initiated, it
must have a security state coefficient included in the model that is
specific to the TASK_ID of the process initiating the signal.  The
target of the signal must have a specific TASK_ID as well.

This gates successful signaling to two binaries of known provenance.  
Given that the model being enforced is generated from a known good unit
test, no adversarial signals would be allowed from within the modeling
namespace.

That leaves the OOM killer, as has been previously suggested.  An
adversary would need to deplete memory in a manner that caused the OOM
killer to select the process that was sleeping on an evaluation by the
trust orchestrator, rather than the adversarial process or processes
that were consuming memory.

We would also offer the following with respect to the latency
challenges associated with a PID misidentification attack.

As noted previously, threat latencies with respect to substituting an
alternate process with something like the OOM killer would be on the
order of 200-300 micro-seconds.

A sufficient number of processes would have to be forked during the
race window in order to have a process poised to replace the task that
is being held for trust evaluation.  These forks must occur before the
trust orchestrator has a chance to be scheduled and complete
processing of the event, which would have the effect of terminating
the race window.

For purposes of reasoning, here is a sample of average process fork
latencies over 32,768 attempts:

Intel(R) Xeon(R) Silver 4214R CPU @ 2.40GHz - 8 core - 69.4 micro-seconds

Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz - 4 core - 81.3 micro-seconds

Intel(R) Core(TM) i5-9400 CPU @ 2.90GHz - 1 core - 132.2 micro-seconds

The above timings indicate a requirement for an adversarial process to
be within a window of 2-5 PID 'slots' below the target process for an
attack to be effective.

As noted at the start of this mail, the substituted PID would be
constrained to the security policy that the trust orchestrator is
implementing.  It would thus be limited from initiating any security
relevant events that are inconsistent with the security model being
enforced.

A single failed security event would result in a security state change
for the security modeling namespace, that in turn would result in
failed attestation of the trust status of the workload or platform.

	return retn;
}
---------------------------------------------------------------------------

There are additional quarantees in place that disallow a substituted
process from being acted upon by the trust orchestrator for a security
modeling namespace.

For an externally modeled security event, the process ends with a
request by the trust orchestrator, through the control plane file for
the security modeling namespace.  The file only allows a single open
and that open would have been by the trust orchestrator that created
the security modeling namespace, thereby precluding an adversarial
process from gaining control of the release process.

The trust relationship between an orchestrator and the processes in a
security modeling namespace is established in the allocate_external()
function in namespace.c:

---------------------------------------------------------------------------
static struct tsem_external *allocate_external(u64 context_id,
					       const char *keystr)
{
	int retn = -ENOMEM;
	char bufr[20 + 1];
	struct tsem_external *external;
	struct tsem_task *t_ttask = tsem_task(current);
	struct tsem_task *p_ttask = tsem_task(current->real_parent);

	external = kzalloc(sizeof(*external), GFP_KERNEL);
	if (!external)
		goto done;

	retn = generate_task_key(keystr, context_id, t_ttask, p_ttask);
	if (retn)
		goto done;

The generate_task_key() function is responsible for generating a
random trust orchestrator identifier that is unique across all
currently active security modeling namespaces.  Uniqueness is
guaranteed by all facets of namespace creation being gated by the
context_id_mutex lock held during the critical section of namespace
creation in tsem_ns_create().

Half of the input to the final identifier is provided by the trust
orchestrator, with the other half being a random key is generated and
attempted until a system unique identifier is demonstrated.

The trust orchestrator identifier is copied into the TSEM specific
portion of the task structure of the parent of the task that is
creating the namespace (p_ttask).  This process is the trust
orchestrator that forked the current process that is divesting itself,
and its children, into a new security modeling namespace.

By virtue of this uniqueness gurantee, no other task on the system
will have this identifier.

	spin_lock_init(&external->export_lock);
	INIT_LIST_HEAD(&external->export_list);

	init_waitqueue_head(&external->wq);

	scnprintf(bufr, sizeof(bufr), "%llu", context_id);
	external->dentry = tsem_fs_create_external(bufr);
	if (IS_ERR(external->dentry)) {
		retn = PTR_ERR(external->dentry);
		external->dentry = NULL;
	} else
		retn = 0;

 done:
	if (retn) {
		memset(t_ttask->task_key, '\0', tsem_digestsize());
		memset(p_ttask->task_key, '\0', tsem_digestsize());
		kfree(external);
		remove_task_key(context_id);
		external = ERR_PTR(retn);
	} else
		p_ttask->tma_for_ns = context_id;

In addition to having a system unique orchestration identifier placed
in the trust orchestrator's task structure, the identifier of the
namespace, that is guaranteed to not wrap, is also placed in the task
control structure of the orchestrator.

	return external;
}
---------------------------------------------------------------------------

All of this leads us to the processing of the control plane request by
a trust orchestrator to set the trust status of a process whose
security event is being modeled.  This request is handled by the
control_COE() function in fs.c:

---------------------------------------------------------------------------
static int control_COE(unsigned long cmd, pid_t pid, char *keystr)
{
	bool wakeup = false;
	int retn = -ESRCH;
	u8 event_key[HASH_MAX_DIGESTSIZE];
	struct task_struct *COE;
	struct tsem_task *task;
	struct tsem_task *tma = tsem_task(current);

	rcu_read_lock();
	COE = find_task_by_vpid(pid);

We use the standard kernel infrastructure to find the PID that has
been previously put to sleep in the export code.  If someone was
nefariously attempting to kill PIDs, an actionable error will be
registered with the trust orchestor if the task cannot be located.

Once again, the only way out of the previously described control
section is by either the process receiving a fatal signal or this
function clearing the TRUST_PENDING state bit.

	if (COE != NULL) {
		task = tsem_task(COE);
		if (tsem_context(COE)->id != tma->tma_for_ns) {
			retn = -EINVAL;
			goto done;
		}

Once the candidate task is located, its security modeling namespace
identifier is verified to match that of the trust orchestrator.  This
denies processes from outside of the security modeling namespace
access to this control call.

		retn = tsem_ns_event_key(task->task_key, keystr, event_key);
		if (retn)
			goto done;

The trust orchestrator identifier is generated using half of the key
re-supplied in the control call by the trust orchestrator itself and
the other half that has been re-supplied from the task structure of
the process being evaluated.

This limits the PID substitution domain to the security modeling
namespace that the trust orchestrator holds dominion over.  Once
again, only security relevant events that the namespace has been
tested to are allowed to occur within the namespace.

If a PID substitution attack were to be mounted, it would have to be
by 'known good' code that was admitted for execution into the modeling
namespace.

		if (memcmp(tma->task_key, event_key, tsem_digestsize())) {
			retn = -EINVAL;
			goto done;
		}

The generated key is compared to the key held inside the task control
structure of the trust orchestrator and the control is denied if they
do not match.  Once again, this would be an actionable event to
shutdown the workload as being untrusted.

		if (cmd == TSEM_CONTROL_UNTRUSTED)
			task->trust_status = TSEM_TASK_UNTRUSTED;
		if (cmd == TSEM_CONTROL_TRUSTED) {
			if (tsem_task_trusted(COE))
				task->trust_status = TSEM_TASK_TRUSTED;
		}
		task->trust_status &= ~TSEM_TASK_TRUST_PENDING;

The trust status of the process is set and the TRUST_PENDING state is
cleared.  As the above code section demonstrates, a process that is
untrusted cannot use a PID substitution attack to convert its status
to trusted.

		}
		retn = 0;
		wakeup = true;
	}

 done:
	rcu_read_unlock();

	if (retn == -EINVAL)
		pr_warn("tsem: Invalid process release request.\n");

	if (wakeup)
		wake_up_process(COE);

The process is turned loose from its loop in
export.c:tsem_export_event() with its new trust status.

	return retn;
}
---------------------------------------------------------------------------

> We need to do better for new designs/implementations; look at the
> pidfd work as an example of work that has gone into
> reducing/eliminating the use of PIDs to identify processes.

We have a high degree of familiarity with the pidfd work, in fact we
use pidfd_open() to establish a stable and immutable relationship
between a Quixote trust orchestrator and the lead process in a
security modeling namespace, typically runc in a container
environment.

In TSEM, the issue is that the trust orchestrator may not have a
direct relationship with any number of processes that may be running
in a security modeling namespace.  Processes asynchronously generate
events that need to be identified for the trust orchestrator to act
on.

If we misunderstand pidfd's, or lack understanding of other alternate
infrastructure that could be purposed for our needs, we would
certainly be interested in your thoughts on an alternate
implementation.

Otherwise we would enjoy specific comments on how our implementation
would be security insufficient in the face of a PID substitution or
race attack.

> paul-moore.com

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

