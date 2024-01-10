Return-Path: <linux-kernel+bounces-22342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D8829C65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB031C24A00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99804BAB8;
	Wed, 10 Jan 2024 14:18:28 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF2C4A9B8;
	Wed, 10 Jan 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T98wg0GTRz67g6l;
	Wed, 10 Jan 2024 22:16:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E63FD140736;
	Wed, 10 Jan 2024 22:18:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 14:18:22 +0000
Date: Wed, 10 Jan 2024 14:18:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hao Xiang <hao.xiang@bytedance.com>
CC: Gregory Price <gregory.price@memverge.com>, "Huang, Ying"
	<ying.huang@intel.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "aneesh.kumar@linux.ibm.com"
	<aneesh.kumar@linux.ibm.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, "Vinicius Tavares Petrucci"
	<vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, "Wei Xu" <weixugc@google.com>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>
Subject: Re: [External] Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration
 between memory tiers
Message-ID: <20240110141821.0000370d@Huawei.com>
In-Reply-To: <CAAYibXhe81ez06tP5K7zGkX9P=Ot+DcSysVyDvh13aSEDD63aA@mail.gmail.com>
References: <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZwrIoP9+ey7rp3C@memverge.com>
	<87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240109155049.00003f13@Huawei.com>
	<ZZ2Jd7/7rFD0o5S3@memverge.com>
	<CAAYibXhe81ez06tP5K7zGkX9P=Ot+DcSysVyDvh13aSEDD63aA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 16:28:15 -0800
Hao Xiang <hao.xiang@bytedance.com> wrote:

> On Tue, Jan 9, 2024 at 9:59=E2=80=AFAM Gregory Price <gregory.price@memve=
rge.com> wrote:
> >
> > On Tue, Jan 09, 2024 at 03:50:49PM +0000, Jonathan Cameron wrote: =20
> > > On Tue, 09 Jan 2024 11:41:11 +0800
> > > "Huang, Ying" <ying.huang@intel.com> wrote: =20
> > > > Gregory Price <gregory.price@memverge.com> writes: =20
> > > > > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote: =20
> > > > It's possible to change the performance of a NUMA node changed, if =
we
> > > > hot-remove a memory device, then hot-add another different memory
> > > > device.  It's hoped that the CDAT changes too. =20
> > >
> > > Not supported, but ACPI has _HMA methods to in theory allow changing
> > > HMAT values based on firmware notifications...  So we 'could' make
> > > it work for HMAT based description.
> > >
> > > Ultimately my current thinking is we'll end up emulating CXL type3
> > > devices (hiding topology complexity) and you can update CDAT but
> > > IIRC that is only meant to be for degraded situations - so if you
> > > want multiple performance regions, CDAT should describe them form the=
 start.
> > > =20
> >
> > That was my thought.  I don't think it's particularly *realistic* for
> > HMAT/CDAT values to change at runtime, but I can imagine a case where
> > it could be valuable.
> > =20
> > > > > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS_81=
R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
> > > > >
> > > > > This group wants to enable passing CXL memory through to KVM/QEMU
> > > > > (i.e. host CXL expander memory passed through to the guest), and
> > > > > allow the guest to apply memory tiering.
> > > > >
> > > > > There are multiple issues with this, presently:
> > > > >
> > > > > 1. The QEMU CXL virtual device is not and probably never will be
> > > > >    performant enough to be a commodity class virtualization. =20
> > >
> > > I'd flex that a bit - we will end up with a solution for virtualizati=
on but
> > > it isn't the emulation that is there today because it's not possible =
to
> > > emulate some of the topology in a peformant manner (interleaving with=
 sub
> > > page granularity / interleaving at all (to a lesser degree)). There a=
re
> > > ways to do better than we are today, but they start to look like
> > > software dissagregated memory setups (think lots of page faults in th=
e host).
> > > =20
> >
> > Agreed, the emulated device as-is can't be the virtualization device,
> > but it doesn't mean it can't be the basis for it.
> >
> > My thought is, if you want to pass host CXL *memory* through to the
> > guest, you don't actually care to pass CXL *control* through to the
> > guest.  That control lies pretty squarely with the host/hypervisor.
> >
> > So, at least in theory, you can just cut the type3 device out of the
> > QEMU configuration entirely and just pass it through as a distinct numa
> > node with specific hmat qualities.
> >
> > Barring that, if we must go through the type3 device, the question is
> > how difficult would it be to just make a stripped down type3 device
> > to provide the informational components, but hack off anything
> > topology/interleave related? Then you just do direct passthrough as you
> > described below.
> >
> > qemu/kvm would report errors if you tried to touch the naughty bits.
> >
> > The second question is... is that device "compliant" or does it need
> > super special handling from the kernel driver :D?  If what i described
> > is not "compliant", then it's probably a bad idea, and KVM/QEMU should
> > just hide the CXL device entirely from the guest (for this use case)
> > and just pass the memory through as a numa node.
> >
> > Which gets us back to: The memory-tiering component needs a way to
> > place nodes in different tiers based on HMAT/CDAT/User Whim. All three
> > of those seem like totally valid ways to go about it.
> > =20
> > > > >
> > > > > 2. When passing memory through as an explicit NUMA node, but not =
as
> > > > >    part of a CXL memory device, the nodes are lumped together in =
the
> > > > >    DRAM tier.
> > > > >
> > > > > None of this has to do with firmware.
> > > > >
> > > > > Memory-type is an awful way of denoting membership of a tier, but=
 we
> > > > > have HMAT information that can be passed through via QEMU:
> > > > >
> > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node0 \
> > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node1 \
> > > > > -numa node,nodeid=3D0,cpus=3D0-4,memdev=3Dram-node0 \
> > > > > -numa node,initiator=3D0,nodeid=3D1,memdev=3Dram-node1 \
> > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-ty=
pe=3Daccess-latency,latency=3D10 \
> > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-ty=
pe=3Daccess-bandwidth,bandwidth=3D10485760 \
> > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-ty=
pe=3Daccess-latency,latency=3D20 \
> > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-ty=
pe=3Daccess-bandwidth,bandwidth=3D5242880
> > > > >
> > > > > Not only would it be nice if we could change tier membership base=
d on
> > > > > this data, it's realistically the only way to allow guests to acc=
omplish
> > > > > memory tiering w/ KVM/QEMU and CXL memory passed through to the g=
uest. =20
> > >
> > > This I fully agree with.  There will be systems with a bunch of norma=
l DDR with different
> > > access characteristics irrespective of CXL. + likely HMAT solutions w=
ill be used
> > > before we get anything more complex in place for CXL.
> > > =20
> >
> > Had not even considered this, but that's completely accurate as well.
> >
> > And more discretely: What of devices that don't provide HMAT/CDAT? That
> > isn't necessarily a violation of any standard.  There probably could be
> > a release valve for us to still make those devices useful.
> >
> > The concern I have with not implementing a movement mechanism *at all*
> > is that a one-size-fits-all initial-placement heuristic feels gross
> > when we're, at least ideologically, moving toward "software defined mem=
ory".
> >
> > Personally I think the movement mechanism is a good idea that gets folks
> > where they're going sooner, and it doesn't hurt anything by existing. We
> > can change the initial placement mechanism too. =20
>=20
> I think providing users a way to "FIX" the memory tiering is a backup
> option. Given that DDRs with different access characteristics provide
> the relevant CDAT/HMAT information, the kernel should be able to
> correctly establish memory tiering on boot.

Include hotplug and I'll be happier!  I know that's messy though.

> Current memory tiering code has
> 1) memory_tier_init() to iterate through all boot onlined memory
> nodes. All nodes are assumed to be fast tier (adistance
> MEMTIER_ADISTANCE_DRAM is used).
> 2) dev_dax_kmem_probe to iterate through all devdax controlled memory
> nodes. This is the place the kernel reads the memory attributes from
> HMAT and recognizes the memory nodes into the correct tier (devdax
> controlled CXL, pmem, etc).
> If we want DDRs with different memory characteristics to be put into
> the correct tier (as in the guest VM memory tiering case), we probably
> need a third path to iterate the boot onlined memory nodes and also be
> able to read their memory attributes. I don't think we can do that in
> 1) because the ACPI subsystem is not yet initialized.

Can we move it later in general?  Or drag HMAT parsing earlier?
ACPI table availability is pretty early, it's just that we don't bother
with HMAT because nothing early uses it.
IIRC SRAT parsing occurs way before memory_tier_init() will be called.

Jonathan



>=20
> >
> > </2cents>
> >
> > ~Gregory =20


