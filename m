Return-Path: <linux-kernel+bounces-85787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E32E86BABC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915891C21D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED031361DF;
	Wed, 28 Feb 2024 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISiNV9ew"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2801361B6;
	Wed, 28 Feb 2024 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159223; cv=none; b=hkIR+KnKTeJ0e4lfKY9kgDCLAf07GWvAMbC9uASm1cMqbNTwvjSd4BomoJ0bJ84piapGJzj38F3WvtkmHaIFk3aCPl2saic88O9+/cTPumGwDpxh3Ke5mMsWizGqDlFpsIyAuqZocuh4tC8FnXa0bvqlQVYOOPlZgHV2xXfWq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159223; c=relaxed/simple;
	bh=1TO5f8A5S0u8pNDs4toUErk3IwQ5H/OMSdBtC0j2kxc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ0+jGHQ5Jodg6jmuYnF6yVfAG9tDRn9ZAS18YVdKsmI2GStwVezIO2mva3/rOiRZw3wzzIfQJHIkGMKOx28DxMVK2MKcUguDbuoQKGO35Z94rO8za1VQgdG+HRIHS5O/mQbwjN2z6QZhnmtMSRbl5C+quRVlwzwessUFXJ7WgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISiNV9ew; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e49332d014so107696a34.3;
        Wed, 28 Feb 2024 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709159220; x=1709764020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaJiMJlBXduLswabTLSZyMUV96qL4jeTVSd7UGYS8fk=;
        b=ISiNV9ew5NLAkcASXb4I8Aj58SVSeABd4MtXWu71w+c5fEHqgpZlCLTznkWdjY3nJ0
         kwsanBAkAYf6jnCEbPrKC5gNPIzSFOmdKYNCtoCplGGuWxnV8U26nAVXiOQgQ8mMtD5P
         TVOlz0gOY3SpyBRxgngN2VXjW+Kwy1E0z7hEy41MKQgW4BQ6Cn/ojDpD0KT+CbN6Ywbq
         SyMfzJyWo2dsrAYiJvN+Q3yFbEItRZCz7KEaSfmnaSQqARRlMpZKBaD0M7IFH+wp4O+P
         VsrZd/rx7F0rwB/AJogwwGdcNwDNQB44X7QtXb7wmHaS8tlKlNCRFrkAR6frg0N9CJmk
         m04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159220; x=1709764020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaJiMJlBXduLswabTLSZyMUV96qL4jeTVSd7UGYS8fk=;
        b=nxWMiTwj2Zbz8Af8c/+oxkp/VmKNHyLKncLiQZcDMCdrroOhf/igZy2ZSdum7jexW2
         xdnMaysJT+eKSjO1lQL2O01T1fpHgg3X0quhIowMrEqCaMYwSQTYavubxfZ99cSVqQB8
         yUAA1T1utBp0stm1JOtQUspzbiZUkUKifBNcJBA+fmSCbS3AkfETGHMUKvylEPT6VbAI
         PlTFQyPTufd0tAXRrWikbcC+sYj0kczw4eZXk6SxANzOCuCPdBgdVcej9nhPgDeOQcEU
         eGiowS0uDdT6gtzi+qKss/c+/RUbJBIVRiBjW2Kd8vST0AFygZtf2fbszK7nJqSj0sS/
         1VZg==
X-Forwarded-Encrypted: i=1; AJvYcCVgli7ubgQ+BxHS/LfnYtotjFUmMCJJH6ptjNLeg1CgJMvIJQXdPgmKQc4opN9dglRuojMrI0AmicgWb+2P3n5FE+6VkVRDMAoIAVHiAoOwYwY8PNh3eAzCfzC/vDvlT9RN4r7RMqrZbE6+r8ybq5akwgbqUeo6JpTLSU9Rz1Vse1FIBgo7GQ4qPlvPKNq54rfIL1tyn1tVW90suxhdh/g=
X-Gm-Message-State: AOJu0YzRedp8HPrJywgS99fokH5CJo+GqBMDh6ACfN4SFHF76UnO5XVp
	X1Kj5jEiQ0+fjPpTlb4TuIVZzTvFD8SmMY2DPjxrAjOsYqke6n0q
X-Google-Smtp-Source: AGHT+IEMG8s51d8mnXsggTW0jvuc65XoybjHZXS/KZXAk1iqexdiKPHx6zfzuc4kQZQavEzyv3OCIw==
X-Received: by 2002:a05:6870:1642:b0:21f:f6f6:cae with SMTP id c2-20020a056870164200b0021ff6f60caemr264638oae.32.1709159220293;
        Wed, 28 Feb 2024 14:27:00 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id gr15-20020a056870aa8f00b0021ff3548a19sm37620oab.37.2024.02.28.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:26:59 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
Date: Wed, 28 Feb 2024 16:26:56 -0600
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dave@stgolabs.net" <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, 
	"alison.schofield@intel.com" <alison.schofield@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>, 
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>, 
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com" <rientjes@google.com>, 
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "tony.luck@intel.com" <tony.luck@intel.com>, 
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, 
	"erdemaktas@google.com" <erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"duenwen@google.com" <duenwen@google.com>, "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>, 
	"gthelen@google.com" <gthelen@google.com>, "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>, 
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei <tanxiaofei@huawei.com>, 
	"Zengtao (B)" <prime.zeng@hisilicon.com>, "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, 
	wanghuiqiang <wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <7r4vrkmpma7u7zkzanuame7q4vl4ourygnyww4muzqjfvwvu3y@qkwmmoy6jflr>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
 <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
 <54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
 <65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On 24/02/23 11:42AM, Dan Williams wrote:
> Shiju Jose wrote:
> > Hi Dan,
> > 
> > Thanks for the feedback.
> > 
> > Please find reply inline.
> > 
> > >-----Original Message-----
> > >From: Dan Williams <dan.j.williams@intel.com>
> > >Sent: 22 February 2024 00:21
> > >To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
> > >acpi@vger.kernel.org; linux-mm@kvack.org; dan.j.williams@intel.com;
> > >dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > >dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com;
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
> > >tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > >kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
> > >Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> > >Subject: RE: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
> > >CXL device patrol scrub control and DDR5 ECS control features
> > >
> > >shiju.jose@ wrote:
> > >> From: Shiju Jose <shiju.jose@huawei.com>
> > >>
> > >> 1. Add support for CXL feature mailbox commands.
> > >> 2. Add CXL device scrub driver supporting patrol scrub control and ECS
> > >> control features.
> > >> 3. Add scrub subsystem driver supports configuring memory scrubs in the
> > >system.
> > >> 4. Register CXL device patrol scrub and ECS with scrub subsystem.
> > >> 5. Add common library for RASF and RAS2 PCC interfaces.
> > >> 6. Add driver for ACPI RAS2 feature table (RAS2).
> > >> 7. Add memory RAS2 driver and register with scrub subsystem.
> > >
> > >I stepped away from this patch set to focus on the changes that landed for v6.8
> > >and the follow-on regression fixups. Now that v6.8 CXL work has quieted down
> > >and I circle back to this set for v6.9 I find the lack of story in this cover letter to
> > >be unsettling. As a reviewer I should not have to put together the story on why
> > >Linux should care about this feature and independently build up the
> > >maintainence-burden vs benefit tradeoff analysis.
> > I will add more details to the cover letter.
> >  
> > >
> > >Maybe it is self evident to others, but for me there is little in these changelogs
> > >besides "mechanism exists, enable it". There are plenty of platform or device
> > >mechanisms that get specified that Linux does not enable for one reason or
> > >another.
> > >
> > >The cover letter needs to answer why it matters, and what are the tradeoffs.
> > >Mind you, in my submissions I do not always get this right in the cover letter [1],
> > >but hopefully at least one of the patches tells the story [2].
> > >
> > >In other words, imagine you are writing the pull request to Linus or someone
> > >else with limited time who needs to make a risk decision on a pull request with a
> > >diffstat of:
> > >
> > >    23 files changed, 3083 insertions(+)
> > >
> > >...where the easiest decision is to just decline. As is, these changelogs are not
> > >close to tipping the scale to "accept".
> > >
> > >[sidebar: how did this manage to implement a new subsystem with 2 consumers
> > >(CXL + ACPI), without modifying a single existing line? Zero deletions? That is
> > >either an indication that Linux perfectly anticipated this future use case
> > >(unlikely), or more work needs to be done to digest an integrate these concepts
> > >into existing code paths]
> > >
> > >One of the first questions for me is why CXL and RAS2 as the first consumers and
> > >not NVDIMM-ARS and/or RASF Patrol Scrub? Part of the maintenance burden
> > We don't personally care about NVDIMMS but would welcome drivers from others.
> 
> Upstream would also welcome consideration of maintenance burden
> reduction before piling on, at least include *some* consideration of the
> implications vs this response that comes off as "that's somebody else's
> problem".
> 
> > Regarding RASF patrol scrub no one cared about it as it's useless and
> > any new implementation should be RAS2.
> 
> The assertion that "RASF patrol scrub no one cared about it as it's
> useless and any new implementation should be RAS2" needs evidence.
> 
> For example, what platforms are going to ship with RAS2 support, what
> are the implications of Linux not having RAS2 scrub support in a month,
> or in year? There are parts of the ACPI spec that have never been
> implemented what is the evidence that RAS2 is not going to suffer the
> same fate as RASF? There are parts of the CXL specification that have
> never been implemented in mass market products.
> 
> > Previous discussions in the community about RASF and scrub could be find here.
> > https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r
> > and some old ones,
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/
> > 
> 
> Do not make people hunt for old discussions, if there are useful points
> in that discussion that make the case for the patch set include those in
> the next submission, don't make people hunt for the latest state of the
> story.
> 
> > https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/
> 
> Yes, now that is a useful changelog, thank you for highlighting it,
> please follow its example.

Just a comment that is not directed at the implementation details: at Micron we
see demand for the scrub control feature, so we do hope to see this support
go in sooner rather than later.

Regards,
John


