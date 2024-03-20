Return-Path: <linux-kernel+bounces-108521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2264880BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C351F23AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8861EA90;
	Wed, 20 Mar 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JRDIUZ8c"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25211DFEA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918277; cv=none; b=MDfOv/yxjeBXbKpQqUOxsqEX8Pvvj4j8C2HwRXvwE/jRzHILxqE4yGqf+WeI5jfubiEQxmgj6LTjTucspQMNkRceRY00YqBZj9NMD6oDpv8Jvj17I1T0g26nst0chnZDBbJKzcXpIrszSkQii3IIYXmEhK9KConnXK5C9H4TP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918277; c=relaxed/simple;
	bh=I3IV91ndQX+iEcDMwkJBEu1Gi7YjSUg57qdCNpilP+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k8C+I21YOKNLI5hXT7wUrNH6DWgUBt4paFK58NLjIT9SZOzElZZpXHzbbZBx6qlHOxeBcATe0uSp3zy8nPLSBkDV5nIOAgfpjmuNDztw8A0UK5dvmWbWZVYflJEyfVFTk+jFgL+I9JuJEcCyEKlP5uyNQ1DfhWO/OSwYIGwkR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JRDIUZ8c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K6HVEX004924;
	Wed, 20 Mar 2024 07:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=XpxGHAgCPpjGEO+oF502GL9pyIPi3QKyPPX1JuNn9UY=;
 b=JRDIUZ8cVBcJo9JRYVmOSVuR4VSJRDyoaS1wvGxi6qYfsCl2vamtwliEhx1j6MWd5E1y
 l7n0skM2nTWeCy0OVHryRaac7ygikV5BhAXEv8dS+/tS5WK59dcqlybBU+NJHAcTV/L0
 t9JgSMFQXde4KnA7+ML1lmtxNFbgaoHWqBW8a4Rt456mwvJasDqplmOfpHWjRGEfxxkX
 em/t4AMMUp/kFAE/5gMSvcKRp5BG0u7vWmdRLWBzXdrdiZtu3u25mad3aP2RPQkjq5KD
 H4OD6ouzPimHOPtebvqjLfaUnyBlPHxaAg/fGmCfpb4NqT5AtlG5l+ELmpFQFV1UhfD4 WA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wytd4823w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:04:20 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42K74KHj011315;
	Wed, 20 Mar 2024 07:04:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wytd4823r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:04:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K6nVC4010073;
	Wed, 20 Mar 2024 07:04:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav1r9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:04:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42K74EJo16056678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 07:04:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4752004B;
	Wed, 20 Mar 2024 07:04:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F01F20043;
	Wed, 20 Mar 2024 07:04:14 +0000 (GMT)
Received: from DESKTOP-2CCOB1S. (unknown [9.171.191.120])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Mar 2024 07:04:14 +0000 (GMT)
Date: Wed, 20 Mar 2024 08:04:12 +0100
From: Tobias Huschle <huschle@linux.ibm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Luis Machado <luis.machado@arm.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
Message-ID: <ZfqKbLm4rWXmfPN4@DESKTOP-2CCOB1S.>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
 <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
 <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com>
 <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DZEUY855tEq6hMQlhysb54UCpvyPwX0F
X-Proofpoint-ORIG-GUID: sfUucA_rWYsBLqcUgVcZL8_D2w_719EB
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200055

On Tue, Mar 19, 2024 at 02:41:14PM +0100, Vincent Guittot wrote:
> On Tue, 19 Mar 2024 at 10:08, Tobias Huschle <huschle@linux.ibm.com> wrote:
> >
> > On 2024-03-18 15:45, Luis Machado wrote:
> > > On 3/14/24 13:45, Tobias Huschle wrote:
> > >> On Fri, Mar 08, 2024 at 03:11:38PM +0000, Luis Machado wrote:
> > >>> On 2/28/24 16:10, Tobias Huschle wrote:
> > >>>>
> > >>>> Questions:
> > >>>> 1. The kworker getting its negative lag occurs in the following
> > >>>> scenario
> > >>>>    - kworker and a cgroup are supposed to execute on the same CPU
> > >>>>    - one task within the cgroup is executing and wakes up the
> > >>>> kworker
> > >>>>    - kworker with 0 lag, gets picked immediately and finishes its
> > >>>>      execution within ~5000ns
> > >>>>    - on dequeue, kworker gets assigned a negative lag
> > >>>>    Is this expected behavior? With this short execution time, I
> > >>>> would
> > >>>>    expect the kworker to be fine.
> > >>>
> > >>> That strikes me as a bit odd as well. Have you been able to determine
> > >>> how a negative lag
> > >>> is assigned to the kworker after such a short runtime?
> > >>>
> > >>
> > >> I did some more trace reading though and found something.
> > >>
> > >> What I observed if everything runs regularly:
> > >> - vhost and kworker run alternating on the same CPU
> > >> - if the kworker is done, it leaves the runqueue
> > >> - vhost wakes up the kworker if it needs it
> > >> --> this means:
> > >>   - vhost starts alone on an otherwise empty runqueue
> > >>   - it seems like it never gets dequeued
> > >>     (unless another unrelated task joins or migration hits)
> > >>   - if vhost wakes up the kworker, the kworker gets selected
> > >>   - vhost runtime > kworker runtime
> > >>     --> kworker gets positive lag and gets selected immediately next
> > >> time
> > >>
> > >> What happens if it does go wrong:
> > >> From what I gather, there seem to be occasions where the vhost either
> > >> executes suprisingly quick, or the kworker surprinsingly slow. If
> > >> these
> > >> outliers reach critical values, it can happen, that
> > >>    vhost runtime < kworker runtime
> > >> which now causes the kworker to get the negative lag.
> > >>
> > >> In this case it seems like, that the vhost is very fast in waking up
> > >> the kworker. And coincidentally, the kworker takes, more time than
> > >> usual
> > >> to finish. We speak of 4-digit to low 5-digit nanoseconds.
> > >>
> > >> So, for these outliers, the scheduler extrapolates that the kworker
> > >> out-consumes the vhost and should be slowed down, although in the
> > >> majority
> > >> of other cases this does not happen.
> > >
> > > Thanks for providing the above details Tobias. It does seem like EEVDF
> > > is strict
> > > about the eligibility checks and making tasks wait when their lags are
> > > negative, even
> > > if just a little bit as in the case of the kworker.
> > >
> > > There was a patch to disable the eligibility checks
> > > (https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium.org/),
> > > which would make EEVDF more like EVDF, though the deadline comparison
> > > would
> > > probably still favor the vhost task instead of the kworker with the
> > > negative lag.
> > >
> > > I'm not sure if you tried it, but I thought I'd mention it.
> >
> > Haven't seen that one yet. Unfortunately, it does not help to ignore the
> > eligibility.
> >
> > I'm inclined to rather propose propose a documentation change, which
> > describes that tasks should not rely on woken up tasks being scheduled
> > immediately.
> 
> Where do you see such an assumption ? Even before eevdf, there were
> nothing that ensures such behavior. When using CFS (legacy or eevdf)
> tasks, you can't know if the newly wakeup task will run 1st or not
> 

There was no guarantee of course. place_entity was reducing the vruntime of 
woken up tasks though, giving it a slight boost, right?. For the scenario 
that I observed, that boost was enough to make sure, that the woken up tasks 
gets scheduled consistently. This might still not be true for all scenarios, 
but in general EEVDF seems to be stricter with woken up tasks.

Dismissing the lag on wakeup also does obviously not guarantee getting 
scheduled, as other tasks might still be involved.

The question would be if it should be explicitly mentioned somewhere that,
at this point, woken up tasks are not getting any special treatment and
noone should rely on that boost for woken up tasks.

> >
> > Changing things in the code to address for the specific scenario I'm
> > seeing seems to mostly create unwanted side effects and/or would require
> > the definition of some magic cut-off values.
> >
> >

