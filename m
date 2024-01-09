Return-Path: <linux-kernel+bounces-21080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C2828971
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2592BB23D33
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03039FF9;
	Tue,  9 Jan 2024 15:51:02 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010439AD6;
	Tue,  9 Jan 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8b1t50QWz6D8y4;
	Tue,  9 Jan 2024 23:48:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EEAEB1400D4;
	Tue,  9 Jan 2024 23:50:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 15:50:51 +0000
Date: Tue, 9 Jan 2024 15:50:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Gregory Price <gregory.price@memverge.com>, Srinivasulu Thanneeru
	<sthanneeru@micron.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "aneesh.kumar@linux.ibm.com"
	<aneesh.kumar@linux.ibm.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, "Vinicius Tavares Petrucci"
	<vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, "Wei Xu" <weixugc@google.com>, Hao Xiang
	<hao.xiang@bytedance.com>, "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory
 tiers
Message-ID: <20240109155049.00003f13@Huawei.com>
In-Reply-To: <87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZwrIoP9+ey7rp3C@memverge.com>
	<87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 09 Jan 2024 11:41:11 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:  
> >> >
> >> > From  https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
> >> > abstract_distance_offset: override by users to deal with firmware issue.
> >> >
> >> > say firmware can configure the cxl node into wrong tiers, similar to
> >> > that it may also configure all cxl nodes into single memtype, hence
> >> > all these nodes can fall into a single wrong tier.
> >> > In this case, per node adistance_offset would be good to have ?  
> >> 
> >> I think that it's better to fix the error firmware if possible.  And
> >> these are only theoretical, not practical issues.  Do you have some
> >> practical issues?
> >> 
> >> I understand that users may want to move nodes between memory tiers for
> >> different policy choices.  For that, memory_type based adistance_offset
> >> should be good.
> >>   
> >
> > There's actually an affirmative case to change memory tiering to allow
> > either movement of nodes between tiers, or at least base placement on
> > HMAT information. Preferably, membership would be changable to allow
> > hotplug/DCD to be managed (there's no guarantee that the memory passed
> > through will always be what HMAT says on initial boot).  
> 
> IIUC, from Jonathan Cameron as below, the performance of memory
> shouldn't change even for DCD devices.
> 
> https://lore.kernel.org/linux-mm/20231103141636.000007e4@Huawei.com/
> 
> It's possible to change the performance of a NUMA node changed, if we
> hot-remove a memory device, then hot-add another different memory
> device.  It's hoped that the CDAT changes too.

Not supported, but ACPI has _HMA methods to in theory allow changing
HMAT values based on firmware notifications...  So we 'could' make
it work for HMAT based description.

Ultimately my current thinking is we'll end up emulating CXL type3
devices (hiding topology complexity) and you can update CDAT but
IIRC that is only meant to be for degraded situations - so if you
want multiple performance regions, CDAT should describe them form the start.

> 
> So, all in all, HMAT + CDAT can help us to put the memory device in
> appropriate memory tiers.  Now, we have HMAT support in upstream.  We
> will working on CDAT support.
> 
> --
> Best Regards,
> Huang, Ying
> 
> > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
> >
> > This group wants to enable passing CXL memory through to KVM/QEMU
> > (i.e. host CXL expander memory passed through to the guest), and
> > allow the guest to apply memory tiering.
> >
> > There are multiple issues with this, presently:
> >
> > 1. The QEMU CXL virtual device is not and probably never will be
> >    performant enough to be a commodity class virtualization.

I'd flex that a bit - we will end up with a solution for virtualization but
it isn't the emulation that is there today because it's not possible to
emulate some of the topology in a peformant manner (interleaving with sub
page granularity / interleaving at all (to a lesser degree)). There are
ways to do better than we are today, but they start to look like
software dissagregated memory setups (think lots of page faults in the host).

> >  The
> >    reason is that the virtual CXL device is built off the I/O
> >    virtualization stack, which treats memory accesses as I/O accesses.

That will remain true for complex emulation, but it needn't always be
the case. 
I'm not 100% sure we can make it work but my current thinking is:

When decoders are set up: Check if there is any interleaving going on.
  interleaving happening: Current functionally correct path.
  no interleaving: More conventional memory access path.

> >
> >    KVM also seems incompatible with the design of the CXL memory device
> >    in general, but this problem may or may not be a blocker.

That's true if we are doing fine grained routing but as above we can
probably avoid that.

> >
> >    As a result, access to virtual CXL memory device leads to QEMU
> >    crawling to a halt - and this is unlikely to change.

In general yes, but hopefully not for carefully configured cases (the
simple one of direct connect single device, no host interleaving for example).

> >
> >    There is presently no good way forward to create a performant virtual
> >    CXL device in QEMU.  This means the memory tiering component in the
> >    kernel is functionally useless for virtual CXL memory, because...

Agreed - nothing there yet and I don't think the question of CXL virtualization
in general is anywhere near solved...  Maybe emulating a CXL device doesn't
make sense, maybe we end up extending virtio-mem instead.
Needs some PoC work to flesh this out. (it's about number 3 on my list of
stuff to look at this year)

> >
> > 2. When passing memory through as an explicit NUMA node, but not as
> >    part of a CXL memory device, the nodes are lumped together in the
> >    DRAM tier.
> >
> > None of this has to do with firmware.
> >
> > Memory-type is an awful way of denoting membership of a tier, but we
> > have HMAT information that can be passed through via QEMU:
> >
> > -object memory-backend-ram,size=4G,id=ram-node0 \
> > -object memory-backend-ram,size=4G,id=ram-node1 \
> > -numa node,nodeid=0,cpus=0-4,memdev=ram-node0 \
> > -numa node,initiator=0,nodeid=1,memdev=ram-node1 \
> > -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
> > -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=10485760 \
> > -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=20 \
> > -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=5242880
> >
> > Not only would it be nice if we could change tier membership based on
> > this data, it's realistically the only way to allow guests to accomplish
> > memory tiering w/ KVM/QEMU and CXL memory passed through to the guest.

This I fully agree with.  There will be systems with a bunch of normal DDR with different
access characteristics irrespective of CXL. + likely HMAT solutions will be used
before we get anything more complex in place for CXL.

Jonathan

p.s. I'd love to see _HMA handling implemented in the kernel.. Would trail blaze what
we will probably need to do for fiddly CXL cases where performance degrades on old devices
etc.

> >
> > ~Gregory  
> 


