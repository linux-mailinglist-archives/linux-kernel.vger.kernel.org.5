Return-Path: <linux-kernel+bounces-78282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D969A861155
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36F81C21962
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97D5C90C;
	Fri, 23 Feb 2024 12:16:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1278667;
	Fri, 23 Feb 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690589; cv=none; b=Xut6gzqu4HUpx325Q3EuPxo/KJvu1JCcXJVwjeDZEA0Ssxj179E9F/vbJtQzxeNqeAdTGoEngzZ33hMR8N2DyjM4YSBjaOXlWFG+ySUnLPrz+/cqLqzivQN3CKc7XjfQ8i6u2W80p2meN1IlntqtEkYgiVCz/Ue4hKWoJfG+8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690589; c=relaxed/simple;
	bh=6gw+sPtzbNCSI61MqAWcS5jAOt318VLZXdpqL8UVbj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R9yLxg5EmCKiUShFIGCTE6KrtP2yHWImzL2nladYX5RvoaSxLp9hKZrsjqBkdokZVE+80/jO4pBJGwBSKwiAHL58QKegbbKMhPs3KsLdoTGhY6BsYlC7AP65zGRhdRhDf+xthNG38UqIbQsby98L3BCyUTV0WqPy088mjj+FxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th8655Ks2z6K8Xc;
	Fri, 23 Feb 2024 20:12:45 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E516140D1A;
	Fri, 23 Feb 2024 20:16:24 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:16:24 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 23 Feb 2024 12:16:24 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
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
Subject: RE: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Thread-Topic: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Thread-Index: AQHaYAA5w4x9+ofZHUSoNACgT3S68LEVigKAgAJRu3A=
Date: Fri, 23 Feb 2024 12:16:23 +0000
Message-ID: <54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
 <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan,

Thanks for the feedback.

Please find reply inline.

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 22 February 2024 00:21
>To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
>acpi@vger.kernel.org; linux-mm@kvack.org; dan.j.williams@intel.com;
>dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com
>Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>tony.luck@intel.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
>james.morse@arm.com; jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>=
;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>Subject: RE: [RFC PATCH v6 00/12] cxl: Add support for CXL feature command=
s,
>CXL device patrol scrub control and DDR5 ECS control features
>
>shiju.jose@ wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> 1. Add support for CXL feature mailbox commands.
>> 2. Add CXL device scrub driver supporting patrol scrub control and ECS
>> control features.
>> 3. Add scrub subsystem driver supports configuring memory scrubs in the
>system.
>> 4. Register CXL device patrol scrub and ECS with scrub subsystem.
>> 5. Add common library for RASF and RAS2 PCC interfaces.
>> 6. Add driver for ACPI RAS2 feature table (RAS2).
>> 7. Add memory RAS2 driver and register with scrub subsystem.
>
>I stepped away from this patch set to focus on the changes that landed for=
 v6.8
>and the follow-on regression fixups. Now that v6.8 CXL work has quieted do=
wn
>and I circle back to this set for v6.9 I find the lack of story in this co=
ver letter to
>be unsettling. As a reviewer I should not have to put together the story o=
n why
>Linux should care about this feature and independently build up the
>maintainence-burden vs benefit tradeoff analysis.
I will add more details to the cover letter.
=20
>
>Maybe it is self evident to others, but for me there is little in these ch=
angelogs
>besides "mechanism exists, enable it". There are plenty of platform or dev=
ice
>mechanisms that get specified that Linux does not enable for one reason or
>another.
>
>The cover letter needs to answer why it matters, and what are the tradeoff=
s.
>Mind you, in my submissions I do not always get this right in the cover le=
tter [1],
>but hopefully at least one of the patches tells the story [2].
>
>In other words, imagine you are writing the pull request to Linus or someo=
ne
>else with limited time who needs to make a risk decision on a pull request=
 with a
>diffstat of:
>
>    23 files changed, 3083 insertions(+)
>
>...where the easiest decision is to just decline. As is, these changelogs =
are not
>close to tipping the scale to "accept".
>
>[sidebar: how did this manage to implement a new subsystem with 2 consumer=
s
>(CXL + ACPI), without modifying a single existing line? Zero deletions? Th=
at is
>either an indication that Linux perfectly anticipated this future use case
>(unlikely), or more work needs to be done to digest an integrate these con=
cepts
>into existing code paths]
>
>One of the first questions for me is why CXL and RAS2 as the first consume=
rs and
>not NVDIMM-ARS and/or RASF Patrol Scrub? Part of the maintenance burden
We don't personally care about NVDIMMS but would welcome drivers from other=
s.

Regarding RASF patrol scrub no one cared about it as it's useless and
any new implementation should be RAS2.
Previous discussions in the community about RASF and scrub could be find he=
re.
https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r
and some old ones,
https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB003871=
8F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/

https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/

>tradeoff is providing a migration path for legacy on the way to adding the=
 new
>thing. If old scrub implementations could be deprecated / deleted on the w=
ay to
>supporting new scrub use cases that becomes interesting.
>
>[1]: http://lore.kernel.org/r/20240208220909.GA975234@bhelgaas
>[2]: http://lore.kernel.org/r/20240208221305.GA975512@bhelgaas

Thanks,
Shiju

