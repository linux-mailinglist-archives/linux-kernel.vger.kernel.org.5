Return-Path: <linux-kernel+bounces-81163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A435C867152
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59310284D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4556535BC;
	Mon, 26 Feb 2024 10:29:58 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A63535BB;
	Mon, 26 Feb 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943397; cv=none; b=Qp8PSyllYhVGwYAphGJG+1yTB0PMGAiCvhFhi2Rj4sbXvhYlmYq36PUZctPio7p3LHcKcDmMV4VqFEsZRbAY0WbQhe/xYn7M1HdQJo2QgxF1HRBmVYc3qkvmfD+2vZg3l5eLk2M1NZkpsSyRIbhvSv4l18Fim+d0hZco/P7KRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943397; c=relaxed/simple;
	bh=/G2UA+uUkp//XVcfRaG2YejlfgNtu6ZxQ2UfuCjPiyk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nmj8hlPln6JMedpMMDvCrGQ+VQRiBqwTYKPyeWGJH62D8h8M131R7a3eqo3xk2Znw5VOrJYa6smo1Sbbrd07pKvwy+kco0cZ70MTyxO3ortiomfNGC2TTVYImJnIMZrXxj1vy1Kz0Id1CNyB6nzqMgm+jgEK7+AK97XsbHmBOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TjxZd1L8dz6JB1P;
	Mon, 26 Feb 2024 18:25:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 882B51400DD;
	Mon, 26 Feb 2024 18:29:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 10:29:45 +0000
Date: Mon, 26 Feb 2024 10:29:44 +0000
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
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <20240226102944.000070a3@Huawei.com>
In-Reply-To: <65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
	<54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
	<65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:42:24 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Shiju Jose wrote:
> > Hi Dan,
> >=20
> > Thanks for the feedback.
> >=20
> > Please find reply inline.
> >  =20
> > >-----Original Message-----
> > >From: Dan Williams <dan.j.williams@intel.com>
> > >Sent: 22 February 2024 00:21
> > >To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; lin=
ux-
> > >acpi@vger.kernel.org; linux-mm@kvack.org; dan.j.williams@intel.com;
> > >dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > >dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel=
com;
> > >ira.weiny@intel.com
> > >Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
> > >Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
> > >tony.luck@intel.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
> > >rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
> > >james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
> > >erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
> > >mike.malvestuto@intel.com; gthelen@google.com;
> > >wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
> > >tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.=
com>;
> > >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
> > >Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> > >Subject: RE: [RFC PATCH v6 00/12] cxl: Add support for CXL feature com=
mands,
> > >CXL device patrol scrub control and DDR5 ECS control features
> > >
> > >shiju.jose@ wrote: =20
> > >> From: Shiju Jose <shiju.jose@huawei.com>
> > >>
> > >> 1. Add support for CXL feature mailbox commands.
> > >> 2. Add CXL device scrub driver supporting patrol scrub control and E=
CS
> > >> control features.
> > >> 3. Add scrub subsystem driver supports configuring memory scrubs in =
the =20
> > >system. =20
> > >> 4. Register CXL device patrol scrub and ECS with scrub subsystem.
> > >> 5. Add common library for RASF and RAS2 PCC interfaces.
> > >> 6. Add driver for ACPI RAS2 feature table (RAS2).
> > >> 7. Add memory RAS2 driver and register with scrub subsystem. =20
> > >
> > >I stepped away from this patch set to focus on the changes that landed=
 for v6.8
> > >and the follow-on regression fixups. Now that v6.8 CXL work has quiete=
d down
> > >and I circle back to this set for v6.9 I find the lack of story in thi=
s cover letter to
> > >be unsettling. As a reviewer I should not have to put together the sto=
ry on why
> > >Linux should care about this feature and independently build up the
> > >maintainence-burden vs benefit tradeoff analysis. =20
> > I will add more details to the cover letter.
> >   =20
> > >
> > >Maybe it is self evident to others, but for me there is little in thes=
e changelogs
> > >besides "mechanism exists, enable it". There are plenty of platform or=
 device
> > >mechanisms that get specified that Linux does not enable for one reaso=
n or
> > >another.
> > >
> > >The cover letter needs to answer why it matters, and what are the trad=
eoffs.
> > >Mind you, in my submissions I do not always get this right in the cove=
r letter [1],
> > >but hopefully at least one of the patches tells the story [2].
> > >
> > >In other words, imagine you are writing the pull request to Linus or s=
omeone
> > >else with limited time who needs to make a risk decision on a pull req=
uest with a
> > >diffstat of:
> > >
> > >    23 files changed, 3083 insertions(+)
> > >
> > >...where the easiest decision is to just decline. As is, these changel=
ogs are not
> > >close to tipping the scale to "accept".
> > >
> > >[sidebar: how did this manage to implement a new subsystem with 2 cons=
umers
> > >(CXL + ACPI), without modifying a single existing line? Zero deletions=
? That is
> > >either an indication that Linux perfectly anticipated this future use =
case
> > >(unlikely), or more work needs to be done to digest an integrate these=
 concepts
> > >into existing code paths]
> > >
> > >One of the first questions for me is why CXL and RAS2 as the first con=
sumers and
> > >not NVDIMM-ARS and/or RASF Patrol Scrub? Part of the maintenance burde=
n =20
> > We don't personally care about NVDIMMS but would welcome drivers from o=
thers. =20
>=20
> Upstream would also welcome consideration of maintenance burden
> reduction before piling on, at least include *some* consideration of the
> implications vs this response that comes off as "that's somebody else's
> problem".

We can do analysis of whether the interfaces are suitable etc but
have no access to test hardware or emulation. I guess I can hack something
together easily enough. Today ndctl has some support. Interestingly the mod=
el
is different from typical volatile scrubbing as it's all on demand - that
could be easily wrapped up in a software scrub scheduler though, but we'd n=
eed
input from you and other Intel people on how this is actually used.=20

The use model is a lot less obvious than autonomous scrubbers - I assume be=
cause
the persistence means you need to do this rarely if at all (though ARS does
support scrubbing volatile memory on nvdimms)

So initial conclusion is it would need a few more controls or it needs
some software handling of scan scheduling to map it to the interface type
that is common to CXL and RAS2 scrub controls.

Intent of the comment was to keep scope somewhat confined, and to=20
invite others to get involved, not to rule out doing some light weight
analysis of whether this feature would work for another potential user
which we weren't even aware of until you mentioned it (thanks!).

>=20
> > Regarding RASF patrol scrub no one cared about it as it's useless and
> > any new implementation should be RAS2. =20
>=20
> The assertion that "RASF patrol scrub no one cared about it as it's
> useless and any new implementation should be RAS2" needs evidence.
>=20
> For example, what platforms are going to ship with RAS2 support, what
> are the implications of Linux not having RAS2 scrub support in a month,
> or in year? There are parts of the ACPI spec that have never been
> implemented what is the evidence that RAS2 is not going to suffer the
> same fate as RASF?=20

=46rom discussions with various firmware folk we have a chicken and egg
situation on RAS2. They will stick to their custom solutions unless there is
plausible support in Linux for it - so right now it's a question mark
on roadmaps. Trying to get rid of that question mark is why Shiju and I
started looking at this in the first place. To get rid of that question
mark we don't necessarily need to have it upstream, but we do need
to be able to make the argument that there will be a solution ready
soon after they release the BIOS image.  (Some distros will take years
to catch up though).

If anyone else an speak up on this point please do. Discussions and
feedback communicated to Shiju and I off list aren't going to
convince people :(
Negatives perhaps easier to give than positives given this is seen as
a potential feature for future platforms so may be confidential.

> There are parts of the CXL specification that have
> never been implemented in mass market products.

Obviously can't talk about who was involved in this feature
in it's definition, but I have strong confidence it will get implemented
for reasons I can point at on a public list.=20
a) There will be scrubbing on devices.
b) It will need control (evidence for this is the BIOS controls mentioned b=
elow
   for equivalent main memory).
c) Hotplug means that control must be done by OS driver (or via very fiddly
   pre hotplug hacks that I think we can all agree should not be necessary
   and aren't even an option on all platforms)
d) No one likes custom solutions.
This isn't a fancy feature with a high level of complexity which helps.

Today there is the option for main memory of leaving it to BIOS parameters.
A quick google gave me some examples (to make sure they are public):
Dell: PowerEdge R640 BIOS and UEFI Reference Guide
  - Memory patrol scrub - Sets the memory patrol scrub frequency.
HP UEFI System Utilities for HPE ProLiant Gen 11 SErvers
  - Enabling or disable patrol scrub
Spec list of flags for lenovo systems (tells you that turning patrol scrub
   off is a good idea ;)
Huawei Kunpeng 920 RAS config menu.=20
  - Active Scrub, Active Scrub interval etc.

>=20
> > Previous discussions in the community about RASF and scrub could be fin=
d here.
> > https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com=
/#r
> > and some old ones,
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB00=
38718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/
> >  =20
>=20
> Do not make people hunt for old discussions, if there are useful points
> in that discussion that make the case for the patch set include those in
> the next submission, don't make people hunt for the latest state of the
> story.

Sure, more of an essay needed along with links given we are talking
about the views of others.

Quick summary from a reread of the linked threads.
AMD not implemented RASF/RAS2 yet - looking at it last year, but worried
about inflexibility of RAS2 spec today. They were looking at some spec
changes to improve this + other functions to be added to RAS2.
I agree with it being limited, but think extending with backwards
compatibility isn't a problem (and ACPI spec rules in theory guarantee
it won't break).  I'm keen on working with current version
so that we can ensure the ABI design for CXL encompasses it.

Intel folk were cc'd but not said anything on that thread, but Tony Luck
did comment in Jiaqi Yan's software scrubbing discussion linked below.
He observed that a hardware implementation can be complex if doing range
based scrubbing due to interleave etc. RAS2 and CXL both side step this
somewhat by making it someone elses problem. In RAS2 the firmware gets
to program multiple scrubbers to cover the range requested. In CXL
for now this leaves the problem for userspace, but we can definitely
consider a region interface if it makes sense.

I'd also like to see inputs from a wider range of systems folk + other
CPU companies.  How easy this is to implement is heavily dependent on
what entity in your system is responsible for this sort of runtime
service and that varies a lot.

>=20
> > https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.co=
m/ =20
>=20
> Yes, now that is a useful changelog, thank you for highlighting it,
> please follow its example.

It's not a changelog as such but a RFC in text only form.
However indeed lots of good info in there.

Jonathan




