Return-Path: <linux-kernel+bounces-88569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8086E394
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44F21F24FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84238DC3;
	Fri,  1 Mar 2024 14:42:02 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBE23DE;
	Fri,  1 Mar 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304121; cv=none; b=AF37UPLV1+Re4r8Gx5ffd4e4ioihwCXO5h4KeCJBqodtl5CzVO4HV7r2tMQI44gRSA7P+98hTdp4sBbvs69JEyfCUyROMGMjmnXZLSWLxrM9GVb/ldDuuK2hRecQxNfTWpKKh25rOpHfC5kihipK5VZANmvoVUPvKGMPPLv8bd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304121; c=relaxed/simple;
	bh=I06CBHd0H62wr/ulGLh0iMZkxB0t3HLpZQz58Xo2Io4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pm3BRYdUrfJbGtYtwcYomORMGEPgnUfMZ7QWfwsUCZM1Iepg0QX+cbG8zyHoQGBxptcfjBumbmygiEqxs4skJ31lYyAVXHq/WNcckRBb0QogrENJmUb1gRFpJu6YFBjdRDmLfUYk+fId0P4Bjc85N59uim+YAzNzon5ycB6dyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TmVzT3M5kz6J9St;
	Fri,  1 Mar 2024 22:37:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B54051409F9;
	Fri,  1 Mar 2024 22:41:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 1 Mar
 2024 14:41:53 +0000
Date: Fri, 1 Mar 2024 14:41:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, Vikram Sethi
	<vsethi@nvidia.com>
Subject: Re: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <20240301144153.0000133b@Huawei.com>
In-Reply-To: <65e0e046a165e_ca001294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
	<54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
	<65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240226102944.000070a3@Huawei.com>
	<65e0e046a165e_ca001294bc@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> 
> > > > Regarding RASF patrol scrub no one cared about it as it's useless and
> > > > any new implementation should be RAS2.    
> > > 
> > > The assertion that "RASF patrol scrub no one cared about it as it's
> > > useless and any new implementation should be RAS2" needs evidence.
> > > 
> > > For example, what platforms are going to ship with RAS2 support, what
> > > are the implications of Linux not having RAS2 scrub support in a month,
> > > or in year? There are parts of the ACPI spec that have never been
> > > implemented what is the evidence that RAS2 is not going to suffer the
> > > same fate as RASF?   
> > 
> > From discussions with various firmware folk we have a chicken and egg
> > situation on RAS2. They will stick to their custom solutions unless there is
> > plausible support in Linux for it - so right now it's a question mark
> > on roadmaps. Trying to get rid of that question mark is why Shiju and I
> > started looking at this in the first place. To get rid of that question
> > mark we don't necessarily need to have it upstream, but we do need
> > to be able to make the argument that there will be a solution ready
> > soon after they release the BIOS image.  (Some distros will take years
> > to catch up though).
> > 
> > If anyone else an speak up on this point please do. Discussions and
> > feedback communicated to Shiju and I off list aren't going to
> > convince people :(
> > Negatives perhaps easier to give than positives given this is seen as
> > a potential feature for future platforms so may be confidential.  
> 
> So one of the observations from efforts like RAS API [1] is that CXL is
> definining mechanisms that others are using for non-CXL use cases. I.e.
> a CXL-like mailbox that supports events is a generic transport that can
> be used for many RAS scenarios not just CXL endpoints. It supplants
> building new ACPI interfaces for these things because the expectation is
> that an OS just repurposes its CXL Type-3 infrastructure to also drive
> event collection for RAS API compliant devices in the topology.
> 
> [1]: https://www.opencompute.org/w/index.php?title=RAS_API_Workstream
> 
> So when considering whether Linux should build support for ACPI RASF,
> ACPI RAS2, and / or Open Compute RAS API it is worthwile to ask if one
> of those can supplant the others.

RAS API is certainly interesting but the bit of the discussion
that matters here will equally apply to CXL RAS controls as of today
(will ship before OCP) and Open Compute's RAS API (sometime in the future).

The subsystem presented here was to address the "show us your code" that
was inevitable feedback if we'd gone for a discussion Doc style RFC.

What really matters here is whether a common ABI is necessary and what
it looks like.
Not even the infrastructure, just whether it's sysfs and what the controls)
Sure there is less code if it all looks like that CXL get feature,
but not that much less.  + I'm hoping we'll also end up sharing with
the various embedded device solutions out there today.

I notice a few familiar names in the meeting recordings. Anyone want
to provide a summary of overlap etc and likely end result?
I scan read the docs and caught up with some meetings at high speed,
but that's not the same as day to day involvement in the spec development. 
Maybe the lesson to take away from this is a more general interface is
needed incorporating scrub control (which at this stage is probably
just a name change!)

I see that patrol scrub is on the RAS actions list which is great.

> 
> Speaking only for myself with my Linux kernel maintainer hat on, I am
> much more attracted to proposals like RAS API where native drivers can
> be deployed vs ACPI which brings ACPI static definition baggage and a
> 3rd component to manage. RAS API is kernel driver + device-firmware
> while I assume ACPI RAS* is kernel ACPI driver + BIOS firmware +
> device-firmware.

Not really. The only thing needed from BIOS firmware is a static table
 to OS to describe where to find the hardware (RAS2 is a header and (1+)
pointers to the PCCT table entry that tells you where the mailbox(s)
(PCC Channel) are and their interrupts etc.  It's all of 48 bytes of
static data to parse.

Could have been done that in DSDT (where you will find other PCC channels
as many methods can use them under the hood to chat to firmware + there
are some other users where they are the only option) but my guess is
assumption is RAS might be needed pre AML interpreter so it's a static table.

A PCC channel is the ACPI spec standard mailbox design (well several
options for how to do it, but given the code is upstream and in use
for other purposes, no new maintenance burden for us :)
PCC channels can be shared resources handling multiple protocols.
They are used for various other things where the OS needs
to talk to firmware and have been upstream for a while.


ACPI driver --------<PCC Mailbox>---> Device Firmware
vs
RAS API Driver-----<CXL Mailbox>----> Device Firmware
or
CXL Driver --------<CXL Mailbox>----> Device Firmware

The new complexity (much like the CXL solution) lies in the
control protocol sent over the mailbox (which is pretty simple!)

Some of the complexity in the driver is left over from earlier
version doing RASF and RAS2 so we'll flatten that layering out
and it'll be even simpler in next RFC and perhaps not hint at
false complexity or maintenance burden.

The only significant burden I really see form incorporating RAS2
is the need for an interface that works for both (very similar)
configuration control sets.  Once that is defined we need to support
the ABI for ever anyway so may be sysfs attribute of extra ABI to
support in current design?


> 
> In other words, this patch proposal enables both CXL memscrub and ACPI
> RAS2 memscrub. It asserts that nobody cares about ACPI RASF memscrub,
> and your clarification asserts that RAS2 is basically dead until Linux
> adopts it. So then the question becomes why should Linux breath air into
> the ACPI RAS2 memscrub proposal when initiatives like RAS API exist?

A fair question and one where I'm looking for inputs from others.

However I think you may be assuming a lot more than is actually
involved in the RAS2 approach - see below.

> 
> The RAS API example seems to indicate that one way to get scrub support
> for non-CXL memory controllers would be to reuse CXL memscrub
> infrastructure. In a world where there is kernel mechanism to understand
> CXL-like scrub mechanisms, why not nudge the industry in that direction
> instead of continuing to build new and different ACPI mechanisms?

There may be some shared elements of course (and it seems the RAS API
stuff has severak sets of proposals for interfacing approaches), but ultimately
a RAS API element still hangs off something that isn't a CXL device, so
still demands some common infrastructure (e.g. a class or similar) or
we are going to find the RAS tools buried under a bunch of different individual
drivers.
1) Maybe shared for system components (maybe not from some of the diagrams!)
   But likely 1 interface per socket. Probably PCI, but maybe platform devices
   (I'd not be surprised to see a PCC channel type added for this mailbox)
   /sys/bus/pci/devices/pcixxx/rasstuff/etc
2) CXL devices say /sys/bus/cxl/devices/mem0/rasstuff/etc.
3) Other system components such as random PCI drivers.

Like other cases of common infrastructure, I'd argue for a nice class with
the devices parentage linking back to the underlying EP driver.
/sys/class/ras/ras0 parent ->   /sys/bus/cxl/devices/mem0/
/sys/class/ras/ras1 parent ->   /sys/bus/pci/device/pcixxx/ RAS API device.
etc

Same as if we had a bunch of devices that happened to have an LED on them
and wanted common userspace controls so registered with /sys/class/led

So to me RAS API looks like another user of this proposal that indeed
shares a bunch of common code with the CXL driver stack (hopefully they'll
move to PCI MMPT from current definition based on CXL 2.0 mailbox so the
discoverability isn't CXL spec based. (I may not have latest version of course!)

> 
> > > There are parts of the CXL specification that have
> > > never been implemented in mass market products.  
> > 
> > Obviously can't talk about who was involved in this feature
> > in it's definition, but I have strong confidence it will get implemented
> > for reasons I can point at on a public list. 
> > a) There will be scrubbing on devices.
> > b) It will need control (evidence for this is the BIOS controls mentioned below
> >    for equivalent main memory).
> > c) Hotplug means that control must be done by OS driver (or via very fiddly
> >    pre hotplug hacks that I think we can all agree should not be necessary
> >    and aren't even an option on all platforms)
> > d) No one likes custom solutions.
> > This isn't a fancy feature with a high level of complexity which helps.  
> 
> That does help, it would help even more if the maintenance burden of CXL
> scrub precludes needing to carry the burden of other implementations.

I think we disagree on whether the burden is significant - sure
we can spin interfaces differently to make it easier for CXL and we can
just stick it on the individual endpoints for now.

Key here is ABI, I don't really care about whether we wrap it up in a subsystem
(mostly we do that to enforce compliance with the ABI design as easier than
 reviewing against a document!)

I want to see userspace ABI that is general enough to extend to other
devices and doesn't require a horrible hydra of a userspace program on top
of incompatible controls because everyone wanted to do it slightly
differently.  The exercise of including RAS2 (and earlier RASF which
we dropped) was about establishing commonality and I think that was very
useful.

I'm reluctant to say it will never be necessary to support RAS2 (because
I want to see solutions well before anyone will have built OCPs proposal
and RAS2 works on many of today's systems with a small amount of firmware
work, many have existing PCC channels to appropriate management controllers
and as I understand it non standard interfaces to control the scrubbing
engines).

So I think not considering an ABI that is designed to be general is just
storing up pain for us in the future.

I'm not sure the design we have here is the right one which is why it
was an RFC :)

> 
> [..]
> > >   
> > > > Previous discussions in the community about RASF and scrub could be find here.
> > > > https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r
> > > > and some old ones,
> > > > https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/
> > > >     
> > > 
> > > Do not make people hunt for old discussions, if there are useful points
> > > in that discussion that make the case for the patch set include those in
> > > the next submission, don't make people hunt for the latest state of the
> > > story.  
> > 
> > Sure, more of an essay needed along with links given we are talking
> > about the views of others.
> > 
> > Quick summary from a reread of the linked threads.
> > AMD not implemented RASF/RAS2 yet - looking at it last year, but worried
> > about inflexibility of RAS2 spec today. They were looking at some spec
> > changes to improve this + other functions to be added to RAS2.
> > I agree with it being limited, but think extending with backwards
> > compatibility isn't a problem (and ACPI spec rules in theory guarantee
> > it won't break).  I'm keen on working with current version
> > so that we can ensure the ABI design for CXL encompasses it.
> > 
> > Intel folk were cc'd but not said anything on that thread, but Tony Luck
> > did comment in Jiaqi Yan's software scrubbing discussion linked below.
> > He observed that a hardware implementation can be complex if doing range
> > based scrubbing due to interleave etc. RAS2 and CXL both side step this
> > somewhat by making it someone elses problem. In RAS2 the firmware gets
> > to program multiple scrubbers to cover the range requested. In CXL
> > for now this leaves the problem for userspace, but we can definitely
> > consider a region interface if it makes sense.
> > 
> > I'd also like to see inputs from a wider range of systems folk + other
> > CPU companies.  How easy this is to implement is heavily dependent on
> > what entity in your system is responsible for this sort of runtime
> > service and that varies a lot.  
> 
> This answers my main question of whether RAS2 is a done deal with
> shipping platforms making it awkward for Linux to *not* support RAS2, or
> if this is the start of an industry conversation that wants some Linux
> ecosystem feedback. It sounds more like the latter.

I'll let others speak up on this as I was presenting on my current outlook
and understand others are much further down the path.

> 
> > > > https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/    
> > > 
> > > Yes, now that is a useful changelog, thank you for highlighting it,
> > > please follow its example.  
> > 
> > It's not a changelog as such but a RFC in text only form.
> > However indeed lots of good info in there.
> > 
> > Jonathan  
> 
> Thanks again for taking the time Jonathan.
> 
You are welcome and thanks for all the questions / pointers.

Jonathan



