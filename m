Return-Path: <linux-kernel+bounces-146232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02F8A627B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775B01F21A45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223852E622;
	Tue, 16 Apr 2024 04:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/jAyfFi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FC39863;
	Tue, 16 Apr 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242364; cv=fail; b=mEJItmtc9XB1+mQCyEYKvngkaFpYekwHfS4tMOdhO7CZK/uYSlgJ67TQkQDGL5P2p1+rqH5V2jgCmxJQgIu4HTJq6kyi+kEKc25iBc2XdLcQjtxnxzSIM1vnwk5j0YGCbsXFSd5a+u3jsZ1iIr+ePIoFhgo9/j2Khw9jVpUPL3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242364; c=relaxed/simple;
	bh=FC5hvb+HaAiBZV/JUGPFW0iF5iauPI4SbQ6lkSiB+zg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bf4XPdXT2jsaKayIyyvRUar6+yiqhZEGik/56uzQCK/NIkoxcY/E4tOwVNVzK4dCc9WeCzjzuk2ZN3CJHbAaNpakFj+6JGyeO04jCUGJx5Yo+4OlWWxluS3Ih0KE6vNP0kC0XtdveT9dDDuJERBU5aiuQYbePVH7yNA6CQZzodc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/jAyfFi; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713242362; x=1744778362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FC5hvb+HaAiBZV/JUGPFW0iF5iauPI4SbQ6lkSiB+zg=;
  b=Z/jAyfFihxsLIntd++XZkLfi5Jd36XM4XBa23fXUlQ+kRRhPPA9B1a8R
   KV1FB4I61mOoruCHO6rOx7bZp7AfTfmWnYUWHQqSzRiwYnAXblzw7reO/
   au4N14hxU3hHiLN3QAk+a/vTGOmO4NmnIVem/HZ8jShCbUsVR1QIvYWid
   uH/ElmkxJh++GfPeDNaDIjOaPPPM6MXTdtCWtikvTI+0ufi1FGVlX9fZ7
   adRYIE3y2L+hrYe9Zo/I1nsdqe2PtRkIpMPTfAmnMG55yaBCereNID10j
   2DMszb2Cd4Q/vOc3ikV4OdWwyo0lhDNx1ehuSK5t5DnUbWnUZ6TWBk+4i
   w==;
X-CSE-ConnectionGUID: jU+cIr9PQIe0pU9rP0Vi/A==
X-CSE-MsgGUID: wGrRWpD/QDiRVemxswtK8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8786655"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8786655"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 21:39:21 -0700
X-CSE-ConnectionGUID: 6vBHPO/5RV6sPmPJUFGGlQ==
X-CSE-MsgGUID: tbk/AvswSom7jT56THj8zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22600880"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 21:39:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 21:39:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 21:39:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa3EOIKdIk7tG06XOD7PtndE54Q44Q+J7MBPUrk3lD+yxgPLpUh/QMYCZBVA2OAMqLgF5p8uJIUFhMctUTO4MScbiQmGT166iKJxk7PcffqL9NMMXn5gBvFVaqaunZmSQlwsYlec46Zr9PLgqsa72lwQsS9cQCrk+D+qc+iKyhML63AdGT5VYe9YWTPL4fTqBsum5UJ581yJ+VwEfO6nSRpMwnsCewKDN30MFUHrfdcWTWnwROi1d6L7E6fyCiTmi07QDM5LnIXKY9mD5ZmYS/8l93gubux0KWuSoe9tw7xexmZSYalHQzKQYdetTYKXF/AyqrzyOJf1FdpvlVu1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/57S9Yl+ner5fT2gfl+3lVzhoHraxDNGoPGwRr/sx8w=;
 b=lq7v/UpkvbqMOZpG17tH2a9JE72aAe7eP6OhnCqNZOyzqMiwhUD18faNaD+HUXuuSvubnvDlNUWtR5D9jsBGZY2YtjHPllZrehpRt8YA4XyE3ee6y5uAMxTKaXRxIU23pH2GTWks0xo6mvhZztAasxXwFpA5CfY9io7xYoNkQEJ7SE7htN5RfYCf/UZEo3O8aHmUtz45GU0sx7IzDDgYYj//uaec0jnprDDolATWHIKmrPs85xvoOAjQIZ5rLshn4EWxm4F7tFekPSVRl68Klr46a85kMe9uNQ97TGrsOdexAh4mky3hKiCpLltS/sduqW6RK+YlFFYALlXa/dGYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8460.namprd11.prod.outlook.com (2603:10b6:408:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Tue, 16 Apr
 2024 04:39:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 04:39:09 +0000
Date: Mon, 15 Apr 2024 21:39:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <Terry.Bowman@amd.com>, Li Ming <ming4.li@intel.com>,
	<dan.j.williams@intel.com>, <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] PCI/RCEC: Introduce pcie_walk_rcec_all()
Message-ID: <661e00eb808e4_4d56129429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-2-ming4.li@intel.com>
 <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
X-ClientProxiedBy: MW3PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:303:2a::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 4775f0c3-0115-47ea-0411-08dc5dcf2846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiXfA/cCj/3zoxS2K5pEU4KvPID0fmLKLrjgK3TDz3faYaGe6iUdKKUATwZ0muDZKFoWrIW+PmakVq6dhcCKm3vF41rntyXthqnXqTmhiNQilGfiCX8V9Kb5pV+E3qCN3LIJTWPl60DYVUJU4D+LCU8wr6Nh/KMpUZYtDI1N4KUE0MMhj1hMLfuNRPmm6KZ6jox01l+C1mShP6/VzIcAGQfmoHqIEbNlv6yv4/6Zrzx4o5fJ7CYuyw33U9jM8c8jhBAuQQgQE8Swl9AENW0RHTAxr2M3Lir9VGWF6GOS2kbfa2zCb+oDTv7T3UNl+oHKXLzMpgIz/P2rcAn2emJFEaulWnbTWokCocx42g+WERfSSHdreI31w79+RSq4frjUWXjgFzY6jtSScFOiTWQCmiKJemfftTCxZIdnLiPlD6z+Pn6WfA5RbYwjk67Qw52k1jUlTHTsWUhNObAp4d3IpMMakHo3FM8zUF2IYCyLg/GyLgRYsz3pk3o86yZw8OCdkwCOAEyLIWhjuJGuTTdCwBskLzgNAIF5I6IGORQinZod0YvZdjstQ87C9USfiFxBPxkq3ougXI+zeQdjkJ7OzC7UGGNy4CE7ku36UX+uPaKUkM76xp07CD9soHimAci6hwlPIH6Xv6WzItRrhBkwo918l+E/DMkMAxSQQmnRRg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdIEfURpLEakVtey+vTTtjRb6fGoPUUIviIe+1WVESFht3C7MNk/xcXAheGt?=
 =?us-ascii?Q?3lansrzUkTheqIpG7cU1q/3fDoebYupNVKS6srlo7J6cs2AX3dRCH7dBAyFb?=
 =?us-ascii?Q?Er+F9qogxtqJ8NbHtvI0u2HXLiy6n1XD5hBI3nQjTIAxKKxC/0y8X4etWjdP?=
 =?us-ascii?Q?1Xq1yWrvoiKsp3/FMi4czK7p7Apn++Zy+wVbeHP0GYcKujIl9288p4iSv/tj?=
 =?us-ascii?Q?5+2GExv/knEjip6MunjSU1pB35Y03sYNe62lYpyX3VU4p3rCAY2mSwRISNsf?=
 =?us-ascii?Q?k8imiwqd7phpyfUIOS/YwKOuMASVQL9T6rpmQYrYetbRbvCT4OcBE5ZMxvkI?=
 =?us-ascii?Q?11eQ0LUfFgcN8SWkM92yPpF07Me7MJ2Gp3g3ypn+cbsNRp4GbIB+ERNEBH94?=
 =?us-ascii?Q?lwaWn6zEyhtVe4vbdyRJyhEBkv1oAdRUD+BRX6XiJWFN8cOynY0jQQ2m7cY3?=
 =?us-ascii?Q?LGgtQ+8OssMylCqSDvXX8s6XE4gT8JyleTPt1UnIGMJ1GGC+xqcFj5DgUi9+?=
 =?us-ascii?Q?nsA87nf9yNzLB5uDf5FOW63kykWOwRVpPkcgV+s+ih/H0vI9eIAdCM7mc/AB?=
 =?us-ascii?Q?CyI47fRd/FNB+DnWeNpNsx/mwaHSzugpzHS3Ow1pnyvC34egVP3byUz0s0F0?=
 =?us-ascii?Q?0KLLbxP8euL+ukwnFSJxhfeluIgIJjKQiWINqwpBUwtDm66AgCKjVUK7PMFv?=
 =?us-ascii?Q?1Z9h4Z6jgzFKxIC/2PE2WLUSRk28bxjnhwIU2Q0R1Z80qbwAi19I8Gn6PXiA?=
 =?us-ascii?Q?0AentnHgLX0PWWf10A+nz307njFsxJBSG37qPK9YEuXdX2WK42908wwbRfF3?=
 =?us-ascii?Q?Om6eeCnUgVYsKV9jEnYjNIlh58jC5WXSSPbsbb4EJNIOXRwwnRLODvl4fEU6?=
 =?us-ascii?Q?4GBw8g49RmRwaa8s8BYJHNpoEjy8DDP0mbZ+q905mbMht+OshPT6yzaQP9B7?=
 =?us-ascii?Q?H2XHrP/IiQ0fapmvoj84jemxy/O3E2v87yv5Gl0wR695kF+JxGWmyEmBouwe?=
 =?us-ascii?Q?nesOJ9n8OYUPhl8OnmJOg92qaQ6NNYy/ynPF281YSGDXAoS6yZ2OO27aqsRl?=
 =?us-ascii?Q?y0zmEMGUiIfpI7GUvBAQFAVLtU61kGKkGQrOjgPqYevD60P18L1i4sw+GrUF?=
 =?us-ascii?Q?INX0M7rYtO6Zp6LTh9Nl0X7UDceckPLiJbGcHPlUSh9DeJ4E7ElW7oS3rGAa?=
 =?us-ascii?Q?mosNNVeedUIovOyHntR2NjzMZPVWLLcX7q99I7w6wpCGl+l+Ds9JlMas98vt?=
 =?us-ascii?Q?E2n5kAfzgPQuHoOrq+7fYImuO7SgXi4y9hXLsCl9he73dWAfHXpph+OMWjjs?=
 =?us-ascii?Q?4HA/N6dG4HsG0EcqcaN5kVd5PhAl/JrivjSqlfi0uuzE37RUrykS6t1Mba6d?=
 =?us-ascii?Q?chBhB8GyUkC5JJyaZ1n6kzC/XxlTiEMDMOyINx1vSa1M4zgzWsr3CnsIPd9k?=
 =?us-ascii?Q?dO2xU7Z5UrDrnBrIvGTuxDXK/TQLxG8+qR55gxAk8oksbzWPf3gp0rpBLn7W?=
 =?us-ascii?Q?JM8fvWP/2+CKesXqSZ8cBp1kRjXZTlgfjMntPUKOFqwm9OJwh50lY6xPlKxk?=
 =?us-ascii?Q?bhUVTqiIn8RfcC2kOHqSHwuFpy/QMRI4wQ87EsoU2UK8oDijNiNqaXl5U42o?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4775f0c3-0115-47ea-0411-08dc5dcf2846
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 04:39:09.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzvdfGuaXhvneaD8FRXCF345kT/S+NMRGiAcBkIBiMWcBBLMCufNB9Q9AOM7+HYFhJfSy4snGeacY9cKS88V5LILxVYr1SQNZFeJ5dLXTgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8460
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Hi Li,
> 
> I added comments below.
> 
> On 3/13/24 03:35, Li Ming wrote:
> > PCIe RCEC core only provides pcie_walk_rcec() to walk all RCiEP devices
> > associating with RCEC, but CXL subsystem needs a helper function which
> > can walk all devices in RCEC associated bus range other than RCiEPs for
> > below RAS error case.
> > 
> > CXL r3.1 section 12.2.2 mentions that the CXL.cachemem protocol errors
> > detected by a CXL root port could be logged in RCEC AER Extended
> > Capability. The recommendation solution from CXL r3.1 section 9.18.1.5
> > is:
> > 
> > 	"Probe all CXL Downstream Ports and determine whether they have
> > 	logged an error in the CXL.io or CXL.cachemem status registers."
> > 
> > The new helper function called pcie_walk_rcec_all(), CXL RAS error
> > handler can use it to locate all CXL root ports or CXL devices in RCEC
> > associated bus range.
> 
> The RCEC-root port relation you mention is new to me. Typically, not in 
> all cases, RCH-RCD has a RCEC. And a VH mode system has a root port 
> instead. The RCH RCEC and VH root port are both bound to the PCIeport 
> bus driver that supports handling and logging AER. This allows the PCIe 
> port bus driver to handle AER in a RCEC and root port AER using the same 
> procedure and accesses to the AER capability registers. 
> 
> This is oversimplified but are you looking to handle root port AER error 
> in the RCEC from the below diagram? 
> 
> RCEC <--> CXL root port (bridge) <--> Endpoint
> 
> > 
> > Signed-off-by: Li Ming <ming4.li@intel.com>
> > ---
> >  drivers/pci/pci.h       |  6 ++++++
> >  drivers/pci/pcie/rcec.c | 44 +++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 48 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 5ecbcf041179..a068f2d7dd28 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -444,6 +444,9 @@ void pcie_link_rcec(struct pci_dev *rcec);
> >  void pcie_walk_rcec(struct pci_dev *rcec,
> >  		    int (*cb)(struct pci_dev *, void *),
> >  		    void *userdata);
> > +void pcie_walk_rcec_all(struct pci_dev *rcec,
> > +			int (*cb)(struct pci_dev *, void *),
> > +			void *userdata);
> >  #else
> >  static inline void pci_rcec_init(struct pci_dev *dev) { }
> >  static inline void pci_rcec_exit(struct pci_dev *dev) { }
> > @@ -451,6 +454,9 @@ static inline void pcie_link_rcec(struct pci_dev *rcec) { }
> >  static inline void pcie_walk_rcec(struct pci_dev *rcec,
> >  				  int (*cb)(struct pci_dev *, void *),
> >  				  void *userdata) { }
> > +static inline void pcie_walk_rcec_all(struct pci_dev *rcec,
> > +				      int (*cb)(struct pci_dev *, void *),
> > +				      void *userdata) { }
> >  #endif
> >  
> >  #ifdef CONFIG_PCI_ATS
> > diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> > index d0bcd141ac9c..189de280660c 100644
> > --- a/drivers/pci/pcie/rcec.c
> > +++ b/drivers/pci/pcie/rcec.c
> > @@ -65,6 +65,15 @@ static int walk_rcec_helper(struct pci_dev *dev, void *data)
> >  	return 0;
> >  }
> >  
> > +static int walk_rcec_all_helper(struct pci_dev *dev, void *data)
> > +{
> > +	struct walk_rcec_data *rcec_data = data;
> > +
> > +	rcec_data->user_callback(dev, rcec_data->user_data);
> > +
> > +	return 0;
> > +}
> > +
> >  static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
> >  		      void *userdata)
> >  {
> > @@ -83,7 +92,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
> >  	nextbusn = rcec->rcec_ea->nextbusn;
> >  	lastbusn = rcec->rcec_ea->lastbusn;
> >  
> > -	/* All RCiEP devices are on the same bus as the RCEC */
> > +	/* All devices are on the same bus as the RCEC */
> 
> RCiEPs are not guaranteed to be on same bus as RCEC. Details for associated 
> next and last busses:
> 
> "This register does not indicate association between an Event Collector and 
> any Function on the same Bus Number as the Event Collector itself, however 
> it is permitted for the Association Bus Range to include the Bus Number of 
> the Root Complex Event Collector."[1]
> 
> [1] PCI Spec 6.0 - RCEC Associated Bus Numbers Register 9Ofset 08h)

Hi Terry,

This patchset is responding to the implications of the implementation
note in 9.18.1.5 RCEC Downstream Port Association Structure (RDPAS).
That says that CXL.io and CXL.cachemem errors in Root Ports may indeed
be signaled to an RCEC. Do you expect that implementation note to cause
any issues on platforms that do not follow that CXL spec behavior?

My expectation is that it may just cause extra polling for errors, but
not cause any harm.

