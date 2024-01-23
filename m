Return-Path: <linux-kernel+bounces-36063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7645839AED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8861C27517
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0642C682;
	Tue, 23 Jan 2024 21:18:03 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486F2C1A7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044682; cv=none; b=EGL/FF63vtKawTkocal7JA3vK7Oyqd32RRU7cDFxCMbYZBAX1TRoalwiVdHfhrgM7HF64+olLuieis4zgejTzxtKRDAEjWG9J5Ot42CfhuOGSZilpYuoRb3aEG2NI4VnPB0H1erC/D+updFItiwt1fylKkEAHwxj8hkhekIDOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044682; c=relaxed/simple;
	bh=wGHQgwkAxXBqCmlJ12C/eCj9q9Ye7h6lCSMRHmIxnMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMaZ0rNmMKuzpZd2WRDRKfiG8oMCmKA9SqE/LFn0OPcjTrgrwHxKS9e8rgW6BOOPcr5Z1R2Y0d70+RaQV0IwgaFm/zXulB2kRITvVSvUJ/zDm7R7C0FBpIrsE7OnnbBeplnwc8A3kbq2qPRc5USucQO0BeFe84Hfl/Bfynh/NgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60036bfdbfeso12611227b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706044680; x=1706649480;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK/MhqIivwhUwQG9RY/nzKBZcdPyV5zeXLTCh7cQCM0=;
        b=pi/9EN7W90Eje2OBE3n18B0KzDYHEgz+gwwLJPbaEmCcioX9nnSu0/p2HjxKKUCCXB
         N407JE3lCrOr876F4ALZNb+NUV0J1IPRYC5PlUogQrK+BPD6l/DtSc4/+CVH2FuRTgPS
         OZ3sqd2jFzqQUfg0WZdvj3JjRKGvd5WdEYBwIe7VTv/MNR89YaQiXx6OVxUXBnvdkSc6
         xxOZPVVGKDTCurSR2+QIu8UcNumA4NgE5WVsFsOifIDB2DCPCFa0054GrUS4b6dapsEm
         /R/O0TB3l61C5o4yL8iu8C9q5m0tOdg3sMbPWEsemkTa52kZ7mHodq1tyP1MSxqFewcO
         epaA==
X-Gm-Message-State: AOJu0YxQQV0dakxhy2tBaSF0e5DJM5UGcXHN8zNHVFbt6GA3gbcJ5MCT
	S6LgmRzvaSpXdQqBmIcDS6iQT8nr/99WbKCoKnTUZCMSGUTYPj88wOFw8ukonmhzmw==
X-Google-Smtp-Source: AGHT+IHAFlWSX9BgP0/cg2Cj2bjGBYYTBAk1PXlrSLqy6C5bci+YXqjPnDJFgeDnBOMx1j6DPxLa1A==
X-Received: by 2002:a0d:d544:0:b0:600:2210:2713 with SMTP id x65-20020a0dd544000000b0060022102713mr3140611ywd.78.1706044679856;
        Tue, 23 Jan 2024 13:17:59 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id ny18-20020a056214399200b006868e6d8b37sm2485459qvb.23.2024.01.23.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:17:59 -0800 (PST)
Date: Tue, 23 Jan 2024 15:17:56 -0600
From: David Vernet <void@manifault.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
Message-ID: <20240123211756.GA221793@maniforge>
References: <20240119084548.2788-1-kprateek.nayak@amd.com>
 <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
 <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NpsGShKTC/EGpTST"
Content-Disposition: inline
In-Reply-To: <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--NpsGShKTC/EGpTST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:28:31AM +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> On 1/23/2024 3:29 AM, Tim Chen wrote:
> > On Fri, 2024-01-19 at 14:15 +0530, K Prateek Nayak wrote:
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index b803030c3a03..1fedc7e29c98 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -8499,6 +8499,16 @@ done: __maybe_unused;
> >>  	if (!rf)
> >>  		return NULL;
> >> =20
> >> +	/*
> >> +	 * An idle CPU in TIF_POLLING mode might end up here after processing
> >> +	 * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
> >> +	 * sending an actual IPI. In such cases, where an idle CPU was woken
> >> +	 * up only to process an interrupt, without necessarily queuing a ta=
sk
> >> +	 * on it, skip newidle_balance() to facilitate faster idle re-entry.
> >> +	 */
> >> +	if (prev =3D=3D rq->idle)
> >> +		return NULL;
> >> +
> >=20
> > Should we check the call function queue directly to detect that there is
> > an IPI waiting to be processed? something like
> >=20
> > 	if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
> > 		return NULL;
>=20
> That could be a valid check too. However, if an IPI is queued right
> after this check, the processing is still delayed since
> newidle_balance() only bails out for scenarios when a wakeup is trying
> to queue a new task on the CPU running the newidle_balance().
>=20
> >=20
> > Could there be cases where we want to do idle balance in this code path?
> > Say a cpu is idle and a scheduling tick came in, we may try
> > to look for something to run on the idle cpu.  Seems like after
> > your change above, that would be skipped.
>=20
> Wouldn't scheduler_tick() do load balancing when the time comes? In my
> testing, I did not see a case where the workloads I tested were
> sensitive to the aspect of newidle_balance() being invoked at scheduler
> tick. Have you come across a workload which might be sensitive to this
> aspect that I can quickly test and verify? Meanwhile, I'll run the
> workloads mentioned in the commit log on an Intel system to see if I
> can spot any sensitivity to this change.
>=20
> Adding David to the thread too since HHVM seems to be one of those
> workloads that is very sensitive to a successful newidle_balance().

Thanks for the cc. FWIW, I think a lot of things are very sensitive to
timing in newidle_balance(), but it goes both ways. For example, we had
to revert commit e60b56e46b38 ("sched/fair: Wait before decaying
max_newidle_lb_cost") [0] on our internal kernel because it regressed
some workloads by causing us to load_balance() too frequently. I think
the fix is correct in that there's no reason we shouldn't apply the ~1%
decay / second to newidle lb cost in newidle_balance(), but by causing
us to (correctly) decay newidle lb cost in newidle_balance(), it also
increased CPU util rather significantly and had us spending too much
time in load_balance().

[0]: https://lore.kernel.org/all/20211019123537.17146-4-vincent.guittot@lin=
aro.org/

On the other hand, on other hosts, we use SHARED_RUNQ to load balance as
aggressively as possible, and those hosts would have benefited from that
change if SHARED_RUNQ wasn't an option.

My 2 cents is that I think it's impossible to make everyone happy, and I
think the change here makes sense. If there's imbalance, it's something
we would uncover when load_balance() is kicked off on the tick path
anyways. I also agree with Vincent [1] that your idea / prototype of
adding a TIF_NEED_IPI flag is an overall better solution, but this does
seem fine to me as well in the interim.

[1]: https://lore.kernel.org/all/CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7ag=
OHY4hs-Pw@mail.gmail.com/

Thanks,
David

--NpsGShKTC/EGpTST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbAtBAAKCRBZ5LhpZcTz
ZFuDAQD+5FTW3DS3AoIE8TR3lgS9s7Js2dsQOhf2N5Aok5Z19AEA/k09QQ7fB1fc
nnDXdpVSyomqTYIf/gAf60Wd9tsVswY=
=APqD
-----END PGP SIGNATURE-----

--NpsGShKTC/EGpTST--

