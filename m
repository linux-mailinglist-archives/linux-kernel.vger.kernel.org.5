Return-Path: <linux-kernel+bounces-146317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE048A6373
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21413283FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CEF3C08A;
	Tue, 16 Apr 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7fCl3aR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FA3BBEA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247732; cv=fail; b=JcuRe2DXj2VLKmLn9MZlob/vFAdXub53ryzUQ0nJdJ+idf51+GNnBODmquWLkYtpLhEb01ol6iNTFytSkYa4+NRx1z7a5iyfemjdTNKeEPdW4EvzSxNoqSk81sTFga8KOXW4Q4TDzpjgq8tLW0lGBVJ5jzvBYRwIgWDj2/J6hLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247732; c=relaxed/simple;
	bh=oR2nklHpfqP+1RFRLk1stTLPp9Mi7wfnwj/amIZVZuY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+VJfr3WkoWxKQ9K4x2H1bPVpdiVt+XFcSt/+Z6ldx6lkVvzscgJ8hQFIa3HxDqpRzm12e3MIVKN4+tP0GJieHdWqlgRM1nTJ7AmddXuwf/OfB8dK6N/pjJM0zJi7z50o7MgANHpPrV1xtclEgNZJkEHGzfPAV2lNNQvI1hiaWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7fCl3aR; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713247731; x=1744783731;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oR2nklHpfqP+1RFRLk1stTLPp9Mi7wfnwj/amIZVZuY=;
  b=B7fCl3aRa3jpimzYAfFSFDBPFrCZAGVrnVUh1xP92lS48Y5woPqj0mBO
   gsZF1XZDb8610SjldhrmlIbAX3FgohFTGb/eKUnTu/3Qq3nvP7dlXYZeG
   lyzdQoAGcMJhRMNMYge5jOVfWlkwgd06Fts0Hy004lerAxjHZreS5mMFc
   30SrMgy5FsZm2ZzSCy/0OmE5wvPM9ciFRSrtKNPSHJrzesJMscG9niqxS
   b1ac/hfVktI1q9NWKlSlrICixRjH+FZCBhPYuVhme5QeFVFf3+sBI4O3q
   YXJSeWRFpLK7ral+/QaE4PIQULwfpIl1ee50OE9hLIud2OjCXexYhN5JA
   g==;
X-CSE-ConnectionGUID: FWkNyihxQNO2R1m14QxjEw==
X-CSE-MsgGUID: Ncp8XWPNRk2I5f71FMJGeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="11613394"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="11613394"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:08:50 -0700
X-CSE-ConnectionGUID: v4THmzhPSlmLjS1nYBjfsg==
X-CSE-MsgGUID: itSQZ52ZSNK3vXA9L+zBww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22053792"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 23:08:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:08:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:08:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPFdw4jtaucYzPq6yswXphOBJ+JLVAhVReirYzAq+ge+ArH6tQCydqRcqRVHWrcmv1FZzd4EVdNxCaNzHVRtaTqIkNUQUrfegI7syN7UvZ6mNSIlIfQbgtMMszYRmr20Pun7Kgz9Zm4tPgIdAbhI+yEMI/JsgdIYir4SHXHafOx6L+bsfp21aRUo1e/4br3qgnHxZANcA2BTr/fZCCbJRUqhNMEvEOmxQHj8NIk2hQYigLLfXWYY852nsu238XocSzbdnYoz5GVpQe6txeeuLtRUY64JfOEOe7NovFg61WTcvBH+Fc8+BPymbMfLZyaFCqWJeUCjqPROzoKsURsUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJur6LmriFNK4l6e9bIawSB4AITIAdrXYD3HfjCbk4A=;
 b=cbN5ssS1nc/TAhw5LuZp76AACxV4iKMxgu5IHsBXfZRywyWUgTocJ2qOau0f8pVqAERceQW6xov1oYQ2KkD8iVo+4c6E1p+FvSYvaDMoYkb3N10TVhdozy+B1p4T2Uv3VQVETfRRjG9WgFkIMkmsUlXgFyj6Q1iG0WqAd6BoJ5BL6t4hu4d3FlBxWjMSIvvolvSnH8gKdOIC4dQ1KC2bkC0Sp7263ihf/FsfEXRSBwMji6WVbH6X8YCet331mEc25fXqF0K+tEBVrnt2QJ0y5Dh9YPoScKd1wa9AOzUloTucPhF5WapcDs6FWuSgs1za9FELMypVApOA+lmbPzP+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Tue, 16 Apr
 2024 06:08:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 06:08:43 +0000
Date: Mon, 15 Apr 2024 23:08:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
Message-ID: <661e15e690003_4d561294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
 <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
 <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
 <81d05bd9-ef8f-4a3a-a5df-384a82be49f5@linux.intel.com>
 <490a6a10-47d0-0689-432a-cbf22de11ad6@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <490a6a10-47d0-0689-432a-cbf22de11ad6@amd.com>
X-ClientProxiedBy: MW4PR04CA0367.namprd04.prod.outlook.com
 (2603:10b6:303:81::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: b51da159-6da8-41ee-4f69-08dc5ddbab5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpnMf5ih1VGdapaZvuaX9WY3Md6PuABuTwtgb7w+RpeOJ3wsBZqxmTFTaglSer9bplpCONfQxDONwqLYPruojCcKlf4idkBmUZhqHxaRZhB9lituSxytyJUrPLZY3/dLKa7OvouuNn/6nWNYMXr/fZ3l/fIFIFyGyuS8c8LIb2VAkIzge/5H6hcLJsJkh/csUpuccZJIV85ee1HbphR0S8ZfZ8tg4R0n37+0tUOIOMa9T9ljNiICXBmzM1f+lCs/SHcAfQAH4G+AskYrIPGja9VfndoPRtyEiZoapw0rrzLYumhrp2O9kKf/jBsRCIA+m/1540PJC3jj8s6BWaabIotm9wV7E2MbiGXusqbQzw7MPOuzoA8vejj8Mx//F48ZhK1TJ8N6odKhamT5JUrqN8k4pfHTS/SQ3r71MlmUjfChuOywaGtA6wZtN1b+j6sU8+/B03MT+xADnGLP67jIb4zzPLQSaukJ0xzFv5hTqa3ww0fqmywK0vZxvPc6d1lxDPWp+ZnlMLeanFJ80VVo1UEmSe+DKw6lKYT3ZJzPWkp+2lIsqRLTa9/ptL/too9W6XoQ381ike1IHIPXKAp61lQczD1qhV63BKJ/JTnyCvlEz5HaN3gdCbGd5JMjOzeBgF7hf8SUC43h/1yrffQwUvB388+5dEM/Hc4+LeV4Q0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Of57iW3QL8jmPsDZWhdbzYG7Gim+tOK1AKIE/NLiEOMdrny93Xe2pYVtJb?=
 =?iso-8859-1?Q?C7CvmsMwMpB41OJyxTXvrg9m+zUg5v5LHGgiXoKn4O8VzdyAg12qXExnlb?=
 =?iso-8859-1?Q?n16dPJAOtItGueSRWBpGZfII3BuCaGs8CYB6NsvD1qFnPN6MY+oymtN8M4?=
 =?iso-8859-1?Q?IvEOhZvChyZaG5xKK6QjCRJWEvWfPY02zGp01HMm2aa1uEmHCGIqEuy3RD?=
 =?iso-8859-1?Q?CVvACuIBh7T76B/vj3MALIliEnadlqyS3wqpmopu4kgXb+O0J0KKqAkQzB?=
 =?iso-8859-1?Q?9+t0givn86VHUuQX61iesyOjrbD2LR1BU8tcVU6cNQQaoIgWZTWGEVKMiD?=
 =?iso-8859-1?Q?2H9UWVvmf86E8Q69/nYTdspFGtYVjRUQ2TzRIA6BiCYG7eM1QiST9duK5R?=
 =?iso-8859-1?Q?E/MEjYNjqFaCOlwj4VdqLnPHNyyd+eCPj8vId3JUVs2RDd3WKwErGmWcYv?=
 =?iso-8859-1?Q?e+Xy8xhayo2waaig+CvVyESuUa1zkejeSilMmVs4OKCuWFa/VAMSIJVJBx?=
 =?iso-8859-1?Q?vYotc1qz28Wt1ZTiOQ82XPQuPudK3wavJmvUvnRnXWKm2JX/MIj5FwmkpS?=
 =?iso-8859-1?Q?234qVbbHoKbTAAlZ/ewfTG38o/mxsNkTiJWpCEAYaSWvG7B/9DMrQD72J+?=
 =?iso-8859-1?Q?dl31p4i6BLBEFUO6HAGr+32JZA1sbwDPgpumpocs7AuswHY30yMjzGZ6Xt?=
 =?iso-8859-1?Q?MebAyDW93tduZadKRAanr84G/sisY9/OBDJe1Eq1vmhNQnSq2A+NNbL3KP?=
 =?iso-8859-1?Q?SGggkLwEURRKh9HrmgCKKd3ztSSwRy7v99fZPe9c2N01S4sIevwLqjqLL1?=
 =?iso-8859-1?Q?FY9QfvZjNzW5SCXbjbmCRJ+8qiiE8fxnAoJB3DqXv05jKSXyQE8Zl1d/0R?=
 =?iso-8859-1?Q?60LqNhSB5C6/+/NdRvvHukDuBpiB7PJDgdrk+YxS93I/sunYQMjukx7BBp?=
 =?iso-8859-1?Q?7QjsB915UMChxqTwJkN95pxvgDkxSrM7hZP1kP/YIdFXkCM4O+1brScbNT?=
 =?iso-8859-1?Q?5JYMwxWS6MYnHX7MXWDcQSICsGIjpw+y3umSjwSQy5nx3oWPjiNRUOgFUS?=
 =?iso-8859-1?Q?/BTgmNX3Burp0PcXyjsTP9aHoVTJ6K93zbAAG+Gg31cR8zICdro0WETvGE?=
 =?iso-8859-1?Q?a3lRDlUdtaP0647i2LtUEm6mAXT3MrRVsrP0Dx5pO1omD4FhHFi69S19Pw?=
 =?iso-8859-1?Q?rMnji3qpM6AraePNkVxOFiRjYXvLG1ozP1LOikiummPVSUrBEv+wmLfP86?=
 =?iso-8859-1?Q?DllbNdkv8GdTTgYE2WAeWYNxSHSljvUo0HVyBiQgtNEU1o9Hh7sVwOL7bq?=
 =?iso-8859-1?Q?5OIPJILKKNcmYhUP0aK4EkR7glftuLU6dxw0YvkdJsTWgtzrcd5i6eRHpF?=
 =?iso-8859-1?Q?zLBkzUjzvvwGzhfolR/eu691l/1kHLbdZEekdBKKWTRdRhWcCCdS8FtmHC?=
 =?iso-8859-1?Q?b0W13Hp0nrBeBOyBhjsoZ4HPfXGhk7fmMtLdZidsfBoIHFhRPwLe935YtU?=
 =?iso-8859-1?Q?WVEvpUJOfxCzfwRfKObMyRpJlwNAItrg+qiPDjiL9cp4ftE1yX8Uj1CkAK?=
 =?iso-8859-1?Q?Z3Bc2U/7ygQo+LvWGsm+ZQ6C6D3TQ2MqIYQWkFcl6drF1MDIGaasLpQVY3?=
 =?iso-8859-1?Q?0WC13/yLXscHgA1jEHNAQsgU0VMBHxKpBx5sgWGcVHjf763K6fRjh9Pg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b51da159-6da8-41ee-4f69-08dc5ddbab5e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:08:43.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dt6sMwxIO5UIEL2PEwymdXN6iRBkP9kN6hfEnVmiMineoW2CCZin0/dsKvbvjfjUtKQtrY4VynLdQs7lq+nSReNWPsbERj/l5nAtxz9q/Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 4/15/24 14:48, Kuppuswamy Sathyanarayanan wrote:
> > Hi,
> > 
> > On 4/15/24 12:16 PM, Tom Lendacky wrote:
> >> On 4/12/24 10:52, Tom Lendacky wrote:
> >>> On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
> >>>> On 3/25/24 3:26 PM, Tom Lendacky wrote:
> >>>>> Config-fs provides support to hide individual attribute entries. Using
> >>>>> this support, base the display of the SVSM related entries on the presence
> >>>>> of an SVSM.
> >>>>>
> >>>>> Cc: Joel Becker <jlbec@evilplan.org>
> >>>>> Cc: Christoph Hellwig <hch@lst.de>
> >>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>>>> ---
> >>>>>    arch/x86/coco/core.c        |  4 ++++
> >>>>>    drivers/virt/coco/tsm.c     | 14 ++++++++++----
> >>>>>    include/linux/cc_platform.h |  8 ++++++++
> >>>>>    3 files changed, 22 insertions(+), 4 deletions(-)
> >>>>>
> >>
> >>>>
> >>>> Any comment about the following query? I think introducing a CC flag for this use
> >>>> case is over kill.
> >>>>
> >>>> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/
> >>>
> >>> If you don't think TDX will be able to make use of the SVSM attribute I can look at adding a callback. But I was waiting to see if anyone else had comments, for or against, before re-doing it all.
> >>>
> >>
> >> What about something like this (applied on top of patch 13):
> >>
> 
> >> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> >> index 27cc97fe8dcd..5aaf626d178d 100644
> >> --- a/include/linux/tsm.h
> >> +++ b/include/linux/tsm.h
> >> @@ -74,7 +74,20 @@ extern const struct config_item_type tsm_report_default_type;
> >>   /* publish @privlevel, @privlevel_floor, and @auxblob attributes */
> >>   extern const struct config_item_type tsm_report_extra_type;
> >>   
> >> +/*
> >> + * Used to indicate the attribute group type to the visibility callback to
> >> + * avoid the callback having to examine the attribute name.
> > 
> > Checking the attribute name will give more flexibility, right? Since it is one time
> > check, it should not be costly, right?
> 
> I thought about checking the name(s), but what if in the future another 
> attribute is added, then you have to remember to update multiple places. 
> This way you have an enum that represents the related attributes. Is 
> there a scenario where you would want to not hide all attributes that 
> are related? String comparisons just seem awkward to me.

An enum that matches an attribute index matches what sysfs offers. I.e.
sysfs is_visible callbacks either do pointer comparisons, or attribute
index number, but not names. So I agree with you about not using an
attribute name as the key.

Using the index however does mean that providers need to assume that all
attributes are in one array (and one bin_attribute array), but I think
that's ok.

